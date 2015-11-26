;;; -*- Mode:Lisp; Syntax:Common-lisp; Package:LUX; Base:10 -*-

(in-package :namemybaby)

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.db.dbaodbc)
  (use-package :edu.isi.isd.nlp.appl.db.dbaodbc))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.nlp.phon.metaphone)
  (use-package :edu.isi.isd.nlp.appl.nlp.phon.metaphone))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.math.discrete.set)
  (use-package :edu.isi.isd.nlp.math.discrete.set))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.adt.list.listutil)
  (use-package :edu.isi.isd.nlp.adt.list.listutil))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.adt.list.group)
  (use-package :edu.isi.isd.nlp.adt.list.group))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.adt.string.editdist)
  (use-package :edu.isi.isd.nlp.adt.string.editdist))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.adt.string.stringutil)
  (use-package :edu.isi.isd.nlp.adt.string.stringutil))

(defun sound-alike (name distance)
  (case distance
    (0 (sound-identical name))
    (1 (sound-close name distance distance))
    (otherwise (error "too far"))))

(defun sound-identical (name)
  (let ((target (metaphone name)))
    (db "select * from phonology where mphn = '~A'"
	target)))

(defun sound-close (name max &optional (min max))
  (let* ((word (metaphone (string name)))
	 (size (length word))
	 (adjmin (max 0 (- min 2)))
	 (patterns (list)))
    
    (loop for i from 0 below (expt 2 size)
	as bitcount = (logcount i)
	when (<= adjmin bitcount max)
	do (let ((d (loop for j from 0 below size
			as c across word
			if (ldb-test (byte 1 j) i)
			collect #\_
		      else
			collect c)))
	     (cond 
	      ((= bitcount (- min 2))
	       (push (cons #\_ (append d (list #\_))) patterns))
	      ((= bitcount (- min 1))
	       (push (cons #\_ d) patterns)
	       (push (append d (list #\_)) patterns))
	      (t (push d patterns)))))
    
    (let ((query (with-output-to-string (s)
		   (format s "select name, mphn from phonology where ")
		   (loop for (p . rest) on patterns by #'cdr
		       do (format s "mphn like '~{~A~}'"
				  p)
		       when rest
		       do (format s " OR ")))))
      (db query))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; (defun namesearch (root &rest keys-and-values)
;;;   (destructuring-bind (&key gender origin
;;; 			    syllables stress
;;; 			    popularity
;;; 			    begins-letter ends-letter 
;;; 			    !begins-letter !ends-letter
;;; 			    begins-sound ends-sound
;;; 			    !begins-sound !ends-sound
;;; 			    semantic-distance phonetic-distance)
;;;       keys-and-values
;;;     ;; various checks
;;;     (let ((ht (make-hash-table :test #'eql)))
;;; 
;;;       (labels ((insert (tag fmt &rest values)
;;; 		 (push (apply #'format nil fmt values)
;;; 		       (gethash tag ht)))
;;; 	       (add-all (tag fmt variable)
;;; 		 (do-canon (i variable)
;;; 		   (insert tag fmt i))))
;;; 	
;;; 	;; gender, etc.
;;; 	(when gender
;;; 	  (add-all :gender "n.gender = '~A'" gender))
;;; 	(when origin
;;; 	  (add-all :origin "n.origin = '~A'" origin))
;;; 	(when syllables
;;; 	  (if (consp syllables)
;;; 	      ;; interval
;;; 	      (insert :syllables "n.syllables >= ~A and n.syllables <= ~A"
;;; 		      (car syllables) (cdr syllables))
;;; 	    ;; single setting
;;; 	    (add-all :syllables "n.syllables = ~A" syllables)))
;;; 	(when stress
;;; 	  (add-all :stress "n.stresspat = '~A'" stress))
;;; 
;;; 	;; orthography
;;; 	(when begins-letter
;;; 	  (add-all :begins-letter "left(n.name,1) = '~A'" begins-letter))
;;; 	(when ends-letter
;;; 	  (add-all :ends-letter "right(n.name,1) = '~A'" ends-letter))
;;; 	(when !begins-letter
;;; 	  (add-all :!begins-letter "left(n.name,1) != '~A'" !begins-letter))
;;; 	(when !ends-letter
;;; 	  (add-all :!ends-letter "right(n.name,1) != '~A'" !ends-letter))
;;; 	
;;; 	;; phonology
;;; 	;; assumes caller knows about metaphone encoding of sounds
;;; 	;; (consonants mostly map normally, except:
;;; 	;; CH, SH = X
;;; 	;; D, T   = T
;;; 	;; F, V   = F
;;; 	;; G/K/Q/C= K
;;; 	;; S, Z   = S
;;; 	;; TH     = 0 (zero)
;;; 	;; Note: H, W only make sense in initial position
;;; 	(when begins-sound
;;; 	  (add-all :begins-sound "left(p.mphn,1) = '~A'" begins-sound))
;;; 	(when ends-sound
;;; 	  (add-all :ends-sound "right(p.mphn,1) = '~A'" ends-sound))
;;; 	(when !begins-sound
;;; 	  (add-all :!begins-sound "left(p.mphn,1) != '~A'" !begins-sound))
;;; 	(when !ends-sound
;;; 	  (add-all :!ends-sound "right(p.mphn,1) != '~A'" !ends-sound))
;;; 
;;; 	;; distance metrics
;;; 	
;;; 	(assert (if (or semantic-distance phonetic-distance)
;;; 		    root
;;; 		  t))
;;; 	
;;; 	#+ignore
;;; 	(let ((root-sems (and semantic-distance
;;; 			      (db "select sem from sem where name = '~A'"
;;; 				  root)))
;;; 	      (root-phon (and phonetic-distance
;;; 			      (metaphone root)))
;;; 	      ))
;;; 	
;;; 	(let ((query 
;;; 	       (with-output-to-string (s)
;;; 		 (format s
;;; 			 "SELECT distinct n.name,n.gender,n.origin,n.syllables,n.stresspat,
;;; p.mphn,s.sem,a.addr
;;; FROM name n,phonology p,semaddr a,sem s
;;; WHERE n.name = p.name
;;; AND s.sem = a.sem
;;; AND s.name = n.name
;;; ")
;;; 		 (maphash #'(lambda (tag clauses)
;;; 			      (let ((negative (char= (char (symbol-name tag) 0)
;;; 						     #\!)))
;;; 				(fresh-line s)
;;; 				(write-string "AND (" s)
;;; 				(loop for (clause . rest) on clauses by #'cdr
;;; 				    do (write-string clause s)
;;; 				    when rest
;;; 				    do (write-string 
;;; 					(if negative " AND " " OR ") s))
;;; 				(write-char #\) s)))
;;; 			  ht))))
;;; 	  (let ((raw (db query)))
;;; 	    (when semantic-distance
;;; 	      (setq raw
;;; 		(delete-if #'(lambda (n)
;;; 			       (> (addr-word-dist n root) semantic-distance))
;;; 			   raw
;;; 			   :key #'first)))
;;; 	    (when phonetic-distance
;;; 	      (setq raw
;;; 		(delete-if #'(lambda (p)
;;; 			       (> (phonetic-dist p root) phonetic-distance))
;;; 			   raw
;;; 			   :key #'sixth)))
;;; 	    
;;; 	    (values
;;; 	     raw
;;; 	     query)))))))

;;; #+uses_metaphone
;;; (defun namesearch (root &rest keys-and-values
;;; 		   &key (xtp 2)   
;;; 		   &allow-other-keys)
;;;   (destructuring-bind (&key gender origin
;;; 			    syllables stress
;;; 			    decile
;;; 			    begins-letter ends-letter 
;;; 			    !begins-letter !ends-letter
;;; 			    begins-sound ends-sound
;;; 			    !begins-sound !ends-sound
;;; 			    semantic-distance phonetic-distance)
;;;       keys-and-values
;;;     
;;;     ;; various checks
;;;     
;;;     (assert (if (or semantic-distance phonetic-distance)
;;; 		root
;;; 	      t))
;;;     
;;;     ;; precompute subqueries
;;;     (let* ((root-sems (and semantic-distance
;;; 			   (mapcar #'car
;;; 				   (db "select distinct sem from sem 
;;; where name = '~A'"
;;; 				       root))))
;;; 	   (root-phon (and phonetic-distance
;;; 			   (metaphone root)))
;;; 	   (minpop (and decile
;;; 			(caar (db "select minpop from decile
;;; where decile = '~A'"
;;; 				 (if (consp decile)
;;; 				     (car decile)
;;; 				   decile)))))
;;; 	   (maxpop (and decile
;;; 			(caar (db "select maxpop from decile
;;; where decile = '~A'"
;;; 				 (if (consp decile)
;;; 				     (cdr decile)
;;; 				   decile)))))
;;; 
;;; 	   (ht (make-hash-table :test #'eql)))
;;; 
;;;       (labels ((insert (tag fmt &rest values)
;;; 		 (push (apply #'format nil fmt values)
;;; 		       (gethash tag ht)))
;;; 	       (add-all (tag fmt variable)
;;; 		 (do-canon (i variable)
;;; 		   (insert tag fmt i))))
;;; 	
;;; 	;; gender, etc.
;;; 	(when gender
;;; 	  (add-all :gender "n.gender = '~A'" gender))
;;; 	(when origin
;;; 	  (add-all :origin "n.origin = '~A'" origin))
;;; 	(when syllables
;;; 	  (if (consp syllables)
;;; 	      ;; interval
;;; 	      (insert :syllables "n.syllables >= ~A AND n.syllables <= ~A"
;;; 		      (car syllables) (cdr syllables))
;;; 	    ;; single setting
;;; 	    (add-all :syllables "n.syllables = ~A" syllables)))
;;; 	(when stress
;;; 	  (add-all :stress "n.stresspat = '~A'" stress))
;;; 	
;;; 	(when decile
;;; 	  (insert :decile "n.popularity >= ~A AND n.popularity <= ~A"
;;; 		  minpop maxpop))
;;; 
;;; 	;; orthography
;;; 	(when begins-letter
;;; 	  (add-all :begins-letter "left(n.name,1) = '~A'" begins-letter))
;;; 	(when ends-letter
;;; 	  (add-all :ends-letter "right(n.name,1) = '~A'" ends-letter))
;;; 	(when !begins-letter
;;; 	  (add-all :!begins-letter "left(n.name,1) != '~A'" !begins-letter))
;;; 	(when !ends-letter
;;; 	  (add-all :!ends-letter "right(n.name,1) != '~A'" !ends-letter))
;;; 	
;;; 	;; phonology
;;; 	;; assumes caller knows about metaphone encoding of sounds
;;; 	;; (consonants mostly map normally, except:
;;; 	;; CH, SH = X
;;; 	;; D, T   = T
;;; 	;; F, V   = F
;;; 	;; G/K/Q/C= K
;;; 	;; S, Z   = S
;;; 	;; TH     = 0 (zero)
;;; 	;; Note: H, W only make sense in initial (left) position
;;; 	(when begins-sound
;;; 	  (add-all :begins-sound "left(p.mphn,1) = '~A'" begins-sound))
;;; 	(when ends-sound
;;; 	  (add-all :ends-sound "right(p.mphn,1) = '~A'" ends-sound))
;;; 	(when !begins-sound
;;; 	  (add-all :!begins-sound "left(p.mphn,1) != '~A'" !begins-sound))
;;; 	(when !ends-sound
;;; 	  (add-all :!ends-sound "right(p.mphn,1) != '~A'" !ends-sound))
;;; 
;;; 	;; distance metrics
;;; 	
;;; 	(let ((query 
;;; 	       (with-output-to-string (s)
;;; 		 (format s
;;; 			 "SELECT distinct n.name,n.gender,n.origin,n.syllables,n.stresspat,
;;; p.mphn,s.sem
;;; FROM name n,phonology p,sem s
;;; WHERE n.name = p.name
;;; AND s.name = n.name
;;; ")
;;; 		 (maphash #'(lambda (tag clauses)
;;; 			      (let ((negative (char= (char (symbol-name tag) 0)
;;; 						     #\!)))
;;; 				(fresh-line s)
;;; 				(write-string "AND (" s)
;;; 				(loop for (clause . rest) on clauses by #'cdr
;;; 				    do (write-string clause s)
;;; 				    when rest
;;; 				    do (write-string 
;;; 					(if negative " AND " " OR ") s))
;;; 				(write-char #\) s)))
;;; 			  ht))))
;;; 	  
;;; 	  (let ((tuples (db query)))
;;; 	    (setq tuples (reorg tuples))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    ;;
;;; 	    ;; now tuples are: 
;;; 	    ;; [<sems> <name> <gender> <orig> <syl> <stress> <mphn>]
;;; 	    ;;
;;; 	    ;; semantic distance processing
;;; 	    ;; 
;;; 	    (setq tuples
;;; 	      (mapcar #'(lambda (tuple)
;;; 			  (cons 
;;; 			   (if semantic-distance
;;; 			       (loop for rs in root-sems
;;; 				   minimize (loop for ts in (car tuple)
;;; 						minimize 
;;; 						  (sem-dist rs ts xtp)))
;;; 			     0)
;;; 			   tuple))
;;; 		      tuples))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    ;;
;;; 	    ;; tuples are now:
;;; 	    ;; [<sdist> <sems> <name> <gndr> <orig> <syl> <str> <mph>]
;;; 	    ;;
;;; 	    (when semantic-distance
;;; 	      (setq tuples 
;;; 		(delete-if #'(lambda (tuple)
;;; 			       (> (car tuple) semantic-distance))
;;; 			   tuples)))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    ;;
;;; 	    ;; phonetic distance processing
;;; 	    ;;
;;; 	    ;; now add phonetic distance to root
;;; 	    ;;
;;; 	    ;; tuples are now:
;;; 	    ;; [<phdst> <sdist> <sems> <name> <gndr> <org> <syl> <str> <mph>
;;; 	    ;;
;;; 	    
;;; 	    (setq tuples
;;; 	      (mapcar #'(lambda (tuple)
;;; 			  (cons (if phonetic-distance
;;; 				    (phonetic-dist (eighth tuple) root-phon)
;;; 				  0)
;;; 				tuple))
;;; 		      tuples))
;;; 	    ;;
;;; 	    ;; filter
;;; 	    (when phonetic-distance
;;; 	      (setq tuples
;;; 		(delete-if #'(lambda (tuple)
;;; 			       (> (car tuple) phonetic-distance))
;;; 			   tuples)))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    (values tuples 
;;; 		    (semgroup tuples)
;;; 		    query)))))))

;;; uses CMUPHON

(defun phon-to-vect (string)
  (apply #'vector 
	 (split-char #\space string))) 

;;; (defun namesearch (root &rest keys-and-values
;;; 		   &key (xtp 2)   
;;; 		   &allow-other-keys)
;;;   (destructuring-bind (&key gender origin
;;; 			    syllables stress
;;; 			    decile
;;; 			    begins-letter ends-letter 
;;; 			    !begins-letter !ends-letter
;;; 			    contains-letter !contains-letter
;;; 			    begins-sound ends-sound
;;; 			    !begins-sound !ends-sound
;;; 			    contains-sound !contains-sound
;;; 			    semantic-distance phonetic-distance)
;;;       keys-and-values
;;;     
;;;     ;; various checks
;;;     
;;;     (assert (if (or semantic-distance phonetic-distance)
;;; 		root
;;; 	      t))
;;;     
;;;     ;; precompute subqueries
;;;     (let* ((root-sems (and semantic-distance
;;; 			   (mapcar #'car
;;; 				   (db "select distinct sem from sem 
;;; where name = '~A'"
;;; 				       root))))
;;; 	   (root-phon (and phonetic-distance
;;; 			   ;; ## ignores cases of gender-specific
;;; 			   ;; pronunciation: Jean vs. Jean
;;; 			   (phon-to-vect
;;; 			    (caar (db "select pron from pron
;;; where name = '~A'" root)))))
;;; 	   (minpop (and decile
;;; 			(caar (db "select minpop from decile
;;; where decile = '~A'"
;;; 				 (if (consp decile)
;;; 				     (car decile)
;;; 				   decile)))))
;;; 	   (maxpop (and decile
;;; 			(caar (db "select maxpop from decile
;;; where decile = '~A'"
;;; 				 (if (consp decile)
;;; 				     (cdr decile)
;;; 				   decile)))))
;;; 
;;; 	   (ht (make-hash-table :test #'eql)))
;;; 
;;;       (labels ((insert (tag fmt &rest values)
;;; 		 (let ((str (apply #'format nil fmt values)))
;;; 		   (push str (gethash tag ht))))
;;; 	       (add-all (tag fmt variable)
;;; 		 (do-canon (i variable)
;;; 		   (insert tag fmt i))))
;;; 	
;;; 	;; gender, etc.
;;; 	(when gender
;;; 	  (add-all :ngender "n.gender = '~A'" gender)
;;; 	  (add-all :pgender "p.gender = '~A'" gender))
;;; 	(when origin
;;; 	  (add-all :origin "n.origin = '~A'" origin))
;;; 	(when syllables
;;; 	  (if (consp syllables)
;;; 	      ;; interval
;;; 	      (insert :syllables "n.syllables >= ~A AND n.syllables <= ~A"
;;; 		      (car syllables) (cdr syllables))
;;; 	    ;; single setting
;;; 	    (add-all :syllables "n.syllables = ~A" syllables)))
;;; 	(when stress
;;; 	  (add-all :stress "n.stresspat = '~A'" stress))
;;; 	
;;; 	(when decile
;;; 	  (insert :decile "n.popularity >= ~A AND n.popularity <= ~A"
;;; 		  minpop maxpop))
;;; 
;;; 	;; orthography
;;; 	(when begins-letter
;;; 	  (add-all :begins-letter "left(n.name,1) = '~A'" begins-letter))
;;; 	(when !begins-letter
;;; 	  (add-all :!begins-letter "left(n.name,1) != '~A'" !begins-letter))
;;; 	(when ends-letter
;;; 	  (add-all :ends-letter "right(n.name,1) = '~A'" ends-letter))
;;; 	(when !ends-letter
;;; 	  (add-all :!ends-letter "right(n.name,1) != '~A'" !ends-letter))
;;; 	(when contains-letter
;;; 	  (add-all :contains-letter "n.name like '%~A%'" contains-letter))
;;; 	(when !contains-letter
;;; 	  (add-all :!contains-letter "n.name not like '%~A%'" !contains-letter))
;;; 
;;; 	;; phonology/pron
;;; 	;; pron.pron is space separated string of phonemes
;;; 	(let ((left "left(p.pron,locate(' ',p.pron)-1)")
;;; 	      (right "right(p.pron,locate(' ',reverse(p.pron))-1)"))
;;; 	  
;;; 	  (when begins-sound
;;; 	    (add-all :begins-sound 
;;; 		     (format nil "~A = '~~A'" left)
;;; 		     begins-sound))
;;; 	  (when !begins-sound
;;; 	    (add-all :!begins-sound
;;; 		     (format nil "~A != '~~A'" left)
;;; 		     !begins-sound))
;;; 	  (when ends-sound
;;; 	    (add-all :ends-sound
;;; 		     (format nil "~A = '~~A'" right)
;;; 		     ends-sound))
;;; 	  (when !ends-sound
;;; 	    (add-all :!ends-sound
;;; 		     (format nil "~A != '~~A'" right)
;;; 		     !ends-sound))
;;; 	  (when contains-sound
;;; 	    (add-all :contains-sound 
;;; 		     (format nil "concat(' ',~A,' ') ~
;;; like '% ~~A %'" "p.pron")
;;; 		     contains-sound))
;;; 	  (when !contains-sound
;;; 	    (add-all :!contains-sound 
;;; 		     (format nil "concat(' ',~A,' ') ~
;;; not like '% ~~A %'" "p.pron")
;;; 		     !contains-sound))
;;; 
;;; 	  )
;;; 
;;; 	;; distance metrics
;;; 	
;;; 	(let ((query 
;;; 	       (with-output-to-string (s)
;;; 		 (format s
;;; 			 "SELECT distinct n.name,n.gender,n.origin,n.syllables,n.stresspat,
;;; p.pron,s.sem
;;; FROM name n,pron p,sem s
;;; WHERE n.name = p.name
;;; AND s.name = n.name
;;; ")
;;; 		 (maphash #'(lambda (tag clauses)
;;; 			      (let ((negative
;;; 				     (char= (char (symbol-name tag) 0)
;;; 					    #\!)))
;;; 				(fresh-line s)
;;; 				(write-string "AND (" s)
;;; 				(loop for (clause . rest) on clauses by #'cdr
;;; 				    do (write-string clause s)
;;; 				    when rest
;;; 				    do (write-string 
;;; 					(if negative " AND " " OR ") s))
;;; 				(write-char #\) s)))
;;; 			  ht))))
;;; 	  
;;; 	  (let ((tuples (db query)))
;;; 	    (setq tuples (reorg tuples))
;;; 	    (dolist (tuple tuples)
;;; 	      (setf (sixth tuple)
;;; 		(phon-to-vect (sixth tuple))))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    (print (car (car tuples)))
;;; 	    ;;
;;; 	    ;; now tuples are: 
;;; 	    ;; [<sems> <name> <gender> <orig> <syl> <stress> <phon>]
;;; 	    ;;
;;; 	    ;; semantic distance processing
;;; 	    ;; 
;;; 	    (setq tuples
;;; 	      (mapcar #'(lambda (tuple)
;;; 			  (cons 
;;; 			   (if semantic-distance
;;; 			       (loop for rs in root-sems
;;; 				   minimize (loop for ts in (car tuple)
;;; 						minimize 
;;; 						  (sem-dist rs ts xtp)))
;;; 			     0)
;;; 			   tuple))
;;; 		      tuples))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    ;;
;;; 	    ;; tuples are now:
;;; 	    ;; [<sdist> <sems> <name> <gndr> <orig> <syl> <str> <phon>]
;;; 	    ;;
;;; 	    (when semantic-distance
;;; 	      (setq tuples 
;;; 		(sort 
;;; 		 (delete-if #'(lambda (tuple)
;;; 			       (> (car tuple) semantic-distance))
;;; 			    tuples)
;;; 		 #'< :key #'car)))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    ;;
;;; 	    ;; phonetic distance processing
;;; 	    ;;
;;; 	    ;; now add phonetic distance to root
;;; 	    ;;
;;; 	    ;; tuples are now:
;;; 	    ;; [<phdst> <sdist> <sems> <name> <gndr> <org> <syl> <str> <phon>
;;; 	    ;;
;;; 	    
;;; 	    (setq tuples
;;; 	      (mapcar #'(lambda (tuple)
;;; 			  (cons (if phonetic-distance
;;; 				    (phonetic-distance 
;;; 				     (phon-to-vect (eighth tuple))
;;; 				     root-phon
;;; 				     :mode :custom)
;;; 				  0)
;;; 				tuple))
;;; 		      tuples))
;;; 	    ;;
;;; 	    ;; filter
;;; 	    (when phonetic-distance
;;; 	      (setq tuples
;;; 		(sort
;;; 		 (delete-if #'(lambda (tuple)
;;; 			       (> (car tuple) phonetic-distance))
;;; 			    tuples)
;;; 		 #'< :key #'car)))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    (values tuples 
;;; 		    (semgroup tuples)
;;; 		    query
;;; 		    ht)))))))

;;; ### this was left at 
;;; REORG, sixth vs seventh, and addition of n.pronunciation


;;; (defun namesearch (root &rest keys-and-values
;;; 		   &key (xtp 2)   
;;; 		   &allow-other-keys)
;;;   (destructuring-bind (&key gender origin
;;; 			    syllables stress
;;; 			    decile
;;; 			    begins-letter ends-letter 
;;; 			    !begins-letter !ends-letter
;;; 			    contains-letter !contains-letter
;;; 			    begins-sound ends-sound
;;; 			    !begins-sound !ends-sound
;;; 			    contains-sound !contains-sound
;;; 			    semantic-distance phonetic-distance)
;;;       keys-and-values
;;;     
;;;     ;; various checks
;;;     
;;;     (assert (if (or semantic-distance phonetic-distance)
;;; 		root
;;; 	      t))
;;;     
;;;     ;; precompute subqueries
;;;     (let* ((root-sems (and semantic-distance
;;; 			   (mapcar #'car
;;; 				   (dbl :namemybaby
;;; 					"select distinct sem from sem 
;;; where name = '~A'"
;;; 				       root))))
;;; 	   (root-phon (and phonetic-distance
;;; 			   ;; ## ignores cases of gender-specific
;;; 			   ;; pronunciation: Jean vs. Jean
;;; 			   (phon-to-vect
;;; 			    (caar (dbl :namemybaby
;;; 				       "select pron from pron
;;; where name = '~A'" root)))))
;;; 	   (minpop (and decile
;;; 			(caar (dbl
;;; 			       :namemybaby
;;; 			       "select minpop from decile
;;; where decile = '~A'"
;;; 				 (if (consp decile)
;;; 				     (car decile)
;;; 				   decile)))))
;;; 	   (maxpop (and decile
;;; 			(caar (db	;
;;; 			       :namemybaby
;;; 			       "select maxpop from decile
;;; where decile = '~A'"
;;; 				 (if (consp decile)
;;; 				     (cdr decile)
;;; 				   decile)))))
;;; 
;;; 	   (ht (make-hash-table :test #'eql)))
;;; 
;;;       (labels ((insert (tag fmt &rest values)
;;; 		 (let ((str (apply #'format nil fmt values)))
;;; 		   (push str (gethash tag ht))))
;;; 	       (add-all (tag fmt variable)
;;; 		 (do-canon (i variable)
;;; 		   (insert tag fmt i))))
;;; 	
;;; 	;; gender, etc.
;;; 	(when gender
;;; 	  (add-all :ngender "n.gender = '~A'" gender)
;;; 	  (add-all :pgender "p.gender = '~A'" gender))
;;; 	(when origin
;;; 	  (add-all :origin "n.origin = '~A'" origin))
;;; 	(when syllables
;;; 	  (if (consp syllables)
;;; 	      ;; interval
;;; 	      (insert :syllables "n.syllables >= ~A AND n.syllables <= ~A"
;;; 		      (car syllables) (cdr syllables))
;;; 	    ;; single setting
;;; 	    (add-all :syllables "n.syllables = ~A" syllables)))
;;; 	(when stress
;;; 	  (add-all :stress "n.stresspat = '~A'" stress))
;;; 	
;;; 	(when decile
;;; 	  (insert :decile "n.popularity >= ~A AND n.popularity <= ~A"
;;; 		  minpop maxpop))
;;; 
;;; 	;; orthography
;;; 	(when begins-letter
;;; 	  (add-all :begins-letter "left(n.name,1) = '~A'" begins-letter))
;;; 	(when !begins-letter
;;; 	  (add-all :!begins-letter "left(n.name,1) != '~A'" !begins-letter))
;;; 	(when ends-letter
;;; 	  (add-all :ends-letter "right(n.name,1) = '~A'" ends-letter))
;;; 	(when !ends-letter
;;; 	  (add-all :!ends-letter "right(n.name,1) != '~A'" !ends-letter))
;;; 	(when contains-letter
;;; 	  (add-all :contains-letter "n.name like '%~A%'" contains-letter))
;;; 	(when !contains-letter
;;; 	  (add-all :!contains-letter "n.name not like '%~A%'" !contains-letter))
;;; 
;;; 	;; phonology/pron
;;; 	;; pron.pron is space separated string of phonemes
;;; 	(let ((left "left(p.pron,locate(' ',p.pron)-1)")
;;; 	      (right "right(p.pron,locate(' ',reverse(p.pron))-1)"))
;;; 	  
;;; 	  (when begins-sound
;;; 	    (add-all :begins-sound 
;;; 		     (format nil "~A = '~~A'" left)
;;; 		     begins-sound))
;;; 	  (when !begins-sound
;;; 	    (add-all :!begins-sound
;;; 		     (format nil "~A != '~~A'" left)
;;; 		     !begins-sound))
;;; 	  (when ends-sound
;;; 	    (add-all :ends-sound
;;; 		     (format nil "~A = '~~A'" right)
;;; 		     ends-sound))
;;; 	  (when !ends-sound
;;; 	    (add-all :!ends-sound
;;; 		     (format nil "~A != '~~A'" right)
;;; 		     !ends-sound))
;;; 	  (when contains-sound
;;; 	    (add-all :contains-sound 
;;; 		     (format nil "concat(' ',~A,' ') ~
;;; like '% ~~A %'" "p.pron")
;;; 		     contains-sound))
;;; 	  (when !contains-sound
;;; 	    (add-all :!contains-sound 
;;; 		     (format nil "concat(' ',~A,' ') ~
;;; not like '% ~~A %'" "p.pron")
;;; 		     !contains-sound))
;;; 
;;; 	  )
;;; 
;;; 	;; distance metrics
;;; 	
;;; 	(let ((query 
;;; 	       (with-output-to-string (s)
;;; 		 (format s
;;; 			 "SELECT distinct n.name,n.gender,n.origin,n.syllables,n.stresspat,
;;; p.pron,s.sem, n.popularity
;;; FROM name n,pron p,sem s
;;; WHERE n.name = p.name
;;; AND s.name = n.name
;;; ")
;;; 		 (maphash #'(lambda (tag clauses)
;;; 			      (let ((negative
;;; 				     (char= (char (symbol-name tag) 0)
;;; 					    #\!)))
;;; 				(fresh-line s)
;;; 				(write-string "AND (" s)
;;; 				(loop for (clause . rest) on clauses by #'cdr
;;; 				    do (write-string clause s)
;;; 				    when rest
;;; 				    do (write-string 
;;; 					(if negative " AND " " OR ") s))
;;; 				(write-char #\) s)))
;;; 			  ht))))
;;; 	  
;;; 	  (let ((tuples (dbl :namemybaby query)))
;;; 	    (print (car tuples))
;;; 	    (setq tuples (reorg tuples))
;;; 	    (dolist (tuple tuples)
;;; 	      (setf (seventh tuple)
;;; 		(phon-to-vect (seventh tuple))))
;;; 	    (format t "~%~D tuples should be
;;; sems name gender orig syl stress phon pop**" (length tuples))
;;; 	    (print (car tuples))
;;; 	    ;;
;;; 	    ;; now tuples are: 
;;; 	    ;; [<sems> <name> <gender> <orig> <syl> <stress> <phon> <pop>]
;;; 	    ;;
;;; 	    ;; semantic distance processing
;;; 	    ;; 
;;; 	    (setq tuples
;;; 	      (mapcar #'(lambda (tuple)
;;; 			  (cons 
;;; 			   (if semantic-distance
;;; 			       (loop for rs in root-sems
;;; 				   minimize (loop for ts in (car tuple)
;;; 						minimize 
;;; 						  (sem-dist rs ts xtp)))
;;; 			     0)
;;; 			   tuple))
;;; 		      tuples))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    ;;
;;; 	    ;; tuples are now:
;;; 	    ;; [<sdist> <sems> <name> <gndr> <orig> <syl> <str> <phon>]
;;; 	    ;;
;;; 	    (when semantic-distance
;;; 	      (setq tuples 
;;; 		(sort 
;;; 		 (delete-if #'(lambda (tuple)
;;; 			       (> (car tuple) semantic-distance))
;;; 			    tuples)
;;; 		 #'< :key #'car)))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    ;;
;;; 	    ;; phonetic distance processing
;;; 	    ;;
;;; 	    ;; now add phonetic distance to root
;;; 	    ;;
;;; 	    ;; tuples are now:
;;; 	    ;; [<phdst> <sdist> <sems> <name> <gndr> <org> <syl> <str> <phon>
;;; 	    ;;
;;; 	    
;;; 	    (setq tuples
;;; 	      (mapcar #'(lambda (tuple)
;;; 			  (cons (if phonetic-distance
;;; 				    (phonetic-distance 
;;; 				     (phon-to-vect (eighth tuple))
;;; 				     root-phon
;;; 				     :mode :custom)
;;; 				  0)
;;; 				tuple))
;;; 		      tuples))
;;; 	    ;;
;;; 	    ;; filter
;;; 	    (when phonetic-distance
;;; 	      (setq tuples
;;; 		(sort
;;; 		 (delete-if #'(lambda (tuple)
;;; 			       (> (car tuple) phonetic-distance))
;;; 			    tuples)
;;; 		 #'< :key #'car)))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    (values tuples 
;;; 		    (semgroup tuples)
;;; 		    query
;;; 		    ht)))))))

(defun make-consolidator (constantfn varfn)
  #'(lambda (&rest tuples)
      (cons (remove-duplicates (mapcar varfn tuples)
			       :test #'equal)
	    (funcall constantfn (first tuples)))))

(defun reorg (tuples)
  (flet ((pivot (tuple) (subseq tuple 0 6)))
    (let ((consolidator (make-consolidator 
			 #'(lambda (x) (subseq x 0 6))
			 #'seventh)))
      (group tuples 
	     :pivot #'pivot
	     :test #'equal
	     :action consolidator
	     :pairwise nil))))

(defun reorg (tuples)
  (flet ((pivot (tuple) (subseq tuple 0 7)))
    (let ((consolidator (make-consolidator 
			 #'(lambda (x) (subseq x 0 7))
			 #'eighth)))
      (group tuples 
	     :pivot #'pivot
	     :test #'equal
	     :action consolidator
	     :pairwise nil))))

#+ignore
(defun reorg (tuples pos)
  (flet ((pivot (tuple) (subseq tuple 0 pos)))
    (let ((consolidator (make-consolidator 
			 #'(lambda (x) (subseq x 0 pos))
			 #'(lambda (x) (nth (1+ pos) x)))))
      (group tuples 
	     :pivot #'pivot
	     :test #'equal
	     :action consolidator
	     :pairwise nil))))

(defun semgroup (tuples)
  (group tuples
	 :pivot #'third
	 :test #'equal
	 :action #'(lambda (&rest tuples)
		     (list* (first (car tuples))
			    (second (car tuples))
			    (third (car tuples))
			    (mapcar #'cdddr tuples)))
	 :pairwise nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; (defun namesearch1 (root &rest keys-and-values
;;; 		   &key (xtp 2)   
;;; 		   &allow-other-keys)
;;;   (destructuring-bind (&key gender origin
;;; 			    syllables stress
;;; 			    decile
;;; 			    begins-letter ends-letter 
;;; 			    !begins-letter !ends-letter
;;; 			    contains-letter !contains-letter
;;; 			    begins-sound ends-sound
;;; 			    !begins-sound !ends-sound
;;; 			    contains-sound !contains-sound
;;; 			    semantic-distance phonetic-distance)
;;;       keys-and-values
;;;     
;;;     ;; various checks
;;;     
;;;     (assert (if (or semantic-distance phonetic-distance)
;;; 		root
;;; 	      t))
;;;     
;;;     ;; if decile comes in as a set, turn into smallest encompassing
;;;     ;; range 
;;;     (when (and (consp decile)
;;; 	       (listp (cdr decile)))
;;;       (flet ((ensure-number (x)
;;; 	       (typecase x
;;; 		 (number x)
;;; 		 (string (parse-integer x)))))
;;; 	(setf decile
;;; 	  (cons (reduce #'min decile :key #'ensure-number)
;;; 		(reduce #'max decile :key #'ensure-number)))))
;;;     
;;;     ;; precompute subqueries
;;;     (let* ((root-sems (and semantic-distance
;;; 			   (mapcar #'car
;;; 				   (dbl :namemybaby "select distinct sem from sem 
;;; where name = '~A'"
;;; 				       root))))
;;; 	   (root-phon (and phonetic-distance
;;; 			   ;; ## ignores cases of gender-specific
;;; 			   ;; pronunciation: Jean vs. Jean
;;; 			   (phon-to-vect
;;; 			    (caar (dbl :namemybaby "select pron from pron
;;; where name = '~A'" root)))))
;;; 	   (minpop (and decile
;;; 			(caar (dbl :namemybaby
;;; 				   "select minpop from decile
;;; where decile = '~A'"
;;; 				 (if (consp decile)
;;; 				     (car decile)
;;; 				   decile)))))
;;; 	   (maxpop (and decile
;;; 			(caar (dbl :namemybaby
;;; 				   "select maxpop from decile
;;; where decile = '~A'"
;;; 				 (if (consp decile)
;;; 				     (cdr decile)
;;; 				   decile)))))
;;; 
;;; 	   (ht (make-hash-table :test #'eql)))
;;; 
;;;       (labels ((insert (tag fmt &rest values)
;;; 		 (let ((str (apply #'format nil fmt values)))
;;; 		   (push str (gethash tag ht))))
;;; 	       (add-all (tag fmt variable)
;;; 		 (do-canon (i variable)
;;; 		   (insert tag fmt i))))
;;; 	
;;; 	;; gender, etc.
;;; 	(when gender
;;; 	  (add-all :ngender "n.gender = '~A'" gender)
;;; 	  (add-all :pgender "p.gender = '~A'" gender))
;;; 	(when origin
;;; 	  (add-all :origin "n.origin = '~A'" origin))
;;; 	(when syllables
;;; 	  (if (consp syllables)
;;; 	      ;; interval
;;; 	      (insert :syllables "n.syllables >= ~A AND n.syllables <= ~A"
;;; 		      (car syllables) (cdr syllables))
;;; 	    ;; single setting
;;; 	    (add-all :syllables "n.syllables = ~A" syllables)))
;;; 	(when stress
;;; 	  (add-all :stress "n.stresspat = '~A'" stress))
;;; 	
;;; 	(when decile
;;; 	  (insert :decile "n.popularity >= ~A AND n.popularity <= ~A"
;;; 		  minpop maxpop))
;;; 
;;; 	;; orthography
;;; 	(when begins-letter
;;; 	  (add-all :begins-letter "left(n.name,1) = '~A'" begins-letter))
;;; 	(when !begins-letter
;;; 	  (add-all :!begins-letter "left(n.name,1) != '~A'" !begins-letter))
;;; 	(when ends-letter
;;; 	  (add-all :ends-letter "right(n.name,1) = '~A'" ends-letter))
;;; 	(when !ends-letter
;;; 	  (add-all :!ends-letter "right(n.name,1) != '~A'" !ends-letter))
;;; 	(when contains-letter
;;; 	  (add-all :contains-letter "n.name like '%~A%'" contains-letter))
;;; 	(when !contains-letter
;;; 	  (add-all :!contains-letter "n.name not like '%~A%'" !contains-letter))
;;; 	;; phonology/pron
;;; 	;; pron.pron is space separated string of phonemes
;;; 	(let ((left "left(p.pron,locate(' ',p.pron)-1)")
;;; 	      (right "right(p.pron,locate(' ',reverse(p.pron))-1)"))
;;; 	  
;;; 	  (when begins-sound
;;; 	    (add-all :begins-sound 
;;; 		     (format nil "~A = '~~A'" left)
;;; 		     begins-sound))
;;; 	  (when !begins-sound
;;; 	    (add-all :!begins-sound
;;; 		     (format nil "~A != '~~A'" left)
;;; 		     !begins-sound))
;;; 	  (when ends-sound
;;; 	    (add-all :ends-sound
;;; 		     (format nil "~A = '~~A'" right)
;;; 		     ends-sound))
;;; 	  (when !ends-sound
;;; 	    (add-all :!ends-sound
;;; 		     (format nil "~A != '~~A'" right)
;;; 		     !ends-sound))
;;; 	  (when contains-sound
;;; 	    (add-all :contains-sound 
;;; 		     (format nil "concat(' ',~A,' ') ~
;;; like '% ~~A %'" "p.pron")
;;; 		     contains-sound))
;;; 	  (when !contains-sound
;;; 	    (add-all :!contains-sound 
;;; 		     (format nil "concat(' ',~A,' ') ~
;;; not like '% ~~A %'" "p.pron")
;;; 		     !contains-sound)))
;;; 
;;; 	;; distance metrics
;;; 	
;;; 	(let ((query 
;;; 	       (with-output-to-string (s)
;;; 		 (format s
;;; 			 "SELECT distinct n.name,n.gender,n.origin,n.syllables,n.stresspat,
;;; p.pron,s.sem, n.popularity
;;; FROM name n,pron p,sem s
;;; WHERE n.name = p.name
;;; AND s.name = n.name
;;; ")
;;; 		 (maphash #'(lambda (tag clauses)
;;; 			      (let ((negative
;;; 				     (char= (char (symbol-name tag) 0)
;;; 					    #\!)))
;;; 				(fresh-line s)
;;; 				(write-string "AND (" s)
;;; 				(loop for (clause . rest) on clauses by #'cdr
;;; 				    do (write-string clause s)
;;; 				    when rest
;;; 				    do (write-string 
;;; 					(if negative " AND " " OR ") s))
;;; 				(write-char #\) s)))
;;; 			  ht))))
;;; 	  
;;; 	  (let ((tuples (dbl :namemybaby query)))
;;; 	    ;; name gender origin syllables stress pron sem pop
;;; 	    ;; (setq tuples (reorg tuples))
;;; 	    (dolist (tuple tuples)
;;; 	      (setf (seventh tuple)
;;; 		(phon-to-vect (seventh tuple))))
;;; 	    (format t "~%After p2v, tuples should be
;;; name gen orig syl stress phon sem pop")
;;; 	    (pprint (car tuples))
;;; 	    ;;
;;; 	    ;; now tuples are: 
;;; 	    ;; [<name> <gender> <orig> <syl> <stress> <phon> <sem> <pop>]
;;; 	    ;;
;;; 	    ;; semantic distance processing
;;; 	    ;; 
;;; 	    (setq tuples
;;; 	      (mapcar #'(lambda (tuple)
;;; 			  (cons 
;;; 			   (if semantic-distance
;;; 			       (loop for rs in root-sems
;;; 				   minimize (loop for ts in (car tuple)
;;; 						minimize 
;;; 						  (sem-dist rs ts xtp)))
;;; 			     0)
;;; 			   tuple))
;;; 		      tuples))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    ;;
;;; 	    ;; tuples are now:
;;; 	    ;; [<sdist> <name> <gender> <orig> <syl> <str> <phon>
;;; 	    ;; <sem> <pop>]
;;; 	    ;;
;;; 	    (when semantic-distance
;;; 	      (setq tuples 
;;; 		(sort 
;;; 		 (delete-if #'(lambda (tuple)
;;; 			       (> (car tuple) semantic-distance))
;;; 			    tuples)
;;; 		 #'< :key #'car)))
;;; 	    (format t "~%after sem filter, fields should be")
;;; 	    (pprint "[<sdist> <name> <gender> <orig> <syl> <str> <phon>
;;; 	    ;; <sem> <pop>]")
;;; 	    (pprint (car tuples))
;;; 	    ;;
;;; 	    ;; phonetic distance processing
;;; 	    ;;
;;; 	    ;; now add phonetic distance to root
;;; 	    ;;
;;; 	    ;; tuples are now:
;;; 	    ;; [<phdst> <sdist> <name> <gndr> <org> <syl> <str> <phon>
;;; 	    ;; <sem> <pop>]
;;; 	    ;;
;;; 	    
;;; 	    (setq tuples
;;; 	      (mapcar #'(lambda (tuple)
;;; 			  (cons (if phonetic-distance
;;; 				    (phonetic-distance 
;;; 				     (eighth tuple)
;;; 				     root-phon
;;; 				     :mode :custom)
;;; 				  0)
;;; 				tuple))
;;; 		      tuples))
;;; 	    (format t "~%after pdf, Fields should be
;;; [<phdst> <sdist> <name> <gndr> <org> <syl> <str> <phon>
;;; 	    ;; <sem> <pop>]")
;;; 	    (pprint (car tuples))
;;; 	    ;;
;;; 	    ;; filter based on pd
;;; 	    (when phonetic-distance
;;; 	      (setq tuples
;;; 		(sort
;;; 		 (delete-if #'(lambda (tuple)
;;; 			       (> (car tuple) phonetic-distance))
;;; 			    tuples)
;;; 		 #'< :key #'car)))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    (values tuples 
;;; 		    ;; (semgroup tuples)
;;; 		    query
;;; 		    ht)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;; (defun namesearch2 (root &rest keys-and-values
;;; 		   &key (xtp 2)   
;;; 		   &allow-other-keys)
;;;   (destructuring-bind (&key gender origin
;;; 			    syllables stress
;;; 			    decile
;;; 			    begins-letter ends-letter 
;;; 			    !begins-letter !ends-letter
;;; 			    contains-letter !contains-letter
;;; 			    begins-sound ends-sound
;;; 			    !begins-sound !ends-sound
;;; 			    contains-sound !contains-sound
;;; 			    semantic-distance phonetic-distance)
;;;       keys-and-values
;;;     
;;;     ;; various checks
;;;     
;;;     (assert (if (or semantic-distance phonetic-distance)
;;; 		root
;;; 	      t))
;;;     
;;;     ;; if decile comes in as a set, turn into smallest encompassing
;;;     ;; range 
;;;     (when (and (consp decile)
;;; 	       (listp (cdr decile)))
;;;       (flet ((ensure-number (x)
;;; 	       (typecase x
;;; 		 (number x)
;;; 		 (string (parse-integer x)))))
;;; 	(setf decile
;;; 	  (cons (reduce #'min decile :key #'ensure-number)
;;; 		(reduce #'max decile :key #'ensure-number)))))
;;;     
;;;     ;; precompute subqueries
;;;     (let* ((root-sems (and semantic-distance
;;; 			   (mapcar #'car
;;; 				   (dbl :namemybaby "select distinct sem from sem 
;;; where name = '~A'"
;;; 				       root))))
;;; 	   (root-phon (and phonetic-distance
;;; 			   ;; ## ignores cases of gender-specific
;;; 			   ;; pronunciation: Jean vs. Jean
;;; 			   (phon-to-vect
;;; 			    (caar (dbl :namemybaby "select pron from pron
;;; where name = '~A'" root)))))
;;; 	   (minpop (and decile
;;; 			(caar (dbl :namemybaby "select minpop from decile
;;; where decile = '~A'"
;;; 				 (if (consp decile)
;;; 				     (car decile)
;;; 				   decile)))))
;;; 	   (maxpop (and decile
;;; 			(caar (dbl :namemybaby "select maxpop from decile
;;; where decile = '~A'"
;;; 				 (if (consp decile)
;;; 				     (cdr decile)
;;; 				   decile)))))
;;; 
;;; 	   (ht (make-hash-table :test #'eql)))
;;; 
;;;       (labels ((insert (tag fmt &rest values)
;;; 		 (let ((str (apply #'format nil fmt values)))
;;; 		   (push str (gethash tag ht))))
;;; 	       (add-all (tag fmt variable)
;;; 		 (do-canon (i variable)
;;; 		   (insert tag fmt i))))
;;; 	
;;; 	;; gender, etc.
;;; 	(when gender
;;; 	  (add-all :ngender "n.gender = '~A'" gender)
;;; 	  (add-all :pgender "p.gender = '~A'" gender))
;;; 	(when origin
;;; 	  (add-all :origin "n.origin = '~A'" origin))
;;; 	(when syllables
;;; 	  (if (consp syllables)
;;; 	      ;; interval
;;; 	      (insert :syllables "n.syllables >= ~A AND n.syllables <= ~A"
;;; 		      (car syllables) (cdr syllables))
;;; 	    ;; single setting
;;; 	    (add-all :syllables "n.syllables = ~A" syllables)))
;;; 	(when stress
;;; 	  (add-all :stress "n.stresspat = '~A'" stress))
;;; 	
;;; 	(when decile
;;; 	  (insert :decile "n.popularity >= ~A AND n.popularity <= ~A"
;;; 		  minpop maxpop))
;;; 
;;; 	;; orthography
;;; 	(when begins-letter
;;; 	  (add-all :begins-letter "left(n.name,1) = '~A'" begins-letter))
;;; 	(when !begins-letter
;;; 	  (add-all :!begins-letter "left(n.name,1) != '~A'" !begins-letter))
;;; 	(when ends-letter
;;; 	  (add-all :ends-letter "right(n.name,1) = '~A'" ends-letter))
;;; 	(when !ends-letter
;;; 	  (add-all :!ends-letter "right(n.name,1) != '~A'" !ends-letter))
;;; 	(when contains-letter
;;; 	  (add-all :contains-letter "n.name like '%~A%'" contains-letter))
;;; 	(when !contains-letter
;;; 	  (add-all :!contains-letter "n.name not like '%~A%'" !contains-letter))
;;; 	;; phonology/pron
;;; 	;; pron.pron is space separated string of phonemes
;;; 	(let ((left "left(p.pron,locate(' ',p.pron)-1)")
;;; 	      (right "right(p.pron,locate(' ',reverse(p.pron))-1)"))
;;; 	  
;;; 	  (when begins-sound
;;; 	    (add-all :begins-sound 
;;; 		     (format nil "~A = '~~A'" left)
;;; 		     begins-sound))
;;; 	  (when !begins-sound
;;; 	    (add-all :!begins-sound
;;; 		     (format nil "~A != '~~A'" left)
;;; 		     !begins-sound))
;;; 	  (when ends-sound
;;; 	    (add-all :ends-sound
;;; 		     (format nil "~A = '~~A'" right)
;;; 		     ends-sound))
;;; 	  (when !ends-sound
;;; 	    (add-all :!ends-sound
;;; 		     (format nil "~A != '~~A'" right)
;;; 		     !ends-sound))
;;; 	  (when contains-sound
;;; 	    (add-all :contains-sound 
;;; 		     (format nil "concat(' ',~A,' ') ~
;;; like '% ~~A %'" "p.pron")
;;; 		     contains-sound))
;;; 	  (when !contains-sound
;;; 	    (add-all :!contains-sound 
;;; 		     (format nil "concat(' ',~A,' ') ~
;;; not like '% ~~A %'" "p.pron")
;;; 		     !contains-sound)))
;;; 
;;; 	;; distance metrics
;;; 	
;;; 	(let ((query 
;;; 	       (with-output-to-string (s)
;;; 		 (format s
;;; 			 "SELECT distinct n.name,n.gender,n.origin,n.syllables,n.stresspat,
;;; p.pron,s.sem, n.popularity
;;; FROM name n,pron p,sem s
;;; WHERE n.name = p.name
;;; AND s.name = n.name
;;; ")
;;; 		 (maphash #'(lambda (tag clauses)
;;; 			      (let ((negative
;;; 				     (char= (char (symbol-name tag) 0)
;;; 					    #\!)))
;;; 				(fresh-line s)
;;; 				(write-string "AND (" s)
;;; 				(loop for (clause . rest) on clauses by #'cdr
;;; 				    do (write-string clause s)
;;; 				    when rest
;;; 				    do (write-string 
;;; 					(if negative " AND " " OR ") s))
;;; 				(write-char #\) s)))
;;; 			  ht))))
;;; 	  
;;; 	  (let ((tuples (dbl :namemybaby query)))
;;; 	    ;; name gender origin syllables stress pron sem pop
;;; 	    ;; (setq tuples (reorg tuples))
;;; 	    (dolist (tuple tuples)
;;; 	      (setf (sixth tuple)
;;; 		(phon-to-vect (sixth tuple))))
;;; 	    (format t "~%After p2v, tuples should be
;;; name gen orig syl stress phon sem pop")
;;; 	    (pprint (car tuples))
;;; 	    ;;
;;; 	    ;; now tuples are: 
;;; 	    ;; [<name> <gender> <orig> <syl> <stress> <phon> <sem> <pop>]
;;; 	    ;;
;;; 	    ;; semantic distance processing
;;; 	    ;; 
;;; 	    (setq tuples
;;; 	      (mapcar #'(lambda (tuple)
;;; 			  (cons 
;;; 			   (if semantic-distance
;;; 			       (loop for rs in root-sems
;;; 				   minimize (loop for ts in (car tuple)
;;; 						minimize 
;;; 						  (sem-dist rs ts xtp)))
;;; 			     0)
;;; 			   tuple))
;;; 		      tuples))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    ;;
;;; 	    ;; tuples are now:
;;; 	    ;; [<sdist> <name> <gender> <orig> <syl> <str> <phon>
;;; 	    ;; <sem> <pop>]
;;; 	    ;;
;;; 	    (when semantic-distance
;;; 	      (setq tuples 
;;; 		(sort 
;;; 		 (delete-if #'(lambda (tuple)
;;; 			       (> (car tuple) semantic-distance))
;;; 			    tuples)
;;; 		 #'< :key #'car)))
;;; 	    (format t "~%after sem filter, fields should be")
;;; 	    (pprint "[<sdist> <name> <gender> <orig> <syl> <str> <phon>
;;; 	    ;; <sem> <pop>]")
;;; 	    (pprint (car tuples))
;;; 	    ;;
;;; 	    ;; phonetic distance processing
;;; 	    ;;
;;; 	    ;; now add phonetic distance to root
;;; 	    ;;
;;; 	    ;; tuples are now:
;;; 	    ;; [<phdst> <sdist> <name> <gndr> <org> <syl> <str> <phon>
;;; 	    ;; <sem> <pop>]
;;; 	    ;;
;;; 	    
;;; 	    (setq tuples
;;; 	      (mapcar #'(lambda (tuple)
;;; 			  (cons (if phonetic-distance
;;; 				    (phonetic-distance 
;;; 				     (seventh tuple)
;;; 				     root-phon
;;; 				     :mode :custom)
;;; 				  0)
;;; 				tuple))
;;; 		      tuples))
;;; 	    (format t "~%after pdf, Fields should be
;;; [<phdst> <sdist> <name> <gndr> <org> <syl> <str> <phon>
;;; 	    ;; <sem> <pop>]")
;;; 	    (pprint (car tuples))
;;; 	    ;;
;;; 	    ;; filter based on pd
;;; 	    (when phonetic-distance
;;; 	      (setq tuples
;;; 		(sort
;;; 		 (delete-if #'(lambda (tuple)
;;; 			       (> (car tuple) phonetic-distance))
;;; 			    tuples)
;;; 		 #'< :key #'car)))
;;; 	    (format t "~%~D tuples" (length tuples))
;;; 	    (values tuples 
;;; 		    ;; (semgroup tuples)
;;; 		    query
;;; 		    ht)))))))

(defun namesearch3 (root &rest keys-and-values
		    &key (xtp 2)   
		    &allow-other-keys)
  (destructuring-bind (&key gender origin
			    syllables stress
			    decile
			    begins-letter ends-letter 
			    !begins-letter !ends-letter
			    contains-letter !contains-letter
			    begins-sound ends-sound
			    !begins-sound !ends-sound
			    contains-sound !contains-sound
			    semantic-distance phonetic-distance)
      keys-and-values
    
    ;; various checks
    
    #+ignore
    (format t "~%Phonetic was ~S" phonetic-distance)
    (when (and (or (stringp phonetic-distance)
		   (symbolp phonetic-distance))
	       (string-equal phonetic-distance "ALL"))
      (setq phonetic-distance nil))
    #+ignore
    (format t "~%Phonetic now ~A" phonetic-distance)

    (assert (if (or semantic-distance phonetic-distance)
		root
	      t))
    
    ;; if decile comes in as a set, turn into smallest encompassing
    ;; range 
    (when (and (consp decile)
	       (listp (cdr decile)))
      (flet ((ensure-number (x)
	       (typecase x
		 (number x)
		 (string (parse-integer x)))))
	(setf decile
	  (cons (reduce #'min decile :key #'ensure-number)
		(reduce #'max decile :key #'ensure-number)))))
    
    (flet ((mem (item atom-or-list &key (test #'equal))
	     (member item (canon-list atom-or-list)
		     :test test)))

      ;; precompute subqueries
      (let* ((root-sems (and semantic-distance
			     (mapcar #'car
				     (dbl :namemybaby "select distinct sem from sem 
where name = '~A'"
					 root))))
	     (root-phon (and phonetic-distance
			     ;; ## ignores cases of gender-specific
			     ;; pronunciation: Jean vs. Jean
			     (phon-to-vect
			      (caar (dbl :namemybaby "select pron from pron
where name = '~A'" root)))))
	     (minpop/m (and decile
			    (mem "M" gender)
			    (caar (dbl :namemybaby "select minpop from decile
where decile = '~A' and gender='M'"
				      (if (consp decile)
					  (car decile)
					decile)))))
	     (minpop/f (and decile
			    (mem "F" gender)
			    (caar (dbl :namemybaby "select minpop from decile
where decile = '~A' and gender='F'"
				      (if (consp decile)
					  (car decile)
					decile)))))
	     (maxpop/m (and decile
			    (mem "M" gender)
			    (caar (dbl :namemybaby "select maxpop from decile
where decile = '~A' and gender='M'"
				      (if (consp decile)
					  (cdr decile)
					decile)))))
	     (maxpop/f (and decile
			    (mem "F" gender)
			    (caar (dbl :namemybaby "select maxpop from decile
where decile = '~A' and gender='F'"
				      (if (consp decile)
					  (cdr decile)
					decile)))))

	     (ht (make-hash-table :test #'eql)))

	#+ignore
	(format t "~%Root-phon is ~A" root-phon)

	(labels ((insert (tag fmt &rest values)
		   (let ((str (apply #'format nil fmt values)))
		     (push str (gethash tag ht))))
		 (add-all (tag fmt variable)
		   (do-canon (i variable)
		     (insert tag fmt i))))
	
	  ;; gender, etc.
	  (when gender
	    (add-all :ngender "n.gender = '~A'" gender)
	    (add-all :pgender "p.gender = '~A'" gender))
	  (when origin
	    (add-all :origin "n.origin = '~A'" origin))
	  (when syllables
	    (if (consp syllables)
		;; interval
		(insert :syllables "n.syllables >= ~A AND n.syllables <= ~A"
			(car syllables) (cdr syllables))
	      ;; single setting
	      (add-all :syllables "n.syllables = ~A" syllables)))
	  (when stress
	    (add-all :stress "n.stresspat = '~A'" stress))
	
	  (when decile
	    (when (mem "M" gender)
	      ;; This formulation is tricky
	      ;; Read it like this:
	      ;; either n.gender is F or M
	      ;; if it is F, ignore the rest
	      ;; if it is not F, then it must be M
	      ;; and you must match the male popularity ranges
	      (insert :decile/male
		      "n.gender = 'F' OR (n.popularity >= ~A AND n.popularity <= ~A)"
		      minpop/m maxpop/m))
	    (when (mem "F" gender)
	      (insert :decile/female
		      "n.gender = 'M' OR (n.popularity >= ~A AND n.popularity <= ~A)"
		      minpop/f maxpop/f)))

	  ;; orthography
	  (when begins-letter
	    (add-all :begins-letter "left(n.name,1) = '~A'" begins-letter))
	  (when !begins-letter
	    (add-all :!begins-letter "left(n.name,1) != '~A'" !begins-letter))
	  (when ends-letter
	    (add-all :ends-letter "right(n.name,1) = '~A'" ends-letter))
	  (when !ends-letter
	    (add-all :!ends-letter "right(n.name,1) != '~A'" !ends-letter))
	  (when contains-letter
	    (add-all :contains-letter "n.name like '%~A%'" contains-letter))
	  (when !contains-letter
	    (add-all :!contains-letter "n.name not like '%~A%'" !contains-letter))
	  ;; phonology/pron
	  ;; pron.pron is space separated string of phonemes
	  (let ((left "left(p.pron,locate(' ',p.pron)-1)")
		(right "right(p.pron,locate(' ',reverse(p.pron))-1)"))
	  
	    (when begins-sound
	      (add-all :begins-sound 
		       (format nil "~A = '~~A'" left)
		       begins-sound))
	    (when !begins-sound
	      (add-all :!begins-sound
		       (format nil "~A != '~~A'" left)
		       !begins-sound))
	    (when ends-sound
	      (add-all :ends-sound
		       (format nil "~A = '~~A'" right)
		       ends-sound))
	    (when !ends-sound
	      (add-all :!ends-sound
		       (format nil "~A != '~~A'" right)
		       !ends-sound))
	    (when contains-sound
	      (add-all :contains-sound 
		       (format nil "concat(' ',~A,' ') ~
like '% ~~A %'" "p.pron")
		       contains-sound))
	    (when !contains-sound
	      (add-all :!contains-sound 
		       (format nil "concat(' ',~A,' ') ~
not like '% ~~A %'" "p.pron")
		       !contains-sound)))

	  ;; distance metrics
	
	  (let ((query 
		 (with-output-to-string (s)
		   (format s
			   "SELECT distinct n.name,n.gender,n.origin,n.syllables,n.stresspat,
p.pron,s.sem, n.popularity
FROM name n,pron p,sem s
WHERE n.name = p.name
AND s.name = n.name
")
		   (maphash #'(lambda (tag clauses)
				(let ((negative
				       (char= (char (symbol-name tag) 0)
					      #\!)))
				  (fresh-line s)
				  (write-string "AND (" s)
				  (loop for (clause . rest) on clauses by #'cdr
				      do (write-string clause s)
				      when rest
				      do (write-string 
					  (if negative " AND " " OR ") s))
				  (write-char #\) s)))
			    ht))))
	  
	    (let ((tuples (dbl :namemybaby query)))
	      ;; name gender origin syllables stress pron sem pop
	      ;; (setq tuples (reorg tuples))
	      (dolist (tuple tuples)
		(setf (sixth tuple)
		  (phon-to-vect (sixth tuple))))
	      #+ignore
	      (format t "~%After p2v, tuples should be
name gen orig syl stress phon sem pop")
	      (pprint (car tuples))
	      ;;
	      ;; now tuples are: 
	      ;; [<name> <gender> <orig> <syl> <stress> <phon> <sem> <pop>]
	      ;;
	      ;; semantic distance processing
	      ;; 
	      (setq tuples
		(mapcar #'(lambda (tuple)
			    (cons 
			     (if semantic-distance
				 (loop for rs in root-sems
				     minimize (loop for ts in (car tuple)
						  minimize 
						    (sem-dist rs ts xtp)))
			       0)
			     tuple))
			tuples))
	      #+ignore
	      (format t "~%~D tuples 1" (length tuples))
	      ;;
	      ;; tuples are now:
	      ;; [<sdist> <name> <gender> <orig> <syl> <str> <phon>
	      ;; <sem> <pop>]
	      ;;
	      (when semantic-distance
		#+ignore
		(format t "~%Applying semantic distance test")
		(setq tuples 
		  (sort 
		   (delete-if #'(lambda (tuple)
				  (> (car tuple) semantic-distance))
			      tuples)
		   #'< :key #'car)))
	      #+ignore
	      (format t "~%~D tuples 2" (length tuples))
	      #+ignore
	      (format t "~%after sem filter, fields should be")
	      #+ignore
	      (pprint "[<sdist> <name> <gender> <orig> <syl> <str> <phon>
	    ;; <sem> <pop>]")
	      ;;
	      ;; phonetic distance processing
	      ;;
	      ;; now add phonetic distance to root
	      ;;
	      ;; tuples are now:
	      ;; [<phdst> <sdist> <name> <gndr> <org> <syl> <str> <phon>
	      ;; <sem> <pop>]
	      ;;
	    
	      (setq tuples
		(mapcar #'(lambda (tuple)
			    (cons (if phonetic-distance
				      (phonetic-distance 
				       (seventh tuple)
				       root-phon
				       :mode :custom)
				    0)
				  tuple))
			tuples))
	      #+ignore
	      (format t "~%~D tuples 3" (length tuples))
	      #+ignore
	      (format t "~%after pdf, Fields should be
[<phdst> <sdist> <name> <gndr> <org> <syl> <str> <phon>
	    ;; <sem> <pop>]")

	      ;;
	      ;; filter based on pd
	      (when phonetic-distance
		#+ignore
		(format t "~%Applying phonetic distance test: ~A" phonetic-distance)
		(setq tuples
		  (sort
		   (delete-if #'(lambda (tuple)
				  (> (car tuple) phonetic-distance))
			      tuples)
		   #'< :key #'car)))
	      #+ignore
	      (format t "~%~D tuples 4" (length tuples))
	      (values tuples 
		      ;; (semgroup tuples)
		      query
		      ht))))))))
