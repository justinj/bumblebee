; not really a legit test, just eyeball this guy
(ns bumblebee.test.core
  (require bumblebee.core :as bumblebee))

(defn sum [values]
  (reduce + 0 values))

(defn product [values]
  (reduce * 1 values))

(bumblebee/run
  {:time-per-bench 2
   :enabled true}
  (bumblebee/defbench sum-bench
    (sum (range 50000)))
  (bumblebee/defbench product-bench
    (product (range 50000))))

; ┌───────────────┬───────┬──────┬─────────┬───────┬─────────┬─────────┐
; │          name │ count │  sum │    mean │ stdev │     min │     max │
; ├───────────────┼───────┼──────┼─────────┼───────┼─────────┼─────────┤
; │     sum-bench │    31 │ 4.1s │ 132.6ms │ 6.7ms │ 125.0ms │ 148.3ms │
; ├───────────────┼───────┼──────┼─────────┼───────┼─────────┼─────────┤
; │ product-bench │    31 │ 4.0s │ 131.3ms │ 5.5ms │ 125.9ms │ 151.5ms │
; └───────────────┴───────┴──────┴─────────┴───────┴─────────┴─────────┘
