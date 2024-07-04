(require hyrule [defmain]
         util :readers [m])

(import hytml [html])

(defmain [#* args]
  (print (html #m{:title "Home"
                  :head [[:link #m{:href "style.css"
                                   :rel "stylesheet"}]
                         [:script #m{:src "script.js"
                                     :type "text/javascript"}]]
                  :body [[:div #m{:id "app"}
                          [:h1 "App"]
                          [:hr]]
                         [:p #m{:class "under"} "Footer"]]})))
