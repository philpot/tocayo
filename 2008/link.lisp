;;; -*- Mode:Lisp; Syntax:Common-lisp; Coding:utf-8; Package:NAMEMYBABY; Base:10 -*-

(in-package :namemybaby)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :edu.isi.isd.nlp.adt.readtable.readtableutil)
  (use-package :edu.isi.isd.nlp.adt.readtable.readtableutil)

  (require :work.alphaprefix-reader)
  (use-package :work.alphaprefix-reader)
  
  (require :edu.isi.isd.nlp.adt.vector.bijection)
  (use-package :edu.isi.isd.nlp.adt.vector.bijection))

(defmacro deflink (rel a1 a2)
  `(express-link ,rel ,a1 ,a2))

(eval-when (:load-toplevel :execute)
  (define-readtable :link (copy-readtable nil)))

(eval-when (:load-toplevel :execute)
  (defmethod reify-token 
      ((char (eql #\!)) (subchar (eql #\:)) (prefix t) (count t) (string string))
    (vector char subchar prefix count string))
  (set-macro-character #\! 'read-entity nil (find-readtable :link)))

#+old
(defclass layer ()
  ((package :accessor layer-package
	    :initarg :package)
   (index :accessor layer-index
	  :initform (let ((vect (make-array 100 :adjustable t 
					    :fill-pointer 1)))
		      (setf (aref vect 0) :layer)
		      vect))))

(defclass layer (autolinear-bijection)
  ((name :accessor layer-name
	 :initarg :name)))

(defmethod enroll-layer ((layer layer) (name t))
  (setf (gethash name *layers*) layer))

(defmethod shared-initialize :after 
	   ((instance layer) slot-names &rest initargs)
  (declare (ignore slot-names))
  (enroll-layer instance (layer-name instance))
  )

(defmethod edu.isi.isd.nlp.adt.vector.bijection::print-object-contents
    ((layer layer) stream)
  (write (layer-name layer) :stream stream)
  (write-char #\space stream)
  (call-next-method))

(defvar *layers* (make-hash-table :test #'equal))

(defun make-layer (name &key (offset 0))
  (setf (gethash name *layers*)
    (make-bijection :class 'layer
		    :origin (+ offset 1)
		    :name name)))

(defun find-layer (name &rest args)
  (declare (ignore args))
  (values (gethash name *layers*)))

(defun insist-layer (name &rest args)
  (or (apply #'find-layer name args)
      (error "No such layer ~S" name)))

(defun ensure-layer (name &rest args)
  (unless (apply #'find-layer name args)
    (apply #'make-layer name args)))

(defmacro define-layer (name &rest args)
  `(ensure-layer ',name ,@args))

(defun canon-layer (layer-or-name)
  (if (typep layer-or-name 'layer)
      layer-or-name
    (insist-layer layer-or-name)))

(defun make-entity (string layer)
  (insert layer :left string)
  (lget string layer))

(defun find-entity (string layer)
  (lget string layer))

(defun insist-entity (string layer)
  (unless (lget string layer)
    (error "No such entity ~S" string)))

(defun ensure-entity (string layer)
  (or (find-entity string layer)
      (make-entity string layer)))

(defun lookup-entity (number layer)
  (rget number (canon-layer layer)))

(eval-when (:load-toplevel :execute)
  ;; tokens
  (define-layer :token :offset 100000)
  ;; names
  (define-layer :name :offset 200000)
  ;; languages
  (define-layer :language :offset 100))

(eval-when (:compile-toplevel :load-toplevel :execute)
  (defun read-entity (stream char)
    (read-alphaprefix stream char 
		      :macro-char #\! 
		      :macro-subchar #\:)))
  

(eval-when (:load-toplevel :execute)
  (defmethod reify-token 
      ((char (eql #\!)) (subchar (eql #\:)) 
       (prefix (eql #\T))
       (count t)
       (string string))
    (ensure-entity string (insist-layer :token)))
  (defmethod reify-token 
      ((char (eql #\!)) (subchar (eql #\:)) 
       (prefix (eql #\N))
       (count t)
       (string string))
    (ensure-entity string (insist-layer :name)))
  (defmethod reify-token 
      ((char (eql #\!)) (subchar (eql #\:)) 
       (prefix (eql #\L))
       (count t)
       (string string))
    (ensure-entity string (insist-layer :language)))
  (set-macro-character #\! 'read-entity 
		       nil (find-readtable :link)))

(defvar *relation-caches* (make-hash-table :test #'eql))

(defun relation-cache (symbol)
  (or (gethash symbol *relation-caches*)
      (error "~S doesn't name a relation" symbol)))

(defvar *relation-info* (make-hash-table :test #'eql))

(defclass relation-info ()
  ((name :accessor name
	 :initarg :name)
   (inverse :accessor inverse
	    :initarg :inverse
	    :initform nil)))

(defun make-relation-info (&key name inverse)
  (assert name)
  (make-instance 'relation-info
    :name name
    :inverse inverse))

(defmacro define-relation (relation &key inverse)
  `(progn
     (unless (gethash ',relation *relation-caches*)
       (setf (gethash ',relation *relation-caches*)
	 (make-hash-table :test #'equal)))
     (setf (gethash ',relation *relation-info*)
       (make-relation-info :name ',relation 
			   :inverse ',inverse))
     (when ',inverse
       (setf (gethash ',inverse *relation-info*)
	 (make-relation-info :name ',inverse 
			     :inverse ',relation)))
     ',relation))

(defmethod inverse ((relation symbol))
  (let ((info (gethash relation *relation-info*)))
    (and info
	 (inverse info))))

(defun express-link (rel a1 &rest other-args)
  (dolist (a2 other-args)
    (pushnew a2 (gethash a1 (relation-cache rel))))
  (when (= (length other-args) 1)
    (let ((a2 (car other-args)))
      (let ((inv (inverse rel)))
	(when inv
	  (pushnew a1 (gethash a2 (relation-cache inv))))))))

;;; token ids: 100000-199999. A string.
;;; name ids: 200000-299999. Token+gender
;;; scope ids: 300000-399999. Name+scopetype+language
;;; scope type: 1=language of origin; 2=language of expression
;;; cluster: ids: 800000-8999999. 

;;; drop origin
;;; utter ids: 400000-499999. Name + phonemes/stress/syllables
;;; semantics ids: 500000-599999. 
;;; semantics address ids: 600000-699999. Semantics+address+source
;;; meaning mapping: 700000-799999. broken.

(eval-when (:load-toplevel :execute)
  (define-relation :name-token)
  (define-relation :token-name :inverse :name-token)
  (define-relation :name-scope))
