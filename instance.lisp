;;; -*- Mode:Lisp; Syntax:Common-lisp; Package:NAMEMYBABY; Base:10 -*-

(in-package :namemybaby)

(defun harvest-instances ()
  (dolist (tuple (dbl :namemybaby "select name from name"))
    (let* ((name (car tuple))
	   (instances (apropos-list (format nil "~A " name) :i2@)))
      (loop for i in instances
	  when (sensor::sensor-ask `(sensor::superclass ,i o2@::|HUMAN|))
	  do (dbl :namemybaby
		  "insert into instances (name, instance, headword, nounphrase,
  fullnounphrase, omegaconcepts) values ('~A','~A','~A','~A','~A','~A')"
		  name
		  (sqlutil:write-sql-string (symbol-name i) nil)
		  (canon-atom (get i 'sensor::head-word))
		  (canon-atom (get i 'sensor::noun-phrase))
		  (canon-atom (get i 'sensor::full-noun-phrase))
		  (format nil "~{~A~^&&~}"
			  (mapcar #'(lambda (s)
				      (sqlutil:write-sql-string
				       (symbol-name s)
				       nil))
				  (canon-list
				   (sensor-concept-parents i)))))))))
