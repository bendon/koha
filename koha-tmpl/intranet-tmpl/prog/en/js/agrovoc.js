// Functions to be used in the agrovoc interface
//

function get_subj_tag_id() {
    var subjTab = document.getElementById('tab6xx');
    var re = /^tag_650_/;
    var children = subjTab.childNodes();
    for (var i = children[length] - 1; i >= 0; i--) {
        if (children[i].id ) {
            var id = children[i].id;
            if (re.test(id)) {
                // clone based on id
                // i = -1;
                return id;
            }
        }
    }
}

function get_geog_tag_id() {
    var subjTab = document.getElementById('tab6xx');
    var re = /^tag_651_/;
    var children = subjTab.childNodes();
    for (var i = children[length] - 1; i >= 0; i--) {
        if (children[i].id ) {
            var id = children[i].id;
            if (re.test(id)) {
                // clone based on id
                // i = -1;
                return id;
            }
        }
    }
}

function agrovoc_add_tags(tagnum, termArray) {
    var index_id;
    if (tagnum == 650) {
        index_id = get_subj_tag_id();
    } else if (tagnum == 651) {
        index_id = get_geog_tag_id();
    } else {
        return '';
    }
    for (var i = 0; i < termArray[length]; i++) {

        index_id = agrovocAddTerm(index_id, termArray[i]);
    }
}

/*
 * Primary/Secondary
 * Topic/Geog
 * Lang
 * Term
 * TermId
 */
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
