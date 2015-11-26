;;; -*- Mode:Lisp; Syntax:Common-lisp; Coding:UTF-8; Package:NMB; Base:10 -*-

(in-package :nmb)

(define-condition nmb-error (program-error)
  ())

(define-condition entity-not-found (nmb-error)
  ())
