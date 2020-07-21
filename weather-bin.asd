
(asdf:defsystem :weather-bin
  :description "Small weather fetching utility"
  :author "Theodor Thornhill <theo@thornhill.no>"
  :license "MIT"
  :version "0.0.1"
  :depends-on (:weather)
  :components ((:module "src"
                :components ((:file "main")))))
