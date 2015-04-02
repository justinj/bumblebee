; not really a legit test, just eyeball this guy
(ns bumblebee.core
  (require sparkles.core  :as sparkles)
  (require bumblebee.stat :as stat)
  (require bumblebee.time :as time))

(defn cut-off? [sum]
  (> sum (* 4 time/sec)))

(defn summarize [results]
  {:sum   (stat/sum   results)
   :mean  (stat/mean  results)
   :stdev (stat/stdev results)
   :min   (stat/min   results)
   :max   (stat/max   results)})

(defn make-timer [exprs]
  `(fn [] (let [start-time# (time/now)
               _ (do ~@exprs)
               end-time# (time/now)]
           (- end-time# start-time#))))

(defmacro defbench [nm & exprs]
  `(let [run-iteration# ~(make-timer exprs)]
     (assoc
       (summarize
         (loop [sum# 0
                results# []]
           (if (cut-off? sum#)
             results#
             (let [diff# (run-iteration#)]
               (recur (+ sum# diff#)
                      (conj results# diff#))))))
       :name ~(name nm))))
