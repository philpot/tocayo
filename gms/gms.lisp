(in-package :namemybaby)

(eval-when (compile load eval)
  (require :aserve)
  (require :webactions)
  (use-package :net.aserve)
  (use-package :net.html.generator))

(eval-when (compile load eval)
  (require :caseutil)
  (use-package :caseutil))

(eval-when (compile load eval)
  (require :listutil)
  (use-package :listutil))

(eval-when (compile load eval)
  (require :allegroserveutil))

(eval-when (compile load eval)
  (require :htmlentity)
  (use-package :htmlentity))

(eval-when (compile load eval)
  (require :htmlentity)
  (use-package :htmlentity))

(eval-when (compile load eval)
  (require :csv)
  (use-package :csv))

(eval-when (compile load eval)
  (require :dbl)
  (use-package :dbl))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; need pron, spelling, origin, syllables, stress

(defun consonant-phoneme-p (ph)
  (or (not (vowel-phoneme-p ph))
      (string-equal ph "ER")))

(defun generate (outfile)
  (let ((tuples (dbl :namemybaby "SELECT distinct n.name,n.origin,n.syllables,n.stresspat,
p.pron
FROM name n,pron p
WHERE n.name = p.name"))
	(*print-circle* nil))
    (with-open-file (stream outfile
		     :direction :output
		     :if-exists :new-version
		     :if-does-not-exist :create)
      (loop for (name origin syl stress pron) in tuples
	  as sounds = (split-char #\space pron)
	  do 
	    ;; order is name (ignored), initsound, finalsound, 
	    ;; initvowel, finalvowel, initconsonant,
	    ;; finalconsonant, origin, initletter, finalletter,
	    ;; syllables, stress, [GMS category]. 
	    (format stream "~&~{~A~^, ~}~%"
		    (list name
			  (first sounds)
			  (car (last sounds))
			  (find-if #'vowel-phoneme-p sounds)
			  (find-if #'vowel-phoneme-p sounds
				   :from-end t)
			  (find-if #'consonant-phoneme-p sounds)
			  (find-if #'consonant-phoneme-p sounds
				       :from-end t)
			  origin
			  (char-upcase (char name 0))
			  (char-upcase (char name (1- (length name))))
			  syl
			  (substitute #\U #\0
				      (substitute #\S #\1
						  (princ-to-string stress)))))))))


      
(defun test-mark-data ()
  (let ((d (csv::read-csv-file "/tmp/mark.data")))
    (loop for (name nil) in d
	as pron = (caar (dbl :namemybaby "select pron from pron where name = '~A'"
			    name))
	collect
	  (list name pron (and pron
			       (remove name 
				       (dbl :namemybaby "select name from
pron where pron = '~A'" pron)
				       :test #'(lambda (x y)
						 (string-equal x (car y)))))))))


(defun generate (outfile)
  (let ((tuples (dbl :namemybaby "SELECT distinct n.name,n.origin,n.syllables,n.stresspat,
p.pron
FROM name n,pron p
WHERE n.name = p.name
ORDER BY n.name"))
	(*print-circle* nil))
    (with-open-file (stream outfile
		     :direction :output
		     :if-exists :new-version
		     :if-does-not-exist :create)
      (loop for (name origin syl stress pron) in tuples
	  as sounds = (split-char #\space pron)
	  do 
	    ;; order is name (ignored), initsound, finalsound, 
	    ;; initvowel, finalvowel, initconsonant,
	    ;; finalconsonant, origin, initletter, finalletter,
	    ;; syllables, stress, [GMS category]. 
	    (format stream "~&~{~A~^, ~}~%"
		    (list name
			  (first sounds)
			  (car (last sounds))
			  (find-if #'vowel-phoneme-p sounds)
			  (find-if #'vowel-phoneme-p sounds
				   :from-end t)
			  (find-if #'consonant-phoneme-p sounds)
			  (find-if #'consonant-phoneme-p sounds
				       :from-end t)
			  origin
			  (char-upcase (char name 0))
			  (char-upcase (char name (1- (length name))))
			  syl
			  (substitute #\U #\0
				      (substitute #\S #\1
						  (princ-to-string stress)))))))))

;;; join this with the known good options


(setq f (dbl :namemybaby "select distinct g.name,p2.name,g.tag,p1.pron from gms g,
pron p1, pron p2
where g.name=p1.name and p1.pron=p2.pron order by g.name, p2.name"))

(defun generate2 (outfile)
  (let ((tuples (dbl :namemybaby "SELECT distinct p2.name,n.origin,n.syllables,n.stresspat,p1.pron,g.tag 
FROM gms g, name n, pron p1, pron p2
WHERE n.name = p2.name
AND g.name=p1.name and p1.pron=p2.pron order by g.name, p2.name"))
	(*print-circle* nil))
    (with-open-file (stream outfile
		     :direction :output
		     :if-exists :new-version
		     :if-does-not-exist :create)
      (loop for (name origin syl stress pron tag) in tuples
	  as sounds = (split-char #\space pron)
	  do 
	    ;; order is name (ignored), initsound, finalsound, 
	    ;; initvowel, finalvowel, initconsonant,
	    ;; finalconsonant, origin, initletter, finalletter,
	    ;; syllables, stress, [GMS category]. 
	    (format stream "~&~{~A~^, ~}~%"
		    (list name
			  (first sounds)
			  (let ((last (car (last sounds))))
			    (when (equal last "EY")
			      (warn "Last sound of ~A is ~A"
				    name last))
			    last)
			  (find-if #'vowel-phoneme-p sounds)
			  (find-if #'vowel-phoneme-p sounds
				   :from-end t)
			  (find-if #'consonant-phoneme-p sounds)
			  (find-if #'consonant-phoneme-p sounds
				       :from-end t)
			  origin
			  (char-upcase (char name 0))
			  (char-upcase (char name (1- (length name))))
			  syl
			  (substitute #\U #\0
				      (substitute #\S #\1
						  (princ-to-string stress)))
			  tag))))))
