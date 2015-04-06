(ns bumblebee.table
  (require bumblebee.stat :as stat))

(def horizontal-bar
  ^{:private true}
  "─")
(def vertical-bar
  ^{:private true}
  "│")

(def left-corner
  ^{:private true}
  {:top    "┌"
   :inner  "├"
   :bottom "└"})

(def inner-corner
  ^{:private true}
  {:top    "┬"
   :inner  "┼"
   :bottom "┴"})

(def right-corner
  ^{:private true}
  {:top    "┐"
   :inner  "┤"
   :bottom "┘"})

(defn- display [s]
  (str " " s " "))

(defn- column-width [xs]
  (stat/max (map (comp count display) xs)))

(defn- header-entry [header]
  (reduce #(assoc %1 %2 (name %2)) {} header))

(defn- make-divider [widths vertical-location]
  (let [stretches (map #(apply str (repeat % horizontal-bar)) widths)]
    (str (vertical-location left-corner)
         (apply str (interpose (vertical-location inner-corner) stretches))
         (vertical-location right-corner))))

(defn- pad [s width]
  (let [padding-needed (- width (count s))
        padding (apply str (repeat padding-needed " "))]
    (str padding s)))

(defn- row-str [row widths header]
  (let [padded (map #(pad (display (%1 row)) %2) header widths)]
  (str vertical-bar (apply str (interpose vertical-bar padded)) vertical-bar
       \newline)))

(defn create [header rows]
  {:doc "Create a prettily formatted table with a header and a number of rows.
        header should be a seq of named things which are invokable on the rows
        to get the value for a particular column.
        The most obvious use of this is to have header be a vector of keywords
        and have rows be a seq of maps from keywords to values."}
  (let [columns (map #(concat [(name %)] (map % rows)) header)
        widths (map column-width columns)
        rows (concat [(header-entry header)] rows)]
    (str
      (make-divider widths :top)
      (apply str \newline
             (interpose (str (make-divider widths :inner) \newline)
                        (map #(row-str % widths header) rows)))
      (make-divider widths :bottom))))
