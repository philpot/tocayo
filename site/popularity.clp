<html>
<nmb_choose_type type="popularity" session/>
<head>
<title>NameMyBaby: <clp_value name="type" session/></title>
<clp_include name="css.clp"/>
</head>
<body>
<clp_include name="scripts.clp"/>

<center>
<form NAME="mainform" METHOD="POST" ACTION="switch">
<input TYPE="HIDDEN" NAME="DEST" VALUE="lookup">
<input TYPE="HIDDEN" NAME="SRC" VALUE="popularity">
<table BORDER=0 CELLPADDING=0 CELLSPACING=0>
<clp_include name="tabpanel.clp"/>
<tr><td COLSPAN=7 class="manila"><table BORDER=0
CELLPADDING=15><tr><td ALIGN="CENTER"><img SRC="assets/clearpixel.gif"
WIDTH=600 HEIGHT=1></td></tr><tr><td ALIGN="CENTER"><table BORDER=0
BGCOLOR="#0000FF" CELLPADDING=10 CELLSPACING=10><tr><td ALIGN="CENTER"
BGCOLOR="#66BBFF">

<span
CLASS="posfontbold">Popularity</span></td></tr><tr><td ALIGN="CENTER"
BGCOLOR="#66BBFF"><table BORDER=1><tr><td>Top&nbsp;10%</td>
<td>
<input TYPE="CHECKBOX" 
       NAME="POP" 
       VALUE=1
       <clp_ifmember name="POP" value="1" session>CHECKED</clp_ifmember>></td>
<td><i>e.g., Michael, Ashley</i></td></tr><tr><td>2nd&nbsp;10%</td>
<td>
<input TYPE="CHECKBOX" 
       NAME="POP" 
       VALUE=2
       <clp_ifmember name="POP" value="2" session>CHECKED</clp_ifmember>></td>
<td><i>e.g., Brittany, Jacob</i></td></tr><tr><td>3rd&nbsp;10%</td>
<td>
<input TYPE="CHECKBOX" 
       NAME="POP" 
       VALUE=3
       <clp_ifmember name="POP" value="3" session>CHECKED</clp_ifmember>></td>
<td><i>e.g., Brandon, Rachel</i></td></tr><tr><td>4th&nbsp;10%</td>
<td>
<input TYPE="CHECKBOX" 
       NAME="POP" 
       VALUE=4
       <clp_ifmember name="POP" value="4" session>CHECKED</clp_ifmember>></td>
<td><i>e.g., Robert, Melissa</i></td></tr><tr><td>5th&nbsp;10%</td>
<td>
<input TYPE="CHECKBOX" 
       NAME="POP" 
       VALUE=5
       <clp_ifmember name="POP" value="5" session>CHECKED</clp_ifmember>></td>
<td><i>e.g., Benjamin, Laura</i></td></tr><tr><td>6th&nbsp;10%</td>
<td>
<input TYPE="CHECKBOX" 
       NAME="POP" 
       VALUE=6
       <clp_ifmember name="POP" value="6" session>CHECKED</clp_ifmember>></td>
<td><i>e.g., Luis, Emma</i></td></tr><tr><td>7th&nbsp;10%</td>
<td>
<input TYPE="CHECKBOX" 
       NAME="POP" 
       VALUE=7
       <clp_ifmember name="POP" value="7" session>CHECKED</clp_ifmember>></td>
<td><i>e.g., Corey, Bailey</i></td></tr><tr><td>8th&nbsp;10%</td>
<td>
<input TYPE="CHECKBOX" 
       NAME="POP" 
       VALUE=8
       <clp_ifmember name="POP" value="8" session>CHECKED</clp_ifmember>></td>
<td><i>e.g., Elijah, Kirsten</i></td></tr><tr><td>9th&nbsp;10%</td>
<td>
<input TYPE="CHECKBOX" 
       NAME="POP" 
       VALUE=9
       <clp_ifmember name="POP" value="9" session>CHECKED</clp_ifmember>></td>
<td><i>e.g., Brady, Jada</i></td></tr><tr><td>Bottom&nbsp;10%</td>
<td>
<input TYPE="CHECKBOX" 
       NAME="POP" 
       VALUE=10
       <clp_ifmember name="POP" value="10" session>CHECKED</clp_ifmember>></td>
<td><i>e.g., Leonardo, Paris</i></td></tr></table></td></tr><tr><td ALIGN="RIGHT" BGCOLOR="#66BBFF">
<input TYPE="CHECKBOX" 
       NAME="POP" 
       ONCLICK="preset(this.name,'WILD',this);"><span CLASS="posfontbold">any popularity</span></td></tr></table><br>
<clp_include name="bottom.clp"/></td></tr></table></td></tr></table></form></center></body></html>
