// Functions to be used in the agrovoc interface
function getXmlHttp() {
    var xmlhttp = null;
    if (window.XMLHttpRequest) {
        xmlhttp = new XMLHttpRequest();
        //if (xmlhttp.overrideMimeType) {
        //    xmlhttp.overrideMimeType('text/xml');
        //}
    }
    else if (window.ActiveXObject) {
        xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
    }
    return xmlhttp;
}

function searchTerm() {
    var searchstring = document.getElementById("searchstring").value;
    var searchmode = document.getElementById('searchmode').value;
    var langEN = document.getElementById('lang_english');
    var langFR = document.getElementById('lang_french');
    var langES = document.getElementById('lang_spanish');
    var url = 'search.pl?op=search&searchmode=' + encodeURIComponent(searchmode);
    var url = url + '&searchstring=' + encodeURIComponent(searchstring);
    if (langEN.checked) {
        url = url + '&language=' + langEN.value;
    }
    if (langFR.checked) {
        url = url + '&language=' + langFR.value;
    }
    if (langES.checked) {
        url = url + '&language=' + langES.value;
    }
    //if (!xmlHttpObj) 
        xmlHttpObj = getXmlHttp();
    if (!xmlHttpObj) return;
    xmlHttpObj.open( 'GET', url, true );
    xmlHttpObj.onreadystatechange=processSearchResult;
    xmlHttpObj.send(null);
}

function processSearchResult() {
    if (xmlHttpObj.readyState == 4 && xmlHttpObj.status == 200) {
        //document.getElementById('termPane').innerHTML = xmlHttpObj.responseText;
        searchResults(xmlHttpObj.responseText);
    } else if ( xmlHttpObj.readyState == 4 && xmlHttpObj.status != 200) {
        document.getElementById('searchResultsPane').innerHTML = 'Error Agrovoc Search failed!';
    }
}

function lookupTerm(termcode, language) {
    //if (!document.getElementById || !document.createTextNode) {
    //    return;
    //}
    var url = 'term.pl?termcode=' + termcode;
    url = url + '&lang=' + language;

    //if (!xmlHttpObj) 
        xmlHttpObj = getXmlHttp();
    if (!xmlHttpObj) return;

    xmlHttpObj.open( 'GET', url, true );
    xmlHttpObj.onreadystatechange=processResult;
    xmlHttpObj.send(null);
}

function processResult() {
    if (xmlHttpObj.readyState == 4 && xmlHttpObj.status == 200) {
        //document.getElementById('termPane').innerHTML = xmlHttpObj.responseText;
        displayTerm(xmlHttpObj.responseText);
    } else if ( xmlHttpObj.readyState == 4 && xmlHttpObj.status != 200) {
        document.getElementById('termPane').innerHTML = 'Error Term Search failed!';
    }
}


function displayTerm(termString) {
    var termObj = JSON.parse(termString);
    // remove any existing elements from termPane
    // rewrite them with the termObj 
    var div1    = document.getElementById('termcodeLabel');
    var paras   = div1.getElementsByTagName("p");
    var termTxt =  document.createTextNode(termObj.concept.termcode + ": ");
    var strongTxt = document.createTextNode(termObj.labels);
    var para = document.createElement("p");
    var strongLbl = document.createElement("strong");
    strongLbl.appendChild(strongTxt);
    para.appendChild(termTxt);
    para.appendChild(strongLbl);
    div1.replaceChild(para, paras[0]);

    replaceAltLang( termObj.concept.termcode, termObj.concept.other_lang );

    replaceTList('USElist', termObj.concept.USE);
    replaceTList('NTlist', termObj.concept.NT);
    replaceTList('BTlist', termObj.concept.BT);
    replaceTList('RTlist', termObj.concept.RT);
    replaceTList('UFlist', termObj.concept.UF);
    addTermSaveButton(termObj.concept.termcode, termObj.labels, termObj.termlang);
}

function addTermSaveButton(termcode, labels, language) {
    /*
     * Add to the div saveButtonBar
    <strong>Save As:</strong>
    <button class="green90x24" onclick="saveTerm(1,<!-- TMPL_VAR NAME='termcode' -->,'<!-- TMPL_VAR NAME='labels' -->','<!-- TMPL_VAR NAME='termlang'-->'); return false;">Primary</button>
     */
    var div = document.getElementById('saveButtonBar');
    var b = document.createElement("button");
    var oldb   = div.getElementsByTagName("button");
    var scriptTxt = 'saveTerm(' + termcode + ",'";
    scriptTxt += labels + "','";
    scriptTxt += language + "'); return false;";

    b.className = 'green90x24';
    b.type = 'button'; // to ensure it dosent default to submit
    b.setAttribute('onclick', scriptTxt);
    var txt = document.createTextNode('Select');
    b.appendChild(txt);

    if (oldb[0]) {
        div.replaceChild(b, oldb[0]);
    } else {
        div.appendChild(b);
    }

}

