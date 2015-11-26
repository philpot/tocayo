(in-package :namemybaby)

(eval-when (compile load eval)
  (require :aserve)
  (require :webactions)
  (use-package :net.aserve)
  (use-package :net.html.generator))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.www.server.allegroserve.webactionsutil)
  (use-package :edu.isi.isd.nlp.appl.www.server.allegroserve.webactionsutil))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.lang.control.caseutil)
  (use-package :edu.isi.isd.nlp.lang.control.caseutil))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.adt.list.listutil)
  (use-package :edu.isi.isd.nlp.adt.list.listutil))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.www.server.allegroserve.allegroserveutil))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.www.wwwutil.htmlencode)
  (use-package :edu.isi.isd.nlp.appl.www.wwwutil.htmlencode))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.adt.file.csv.philpot)
  (use-package :edu.isi.isd.nlp.adt.file.csv.philpot))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.appl.db.dbl)
  (use-package :edu.isi.isd.nlp.appl.db.dbl))

(eval-when (load eval)
  (setf edu.isi.isd.nlp.appl.db.dbl::*host* "blombos"))

(eval-when (compile load eval)
  (require :edu.isi.isd.nlp.adt.operator.memo)
  (use-package :edu.isi.isd.nlp.adt.operator.memo))

(defvar *port* 9900)

(eval-when (load eval)
  (net.aserve::start :port *port*))

(publish :path "/andrewdata"
  :content-type "text/plain"
  :function #'(lambda (req ent)
		(with-http-response (req ent)
		  (warn "Inside /andrewdata")
		(push (websession-variable
		       (websession-from-req req)
		       "DATA")
		      reqs)
		(push (prin1-to-string *html-stream*) reqs)
		(nmb_writecolumns_fn req)
		(nmb_writecsv_fn req))))

(defparameter *dummy* NIL)

(publish :path "/dummydata"
  :content-type "text/plain"
  :function #'(lambda (req ent)
		(with-http-response (req ent :content-type "text/csv")
		  (with-http-body (req ent)
		    (warn "Inside /dummydata")
		    (push (websession-variable
			   (websession-from-req req)
			   "DATA")
			  *dummy*)
		    (push (prin1-to-string *html-stream*) reqs)
		    (nmb_writecolumns_fn req)
		    (nmb_writecsv_fn req)))))

(publish :path "/dummydata.csv"
  :content-type "text/plain"
  :function #'(lambda (req ent)
		(with-http-response (req ent :content-type "application/vnd.ms-excel")
		  (with-http-body (req ent)
		    (warn "Inside /dummydata.csv")
		    (push (websession-variable
			   (websession-from-req req)
			   "DATA")
			  *dummy*)
		    (html
		     (:html
		      (:body
		       (:table
			   (:tr
			    (:td "ABC")
			    (:td "DEF"))
			 (:tr
			  (:td "123")
			  (:td "456"))))))))))

