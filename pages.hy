(require hyrule [fn+ ->]
         util :readers [m])

(import hytml [html html-element])

(defn render-page [title page]
  (-> #m{:title title
         :head [[:link #m{:href "https://cdn.jsdelivr.net/npm/@picocss/pico@2.0.6/css/pico.classless.min.css"
                          :rel "stylesheet"}]]
         :body [[:script #m{:src "https://unpkg.com/htmx.org@2.0.0"
                            :type "text/javascript"}]
                page]}
      html
      .render))

(defn render-element [element]
  (-> element html-element .render))

(defn contacts-table [contacts]
  [:form
   [:table
    [:thead
     [:th "Name"]
     [:th "Email"]
     [:th "Status"]
     [:th]]
    [:tbody #m{:hx-confirm "Are you sure?" :hx-target "closest tr" :hx-swap "outerHTML"}
     #* (map (fn+ [[id {:strs [name email status]}]]
                  [:tr
                   [:td name]
                   [:td email]
                   [:td status]
                   [:td
                    [:button #m{:hx-delete f"/contact/{id}"}
                     "Delete"]]])
             (enumerate contacts))]]])
