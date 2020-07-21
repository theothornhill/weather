(ql:quickload :weather-bin)

(sb-ext:save-lisp-and-die
 "weather"
 :toplevel 'weather:main
 :executable t)
