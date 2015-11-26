;;; -*- Mode:Lisp; Syntax:Common-lisp; Package:LUX; Base:10 -*-

(in-package :namemybaby)

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.adt.list.coalesce)
  (use-package :edu.isi.isd.nlp.adt.list.coalesce))

(eval-when (compile load eval)
  (require :sensor-three)
  (use-package :sensor-three)
  (provide :sensor))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.onto.sensor.sensor-penumbra)
  (use-package :edu.isi.isd.nlp.appl.onto.sensor.sensor-penumbra))

(defun root-concepts (c)
  (let ((roots (list)))
    (labels ((rec (x)
	       (let ((parents (remove x (sensor-concept-parents x))))
		 (if parents
		     (mapc #'rec parents)
		   (pushnew x roots)))))
      (rec c))
    roots))

(defun count-classes2 ()
  (ovocab:ensure-vocab :s)
  (ovocab:load-into-vocab :s "LUX:data;sem.lisp"
			  :expander :univ
			  :discard-definitions nil)
  (let ((pkg (find-package :s@))
	(roots (list)))
    (do-symbols (s pkg)
      (when (eql pkg (symbol-package s))
	(dolist (root (root-concepts s))
	  (pushnew root roots))))
    roots))


(defun count-classes ()
  (ovocab:load-into-vocab :s "LUX:data;sem.lisp"
			  :expander :univ
			  :discard-definitions nil)
  (let ((pkg (find-package :s@))
	(pairs (list)))
    (do-symbols (s pkg)
      (when (eql pkg (symbol-package s))
	(dolist (child (remove s (sensor-concept-children s)))
	  (pushnew (cons s child) pairs
		   :test #'equal))))
    (let ((equiv (coalesce pairs)))
      (values (length equiv)
	      ;; equiv
	      pairs))))

(defun grow (c &key (verbose t))
  (let ((universe (list)))
    (labels ((rec (x)
	       (if (member x universe)
		   ()
		 (progn
		   (when verbose
		     (print x))
		   (push x universe)
		   (mapc #'rec (remove x (sensor-concept-children x)))
		   (mapc #'rec (remove x (sensor-concept-parents x)))))))
      (rec c))
    universe))
