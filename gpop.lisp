;;; -*- Mode:Lisp; Syntax:Common-lisp; Package:NAMEMYBABY; Base:10 -*-

(in-package :namemybaby)

(eval-when (compile load eval)
  (require :googlesoap)
  (use-package :googlesoap))

(eval-when (compile load eval)
  (require :listutil)
  (use-package :listutil))

(eval-when (compile load eval)
  (require :mail)
  (use-package :mail))

(defun gpop-one (name)
  (let ((count (google-search-count name)))
    (when count
      (dbl :namemybaby 
	   "insert into gpop values('~A',~D)"
	   (canon-atom name)
	   (canon-atom count))
      count)))

(defun gpop-range (start end)
  (let ((all (coerce (dbl :namemybaby 
			  "select distinct name from name
order by name")
		     'vector)))
    (loop for i from start below end
	as name = (aref all i)
	do (gpop-one name))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defvar *surnames* 
    '#2A((SMITH          1.006  1.006      1)
	 (JOHNSON        0.810  1.816      2)
	 (WILLIAMS       0.699  2.515      3)
	 (JONES          0.621  3.136      4)
	 (BROWN          0.621  3.757      5)
	 (DAVIS          0.480  4.237      6)
	 (MILLER         0.424  4.660      7)
	 (WILSON         0.339  5.000      8)
	 (MOORE          0.312  5.312      9)
	 (TAYLOR         0.311  5.623     10)
	 (ANDERSON       0.311  5.934     11)
	 (THOMAS         0.311  6.245     12)
	 (JACKSON        0.310  6.554     13)
	 (WHITE          0.279  6.834     14)
	 (HARRIS         0.275  7.109     15)
	 (MARTIN         0.273  7.382     16)
	 (THOMPSON       0.269  7.651     17)
	 (GARCIA         0.254  7.905     18)
	 (MARTINEZ       0.234  8.140     19)
	 (ROBINSON       0.233  8.372     20)
	 (CLARK          0.231  8.603     21)
	 (RODRIGUEZ      0.229  8.832     22)
	 (LEWIS          0.226  9.058     23)
	 (LEE            0.220  9.278     24)
	 (WALKER         0.219  9.497     25)
	 (HALL           0.200  9.698     26)
	 (ALLEN          0.199  9.897     27)
	 (YOUNG          0.193 10.090     28)
	 (HERNANDEZ      0.192 10.282     29)
	 (KING           0.190 10.472     30)))

(defun gpop-one-with-surnames (j name &key (limit 30))
  (format t "~%~D. ~A" j name)
  (loop for i from 0 below limit
      as surname = (aref *surnames* i 0)
      do (let ((count (google-search-count (format nil "\"~A ~A\""
						   (canon-atom name)
						   surname))))
	   (when count
	     (dbl :namemybaby 
		  "insert into gpopsurname values('~A','~A',~D)"
		  (canon-atom name)
		  (canon-atom surname)
		  (canon-atom count))
	     count))))

(defun gpop-surname-range (start end surname-limit)
  (let ((all (coerce (dbl :namemybaby 
			  "select distinct name from name
order by name")
		     'vector)))
    (loop for i from start below end
	as name = (canon-atom (aref all i))
	do (gpop-one-with-surnames i name :limit surname-limit))))

(defun gpop-surname-inf (start sleep)
  (let ((all (coerce (dbl :namemybaby 
			  "select distinct name from name
order by name")
		     'vector)))
    (loop for i from start
	as name = (canon-atom (aref all i))
	do (gpop-one-with-surnames i name)
	do (sleep sleep))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; use ISI google key

(defvar *verbose* t)

(defvar *given-names* 
    (coerce 
     (sort (union 
	    (mapcar #'car (dbl :namemybaby 
			       "select distinct name from name
order by name"))
	    (mapcar #'car (dbl :namemybaby
			       "select distinct name from name_from_ethnic
order by name"))
	    :test #'string-equal)
	   #'string-lessp)
     'vector))

;;; Approximately 5100 names
;;; Pair each with each of 30 last names
;;; as well as individually.  Will require 151800 google hits!

(defun make-google-search-key (given-name surname)
  (format nil "\"~A~@[ ~A~]\""
	  given-name
	  surname))

(defun try-google-count (given-name surname
			 &key (repeat 5) (wait 0)
			      (keyfile googlesoap::*google-keyfile*)
			      (countfile googlesoap::*google-countfile*)
			      (limit googlesoap::*google-limit*)
			      (on-error :mail-and-error))
  (let* ((key (make-google-search-key given-name surname))
	 (j 1)
	 (answer
	  (loop as k = (ignore-errors 
			(google-search-count key :keyfile keyfile
					     :countfile countfile
					     :limit limit))
	      repeat repeat
	      when k do (return k)
	      do (incf j)		  
	      do (write-char #\.)
	      do (sleep wait))))
    (if answer
	(progn
	  (dbl :namemybaby 
	       "insert into gpopsurname values('~A',~A,~D)"
	       (canon-atom given-name)
	       (if (null surname)
		   "null"
		 (format nil "'~A'" (canon-atom surname)))
	       (canon-atom answer))
	  (values answer t))
      (progn
	(case on-error
	  (:mail-and-error
	   (send-mail "philpot@isi.edu" 
		      (format nil "NMB failed on/after attempt ~D on query ~A ~A" 
			      j given-name surname))
	   (error "waiting")))))))
    
(defun google-harvest-counts 
    (index &key (keyfile googlesoap::*google-keyfile*)
		(countfile googlesoap::*google-countfile*)
		(limit googlesoap::*google-limit*)
		(verbose *verbose*)
		(wait 0))
  (let ((given-name (aref *given-names* index)))
    (when verbose
      (format t "~%~D. ~A" index given-name))
    (try-google-count (string-downcase given-name) nil
		      :keyfile keyfile
		      :countfile countfile
		      :limit limit)
    (sleep wait)
    (loop for s from 0 below 30
	as surname = (aref *surnames* s 0)
	do (try-google-count given-name surname
			     :keyfile keyfile
			     :countfile countfile
			     :limit limit)
	do (sleep wait))))

(defun google-harvest-all (start &key (keyfile "~/.googlekey.isi")
				      (limit 20000)
				      (end most-positive-fixnum))
  (loop for i from start below (length *given-names*)
      repeat end
      do (google-harvest-counts i :keyfile keyfile :limit limit)))
