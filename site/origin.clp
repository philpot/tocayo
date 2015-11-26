<html>
<nmb_choose_type type="origin" session/>
<head>
<title>NameMyBaby: <clp_value name="type" session/></title>
<clp_include name="css.clp"/>
</head>
<body>
<clp_include name="scripts.clp"/>

<center>
<form NAME="mainform" METHOD="POST" ACTION="switch">
<input TYPE="HIDDEN" NAME="DEST" VALUE="lookup">
<input TYPE="HIDDEN" name="SRC" VALUE="origin">
<table BORDER=0 CELLPADDING=0 CELLSPACING=0>
<clp_include name="tabpanel.clp"/>
<tr><td COLSPAN=7 class="manila"><table BORDER=0 CELLPADDING=15><tr><td ALIGN="CENTER"><img SRC="assets/clearpixel.gif" WIDTH=600 HEIGHT=1></td></tr><tr><td ALIGN="CENTER">

<table BGCOLOR="#0000FF" BORDER=0 CELLPADDING=5 CELLSPACING=10>
<tr>
<td align="center" colspan=4 BGCOLOR="#3399FF">
<span CLASS="posfontbold">Origin</span>
</td>
</tr>

<tr>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">African (<nmb_origin_count ORIGIN="A1"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="A1" 
<clp_ifmember name="ORIGIN" value="A1" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Farsi (<nmb_origin_count ORIGIN="FA"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="FA"
<clp_ifmember name="ORIGIN" value="FA" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Hungarian (<nmb_origin_count ORIGIN="HU"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="HU"
<clp_ifmember name="ORIGIN" value="HU" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Welsh (<nmb_origin_count ORIGIN="CY"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="CY"
<clp_ifmember name="ORIGIN" value="CY" session>checked</clp_ifmember>></td></tr>
<tr>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">African-American (<nmb_origin_count ORIGIN="A2"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="A2"
<clp_ifmember name="ORIGIN" value="A2" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">French (<nmb_origin_count ORIGIN="FR"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="FR"
<clp_ifmember name="ORIGIN" value="FR" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Italian (<nmb_origin_count ORIGIN="IT"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="IT"
<clp_ifmember name="ORIGIN" value="IT" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Vietnamese (<nmb_origin_count ORIGIN="VI"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="VI"
<clp_ifmember name="ORIGIN" value="VI" session>checked</clp_ifmember>></td></tr>
<tr>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Arabic (<nmb_origin_count ORIGIN="AR"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="AR"
<clp_ifmember name="ORIGIN" value="AR" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Gaelic (<nmb_origin_count ORIGIN="G1"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="G1"
<clp_ifmember name="ORIGIN" value="G1" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Japanese (<nmb_origin_count ORIGIN="JA"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="JA"
<clp_ifmember name="ORIGIN" value="JA" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Turkish (<nmb_origin_count ORIGIN="TR"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="TR"
<clp_ifmember name="ORIGIN" value="TR" session>checked</clp_ifmember>></td></tr>
<tr>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Armenian (<nmb_origin_count ORIGIN="HY"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="HY"
<clp_ifmember name="ORIGIN" value="HY" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">German (<nmb_origin_count ORIGIN="DE"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="DE"
<clp_ifmember name="ORIGIN" value="DE" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Latin (<nmb_origin_count ORIGIN="LA"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="LA"
<clp_ifmember name="ORIGIN" value="LA" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Swahili (<nmb_origin_count ORIGIN="SW"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="SW"
<clp_ifmember name="ORIGIN" value="SW" session>checked</clp_ifmember>></td></tr>
<tr>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Cambodian (<nmb_origin_count ORIGIN="KM"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="KM"
<clp_ifmember name="ORIGIN" value="KM" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Greek (<nmb_origin_count ORIGIN="EL"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="EL"
<clp_ifmember name="ORIGIN" value="EL" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Polish (<nmb_origin_count ORIGIN="PL"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="PL"
<clp_ifmember name="ORIGIN" value="PL" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Spanish (<nmb_origin_count ORIGIN="ES"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="ES"
<clp_ifmember name="ORIGIN" value="ES" session>checked</clp_ifmember>></td></tr>
<tr>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Chinese (<nmb_origin_count ORIGIN="ZH"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="ZH"
<clp_ifmember name="ORIGIN" value="ZH" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Hawaiian (<nmb_origin_count ORIGIN="H1"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="H1"
<clp_ifmember name="ORIGIN" value="H1" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Portuguese (<nmb_origin_count ORIGIN="PT"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="PT"
<clp_ifmember name="ORIGIN" value="PT" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Slavic (<nmb_origin_count ORIGIN="S2"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="S2"
<clp_ifmember name="ORIGIN" value="S2" session>checked</clp_ifmember>></td></tr>
<tr>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Dutch (<nmb_origin_count ORIGIN="NL"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="NL"
<clp_ifmember name="ORIGIN" value="NL" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Hebrew (<nmb_origin_count ORIGIN="HE"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="HE"
<clp_ifmember name="ORIGIN" value="HE" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Russian (<nmb_origin_count ORIGIN="RU"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="RU"
<clp_ifmember name="ORIGIN" value="RU" session>checked</clp_ifmember>></td></tr>
<tr>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">English (<nmb_origin_count ORIGIN="EN"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="EN"
<clp_ifmember name="ORIGIN" value="EN" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Hindi (<nmb_origin_count ORIGIN="HI"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="HI"
<clp_ifmember name="ORIGIN" value="HI" session>checked</clp_ifmember>></td>
<td BGCOLOR="#66BBFF" ALIGN="RIGHT" BGCOLOR="#FFFFFF">Scandinavian (<nmb_origin_count ORIGIN="S1"/>)<input TYPE="CHECKBOX" NAME="ORIGIN" VALUE="S1"
<clp_ifmember name="ORIGIN" value="S1" session>checked</clp_ifmember>></td></tr>
<tr><td COLSPAN=4 ALIGN="RIGHT" BGCOLOR="#3399FF"><span CLASS="posfontbold">any origin</span><input TYPE="CHECKBOX" NAME="ORIGIN" ONCLICK="preset(this.name,'WILD',this);"></td></tr></table><br>
<br>
<clp_include name="bottom.clp"/></td></tr></table></td></tr></table></form></center></body></html>
