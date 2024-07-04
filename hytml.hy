(require hyrule [let+]
         util :readers [m])

(import util [drop first second]
        dominate
        dominate.tags)

(defn html-tag [tag [attrs None] #* content]
  (let [make-tag (fn [k] (getattr dominate.tags (getattr k "name")))]
    (if (or (= (len content) 0)
            (and (= (len content) 1) (= (type (first content)) str)))
      ((make-tag tag) #* content #** attrs)
      (with [((make-tag tag) #** attrs)]
        (for [element content] (html-element element))))))

(defn html-element [element]
  (if (and (> (len element) 1) 
           (= (type (second element)) hy.I.types.MappingProxyType))
    (html-tag #* element)
    (html-tag (first element) #m{} #* (drop 1 element))))

(defn html [tree]
  (let+ [{:strs [title head body]} tree]
    (let [doc (dominate.document :title title)]
      (with [doc.head]
        (for [element head] (html-element element)))
      (with [doc]
        (for [element body] (html-element element)))
      doc)))