function saveTerm(termcode, labels, termlang) {
    /* Write the term in the save box */
    var div = document.getElementById('savedTerms');
    var newPara = document.createElement("p");
    var txt = document.createTextNode(labels + ': ' + termcode + ': (' + termlang + ')');
    newPara.appendChild(txt);
    div.appendChild(newPara);
}

function searchResults(resultString) {
    var results = JSON.parse(resultString);
    // arrayref of termcode matchedTerm language
    var div = document.getElementById('resultsList');
    var oldul = div.getElementsByTagName("ul")[0];
    var ul = document.createElement("ul");
    for(var i = 0; i < results.length; i++) {
        var li = document.createElement("li");
        var labelTxt = document.createTextNode(results[i].matchedTerm);
        var b        = termlinkButton(results[i].termcode, results[i].language);
        li.appendChild(labelTxt);
        li.appendChild(b);
        var s = selectCheckbox(results[i].termcode, results[i].matchedTerm, results[i].language);
        li.appendChild(s);
        ul.appendChild(li);
    }
    div.replaceChild(ul,oldul);
}


function replaceAltLang(termcode, langList)
{   // langname langcode
    var div    = document.getElementById('altlang');

    var oldul = div.getElementsByTagName("ul")[0];
    var ul = document.createElement("ul");
    for(var i = 0; i < langList.length; i++) {
        var li = document.createElement("li");
        var seeIn = document.createTextNode('See in ');
        li.appendChild(seeIn);
        var b = langButton(termcode, langList[i].langcode, langList[i].langname);
        li.appendChild(b);
        ul.appendChild(li);
    }
    div.replaceChild(ul,oldul);
}

function termlinkButton(termcode, language)
{
    var b = document.createElement("button");
    var scriptTxt = 'lookupTerm(' + termcode + ",'";
    scriptTxt += language + "'); return false;";
    b.className = 'termlink';
    b.type = 'button'; // to ensure it dosent default to submit
    b.setAttribute('onclick', scriptTxt);
    var txt = document.createTextNode(termcode);
    b.appendChild(txt);
    return b;
}

function langButton(termcode, language, languageLabel)
{
    var b = document.createElement("button");
    var scriptTxt = 'lookupTerm(' + termcode + ",'";
    scriptTxt += language + "'); return false;";
    b.className = 'termlink';
    b.type = 'button'; // to ensure it dosent default to submit
    b.setAttribute('onclick', scriptTxt);
    var txt = document.createTextNode(languageLabel);
    b.appendChild(txt);
    return b;
}

function replaceTList(listId, termlist)
{
    var div = document.getElementById(listId);
    var oldul = div.getElementsByTagName("ul")[0];
    var ul = document.createElement("ul");
    for(var i = 0; i < termlist.length; i++) {
        var li = document.createElement("li");
        var labelTxt = document.createTextNode(termlist[i].label);
        var b        = termlinkButton(termlist[i].termcode, termlist[i].language);
        li.appendChild(labelTxt);
        li.appendChild(b);
        var s = selectCheckbox(termlist[i].termcode, termlist[i].label, termlist[i].language);
        li.appendChild(s);
        ul.appendChild(li);
    }
    div.replaceChild(ul,oldul);
}

function selectCheckbox(termcode, label, language)
{
    var b = document.createElement("button");
    var scriptTxt = 'saveTerm(' + termcode + ",'";
    scriptTxt += label + "','";
    scriptTxt += language + "'); return false;";

    b.type = 'button'; // to ensure it dosent default to submit
    b.className = 'selectlink';
    b.setAttribute('onclick', scriptTxt);
    var txt = document.createTextNode("select");
    b.appendChild(txt);
    return b;
}

function termToTag(tagindex)
{
    var savedTerms = document.getElementById('savedTerms');
    var paras = savedTerms.getElementsByTagName('p');
    var terms = new Array();
    for( var i = 0; i < paras.length; i++) {
        var t = paras[i].firstChild.nodeValue;
        var termArr = t.split(/\s*:\s*/);
        terms.push(termArr);
    }
    var debug = terms.length;

    addTerms2Rec(tagindex, terms);
    //var txt = document.createTextNode(labels + ': ' + termcode + ': (' + termlang + ')');

    window.close();
    return false;
}

