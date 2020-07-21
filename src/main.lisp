(in-package :weather)

(unix-opts:define-opts
  (:name :help
   :description "Print this help text"
   :short #\h
   :long "help"))

(defun main ()
  (multiple-value-bind (options free-args)
      (unix-opts:get-opts)
    (if (or (getf options :help) (/= (length free-args) 1))
        (unix-opts:describe
         :prefix "Get the temperature in a given city."
         :args "cityname")
        (let ((arg-as-keyword (intern (string-upcase (first free-args)) :keyword)))
          (unless (eq arg-as-keyword :nil)
            (format t "~a~%" (get-temperature arg-as-keyword))))))
  (uiop:quit))
