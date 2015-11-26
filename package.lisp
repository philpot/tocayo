;;; -*- Mode:Lisp; Syntax:Common-lisp; Package:USER; Base:10 -*-

(in-package :user)

(require :webactions)

(defpackage :namemybaby
  (:use :cl :net.aserve
	:net.html.generator))