(publish :path "/excel.aserve"
  :content-type "application/vnd.ms-excel"
  :function
  #'(lambda (req ent)
      (with-http-response (req ent 
			       :content-type "application/vnd.ms-excel")
	(with-http-body (req ent)
	  (let ((data (websession-variable
		       (websession-from-req req)
		       "DATA")))
	    (html
	     (:html
	      (:body
	       (:table
		   (:tr
		    (:th "Phonetic" :br "Distance")
		    (:th "Semantic" :br "Distance")
		    (:th "Name")
		    (:th "Gender")
		    (:th "Origin")
		    (:th "Syllables")
		    (:th "Stress")
		    (:th "Pronunciation")
		    (:th "Meaning")
		    (:th "Popularity"))
		 (loop for line in data
		     as readable = (list
				    (first line)
				    (second line)
				    (third line)
				    (case-equal (fourth line)
				      ("M" "boy")
				      ("F" "girl"))
				    (gethash (fifth line) *origins-map*)
				    (sixth line)
				    (gethash (seventh line) *stresses-map*)
				    (format nil "~{~A~^ ~}" (coerce (eighth line) 'list))
				    (ninth line)
				    (tenth line))
		     do (html 
			 (:tr
			  (dolist (field readable)
			    (html (:td (:princ-safe field))))))))))))))
      :all-done))

#+ignore
(publish :path "/csv.aserve"
  :content-type "text/plain"
  :function
  #'(lambda (req ent)
      (print :inside-csv.aserve)
      (with-http-response (req ent :content-type "text/plain")
	(with-http-body (req ent)
	  (let ((data (websession-variable
		       (websession-from-req req)
		       "DATA")))
	    (unless data
	      (setq data '((1 2 3)
			   ("a" "b" "c")
			   ("e" "f" "g"))))
	    (write-csv-file-line
	     *html-stream*
	     (list "Phonetic_Distance"
		   "Semantic_Distance"
		   "Name"
		   "Gender"
		   "Origin"
		   "Syllables"
		   "Stress"
		   "Pronunciation"
		   "Meaning"
		   "Popularity"))
	    (loop for line in data
		as readable = (list
			       (first line)
			       (second line)
			       (third line)
			       (case-equal (fourth line)
				 ("M" "boy")
				 ("F" "girl"))
			       (gethash (fifth line) *origins-map*)
			       (sixth line)
			       (gethash (seventh line) *stresses-map*)
			       (format nil "~{~A~^ ~}" 
				       (coerce (eighth line) 'list))
			       (ninth line)
			       (tenth line))
		do (write-csv-file-line
		    *html-stream*
		    readable)))))))

(publish :path "/csv.aserve"
  :content-type "text/plain"
  :function
  #'(lambda (req ent)
      (print :inside-csv.aserve)
      (with-http-response (req ent :content-type "text/plain")
	(with-http-body (req ent)
	  (let ((data (websession-variable
		       (websession-from-req req)
		       "DATA")))
	    (unless data
	      (setq data '((1 2 3)
			   ("a" "b" "c")
			   ("e" "f" "g"))))
	    (format *html-stream* "~&~{~S~^,~}"
		    (list "Phonetic_Distance"
			  "Semantic_Distance"
			  "Name"
			  "Gender"
			  "Origin"
			  "Syllables"
			  "Stress"
			  "Pronunciation"
			  "Meaning"
			  "Popularity"))
	    (loop for line in data
		as readable = (list
			       (first line)
			       (second line)
			       (third line)
			       (case-equal (fourth line)
				 ("M" "boy")
				 ("F" "girl"))
			       (gethash (fifth line) *origins-map*)
			       (sixth line)
			       (gethash (seventh line) *stresses-map*)
			       (format nil "~{~A~^ ~}" 
				       (coerce (eighth line) 'list))
			       (ninth line)
			       (tenth line))
		do (format *html-stream*
			   "~&;~{~S~^,~}"
			   readable)))))))

(defparameter *project*
    (webaction-project "namemybaby"
	:destination "/nfs/isd3/philpot/lisp/system/namemybaby/site/"
	:index "home"
	:clp-suffixes '("clp" #+ignore "csv")
	:map
	'(("test" "test.clp")
		     
	  ("home" action-check-login action-reinit "realhome")
	  ("restart" action-reinit "realhome")
	  ("login" "login.clp")
	  ("gotlogin" action-got-login)
	  ("realhome" "realhome.clp")
	  ("switch" action-record (:redirect t))
	  ;; semi-static
	  ("spelling" action-check-login "spelling.clp")
	  ("syllables" action-check-login "syllables.clp")
	  ("sound" action-check-login "sound.clp")
	  ("origin" action-check-login "origin.clp")
	  ("popularity" action-check-login "popularity.clp")
	  ("misc" action-check-login "misc.clp")
	  ("config" action-check-login "config.clp")
	  ("gender" action-check-login "gender.clp")
	  ("meaning" action-check-login "meaning.clp")
	  ("bobo" action-check-login "bobo.clp")
	  ;;
	  ;; ("lookup" action-check-login action-retrieve "lookup.clp")
	  ("lookup" action-check-login action-retrieve "lookup_list.clp")
	  ("save" action-check-login action-retrieve "save.clp"
	   (:redirect t))
	  ;; ("writecsv" action-check-login action-retrieve "writecsv")
	  ;; ("writecsv" action-check-login action-retrieve "csvfile.clp")
	  ;; ("csvfile.clp" (:content-type "text/comma-separated-values"))
	  ;; ("csvfile.clp" (:content-type "application/vnd.ms-excel"))

	  ("writecsv" action-check-login action-retrieve "csvfile.csv")
	  ("csvfile.csv" (:content-type "application/vnd.ms-excel"))
	  
	  ("postscript" "postscript.ps")
	  ("postscript.ps" (:content-type "application/postscript"))
	  
	  ("showdata" action-check-login action-retrieve "/dummydata.csv")
	  ("dummy" "/dummydata.csv")
	  
	  ;; this one worked correctly once
	  ("excel2" "/excel.aserve")
	  ("excel3" "excel3.clp"
	   (:content-type "application/vnd.ms-excel"))
	  ("excel4" "excel4.xls"
	   (:content-type "application/vnd.ms-excel"))
	  
	  ;; I think this one worked best
	  ("csvfile.csv" (:content-type "application/vnd.ms-excel"))
	  ("csvfile2.csv" (:content-type "application/vnd.ms-excel"))
	  ("csvfile3.csv" (:content-type "text/plain"))
	  
	  ;; This works, but only when
	  ;; (1) first, you have selected some criteria, done lookup
	  ;; (2) second, it's the first time in that session of
	  ;; Explorer (i.e., it's cached)
	  ;; ("excel2" "/excel.aserve")
	  ("excel" "/excel.aserve")
	  ("csv" "/csv.aserve")

	  ("try" action-check-login action-retrieve)
	  ;; 
	  ("play" "play.clp")
	  ("reorder" action-reorder)
	  ("dump" "dump.clp")
	  ("sembrowse" "sembrowse.clp")
		     
	  ;; ("showall" action-showall "lookup")
	  ;; ("hide" action-hide "lookup")

	  ("test" "testgraphics.html")
	  ("panel" "panel.clp")
	  ;;
	  ("detail" "detail.clp")
	  )
	)
  )

(defun action-check-login (req ent)
  (declare (ignore ent))
  (let ((session (websession-from-req req)))
    (let ((user (websession-variable session "USERNAME")))
      (if user 
	  :continue 
	"login"))))

(defun action-got-login (req ent)
  (declare (ignore ent))
  (let ((username (request-query-value "USERNAME" req)))
    (if (and username (> (length username) 0))
	(progn
	  (setf (websession-variable (websession-from-req req)
				     "USERNAME")
	    username)
	  "realhome")
      "login")))

(defun action-reinit (req ent) 
  (declare (ignore ent))
  (let ((ws (websession-from-req req)))
    (flet ((reinit (name &optional value)
	     (setf (websession-variable ws name) value)))
      ;; spelling
      (reinit "BEG1VWL")
      (reinit "BEG1CST")
      (reinit "CNT1VWL")
      (reinit "CNT1CST")
      (reinit "END1VWL")
      (reinit "END1CST")
      (reinit "BEG0VWL")
      (reinit "BEG0CST")
      (reinit "CNT0VWL")
      (reinit "CNT0CST")
      (reinit "END0VWL")
      (reinit "END0CST")
      ;; syllables
      (reinit "MINSYL" "1")
      (reinit "MAXSYL" "5")
      ;; stress
      (reinit "STRESS" "1:S1")
      (reinit "STRESS" "2:S10")
      (reinit "STRESS" "2:S01")
      (reinit "STRESS" "2:S11")
      (reinit "STRESS" "3:S100")
      (reinit "STRESS" "3:S010")
      (reinit "STRESS" "3:S001")
      (reinit "STRESS" "4:S1000")
      (reinit "STRESS" "4:S0100")
      (reinit "STRESS" "4:S0010")
      (reinit "STRESS" "5:S00100")
      ;; sound
      (reinit "BEG1SND")
      (reinit "CNT1SND")
      (reinit "END1SND")
      (reinit "BEG0SND")
      (reinit "CNT0SND")
      (reinit "END0SND")
      (reinit "SNDSRCHROOT")
      (reinit "SNDSRCHLIMIT" "ALL")
      ;; meaning
      (reinit "SEMSRCHROOT")
      (reinit "SEMSRCHLIMIT" "ALL")
      ;; origin
      (reinit "ORIGIN" "A1")
      (reinit "ORIGIN" "A2")
      (reinit "ORIGIN" "AR")
      (reinit "ORIGIN" "HY")
      (reinit "ORIGIN" "KM")
      (reinit "ORIGIN" "ZH")
      (reinit "ORIGIN" "NL")
      (reinit "ORIGIN" "EN")
      (reinit "ORIGIN" "FA")
      (reinit "ORIGIN" "FR")
      (reinit "ORIGIN" "G1")
      (reinit "ORIGIN" "DE")
      (reinit "ORIGIN" "EL")
      (reinit "ORIGIN" "H1")
      (reinit "ORIGIN" "HE")
      (reinit "ORIGIN" "HI")
      (reinit "ORIGIN" "HU")
      (reinit "ORIGIN" "IT")
      (reinit "ORIGIN" "JA")
      (reinit "ORIGIN" "LA")
      (reinit "ORIGIN" "PL")
      (reinit "ORIGIN" "PT")
      (reinit "ORIGIN" "RU")
      (reinit "ORIGIN" "S1")
      (reinit "ORIGIN" "S2")
      (reinit "ORIGIN" "ES")
      (reinit "ORIGIN" "SW")
      (reinit "ORIGIN" "TR")
      (reinit "ORIGIN" "VI")
      (reinit "ORIGIN" "S1")
      ;; but then remove all
      (reinit "ORIGIN")
      ;; popularity 
      (reinit "POP")
      ;; config
      (reinit "MODE" "USER")
      ;; gender
      (reinit "GENDER" "M")
      (reinit "GENDER" "F")
      ;; show/fold/sort
      (reinit "SHOW_PHONDIST" "T")
      (reinit "SORT_PHONDIST" "ASC")
      (reinit "FOLD_PHONDIST")
      
      (reinit "SHOW_SEMDIST")
      (reinit "SORT_SEMDIST" "ASC")
      (reinit "FOLD_SEMDIST")

      (reinit "SHOW_NAME" "T")
      (reinit "SORT_NAME" "ASC")
      (reinit "FOLD_NAME")

      (reinit "SHOW_GENDER" "T")
      (reinit "SORT_GENDER" "ASC")
      (reinit "FOLD_GENDER")

      (reinit "SHOW_ORIGIN" "T")
      (reinit "SORT_ORIGIN" "ASC")
      (reinit "FOLD_ORIGIN")

      (reinit "SHOW_SYLLABLES" "T")
      (reinit "SORT_SYLLABLES" "ASC")
      (reinit "FOLD_SYLLABLES")

      (reinit "SHOW_STRESS" "T")
      (reinit "SORT_STRESS" "ASC")
      (reinit "FOLD_STRESS")

      (reinit "SHOW_PRON")
      (reinit "SORT_PRON" "ASC")
      (reinit "FOLD_PRON")

      (reinit "SHOW_MEANING" "T")
      (reinit "SORT_MEANING" "ASC")
      (reinit "FOLD_MEANING")

      (reinit "SHOW_POPULARITY" "T")
      (reinit "SORT_POPULARITY" "ASC")
      (reinit "FOLD_POPULARITY")

      :continue)))

(defun action-showall (req ent) 
  (declare (ignore ent))
  (let ((ws (websession-from-req req)))
    (flet ((show (name value)
	     (setf (websession-variable ws name) value)))
      ;; show/fold/sort
      (show "SHOW_PHONDIST" "T")
      (show "SHOW_SEMDIST" "T")
      (show "SHOW_NAME" "T")
      (show "SHOW_GENDER" "T")
      (show "SHOW_ORIGIN" "T")
      (show "SHOW_SYLLABLES" "T")
      (show "SHOW_STRESS" "T")
      (show "SHOW_PRON" "T")
      (show "SHOW_MEANING" "T")
      (show "SHOW_POPULARITY" "T")

      :continue)))

(defun action-hide (req ent) 
  (declare (ignore ent))
  (let ((column (request-query-value "column" req)))
    (setf (websession-variable 
	   (websession-from-req req)
	   (format nil "SHOW_~:(~A~)" column))
      nil)))

(defvar www)
(defvar rrr)
(defvar eee)

(defun maybe-record (req variables &key (clear t))
  (let ((ws (websession-from-req req)))
    ;; (setq www ws rrr req)
    (when clear
      (loop for variable in variables
	  do (setf (websession-variable ws variable) nil)))
    (loop for (variable . value)
	in (request-query req)
	when (member variable variables :test #'string-equal)
	do (push value
		 (websession-variable ws variable)))))

(defun action-record (req ent) 
  (declare (ignore ent))
  (let ((src (request-query-value "SRC" req))
	(dest (request-query-value "DEST" req)))
    (case-equal src
      ("spelling"
       (maybe-record req '("BEG1VWL" "BEG1CST"
			   "CNT1VWL" "CNT1CST"
			   "END1VWL" "END1CST"
			   "BEG0VWL" "BEG0CST"
			   "CNT0VWL" "CNT0CST"
			   "END0VWL" "END0CST")))
      ("syllables"
       (maybe-record req '("MINSYL" "MAXSYL" "STRESS")))
      ("sound"
       (maybe-record req '("BEG1SND" "CNT1SND" "END1SND"
			   "BEG0SND" "CNT0SND" "END0SND"
			   "SNDSRCHLIMIT" "SNDSRCHROOT")))
      ("origin"
       (maybe-record req '("ORIGIN")))
      ("popularity"
       (maybe-record req '("POP")))
      ("gender"
       (maybe-record req '("GENDER")))
      ("config"
       (maybe-record req '("MODE")))
      ("meaning")
      ("bobo")
      ("save"))

    dest))

(defun member-string-equal (item list)
  (member item list :test #'string-equal))

(defun wsv (ws n) (websession-variable ws n))

(def-clp-function clp_ifmember (req ent args body)
  (clp_ifmember_fn req ent args body))

(defun clp_ifmember_fn (req ent args body)
  (let ((name (cdr (assoc "name" args :test #'string-equal)))
	(value (cdr (assoc "value" args :test #'string-equal)))
	(session (cdr (assoc "session" args :test #'string-equal))))
    ;; most likely one would want to be able to access QUERY or
    ;; REQUEST as well. NIY
    (when (and session
	       (let* ((ws (websession-from-req req))
		      (valueset (canon-list (wsv ws name))))
		 (member-string-equal value valueset)))
      (emit-clp-entity req ent body))))

(def-clp-function clp_firstvalue (req ent args body)
  (clp_firstvalue_fn req ent args body))

(defun clp_firstvalue_fn (req ent args body)
  (declare (ignore body))
  (let ((name (cdr (assoc "name" args :test #'string-equal)))
	(session (cdr (assoc "session" args :test #'string-equal))))
    ;; most likely one would want to be able to access QUERY or
    ;; REQUEST as well. NIY
    (when session
      (let* ((ws (websession-from-req req))
	     (valueset (websession-variable ws name))
	     (firstvalue (canon-atom valueset)))
	#+ignore (format t "~%Firstvalue: firstvalue=~S" firstvalue)
	(when firstvalue
	  (emit-clp-entity req ent `((:text ,firstvalue))))))))

(def-clp-function clp_add (req ent args body)
  (clp_add_fn req ent args body))

(defun clp_add_fn (req ent args body)
  (declare (ignore body ent))
  (let ((name (cdr (assoc "name" args :test #'string-equal)))
	(value (cdr (assoc "value" args :test #'string-equal)))
	(session (cdr (assoc "session" args :test #'string-equal))))
    ;; most likely one would want to be able to access QUERY or
    ;; REQUEST as well. NIY
    (when session
      (let* ((ws (websession-from-req req))
	     (current (websession-variable ws name)))
	(cond ((listp current)
	       (pushnew value (websession-variable ws name)
			:test #'equal))
	      (t (setf (websession-variable ws name)
		   (adjoin value (list current)
			   :test #'equal))))))))

(defparameter *all-types*
    '("spelling" "syllables" "sound" "origin" "popularity"
      "gender" "meaning" "config" "lookup" "save"
      ;; 
      "bobo" "sembrowse" "detail"))

(def-clp-function nmb_choose_type (req ent args body)
  (setq rrr req eee ent)
  (nmb_choose_type_fn req ent args body))

(defun nmb_choose_type_fn (req ent args body)
  (declare (ignore body ent))
  (let ((chosen-type (cdr (assoc "type" args :test #'string-equal)))
	(session (cdr (assoc "session" args :test #'string-equal))))
    (assert (and chosen-type session
		 (member chosen-type *all-types*
			 :test #'equal)))
    (let ((ws (websession-from-req req)))
      (setf (websession-variable ws "type") chosen-type)
      (setf (websession-variable ws (format nil "~A_class" chosen-type))
	"tabnormal")
      (loop for unchosen-type in *all-types*
	  unless (equal unchosen-type chosen-type)
	  do (setf (websession-variable ws 
					(format nil "~A_class" unchosen-type))
	       "tabdark")))))

(def-clp-function nmb_dump_all_vars (req ent args body)
  (html
   (:small
    ((:table :border 1)
     (:tr
      ((:td :colspan 2)
       (:b "Request")))
     (loop for (k . v)
	 in (request-query req)
	 do (html
	     (:tr
	      (:td (:princ k))
	      (:td (:princ v)))))
     (:tr
      ((:td :colspan 2)
       (:b "Session")))
          (:tr
      (:td (with-output-to-string (s)
	     (describe req s))))
     (loop for (k . v)
	 in (net.aserve::websession-variables 
	     (websession-from-req req))
	 when v
	 do (html
	     (:tr
	      (:td (:princ k))
	      (:td (:princ v)))))))))

(defparameter *syllable-options*
    '((1 "S" "1 Syllable: 'Ruth,George'")
      (2 "S10" "2 Syllables, Stress on first syllable: 'BILLy,SADie'")
      (2 "S01" "2 Syllables, Stress on second syllable: 'maRIE,laMAR'")
      (2 "S11" "2 Syllables, Stress on both: 'MATTHEW,ROXANNE'")
      (3 "S100" "3 Syllables, Stress on first syllable: 'EMily,ROmeo'")
      (3 "S010" "3 Syllables, Stress on second syllable: 'beLINda,franCISco'")
      (3 "S001" "3 Syllables, Stress on third syllable: 'raphaEL,gabriELLE'")
      (4 "S1000" "4 Syllables, Stress on first syllable: 'BONaventure'")
      (4 "S0100" "4 Syllables, Stress on second syllable: 'eLIZabeth,barTHOLomew'")
      (4 "S0010" "4 Syllables, Stress on third syllable: 'alexANDer,liliANa'")  
      (5 "S00100" "5 Syllables, Stress on third syllable: 'anaSTASia,desiDERio'")))

(def-clp-function nmb_syllableselect (req ent args body)
  (nmb_syllableselect_fn req ent args body))

(defun nmb_syllableselect_fn (req ent args body)
  (declare (ignore ent body args))
  (flet ((intarg (loc)
	   (parse-integer
	    (canon-atom loc))))
    (let* ((ws (websession-from-req req))
	   (minsyl (intarg (websession-variable ws "MINSYL")))
	   (maxsyl (intarg (websession-variable ws "MAXSYL")))
	   (selected-options (websession-variable ws "STRESS")))
      (html
       ((:select :multiple :||
		 :name "STRESS"
		 :size "11")
	(loop for (count stress blurb) 
	    in *syllable-options*
	    as id = (format nil "~A:~A" count stress)
	    do (html :newline)
	    when (and (>= count minsyl)
		      (<= count maxsyl))
	    do (html 
		((:option :value id
			  :if* (member id selected-options
				       :test #'string-equal)
			  :selected :||)
		  (:princ blurb)))))))))

(eval-when (load eval)
  (publish :path "/display"
	   :function 'display))

(eval-when (load eval)
  (publish-file :path "/assets/speaker.gif"
    :file "assets/speaker.gif")
  (publish-file :path "/assets/tabnormal.gif"
    :file "assets/tabnormal.gif")
  (publish-file :path "/assets/left.gif"
    :file "assets/left.gif")
  (publish-file :path "/assets/right.gif"
    :file "assets/right.gif")
  (publish-file :path "up.gif"
    :file "site/assets/up.gif")
  (publish-file :path "/assets/down.gif"
    :file "assets/down.gif"))

(defparameter *colors*
    (let ((l (list "#BBBBBB" "#999999")))
      (nconc l l)))

(defparameter *header*
    '("name" "master-name" "gender" "origin" "popularity" "meanings"
      "mdist" "sdist"))

(defparameter *data*
    ;; name master-name gender origin popularity meanings mdist sdist
    '(("Joey" "Joseph" "M" "HE" 1000 ("coat") 20 30)
      ("Joseph" "Joseph" "M" "HE" 500 ("coat") 10 40)
      ("Joe" "Joseph" "M" "HE" 600 ("coat" "coffee") 5 30)
      ("Giuseppe" "Joseph" "M" "IT" 400 ("coat") 3 55)
      ("Jose" "Joseph" "M" "ES" 6000 ("coat") 5 66)
      ("Frank" "Franklin" "M" "DE" 3000 ("wiener") 15 150)
      ("Frankie" "Franklin" "M" "DE" 400 ("wiener" "rock/roll") 30 200)
      ("Fran" "Franklin" "M" "DE" 10 ("wiener") 10 200)
      ("Zoe" "Zoe" "F" "EL" 400 ("zebra") 20 20)))


#+no
(def-clp-function nmb_report (req ent args body)
  (declare (ignorable args body))
  (nmb_report_fn req ent))

#+no
(defun nmb_report_fn (req ent &key (header *header*)
				  (data *data*)
				  (grouped t))
  (let ((colors *colors*)
	(ws (websession-from-req req)))
    (flet ((var (name)
	     (websession-variable ws name)))
    (html
     :newline
     (:ul
      (:li "Grouped:"
	   (:princ (var "grouped"))))
     :newline

     ((:table :border 0 :bgcolor "#EEEEEE")
      :newline
      ;; header row
      (:tr
       :newline
       (:th
	:newline
	((:table :border 1
		 :cellpadding 0
		 :cellspacing 0)
	 (:tr
	  (:td
	   (:princ "Name")
	   (:princ " ")
	   (if (var "grouped")
	       (html ((:a :href "ungroup") 
		      (:princ "ungroup")))
	     (html ((:a :href "group") 
		      (:princ "group"))))))))
       (:th
	((:a :href "reorder?column=gender")
	 (:princ "Gender")))
       (:th
	(:princ "Origin"))
       (:th
	(:princ "Popularity"))
       (:th
	(:princ "Meanings"))
       (:th 
	(:princ "Meaning")
	:br
	(:princ "Dist"))
       (:th
	(:princ "Sound Dist")))
	  
     (let ((color nil)
	   (last-master nil))

       (loop for (name master gender origin pop meanings mdist sdist)
	   in data
	   do (html
	       (:tr
		:newline
		((:td :bgcolor color)
		 ((:table :border 0
			  :cellpadding 0
			  :cellspacing 0
			  :width "100%")
		  (:tr
		   ((:td :align :left)
		    (if (string-equal name master)
			(html
			 (:princ name))
		      (html
		       (:princ "&nbsp;&nbsp;&nbsp")
		       (:princ name))))
		   (html
		    ((:td :align :right)
		     ((:a :href "play")
		      ((:img :border 0
			     :src "speaker.gif"))))))))
		:newline
		((:td :bgcolor color)
		 (:princ gender))
		:newline
		((:td :bgcolor color) (:princ origin))
		:newline
		((:td :bgcolor color 
		      :align :right)
		 (:princ pop))
		:newline
		((:td :bgcolor color) (:princ 
				       (format nil "~{~A~^;~}"
					       meanings)))
		:newline
		((:td :bgcolor color
		      :align :right)
		 (:princ mdist))
		:newline
		((:td :bgcolor color
		      :align :right)
		 (:princ sdist))))
	   do (unless (string-equal master last-master)
		(setq color (pop colors))))))))))

#+no
(defun nmb_report_fn (req ent &key (header *header*)
				  (data *data*)
				  (grouped t))
  (let* ((gender "M")
	 (origin '("EN" "DE" "FR" "IT"))
	 (syllables "2")
	 (stress '("10" "01" "11"))
	 (decile '(2 . 9))
	 (begins-letter '("R" "B" "T" "L" "M" "W"))
	 (!begins-letter "S")
	 (ends-letter '("T" "N" "M" "L"))
	 (!ends-letter "U")
	 (contains-letter '("O" "A" "T" "H" "E"))
	 (!contains-letter "X")
	 (begins-sound '("R" "B" "T" "L" "M" "W"))
	 (!begins-sound "S")
	 (ends-sound '("T" "N" "M" "L"))
	 (!ends-sound "S")
	 (contains-sound '("AA" "O" "IH" "IY"))
	 (!contains-sound "ZH")
	
	 (names
	  (namesearch nil
		      :gender gender
		      :origin origin
		      :syllables syllables
		      :stress stress
		      :decile decile
		      :begins-letter begins-letter
		      :!begins-letter !begins-letter
		      :ends-letter ends-letter
		      :!ends-letter !ends-letter
		      :contains-letter contains-letter
		      :!contains-letter !contains-letter
		      :begins-sound begins-sound
		      :!begins-sound !begins-sound
		      :ends-sound ends-sound
		      :!ends-sound !ends-sound
		      :contains-sound contains-sound
		      :!contains-sound !contains-sound)))
		    
    (html
     ((:table :border 1)
      (:tr
       (:th "name")
       (:th "gender")
       (:th "origin")
       (:th "popularity")
       (:th "meanings")
       (:th "m dist")
       (:th "s dist"))

      (loop for (phdist sdist sems name gndr org syl str pron) in names
	  do (html
	      :newline
	      (:tr
	       :newline
	       (:td (:princ name))
	       :newline
	       (:td (:princ gndr))
	       :newline
	       (:td (:princ org))
	       :newline
	       (:td (:princ 0))
	       :newline
	       (:td (:prin1 sems))
	       :newline
	       (:td (:princ sdist))
	       :newline
	       (:td (:princ phdist)))))))))


#+no
(defun nmb_report_fn (req ent &key (header *header*)
				  (data *data*)
				  (grouped t))
  (let* ((gender "M")
	 (origin '("EN" "DE" "FR" "IT"))
	 (syllables "2")
	 (stress '("10" "01" "11"))
	 (decile '(2 . 9))
	 (begins-letter '("R" "B" "T" "L" "M" "W"))
	 (!begins-letter "S")
	 (ends-letter '("T" "N" "M" "L"))
	 (!ends-letter "U")
	 (contains-letter '("O" "A" "T" "H" "E"))
	 (!contains-letter "X")
	 (begins-sound '("R" "B" "T" "L" "M" "W"))
	 (!begins-sound "S")
	 (ends-sound '("T" "N" "M" "L"))
	 (!ends-sound "S")
	 (contains-sound '("AA" "O" "IH" "IY"))
	 (!contains-sound "ZH")
	
	 (names
	  (namesearch nil
		      :gender gender
		      :origin origin
		      :syllables syllables
		      :stress stress
		      :decile decile
		      :begins-letter begins-letter
		      :!begins-letter !begins-letter
		      :ends-letter ends-letter
		      :!ends-letter !ends-letter
		      :contains-letter contains-letter
		      :!contains-letter !contains-letter
		      :begins-sound begins-sound
		      :!begins-sound !begins-sound
		      :ends-sound ends-sound
		      :!ends-sound !ends-sound
		      :contains-sound contains-sound
		      :!contains-sound !contains-sound)))
		    
    (html
     ((:table :border 1)
      (:tr
       (:th "name")
       (:th "gender")
       (:th "origin")
       (:th "popularity")
       (:th "meanings")
       (:th "m dist")
       (:th "s dist"))

      (loop for (phdist sdist sems name gndr org syl str pron) in names
	  do (html
	      :newline
	      (:tr
	       :newline
	       (:td (:princ name))
	       :newline
	       (:td (:princ gndr))
	       :newline
	       (:td (:princ org))
	       :newline
	       (:td (:princ 0))
	       :newline
	       (:td (:prin1 sems))
	       :newline
	       (:td (:princ sdist))
	       :newline
	       (:td (:princ phdist)))))))))


(defun all-genders () '("M" "F"))

(defun all-origins () 
  '("A1" ;; African 
    "A2" ;; African-American
    "AR" ;; Arabic
    "HY" ;; Armenian
    "KM" ;; Cambodian
    "ZH" ;; Chinese
    "NL" ;; Dutch
    "EN" ;; English
    "FA" ;; Farsi
    "FR" ;; French
    "G1" ;; Gaelic
    "DE" ;; German
    "EL" ;; Greek
    "H1" ;; Hawaiian
    "HE" ;; Hebrew
    "HI" ;; Hindi
    "HU" ;; Hungarian
    "IT" ;; Italian
    "JA" ;; Japanese
    "LA" ;; Latin
    "PL" ;; Polish
    "PT" ;; Portuguese
    "RU" ;; Russian
    "S1" ;; Slavic
    "S2" ;; Scandinavian
    "ES" ;; Spanish
    "SW" ;; Swahili
    "TR" ;; Turkish
    "VI" ;; Vietnamese
    "CY" ;; Welsh
    ))

(defvar *origins-map*
    (let ((origins-ht (make-hash-table :test #'equal)))
      (setf (gethash "A1" origins-ht) "African")
      (setf (gethash "A2" origins-ht) "African-American")
      (setf (gethash "AR" origins-ht) "Arabic")
      (setf (gethash "HY" origins-ht) "Armenian")
      (setf (gethash "KM" origins-ht) "Cambodian")
      (setf (gethash "ZH" origins-ht) "Chinese")
      (setf (gethash "NL" origins-ht) "Dutch")
      (setf (gethash "EN" origins-ht) "English")
      (setf (gethash "FA" origins-ht) "Farsi")
      (setf (gethash "FR" origins-ht) "French")
      (setf (gethash "G1" origins-ht) "Gaelic")
      (setf (gethash "DE" origins-ht) "German")
      (setf (gethash "EL" origins-ht) "Greek")
      (setf (gethash "H1" origins-ht) "Hawaiian")
      (setf (gethash "HE" origins-ht) "Hebrew")
      (setf (gethash "HI" origins-ht) "Hindi")
      (setf (gethash "HU" origins-ht) "Hungarian")
      (setf (gethash "IT" origins-ht) "Italian")
      (setf (gethash "JA" origins-ht) "Japanese")
      (setf (gethash "LA" origins-ht) "Latin")
      (setf (gethash "PL" origins-ht) "Polish")
      (setf (gethash "PT" origins-ht) "Portuguese")
      (setf (gethash "RU" origins-ht) "Russian")
      (setf (gethash "S1" origins-ht) "Scandinavian")
      (setf (gethash "S2" origins-ht) "Slavic")
      (setf (gethash "ES" origins-ht) "Spanish")
      (setf (gethash "SW" origins-ht) "Swahili")
      (setf (gethash "TR" origins-ht) "Turkish")
      (setf (gethash "VI" origins-ht) "Vietnamese")
      (setf (gethash "CY" origins-ht) "Welsh")
      
      origins-ht))

(defun all-deciles ()
  '("1" "2" "3" "4" "5" "6" "7" "8" "9" "10"))

(defun all-stresses ()
  '("1"
    "10" "01" "11"
    "100" "010" "001"
    "1000" "0100" "0010"
    "00100"))

#+old
(defvar *stresses-map*
    (let ((stresses-ht (make-hash-table :test #'equal)))
      (setf (gethash "1" stresses-ht) "stressed")
      (setf (gethash "10" stresses-ht) "first syllable")
      (setf (gethash "01" stresses-ht) "second syllable")
      (setf (gethash "11" stresses-ht) "both")
      (setf (gethash "100" stresses-ht) "first syllable")
      (setf (gethash "010" stresses-ht) "second syllable")
      (setf (gethash "001" stresses-ht) "third syllable")
      (setf (gethash "1000" stresses-ht) "first syllable")
      (setf (gethash "0100" stresses-ht) "second syllable")
      (setf (gethash "0010" stresses-ht) "third syllable")
      (setf (gethash "00100" stresses-ht) "third syllable")
      stresses-ht))

(defvar *stresses-map*
    (let ((stresses-ht (make-hash-table :test #'equal)))
      (setf (gethash "1" stresses-ht) "stressed")
      (setf (gethash "10" stresses-ht) "first")
      (setf (gethash "01" stresses-ht) "second")
      (setf (gethash "11" stresses-ht) "both")
      (setf (gethash "100" stresses-ht) "first")
      (setf (gethash "010" stresses-ht) "second")
      (setf (gethash "001" stresses-ht) "third")
      (setf (gethash "1000" stresses-ht) "first")
      (setf (gethash "0100" stresses-ht) "second")
      (setf (gethash "0010" stresses-ht) "third")
      (setf (gethash "00100" stresses-ht) "third")
      stresses-ht))

(defvar *decile-interpretations*
    #("extremely rare"
      "very rare"
      "rare"
      "unusual"
      "uncommon"
      "frequent"
      "somewhat popular"
      "popular"
      "very popular"
      "extremely popular"))

(defun ensure-integer (thing)
  (etypecase thing
    (integer thing)
    (string (parse-integer thing))))

(defvar *popularity-map*
    (let ((map (edu.isi.isd.nlp.appl.db.dbl:dbl :namemybaby "select gender,minpop,maxpop,decile
from decile")))
      (loop for (gender minpop maxpop decile) in map
	  as iminpop = (ensure-integer minpop)
	  as imaxpop = (ensure-integer maxpop)
	  as idecile = (ensure-integer decile)
	  collect (list gender 
			iminpop
			imaxpop
			idecile
			(aref *decile-interpretations* 
			      (1- idecile))))))

(defun nmb_report_fn (req ent)
  (declare (ignore ent))
  (let ((ws (websession-from-req req)))
    (flet ((var (name)
	     (websession-variable ws name))
	   (smash (a b)
	     (append a b)))
      (let* ((gender (var "GENDER"))
	     (origin (var "ORIGIN"))
	     (syllables (var "SYLLABLES"))
	     (stress (mapcar #'(lambda (x)
				 (subseq x 3))
			     (var "STRESS")))
	     (decile (var "DECILE"))
	     (begins-letter (smash (var "BEG1VWL")
				   (var "BEG1CST")))
	     (!begins-letter (smash (var "BEG0VWL")
				    (var "BEG0CST")))
	     (ends-letter (smash (var "END1VWL")
				 (var "END1CST")))
	     (!ends-letter (smash (var "END0VWL")
				  (var "END0CST")))
	     (contains-letter (smash (var "CNT1VWL")
				     (var "CNT1CST")))
	     (!contains-letter (smash (var "CNT0VWL")
				      (var "CNT0CST")))
	     (begins-sound (var "BEG1SND"))
	     (!begins-sound (var "BEG0SND"))
	     (ends-sound (var "END1SND"))
	     (!ends-sound (var "END0SND"))
	     (contains-sound (var "CNT1SND"))
	     (!contains-sound (var "CNT0SND")))
	
	(unless gender (setq gender (all-genders)))
	(unless origin (setq origin (all-origins)))
	(unless stress (setq stress (all-stresses)))
	(unless decile (setq decile (all-deciles)))
	
	(let ((names
	       (namesearch1 nil
			    :gender gender
			    :origin origin
			    :syllables syllables
			    :stress stress
			    :decile decile
			    :begins-letter begins-letter
			    :!begins-letter !begins-letter
			    :ends-letter ends-letter
			    :!ends-letter !ends-letter
			    :contains-letter contains-letter
			    :!contains-letter !contains-letter
			    :begins-sound begins-sound
			    :!begins-sound !begins-sound
			    :ends-sound ends-sound
			    :!ends-sound !ends-sound
			    :contains-sound contains-sound
			    :!contains-sound !contains-sound)))
		    
	  (html
	   ((:table :border 1)
	    (:tr
	     :newline
	     (:th "phdist")
	     :newline
	     (:th "sdist")
	     :newline
	     (:th "name")
	     :newline
	     (:th "gndr")
	     :newline
	     (:th "org")
	     :newline
	     (:th "syl")
	     :newline
	     (:th "str")
	     :newline
	     (:th "pron")
	     :newline
	     (:th "sems")
	     :newline
	     (:th "pop"))
	  
	    (loop for (phdist sdist name gndr org syl str pron sems pop) in names
		do (html
		    :newline
		    (:tr
		     :newline
		     (:td (:princ phdist))
		     :newline
		     (:td (:princ sdist))
		     :newline
		     (:td (:princ name))
		     :newline
		     (:td (:princ gndr))
		     :newline
		     (:td (:prin1 org))
		     :newline
		     (:td (:princ syl))
		     :newline
		     (:td (:princ str))
		     :newline
		     (:td (:princ pron))
		     :newline
		     (:td (:princ sems))
		     :newline
		     (:td (:princ pop))))))))))))


(defun action-reorder (req ent) 
  (declare (ignore ent))
  (let ((col (request-query-value "col" req)))
    (setf (websession-variable
	   (websession-from-req req)
	   "criteria")
      col)
    "dump"))
    

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defun nmb_report_fn (req ent)
  (declare (ignore ent))
  (let ((ws (websession-from-req req)))
    (setq www ws)
    (flet ((var (name)
	     (websession-variable ws name))
	   (smash (a b)
	     (append a b)))
      (macrolet ((cond-emit (flag &body body)
		   `(when ,flag
		      (html ,@body))))
	(let* ((gender (var "GENDER"))
	       (origin (var "ORIGIN"))
	       (syllables (var "SYLLABLES"))
	       (stress (mapcar #'(lambda (x)
				   (subseq x 3))
			       (var "STRESS")))
	       (decile (var "DECILE"))
	       (begins-letter (smash (var "BEG1VWL")
				     (var "BEG1CST")))
	       (!begins-letter (smash (var "BEG0VWL")
				      (var "BEG0CST")))
	       (ends-letter (smash (var "END1VWL")
				   (var "END1CST")))
	       (!ends-letter (smash (var "END0VWL")
				    (var "END0CST")))
	       (contains-letter (smash (var "CNT1VWL")
				       (var "CNT1CST")))
	       (!contains-letter (smash (var "CNT0VWL")
					(var "CNT0CST")))
	       (begins-sound (var "BEG1SND"))
	       (!begins-sound (var "BEG0SND"))
	       (ends-sound (var "END1SND"))
	       (!ends-sound (var "END0SND"))
	       (contains-sound (var "CNT1SND"))
	       (!contains-sound (var "CNT0SND")))
	
	  (unless gender (setq gender (all-genders)))
	  (unless origin (setq origin (all-origins)))
	  (unless stress (setq stress (all-stresses)))
	  (unless decile (setq decile (all-deciles)))
	
	  (let ((names
		 (namesearch1 nil
			      :gender gender
			      :origin origin
			      :syllables syllables
			      :stress stress
			      :decile decile
			      :begins-letter begins-letter
			      :!begins-letter !begins-letter
			      :ends-letter ends-letter
			      :!ends-letter !ends-letter
			      :contains-letter contains-letter
			      :!contains-letter !contains-letter
			      :begins-sound begins-sound
			      :!begins-sound !begins-sound
			      :ends-sound ends-sound
			      :!ends-sound !ends-sound
			      :contains-sound contains-sound
			      :!contains-sound !contains-sound)))
		    
	    (html
	     ((:table :border 1)
	      (:tr
	       (cond-emit (var "SHOW_NAME")
			  :newline
			  (:th "name" 
			       ((:img :src "/assets/down.gif"))
			       ((:img :src "/assets/up.gif"))))
	       (cond-emit (var "SHOW_GENDER")
			  :newline
			  (:th "gender"))
	       (cond-emit (var "SHOW_ORIGIN")
			  :newline
			  (:th "origin"))
	       (cond-emit (var "SHOW_SYLLABLES")
			  :newline
			  (:th "syllables"))
	       (cond-emit (var "SHOW_STRESS")
			  :newline
			  (:th "stressed"))
	       (cond-emit (var "SHOW_PRON")
			  :newline
			  (:th "pronunciation"))
	       (cond-emit (var "SHOW_MEANING")
			  :newline
			  (:th "meanings"))
	       (cond-emit (var "SHOW_POPULARITY")
			  :newline
			  (:th "popularity"))
	       (cond-emit (var "SHOW_PHONDIST")
			  :newline
			  (:th "phonetic distance"))
	       (cond-emit (var "SHOW_SEMDIST")
			  :newline
			  (:th "semantic distance")))
	  
	      (loop for (phdist sdist name gndr org syl str pron sems pop) in names
		  do (html
		      :newline
		      (:tr
		       (cond-emit (var "SHOW_NAME")
				  :newline
				  (:td (:princ name)
				       (:princ "&nbsp;")
				       ((:img :src "speaker.gif"))))
		       (cond-emit (var "SHOW_GENDER")
				  :newline
				  (:td (when (string-equal gndr "M")
					 (html
					  ((:span :class "blue") 
					   (:b (:princ "boy")))))
				       (when (string-equal gndr "F")
					 (html
					  ((:span :class "pink")
					   (:b (:princ "girl")))))))
		       (cond-emit (var "SHOW_ORIGIN")
				  :newline
				  (:td (:princ 
					(gethash org *origins-map*))))
		       (cond-emit (var "SHOW_SYLLABLES")
				  :newline
				  (:td (:princ syl)))
		       (cond-emit (var "SHOW_STRESS")
				  :newline
				  (:td (:princ 
					(gethash str *stresses-map*))))
		       (cond-emit (var "SHOW_PRON")
				  :newline
				  (:td (:princ pron)))
		       (cond-emit (var "SHOW_MEANING")
				  :newline
				  (:td (loop for sem across sems
					   do (html (:princ sem)
						    :newline))))
		       (cond-emit (var "SHOW_POPULARITY")
				  :newline
				  (:td 
				   (let ((pop (parse-integer pop)))
				     (loop for (g min max dec interp)
					 in *popularity-map*
					 when (and (equal g gndr)
						   (<= min pop)
						   (<= pop max))
					 do (html
					     (:format-safe
					      (format nil "~D: ~A (~A~A)"
						      dec
						      interp
						      (if (> pop 40)
							  "" "<")
						      pop)))
				       and do (return)))))
		       (cond-emit (var "SHOW_PHONDIST")
				  :newline
				  (:td (:princ phdist)))
		       (cond-emit (var "SHOW_SEMDIST")
				  :newline
				  (:td (:princ sdist))))))))))))))

(defun fake-read-from-string (string)
  (read-from-string string))

(defun pron-link (name)
  (format nil "http://blombos.isi.edu/cgi-bin/namemybaby/pron/tpron.cgi?word=~A"
	  (html-code-string name)))

(defun pop-graphic-urls (decile gender)
  (canon-list
   (map-canon #'(lambda (g)
		  (format nil "/assets/~:[blue~;pink~]~2,'0D.gif" 
			  (string-equal g "F")
			  decile))
	      gender)))
	  
;;; (defun nmb_report_fn (req ent)
;;;   (declare (ignore ent))
;;;   (let ((ws (websession-from-req req)))
;;;     (setq www ws)
;;;     (flet ((var (name)
;;; 	     (websession-variable ws name))
;;; 	   (smash (a b)
;;; 	     (append a b)))
;;;       (macrolet ((cond-emit (flag &body body)
;;; 		   `(when ,flag
;;; 		      (html ,@body))))
;;; 	(let* ((gender (var "GENDER"))
;;; 	       (origin (var "ORIGIN"))
;;; 	       (syllables (var "SYLLABLES"))
;;; 	       (stress (mapcar #'(lambda (x)
;;; 				   (subseq x 3))
;;; 			       (var "STRESS")))
;;; 	       (decile (var "POP"))
;;; 	       (begins-letter (smash (var "BEG1VWL")
;;; 				     (var "BEG1CST")))
;;; 	       (!begins-letter (smash (var "BEG0VWL")
;;; 				      (var "BEG0CST")))
;;; 	       (ends-letter (smash (var "END1VWL")
;;; 				   (var "END1CST")))
;;; 	       (!ends-letter (smash (var "END0VWL")
;;; 				    (var "END0CST")))
;;; 	       (contains-letter (smash (var "CNT1VWL")
;;; 				       (var "CNT1CST")))
;;; 	       (!contains-letter (smash (var "CNT0VWL")
;;; 					(var "CNT0CST")))
;;; 	       (begins-sound (var "BEG1SND"))
;;; 	       (!begins-sound (var "BEG0SND"))
;;; 	       (ends-sound (var "END1SND"))
;;; 	       (!ends-sound (var "END0SND"))
;;; 	       (contains-sound (var "CNT1SND"))
;;; 	       (!contains-sound (var "CNT0SND"))
;;; 	       (phonetic-root (car (var "SNDSRCHROOT")))
;;; 	       (phonetic-distance (car (var "SNDSRCHLIMIT"))))
;;; 	  
;;; 	  (when decile
;;; 	    (setq decile
;;; 	      (mapcar #'(lambda (x)
;;; 			  (- 11 (read-from-string x)))
;;; 		      decile)))
;;; 	
;;; 	  (unless gender (setq gender (all-genders)))
;;; 	  (unless origin (setq origin (all-origins)))
;;; 	  (unless stress (setq stress (all-stresses)))
;;; 	  (unless decile (setq decile (all-deciles)))
;;; 	  
;;; 	  (when phonetic-distance
;;; 	    (setq phonetic-distance 
;;; 	      (ignore-errors
;;; 	       (read-from-string phonetic-distance))))
;;; 
;;; 	  (warn "Phonetic root = ~S, phonetic distance=~S"
;;; 		phonetic-root phonetic-distance)
;;; 
;;; 	  (let ((names
;;; 		 (namesearch3 phonetic-root
;;; 			      :gender gender
;;; 			      :origin origin
;;; 			      :syllables syllables
;;; 			      :stress stress
;;; 			      :decile decile
;;; 			      :begins-letter begins-letter
;;; 			      :!begins-letter !begins-letter
;;; 			      :ends-letter ends-letter
;;; 			      :!ends-letter !ends-letter
;;; 			      :contains-letter contains-letter
;;; 			      :!contains-letter !contains-letter
;;; 			      :begins-sound begins-sound
;;; 			      :!begins-sound !begins-sound
;;; 			      :ends-sound ends-sound
;;; 			      :!ends-sound !ends-sound
;;; 			      :contains-sound contains-sound
;;; 			      :!contains-sound !contains-sound
;;; 			      :phonetic-distance phonetic-distance)))
;;; 		    
;;; 	    (html
;;; 	     ((:table :border 1 :cellpadding 0 :cellspacing 0)
;;; 	      (:tr
;;; 	       (cond-emit (var "SHOW_NAME")
;;; 			  :newline
;;; 			  ((:th :valign :top)
;;; 			   "name"
;;; 			   :br
;;; 			   ((:a :href "reorder?column=NAME&dir=DESC"
;;; 				:onmouseover "window.status='Sort by names in alphabetic order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/assets/down.gif")))
;;; 			   ((:a :href "reorder?column=NAME&dir=ASC"
;;; 				:onmouseover "window.status='Sort by names in reverse order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/up.gif")))
;;; 			   ((:a :href "reorder?column=NAME&dir=ASC"
;;; 				:onmouseover "window.status='Sort by names in reverse order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/circle.gif")))))
;;; 	       (cond-emit (var "SHOW_GENDER")
;;; 			  :newline
;;; 			  ((:th :valign :top)
;;; 			   "gender" 
;;; 			   :br
;;; 			   ((:a :href "reorder?column=NAME&dir=DESC"
;;; 				:onmouseover "window.status='Sort by names in alphabetic order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/assets/down.gif")))
;;; 			   ((:a :href "reorder?column=NAME&dir=ASC"
;;; 				:onmouseover "window.status='Sort by names in reverse order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/up.gif")))))
;;; 	       (cond-emit (var "SHOW_ORIGIN")
;;; 			  :newline
;;; 			  ((:th :valign :top)
;;; 			   "origin"
;;; 			   :br
;;; 			   ((:a :href "reorder?column=NAME&dir=DESC"
;;; 				:onmouseover "window.status='Sort by names in alphabetic order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/assets/down.gif")))
;;; 			   ((:a :href "reorder?column=NAME&dir=ASC"
;;; 				:onmouseover "window.status='Sort by names in reverse order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/up.gif")))))
;;; 	       (cond-emit (var "SHOW_SYLLABLES")
;;; 			  :newline
;;; 			  ((:th :valign :top)
;;; 			   "syllables"			
;;; 			   :br
;;; 			   ((:a :href "reorder?column=NAME&dir=DESC"
;;; 				:onmouseover "window.status='Sort by names in alphabetic order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/assets/down.gif")))
;;; 			   ((:a :href "reorder?column=NAME&dir=ASC"
;;; 				:onmouseover "window.status='Sort by names in reverse order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/up.gif")))))
;;; 	       (cond-emit (var "SHOW_STRESS")
;;; 			  :newline
;;; 			  ((:th :valign :top)
;;; 			   "stressed syllables"
;;; 			   :br
;;; 			   ((:a :href "reorder?column=NAME&dir=DESC"
;;; 				:onmouseover "window.status='Sort by names in alphabetic order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/assets/down.gif")))
;;; 			   ((:a :href "reorder?column=NAME&dir=ASC"
;;; 				:onmouseover "window.status='Sort by names in reverse order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/up.gif")))))
;;; 	       (cond-emit (var "SHOW_PRON")
;;; 			  :newline
;;; 			  ((:th :valign :top)
;;; 			   "pronunciation"			 
;;; 			   ((:a :href "reorder?column=NAME&dir=DESC"
;;; 				:onmouseover "window.status='Sort by names in alphabetic order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/assets/down.gif")))
;;; 			   ((:a :href "reorder?column=NAME&dir=ASC"
;;; 				:onmouseover "window.status='Sort by names in reverse order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/up.gif")))))
;;; 	       (cond-emit (var "SHOW_MEANING")
;;; 			  :newline
;;; 			  ((:th :valign :top)
;;; 			   "meanings"
;;; 			   :br
;;; 			   ((:a :href "reorder?column=NAME&dir=DESC"
;;; 				:onmouseover "window.status='Sort by names in alphabetic order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/assets/down.gif")))
;;; 			   ((:a :href "reorder?column=NAME&dir=ASC"
;;; 				:onmouseover "window.status='Sort by names in reverse order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/up.gif")))))
;;; 	       (cond-emit (var "SHOW_POPULARITY")
;;; 			  :newline
;;; 			  ((:th :valign :top)
;;; 			   "popularity"	
;;; 			   :br
;;; 			   ((:a :href "reorder?column=NAME&dir=DESC"
;;; 				:onmouseover "window.status='Sort by names in alphabetic order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/assets/down.gif")))
;;; 			   ((:a :href "reorder?column=NAME&dir=ASC"
;;; 				:onmouseover "window.status='Sort by names in reverse order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/up.gif")))))
;;; 	       (cond-emit (var "SHOW_PHONDIST")
;;; 			  :newline
;;; 			  ((:th :valign :top)
;;; 			   "phonetic distance"
;;; 			   :br
;;; 			   ((:a :href "reorder?column=NAME&dir=DESC"
;;; 				:onmouseover "window.status='Sort by names in alphabetic order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/assets/down.gif")))
;;; 			   ((:a :href "reorder?column=NAME&dir=ASC"
;;; 				:onmouseover "window.status='Sort by names in reverse order';return true"
;;; 				:onmouseout "window.status=' ';return true")			    
;;; 			    ((:img :border 0 :src "/up.gif")))))
;;; 	       (cond-emit (var "SHOW_SEMDIST")
;;; 			  :newline
;;; 			  ((:th :valign :top)
;;; 			   "semantic distance2"
;;; 			   :br
;;; 			   ((:a :href "reorder?column=NAME&dir=DESC"
;;; 				:onmouseover "window.status='Sort by names in alphabetic order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/assets/down.gif")))
;;; 			   ((:a :href "reorder?column=NAME&dir=ASC"
;;; 				:onmouseover "window.status='Sort by names in reverse order';return true"
;;; 				:onmouseout "window.status=' ';return true")
;;; 			    ((:img :border 0 :src "/up.gif"))))))
;;; 	  
;;; 	      (loop for (phdist sdist name gndr org syl str pron sems pop) in names
;;; 		  do (html
;;; 		      :newline
;;; 		      (:tr
;;; 		       (cond-emit (var "SHOW_NAME")
;;; 				  :newline
;;; 				  (:td (:princ name)
;;; 				       (:princ "&nbsp;")
;;; 				       ((:a :href (pron-link name)
;;; 					    :target "_new"
;;; 					    :onmouseover (over "a" "b")
;;; 					    :onmouseout (out))
;;; 					((:img :border 0
;;; 					       :src "speaker.gif")))))
;;; 		       (cond-emit (var "SHOW_GENDER")
;;; 				  :newline
;;; 				  ((:td :align :center)
;;; 				   (when (string-equal gndr "M")
;;; 				     (html
;;; 				      ((:span :class "blue") 
;;; 				       (:princ "boy"))))
;;; 				   (when (string-equal gndr "F")
;;; 				     (html
;;; 				      ((:span :class "pink")
;;; 				       (:princ "girl"))))))
;;; 		       (cond-emit (var "SHOW_ORIGIN")
;;; 				  :newline
;;; 				  ((:td :align :center)
;;; 				   (:princ 
;;; 				    (gethash org *origins-map*))))
;;; 		       (cond-emit (var "SHOW_SYLLABLES")
;;; 				  :newline
;;; 				  (:td (:princ syl)))
;;; 		       (cond-emit (var "SHOW_STRESS")
;;; 				  :newline
;;; 				  (:td (:princ 
;;; 					(gethash str *stresses-map*))))
;;; 		       (cond-emit (var "SHOW_PRON")
;;; 				  :newline
;;; 				  (:td (:princ pron)))
;;; 		       (cond-emit (var "SHOW_MEANING")
;;; 				  :newline
;;; 				  (:td (loop for sem in (canon-list sems)
;;; 					   do (html (:princ sem)
;;; 						    :newline))))
;;; 		       (cond-emit (var "SHOW_POPULARITY")
;;; 				  :newline
;;; 				  (:td 
;;; 				   (let ((pop (parse-integer pop)))
;;; 				     (loop for (g min max dec interp)
;;; 					 in *popularity-map*
;;; 					 when (and (equal g gndr)
;;; 						   (<= min pop)
;;; 						   (<= pop max))
;;; 					 do (html
;;; 					     :br
;;; 					     ((:img :src
;;; 						    (pop-graphic-urls dec
;;; 								     gender)))
;;; 					     :br
;;; 					     (:princ pop))
;;; 				       and do (return)))))
;;; 		       (cond-emit (var "SHOW_PHONDIST")
;;; 				  :newline
;;; 				  (:td (:princ phdist)))
;;; 		       (cond-emit (var "SHOW_SEMDIST")
;;; 				  :newline
;;; 				  (:td (:princ sdist))))))))))))))

(defun over (operation field &optional (dir "ASC"))
  (format nil "window.status='~:(~A~) by ~A, ~A';return true"
	  operation field dir))

(defun out ()
  :onmouseout "window.status=' ';return true")

(defun link (base &rest keys-and-values)
  (format nil "~A~@[?~]~{~A=~A~^&~}"
	  base
	  keys-and-values
	  keys-and-values))

#+OLD
(defun nmb_report_fn (req ent)
  (declare (ignore ent))
  (let ((ws (websession-from-req req)))
    (setq www ws)
    (flet ((var (name)
	     (websession-variable ws name))
	   (smash (a b)
	     (append a b)))
      (macrolet ((cond-emit (flag &body body)
		   `(when ,flag
		      (html ,@body))))
	(let* ((gender (var "GENDER"))
	       (origin (var "ORIGIN"))
	       (syllables (var "SYLLABLES"))
	       (stress (mapcar #'(lambda (x)
				   (subseq x 3))
			       (var "STRESS")))
	       (decile (remove "on" (canon-list (var "POP")) :test #'equal))
	       (begins-letter (smash (var "BEG1VWL")
				     (var "BEG1CST")))
	       (!begins-letter (smash (var "BEG0VWL")
				      (var "BEG0CST")))
	       (ends-letter (smash (var "END1VWL")
				   (var "END1CST")))
	       (!ends-letter (smash (var "END0VWL")
				    (var "END0CST")))
	       (contains-letter (smash (var "CNT1VWL")
				       (var "CNT1CST")))
	       (!contains-letter (smash (var "CNT0VWL")
					(var "CNT0CST")))
	       (begins-sound (var "BEG1SND"))
	       (!begins-sound (var "BEG0SND"))
	       (ends-sound (var "END1SND"))
	       (!ends-sound (var "END0SND"))
	       (contains-sound (var "CNT1SND"))
	       (!contains-sound (var "CNT0SND"))
	       (phonetic-root (car (var "SNDSRCHROOT")))
	       (phonetic-distance (car (var "SNDSRCHLIMIT"))))
	  
	  (when decile
	    (setq decile
	      (mapcar #'(lambda (x)
			  (- 11 (read-from-string x)))
		      decile)))
	  
	  ;; hack alert; should be done using javascript in sound.clp

	  (when (and (car (var "SNDSRCHROOT"))
		     (car (var "SNDSRCHLIMIT")))
	    (setf (websession-variable ws "SHOW_PHONDIST") "1"))
	
	  (unless gender (setq gender (all-genders)))
	  (unless origin (setq origin (all-origins)))
	  (unless stress (setq stress (all-stresses)))
	  (unless decile (setq decile (all-deciles)))
	  
	  (when phonetic-distance
	    (setq phonetic-distance 
	      (ignore-errors
	       (read-from-string phonetic-distance))))

	  (warn "Phonetic root = ~S, phonetic distance=~S"
		phonetic-root phonetic-distance)

	  (let ((names
		 (namesearch3 phonetic-root
			      :gender gender
			      :origin origin
			      :syllables syllables
			      :stress stress
			      :decile decile
			      :begins-letter begins-letter
			      :!begins-letter !begins-letter
			      :ends-letter ends-letter
			      :!ends-letter !ends-letter
			      :contains-letter contains-letter
			      :!contains-letter !contains-letter
			      :begins-sound begins-sound
			      :!begins-sound !begins-sound
			      :ends-sound ends-sound
			      :!ends-sound !ends-sound
			      :contains-sound contains-sound
			      :!contains-sound !contains-sound
			      :phonetic-distance phonetic-distance)))
		    
	    (html
	     ((:table :border 0 :cellpadding 0 :cellspacing 5 
		      :class "ltmanila")
	      (:tr
	       (cond-emit (var "SHOW_NAME")
			  :newline
			  ((:th :valign :bottom
				:colspan 2
				:class "manila")
			   ((:table :border 0
				    :cellpadding 5
				    :cellspacing 5)
			    (:tr 
			     ((:th :align :center
				   :colspan 3) "name"))
			    (:tr
			     (:td
			      ((:a :href 
				   (link "reorder"
					 "column" "NAME"
					 "dir" "DESC")
				   :onmouseover (over "reorder" "names"
						      "DESC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/assets/down.gif"))))
			     (:td
			      ((:a :href
				   (link "reorder"
					 "column" "NAME"
					 "dir" "ASC")
				   :onmouseover (over "reorder" "names"
						      "ASC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/up.gif"))))
			     (:td
			      ((:a :href
				   (link "hide"
					 "column" "NAME")
				   :onmouseover (over "hide" "names")
				   :onmouseout (out))
			       ((:img :border 0 :src "/circle.gif"))))))))
	       (cond-emit (var "SHOW_GENDER")
			  :newline
			  ((:th :valign :bottom
				:class "manila")
			   ((:table :border 0
				    :cellpadding 5
				    :cellspacing 5)
			    (:tr
			     ((:th :align :center
				   :colspan 3) "gender"))
			    (:tr
			     (:td
			      ((:a :href 
				   (link "reorder"
					 "column" "GENDER"
					 "dir" "DESC")
				   :onmouseover (over "reorder" "genders"
						      "DESC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/assets/down.gif"))))
			     (:td
			      ((:a :href
				   (link "reorder"
					 "column" "GENDER"
					 "dir" "ASC")
				   :onmouseover (over "reorder" "genders"
						      "ASC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/up.gif"))))
			     (:td
			      ((:a :href
				   (link "hide"
					 "column" "GENDER")
				   :onmouseover (over "hide" "genders")
				   :onmouseout (out))
			       ((:img :border 0 :src "/circle.gif"))))))))
	       (cond-emit (var "SHOW_ORIGIN")
			  :newline
			  ((:th :valign :bottom
				:class "manila")
			   ((:table :border 0
				    :cellpadding 5
				    :cellspacing 5)
			    (:tr
			     ((:th :align :center
				   :colspan 3) "origin"))
			    (:tr
			     (:td
			      ((:a :href 
				   (link "reorder"
					 "column" "ORIGIN"
					 "dir" "DESC")
				   :onmouseover (over "reorder" "origins"
						      "DESC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/assets/down.gif"))))
			     (:td
			      ((:a :href
				   (link "reorder"
					 "column" "ORIGIN"
					 "dir" "ASC")
				   :onmouseover (over "reorder" "origins"
						      "ASC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/up.gif"))))
			     (:td
			      ((:a :href
				   (link "hide"
					 "column" "ORIGIN")
				   :onmouseover (over "hide" "origins")
				   :onmouseout (out))
			       ((:img :border 0 :src "/circle.gif"))))))))
	       (cond-emit (var "SHOW_SYLLABLES")
			  :newline
			  ((:th :valign :bottom
				:class "manila")
			   ((:table :border 0
				    :cellpadding 5
				    :cellspacing 5)
			    (:tr
			     ((:th :align :center
				   :colspan 3) "syllables"))
			    (:tr
			     (:td
			      ((:a :href 
				   (link "reorder"
					 "column" "SYLLABLE"
					 "dir" "DESC")
				   :onmouseover (over "reorder" "syllables"
						      "DESC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/assets/down.gif"))))
			     (:td
			      ((:a :href
				   (link "reorder"
					 "column" "SYLLABLE"
					 "dir" "ASC")
				   :onmouseover (over "reorder" "syllables"
						      "ASC")						      
				   :onmouseout (out))
			       ((:img :border 0 :src "/up.gif"))))
			     (:td
			      ((:a :href
				   (link "hide"
					 "column" "SYLLABLE")
				   :onmouseover (over "hide" "syllables")
				   :onmouseout (out))
			       ((:img :border 0 :src "/circle.gif"))))))))
	       (cond-emit (var "SHOW_STRESS")
			  :newline
			  ((:th :valign :bottom
				:class "manila")
			   ((:table :border 0
				    :cellpadding 5
				    :cellspacing 5)
			    (:tr
			     ((:th :align :center
				   :colspan 3) "stress"))
			    (:tr
			     (:td
			      ((:a :href 
				   (link "reorder"
					 "column" "STRESS"
					 "dir" "DESC")
				   :onmouseover (over "reorder" "stresses"
						      "DESC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/assets/down.gif"))))
			     (:td
			      ((:a :href
				   (link "reorder"
					 "column" "STRESS"
					 "dir" "ASC")
				   :onmouseover (over "reorder" "stresses"
						      "ASC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/up.gif"))))
			     (:td
			      ((:a :href
				   (link "hide"
					 "column" "STRESS")
				   :onmouseover (over "hide" "stresses")
				   :onmouseout (out))
			       ((:img :border 0 :src "/circle.gif"))))))))
	       (cond-emit (var "SHOW_PRON")
			  :newline
			  ((:th :valign :bottom
				:class "manila")
			   ((:table :border 0
				    :cellpadding 5
				    :cellspacing 5)
			    (:tr
			     ((:th :align :center
				   :colspan 3) "pronunciation"))
			    (:tr
			     (:td
			      ((:a :href 
				   (link "reorder"
					 "column" "PRON"
					 "dir" "DESC")
				   :onmouseover (over "reorder" "prons"
						      "DESC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/assets/down.gif"))))
			     (:td
			      ((:a :href
				   (link "reorder"
					 "column" "PRON"
					 "dir" "ASC")
				   :onmouseover (over "reorder" "prons"
						      "ASC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/up.gif"))))
			     (:td
			      ((:a :href
				   (link "hide"
					 "column" "PRON")
				   :onmouseover (over "hide" "prons")
				   :onmouseout (out))
			       ((:img :border 0 :src "/circle.gif"))))))))
	       (cond-emit (var "SHOW_MEANING")
			  :newline
			  ((:th :valign :bottom
				:class "manila")
			   ((:table :border 0
				    :cellpadding 5
				    :cellspacing 5)
			    (:tr
			     ((:th :align :center
				   :colspan 3) "meanings"))
			    (:tr
			     (:td
			      ((:a :href 
				   (link "reorder"
					 "column" "MEANING"
					 "dir" "DESC")
				   :onmouseover (over "reorder" "meanings"
						      "DESC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/assets/down.gif"))))
			     (:td
			      ((:a :href
				   (link "reorder"
					 "column" "MEANING"
					 "dir" "ASC")
				   :onmouseover (over "reorder" "meanings"
						      "ASC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/up.gif"))))
			     (:td
			      ((:a :href
				   (link "hide"
					 "column" "MEANING")
				   :onmouseover (over "hide" "meanings")
				   :onmouseout (out))
			       ((:img :border 0 :src "/circle.gif"))))))))
	       (cond-emit (var "SHOW_POPULARITY")
			  :newline
			  ((:th :valign :bottom
				:class "manila")
			   ((:table :border 0
				    :cellpadding 5
				    :cellspacing 5)
			    (:tr
			     ((:th :align :center
				   :colspan 3) "popularity"))
			    (:tr
			     (:td
			      ((:a :href 
				   (link "reorder"
					 "column" "POPULARITY"
					 "dir" "DESC")
				   :onmouseover (over "reorder" "popularities"
						      "DESC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/assets/down.gif"))))
			     (:td
			      ((:a :href
				   (link "reorder"
					 "column" "POPULARITY"
					 "dir" "ASC")
				   :onmouseover (over "reorder" "popularities"
						      "ASC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/up.gif"))))
			     (:td
			      ((:a :href
				   (link "hide"
					 "column" "POPULARITY")
				   :onmouseover (over "hide" "popularitys")
				   :onmouseout (out))
			       ((:img :border 0 :src "/circle.gif"))))))))
	       (cond-emit (var "SHOW_PHONDIST")
			  :newline
			  ((:th :valign :bottom
				:class "manila")
			   "phonetic distance"
			   :br
			   ((:table :border 0
				    :cellpadding 5
				    :cellspacing 5)
			    (:tr
			     (:td
			      ((:a :href 
				   (link "reorder"
					 "column" "PHONDIST"
					 "dir" "DESC")
				   :onmouseover (over "reorder"
						      "phonetic distance"
						      "DESC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/assets/down.gif"))))
			     (:td
			      ((:a :href
				   (link "reorder"
					 "column" "PHONDIST"
					 "dir" "ASC")
				   :onmouseover (over "reorder"
						      "phonetic distance"
						      "ASC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/up.gif"))))
			     (:td
			      ((:a :href
				   (link "hide"
					 "column" "PHONDIST")
				   :onmouseover (over "hide" "phondists")
				   :onmouseout (out))
			       ((:img :border 0 :src "/circle.gif"))))))))
	       (cond-emit (var "SHOW_SEMDIST")
			  :newline
			  ((:th :valign :bottom
				:class "manila")
			   "semantic distance"
			   :br
			   ((:table :border 0
				    :cellpadding 5
				    :cellspacing 5)
			    (:tr
			     (:td
			      ((:a :href 
				   (link "reorder"
					 "column" "SEMDIST"
					 "dir" "DESC")
				   :onmouseover (over "reorder"
						      "semantic distance"
						      "DESC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/assets/down.gif"))))
			     (:td
			      ((:a :href
				   (link "reorder"
					 "column" "SEMDIST"
					 "dir" "ASC")
				   :onmouseover (over "reorder"
						      "semantic distance"
						      "ASC")
				   :onmouseout (out))
			       ((:img :border 0 :src "/up.gif"))))
			     (:td
			      ((:a :href
				   (link "hide"
					 "column" "SEMDIST")
				   :onmouseover (over "hide" "semdists")
				   :onmouseout (out))
			       ((:img :border 0 :src "/circle.gif"))))))))
	       ((:th :valign :top
		     :class "manila")
		((:a :href
		     (link "showall"))
		 "Show all")))
	       
	       
	  
	      (loop for (phdist sdist name gndr org syl str pron sems pop) 
		  in names
		  do (html
		      :newline
		      (:tr
		       (cond-emit (var "SHOW_NAME")
				  :newline
				  ((:td :class "manila")
				   (:princ name)))
		       (cond-emit (var "SHOW_NAME")
				  :newline
				  ((:td :class "manila")
				   ((:a :href (pron-link name)
					    :target "_new")
					((:img :border 0
					       :src "speaker.gif")))))
		       (cond-emit (var "SHOW_GENDER")
				  :newline
				  ((:td :class "manila"
					:align :center)
				   (when (string-equal gndr "M")
				     (html
				      ((:span :class "blue") 
				       (:princ "boy"))))
				   (when (string-equal gndr "F")
				     (html
				      ((:span :class "pink")
				       (:princ "girl"))))))
		       (cond-emit (var "SHOW_ORIGIN")
				  :newline
				  ((:td :class "manila"
					:align :center)
				   (:princ 
				    (gethash org *origins-map*))))
		       (cond-emit (var "SHOW_SYLLABLES")
				  :newline
				  ((:td :class "manila")
				   (:princ syl)))
		       (cond-emit (var "SHOW_STRESS")
				  :newline
				  ((:td :class "manila")
				   (:princ 
					(gethash str *stresses-map*))))
		       (cond-emit (var "SHOW_PRON")
				  :newline
				  ((:td :class "manila")
				   (:princ pron)))
		       (cond-emit (var "SHOW_MEANING")
				  :newline
				  ((:td :class "manila")
				   (loop for sem in (canon-list sems)
					   do (html (:princ sem)
						    :newline))))
		       (cond-emit (var "SHOW_POPULARITY")
				  :newline
				  ((:td :class "manila")
				   (let ((pop (parse-integer pop)))
				     (loop for (g min max dec interp)
					 in *popularity-map*
					 when (and (equal g gndr)
						   (<= min pop)
						   (<= pop max))
					 do 
					   (html
					     (dolist 
						 (url (pop-graphic-urls dec gndr))
					       (html
						:br
						((:img :src url))))
					     :br
					     (:princ pop))
				       and do (return)))))
		       (cond-emit (var "SHOW_PHONDIST")
				  :newline
				  ((:td :class "manila")
				   (:format "~4,2F" phdist)))
		       (cond-emit (var "SHOW_SEMDIST")
				  :newline
				  ((:td :class "manila")
				   (:princ sdist))))))))))))))

(defun action-retrieve (req ent)
  (declare (ignore ent))
  (let ((ws (websession-from-req req)))
    (setq www ws)
    (flet ((var (name)
	     (websession-variable ws name))
	   (smash (a b)
	     (append a b)))
      (macrolet ((cond-emit (flag &body body)
		   `(when ,flag
		      (html ,@body))))
	(let* ((gender (var "GENDER"))
	       (origin (var "ORIGIN"))
	       (syllables (var "SYLLABLES"))
	       (stress (mapcar #'(lambda (x)
				   (subseq x 3))
			       (var "STRESS")))
	       (decile (remove "on" (canon-list (var "POP")) :test #'equal))
	       (begins-letter (smash (var "BEG1VWL")
				     (var "BEG1CST")))
	       (!begins-letter (smash (var "BEG0VWL")
				      (var "BEG0CST")))
	       (ends-letter (smash (var "END1VWL")
				   (var "END1CST")))
	       (!ends-letter (smash (var "END0VWL")
				    (var "END0CST")))
	       (contains-letter (smash (var "CNT1VWL")
				       (var "CNT1CST")))
	       (!contains-letter (smash (var "CNT0VWL")
					(var "CNT0CST")))
	       (begins-sound (var "BEG1SND"))
	       (!begins-sound (var "BEG0SND"))
	       (ends-sound (var "END1SND"))
	       (!ends-sound (var "END0SND"))
	       (contains-sound (var "CNT1SND"))
	       (!contains-sound (var "CNT0SND"))
	       (phonetic-root (car (var "SNDSRCHROOT")))
	       (phonetic-distance (car (var "SNDSRCHLIMIT"))))
	  
	  (when decile
	    (setq decile
	      (mapcar #'(lambda (x)
			  (- 11 (read-from-string x)))
		      decile)))
	  
	  ;; hack alert; should be done using javascript in sound.clp

	  (when (and (car (var "SNDSRCHROOT"))
		     (car (var "SNDSRCHLIMIT")))
	    (setf (websession-variable ws "SHOW_PHONDIST") "1"))
	
	  (unless gender (setq gender (all-genders)))
	  (unless origin (setq origin (all-origins)))
	  (unless stress (setq stress (all-stresses)))
	  (unless decile (setq decile (all-deciles)))
	  
	  (when phonetic-distance
	    (setq phonetic-distance 
	      (ignore-errors
	       (read-from-string phonetic-distance))))

	  #+ignore
	  (warn "Phonetic root = ~S, phonetic distance=~S"
		phonetic-root phonetic-distance)

	  (let ((names
		 (namesearch3 phonetic-root
			      :gender gender
			      :origin origin
			      :syllables syllables
			      :stress stress
			      :decile decile
			      :begins-letter begins-letter
			      :!begins-letter !begins-letter
			      :ends-letter ends-letter
			      :!ends-letter !ends-letter
			      :contains-letter contains-letter
			      :!contains-letter !contains-letter
			      :begins-sound begins-sound
			      :!begins-sound !begins-sound
			      :ends-sound ends-sound
			      :!ends-sound !ends-sound
			      :contains-sound contains-sound
			      :!contains-sound !contains-sound
			      :phonetic-distance phonetic-distance)))
	    
	    (setf (websession-variable ws "DATA") names)
	    :continue))))))

(def-clp-function nmb_report (req ent args body)
  (declare (ignorable args body))
  (nmb_report_fn req ent))

(defun nmb_report_fn (req ent)
  (declare (ignore ent))
  (let ((ws (websession-from-req req)))
    (setq www ws)
    (flet ((var (name)
	     (websession-variable ws name))
	   (smash (a b)
	     (append a b)))
      (macrolet ((cond-emit (flag &body body)
		   `(when ,flag
		      (html ,@body))))
	(let ((names (var "DATA")))
	  
	  (html
	   :br
	   (:princ "There are ")
	   (:princ (length names))
	   (:princ " names in your active set")
	   :br

	   ((:table :border 0 :cellpadding 0 :cellspacing 5 
		    :class "ltmanila")
	    (:tr
	     (cond-emit (var "SHOW_NAME")
			:newline
			((:th :valign :bottom
			      :colspan 2
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr 
			   ((:th :align :center
				 :colspan 3) "name"))
			  (:tr
			   (:td
			    ((:a :href 
				 (link "reorder"
				       "column" "NAME"
				       "dir" "DESC")
				 :onmouseover (over "reorder" "names"
						    "DESC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/down.gif"))))
			   (:td
			    ((:a :href
				 (link "reorder"
				       "column" "NAME"
				       "dir" "ASC")
				 :onmouseover (over "reorder" "names"
						    "ASC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/up.gif"))))
			   (:td
			    ((:a :href
				 (link "hide"
				       "column" "NAME")
				 :onmouseover (over "hide" "names")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/circle.gif"))))))))
	     (cond-emit (var "SHOW_GENDER")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "gender"))
			  (:tr
			   (:td
			    ((:a :href 
				 (link "reorder"
				       "column" "GENDER"
				       "dir" "DESC")
				 :onmouseover (over "reorder" "genders"
						    "DESC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/down.gif"))))
			   (:td
			    ((:a :href
				 (link "reorder"
				       "column" "GENDER"
				       "dir" "ASC")
				 :onmouseover (over "reorder" "genders"
						    "ASC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/up.gif"))))
			   (:td
			    ((:a :href
				 (link "hide"
				       "column" "GENDER")
				 :onmouseover (over "hide" "genders")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/circle.gif"))))))))
	     (cond-emit (var "SHOW_ORIGIN")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "origin"))
			  (:tr
			   (:td
			    ((:a :href 
				 (link "reorder"
				       "column" "ORIGIN"
				       "dir" "DESC")
				 :onmouseover (over "reorder" "origins"
						    "DESC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/down.gif"))))
			   (:td
			    ((:a :href
				 (link "reorder"
				       "column" "ORIGIN"
				       "dir" "ASC")
				 :onmouseover (over "reorder" "origins"
						    "ASC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/up.gif"))))
			   (:td
			    ((:a :href
				 (link "hide"
				       "column" "ORIGIN")
				 :onmouseover (over "hide" "origins")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/circle.gif"))))))))
	     (cond-emit (var "SHOW_SYLLABLES")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "syllables"))
			  (:tr
			   (:td
			    ((:a :href 
				 (link "reorder"
				       "column" "SYLLABLE"
				       "dir" "DESC")
				 :onmouseover (over "reorder" "syllables"
						    "DESC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/down.gif"))))
			   (:td
			    ((:a :href
				 (link "reorder"
				       "column" "SYLLABLE"
				       "dir" "ASC")
				 :onmouseover (over "reorder" "syllables"
						    "ASC")						      
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/up.gif"))))
			   (:td
			    ((:a :href
				 (link "hide"
				       "column" "SYLLABLE")
				 :onmouseover (over "hide" "syllables")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/circle.gif"))))))))
	     (cond-emit (var "SHOW_STRESS")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "stress"))
			  (:tr
			   (:td
			    ((:a :href 
				 (link "reorder"
				       "column" "STRESS"
				       "dir" "DESC")
				 :onmouseover (over "reorder" "stresses"
						    "DESC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/down.gif"))))
			   (:td
			    ((:a :href
				 (link "reorder"
				       "column" "STRESS"
				       "dir" "ASC")
				 :onmouseover (over "reorder" "stresses"
						    "ASC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/up.gif"))))
			   (:td
			    ((:a :href
				 (link "hide"
				       "column" "STRESS")
				 :onmouseover (over "hide" "stresses")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/circle.gif"))))))))
	     (cond-emit (var "SHOW_PRON")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "pronunciation"))
			  (:tr
			   (:td
			    ((:a :href 
				 (link "reorder"
				       "column" "PRON"
				       "dir" "DESC")
				 :onmouseover (over "reorder" "prons"
						    "DESC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/down.gif"))))
			   (:td
			    ((:a :href
				 (link "reorder"
				       "column" "PRON"
				       "dir" "ASC")
				 :onmouseover (over "reorder" "prons"
						    "ASC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/up.gif"))))
			   (:td
			    ((:a :href
				 (link "hide"
				       "column" "PRON")
				 :onmouseover (over "hide" "prons")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/circle.gif"))))))))
	     (cond-emit (var "SHOW_MEANING")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "meanings"))
			  (:tr
			   (:td
			    ((:a :href 
				 (link "reorder"
				       "column" "MEANING"
				       "dir" "DESC")
				 :onmouseover (over "reorder" "meanings"
						    "DESC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/down.gif"))))
			   (:td
			    ((:a :href
				 (link "reorder"
				       "column" "MEANING"
				       "dir" "ASC")
				 :onmouseover (over "reorder" "meanings"
						    "ASC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/up.gif"))))
			   (:td
			    ((:a :href
				 (link "hide"
				       "column" "MEANING")
				 :onmouseover (over "hide" "meanings")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/circle.gif"))))))))
	     (cond-emit (var "SHOW_POPULARITY")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "popularity"))
			  (:tr
			   (:td
			    ((:a :href 
				 (link "reorder"
				       "column" "POPULARITY"
				       "dir" "DESC")
				 :onmouseover (over "reorder" "popularities"
						    "DESC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/down.gif"))))
			   (:td
			    ((:a :href
				 (link "reorder"
				       "column" "POPULARITY"
				       "dir" "ASC")
				 :onmouseover (over "reorder" "popularities"
						    "ASC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/up.gif"))))
			   (:td
			    ((:a :href
				 (link "hide"
				       "column" "POPULARITY")
				 :onmouseover (over "hide" "popularitys")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/circle.gif"))))))))
	     (cond-emit (var "SHOW_PHONDIST")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 "phonetic distance"
			 :br
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   (:td
			    ((:a :href 
				 (link "reorder"
				       "column" "PHONDIST"
				       "dir" "DESC")
				 :onmouseover (over "reorder"
						    "phonetic distance"
						    "DESC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/down.gif"))))
			   (:td
			    ((:a :href
				 (link "reorder"
				       "column" "PHONDIST"
				       "dir" "ASC")
				 :onmouseover (over "reorder"
						    "phonetic distance"
						    "ASC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/up.gif"))))
			   (:td
			    ((:a :href
				 (link "hide"
				       "column" "PHONDIST")
				 :onmouseover (over "hide" "phondists")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/circle.gif"))))))))
	     (cond-emit (var "SHOW_SEMDIST")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 "semantic distance"
			 :br
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   (:td
			    ((:a :href 
				 (link "reorder"
				       "column" "SEMDIST"
				       "dir" "DESC")
				 :onmouseover (over "reorder"
						    "semantic distance"
						    "DESC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/down.gif"))))
			   (:td
			    ((:a :href
				 (link "reorder"
				       "column" "SEMDIST"
				       "dir" "ASC")
				 :onmouseover (over "reorder"
						    "semantic distance"
						    "ASC")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/up.gif"))))
			   (:td
			    ((:a :href
				 (link "hide"
				       "column" "SEMDIST")
				 :onmouseover (over "hide" "semdists")
				 :onmouseout (out))
			     ((:img :border 0 :src "/assets/circle.gif"))))))))
	     #+ignore
	     ((:th :valign :top
		   :class "manila")
	      ((:a :href
		   (link "showall"))
	       "Show all")))
	       
	       
	  
	    (loop for (phdist sdist name gndr org syl str pron sems pop) 
		in names
		do (html
		    :newline
		    (:tr
		     (cond-emit (var "SHOW_NAME")
				:newline
				((:td :class "manila")
				 (:princ name)))
		     (cond-emit (var "SHOW_NAME")
				:newline
				((:td :class "manila")
				 ((:a :href (pron-link name)
				      :target "_new")
				  ((:img :border 0
					 :src "/assets/speaker.gif")))))
		     (cond-emit (var "SHOW_GENDER")
				:newline
				((:td :class "manila"
				      :align :center)
				 (when (string-equal gndr "M")
				   (html
				    ((:span :class "blue") 
				     (:princ "boy"))))
				 (when (string-equal gndr "F")
				   (html
				    ((:span :class "pink")
				     (:princ "girl"))))))
		     (cond-emit (var "SHOW_ORIGIN")
				:newline
				((:td :class "manila"
				      :align :center)
				 (:princ 
				  (gethash org *origins-map*))))
		     (cond-emit (var "SHOW_SYLLABLES")
				:newline
				((:td :class "manila")
				 (:princ syl)))
		     (cond-emit (var "SHOW_STRESS")
				:newline
				((:td :class "manila")
				 (:princ 
				  (gethash str *stresses-map*))))
		     (cond-emit (var "SHOW_PRON")
				:newline
				((:td :class "manila")
				 (:princ pron)))
		     (cond-emit (var "SHOW_MEANING")
				:newline
				((:td :class "manila")
				 (loop for sem in (canon-list sems)
				     do (html (:princ sem)
					      :newline))))
		     (cond-emit (var "SHOW_POPULARITY")
				:newline
				((:td :class "manila")
				 (let ((pop (parse-integer pop)))
				   (loop for (g min max dec interp)
				       in *popularity-map*
				       when (and (equal g gndr)
						 (<= min pop)
						 (<= pop max))
				       do 
					 (html
					  (dolist 
					      (url (pop-graphic-urls dec gndr))
					    (html
					     :br
					     ((:img :src url))))
					  :br
					  (:princ pop))
				     and do (return)))))
		     (cond-emit (var "SHOW_PHONDIST")
				:newline
				((:td :class "manila")
				 (:format "~4,2F" phdist)))
		     (cond-emit (var "SHOW_SEMDIST")
				:newline
				((:td :class "manila")
				 (:princ sdist)))))))))))))

;; 18 March 04

(def-clp-function nmb_list (req ent args body)
  (declare (ignorable args body))
  (nmb_list_fn req ent))

(defun gender-class (gender)
  (case-string-equal gender
    ("F" "pink")
    ("M" "blue")))

(defun emit-pop (pop gndr &key (lower-threshold 41))
  (loop for (g min max dec nil)
      in *popularity-map*
      when (and (equal g gndr)
		(<= min pop)
		(<= pop max))
      do (progn
	   (html
	    (dolist (url (pop-graphic-urls dec gndr))
	      (html
	       ((:img :src url))
	       (:princ "&nbsp;")
	       ((:span :class (gender-class g))
		(:princ (if (>= pop lower-threshold)
			    pop
			  "rare"))))))
	   (return))))

(defun nmb_list_fn (req ent)
  (declare (ignore ent))
  (let ((ws (websession-from-req req)))
    (setq www ws)
    (flet ((var (name)
	     (websession-variable ws name))
	   (smash (a b)
	     (append a b)))
      (macrolet ((cond-emit (flag &body body)
		   `(when ,flag
		      (html ,@body))))
	(let ((names (var "DATA")))
	  
	  (html
	   :br
	   (:princ "There are ")
	   (:princ (length names))
	   (:princ " names in your active set")
	   :br

	   ((:table :border 0 :cellpadding 0 :cellspacing 5 
		    :class "ltmanila")
	    (:tr
	     (cond-emit (var "SHOW_NAME")
			:newline
			((:th :valign :bottom
			      :colspan 2
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr 
			   ((:th :align :center
				 :colspan 3) "name")))))
	     (cond-emit (var "SHOW_GENDER")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "gender")))))
	     (cond-emit (var "SHOW_ORIGIN")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "origin")))))
	     (cond-emit (var "SHOW_SYLLABLES")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "syllables")))))
	     (cond-emit (var "SHOW_STRESS")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "stress")))))
	     (cond-emit (var "SHOW_PRON")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "pronunciation")))))
	     (cond-emit (var "SHOW_MEANING")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "meanings")))))
	     (cond-emit (var "SHOW_POPULARITY")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "popularity")))))
	     (cond-emit (var "SHOW_PHONDIST")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 :br
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "phonetic distance")))))
	     (cond-emit (var "SHOW_SEMDIST")
			:newline
			((:th :valign :bottom
			      :class "manila")
			 :br
			 ((:table :border 0
				  :cellpadding 5
				  :cellspacing 5)
			  (:tr
			   ((:th :align :center
				 :colspan 3) "semantic distance"))))))
	    
	    (let ((pivoted (pivot names)))
	      (loop for (phdist sdist name gndr org syl str pron sems pop) 
		  in pivoted
		;; pivoting will drop a pop if both genders agree on it
		  do (when (and (= (length gndr) 2)
				(= (length pop) 1))
		       (setq pop (list (car pop) (car pop))))
		  do (html
		      :newline
		      (:tr
		       (cond-emit (var "SHOW_NAME")
				  :newline
				  ((:td :class "manila")
				   ((:a :href (name-link (car name)
							 (member "M" gndr :test #'equal)
							 (member "F" gndr :test #'equal))
					:target "_new")
				    (:princ (car name)))))
		       (cond-emit (var "SHOW_NAME")
				  :newline
				  ((:td :class "manila")
				   ((:a :href (pron-link (car name))
					:target "_new")
				    ((:img :border 0
					   :src "/assets/speaker.gif")))))
		       (cond-emit (var "SHOW_GENDER")
				  :newline
				  ((:td :class "manila"
					:align :center)
				   (loop for (item . rest) on gndr do
				     (when (string-equal item "M")
				       (html
					((:span :class "blue") 
					 (:princ "boy"))))
				     (when (string-equal item "F")
				       (html
					((:span :class "pink")
					 (:princ "girl"))))
				     (when rest
				       (html :br)))))
		       (cond-emit (var "SHOW_ORIGIN")
				  :newline
				  ((:td :class "manila"
					:align :center)
				   (loop for (item . rest) on org
				       do (html
					   (:princ
					    (gethash item *origins-map*)))
				       when rest
				       do (html 
					   :br))))
		       (cond-emit (var "SHOW_SYLLABLES")
				  :newline
				  ((:td :class "manila")
				   (loop for (item . rest) on syl
				       do (html (:princ item))
				       when rest
				       do (html
					   :br))))
		       (cond-emit (var "SHOW_STRESS")
				  :newline
				  ((:td :class "manila")
				   (loop for (item . rest) on str
				       do (html 
					   (:princ 
					    (gethash item *stresses-map*)))
				       when rest
				       do (html
					   :br))))
		       (cond-emit (var "SHOW_PRON")
				  :newline
				  ((:td :class "manila")
				   (loop for (item . rest) 
				       on pron
				       do (html 
					   (:princ item))
				       when rest
				       do (html
					   :br))))
		       #+OLD
		       (cond-emit (var "SHOW_MEANING")
				  :newline
				  ((:td :class "manila")
				   (loop for (item . rest)
				       on (canon-list sems)
				       do (html
					   (:princ item))
				       when rest
				       do (html
					   (:princ-safe #\;)
					   :br))))
		       (cond-emit (var "SHOW_MEANING")
				  :newline
				  ((:td :class "manila")
				   (:ul
				    (loop for (item . rest)
					on (canon-list sems)
					do (html
					    (:li (:princ-safe item)))))))
		       (cond-emit 
			(var "SHOW_POPULARITY")
			:newline
			((:td :class "manila")
			 (loop for (item . rest)
			     on pop
			     as g in gndr
			     do (emit-pop (ensure-integer item) g)
			     when rest
			     do (html :br))))
		       (cond-emit (var "SHOW_PHONDIST")
				    :newline
				    ((:td :class "manila")
				     (loop for (item . rest)
					 on phdist
					 do (html
					     (:format "~4,2F" item))
					 when rest
					 do (html :br))))
		       (cond-emit (var "SHOW_SEMDIST")
				  :newline
				  ((:td :class "manila")
				   (loop for (item . rest)
				       on sdist
				       do (html
					   (:princ item))
				       when rest
				       do (html :br)))))
		       ))))))))))


(defun transpose (list-of-lists)
  (apply #'mapcar #'list list-of-lists))

(defun pivot (data)
  (let ((tuple-sets (group data 
			   :pivot #'third
			   :test #'equal
			   :pairwise nil
			   :action #'list)))
    (mapcar #'(lambda (tuples)
		(mapcar #'(lambda (p)
			    (stable-remove-duplicates p :test #'equalp))
			(transpose tuples)))
	    tuple-sets)))
  

(defmethod my-write-csv-file-line (stream (row list) &key (nullrep "NULL"))
  (if (and (cdr row) (not (listp (cdr row))))
      (edu.isi.isd.nlp.adt.file.csv.philpot::write-csv-file-cons stream row :nullrep nullrep)
    (let ((*print-pretty* nil)
	  (at-start t))
      (fresh-line stream)
      (loop for item in row
	  unless at-start
	  do (progn (write-char #\, stream))
	  do (setq at-start nil)
	  do (when (symbolp item)
	       (setq item (symbol-name item)))
	  do (when (typep item 'double-float)
	       (setq item (coerce item 'single-float)))
	  do (cond ((null item) 
		    (write-string nullrep stream))
		   ((stringp item)
		    (write-char #\" stream)
		    (edu.isi.isd.nlp.adt.file.csv.philpot::write-sql-string item stream)
		    (write-char #\" stream))
		   (t (write item :stream stream))))
      (values))))

(defun action-writecsv (req ent)
  (with-http-response (req ent :content-type "text/plain")
    (loop for line in (websession-variable (websession-from-req req)
					   "DATA")
	do (my-write-csv-file-line *html-stream* line))))

(def-clp-function nmb_writecsv (req ent args body)
  (declare (ignorable ent args body))
  (nmb_writecsv_fn req))

(defun nmb_writecsv_fn (req)
  (loop for line in 
	(websession-variable (websession-from-req req) "DATA")
      as readable = (list
		     (first line)
		     (second line)
		     (third line)
		     (case-equal (fourth line)
		       ("M" "boy")
		       ("F" "girl"))
		     (gethash (fifth line) *origins-map*)
		     (sixth line)
		     (gethash (seventh line) *stresses-map*)
		     (format nil "~{~A~^ ~}" (coerce (eighth line) 'list))
		     (ninth line)
		     (tenth line))
      do (my-write-csv-file-line *html-stream* readable)))

(def-clp-function nmb_writecolumns (req ent args body)
  (declare (ignorable req ent args body))
  (nmb_writecolumns_fn req))

(defun nmb_writecolumns_fn (req)
  (declare (ignore req))
  (my-write-csv-file-line 
   *html-stream*
   '("Phonetic_Distance"
     "Semantic_Distance"
     "Name"
     "Gender"
     "Origin"
     "Syllables"
     "Stress"
     "Pronunciation"
     "Meaning"
     "Popularity_2001_Census")))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(def-clp-function nmb_browse_meanings (req ent args body)
  (declare (ignorable args body))
  (nmb_browse_meanings_fn req ent))

(defun lexico< (i1 i2)
  (let ((l1 (length i1))
	(l2 (length i2)))
    (loop for j1 from 0 below l1
	as x1 across i1
	as x2 across i2
      when (> x1 x2) do (return-from lexico< nil)
      else when (< x1 x2) do (return-from lexico< t))
    (< l1 l2)))

(defun has-children (addr ht)
  (gethash addr ht))

(defun ordered-meanings ()
  (let ((index (make-hash-table :test #'equalp))
	(childp (make-hash-table :test #'equalp))
	(v (make-array '(0) :fill-pointer 0 :adjustable t)))
    (loop for (sem addr) in (db "select sem, addr from semaddr")
	as ints = (map 'vector #'parse-integer (split-char #\space addr))
	do (push sem (gethash ints index))
	do (vector-push-extend ints v))
    (setq v (sort v #'lexico<))
    (loop for addr across v
	as length = (length addr)
	when (> length 2)
	do (setf (gethash (subseq addr 0 (- length 1)) childp) t))
    (values v index childp)))

(defun nmb_browse_meanings_fn (req ent)
  (multiple-value-bind (vector ht kidp) (ordered-meanings)
    (let ((seen (make-hash-table :test #'equal)))
      (html 
       (:pre
	(:small
	 (loop for addr across vector
	     do (html :br
		      ;; (:princ addr)
		      ;; (:princ "&nbsp;")
		      (let* ((m (canon-atom (gethash addr ht)))
			     (s (gethash m seen)))
			(dotimes (i (* 2 (length addr)))
			  (html (:princ "&nbsp;")))
			(if s 
			    (html ((:font :color "RED")
				   (:princ m)))
			  (html ((:font :color "GREEN")
				 (:princ m))))
			(incf (gethash m seen 0)))))))))))

(defun make-node (level)
  (format nil "aux~D" level))

(defun make-url (level)
  (format nil "ftbase~D" level))  

(defun nmb_browse_meanings_js_fn (outfile)
  (with-open-file (stream outfile
		   :direction :output
		   :if-does-not-exist :create
		   :if-exists :new-version)
    (format stream "~&iconFolder = \"../images/\"")
    (format stream "~%ftFolder = \"../\"")
    (format stream "~%~A = gFld(\"<i>Been There</i>\", \"~A\")"
	    (make-node 0)
	    (make-url 0))

    (multiple-value-bind (vector ht kidp) (ordered-meanings)
      (loop for addr across vector
	  do (let ((m (canon-atom (gethash addr ht)))
		   (lvl (length addr)))
	       (if (has-children addr kidp)
		   (format stream "~&insDoc(aux~D,gLnk(\"~A\",\"view?meaning=~A\"))~%"
			 lvl
			 m
			 (html-code-string m))
		 (format stream "~&~A=insFld(~A,gFld(\"~A\",\"view?meaning=~A\"))~%"
			   (make-node lvl)
			   (make-node (1- lvl))
			   m
			   (html-code-string m))))))))



(def-clp-function nmb_bootie_logo (req ent args body)
  (nmb_bootie_logo_fn req ent args body))

(defun nmb_bootie_logo_fn (req ent args body)
  (declare (ignore req ent args body))
  (macrolet ((pink () '(:td ((:img :border 0 :src "assets/pink.jpg")) :newline))
	     (blue () '(:td ((:img :border 0 :src "assets/blue.jpg")) :newline))
	     (green () '(:td ((:img :border 0 :src "assets/green.jpg")) :newline))
	     (white () '(:td ((:img :border 0 :width 49 :height 36 :src "assets/clearpixel.gif")) :newline)))
    (html
     (:center
      ((:table :border 0 :cellpadding 0 :cellspacing 0)
       (:tr (pink) (white) (white) (white) 
	    (white)
	    (blue) (white) (white) (blue)
	    (white)
	    (green) (white) (white) (white) (green))
       :newline
       (:tr (pink) (white) (white) (white) 
	    (white)
	    (blue) (white) (white) (blue)
	    (white)
	    (white) (green) (white) (green) (white))
       :newline
       (:tr (pink) (white) (white) (white) 
	    (white)
	    (blue) (white) (white) (blue)
	    (white)
	    (white) (white) (green) (white) (white))
       :newline
       (:tr (pink) (white) (white) (white) 
	    (white)
	    (blue) (white) (white) (blue)
	    (white)
	    (white) (green) (white) (green) (white))
       :newline
       (:tr (pink) (pink) (pink) (pink)
	    (white)
	    (white) (blue) (blue) (white)
	    (white)
	    (green) (white) (white) (white) (green)))))))

(def-clp-function nmb_logo (req ent args body)
  (nmb_bootie_logo_fn req ent args body))

(defun nmb_bootie_logo_fn (req ent args body)
  (declare (ignore req ent args body))
  (html
   ((:img :src "assets/nmb.jpg"))))

(defun new-id ()
  (gentemp "ID"))

(def-clp-function nmb_login_form (req ent args body)
  (declare (ignore req ent args body))
  (nmb_login_form_fn))

(defun nmb_login_form_fn ()
  (html
   ((:form :name :nmb_login
	   :action "gotlogin")
    :newline
    ((:input :type :text :name "USERNAME" :value (new-id)))
    :newline
    ((:input :type :submit :value "Start")))))


(defvar *uniq* 0)

(def-clp-function nmb_excel_link (req ent args body)
  (declare (ignore req ent args body))
  (nmb_excel_link_fn))

(defun nmb_excel_link_fn ()
  (html
   ((:a :class "buttonlike"
	:href (format nil "excel?link=~D" (incf *uniq*)))
    "Excel spreadsheet (.xls) file")))

#||

aux1 = insFld(fT, gFld("Europe", "ftbase2.htm"))
aux2 = insFld(aux1, gFld("United Kingdom", "ftbase3.htm"))
aux3 = insFld(aux2, gFld("Scotland", "ftbase.htm"))
insDoc(aux3, gLnk("Edinburgh", "ftbase2.htm"))
insDoc(aux2, gLnk("London", "ftbase3.htm"))
aux2 = insFld(aux1, gFld("Germany", "ftbase.htm"))
insDoc(aux2, gLnk("Munich", "ftbase2.htm"))
aux2 = insFld(aux1, gFld("Greece", "ftbase3.htm"))
insDoc(aux2, gLnk("Athens", "ftbase.htm"))
aux2 = insFld(aux1, gFld("Italy", "ftbase2.htm"))
aux3 = insFld(aux2, gFld("Tuscany", "ftbase3.htm"))	
insDoc(aux3, gLnk("Florence", "ftbase.htm"))
insDoc(aux3, gLnk("Pisa", "ftbase2.htm"))
insDoc(aux2, gLnk("Rome", "ftbase3.htm"))
aux2 = insFld(aux1, gFld("Portugal", "ftbase.htm"))
insDoc(aux2, gLnk("Lisboa", "ftbase2.htm"))
aux1 = insFld(fT, gFld("America", "ftbase3.htm"))
aux2 = insFld(aux1, gFld("Canada", "ftbase.htm"))
insDoc(aux2, gLnk("Montreal", "ftbase2.htm"))
aux2 = insFld(aux1, gFld("United States", "ftbase3.htm"))
insDoc(aux2, gLnk("Boston", "ftbase.htm"))
insDoc(aux2, gLnk("New York", "ftbase2.htm"))
insDoc(aux2, gLnk("Washington", "ftbase3.htm"))
insDoc(aux2, gLnk("Atlanta", "ftbase3.htm"))

||#

(def-clp-function nmb_origin_count (req ent args body)
  (declare (ignore ent body))
  (with-vars (req args)
    (nmb_origin_count_fn (var "ORIGIN" :args))))

(defun nmb_origin_count_fn (origin)
  (html
   (:princ (origin-count origin))))

(defun origin-count (origin)
  (caar (dbl :namemybaby "select count(*) from name where
  origin = '~A'" origin)))

(eval-when (load eval)
  (memoize 'origin-count))

(defun name-link (name masc-p fem-p)
  (format nil "detail?name=~A&gender=~A" 
	  name
	  (cond ((and masc-p fem-p) "B")
		(masc-p "M")
		(t "F"))))

(def-clp-function nmb_detail (req ent args body)
  (declare (ignore ent body))
  (with-vars (req args)
    (nmb_detail_fn (var "name" :query)
		   (var "gender" :query))))

(defun nmb_detail_fn (name gender)
  (multiple-value-bind (tuples cols)
      (dbl :namemybaby 
	   "SELECT distinct n.name,n.gender,n.origin,n.syllables,n.stresspat,
p.pron,s.sem, n.popularity
FROM name n,pron p,sem s
WHERE n.name = p.name
AND s.name = n.name
AND s.name = '~A'" name)
    (dolist (tuple tuples)
      (html 
       :br
       (:princ-safe 
	(mapcar #'list cols tuple)))))
  (html
   :br
   "Other related names"
   (:ul
    (loop for (r2name) in 
	  (dbl :namemybaby
	       "SELECT r2.name from rel r2, rel r1
WHERE r1.name='~A'
AND r1.root=r2.root
AND r2.name !=r1.name"
	       name)
	do (html :newline (:li (:princ r2name))))))

  (html
   :br
   "Actual people (some famous, some not) with the name "
   (:b (:princ name))
   " (from newspapers &amp; web pages collected in 1999-2000): "
   (:ul
    (loop for (instance fullnounphrase) 
	in (dbl :namemybaby 
		"SELECT distinct instance,fullnounphrase
FROM instances
WHERE name='~A'
ORDER BY instance,fullnounphrase" name)
	do (html (:li (:princ instance)
		      ","
		      (:princ "&nbsp;")
		      (:princ fullnounphrase)))))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#+ignore
(dbl :namesearch 
     "SELECT p1.pron,r1.root,p2.pron,r2.root
FROM pron p1, rel r1, pron p2, rel r2
WHERE p1.pron=p2.pron
AND p1.name!=p2.name
AND p1.name=r1.name
AND p2.name=r2.name
AND r1.root!=r2.root")


