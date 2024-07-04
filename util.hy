(require hyrule [->> fn+])

(import types [MappingProxyType]
        itertools [islice accumulate repeat])

(defreader m
  (assert (= (.getc &reader) "{"))
  (let [args (.parse-forms-until &reader "}")]
    `(hy.I.types.MappingProxyType (dict ~@args))))

(defn assoc [m #** kwargs]
  (MappingProxyType (| m kwargs)))

(defn update [m #** kwargs]
  (let [args (->> kwargs
                  .items
                  (map (fn+ [[k f]] #(k (f (get m k)))))
                  dict)]
    (MappingProxyType (| m args))))

(defn take [n it]
  (islice it n))

(defn drop [n it]
  (islice it n None))

(defn first [xs]
  (get xs 0))

(defn second [xs]
  (get xs 1))

(defn iterate [f x]
  (accumulate (repeat x) (fn [fx _] (f fx))))
