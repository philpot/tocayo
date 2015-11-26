<html>
<nmb_choose_type type="spelling" session/>
<head>
<title>NameMyBaby: <clp_value name="type" session/></title>
<clp_include name="css.clp"/>
</head>
<body>
<clp_include name="scripts.clp"/>

<center>
<form NAME="mainform" METHOD="POST" ACTION="switch">
<input type=hidden name="DEST" value="lookup">
<input type=hidden name="SRC" value="spelling">
<table border=0 CELLPADDING=0 CELLSPACING=0>
<clp_include name="tabpanel.clp"/>
<tr><td COLSPAN=7 class="manila"><table BORDER=0 CELLPADDING=15><tr><td ALIGN="CENTER"><img SRC="assets/clearpixel.gif" WIDTH=600 HEIGHT=1></td></tr><tr><td ALIGN="CENTER"><table class="posoutline" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td>
<table class="posframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 ALIGN="CENTER" VALIGN="TOP" class="positive"><span
CLASS="posfontbold">Begins with...</span></td></tr><tr><td
ALIGN="CENTER" valign="top" class="positive">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="posfont"><i>(vowel)</i></span>
<br><select MULTIPLE SIZE=5 NAME="BEG1VWL">

<option NAME="A" VALUE="A"
<clp_ifmember name="BEG1VWL" value="A" session>selected</clp_ifmember>
>A</option>
<option NAME="E" VALUE="E"
<clp_ifmember name="BEG1VWL" value="E" session>selected</clp_ifmember>
>E</option>
<option NAME="I" VALUE="I"
<clp_ifmember name="BEG1VWL" value="I" session>selected</clp_ifmember>
>I</option>
<option NAME="O" VALUE="O"
<clp_ifmember name="BEG1VWL" value="O" session>selected</clp_ifmember>
>O</option>
<option NAME="U" VALUE="U"
<clp_ifmember name="BEG1VWL" value="U" session>selected</clp_ifmember>
>U</option></select>
<br><span CLASS="posfont">any  vowel&nbsp;<input TYPE="CHECKBOX"
NAME="BEG1VWLBOX"
ONCLICK="setAllOptions(document.mainform.BEG1VWL,this.checked);"></span></td><td
ALIGN="CENTER" 
valign="top" class="positive">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="posfont"><i>(consonant)</i></span>
<br><select MULTIPLE SIZE=5 NAME="BEG1CST">
<option NAME="B" VALUE="B"
<clp_ifmember name="BEG1CST" value="B" session>selected</clp_ifmember>
>B</option>
<option NAME="C" VALUE="C"
<clp_ifmember name="BEG1CST" value="C" session>selected</clp_ifmember>
>C</option>
<option NAME="D" VALUE="D"
<clp_ifmember name="BEG1CST" value="D" session>selected</clp_ifmember>
>D</option>
<option NAME="F" VALUE="F"
<clp_ifmember name="BEG1CST" value="F" session>selected</clp_ifmember>
>F</option>
<option NAME="G" VALUE="G"
<clp_ifmember name="BEG1CST" value="G" session>selected</clp_ifmember>
>G</option>
<option NAME="H" VALUE="H"
<clp_ifmember name="BEG1CST" value="H" session>selected</clp_ifmember>
>H</option>
<option NAME="J" VALUE="J"
<clp_ifmember name="BEG1CST" value="J" session>selected</clp_ifmember>
>J</option>
<option NAME="K" VALUE="K"
<clp_ifmember name="BEG1CST" value="K" session>selected</clp_ifmember>
>K</option>
<option NAME="L" VALUE="L"
<clp_ifmember name="BEG1CST" value="L" session>selected</clp_ifmember>
>L</option>
<option NAME="M" VALUE="M"
<clp_ifmember name="BEG1CST" value="M" session>selected</clp_ifmember>
>M</option>
<option NAME="N" VALUE="N"
<clp_ifmember name="BEG1CST" value="N" session>selected</clp_ifmember>
>N</option>
<option NAME="P" VALUE="P"
<clp_ifmember name="BEG1CST" value="P" session>selected</clp_ifmember>
>P</option>
<option NAME="Q" VALUE="Q"
<clp_ifmember name="BEG1CST" value="Q" session>selected</clp_ifmember>
>Q</option>
<option NAME="R" VALUE="R"
<clp_ifmember name="BEG1CST" value="R" session>selected</clp_ifmember>
>R</option>
<option NAME="S" VALUE="S"
<clp_ifmember name="BEG1CST" value="S" session>selected</clp_ifmember>
>S</option>
<option NAME="T" VALUE="T"
<clp_ifmember name="BEG1CST" value="T" session>selected</clp_ifmember>
>T</option>
<option NAME="V" VALUE="V"
<clp_ifmember name="BEG1CST" value="V" session>selected</clp_ifmember>
>V</option>
<option NAME="W" VALUE="W"
<clp_ifmember name="BEG1CST" value="W" session>selected</clp_ifmember>
>W</option>
<option NAME="X" VALUE="X"
<clp_ifmember name="BEG1CST" value="X" session>selected</clp_ifmember>
>X</option>
<option NAME="Y" VALUE="Y"
<clp_ifmember name="BEG1CST" value="Y" session>selected</clp_ifmember>
>Y</option>
<option NAME="Z" VALUE="Z"
<clp_ifmember name="BEG1CST" value="Z" session>selected</clp_ifmember>
>Z</option></select>
<br><span CLASS="posfont">any  consonant&nbsp;<input TYPE="CHECKBOX" NAME="BEG1CSTBOX" ONCLICK="setAllOptions(document.mainform.BEG1CST,this.checked);"></span></td></tr></table></td><td>
<table class="posframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 
ALIGN="CENTER"
valign="TOP"
 class="positive"><span
 CLASS="posfontbold">Contains...</span></td></tr><tr><td
 ALIGN="CENTER" VALIGN="TOP" class="positive">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="posfont"><i>(vowel)</i></span>
