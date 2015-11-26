;;; -*- Mode:Lisp; Syntax:Common-lisp; Package:NAMEMYBABY; Base:10 -*-

(in-package :namemybaby)

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.adt.string.editdist)
  (use-package :edu.isi.isd.nlp.adt.string.editdist))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.nlp.lex.letter)
  (use-package :edu.isi.isd.nlp.appl.nlp.lex.letter))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.lang.control.caseutil)
  (use-package :edu.isi.isd.nlp.lang.control.caseutil))

;;; simple phonetic model
;;; for use on english strings, not phonemic reps

#+ignore
(progn
  (defun subst-cost (c1 c2)
    (if (and (vowelp c1)
	     (vowelp c2))
	1
      2))

  (defun phonetic-dist (mph1 mph2)
    (/ (edit-distance mph1 mph2
		      :insert 2
		      :delete 2
		      :subst #'subst-cost) 2))
  )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun vowel-phoneme-p (ph)
  (member ph '("AA" "AE" "AH" "AO" "AW" 
	       "AY" "EH" "ER" "EY" "IH"
	       "IY" "OW" "OY" "UH" "UW")
	  :test #'string-equal))

(defun subst-favor-vowels (p1 p2)
  (if (and (vowel-phoneme-p p1)
	   (vowel-phoneme-p p2))
      1
    2))
  
;;; "Similar" (but not equal) sounds have cost 1, all other
;;; differences have cost 2

(defun subst-custom (p1 p2)
  (when (string< p2 p1)
    (rotatef p1 p2))
  (let ((p2-set
	 (case-string-equal p1
	   ("AA" '("AE" "AH" "AO"))
	   ("AE" '("AH"))
	   ("AH" '("EH" "ER" "IH"))
	   ("CH" '("JH" "SH"))
	   ("DH" '("TH"))
	   ("ER" '("R"))
	   ("IY" '("Y"))
	   ("JH" '("ZH"))
	   ("M" '("N"))
	   ("N" '("NG"))
	   ("S" '("Z"))
	   ("SH" '("ZH")))))
    (if (and p2-set 
	     (member p2 p2-set :test #'string-equal))
	2
      (if (and (vowel-phoneme-p p1)
	       (vowel-phoneme-p p2))
	  3
      4))))

;;; R1,R2 should be vectors

(defun phonetic-distance (r1 r2 &key (mode :conservative))
  (ecase mode
    (:conservative 
     (edit-distance r1 r2 :test #'equal))
    (:simple 
     (/ (edit-distance r1 r2 
		       :test #'equal
		       :insert 2
		       :delete 2
		       :subst #'subst-favor-vowels) 2))   
    (:custom
     (/ (edit-distance r1 r2
		       :test #'equal
		       :insert 2
		       :delete 2
		       :subst #'subst-custom) 4))))

(defun phon (n)
  ;; was DB
  (caar (dbl "select pron from pron where name = '~A'" n)))

(defun word-phonetic-distance (w1 w2 &key (mode :conservative))
  (let ((ph1 (phon w1))
	(ph2 (phon w2)))
    (and ph1 ph2
	 (phonetic-distance ph1 ph2
			    :mode mode))))

