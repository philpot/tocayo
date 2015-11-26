<script LANGUAGE="Javascript"><!--

ar = new Array(
new Array("1","S1","1 Syllable: 'Ruth,George'"),
new Array("2","S10","2 Syllables, Stress on first syllable: 'BILLy,SADie'"),
new Array("2","S01","2 Syllables, Stress on second syllable: 'maRIE,laMAR'"),
new Array("2","S11","2 Syllables, Stress on both: 'MATTHEW,ROXANNE'"),
new Array("3","S100","3 Syllables, Stress on first syllable: 'EMily,ROmeo'"),
new Array("3","S010","3 Syllables, Stress on second syllable: 'beLINda,franCISco'"),
new Array("3","S001","3 Syllables, Stress on third syllable: 'raphaEL,gabriELLE'"),
new Array("4","S1000","4 Syllables, Stress on first syllable: 'BONaventure'"),
new Array("4","S0100","4 Syllables, Stress on second syllable: 'eLIZabeth,barTHOLomew'"),
new Array("4","S0010","4 Syllables, Stress on third syllable: 'alexANDer,liliANa'"),  
new Array("5","S00100","5 Syllables, Stress on third syllable: 'anaSTASia,desiDERio'"));

start = 0;
end = ar.length-1;

mins = new Array(-1,0,1,4,7,10);
maxs = new Array(-1,0,3,6,9,10);

function val(input) {
  cur = input.value;
  // alert('Validate: 1 <= 5 vs' + cur);
  if (input.value < 1) {
    alert('Minimum 1 syllable');
    input.value = 1;
    }
  if (input.value > 5) {
    alert('Maximum of 5 syllables');
    input.value = 5;
    }
  };

function order(imin,imax) {
  if (imin.value > imax.value) {
    alert('Swapping values ' + imin.value + ' and ' + imax.value);
    // reverse
    temp = imin.value;
    imin.value = imax.value;
    imax.value = temp;
  }
};

function modify(sel,min,max) {
  // alert('modify');
  if (min != null) start = mins[min];
  if (max != null) end = maxs[max];
  // empty existing options
  // but remember which ones were selected before
  prevsel = new Array();
  numselected = 0;
  allsel = true;
  for (i = sel.options.length-1; i >= 0; i--) {
    // alert('Considering option ' + i + ' ' + sel.options[i]);
    // remember if all were selected
    allsel = allsel && sel.options[i].selected;
    // remember selected ones
    if (sel.options[i].selected) {
       prevsel[numselected] = sel.options[i].value;
       numselected++;
       }
    // get rid of this option; will recreate
    sel.options[i] = null; 
  }
  if (numselected == 0) {
     allsel = false;
  }
  // recreate
  numnewitems = 0;
  for (i = start; i<= end; i++) {
    sel.options[numnewitems] = new Option(ar[i]);
    sel.options[numnewitems].text = ar[i][2];
    sel.options[numnewitems].value = ar[i][0]+':'+ar[i][1];
    numnewitems++;
    // alert('The '+numnewitems+'th menu item is '+ar[i]);
   }
  // only if all items were previously selected
  // should extending or contracting cause 
  // all new items to be selected
  for (i = 0; i<numnewitems; i++) {
    if (allsel && sel.options[i]) {
      sel.options[i].selected = true;
    }
    // OR previously selected
    for (n = 0; n<numselected; n++) {
      // alert('Options');

      if (prevsel[n] == sel.options[i].value) {
        sel.options[i].selected = true;
	}
    }
  }
};

// alert('Setting ' + groupname + ' and ' + value + ' for ' + thing.checked);

function preset(groupname,value,thing) {
  var vec = document.mainform[groupname];
  var check = thing.checked;
  for (i=0; i<vec.length; i++) {
    // alert(vec[i].value);
    if (value == 'WILD' || value == vec[i].value) {
      vec[i].checked = check;
      }
    }
  }


function unset(groupname,value,thing) {
  if (!thing.checked) preset(groupname,value,thing);
}

function setAllOptions(sel,val) {
  var opts = sel.options;
  for(i=0; i<opts.length; i++) {
    opts[i].selected=val;
  // would be nice if this scrolled to top of first selected item
  }
}

function goto(url) {
  if (top.location == self.location) {
    top.location = url;
  }
}
-->
</script>
