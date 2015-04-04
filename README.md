Bumblebee
=========

Low-effort benchmarking for Pixie:

```clojure
(defn sum [values]
  (reduce + 0 values))

(defn product [values]
  (reduce * 1 values))

(bumblebee/display-results
  (bumblebee/bench sum-bench
    (sum (range 50000)))
  (bumblebee/bench product-bench
    (product (range 50000))))

; ┌───────────────┬───────┬──────┬─────────┬───────┬─────────┬─────────┐
; │          name │ count │  sum │    mean │ stdev │     min │     max │
; ├───────────────┼───────┼──────┼─────────┼───────┼─────────┼─────────┤
; │     sum-bench │    31 │ 4.1s │ 132.6ms │ 6.7ms │ 125.0ms │ 148.3ms │
; ├───────────────┼───────┼──────┼─────────┼───────┼─────────┼─────────┤
; │ product-bench │    31 │ 4.0s │ 131.3ms │ 5.5ms │ 125.9ms │ 151.5ms │
; └───────────────┴───────┴──────┴─────────┴───────┴─────────┴─────────┘
```

Current Problems
================

* It should probably run the code a couple times before timing to allow the JIT to get its pants on
* Currently it runs the code until 4 seconds has passed, this should probably be configurable
