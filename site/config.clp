<html>
<nmb_choose_type type="config" session/>
<head>
<title>NameMyBaby: <clp_value name="type" session/></title>
<clp_include name="css.clp"/>
</head>
<body>

<clp_include name="scripts.clp"/>

<center>
<form NAME="mainform" METHOD="POST" ACTION="switch">
<input TYPE="HIDDEN" NAME="DEST" VALUE="lookup">
<input TYPE="HIDDEN" NAME="SRC" VALUE="config">
<table BORDER=0 CELLPADDING=0 CELLSPACING=0>
<tr>

<clp_include name="tabpanel.clp"/>

<tr><td COLSPAN=7 class="manila"><table BORDER=0 CELLPADDING=15><tr><td ALIGN="CENTER"><img SRC="assets/clearpixel.gif" WIDTH=600 HEIGHT=1></td></tr><tr><td ALIGN="CENTER"><table BORDER=0 BGCOLOR="#0000FF" CELLPADDING=10 CELLSPACING=10><tr><td ALIGN="CENTER" BGCOLOR="#66BBFF"><span CLASS="posfontbold">Config</span></td></tr><tr><td ALIGN="CENTER" BGCOLOR="#66BBFF"><table BORDER=1><tr>
<td>User Mode
<input TYPE="RADIO" 
       NAME="MODE" 
       VALUE="USER" 
       <clp_ifmember name="MODE" value="USER"
       session>CHECKED</clp_ifmember>>
</td>
<td>Wizard Mode
<input TYPE="RADIO" 
       NAME="MODE"
       VALUE="WIZARD" 
       <clp_ifmember name="MODE" value="WIZARD"
       session>CHECKED</clp_ifmember>>
</td>
</td></td></tr></table>
</td></tr></table><br>
<clp_include name="bottom.clp"/></td></tr></table></td></tr></table></form></center></body></html>
