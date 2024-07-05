(require hyrule [->> fn+ defmacro-kwargs])

(defreader m
  (assert (= (.getc &reader) "{"))
  `{~@(->> (.parse-forms-until &reader "}")
           (map (fn [a]
                  (if (= (type a) hy.models.Keyword)
                    (getattr a "name")
                    a))))})

(defn assoc [m #** kwargs]
  (| m kwargs))

(defn update [m #** kwargs]
  (let [args (->> kwargs
                  .items
                  (map (fn+ [[k f]] #(k (f (get m k)))))
                  dict)]
    (| m args)))

(defmacro-kwargs assoc! [m #** kwargs]
  `(do
     ~@(map (fn+ [[k v]] `(setv (get ~m ~k) ~v)) (.items kwargs))
     ~m))

(defn drop [n xs]
  (cut xs n None))

(defn take [n xs]
  (cut xs None n))

(defn first [xs]
  (get xs 0))

(defn second [xs]
  (get xs 1))

(defn remove [n xs]
  (+ (take n xs) (drop (+ n 1) xs)))
