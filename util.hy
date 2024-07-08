(require hyrule [->> fn+ defmacro-kwargs])

(defreader m
  (assert (= (.getc &reader) "{"))
  `{~@(->> (.parse-forms-until &reader "}")
           (map (fn [a]
                  (if (= (type a) hy.models.Keyword)
                    (getattr a "name")
                    a))))})

(defn drop [n xs]
  (cut xs n None))

(defn first [xs]
  (get xs 0))

(defn second [xs]
  (get xs 1))
