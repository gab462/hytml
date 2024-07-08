(require hyrule [defmain])

(import flask [Flask]
        handlers :as handle
        pages :as page
        db)

(setv app (Flask __name__))

(defn [(app.route "/")] index []
  (page.render-page "Delete Row" (page.contacts-table (db.get-all-contacts))))

(defn [(app.route "/contact/<int:id>" :methods ["DELETE"])] contact [id]
  (page.render-element (handle.delete-row id)))

(defmain [#* args]
  (.run app))
