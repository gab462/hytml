(require hyrule [defmain])

(import flask [Flask]
        state [state]
        handlers :as handle
        pages :as page)

(setv app (Flask __name__))

(defn [(app.route "/")] index []
  (page.render-page "Delete Row" (page.contacts-table (:contacts state))))

(defn [(app.route "/contact/<int:id>" :methods ["DELETE"])] contact [id]
  (page.render-element (handle.delete-row id)))

(defmain [#* args]
  (.run app))
