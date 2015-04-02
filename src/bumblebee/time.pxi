(ns bumblebee.time
  (require pixie.ffi-infer :as f))

(f/with-config {:library "c"
                :includes ["sys/time.h"]}
  (f/defc-raw-struct timeval [:tv_sec
                              :tv_usec])
  (f/defcfn gettimeofday))

(def micro       1.0)
(def milli    1000.0)
(def sec   1000000.0)

(defn now []
  (let [t (timeval)]
    (gettimeofday t (buffer 0))
    (+ (* sec (:tv_sec t))
       (:tv_usec t))))

(defn- round-to-one-place [n]
  (str (int n)
       "."
       (-> n (* 10) int (rem 10) int)))

(defn time->human-readable [t]
  (let [[number suffix]
        (cond (>= t sec)   [(/ t sec)    "s"]
              (>= t milli) [(/ t milli) "ms"]
              :else        [(/ t micro) "us"])]
  (str (round-to-one-place number) suffix)))
