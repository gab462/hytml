(require util :readers [m])

(setv state #m{:contacts [#m{:name "Joe Smith"
                             :email "joe@smith.org"
                             :status "Active"}
                          #m{:name "Angie MacDowell"
                             :email "angie@macdowell.org"
                             :status "Active"}
                          #m{:name "Fuqua Tarkenton"
                             :email "fuqua@tarkenton.org"
                             :status "Active"}
                          #m{:name "Kim Yee"
                             :email "kim@yee.org"
                             :status "Inactive"}]})
