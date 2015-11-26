<html>
<nmb_choose_type type="sound" session/>
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
<input type=hidden name="SRC" value="sound">
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
<span class="searchfontbold">Sounds Like...</span>
</td>
</tr>
<tr>
<td class="search">
<span class="searchfont">&nbsp;Return names which sound&nbsp;</span>

<I><clp_value name="SNDSRCHLIMIT" session></I>

<select name="SNDSRCHLIMIT">
<option value="ALL" <clp_ifmember name="SNDSRCHLIMIT" value="ALL" session>selected</clp_ifmember>>[return all names]</option>
<option value="1"   <clp_ifmember name="SNDSRCHLIMIT" value="1"   session>selected</clp_ifmember>>extremely similar</option>
<option value="2"   <clp_ifmember name="SNDSRCHLIMIT" value="2"   session>selected</clp_ifmember>>very similar</option>
<option value="3"   <clp_ifmember name="SNDSRCHLIMIT" value="3"   session>selected</clp_ifmember>>somewhat similar</option>
<option value="5"   <clp_ifmember name="SNDSRCHLIMIT" value="5"   session>selected</clp_ifmember>>similar</option>
</select>

<span class="searchfont">&nbsp;to the sound of name&nbsp;</span>
<input name="SNDSRCHROOT" size=12 value=<clp_firstvalue
name="SNDSRCHROOT" session/>>
&nbsp;
</td>
</tr>
</table>
</td>
</tr>
</table>

<br>