function addTerms2Rec(index, terms)
{
    var idx = index;
    for(var i = 0; i < terms.length; i++) {
        addTermWorker(idx,terms[i]);
        idx = cloneField(idx);
        //var newer_idx = opener.document.getElementById(idx).nextSibling.id;
        //idx = new_idx;
    }
}

/*
function testAddTerm(index) {
    var termArr = new Array('watermelons', 15277, 'EN');
    addTermWorker(index,termArr);

    var term2Arr = new Array('waterbirds', 36178, 'EN');
    CloneField(index);
    var new_index = document.getElementById(index).nextSibling.id;
    addTermWorker(new_index,term2Arr);
    //ExpandField(index);
    //ExpandField(new_index);
}
*/

function addTermWorker(index, termArr) {
    var t = opener.document.getElementById(index);
    var tagdata = index.split(/_/); // tagdata == tag XXX random
//    var ind_id = 'div_indicator_tag_' + tagdata[1] + '_' + tagdata[2];
//    var ind_elem = document.getElementById(ind_id).getElementsByTagName('input');
    // call .value on each element;
    var inputs = t.getElementsByTagName('input');
    sfdaRegExp = new RegExp("^tag_" + tagdata[1] + "_subfield_a");
    sfd0RegExp = new RegExp("^tag_" + tagdata[1] + "_subfield_0");
    sfd2RegExp = new RegExp("^tag_" + tagdata[1] + "_subfield_2");
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].name.match(sfdaRegExp)) {
            inputs[i].value = termArr[0];
        }
        if (inputs[i].name.match(sfd0RegExp)) {
            inputs[i].value = termArr[1];
        }
        if (inputs[i].name.match(sfd2RegExp)) {
            if (termArr[2] == 'EN') {
                inputs[i].value =  'agrovoc';
            } else if (termArr[2] == 'FR') {
                inputs[i].value =  'agrovocf';
            } else if (termArr[2] == 'ES') {
                inputs[i].value =  'agrovocs';
            }
        }

    }
}

function createKey() {
    return parseInt(Math.random() * 100000);
}

