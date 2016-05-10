var Quote = 0;
var Bold  = 0;
var Italic = 0;
var Underline = 0;
var Center = 0;
var Strike = 0;
var Marquee = 0;
var Fly = 0;
var fanzi=0;

function Cbold() {
fontbegin="[B]";
fontend="[/B]";
fontchuli();
}
function Citalic() {
fontbegin="[I]";
fontend="[/I]";
fontchuli();
}
function Cunder() {
fontbegin="[U]";
fontend="[/U]";
fontchuli();
}
function Ccenter() {
fontbegin="[center]";
fontend="[/center]";
fontchuli();
}
helpstat = false;
stprompt = true;
basic = false;
function thelp(swtch){
	if (swtch == 1){
		basic = false;
		stprompt = false;
		helpstat = true;
	} else if (swtch == 0) {
		helpstat = false;
		stprompt = false;
		basic = true;
	} else if (swtch == 2) {
		helpstat = false;
		basic = false;
		stprompt = true;
	}
}



function Cmarquee() {
fontbegin="[move]";
fontend="[/move]";
fontchuli();
}
function Cfly() {
fontbegin="[fly]";
fontend="[/fly]";
fontchuli();
}

function paste(text) {
	if (opener.document.frmAnnounce.Contents.createTextRange && opener.document.frmAnnounce.Contents.caretPos) {      
		var caretPos = opener.document.frmAnnounce.Contents.caretPos;      
		caretPos.text = caretPos.text.charAt(caretPos.text.length - 1) == ' ' ?
		text + ' ' : text;
	}
	else opener.document.frmAnnounce.Contents.value += text;
	opener.document.frmAnnounce.Contents.focus(caretPos);
}

function showsize(size){
fontbegin="[size="+size+"]";
fontend="[/size]";
fontchuli();
}

function showcolor(color){
fontbegin="[color="+color+"]";
fontend="[/color]";
fontchuli();
}

function fontchuli(){
if ((document.selection)&&(document.selection.type == "Text")) {
var range = document.selection.createRange();
var ch_text=range.text;
range.text = fontbegin + ch_text + fontend;
} 
else {
document.frmAnnounce.Content.value=fontbegin+document.frmAnnounce.Content.value+fontend;
document.frmAnnounce.Content.focus();
}
}