<table class="posoutline" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td>
<table class="posframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 ALIGN="CENTER" class="positive"><span CLASS="posfontbold">Begins with...</span></td></tr><tr><td ALIGN="CENTER" class="positive">
<img SRC="assets/clearpixel.gif" WIDTH=160 HEIGHT=1><br><br><select MULTIPLE SIZE=5 NAME="BEG1SND">
<option NAME="AA" VALUE="AA" <clp_ifmember name="BEG1SND" value="AA" session>selected</clp_ifmember>>AA as in 'odd'</option>
<option NAME="AE" VALUE="AE" <clp_ifmember name="BEG1SND" value="AE" session>selected</clp_ifmember>>AE as in 'at'</option>
<option NAME="AH" VALUE="AH" <clp_ifmember name="BEG1SND" value="AH" session>selected</clp_ifmember>>AH as in 'hut'</option>
<option NAME="AO" VALUE="AO" <clp_ifmember name="BEG1SND" value="AO" session>selected</clp_ifmember>>AO as in 'ought'</option>
<option NAME="AW" VALUE="AW" <clp_ifmember name="BEG1SND" value="AW" session>selected</clp_ifmember>>AW as in 'cow'</option>
<option NAME="AY" VALUE="AY" <clp_ifmember name="BEG1SND" value="AY" session>selected</clp_ifmember>>AY as in 'hide'</option>
<option NAME="B" VALUE="B"> <clp_ifmember name="BEG1SND" value="B"" session>selected</clp_ifmember>B as in 'be'</option>
<option NAME="CH" VALUE="CH" <clp_ifmember name="BEG1SND" value="CH" session>selected</clp_ifmember>>CH as in 'cheese'</option>
<option NAME="D" VALUE="D"> <clp_ifmember name="BEG1SND" value="D"" session>selected</clp_ifmember>D as in 'dee'</option>
<option NAME="DH" VALUE="DH" <clp_ifmember name="BEG1SND" value="DH" session>selected</clp_ifmember>>DH as in 'thee'</option>
<option NAME="EH" VALUE="EH" <clp_ifmember name="BEG1SND" value="EH" session>selected</clp_ifmember>>EH as in 'egg'</option>
<option NAME="ER" VALUE="ER" <clp_ifmember name="BEG1SND" value="ER" session>selected</clp_ifmember>>ER as in 'hurt'</option>
<option NAME="EY" VALUE="EY" <clp_ifmember name="BEG1SND" value="EY" session>selected</clp_ifmember>>EY as in 'ate'</option>
<option NAME="F" VALUE="F"> <clp_ifmember name="BEG1SND" value="F"" session>selected</clp_ifmember>F as in 'fee'</option>
<option NAME="G" VALUE="G"> <clp_ifmember name="BEG1SND" value="G"" session>selected</clp_ifmember>G as in 'green'</option>
<option NAME="HH" VALUE="HH" <clp_ifmember name="BEG1SND" value="HH" session>selected</clp_ifmember>>HH as in 'he'</option>
<option NAME="IH" VALUE="IH" <clp_ifmember name="BEG1SND" value="IH" session>selected</clp_ifmember>>IH as in 'it'</option>
<option NAME="IY" VALUE="IY" <clp_ifmember name="BEG1SND" value="IY" session>selected</clp_ifmember>>IY as in 'eat'</option>
<option NAME="JH" VALUE="JH" <clp_ifmember name="BEG1SND" value="JH" session>selected</clp_ifmember>>JH as in 'gee'</option>
<option NAME="K" VALUE="K"> <clp_ifmember name="BEG1SND" value="K"" session>selected</clp_ifmember>K as in 'key'</option>
<option NAME="L" VALUE="L"> <clp_ifmember name="BEG1SND" value="L"" session>selected</clp_ifmember>L as in 'lee'</option>
<option NAME="M" VALUE="M"> <clp_ifmember name="BEG1SND" value="M"" session>selected</clp_ifmember>M as in 'me'</option>
<option NAME="N" VALUE="N"> <clp_ifmember name="BEG1SND" value="N"" session>selected</clp_ifmember>N as in 'knee'</option>
<option NAME="NG" VALUE="NG" <clp_ifmember name="BEG1SND" value="NG" session>selected</clp_ifmember>>NG as in 'ping'</option>
<option NAME="OW" VALUE="OW" <clp_ifmember name="BEG1SND" value="OW" session>selected</clp_ifmember>>OW as in 'oat'</option>
<option NAME="OY" VALUE="OY" <clp_ifmember name="BEG1SND" value="OY" session>selected</clp_ifmember>>OY as in 'toy'</option>
<option NAME="P" VALUE="P"> <clp_ifmember name="BEG1SND" value="P"" session>selected</clp_ifmember>P as in 'pee'</option>
<option NAME="R" VALUE="R"> <clp_ifmember name="BEG1SND" value="R"" session>selected</clp_ifmember>R as in 'read'</option>
<option NAME="S" VALUE="S"> <clp_ifmember name="BEG1SND" value="S"" session>selected</clp_ifmember>S as in 'sea'</option>
<option NAME="SH" VALUE="SH" <clp_ifmember name="BEG1SND" value="SH" session>selected</clp_ifmember>>SH as in 'she'</option>
<option NAME="T" VALUE="T"> <clp_ifmember name="BEG1SND" value="T"" session>selected</clp_ifmember>T as in 'tea'</option>
<option NAME="TH" VALUE="TH" <clp_ifmember name="BEG1SND" value="TH" session>selected</clp_ifmember>>TH as in 'theta'</option>
<option NAME="UH" VALUE="UH" <clp_ifmember name="BEG1SND" value="UH" session>selected</clp_ifmember>>UH as in 'hood'</option>
<option NAME="UW" VALUE="UW" <clp_ifmember name="BEG1SND" value="UW" session>selected</clp_ifmember>>UW as in 'two'</option>
<option NAME="V" VALUE="V"> <clp_ifmember name="BEG1SND" value="V"" session>selected</clp_ifmember>V as in 'vee'</option>
<option NAME="W" VALUE="W"> <clp_ifmember name="BEG1SND" value="W"" session>selected</clp_ifmember>W as in 'we'</option>
<option NAME="Y" VALUE="Y"> <clp_ifmember name="BEG1SND" value="Y"" session>selected</clp_ifmember>Y as in 'yield'</option>
<option NAME="Z" VALUE="Z"> <clp_ifmember name="BEG1SND" value="Z"" session>selected</clp_ifmember>Z as in 'zee'</option>
<option NAME="ZH" VALUE="ZH" <clp_ifmember name="BEG1SND" value="ZH" session>selected</clp_ifmember>>ZH as in 'seizure'</option></select><br><br></td></tr></table></td><td>
<table class="posframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 ALIGN="CENTER" class="positive"><span CLASS="posfontbold">Contains...</span></td></tr><tr><td ALIGN="CENTER" class="positive">
<img SRC="assets/clearpixel.gif" WIDTH=160 HEIGHT=1><br><br><select MULTIPLE SIZE=5 NAME="CNT1SND">
<option NAME="AA" VALUE="AA" <clp_ifmember name="CNT1SND" value="AA" session>selected</clp_ifmember>>AA as in 'odd'</option>
<option NAME="AE" VALUE="AE" <clp_ifmember name="CNT1SND" value="AE" session>selected</clp_ifmember>>AE as in 'at'</option>
<option NAME="AH" VALUE="AH" <clp_ifmember name="CNT1SND" value="AH" session>selected</clp_ifmember>>AH as in 'hut'</option>
<option NAME="AO" VALUE="AO" <clp_ifmember name="CNT1SND" value="AO" session>selected</clp_ifmember>>AO as in 'ought'</option>
<option NAME="AW" VALUE="AW" <clp_ifmember name="CNT1SND" value="AW" session>selected</clp_ifmember>>AW as in 'cow'</option>
<option NAME="AY" VALUE="AY" <clp_ifmember name="CNT1SND" value="AY" session>selected</clp_ifmember>>AY as in 'hide'</option>
<option NAME="B" VALUE="B"> <clp_ifmember name="CNT1SND" value="B"" session>selected</clp_ifmember>B as in 'be'</option>
<option NAME="CH" VALUE="CH" <clp_ifmember name="CNT1SND" value="CH" session>selected</clp_ifmember>>CH as in 'cheese'</option>
<option NAME="D" VALUE="D"> <clp_ifmember name="CNT1SND" value="D"" session>selected</clp_ifmember>D as in 'dee'</option>
<option NAME="DH" VALUE="DH" <clp_ifmember name="CNT1SND" value="DH" session>selected</clp_ifmember>>DH as in 'thee'</option>
<option NAME="EH" VALUE="EH" <clp_ifmember name="CNT1SND" value="EH" session>selected</clp_ifmember>>EH as in 'egg'</option>
<option NAME="ER" VALUE="ER" <clp_ifmember name="CNT1SND" value="ER" session>selected</clp_ifmember>>ER as in 'hurt'</option>
<option NAME="EY" VALUE="EY" <clp_ifmember name="CNT1SND" value="EY" session>selected</clp_ifmember>>EY as in 'ate'</option>
<option NAME="F" VALUE="F"> <clp_ifmember name="CNT1SND" value="F"" session>selected</clp_ifmember>F as in 'fee'</option>
<option NAME="G" VALUE="G"> <clp_ifmember name="CNT1SND" value="G"" session>selected</clp_ifmember>G as in 'green'</option>
<option NAME="HH" VALUE="HH" <clp_ifmember name="CNT1SND" value="HH" session>selected</clp_ifmember>>HH as in 'he'</option>
<option NAME="IH" VALUE="IH" <clp_ifmember name="CNT1SND" value="IH" session>selected</clp_ifmember>>IH as in 'it'</option>
<option NAME="IY" VALUE="IY" <clp_ifmember name="CNT1SND" value="IY" session>selected</clp_ifmember>>IY as in 'eat'</option>
<option NAME="JH" VALUE="JH" <clp_ifmember name="CNT1SND" value="JH" session>selected</clp_ifmember>>JH as in 'gee'</option>
<option NAME="K" VALUE="K"> <clp_ifmember name="CNT1SND" value="K"" session>selected</clp_ifmember>K as in 'key'</option>
<option NAME="L" VALUE="L"> <clp_ifmember name="CNT1SND" value="L"" session>selected</clp_ifmember>L as in 'lee'</option>
<option NAME="M" VALUE="M"> <clp_ifmember name="CNT1SND" value="M"" session>selected</clp_ifmember>M as in 'me'</option>
<option NAME="N" VALUE="N"> <clp_ifmember name="CNT1SND" value="N"" session>selected</clp_ifmember>N as in 'knee'</option>
<option NAME="NG" VALUE="NG" <clp_ifmember name="CNT1SND" value="NG" session>selected</clp_ifmember>>NG as in 'ping'</option>
<option NAME="OW" VALUE="OW" <clp_ifmember name="CNT1SND" value="OW" session>selected</clp_ifmember>>OW as in 'oat'</option>
<option NAME="OY" VALUE="OY" <clp_ifmember name="CNT1SND" value="OY" session>selected</clp_ifmember>>OY as in 'toy'</option>
<option NAME="P" VALUE="P"> <clp_ifmember name="CNT1SND" value="P"" session>selected</clp_ifmember>P as in 'pee'</option>
<option NAME="R" VALUE="R"> <clp_ifmember name="CNT1SND" value="R"" session>selected</clp_ifmember>R as in 'read'</option>
<option NAME="S" VALUE="S"> <clp_ifmember name="CNT1SND" value="S"" session>selected</clp_ifmember>S as in 'sea'</option>
<option NAME="SH" VALUE="SH" <clp_ifmember name="CNT1SND" value="SH" session>selected</clp_ifmember>>SH as in 'she'</option>
<option NAME="T" VALUE="T"> <clp_ifmember name="CNT1SND" value="T"" session>selected</clp_ifmember>T as in 'tea'</option>
<option NAME="TH" VALUE="TH" <clp_ifmember name="CNT1SND" value="TH" session>selected</clp_ifmember>>TH as in 'theta'</option>
<option NAME="UH" VALUE="UH" <clp_ifmember name="CNT1SND" value="UH" session>selected</clp_ifmember>>UH as in 'hood'</option>
<option NAME="UW" VALUE="UW" <clp_ifmember name="CNT1SND" value="UW" session>selected</clp_ifmember>>UW as in 'two'</option>
<option NAME="V" VALUE="V"> <clp_ifmember name="CNT1SND" value="V"" session>selected</clp_ifmember>V as in 'vee'</option>
<option NAME="W" VALUE="W"> <clp_ifmember name="CNT1SND" value="W"" session>selected</clp_ifmember>W as in 'we'</option>
<option NAME="Y" VALUE="Y"> <clp_ifmember name="CNT1SND" value="Y"" session>selected</clp_ifmember>Y as in 'yield'</option>
<option NAME="Z" VALUE="Z"> <clp_ifmember name="CNT1SND" value="Z"" session>selected</clp_ifmember>Z as in 'zee'</option>
<option NAME="ZH" VALUE="ZH" <clp_ifmember name="CNT1SND" value="ZH" session>selected</clp_ifmember>>ZH as in 'seizure'</option></select><br><br></td></tr></table></td><td>
<table class="posframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 ALIGN="CENTER" class="positive"><span CLASS="posfontbold">Ends with...</span></td></tr><tr><td ALIGN="CENTER" class="positive">
<img SRC="assets/clearpixel.gif" WIDTH=160 HEIGHT=1><br><br><select MULTIPLE SIZE=5 NAME="END1SND">
<option NAME="AA" VALUE="AA" <clp_ifmember name="END1SND" value="AA" session>selected</clp_ifmember>>AA as in 'odd'</option>
<option NAME="AE" VALUE="AE" <clp_ifmember name="END1SND" value="AE" session>selected</clp_ifmember>>AE as in 'at'</option>
<option NAME="AH" VALUE="AH" <clp_ifmember name="END1SND" value="AH" session>selected</clp_ifmember>>AH as in 'hut'</option>
<option NAME="AO" VALUE="AO" <clp_ifmember name="END1SND" value="AO" session>selected</clp_ifmember>>AO as in 'ought'</option>
<option NAME="AW" VALUE="AW" <clp_ifmember name="END1SND" value="AW" session>selected</clp_ifmember>>AW as in 'cow'</option>
<option NAME="AY" VALUE="AY" <clp_ifmember name="END1SND" value="AY" session>selected</clp_ifmember>>AY as in 'hide'</option>
<option NAME="B" VALUE="B"> <clp_ifmember name="END1SND" value="B"" session>selected</clp_ifmember>B as in 'be'</option>
<option NAME="CH" VALUE="CH" <clp_ifmember name="END1SND" value="CH" session>selected</clp_ifmember>>CH as in 'cheese'</option>
<option NAME="D" VALUE="D"> <clp_ifmember name="END1SND" value="D"" session>selected</clp_ifmember>D as in 'dee'</option>
<option NAME="DH" VALUE="DH" <clp_ifmember name="END1SND" value="DH" session>selected</clp_ifmember>>DH as in 'thee'</option>
<option NAME="EH" VALUE="EH" <clp_ifmember name="END1SND" value="EH" session>selected</clp_ifmember>>EH as in 'egg'</option>
<option NAME="ER" VALUE="ER" <clp_ifmember name="END1SND" value="ER" session>selected</clp_ifmember>>ER as in 'hurt'</option>
<option NAME="EY" VALUE="EY" <clp_ifmember name="END1SND" value="EY" session>selected</clp_ifmember>>EY as in 'ate'</option>
<option NAME="F" VALUE="F"> <clp_ifmember name="END1SND" value="F"" session>selected</clp_ifmember>F as in 'fee'</option>
<option NAME="G" VALUE="G"> <clp_ifmember name="END1SND" value="G"" session>selected</clp_ifmember>G as in 'green'</option>
<option NAME="HH" VALUE="HH" <clp_ifmember name="END1SND" value="HH" session>selected</clp_ifmember>>HH as in 'he'</option>
<option NAME="IH" VALUE="IH" <clp_ifmember name="END1SND" value="IH" session>selected</clp_ifmember>>IH as in 'it'</option>
<option NAME="IY" VALUE="IY" <clp_ifmember name="END1SND" value="IY" session>selected</clp_ifmember>>IY as in 'eat'</option>
<option NAME="JH" VALUE="JH" <clp_ifmember name="END1SND" value="JH" session>selected</clp_ifmember>>JH as in 'gee'</option>
<option NAME="K" VALUE="K"> <clp_ifmember name="END1SND" value="K"" session>selected</clp_ifmember>K as in 'key'</option>
<option NAME="L" VALUE="L"> <clp_ifmember name="END1SND" value="L"" session>selected</clp_ifmember>L as in 'lee'</option>
<option NAME="M" VALUE="M"> <clp_ifmember name="END1SND" value="M"" session>selected</clp_ifmember>M as in 'me'</option>
<option NAME="N" VALUE="N"> <clp_ifmember name="END1SND" value="N"" session>selected</clp_ifmember>N as in 'knee'</option>
<option NAME="NG" VALUE="NG" <clp_ifmember name="END1SND" value="NG" session>selected</clp_ifmember>>NG as in 'ping'</option>
<option NAME="OW" VALUE="OW" <clp_ifmember name="END1SND" value="OW" session>selected</clp_ifmember>>OW as in 'oat'</option>
<option NAME="OY" VALUE="OY" <clp_ifmember name="END1SND" value="OY" session>selected</clp_ifmember>>OY as in 'toy'</option>
<option NAME="P" VALUE="P"> <clp_ifmember name="END1SND" value="P"" session>selected</clp_ifmember>P as in 'pee'</option>
<option NAME="R" VALUE="R"> <clp_ifmember name="END1SND" value="R"" session>selected</clp_ifmember>R as in 'read'</option>
<option NAME="S" VALUE="S"> <clp_ifmember name="END1SND" value="S"" session>selected</clp_ifmember>S as in 'sea'</option>
<option NAME="SH" VALUE="SH" <clp_ifmember name="END1SND" value="SH" session>selected</clp_ifmember>>SH as in 'she'</option>
<option NAME="T" VALUE="T"> <clp_ifmember name="END1SND" value="T"" session>selected</clp_ifmember>T as in 'tea'</option>
<option NAME="TH" VALUE="TH" <clp_ifmember name="END1SND" value="TH" session>selected</clp_ifmember>>TH as in 'theta'</option>
<option NAME="UH" VALUE="UH" <clp_ifmember name="END1SND" value="UH" session>selected</clp_ifmember>>UH as in 'hood'</option>
<option NAME="UW" VALUE="UW" <clp_ifmember name="END1SND" value="UW" session>selected</clp_ifmember>>UW as in 'two'</option>
<option NAME="V" VALUE="V"> <clp_ifmember name="END1SND" value="V"" session>selected</clp_ifmember>V as in 'vee'</option>
<option NAME="W" VALUE="W"> <clp_ifmember name="END1SND" value="W"" session>selected</clp_ifmember>W as in 'we'</option>
<option NAME="Y" VALUE="Y"> <clp_ifmember name="END1SND" value="Y"" session>selected</clp_ifmember>Y as in 'yield'</option>
<option NAME="Z" VALUE="Z"> <clp_ifmember name="END1SND" value="Z"" session>selected</clp_ifmember>Z as in 'zee'</option>
<option NAME="ZH" VALUE="ZH" <clp_ifmember name="END1SND" value="ZH" session>selected</clp_ifmember>>ZH as in 'seizure'</option></select><br><br></td></tr></table></td></tr></table><br>

