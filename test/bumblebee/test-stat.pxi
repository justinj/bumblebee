(ns bumblebee.test.stat
  (require bumblebee.stat :as stat)
  (require pixie.test :as t))

(t/deftest sum
  (t/assert= (stat/sum [1 2 3]) 6))

(t/deftest mean
  (t/assert= (stat/mean [1 2 3]) 2)
  (t/assert= (stat/mean [1 2]) 1.5))

(t/deftest stdev
  (t/assert= (stat/stdev [2 4 4 4 5 5 7 9]) 2))
