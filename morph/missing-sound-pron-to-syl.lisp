;;; -*- Mode:Lisp; Syntax:Common-lisp; Package:NMB; Base:10 -*-

(in-package :nmb)

(eval-when (compile load eval)
  (require :dbl)
  (use-package :dbl))

(eval-when (compile load eval)
  (require :cmupron)
  (use-package :cmupron))

(eval-when (compile load eval)
  (require :stringutil)
  (use-package :stringutil))

(eval-when (compile load eval)
  (require :dblhax)
  (use-package :dblhax))

(eval-when (compile load eval)
  (setq dbl::*host* "ubirr.isi.edu"))

(defun update-missing-sound-pron-to-syl ()
  (archive-table :nmb "missing_sound")
  (loop for (id name sex phonemes stress syllables)
      in (dbl :nmb "select * from missing_sound")
      as list = (split-char #\space phonemes)
      as vowel-count = (count-if #'vowel-phoneme-p list)
      do (dbl :nmb "update missing_sound set syllables = ~D
  where id=~D and phonemes='~A'" 
	      vowel-count
	      id phonemes)))


#||

    
theomjlu7ytrewqzcfdhyytyytgfdsxxrrrttttrrtttttttrgtgujiiiuuuih ngfffffffffffffffffcvbhnmkk;    
    daddy

||#