<br><select MULTIPLE SIZE=5 NAME="CNT1VWL">
<option NAME="A" VALUE="A"
<clp_ifmember name="CNT1VWL" value="A" session>selected</clp_ifmember>
>A</option>
<option NAME="E" VALUE="E"
<clp_ifmember name="CNT1VWL" value="E" session>selected</clp_ifmember>
>E</option>
<option NAME="I" VALUE="I"
<clp_ifmember name="CNT1VWL" value="I" session>selected</clp_ifmember>
>I</option>
<option NAME="O" VALUE="O"
<clp_ifmember name="CNT1VWL" value="O" session>selected</clp_ifmember>
>O</option>
<option NAME="U" VALUE="U"
<clp_ifmember name="CNT1VWL" value="U" session>selected</clp_ifmember>
>U</option></select>
<br><span CLASS="posfont">any  vowel&nbsp;<input TYPE="CHECKBOX" NAME="CNT1VWLBOX" ONCLICK="setAllOptions(document.mainform.CNT1VWL,this.checked);"></span></td><td ALIGN="CENTER" class="positive">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="posfont"><i>(consonant)</i></span>
<br><select MULTIPLE SIZE=5 NAME="CNT1CST">
<option NAME="B" VALUE="B"
<clp_ifmember name="CNT1CST" value="B" session>selected</clp_ifmember>
>B</option>
<option NAME="C" VALUE="C"
<clp_ifmember name="CNT1CST" value="C" session>selected</clp_ifmember>
>C</option>
<option NAME="D" VALUE="D"
<clp_ifmember name="CNT1CST" value="D" session>selected</clp_ifmember>
>D</option>
<option NAME="F" VALUE="F"
<clp_ifmember name="CNT1CST" value="F" session>selected</clp_ifmember>
>F</option>
<option NAME="G" VALUE="G"
<clp_ifmember name="CNT1CST" value="G" session>selected</clp_ifmember>
>G</option>
<option NAME="H" VALUE="H"
<clp_ifmember name="CNT1CST" value="H" session>selected</clp_ifmember>
>H</option>
<option NAME="J" VALUE="J"
<clp_ifmember name="CNT1CST" value="J" session>selected</clp_ifmember>
>J</option>
<option NAME="K" VALUE="K"
<clp_ifmember name="CNT1CST" value="K" session>selected</clp_ifmember>
>K</option>
<option NAME="L" VALUE="L"
<clp_ifmember name="CNT1CST" value="L" session>selected</clp_ifmember>
>L</option>
<option NAME="M" VALUE="M"
<clp_ifmember name="CNT1CST" value="M" session>selected</clp_ifmember>
>M</option>
<option NAME="N" VALUE="N"
<clp_ifmember name="CNT1CST" value="N" session>selected</clp_ifmember>
>N</option>
<option NAME="P" VALUE="P"
<clp_ifmember name="CNT1CST" value="P" session>selected</clp_ifmember>
>P</option>
<option NAME="Q" VALUE="Q"
<clp_ifmember name="CNT1CST" value="Q" session>selected</clp_ifmember>
>Q</option>
<option NAME="R" VALUE="R"
<clp_ifmember name="CNT1CST" value="R" session>selected</clp_ifmember>
>R</option>
<option NAME="S" VALUE="S"
<clp_ifmember name="CNT1CST" value="S" session>selected</clp_ifmember>
>S</option>
<option NAME="T" VALUE="T"
<clp_ifmember name="CNT1CST" value="T" session>selected</clp_ifmember>
>T</option>
<option NAME="V" VALUE="V"
<clp_ifmember name="CNT1CST" value="V" session>selected</clp_ifmember>
>V</option>
<option NAME="W" VALUE="W"
<clp_ifmember name="CNT1CST" value="W" session>selected</clp_ifmember>
>W</option>
<option NAME="X" VALUE="X"
<clp_ifmember name="CNT1CST" value="X" session>selected</clp_ifmember>
>X</option>
<option NAME="Y" VALUE="Y"
<clp_ifmember name="CNT1CST" value="Y" session>selected</clp_ifmember>
>Y</option>
<option NAME="Z" VALUE="Z"
<clp_ifmember name="CNT1CST" value="Z" session>selected</clp_ifmember>
>Z</option></select>
<br><span CLASS="posfont">any  consonant&nbsp;<input TYPE="CHECKBOX" NAME="CNT1CSTBOX" ONCLICK="setAllOptions(document.mainform.CNT1CST,this.checked);"></span></td></tr></table></td><td>
<table class="posframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 ALIGN="CENTER" class="positive"><span
CLASS="posfontbold">Ends with...</span></td></tr><tr><td
ALIGN="CENTER" valign="top" class="positive">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="posfont"><i>(vowel)</i></span>
<br><select MULTIPLE SIZE=5 NAME="END1VWL">
<option NAME="A" VALUE="A"
<clp_ifmember name="END1VWL" value="A" session>selected</clp_ifmember>
>A</option>
<option NAME="E" VALUE="E"
<clp_ifmember name="END1VWL" value="E" session>selected</clp_ifmember>
>E</option>
<option NAME="I" VALUE="I"
<clp_ifmember name="END1VWL" value="I" session>selected</clp_ifmember>
>I</option>
<option NAME="O" VALUE="O"
<clp_ifmember name="END1VWL" value="O" session>selected</clp_ifmember>
>O</option>
<option NAME="U" VALUE="U"
<clp_ifmember name="END1VWL" value="U" session>selected</clp_ifmember>
>U</option></select>
<br><span CLASS="posfont">any  vowel&nbsp;<input TYPE="CHECKBOX" NAME="END1VWLBOX" ONCLICK="setAllOptions(document.mainform.END1VWL,this.checked);"></span></td><td ALIGN="CENTER" class="positive">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="posfont"><i>(consonant)</i></span>
<br><select MULTIPLE SIZE=5 NAME="END1CST">
<option NAME="B" VALUE="B"
<clp_ifmember name="END1CST" value="B" session>selected</clp_ifmember>
>B</option>
<option NAME="C" VALUE="C"
<clp_ifmember name="END1CST" value="C" session>selected</clp_ifmember>
>C</option>
<option NAME="D" VALUE="D"
<clp_ifmember name="END1CST" value="D" session>selected</clp_ifmember>
>D</option>
<option NAME="F" VALUE="F"
<clp_ifmember name="END1CST" value="F" session>selected</clp_ifmember>
>F</option>
<option NAME="G" VALUE="G"
<clp_ifmember name="END1CST" value="G" session>selected</clp_ifmember>
>G</option>
<option NAME="H" VALUE="H"
<clp_ifmember name="END1CST" value="H" session>selected</clp_ifmember>
>H</option>
<option NAME="J" VALUE="J"
<clp_ifmember name="END1CST" value="J" session>selected</clp_ifmember>
>J</option>
<option NAME="K" VALUE="K"
<clp_ifmember name="END1CST" value="K" session>selected</clp_ifmember>
>K</option>
<option NAME="L" VALUE="L"
<clp_ifmember name="END1CST" value="L" session>selected</clp_ifmember>
>L</option>
<option NAME="M" VALUE="M"
<clp_ifmember name="END1CST" value="M" session>selected</clp_ifmember>
>M</option>
<option NAME="N" VALUE="N"
<clp_ifmember name="END1CST" value="N" session>selected</clp_ifmember>
>N</option>
<option NAME="P" VALUE="P"
<clp_ifmember name="END1CST" value="P" session>selected</clp_ifmember>
>P</option>
<option NAME="Q" VALUE="Q"
<clp_ifmember name="END1CST" value="Q" session>selected</clp_ifmember>
>Q</option>
<option NAME="R" VALUE="R"
<clp_ifmember name="END1CST" value="R" session>selected</clp_ifmember>
>R</option>
<option NAME="S" VALUE="S"
<clp_ifmember name="END1CST" value="S" session>selected</clp_ifmember>
>S</option>
<option NAME="T" VALUE="T"
<clp_ifmember name="END1CST" value="T" session>selected</clp_ifmember>
>T</option>
<option NAME="V" VALUE="V"
<clp_ifmember name="END1CST" value="V" session>selected</clp_ifmember>
>V</option>
<option NAME="W" VALUE="W"
<clp_ifmember name="END1CST" value="W" session>selected</clp_ifmember>
>W</option>
<option NAME="X" VALUE="X"
<clp_ifmember name="END1CST" value="X" session>selected</clp_ifmember>
>X</option>
<option NAME="Y" VALUE="Y"
<clp_ifmember name="END1CST" value="Y" session>selected</clp_ifmember>
>Y</option>
<option NAME="Z" VALUE="Z"
<clp_ifmember name="END1CST" value="Z" session>selected</clp_ifmember>
>Z</option></select>
<br><span CLASS="posfont">any  consonant&nbsp;<input TYPE="CHECKBOX"
NAME="END1CSTBOX"
ONCLICK="setAllOptions(document.mainform.END1CST,this.checked);"></span></td></tr></table></td></tr></table><br>

