(require hyrule [let+])

(import util [drop first second]
        dominate
        dominate.tags)

(defn html-tag [tag [attrs None] #* content]
  (let [tag-fn (getattr dominate.tags (getattr tag "name"))]
    (if (or (= (len content) 0)
            (and (= (len content) 1) (= (type (first content)) str)))
      (tag-fn #* content #** attrs)
      (with [e (tag-fn #** attrs)]
        (for [element content] (html-element element))
        e))))

(defn html-element [element]
  (if (and (> (len element) 1) 
           (= (type (second element)) dict))
    (html-tag #* element)
    (html-tag (first element) {} #* (drop 1 element))))

(defn html [tree]
  (let+ [{:strs [title head body]} tree]
    (let [doc (dominate.document :title title)]
      (with [doc.head]
        (for [element head] (html-element element)))
      (with [doc]
        (for [element body] (html-element element)))
      doc)))
