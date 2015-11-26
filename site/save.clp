<html>
<nmb_choose_type type="save" session/>
<head>
<title>NameMyBaby: <clp_value name="type" session/></title>
<clp_include name="css.clp"/>
</head>
<body>

<clp_include name="scripts.clp"/>

<center>
<form NAME="mainform" METHOD="POST" ACTION="switch">
<input TYPE="HIDDEN" NAME="DEST" VALUE="save">
<input TYPE="HIDDEN" NAME="SRC" VALUE="save">
<table BORDER=0 CELLPADDING=0 CELLSPACING=0>


<clp_include name="tabpanel.clp"/>

<tr>
<td COLSPAN=7 class="manila">
<table BORDER=0 CELLPADDING=15>
<tr><td ALIGN="CENTER"><img SRC="assets/clearpixel.gif" WIDTH=600 HEIGHT=1></td></tr>
<tr><td ALIGN="CENTER"><table BORDER=0 BGCOLOR="#0000FF" CELLPADDING=10 CELLSPACING=10>
<tr><td ALIGN="CENTER" BGCOLOR="#66BBFF"><span CLASS="posfontbold">Save</span></td></tr>
<tr><td ALIGN="CENTER" BGCOLOR="#66BBFF">
<nmb_excel_link/>
<br>
<a class="buttonlike" target="_blank" href="/csv">Comma-separated
text(.csv) file</a>
</td>
</tr>
</table><br>
<clp_include name="bottom.clp"/></td></tr></table></td></tr></table></form>

<form name="saveform" target="_blank" method="GET" action="/dummy">
<!--
<input type="SUBMIT" value="Generate Excel/CSV file">
-->

<!--
<a target="_blank" HREF="http://blombos.isi.edu/cgi-bin/printenv">printenv</A>
<a target="_blank" HREF="http://blombos.isi.edu:8888/wc">wc</a>
<a target="_blank" HREF="file3.clp">file3.clp</A>
<a target="_blank" HREF="writecsv">writecsv</A>
<a target="_blank" HREF="postscript">postscript</A>
<a target="_blank" HREF="postscript.ps">postscript.ps</A>
<a target="_blank" HREF="/data">data</A>
<a target="_blank" HREF="/showdata">showdata</A>
<a target="_blank" HREF="/dummy">dummy</A>
-->
</form>


</center></body></html>
