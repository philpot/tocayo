;;; -*- Mode:Lisp; Syntax:Common-lisp; Coding:UTF-8; Package:NMB; Base:10 -*-

(IN-PACKAGE :NMB)

(EVAL-WHEN (:COMPILE-TOPLEVEL :LOAD-TOPLEVEL :EXECUTE)
  (REQUIRE :EDU.ISI.ISD.NLP.APPL.DB.DBL)
  (USE-PACKAGE :EDU.ISI.ISD.NLP.APPL.DB.DBL)
  
  (REQUIRE :EDU.ISI.ISD.NLP.ADT.STRING.STRINGUTIL)
  (USE-PACKAGE :EDU.ISI.ISD.NLP.ADT.STRING.STRINGUTIL)
  
  (REQUIRE :EDU.ISI.ISD.NLP.ADT.READTABLE.READTABLEUTIL)
  (USE-PACKAGE :EDU.ISI.ISD.NLP.ADT.READTABLE.READTABLEUTIL))

(IN-SYNTAX (COPY-READTABLE NIL))

;;; 17 October 2007 by Philpot
;;; general naming scheme
;;; lookup-x: returns the index if exists, NIL otherwise
;;; fetch-x: returns the index if exists, error otherwise
;;; ensure-x: returns the index if exists, creates if possible,
;;;   otherwise error
;;; intern-x: unconditionally make new X

;;; token

(define-condition token-not-found (entity-not-found)
  ((token :initarg :token
	  :accessor token
	  :initform nil))
  (:report (lambda (c s)
	     (format s "Token ~S not found"
		     (token c)))))

(defun lookup-token (token)
  (let* ((token (coerce-string token))
	 (ids (dbl :nmb "select id from token where token='~A'"
		   token)))
    (when (cdr ids)
      (warn "More than one ID exists for ~S: ~S"
	    token ids))
    (if ids
	(values (caar ids) token)
      nil)))

