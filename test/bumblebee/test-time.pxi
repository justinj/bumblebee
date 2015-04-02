(ns bumblebee.test.core
  (require pixie.test     :as t)
  (require bumblebee.time :as time))

(t/deftest formatting-times
  (let [cases [["1.0s"     1000000]
               ["10.0s"   10000000]
               ["500.0ms"   500000]
               ["500.0us"      500]]]
  (doseq [[expected value] cases]
    (t/assert= expected (time/time->human-readable value)))))
          
