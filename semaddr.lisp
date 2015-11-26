;;; -*- Mode:Lisp; Syntax:Common-lisp; Package:NAMEMYBABY; Base:10 -*-

(in-package :namemybaby)

(eval-when (compile load eval)
  (require :sensor-three)
  (use-package :sensor-three))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.onto.sensor.sensor-distance)
  (use-package :edu.isi.isd.nlp.appl.onto.sensor.sensor-distance))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.onto.sensor.sensor-root)
  (use-package :edu.isi.isd.nlp.appl.onto.sensor.sensor-root))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.adt.file.withfile)
  (use-package :edu.isi.isd.nlp.adt.file.withfile))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.adt.file.csv.philpot)
  (use-package :edu.isi.isd.nlp.adt.file.csv.philpot))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.algo.sort.alpha-lessp)
  (use-package :edu.isi.isd.nlp.algo.sort.alpha-lessp))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.db.dbaodbc)
  (use-package :edu.isi.isd.nlp.appl.db.dbaodbc))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.db.dbl)
  (use-package :edu.isi.isd.nlp.appl.db.dbl))

(defun write-addresses (vocab)
  (let ((roots (find-roots vocab)))
    (setq roots (sort roots #'alpha-lessp))
    (assign-addresses :vocab vocab :root-or-roots roots)
    (with-output-file (s "/tmp/addr.csv")
      (map-vocab-concepts
       #'(lambda (c)
	   (dolist (a (get c 'sensor-distance::addresses))
	     (write-csv-file-line 
	      s (list c (with-output-to-string (w)
			  (let ((start t))
			    (loop for n across a
				unless start 
				do (write-char #\space w)
				do (princ n w)
				do (setq start nil))))))))
       vocab))))

#+ignore
(defun db (fmt &rest args)
  (fetch ;; "babynames3"
   (if (equal (machine-instance) "#x98027d8")
       "namemybaby3"
     "namemybaby")
   (apply #'format nil fmt args) 
   :user "philpot"
   :password "janndrew"
   :verbose nil))

(defun db (fmt &rest args)
  (edu.isi.isd.nlp.appl.db.dbl::dbl
   ;; "babynames3"
   ;; edited 6 December 04
   #+remove
   (if (equal (machine-instance) "#x98027d8")
       "namemybaby3"
     "namemybaby")
   :namemybaby
   (apply #'format nil fmt args) 
   :user "philpot"
   :password "janndrew"
   :verbose nil))
	 
(defun addr-word-dist (n1 n2)
  (loop for a1 in (db "select a.addr from semaddr a, sem s where
  s.sem=a.sem and s.name='~A'" n1)
      as v1 = (read-from-string (format nil "#~A" a1))
      minimize (loop for a2 in (db "select a.addr from semaddr a, sem s where
  s.sem=a.sem and s.name='~A'" n2)
		   as v2 = (read-from-string (format nil "#~A" a2))
		   minimize (addr-vector-difference v1 v2))))

(defun sem-dist (s1 s2 &optional (cross-tree-penalty 2))
  (let ((l1 (db "select distinct addr from semaddr where sem = '~A'" s1))
	(l2 (db "select distinct addr from semaddr where sem = '~A'" s2)))
    (loop for a1 in l1
	as v1 = (read-from-string (format nil "#~A" a1))
	minimize (loop for a2 in l2
		     as v2 = (read-from-string (format nil "#~A" a2))
		     minimize (addr-vector-difference v1 v2
						      :cross-tree-penalty cross-tree-penalty)))))

(defun addr-word-path (n1 n2)
  (let ((min most-positive-fixnum)
	(b1 nil)
	(b2 nil))
    (loop for a1 in (db "select a.addr from semaddr a, sem s where
  s.sem=a.sem and s.name='~A'" n1)
	as v1 = (read-from-string (format nil "#~A" a1))
	do (loop for a2 in (db "select a.addr from semaddr a, sem s where
  s.sem=a.sem and s.name='~A'" n2)
	       as v2 = (read-from-string (format nil "#~A" a2))
	       as diff = (addr-vector-difference v1 v2
						 :cross-tree-penalty 2)
	       when (< diff min)
	       do (setq min diff
			b1 v1
			b2 v2)))

    
    (flet ((show (a)
	     (let ((sem (db "select sem from semaddr where addr = '~A'"
			    (format nil "~{~A~^ ~}"
				    (coerce a 'list)))))
	       (format t "~%~A = ~A" a (car sem)))))

    (let ((m (mismatch b1 b2 :test #'=)))
      (show b1) (princ n1)
      (loop for j1 from (length b1) downto m 
	  do (show (subseq b1 0 j1)))
      (loop for j2 from (1+ m) below (length b2)
	  do (show (subseq b2 0 j2)))
      (show b2) (princ n2)
      )
    (values min b1 b2))))
