;;; -*- Mode:Lisp; Syntax:Common-lisp; Coding:UTF-8; Package:NMB; Base:10 -*-

(in-package :nmb)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (require :edu.isi.isd.nlp.appl.db.dbl)
  (use-package :edu.isi.isd.nlp.appl.db.dbl))

;;; token

(defun ensure-token (token)
  (let ((ids (dbl :nmb "select id from token where token='~A'" token)))
    (if ids
	(progn
	  (when (cdr ids)
	    (warn "More than one ID for token ~S" token))
	  (values (caar ids)
		  token))
      (progn
	(let ((maxes (dbl :nmb "select max(id) from token")))
	  (let ((id (if maxes 
			(1+ (caar maxes))
		      100000)))
	    (dbl :nmb "insert into token values(~A,'~A')"
		 id token)
	    (values id token)))))))

(defmacro define-token (token)
  `(ensure-token ',token))

;;; name: token and gender

(defun ensure-name (token gender)
  (let ((tid (ensure-token token)))
    (let ((ids (dbl :nmb "select id from name 
where tid='~A' 
and gender='~A'"
		    tid
		    gender)))
      (if ids
	  (progn
	    (when (cdr ids)
	      (warn "More than one ID for token=~S, gender=~S" 
		    token gender))
	    (values (caar ids)
		    token))
	(progn
	  (let ((maxes (dbl :nmb "select max(id) from name")))
	    (let ((id (if maxes 
			  (1+ (caar maxes))
			200000)))
	      (dbl :nmb "insert into name values(~A,~A,'~A')"
		   id tid gender)
	      (values id token))))))))

(defmacro define-name (token gender)
  `(ensure-name ',token ',gender))

;;; scope: token, gender, situated in a language/culture
;;; a given name probably should have at least one expression
;;; (scope-type 2) and ideally at least one origin (scope-type 1)

(defun ensure-scope (token gender scope-type language)
  (let ((name (ensure-name token gender)))
    
