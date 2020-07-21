
(in-package :weather)

(defun parse-float (number-string)
  (with-input-from-string (in number-string)
    (read in)))

(defun parse-line (line)
  (let* ((split (cl-ppcre:split "," (cl-ppcre:regex-replace-all "\"" line "")))
         (city (intern (string-upcase (second split)) :keyword))
         (latitude (parse-float (third split)))
         (longitude (parse-float (fourth split))))
    (list city (cons latitude longitude))))

(defun read-cities ()
  (with-open-file (file "./worldcities.csv")
    (read-line file)
    (loop for line = (read-line file nil nil)
          while line
          collect (parse-line line ))))

(defun find-city-lat-long (target)
  (let ((city (find-if (lambda (city)
                         (eq (car city) target))
                       (read-cities))))
    (getf city target)))

(defun decode-properties (data)
  (cdr (assoc :properties data)))

(defun decode-timeseries (data)
  (cdr (second (assoc :timeseries data))))

(defun decode-air-temperature (data)
  (cdr (third (second (second (assoc :data data))))))

(defun get-temperature (city)
  (let ((town (find-city-lat-long city)))
    (if town
        (with-input-from-string
            (s (flexi-streams:octets-to-string
                (drakma:http-request
                 (concatenate
                  'string
                  "https://api.met.no/weatherapi/locationforecast/2.0/compact?"
                  (format nil "lat=~a" (car town))
                  (format nil "&lon=~a" (cdr town))))))
          (let* ((data (json:decode-json s))
                 (properties (decode-properties data))
                 (timeseries (decode-timeseries properties))
                 (air-temperature (decode-air-temperature timeseries)))
            air-temperature))
        (warn "Cannot find this city. Try another city."))))

