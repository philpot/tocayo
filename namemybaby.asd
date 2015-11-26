;;; -*- Mode:Lisp; Syntax:Common-lisp; Coding:utf-8; Package:NAMEMYBABY-ASDF; Base:10 -*-

(in-package :cl-user)

(require :asdf)

(defpackage :namemybaby-asdf
  (:use :cl :asdf))

(in-package :namemybaby-asdf)

(eval-when (load eval)
  (require :edu.isi.isd.nlp.adt.pkg.ovocab))

(eval-when (load eval)
  (require :sensor-three))

(defvar *reloading-namemybaby* nil)

;;; A1 = African
;;; A2 = African-American
;;; A3 = American Indian
;;; G1 = Gaelic
;;; H1 = Hawaiian
;;; S1 = Scandinavian
;;; S2 = Slavic
;;; 00 = junk ("all nationalities")
;;; 99 = unidentified origin

(eval-when (load eval)
  (let ((languages '("a1" "a2" "a3" "ar" "cy" "de" "el" "en" "es"
		     "fa" "fr" "g1" "h1" "he" "hi" "hu" "hy" "it" "ja"
		     "km" "la" "nl" "pl" "pt" "ru" "s1" "s2" "sw" "tr"
		     "vi" "zh" "99")))
    (ovocab:ensure-vocab :m :languages languages)
    (ovocab:ensure-vocab :f :languages languages)
    (ovocab:ensure-vocab :l)
    (ovocab:ensure-vocab :s)))

(defvar *namemybaby-vocabs*
    (list (ovocab::find-vocab :m)
	  (ovocab::find-vocab :f)
	  (ovocab::find-vocab :l)
	  (ovocab::find-vocab :s)))

(defpackage :namemybaby
  (:use #+CLIM "CLIM-LISP" 
	#-CLIM "COMMON-LISP"
	;; "CLOS"
	:edu.isi.isd.nlp.adt.pkg.ovocab)
  (:nicknames #:nmb)
  )

(defsystem :NAMEMYBABY
  ;; :source-pathname (translate-logical-pathname "NAMEMYBABY:")
  ;; :depends-on (:SENSOR3)
  :depends-on (:SENSOR-THREE)
  :components
  ((:file "package")

   (:file "db" :depends-on ("package"))
   (:file "semcount" :depends-on ("package"))
   (:file "semdist" :depends-on ("package"))
   (:file "semaddr" :depends-on ("package"))
   (:file "search" :depends-on ("package"))
   (:file "phon" :depends-on ("package"))
   
   (:file "decl")
   ))