(defun fetch-token (token)
  (let ((token (coerce-string token)))
    (or (lookup-token token)
	(error 'token-not-found :token token))))

(defun ensure-token (token)
  (multiple-value-bind (tid token) (lookup-token token)
    (when tid
      (return-from ensure-token (values tid token))))
  (intern-token (coerce-string token)))

(defun intern-token (string &key (origin 100000))
  (let* ((max (caar (dbl :nmb "select max(id) from token")))
	 (id (if max (1+ max) origin)))
    (dbl :nmb "insert into token values(~A,'~A')"
	 id string)
    (values id string)))

(defmacro define-token (token)
  `(ensure-token ',token))

;;; name: token and gender

(define-condition name-not-found (entity-not-found)
  ((token :initarg :token
	  :accessor token
	  :initform nil)
   (gender :initarg :gender
	   :accessor gender
	   :initform :u))
  (:report (lambda (c s)
	     (format s "Name ~S/~S not found"
		     (token c)
		     (gender c)))))

(defun canon-gender (x)
  (string-upcase (coerce-string x)))

(defun lookup-name (token gender)
  (multiple-value-bind (tid token)
      (ensure-token token)
    (let ((gender (canon-gender gender))
	  (ids (dbl :nmb "select id from name 
where tid='~A' 
and gender='~A'"
		    tid
		    gender)))
      (when (cdr ids)
	(warn "More than one ID exists for name S/~S: ~S" 
	      token gender ids))
      (if ids
	  (values (caar ids)
		  token
		  gender)
	nil))))

(defun fetch-name (token gender)
  (let ((token (coerce-string token))
	(gender (canon-gender gender)))
    (or (lookup-name token gender)
	(error 'token-not-found :token token :gender gender))))

(defun ensure-name (token gender)
  (multiple-value-bind (id token gender) (lookup-name token gender)
    (when id
      (return-from ensure-name (values id token gender))))
  (intern-name (coerce-string token)
	       gender))

(defun intern-name (string gender &key (origin 200000))
  (let* ((tid (ensure-token string))
	 (max (caar (dbl :nmb "select max(id) from name")))
	 (id (if max (1+ max) origin)))
    (dbl :nmb "insert into name values(~A,'~A','~A')"
	 id tid gender)
    (values id string gender)))

(defmacro define-name (token &key (gender :u))
  `(ensure-name ',token ',gender))

;;; language

(define-condition language-not-found (entity-not-found)
  ((short :initarg :short
	  :accessor short
	  :initform nil))
  (:report (lambda (c s)
	     (format s "Language ~S not found"
		     (short c)))))

(defun canon-language (thing)
  (string-upcase (coerce-string thing)))

(defun lookup-language (language)
  (let* ((language (canon-language language))
	 (ids (dbl :nmb "select id from lang where short='~A'"
		   language)))
    (when (cdr ids)
      (warn "More than one ID exists for ~S: ~S"
	    language ids))
    (when (car ids)
      (return-from lookup-language (values (caar ids) language)))
    ;; try long
    (let ((ids (dbl :nmb "select id from lang where `long`='~A'"
		    language)))
      (when (cdr ids)
	(warn "More than one ID exists for ~S: ~S"
	      language ids))
      (when (car ids)
	(return-from lookup-language (values (caar ids) language)))
      ;; try name
      (let ((ids (dbl :nmb "select id from lang where name='~A'"
		      language)))
	(when (cdr ids)
	  (warn "More than one ID exists for ~S: ~S"
		language ids))
	(when (car ids)
	  (return-from lookup-language (values (caar ids) language))))))
  nil)

(defun fetch-language (language)
  (let ((language (canon-language language)))
    (or (lookup-language language)
	(error 'language-not-found :short language))))

;;; scope type

(define-condition scopetype-not-found (entity-not-found)
  ((token :initarg :token
	  :accessor token
	  :initform nil)
   (gender :initarg :gender
	   :accessor gender
	   :initform :u))
  (:report (lambda (c s)
	     (format s "Scopetype ~S/~S not found"
		     (token c)
		     (gender c)))))

(defun lookup-scopetype (scopetype)
  (let* ((scopetype (coerce-string scopetype))
	 (ids (dbl :nmb "select id from scopetype where name='~A'"
		   scopetype)))
    (when (cdr ids)
      (warn "More than one ID exists for ~S: ~S"
	    scopetype ids))
    (if ids
	(values (caar ids) scopetype)
      nil)))

(defun canon-scopetype (thing)
  (string-downcase (coerce-string thing)))

(defun fetch-scopetype (scopetype)
  (let ((scopetype (canon-scopetype scopetype)))
    (or (lookup-scopetype scopetype)
	(error 'scopetype-not-found
	       :scopetype scopetype))))

;;; scope: token, gender, situated in a language/culture
;;; a given name probably should have at least one expression
;;; (scopetype 2) and ideally at least one origin (scopetype 1)

(define-condition scope-not-found (entity-not-found)
  ((token :initarg :token
	  :accessor token
	  :initform nil)
   (gender :initarg :gender
	   :accessor gender
	   :initform :u)
   (scopetype :initarg :scopetype
	      :accessor scopetype
	      :initform :expression)
   (language :initarg :language
	     :accessor language
	     :initform :en))
  (:report (lambda (c s)
	     (format s "Scope ~S/~S/~S/~S not found"
		     (token c)
		     (gender c)
		     (scopetype c)
		     (language c)))))

(defun lookup-scope (token gender scopetype language)
  (let ((gender (canon-gender gender))
	(scopetype (canon-scopetype scopetype))
	(stid (fetch-scopetype scopetype))
	(language (canon-language language))
	(lid (fetch-language language)))
    (multiple-value-bind (nid token gender)
	(ensure-name token gender)
      (let ((ids (dbl :nmb "select id from scope 
where nid='~A' 
and stid='~A'
and lang='~A'"
		      nid
		      stid
		      lid)))
      (when (cdr ids)
	(warn "More than one ID exists for scope S/~S/~S: ~S" 
	      nid gender lid ids))
      (if ids
	  (values (caar ids)
		  token
		  gender
		  scopetype
		  language)
	nil)))))

(defun fetch-scope (token gender scopetype language)
  (or (lookup-scope token gender scopetype language)
      (error 'scope-not-found 
	     :token token
	     :gender gender
	     :scopetype scopetype
	     :language language)))


(defun ensure-scope (token gender scopetype language)
  (multiple-value-bind (sid token gender scopetype language) 
      (lookup-scope token gender scopetype language)
    (when sid
      (return-from ensure-scope (values sid token gender scopetype language))))
  (intern-scope token gender scopetype language))

(defun intern-scope (token gender scopetype language
		     &key (origin 300000))
  (let* ((nid (ensure-name token gender))
	 (max (caar (dbl :nmb "select max(id) from scope")))
	 (id (if (not (empty max)) (1+ max) origin))
	 (stid (fetch-scopetype scopetype))
	 (lid (fetch-language language)))
    (dbl :nmb "insert into scope values(~A,'~A','~A','~A')"
	 id nid stid lid)
    (values id token gender scopetype language)))

(defmacro define-scope (token &optional (gender :u) 
					(language :en)
					(scopetype :expression))
  `(ensure-scope ',token ',gender ',scopetype ',language))

(defmacro |define-scope| (&rest args)
  `(define-scope ,@args))
