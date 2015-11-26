<html>
<nmb_choose_type type="gender" session/>
<head>
<title>NameMyBaby: <clp_value name="type" session/></title>
<clp_include name="css.clp"/>
</head>
<body>

<clp_include name="scripts.clp"/>

<center>
<form NAME="mainform" METHOD="POST" ACTION="switch">
<input TYPE="HIDDEN" NAME="DEST" VALUE="lookup">
<input TYPE="HIDDEN" NAME="SRC" VALUE="gender">
<table BORDER=0 CELLPADDING=0 CELLSPACING=0>
<tr>
<clp_include name="tabpanel.clp"/>
<tr><td COLSPAN=7 class="manila"><table BORDER=0 CELLPADDING=15><tr><td ALIGN="CENTER"><img SRC="assets/clearpixel.gif" WIDTH=600 HEIGHT=1></td></tr><tr><td ALIGN="CENTER"><table BORDER=0 BGCOLOR="#0000FF" CELLPADDING=10 CELLSPACING=10><tr><td ALIGN="CENTER" BGCOLOR="#66BBFF"><span CLASS="posfontbold">Gender</span></td></tr><tr><td ALIGN="CENTER" BGCOLOR="#66BBFF"><table BORDER=1><tr>
<td>Girl
<input TYPE="CHECKBOX" 
       NAME="GENDER" 
       VALUE="F" 
       ONCLICK="unset(this.name,'ANY',this);"
       <clp_ifmember name="GENDER" value="F"
       session>CHECKED</clp_ifmember>>
</td>
<td>Boy
<input TYPE="CHECKBOX" 
       NAME="GENDER"
       VALUE="M" 
       ONCLICK="unset(this.name,'ANY',this);"
       <clp_ifmember name="GENDER" value="M" session>CHECKED</clp_ifmember>>
</td>
<td>Either
<input TYPE="CHECKBOX" 
       NAME="GENDER" 
       VALUE="ANY" 
       ONCLICK="preset(this.name,'WILD',this);"
       <clp_ifmember name="GENDER" value="ANY" session>CHECKED</clp_ifmember>>
</td></td></tr></table>
</td></tr></table><br>
<clp_include name="bottom.clp"/></td></tr></table></td></tr></table></form></center></body></html>