<table class="negoutline" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td>
<table class="negframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 ALIGN="CENTER" class="negative"><span CLASS="bolddeepred">Does not begin with...</span></td></tr><tr><td ALIGN="CENTER" class="negative">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="deepred"><i>(vowel)</i></span>
<br><select MULTIPLE SIZE=5 NAME="BEG0VWL">
<option NAME="A" VALUE="A"
<clp_ifmember name="BEG0VWL" value="A" session>selected</clp_ifmember>
>A</option>
<option NAME="E" VALUE="E"
<clp_ifmember name="BEG0VWL" value="E" session>selected</clp_ifmember>
>E</option>
<option NAME="I" VALUE="I"
<clp_ifmember name="BEG0VWL" value="I" session>selected</clp_ifmember>
>I</option>
<option NAME="O" VALUE="O"
<clp_ifmember name="BEG0VWL" value="O" session>selected</clp_ifmember>
>O</option>
<option NAME="U" VALUE="U"
<clp_ifmember name="BEG0VWL" value="U" session>selected</clp_ifmember>
>U</option></select>
<br><span CLASS="deepred">a  vowel&nbsp;<input TYPE="CHECKBOX" NAME="BEG0VWLBOX" ONCLICK="setAllOptions(document.mainform.BEG0VWL,this.checked);"></span></td><td ALIGN="CENTER" class="negative">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="deepred"><i>(consonant)</i></span>
<br><select MULTIPLE SIZE=5 NAME="BEG0CST">
<option NAME="B" VALUE="B"
<clp_ifmember name="BEG0CST" value="B" session>selected</clp_ifmember>
>B</option>
<option NAME="C" VALUE="C"
<clp_ifmember name="BEG0CST" value="C" session>selected</clp_ifmember>
>C</option>
<option NAME="D" VALUE="D"
<clp_ifmember name="BEG0CST" value="D" session>selected</clp_ifmember>
>D</option>
<option NAME="F" VALUE="F"
<clp_ifmember name="BEG0CST" value="F" session>selected</clp_ifmember>
>F</option>
<option NAME="G" VALUE="G"
<clp_ifmember name="BEG0CST" value="G" session>selected</clp_ifmember>
>G</option>
<option NAME="H" VALUE="H"
<clp_ifmember name="BEG0CST" value="H" session>selected</clp_ifmember>
>H</option>
<option NAME="J" VALUE="J"
<clp_ifmember name="BEG0CST" value="J" session>selected</clp_ifmember>
>J</option>
<option NAME="K" VALUE="K"
<clp_ifmember name="BEG0CST" value="K" session>selected</clp_ifmember>
>K</option>
<option NAME="L" VALUE="L"
<clp_ifmember name="BEG0CST" value="L" session>selected</clp_ifmember>
>L</option>
<option NAME="M" VALUE="M"
<clp_ifmember name="BEG0CST" value="M" session>selected</clp_ifmember>
>M</option>
<option NAME="N" VALUE="N"
<clp_ifmember name="BEG0CST" value="N" session>selected</clp_ifmember>
>N</option>
<option NAME="P" VALUE="P"
<clp_ifmember name="BEG0CST" value="P" session>selected</clp_ifmember>
>P</option>
<option NAME="Q" VALUE="Q"
<clp_ifmember name="BEG0CST" value="Q" session>selected</clp_ifmember>
>Q</option>
<option NAME="R" VALUE="R"
<clp_ifmember name="BEG0CST" value="R" session>selected</clp_ifmember>
>R</option>
<option NAME="S" VALUE="S"
<clp_ifmember name="BEG0CST" value="S" session>selected</clp_ifmember>
>S</option>
<option NAME="T" VALUE="T"
<clp_ifmember name="BEG0CST" value="T" session>selected</clp_ifmember>
>T</option>
<option NAME="V" VALUE="V"
<clp_ifmember name="BEG0CST" value="V" session>selected</clp_ifmember>
>V</option>
<option NAME="W" VALUE="W"
<clp_ifmember name="BEG0CST" value="W" session>selected</clp_ifmember>
>W</option>
<option NAME="X" VALUE="X"
<clp_ifmember name="BEG0CST" value="X" session>selected</clp_ifmember>
>X</option>
<option NAME="Y" VALUE="Y"
<clp_ifmember name="BEG0CST" value="Y" session>selected</clp_ifmember>
>Y</option>
<option NAME="Z" VALUE="Z"
<clp_ifmember name="BEG0CST" value="Z" session>selected</clp_ifmember>
>Z</option></select>
<br><span CLASS="deepred">a  consonant&nbsp;<input TYPE="CHECKBOX" NAME="BEG0CSTBOX" ONCLICK="setAllOptions(document.mainform.BEG0CST,this.checked);"></span></td></tr></table></td><td>
<table class="negframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 ALIGN="CENTER" class="negative"><span CLASS="bolddeepred">Does not contain...</span></td></tr><tr><td ALIGN="CENTER" class="negative">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="deepred"><i>(vowel)</i></span>
<br><select MULTIPLE SIZE=5 NAME="CNT0VWL">
<option NAME="A" VALUE="A"
<clp_ifmember name="CNT0VWL" value="A" session>selected</clp_ifmember>
>A</option>
<option NAME="E" VALUE="E"
<clp_ifmember name="CNT0VWL" value="E" session>selected</clp_ifmember>
>E</option>
<option NAME="I" VALUE="I"
<clp_ifmember name="CNT0VWL" value="I" session>selected</clp_ifmember>
>I</option>
<option NAME="O" VALUE="O"
<clp_ifmember name="CNT0VWL" value="O" session>selected</clp_ifmember>
>O</option>
<option NAME="U" VALUE="U"
<clp_ifmember name="CNT0VWL" value="U" session>selected</clp_ifmember>
>U</option></select>
<br><span CLASS="deepred">a  vowel&nbsp;<input TYPE="CHECKBOX" NAME="CNT0VWLBOX" ONCLICK="setAllOptions(document.mainform.CNT0VWL,this.checked);"></span></td><td ALIGN="CENTER" class="negative">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="deepred"><i>(consonant)</i></span>
<br><select MULTIPLE SIZE=5 NAME="CNT0CST">
<option NAME="B" VALUE="B"
<clp_ifmember name="CNT0CST" value="B" session>selected</clp_ifmember>
>B</option>
<option NAME="C" VALUE="C"
<clp_ifmember name="CNT0CST" value="C" session>selected</clp_ifmember>
>C</option>
<option NAME="D" VALUE="D"
<clp_ifmember name="CNT0CST" value="D" session>selected</clp_ifmember>
>D</option>
<option NAME="F" VALUE="F"
<clp_ifmember name="CNT0CST" value="F" session>selected</clp_ifmember>
>F</option>
<option NAME="G" VALUE="G"
<clp_ifmember name="CNT0CST" value="G" session>selected</clp_ifmember>
>G</option>
<option NAME="H" VALUE="H"
<clp_ifmember name="CNT0CST" value="H" session>selected</clp_ifmember>
>H</option>
<option NAME="J" VALUE="J"
<clp_ifmember name="CNT0CST" value="J" session>selected</clp_ifmember>
>J</option>
<option NAME="K" VALUE="K"
<clp_ifmember name="CNT0CST" value="K" session>selected</clp_ifmember>
>K</option>
<option NAME="L" VALUE="L"
<clp_ifmember name="CNT0CST" value="L" session>selected</clp_ifmember>
>L</option>
<option NAME="M" VALUE="M"
<clp_ifmember name="CNT0CST" value="M" session>selected</clp_ifmember>
>M</option>
<option NAME="N" VALUE="N"
<clp_ifmember name="CNT0CST" value="N" session>selected</clp_ifmember>
>N</option>
<option NAME="P" VALUE="P"
<clp_ifmember name="CNT0CST" value="P" session>selected</clp_ifmember>
>P</option>
<option NAME="Q" VALUE="Q"
<clp_ifmember name="CNT0CST" value="Q" session>selected</clp_ifmember>
>Q</option>
<option NAME="R" VALUE="R"
<clp_ifmember name="CNT0CST" value="R" session>selected</clp_ifmember>
>R</option>
<option NAME="S" VALUE="S"
<clp_ifmember name="CNT0CST" value="S" session>selected</clp_ifmember>
>S</option>
<option NAME="T" VALUE="T"
<clp_ifmember name="CNT0CST" value="T" session>selected</clp_ifmember>
>T</option>
<option NAME="V" VALUE="V"
<clp_ifmember name="CNT0CST" value="V" session>selected</clp_ifmember>
>V</option>
<option NAME="W" VALUE="W"
<clp_ifmember name="CNT0CST" value="W" session>selected</clp_ifmember>
>W</option>
<option NAME="X" VALUE="X"
<clp_ifmember name="CNT0CST" value="X" session>selected</clp_ifmember>
>X</option>
<option NAME="Y" VALUE="Y"
<clp_ifmember name="CNT0CST" value="Y" session>selected</clp_ifmember>
>Y</option>
<option NAME="Z" VALUE="Z"
<clp_ifmember name="CNT0CST" value="Z" session>selected</clp_ifmember>
>Z</option></select>
<br><span CLASS="deepred">a  consonant&nbsp;<input TYPE="CHECKBOX" NAME="CNT0CSTBOX" ONCLICK="setAllOptions(document.mainform.CNT0CST,this.checked);"></span></td></tr></table></td><td>
<table class="negframe" BORDER=0 CELLPADDING=0 CELLSPACING=6>
<tr>
<td COLSPAN=2 ALIGN="CENTER" class="negative"><span CLASS="bolddeepred">Does not end with...</span></td></tr><tr><td ALIGN="CENTER" class="negative">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="deepred"><i>(vowel)</i></span>
<br><select MULTIPLE SIZE=5 NAME="END0VWL">
<option NAME="A" VALUE="A"
<clp_ifmember name="END0VWL" value="A" session>selected</clp_ifmember>
>A</option>
<option NAME="E" VALUE="E"
<clp_ifmember name="END0VWL" value="E" session>selected</clp_ifmember>
>E</option>
<option NAME="I" VALUE="I"
<clp_ifmember name="END0VWL" value="I" session>selected</clp_ifmember>
>I</option>
<option NAME="O" VALUE="O"
<clp_ifmember name="END0VWL" value="O" session>selected</clp_ifmember>
>O</option>
<option NAME="U" VALUE="U"
<clp_ifmember name="END0VWL" value="U" session>selected</clp_ifmember>
>U</option></select>
<br><span CLASS="deepred">a  vowel&nbsp;<input TYPE="CHECKBOX" NAME="END0VWLBOX" ONCLICK="setAllOptions(document.mainform.END0VWL,this.checked);"></span></td><td ALIGN="CENTER" class="negative">
<img SRC="assets/clearpixel.gif" WIDTH=120 HEIGHT=1><br><span CLASS="deepred"><i>(consonant)</i></span>
<br><select MULTIPLE SIZE=5 NAME="END0CST">
<option NAME="B" VALUE="B"
<clp_ifmember name="END0CST" value="B" session>selected</clp_ifmember>
>B</option>
<option NAME="C" VALUE="C"
<clp_ifmember name="END0CST" value="C" session>selected</clp_ifmember>
>C</option>
<option NAME="D" VALUE="D"
<clp_ifmember name="END0CST" value="D" session>selected</clp_ifmember>
>D</option>
<option NAME="F" VALUE="F"
<clp_ifmember name="END0CST" value="F" session>selected</clp_ifmember>
>F</option>
<option NAME="G" VALUE="G"
<clp_ifmember name="END0CST" value="G" session>selected</clp_ifmember>
>G</option>
<option NAME="H" VALUE="H"
<clp_ifmember name="END0CST" value="H" session>selected</clp_ifmember>
>H</option>
<option NAME="J" VALUE="J"
<clp_ifmember name="END0CST" value="J" session>selected</clp_ifmember>
>J</option>
<option NAME="K" VALUE="K"
<clp_ifmember name="END0CST" value="K" session>selected</clp_ifmember>
>K</option>
<option NAME="L" VALUE="L"
<clp_ifmember name="END0CST" value="L" session>selected</clp_ifmember>
>L</option>
<option NAME="M" VALUE="M"
<clp_ifmember name="END0CST" value="M" session>selected</clp_ifmember>
>M</option>
<option NAME="N" VALUE="N"
<clp_ifmember name="END0CST" value="N" session>selected</clp_ifmember>
>N</option>
<option NAME="P" VALUE="P"
<clp_ifmember name="END0CST" value="P" session>selected</clp_ifmember>
>P</option>
<option NAME="Q" VALUE="Q"
<clp_ifmember name="END0CST" value="Q" session>selected</clp_ifmember>
>Q</option>
<option NAME="R" VALUE="R"
<clp_ifmember name="END0CST" value="R" session>selected</clp_ifmember>
>R</option>
<option NAME="S" VALUE="S"
<clp_ifmember name="END0CST" value="S" session>selected</clp_ifmember>
>S</option>
<option NAME="T" VALUE="T"
<clp_ifmember name="END0CST" value="T" session>selected</clp_ifmember>
>T</option>
<option NAME="V" VALUE="V"
<clp_ifmember name="END0CST" value="V" session>selected</clp_ifmember>
>V</option>
<option NAME="W" VALUE="W"
<clp_ifmember name="END0CST" value="W" session>selected</clp_ifmember>
>W</option>
<option NAME="X" VALUE="X"
<clp_ifmember name="END0CST" value="X" session>selected</clp_ifmember>
>X</option>
<option NAME="Y" VALUE="Y"
<clp_ifmember name="END0CST" value="Y" session>selected</clp_ifmember>
>Y</option>
<option NAME="Z" VALUE="Z"
<clp_ifmember name="END0CST" value="Z" session>selected</clp_ifmember>
>Z</option></select>
<br><span CLASS="deepred">a  consonant&nbsp;<input TYPE="CHECKBOX" NAME="END0CSTBOX" ONCLICK="setAllOptions(document.mainform.END0CST,this.checked);"></span></td></tr></table></td></tr></table><br>

<script LANGUAGE="JavaScript">
<!-- This only works in IE, sigh
document.getElementById('CNT0VWLBOX').disabled=true;
document.getElementById('CNT0CSTBOX').disabled=true;
--></script>
<br>
<clp_include name="bottom.clp"/>
</td>
</tr>
</table>
</td>
</tr>
</table>
</form>
</center>
</body>
</html>
