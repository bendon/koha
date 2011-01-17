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
    addTermSaveButton(termObj.concept.termcode, termObj.labels, termObj.concept.language);
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
    var txt = document.createTextNode(labels + ': ' + termcode);
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
// <input type="checkbox"> Select?
    var b = document.createElement("button");
    var scriptTxt = 'saveTerm(' + termcode + ",'";
    scriptTxt += label + "','";
    scriptTxt += language + "'); return false;";

    b.type = 'button'; // to ensure it dosent default to submit
    b.setAttribute('onclick', scriptTxt);
    var txt = document.createTextNode(" select?");
    b.appendChild(txt);
    return b;
}

/*
 * Primary/Secondary
 * Topic/Geog
 * Lang
 * Term
 * TermId
 */
/*
function agrovocAddTerm( index, term ) {
    var original = document.getElementById(index);
    fields_in_use[index.substr(0, 12)]++;
    var clone = original.cloneNode(true);
    var new_key = CreateKey();
    var new_id = original.getAttribute('id')+new_key;

    var inputs     = clone.getElementsByTagName('input');
    var selects    = clone.getElementsByTagName('select');
    var textareas  = clone.getElementsByTagName('textarea');
    var linkid;
    // input
    var id_input = "";
    for(var i=0,len=inputs.length; i<len ; i++ ){
        id_input = inputs[i].getAttribute('id')+new_key;
        inputs[i].setAttribute('id',id_input);
        inputs[i].setAttribute('name',inputs[i].getAttribute('name')+new_key);
	linkid = id_input;
    }

    // select 
    for(var i=0,len=selects.length; i<len ; i++ ){
        id_input = selects[i].getAttribute('id')+new_key;
        selects[i].setAttribute('id',selects[i].getAttribute('id')+new_key);
        selects[i].setAttribute('name',selects[i].getAttribute('name')+new_key);
    }
    
    // textarea
    for(var i=0,len=textareas.length; i<len ; i++ ){
        id_input = textareas[i].getAttribute('id')+new_key;
        textareas[i].setAttribute('id',textareas[i].getAttribute('id')+new_key);
        textareas[i].setAttribute('name',textareas[i].getAttribute('name')+new_key);
    }

    <!-- TMPL_UNLESS NAME='advancedMARCEditor' -->
    // when cloning a subfield, reset its label too.
    var label = clone.getElementsByTagName('label')[0];
    label.setAttribute('for',id_input);
    <!-- /TMPL_UNLESS -->
    
    // setting a new id for the parent div
    clone.setAttribute('id',new_id);
    
    try {
        var buttonUp = clone.getElementsByTagName('img')[0];
        buttonUp.setAttribute('onclick',"upSubfield('" + new_id + "')");
        var anchors = clone.getElementsByTagName('a');
        if(anchors.length){
            for(var i = 0 ,lenanchors = anchors.length ; i < lenanchors ; i++){
                if(anchors[i].getAttribute('class') == 'buttonPlus'){
                    anchors[i].setAttribute('onclick',"CloneSubfield('" + new_id + "')");
                } else if (anchors[i].getAttribute('class') == 'buttonMinus') {
                    anchors[i].setAttribute('onclick',"UnCloneField('" + new_id + "')");
                }
            }
        }
    }
    catch(e){
        // do nothig if ButtonPlus & CloneButtonPlus don't exist.
    }
    // insert this line on the page
    original.parentNode.insertBefore(clone,original.nextSibling);
}
 */
