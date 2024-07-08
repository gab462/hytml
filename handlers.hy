(require hyrule [->>])

(import db [delete-contact get-all-contacts]
        pages :as page)

(defn delete-row [id]
  (let [_ (delete-contact id)
        contacts (get-all-contacts)]
    (page.contacts-table contacts)))