<table class="negoutline" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td>
<table class="negframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 ALIGN="CENTER" class="negative"><span CLASS="bolddeepred">Does not begin with...</span></td></tr><tr><td ALIGN="CENTER" class="negative">
<img SRC="assets/clearpixel.gif" WIDTH=160 HEIGHT=1><br><br><select MULTIPLE SIZE=5 NAME="BEG0SND">
<option NAME="AA" VALUE="AA" <clp_ifmember name="BEG0SND" value="AA" session>selected</clp_ifmember>>AA as in 'odd'</option>
<option NAME="AE" VALUE="AE" <clp_ifmember name="BEG0SND" value="AE" session>selected</clp_ifmember>>AE as in 'at'</option>
<option NAME="AH" VALUE="AH" <clp_ifmember name="BEG0SND" value="AH" session>selected</clp_ifmember>>AH as in 'hut'</option>
<option NAME="AO" VALUE="AO" <clp_ifmember name="BEG0SND" value="AO" session>selected</clp_ifmember>>AO as in 'ought'</option>
<option NAME="AW" VALUE="AW" <clp_ifmember name="BEG0SND" value="AW" session>selected</clp_ifmember>>AW as in 'cow'</option>
<option NAME="AY" VALUE="AY" <clp_ifmember name="BEG0SND" value="AY" session>selected</clp_ifmember>>AY as in 'hide'</option>
<option NAME="B" VALUE="B"> <clp_ifmember name="BEG0SND" value="B"" session>selected</clp_ifmember>B as in 'be'</option>
<option NAME="CH" VALUE="CH" <clp_ifmember name="BEG0SND" value="CH" session>selected</clp_ifmember>>CH as in 'cheese'</option>
<option NAME="D" VALUE="D"> <clp_ifmember name="BEG0SND" value="D"" session>selected</clp_ifmember>D as in 'dee'</option>
<option NAME="DH" VALUE="DH" <clp_ifmember name="BEG0SND" value="DH" session>selected</clp_ifmember>>DH as in 'thee'</option>
<option NAME="EH" VALUE="EH" <clp_ifmember name="BEG0SND" value="EH" session>selected</clp_ifmember>>EH as in 'egg'</option>
<option NAME="ER" VALUE="ER" <clp_ifmember name="BEG0SND" value="ER" session>selected</clp_ifmember>>ER as in 'hurt'</option>
<option NAME="EY" VALUE="EY" <clp_ifmember name="BEG0SND" value="EY" session>selected</clp_ifmember>>EY as in 'ate'</option>
<option NAME="F" VALUE="F"> <clp_ifmember name="BEG0SND" value="F"" session>selected</clp_ifmember>F as in 'fee'</option>
<option NAME="G" VALUE="G"> <clp_ifmember name="BEG0SND" value="G"" session>selected</clp_ifmember>G as in 'green'</option>
<option NAME="HH" VALUE="HH" <clp_ifmember name="BEG0SND" value="HH" session>selected</clp_ifmember>>HH as in 'he'</option>
<option NAME="IH" VALUE="IH" <clp_ifmember name="BEG0SND" value="IH" session>selected</clp_ifmember>>IH as in 'it'</option>
<option NAME="IY" VALUE="IY" <clp_ifmember name="BEG0SND" value="IY" session>selected</clp_ifmember>>IY as in 'eat'</option>
<option NAME="JH" VALUE="JH" <clp_ifmember name="BEG0SND" value="JH" session>selected</clp_ifmember>>JH as in 'gee'</option>
<option NAME="K" VALUE="K"> <clp_ifmember name="BEG0SND" value="K"" session>selected</clp_ifmember>K as in 'key'</option>
<option NAME="L" VALUE="L"> <clp_ifmember name="BEG0SND" value="L"" session>selected</clp_ifmember>L as in 'lee'</option>
<option NAME="M" VALUE="M"> <clp_ifmember name="BEG0SND" value="M"" session>selected</clp_ifmember>M as in 'me'</option>
<option NAME="N" VALUE="N"> <clp_ifmember name="BEG0SND" value="N"" session>selected</clp_ifmember>N as in 'knee'</option>
<option NAME="NG" VALUE="NG" <clp_ifmember name="BEG0SND" value="NG" session>selected</clp_ifmember>>NG as in 'ping'</option>
<option NAME="OW" VALUE="OW" <clp_ifmember name="BEG0SND" value="OW" session>selected</clp_ifmember>>OW as in 'oat'</option>
<option NAME="OY" VALUE="OY" <clp_ifmember name="BEG0SND" value="OY" session>selected</clp_ifmember>>OY as in 'toy'</option>
<option NAME="P" VALUE="P"> <clp_ifmember name="BEG0SND" value="P"" session>selected</clp_ifmember>P as in 'pee'</option>
<option NAME="R" VALUE="R"> <clp_ifmember name="BEG0SND" value="R"" session>selected</clp_ifmember>R as in 'read'</option>
<option NAME="S" VALUE="S"> <clp_ifmember name="BEG0SND" value="S"" session>selected</clp_ifmember>S as in 'sea'</option>
<option NAME="SH" VALUE="SH" <clp_ifmember name="BEG0SND" value="SH" session>selected</clp_ifmember>>SH as in 'she'</option>
<option NAME="T" VALUE="T"> <clp_ifmember name="BEG0SND" value="T"" session>selected</clp_ifmember>T as in 'tea'</option>
<option NAME="TH" VALUE="TH" <clp_ifmember name="BEG0SND" value="TH" session>selected</clp_ifmember>>TH as in 'theta'</option>
<option NAME="UH" VALUE="UH" <clp_ifmember name="BEG0SND" value="UH" session>selected</clp_ifmember>>UH as in 'hood'</option>
<option NAME="UW" VALUE="UW" <clp_ifmember name="BEG0SND" value="UW" session>selected</clp_ifmember>>UW as in 'two'</option>
<option NAME="V" VALUE="V"> <clp_ifmember name="BEG0SND" value="V"" session>selected</clp_ifmember>V as in 'vee'</option>
<option NAME="W" VALUE="W"> <clp_ifmember name="BEG0SND" value="W"" session>selected</clp_ifmember>W as in 'we'</option>
<option NAME="Y" VALUE="Y"> <clp_ifmember name="BEG0SND" value="Y"" session>selected</clp_ifmember>Y as in 'yield'</option>
<option NAME="Z" VALUE="Z"> <clp_ifmember name="BEG0SND" value="Z"" session>selected</clp_ifmember>Z as in 'zee'</option>
<option NAME="ZH" VALUE="ZH" <clp_ifmember name="BEG0SND" value="ZH" session>selected</clp_ifmember>>ZH as in 'seizure'</option></select><br><br></td></tr></table></td><td>
<table class="negframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 ALIGN="CENTER" class="negative"><span CLASS="bolddeepred">Does not contain...</span></td></tr><tr><td ALIGN="CENTER" class="negative">
<img SRC="assets/clearpixel.gif" WIDTH=160 HEIGHT=1><br><br><select MULTIPLE SIZE=5 NAME="CNT0SND">
<option NAME="AA" VALUE="AA" <clp_ifmember name="CNT0SND" value="AA" session>selected</clp_ifmember>>AA as in 'odd'</option>
<option NAME="AE" VALUE="AE" <clp_ifmember name="CNT0SND" value="AE" session>selected</clp_ifmember>>AE as in 'at'</option>
<option NAME="AH" VALUE="AH" <clp_ifmember name="CNT0SND" value="AH" session>selected</clp_ifmember>>AH as in 'hut'</option>
<option NAME="AO" VALUE="AO" <clp_ifmember name="CNT0SND" value="AO" session>selected</clp_ifmember>>AO as in 'ought'</option>
<option NAME="AW" VALUE="AW" <clp_ifmember name="CNT0SND" value="AW" session>selected</clp_ifmember>>AW as in 'cow'</option>
<option NAME="AY" VALUE="AY" <clp_ifmember name="CNT0SND" value="AY" session>selected</clp_ifmember>>AY as in 'hide'</option>
<option NAME="B" VALUE="B"> <clp_ifmember name="CNT0SND" value="B"" session>selected</clp_ifmember>B as in 'be'</option>
<option NAME="CH" VALUE="CH" <clp_ifmember name="CNT0SND" value="CH" session>selected</clp_ifmember>>CH as in 'cheese'</option>
<option NAME="D" VALUE="D"> <clp_ifmember name="CNT0SND" value="D"" session>selected</clp_ifmember>D as in 'dee'</option>
<option NAME="DH" VALUE="DH" <clp_ifmember name="CNT0SND" value="DH" session>selected</clp_ifmember>>DH as in 'thee'</option>
<option NAME="EH" VALUE="EH" <clp_ifmember name="CNT0SND" value="EH" session>selected</clp_ifmember>>EH as in 'egg'</option>
<option NAME="ER" VALUE="ER" <clp_ifmember name="CNT0SND" value="ER" session>selected</clp_ifmember>>ER as in 'hurt'</option>
<option NAME="EY" VALUE="EY" <clp_ifmember name="CNT0SND" value="EY" session>selected</clp_ifmember>>EY as in 'ate'</option>
<option NAME="F" VALUE="F"> <clp_ifmember name="CNT0SND" value="F"" session>selected</clp_ifmember>F as in 'fee'</option>
<option NAME="G" VALUE="G"> <clp_ifmember name="CNT0SND" value="G"" session>selected</clp_ifmember>G as in 'green'</option>
<option NAME="HH" VALUE="HH" <clp_ifmember name="CNT0SND" value="HH" session>selected</clp_ifmember>>HH as in 'he'</option>
<option NAME="IH" VALUE="IH" <clp_ifmember name="CNT0SND" value="IH" session>selected</clp_ifmember>>IH as in 'it'</option>
<option NAME="IY" VALUE="IY" <clp_ifmember name="CNT0SND" value="IY" session>selected</clp_ifmember>>IY as in 'eat'</option>
<option NAME="JH" VALUE="JH" <clp_ifmember name="CNT0SND" value="JH" session>selected</clp_ifmember>>JH as in 'gee'</option>
<option NAME="K" VALUE="K"> <clp_ifmember name="CNT0SND" value="K"" session>selected</clp_ifmember>K as in 'key'</option>
<option NAME="L" VALUE="L"> <clp_ifmember name="CNT0SND" value="L"" session>selected</clp_ifmember>L as in 'lee'</option>
<option NAME="M" VALUE="M"> <clp_ifmember name="CNT0SND" value="M"" session>selected</clp_ifmember>M as in 'me'</option>
<option NAME="N" VALUE="N"> <clp_ifmember name="CNT0SND" value="N"" session>selected</clp_ifmember>N as in 'knee'</option>
<option NAME="NG" VALUE="NG" <clp_ifmember name="CNT0SND" value="NG" session>selected</clp_ifmember>>NG as in 'ping'</option>
<option NAME="OW" VALUE="OW" <clp_ifmember name="CNT0SND" value="OW" session>selected</clp_ifmember>>OW as in 'oat'</option>
<option NAME="OY" VALUE="OY" <clp_ifmember name="CNT0SND" value="OY" session>selected</clp_ifmember>>OY as in 'toy'</option>
<option NAME="P" VALUE="P"> <clp_ifmember name="CNT0SND" value="P"" session>selected</clp_ifmember>P as in 'pee'</option>
<option NAME="R" VALUE="R"> <clp_ifmember name="CNT0SND" value="R"" session>selected</clp_ifmember>R as in 'read'</option>
<option NAME="S" VALUE="S"> <clp_ifmember name="CNT0SND" value="S"" session>selected</clp_ifmember>S as in 'sea'</option>
<option NAME="SH" VALUE="SH" <clp_ifmember name="CNT0SND" value="SH" session>selected</clp_ifmember>>SH as in 'she'</option>
<option NAME="T" VALUE="T"> <clp_ifmember name="CNT0SND" value="T"" session>selected</clp_ifmember>T as in 'tea'</option>
<option NAME="TH" VALUE="TH" <clp_ifmember name="CNT0SND" value="TH" session>selected</clp_ifmember>>TH as in 'theta'</option>
<option NAME="UH" VALUE="UH" <clp_ifmember name="CNT0SND" value="UH" session>selected</clp_ifmember>>UH as in 'hood'</option>
<option NAME="UW" VALUE="UW" <clp_ifmember name="CNT0SND" value="UW" session>selected</clp_ifmember>>UW as in 'two'</option>
<option NAME="V" VALUE="V"> <clp_ifmember name="CNT0SND" value="V"" session>selected</clp_ifmember>V as in 'vee'</option>
<option NAME="W" VALUE="W"> <clp_ifmember name="CNT0SND" value="W"" session>selected</clp_ifmember>W as in 'we'</option>
<option NAME="Y" VALUE="Y"> <clp_ifmember name="CNT0SND" value="Y"" session>selected</clp_ifmember>Y as in 'yield'</option>
<option NAME="Z" VALUE="Z"> <clp_ifmember name="CNT0SND" value="Z"" session>selected</clp_ifmember>Z as in 'zee'</option>
<option NAME="ZH" VALUE="ZH" <clp_ifmember name="CNT0SND" value="ZH" session>selected</clp_ifmember>>ZH as in 'seizure'</option></select><br><br></td></tr></table></td><td>
<table class="negframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 ALIGN="CENTER" class="negative"><span CLASS="bolddeepred">Does not end with...</span></td></tr><tr><td ALIGN="CENTER" class="negative">
<img SRC="assets/clearpixel.gif" WIDTH=160 HEIGHT=1><br><br><select MULTIPLE SIZE=5 NAME="END0SND">
<option NAME="AA" VALUE="AA" <clp_ifmember name="END0SND" value="AA" session>selected</clp_ifmember>>AA as in 'odd'</option>
<option NAME="AE" VALUE="AE" <clp_ifmember name="END0SND" value="AE" session>selected</clp_ifmember>>AE as in 'at'</option>
<option NAME="AH" VALUE="AH" <clp_ifmember name="END0SND" value="AH" session>selected</clp_ifmember>>AH as in 'hut'</option>
<option NAME="AO" VALUE="AO" <clp_ifmember name="END0SND" value="AO" session>selected</clp_ifmember>>AO as in 'ought'</option>
<option NAME="AW" VALUE="AW" <clp_ifmember name="END0SND" value="AW" session>selected</clp_ifmember>>AW as in 'cow'</option>
<option NAME="AY" VALUE="AY" <clp_ifmember name="END0SND" value="AY" session>selected</clp_ifmember>>AY as in 'hide'</option>
<option NAME="B" VALUE="B"> <clp_ifmember name="END0SND" value="B"" session>selected</clp_ifmember>B as in 'be'</option>
<option NAME="CH" VALUE="CH" <clp_ifmember name="END0SND" value="CH" session>selected</clp_ifmember>>CH as in 'cheese'</option>
<option NAME="D" VALUE="D"> <clp_ifmember name="END0SND" value="D"" session>selected</clp_ifmember>D as in 'dee'</option>
<option NAME="DH" VALUE="DH" <clp_ifmember name="END0SND" value="DH" session>selected</clp_ifmember>>DH as in 'thee'</option>
<option NAME="EH" VALUE="EH" <clp_ifmember name="END0SND" value="EH" session>selected</clp_ifmember>>EH as in 'egg'</option>
<option NAME="ER" VALUE="ER" <clp_ifmember name="END0SND" value="ER" session>selected</clp_ifmember>>ER as in 'hurt'</option>
<option NAME="EY" VALUE="EY" <clp_ifmember name="END0SND" value="EY" session>selected</clp_ifmember>>EY as in 'ate'</option>
<option NAME="F" VALUE="F"> <clp_ifmember name="END0SND" value="F"" session>selected</clp_ifmember>F as in 'fee'</option>
<option NAME="G" VALUE="G"> <clp_ifmember name="END0SND" value="G"" session>selected</clp_ifmember>G as in 'green'</option>
<option NAME="HH" VALUE="HH" <clp_ifmember name="END0SND" value="HH" session>selected</clp_ifmember>>HH as in 'he'</option>
<option NAME="IH" VALUE="IH" <clp_ifmember name="END0SND" value="IH" session>selected</clp_ifmember>>IH as in 'it'</option>
<option NAME="IY" VALUE="IY" <clp_ifmember name="END0SND" value="IY" session>selected</clp_ifmember>>IY as in 'eat'</option>
<option NAME="JH" VALUE="JH" <clp_ifmember name="END0SND" value="JH" session>selected</clp_ifmember>>JH as in 'gee'</option>
<option NAME="K" VALUE="K"> <clp_ifmember name="END0SND" value="K"" session>selected</clp_ifmember>K as in 'key'</option>
<option NAME="L" VALUE="L"> <clp_ifmember name="END0SND" value="L"" session>selected</clp_ifmember>L as in 'lee'</option>
<option NAME="M" VALUE="M"> <clp_ifmember name="END0SND" value="M"" session>selected</clp_ifmember>M as in 'me'</option>
<option NAME="N" VALUE="N"> <clp_ifmember name="END0SND" value="N"" session>selected</clp_ifmember>N as in 'knee'</option>
<option NAME="NG" VALUE="NG" <clp_ifmember name="END0SND" value="NG" session>selected</clp_ifmember>>NG as in 'ping'</option>
<option NAME="OW" VALUE="OW" <clp_ifmember name="END0SND" value="OW" session>selected</clp_ifmember>>OW as in 'oat'</option>
<option NAME="OY" VALUE="OY" <clp_ifmember name="END0SND" value="OY" session>selected</clp_ifmember>>OY as in 'toy'</option>
<option NAME="P" VALUE="P"> <clp_ifmember name="END0SND" value="P"" session>selected</clp_ifmember>P as in 'pee'</option>
<option NAME="R" VALUE="R"> <clp_ifmember name="END0SND" value="R"" session>selected</clp_ifmember>R as in 'read'</option>
<option NAME="S" VALUE="S"> <clp_ifmember name="END0SND" value="S"" session>selected</clp_ifmember>S as in 'sea'</option>
<option NAME="SH" VALUE="SH" <clp_ifmember name="END0SND" value="SH" session>selected</clp_ifmember>>SH as in 'she'</option>
<option NAME="T" VALUE="T"> <clp_ifmember name="END0SND" value="T"" session>selected</clp_ifmember>T as in 'tea'</option>
<option NAME="TH" VALUE="TH" <clp_ifmember name="END0SND" value="TH" session>selected</clp_ifmember>>TH as in 'theta'</option>
<option NAME="UH" VALUE="UH" <clp_ifmember name="END0SND" value="UH" session>selected</clp_ifmember>>UH as in 'hood'</option>
<option NAME="UW" VALUE="UW" <clp_ifmember name="END0SND" value="UW" session>selected</clp_ifmember>>UW as in 'two'</option>
<option NAME="V" VALUE="V"> <clp_ifmember name="END0SND" value="V"" session>selected</clp_ifmember>V as in 'vee'</option>
<option NAME="W" VALUE="W"> <clp_ifmember name="END0SND" value="W"" session>selected</clp_ifmember>W as in 'we'</option>
<option NAME="Y" VALUE="Y"> <clp_ifmember name="END0SND" value="Y"" session>selected</clp_ifmember>Y as in 'yield'</option>
<option NAME="Z" VALUE="Z"> <clp_ifmember name="END0SND" value="Z"" session>selected</clp_ifmember>Z as in 'zee'</option>
<option NAME="ZH" VALUE="ZH" <clp_ifmember name="END0SND" value="ZH" session>selected</clp_ifmember>>ZH as in 'seizure'</option>
</select><br><br></td></tr></table></td></tr></table>
<br>

<br>
<clp_include name="bottom.clp"/></td></tr></table></td></tr>

</table></form></center></body></html>