function cloneField(index) {
    var original = opener.document.getElementById(index); //original <div>
    //fields_in_use[index.substr(0, 7)]++;
    var clone = original.cloneNode(true);
    var new_key = createKey();
    var new_id  = original.getAttribute('id')+new_key;

    clone.setAttribute('id',new_id); // setting a new id for the parent div

    var divs = clone.getElementsByTagName('div');

    // setting a new name for the new indicator
    for(var i=0; i < 2; i++) {
        var indicator = clone.getElementsByTagName('input')[i];
        indicator.setAttribute('name',indicator.getAttribute('name')+new_key);
    }

    // settings all subfields
    for(var i=0,divslen = divs.length ; i<divslen ; i++){      // foreach div
        if(divs[i].getAttribute("id").match(/^subfield/)){  // if it s a subfield

            // set the attribute for the new 'div' subfields
            divs[i].setAttribute('id',divs[i].getAttribute('id')+new_key);

            var inputs   = divs[i].getElementsByTagName('input');
            var id_input = "";

            for( j = 0 ; j < inputs.length ; j++ ) {
                if(inputs[j].getAttribute("id") && inputs[j].getAttribute("id").match(/^tag_/) ){
                    inputs[j].value = "";
                }
            }

            inputs[0].setAttribute('id',inputs[0].getAttribute('id')+new_key);
            inputs[0].setAttribute('name',inputs[0].getAttribute('name')+new_key);
            var id_input;
            try {
                id_input = inputs[1].getAttribute('id')+new_key;
                inputs[1].setAttribute('id',id_input);
                inputs[1].setAttribute('name',inputs[1].getAttribute('name')+new_key);
            } catch(e) {
                try{ // it s a select if it is not an input
                    var selects = divs[i].getElementsByTagName('select');
                    id_input = selects[0].getAttribute('id')+new_key;
                    selects[0].setAttribute('id',id_input);
                    selects[0].setAttribute('name',selects[0].getAttribute('name')+new_key);
                }catch(e2){ // it is a textarea if it s not a select or an input
                    var textaeras = divs[i].getElementsByTagName('textarea');
                    id_input = textaeras[0].getAttribute('id')+new_key;
                    textaeras[0].setAttribute('id',id_input);
                    textaeras[0].setAttribute('name',textaeras[0].getAttribute('name')+new_key);
                }
            }

            // when cloning a subfield, re set its label too.
            var labels = divs[i].getElementsByTagName('label');
            labels[0].setAttribute('for',id_input);

            // updating javascript parameters on button up
            var imgs = divs[i].getElementsByTagName('img');
            imgs[0].setAttribute('onclick',"upSubfield(\'"+divs[i].getAttribute('id')+"\');");

            // setting its '+' and '-' buttons
            try {
                var anchors = divs[i].getElementsByTagName('a');
                for (var j = 0; j < anchors.length; j++) {
                    if(anchors[j].getAttribute('class') == 'buttonPlus'){
                        anchors[j].setAttribute('onclick',"CloneSubfield('" + divs[i].getAttribute('id') + "')");
                    } else if (anchors[j].getAttribute('class') == 'buttonMinus') {
                        anchors[j].setAttribute('onclick',"UnCloneField('" + divs[i].getAttribute('id') + "')");
                    } else if (anchors[j].getAttribute('class') == 'buttonDot') {
                        anchors[j].setAttribute('onclick',"openAgrovoc('" + divs[i].getAttribute('id') + "')");
                    }
                }
            }
            catch(e){
                // do nothig if ButtonPlus & CloneButtonPlus don t exist.
            }

            // button ...
            var spans=0;
            try {
                spans = divs[i].getElementsByTagName('a');
            } catch(e) {
                // no spans
            }
            if(spans){
                var buttonDot;
                if(!CloneButtonPlus){ // it s impossible to have  + ... (buttonDot AND buttonPlus)
                    buttonDot = spans[0];
                    if(buttonDot){
                        // 2 possibilities :
                        try{
                            var buttonDotOnClick = buttonDot.getAttribute('onclick');
                            if(buttonDotOnClick.match('Clictag')){   // -1- It s a plugin
                                var re = /\('.*'\)/i;
                                buttonDotOnClick = buttonDotOnClick.replace(re,"('"+inputs[1].getAttribute('id')+"')");
                                if(buttonDotOnClick){
                                    buttonDot.setAttribute('onclick',buttonDotOnClick);
                                }
                            } else {
                                if(buttonDotOnClick.match('Dopop')) {  // -2- It's a auth value
                                    var re1 = /&index=.*',/;
                                    var re2 = /,.*\)/;

                                    buttonDotOnClick = buttonDotOnClick.replace(re1,"&index="+inputs[1].getAttribute('id')+"',");
                                    buttonDotOnClick = buttonDotOnClick.replace(re2,",'"+inputs[1].getAttribute('id')+"')");

                                    if(buttonDotOnClick){
                                        buttonDot.setAttribute('onclick',buttonDotOnClick);
                                    }
                                }
                            }
                            try {
                                // do not copy the script section.
                                var script = spans[0].getElementsByTagName('script')[0];
                                spans[0].removeChild(script);
                            } catch(e) {
                                // do nothing if there is no script
                            }
                        }catch(e){}
                    }
                }
            }
            var buttonUp = divs[i].getElementsByTagName('img')[0];
            buttonUp.setAttribute('onclick',"upSubfield('" + divs[i].getAttribute('id') + "')");

        } else { // it's a indicator div
            if(divs[i].getAttribute('id').match(/^div_indicator/)){
                var inputs = divs[i].getElementsByTagName('input');
                inputs[0].setAttribute('id',inputs[0].getAttribute('id')+new_key);
                inputs[1].setAttribute('id',inputs[1].getAttribute('id')+new_key);

                var CloneButtonPlus;
                try {
                    var anchors = divs[i].getElementsByTagName('a');
                    for (var j = 0; j < anchors.length; j++) {
                        if (anchors[j].getAttribute('class') == 'buttonPlus') {
                            anchors[j].setAttribute('onclick',"CloneField('" + new_id + "')");
                        } else if (anchors[j].getAttribute('class') == 'buttonMinus') {
                            anchors[j].setAttribute('onclick',"UnCloneField('" + new_id + "')");
                        }
                    }
                }
                catch(e){
                    // do nothig CloneButtonPlus doesn't exist.
                }
                // setting its 'Expand' property
                var ExpandFieldA=0;
                try {
                    ExpandFieldA = divs[i].getElementsByTagName('a')[0];
                    ExpandFieldA.setAttribute('onclick',"ExpandField('" + divs[i].parentNode.getAttribute('id') + "')");
                }
                catch(e){
                    // do nothig if ButtonPlus & CloneButtonPlus don t exist.
                }

            }
        }
    }

    // insert this line on the page
    original.parentNode.insertBefore(clone,original.nextSibling);
    return new_id;
}
