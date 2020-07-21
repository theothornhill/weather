
(asdf:defsystem :weather
  :description "Small weather fetching utility"
  :author "Theodor Thornhill <theo@thornhill.no>"
  :license "MIT"
  :version "0.0.1"
  :depends-on (:flexi-streams
               :cl-json
               :drakma
               :cl-ppcre
               :unix-opts)
  :components ((:module "src"
                :components ((:file "package")
                             (:file "weather")))))


