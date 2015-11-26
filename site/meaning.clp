<html>
<nmb_choose_type type="meaning" session/>
<head>
<title>NameMyBaby: <clp_value name="type" session/></title>
<clp_include name="css.clp"/>
</head>
<body>
<clp_include name="scripts.clp"/>

<center>
<form NAME="mainform" METHOD="POST" ACTION="switch">
<table BORDER=0 CELLPADDING=0 CELLSPACING=0>
<input type=hidden name="DEST" value="lookup">
<input type=hidden name="SRC" value="meaning">
<clp_include name="tabpanel.clp"/>
<tr><td COLSPAN=7 class="manila"><table BORDER=0
CELLPADDING=15><tr><td ALIGN="CENTER"><img SRC="assets/clearpixel.gif"
WIDTH=600 HEIGHT=1></td></tr><tr><td ALIGN="CENTER">

<table class="searchoutline" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td>
<table class="searchframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td class="search" colspan=2 align=center>
<span class="searchfontbold">Meaning</span>
</td>
</tr>
<tr>
<td class="search">
<span class="searchfont">&nbsp;Return names whose meaning is&nbsp;</span>

<select name="SEMSRCHLIMIT">
<option value="ALL" <clp_ifmember name="SEMSRCHLIMIT" value="ALL" session>selected</clp_ifmember>>[return all names]</option>
<option value="1"   <clp_ifmember name="SEMSRCHLIMIT" value="ALL" session>selected</clp_ifmember>>extremely similar</option>
<option value="2"   <clp_ifmember name="SEMSRCHLIMIT" value="ALL" session>selected</clp_ifmember>>very similar</option>
<option value="3"   <clp_ifmember name="SEMSRCHLIMIT" value="ALL" session>selected</clp_ifmember>>somewhat similar</option>
<option value="5"   <clp_ifmember name="SEMSRCHLIMIT" value="ALL" session>selected</clp_ifmember>>similar</option>
</select>

<span class="searchfont">&nbsp;to&nbsp;</span>
<input name="SEMSRCHROOT" size=12 value=<clp_firstvalue
name="SEMSRCHROOT" session/>>
&nbsp;
[<a href="sembrowse">Browse all meanings</a>]
&nbsp;
</td>
</tr>
</table>
</td>
</tr>
</table>

<br>

<br>
<clp_include name="bottom.clp"/></td></tr></table></td></tr>

</table></form></center></body></html>
