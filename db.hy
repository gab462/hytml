(require hyrule [defmain some-> -> ->> let+ loop] :readers [%])

(import pypika [Query :as query
                Column :as column
                Table :as table
                Parameter :as param]
        hyrule [flatten rest]
        util [first second drop]
        functools [reduce]
        sqlite3)

(defn execute [sql #* args]
  (some-> (with [db (sqlite3.connect "contacts.db")]
             (setv db.row-factory sqlite3.Row)
             (db.execute (.get-sql sql) #* args))
           .fetchall
           (#%(map dict %1))
           list))

(defn execute-one [sql #* args]
  (some-> (with [db (sqlite3.connect "contacts.db")]
            (setv db.row-factory sqlite3.Row)
            (db.execute (.get-sql sql) #* args))
          .fetchone
          dict))

(defn all-tables []
  (let [t (table "sqlite_master")]
    (-> query
        (.from- t)
        (.where (= t.type "table"))
        (.select "*")
        execute)))

(defn create-contacts-table []
  (-> query
      (.create-table "contact")
      (.columns (column "name" "TEXT" :nullable False)
                (column "email" "TEXT" :nullable False)
                (column "status" "TEXT" :nullable False))
      execute))

(defn insert-contact [name email status]
  (-> query
      (.into "contact")
      (.insert (param "?") (param "?") (param "?"))
      ; (.returning "id")
      (execute-one [name email status])))

(defn get-contact [row-id]
  (let [t (table "contact")]
    (-> query
        (.from- t)
        (.select t.rowid t.name t.email t.status)
        (.where (= t.rowid row-id))
        execute-one)))

(defn update-contact [row-id #** kwargs]
  (let+ [cols (list (.keys kwargs))
         vals (list (.values kwargs))
         t (table "contact")]
    (-> query
        (.update t)
        (#%(reduce (fn [q c] (.set q c (param "?"))) cols %1))
        (.where (= t.rowid row-id))
        (execute vals))))

(defn delete-contact [row-id]
  (let [t (table "contact")]
    (-> query
        (.from- t)
        (.where (= t.rowid row-id))
        .delete
        execute)))

(defn get-all-contacts []
  (-> query
      (.from- "contact")
      (.select "rowid" "name" "email" "status")
      execute))
