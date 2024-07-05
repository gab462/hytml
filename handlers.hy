(require hyrule [->>]
         util [assoc!])

(import util [remove]
        state [state]
        pages :as page)

(defn delete-row [id]
  (->> state
       :contacts
       (remove id)
       (assoc! state :contacts)
       :contacts
       page.contacts-table))
