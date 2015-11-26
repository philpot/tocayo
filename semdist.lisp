;;; -*- Mode:Lisp; Syntax:Common-lisp; Package:LUX; Base:10 -*-

(in-package :namemybaby)

(eval-when (compile load eval)
  (require :sensor-three)
  (use-package :sensor-three))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.algo.search.apsp)
  (use-package :edu.isi.isd.nlp.algo.search.apsp))

(defun compute-distances (vocab)
  (let ((sems (list)))
    (map-vocab-concepts #'(lambda (c)
			    (push c sems))
			vocab)
    (let ((a (make-apsp sems
			#'(lambda (x y)
			    (if (or (member x (sensor-concept-parents y))
				    (member y (sensor-concept-parents x)))
				1.0d0
			      nil)))))
      (setup-apsp a nil)
      a)))

(defun word-dist (w1 w2 apsp)
  (loop for c1 in (sensor::sensor-word-concept-name w1)
      minimize 
	(loop for s1 in (sensor-concept-relations c1 'sensor::semantics)
	    minimize
	      (loop for c2 in (sensor::sensor-word-concept-name w2)
		  minimize
		    (loop for s2 in (sensor-concept-relations c2 'sensor::semantics)
			minimize (reap-apsp apsp s1 s2))))))

(defun word-path (w1 w2 apsp)
  (let ((minimum most-positive-double-float)
	(sem1 nil)
	(sem2 nil)
	(path nil))
    (loop for c1 in (sensor::sensor-word-concept-name w1)
	do (loop for s1 in (sensor-concept-relations c1 'sensor::semantics)
	       do (loop for c2 in (sensor::sensor-word-concept-name w2)
		      do (loop for s2 in (sensor-concept-relations c2 'sensor::semantics)
			     do (multiple-value-bind (r p)
				    (reap-apsp apsp s1 s2
					       :return-path-p t)
				  (when (< r minimum)
				    (setq minimum r
					  path p)))))))
    (values minimum path)))
