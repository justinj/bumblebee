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
; │     sum-bench │    16 │ 2.0s │ 128.0ms │ 2.5ms │ 124.9ms │ 134.4ms │
; │ product-bench │    16 │ 2.0s │ 129.5ms │ 3.0ms │ 126.1ms │ 135.7ms │
; └───────────────┴───────┴──────┴─────────┴───────┴─────────┴─────────┘
