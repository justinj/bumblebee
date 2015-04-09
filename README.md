Bumblebee
=========

Low-effort benchmarking for Pixie:

```clojure
(defn sum [values]
  (reduce + 0 values))

(defn product [values]
  (reduce * 1 values))

(bumblebee/run {}
  (bumblebee/bench sum-bench
    (sum (range 50000)))
  (bumblebee/bench product-bench
    (product (range 50000))))

; ┌───────────────┬───────┬──────┬─────────┬───────┬─────────┬─────────┐
; │          name │ count │  sum │    mean │ stdev │     min │     max │
; ├───────────────┼───────┼──────┼─────────┼───────┼─────────┼─────────┤
; │     sum-bench │    16 │ 2.0s │ 128.0ms │ 2.5ms │ 124.9ms │ 134.4ms │
; │ product-bench │    16 │ 2.0s │ 129.5ms │ 3.0ms │ 126.1ms │ 135.7ms │
; └───────────────┴───────┴──────┴─────────┴───────┴─────────┴─────────┘
```

Current Problems
================

* It should probably run the code a couple times before timing to allow the JIT to get its pants on
* Currently it runs the code until 4 seconds has passed, this should probably be configurable
