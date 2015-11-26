<html>
<body>
<!-- setting up page -->
<!-- spelling -->

<clp_set name="BEG1VWL" session/>
<clp_set name="BEG1CST" session/>
<clp_set name="CNT1VWL" session/>
<clp_set name="CNT1CST" session/>
<clp_set name="END1VWL" session/>
<clp_set name="END1CST" session/>
<clp_set name="BEG0VWL" session/>
<clp_set name="BEG0CST" session/>
<clp_set name="CNT0VWL" session/>
<clp_set name="CNT0CST" session/>
<clp_set name="END0VWL" session/>
<clp_set name="END0CST" session/>

<!-- syllables -->

<clp_set name="MINSYL" value="1" session/>
<clp_set name="MAXSYL" value="5" session/>

<clp_add name="STRESS" value="1:S" session/>
<clp_add name="STRESS" value="2:S10" session/>
<clp_add name="STRESS" value="2:S01" session/>
<clp_add name="STRESS" value="2:S11" session/>
<clp_add name="STRESS" value="3:S100" session/>
<clp_add name="STRESS" value="3:S010" session/>
<clp_add name="STRESS" value="3:S001" session/>
<clp_add name="STRESS" value="4:S1000" session/>
<clp_add name="STRESS" value="4:S0100" session/>
<clp_add name="STRESS" value="4:S0010" session/>
<clp_add name="STRESS" value="5:S00100" session/>

<!-- sound -->

<clp_set name="BEG1SND" session/>
<clp_set name="CNT1SND" session/>
<clp_set name="END1SND" session/>
<clp_set name="BEG0SND" session/>
<clp_set name="CNT0SND" session/>
<clp_set name="END0SND" session/>

<!-- origin -->

<clp_add name="ORIGIN" value="A1" session/>
<clp_add name="ORIGIN" value="A2" session/>
<clp_add name="ORIGIN" value="AR" session/>
<clp_add name="ORIGIN" value="HY" session/>
<clp_add name="ORIGIN" value="KM" session/>
<clp_add name="ORIGIN" value="ZH" session/>
<clp_add name="ORIGIN" value="NL" session/>
<clp_add name="ORIGIN" value="EN" session/>
<clp_add name="ORIGIN" value="FA" session/>
<clp_add name="ORIGIN" value="FR" session/>
<clp_add name="ORIGIN" value="G1" session/>
<clp_add name="ORIGIN" value="DE" session/>
<clp_add name="ORIGIN" value="EL" session/>
<clp_add name="ORIGIN" value="H1" session/>
<clp_add name="ORIGIN" value="HE" session/>
<clp_add name="ORIGIN" value="HI" session/>
<clp_add name="ORIGIN" value="HU" session/>
<clp_add name="ORIGIN" value="IT" session/>
<clp_add name="ORIGIN" value="JA" session/>
<clp_add name="ORIGIN" value="LA" session/>
<clp_add name="ORIGIN" value="PL" session/>
<clp_add name="ORIGIN" value="PT" session/>
<clp_add name="ORIGIN" value="RU" session/>
<clp_add name="ORIGIN" value=vian session/>
<clp_add name="ORIGIN" value="S2" session/>
<clp_add name="ORIGIN" value="ES" session/>
<clp_add name="ORIGIN" value="SW" session/>
<clp_add name="ORIGIN" value="TR" session/>
<clp_add name="ORIGIN" value="VI" session/>
<clp_add name="ORIGIN" value="S1" session/>

<clp_set name="ORIGIN" session/>

<!-- popularity -->

<clp_set name="POP" session/>

<!-- misc -->

<clp_add name="GENDER" value="M" session/>
<clp_add name="GENDER" value="F" session/>

<!-- show vars -->

<clp_set name="SHOW_PHONDIST" session/>
<clp_set name="SORT_PHONDIST" value="ASC" session/>
<clp_set name="FOLD_PHONDIST" session/>

<clp_set name="SHOW_SEMDIST" session/>
<clp_set name="SORT_SEMDIST" value="ASC" session/>
<clp_set name="FOLD_SEMDIST" session/>

<clp_set name="SHOW_NAME" value="T" session/>
<clp_set name="SORT_NAME" value="ASC" session/>
<clp_set name="FOLD_NAME" session/>

<clp_set name="SHOW_GENDER" value="T" session/>
<clp_set name="SORT_GENDER" value="ASC" session/>
<clp_set name="FOLD_GENDER" session/>

<clp_set name="SHOW_ORIGIN" value="T" session/>
<clp_set name="SORT_ORIGIN" value="ASC" session/>
<clp_set name="FOLD_ORIGIN" session/>

<clp_set name="SHOW_SYLLABLES" value="T" session/>
<clp_set name="SORT_SYLLABLES" value="ASC" session/>
<clp_set name="FOLD_SYLLABLES" session/>

<clp_set name="SHOW_STRESS" value="T" session/>
<clp_set name="SORT_STRESS" value="ASC" session/>
<clp_set name="FOLD_STRESS" session/>

<clp_set name="SHOW_PRON" session/>
<clp_set name="SORT_PRON" value="ASC" session/>
<clp_set name="FOLD_PRON" session/>

<clp_set name="SHOW_MEANING" value="T" session/>
<clp_set name="SORT_MEANING" value="ASC" session/>
<clp_set name="FOLD_MEANING" session/>

<clp_set name="SHOW_POPULARITY" value="T" session/>
<clp_set name="SORT_POPULARITY" value="ASC" session/>
<clp_set name="FOLD_POPULARITY" session/>

<p>
<B>NameMyBaby!</B> is an application for finding names, for example,
for naming a child or a character in a work of fiction.
</p>

<p> To use the program, one successively chooses criteria to select in
or filter out names.  Criteria that the program uses include a name's
spelling; sound, including number of syllables; cultural, ethnic, or
language of origin; popularity (measured by the number of uses of the
name for naming new babies in the US, per 2001 Social Security
Administration records), and gender marking.  Data available for
inspection for each name but currently not used in search include
spoken pronunciation (.wav) file and catalog of name meanings, related
names, and individuals with a given name.  </p>

<p>
When search is complete, you can save the data to another file and/or
restart with all criteria removed.
</p>

<p>
This web-based application requires javascript and has been tested
most extensively using IE 6.
</p>


<ul>
<li><a href="spelling.clp">Start</a>
<!--
<li><a href="syllables.clp">syllables</a>
<li><a href="sound.clp">sound</a>
<li><a href="origin.clp">origin</a>
<li><a href="popularity.clp">popularity</a>
<li><a href="misc.clp">misc</a>
-->
</ul>

</body>
</html>
