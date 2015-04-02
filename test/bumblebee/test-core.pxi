(ns bumblebee.test.core
  (require bumblebee.core :as bumblebee))

(defn sum [values]
  (reduce + 0 values))

(bumblebee/display-results
  (bumblebee/defbench sum-bench
    (sum (range 50000)))
