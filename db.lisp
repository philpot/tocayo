;;; -*- Mode:Lisp; Syntax:Common-lisp; Package:LUX; Base:10 -*-

(in-package :namemybaby)

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.db.dbaodbc)
  (use-package :edu.isi.isd.nlp.appl.db.dbaodbc))

(defun db (fmt &rest args)
  (fetch "babynames" (apply #'format nil fmt args)
	 :password "janndrew"
	 :verbose nil))
