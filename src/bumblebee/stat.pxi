(ns bumblebee.stat
  (require pixie.math :as math))

(defn most [cmp xs]
  (if (zero? (count xs))
    (throw "min needs at least one value")
    (reduce #(if (cmp %1 %2) %1 %2) (first xs) (rest xs))))

(defn min [xs]
  (most < xs))

(defn max [xs]
  (most > xs))

(defn sum [xs]
  (reduce + 0 xs))

(defn mean [xs]
  (/ (sum xs)
     (float (count xs))))

(defn stdev [xs]
  (let [mn (mean xs)]
    (math/sqrt
      (mean (map (fn [x]
                   (let [diff (- x mn)]
                     (* diff diff)))
                 xs)))))
