(ns bumblebee.core
  (require bumblebee.stat  :as stat)
  (require bumblebee.table :as table)
  (require bumblebee.time  :as time))

(defn cut-off? [sum]
  (> sum (* 4 time/sec)))

(defn summarize [results]
  {:sum   (time/time->human-readable (stat/sum   results))
   :mean  (time/time->human-readable (stat/mean  results))
   :stdev (time/time->human-readable (stat/stdev results))
   :min   (time/time->human-readable (stat/min   results))
   :max   (time/time->human-readable (stat/max   results))
   :count (count results)})

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

(defn display-results [& benches]
  (println (table/create [:name :count :sum :mean :stdev :min :max] benches)))
