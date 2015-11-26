<html>
<nmb_choose_type type="syllables" session/>
<head>
<title>NameMyBaby: <clp_value name="type" session/></title>
<clp_include name="css.clp"/>
</head>
<body>
<clp_include name="scripts.clp"/>

<center>
<form NAME="mainform" METHOD="POST" ACTION="switch">
<input type=hidden name="DEST" value="lookup">
<input type=hidden name="SRC" value="syllables">
<table BORDER=0 CELLPADDING=0 CELLSPACING=0>
<clp_include name="tabpanel.clp"/>
<tr><td COLSPAN=7 class="manila"><table BORDER=0 CELLPADDING=15><tr><td ALIGN="CENTER"><img SRC="assets/clearpixel.gif" WIDTH=600 HEIGHT=1></td></tr><tr><td ALIGN="CENTER"><table BORDER=0 BGCOLOR="#0000FF" CELLPADDING=10 CELLSPACING=10><tr><td ALIGN="CENTER" BGCOLOR="#66BBFF"><span CLASS="posfontbold">Syllables</span></td><td ALIGN="CENTER" BGCOLOR="#66BBFF"><span CLASS="posfontbold">Stress Pattern</span></td></tr><tr><td BGCOLOR="#66BBFF">
<input NAME="MINSYL" 
       SIZE=3 
       VALUE="<clp_firstvalue name="MINSYL" session/>"
       ONCHANGE="val(document.mainform.MINSYL);
order(document.mainform.MINSYL,document.mainform.MAXSYL);
modify(document.mainform.STRESS,document.mainform.MINSYL.value,document.mainform.MAXSYL.value);">

&nbsp;to&nbsp;
<input NAME="MAXSYL" 
       SIZE=3 
       VALUE="<clp_firstvalue name="MAXSYL" session/>"
       ONCHANGE="val(document.mainform.MAXSYL);order(document.mainform.MINSYL,document.mainform.MAXSYL);modify(document.mainform.STRESS,document.mainform.MINSYL.value,document.mainform.MAXSYL.value);">
&nbsp;<i>
(1&nbsp;to&nbsp;5)</i></td>
<td BGCOLOR="#66BBFF">

<nmb_syllableselect session/>

</td></tr></table><br>

<clp_include name="bottom.clp"/>
</td></tr></table></td></tr></table></form></center></body></html>
