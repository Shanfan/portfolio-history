<!--#include file="color.asp" -->
<!--#include file="../Connections/may_user.asp" -->
<HTML>
<HEAD>
<TITLE>Java applet!</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312"> 
<link rel="stylesheet" href="CSS.asp" type="text/css">
</HEAD>

<BODY BGCOLOR="<%=web_bg%>" TEXT="#000000" LEFTMARGIN="0" TOPMARGIN="0" MARGINWIDTH="0" MARGINHEIGHT="0" background="<%=web_bgimg%>">
<!--#include file="user.asp" -->
<script language="JavaScript">
<!-- Hide
function killErrors() {
  return true;
}
   window.onerror = killErrors;
// -->
</script> <script language="JavaScript">
<!--
 
if (window.Event) 
  document.captureEvents(Event.MOUSEUP); 
 
function nocontextmenu() 
{
 event.cancelBubble = true
 event.returnValue = false;
 
 return false;
}
 
function norightclick(e) 
{
 if (window.Event) 
 {
  if (e.which == 2 || e.which == 3)
   return false;
 }
 else
  if (event.button == 2 || event.button == 3)
  {
   event.cancelBubble = true
   event.returnValue = false;
   return false;
  }
 
}
 
document.oncontextmenu = nocontextmenu;  // for IE5+
document.onmousedown = norightclick;  // for all others
//-->
</script>

<%if Request.form("w") and Request.form("h") and Request.form("name")<>""then 
dim w,h,pname,paint
paint=Request.form("paint")
w=Request.form("w")
h=Request.form("h")
pname=Request.form("name")
pop=Request.form("pop")
 %>

 
 <%If paint= "painter" then %> <%pic= "Shi_painter"&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&".jpg"
		pch= "Shi_painter"&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&".spch"%><table width="750" border="0" align="center" cellpadding="0" cellspacing="0" bordercolorlight="#ffffff" bordercolordark="#777777"> 
<tr> <td align=center width="655" height="1"> <script language="JavaScript">
 var h;
 var w;
 var l;
 var t;
 var topMar = 1;
 var leftMar = -2;
 var space = 1;
 var isvisible;
 var MENU_SHADOW_COLOR='#999999';
 var global = window.document;
 global.fo_currentMenu = null;
 global.fo_shadows = new Array;

function HideMenu() 
	{
	 var mX;
	 var mY;
	 var vDiv;
	 var mDiv;
		if (isvisible == true)
		{
			vDiv = document.all("menuDiv");
			mX = window.event.clientX + document.body.scrollLeft;
			mY = window.event.clientY + document.body.scrollTop;
			if ((mX < parseInt(vDiv.style.left)) || (mX > parseInt(vDiv.style.left)+vDiv.offsetWidth) || (mY < parseInt(vDiv.style.top)-h) || (mY > parseInt(vDiv.style.top)+vDiv.offsetHeight))
			{
			vDiv.style.visibility = "hidden";
			isvisible = false;
			}
		}
	}

function ShowMenu(vMnuCode,tWidth) {
	vSrc = window.event.srcElement;
	vMnuCode = "<table id='submenu' cellspacing=1 cellpadding=3 style='width:"+tWidth+"'  bgcolor=#9cc5f8 onmouseout='HideMenu()'><tr height=23><td nowrap align=left bgcolor=#fffff9>" + vMnuCode + "</td></tr></table>";

	h = vSrc.offsetHeight;
	w = vSrc.offsetWidth;
	l = vSrc.offsetLeft + leftMar+4;
	t = vSrc.offsetTop + topMar + h + space-2;
	vParent = vSrc.offsetParent;
	while (vParent.tagName.toUpperCase() != "BODY")
	{
		l += vParent.offsetLeft;
		t += vParent.offsetTop;
		vParent = vParent.offsetParent;
	}

	menuDiv.innerHTML = vMnuCode;
	menuDiv.style.top = t;
	menuDiv.style.left = l;
	menuDiv.style.visibility = "visible";
	isvisible = true;
    makeRectangularDropShadow(submenu, MENU_SHADOW_COLOR, 4)
}

function makeRectangularDropShadow(el, color, size)
{
	var i;
	for (i=size; i>0; i--)
	{
		var rect = document.createElement('div');
		var rs = rect.style
		rs.position = 'absolute';
		rs.left = (el.style.posLeft + i) + 'px';
		rs.top = (el.style.posTop + i) + 'px';
		rs.width = el.offsetWidth + 'px';
		rs.height = el.offsetHeight + 'px';
		rs.zIndex = el.style.zIndex - i;
		rs.backgroundColor = color;
		var opacity = 1 - i / (i + 1);
		rs.filter = 'alpha(opacity=' + (100 * opacity) + ')';
		el.insertAdjacentElement('afterEnd', rect);
		global.fo_shadows[global.fo_shadows.length] = rect;
	}
}
</script> <script language="javascript">
<!--
var digit=new Array("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");

function getByte(value){
 
 return digit[(value>>>4)&0xf]+digit[value&0xf];
}
function getShort(value){
 return getByte(value>>>8)+getByte(value&0xff);
}
function getInt(value){
 return getShort(value>>>16)+getShort(value&0xffff);
}
function addLayer(){
 var len=eval(PaintBBS.getLSize());
 PaintBBS.send("iHint=14@"+getInt(1)+getInt(len+1),false);// 
}

function scale(){
 PaintBBS.getMi().scaleChange(1,true);
}

function line(){
 var header="iHint=0;iColor="+0x0000ff+";iSize=10;iLayer="+PaintBBS.getInfo().m.iLayer+"@";
 //TRUE 128 2Byte 
 PaintBBS.send(header+getShort(100)+getShort(100)+getByte(0)+getByte(50)+getByte(60)+getByte(-70),true);
 PaintBBS.send(header+getShort(200)+getShort(0)+getByte(0)+getByte(128)+getShort(400),true);
}

// 
function dot(x,y,color){
 PaintBBS.send("iColor="+color+"@"+ getShort(x)+getShort(y)+"0100",true);
}

// 
function drawFrame(size,color){
 var info=PaintBBS.getInfo();
 var m=info.m;
 
 var width=info.imW-1,height=info.imH-1;
  
 PaintBBS.send("iHint="+m.H_FRECT+";iColor="+color+";iSize="+size+";iLayer="+(PaintBBS.getLSize()-1)+"@"+getShort(0)+getShort(0)+getShort(width)+getShort(height),true);
}
//-->
</script> <script language="JavaScript">
<!--
function ResizeWin(){
	 w = document.body.clientWidth - 200; h = document.body.clientHeight - 50;
	flag = confirm("???????\n\n???????\n???????");
	if(flag) location.href = "./bbsnote.cgi?fc=paint_spa1&anime=true&width=300&height=300&palette=&appw="+w+"&apph="+h;
}

//-->

</script> <noscript> JavaScript </noscript> <script language="JavaScript">
<!--
var Palettes = new Array();
Palettes[0] = "#000000\n#FFFFFF\n#B47575\n#888888\n#FA9696\n#C096C0\n#FFB6FF\n#8080FF\n#25C7C9\n#E7E58D\n#E7962D\n#99CB7B\n#FCECE2\n#F9DDCF";
Palettes[1] = "#FFF0DC\n#52443C\n#FFE7D0\n#5E3920\n#FFD6C0\n#B06A54\n#FFCBB3\n#C07A64\n#FFC0A3\n#DEA197\n#FFB7A2\n#ECA385\n#000000\n#FFFFFF";
Palettes[2] = "#FFEEF7\n#FFE6E6\n#FFCAE4\n#FFC4C4\n#FF9DCE\n#FF7D7D\n#FF6AB5\n#FF5151\n#FF2894\n#FF0000\n#CF1874\n#BF0000\n#851B53\n#800000";
Palettes[3] = "#FFE3D7\n#FFFFDD\n#FFCBB3\n#FFFFA2\n#FFA275\n#FFFF00\n#FF8040\n#D9D900\n#FF5F11\n#AAAA00\n#DB4700\n#7D7D00\n#BD3000\n#606000";
Palettes[4] = "#C6FDD9\n#E8FACD\n#8EF09F\n#B9E97E\n#62D99D\n#9ADC65\n#1DB67C\n#65B933\n#1A8C5F\n#4F8729\n#136246\n#2B6824\n#0F3E2B\n#004000";
Palettes[5] = "#DFF4FF\n#C1FFFF\n#80C6FF\n#6DEEFC\n#60A8FF\n#44D0EE\n#1D56DC\n#209CCC\n#273D8F\n#2C769A\n#1C2260\n#295270\n#000040\n#003146";
Palettes[6] = "#E9D2FF\n#E1E1FF\n#DAB5FF\n#C1C1FF\n#CE9DFF\n#8080FF\n#B366FF\n#6262FF\n#9428FF\n#3D44C9\n#6900D2\n#33309E\n#3F007D\n#252D6B";
Palettes[7] = "#ECD3BD\n#F7E2BD\n#E4C098\n#DBC7AC\n#C8A07D\n#D9B571\n#896952\n#C09450\n#825444\n#AE7B3E\n#5E4435\n#8E5C2F\n#493830\n#5F492C";
Palettes[8] = "#FFEADD\n#DED8F5\n#FFCAAB\n#9C89C4\n#F19D71\n#CF434A\n#52443C\n#F09450\n#5BADFF\n#FDF666\n#0077D9\n#4AA683\n#000000\n#FFFFFF";
Palettes[9] = "#F6CD8A\n#FFF99D\n#89CA9D\n#C7E19E\n#8DCFF4\n#8CCCCA\n#9595C6\n#94AAD6\n#AE88B8\n#9681B7\n#F49F9B\n#F4A0BD\n#8C6636\n#FFFFFF";
Palettes[10] = "#C7E19E\n#D1E1FF\n#A8D59D\n#8DCFE0\n#7DC622\n#00A49E\n#528413\n#CBB99C\n#00B03B\n#766455\n#007524\n#5B3714\n#0F0F0F\n#FFFFFF";
Palettes[11] = "#FFFF80\n#F4C1D4\n#EE9C00\n#F4BDB0\n#C45914\n#ED6B9E\n#FEE7DB\n#E76568\n#FFC89D\n#BD3131\n#ECA385\n#AE687E\n#0F0F0F\n#FFFFFF";
Palettes[12] = "#FFFFFF\n#7F7F7F\n#EFEFEF\n#5F5F5F\n#DFDFDF\n#4F4F4F\n#CFCFCF\n#3F3F3F\n#BFBFBF\n#2F2F2F\n#AFAFAF\n#1F1F1F\n#0F0F0F\n#000000";
function setPalette(){
	d = document
	d.PaintBBS.setColors(Palettes[d.Palette.select.selectedIndex])
	//if (! d.grad.view.checked){return}
	GetPalette();
}
function PaletteSave(){
	Palettes[0] = String(document.PaintBBS.getColors())
}
var cutomP = 0;
function PaletteNew(){
	d = document
	p = String(d.PaintBBS.getColors())
	s = d.Palette.select
	Palettes[s.length] = p
	cutomP++
	str = prompt("为新增的色盘取名","新色盘" + cutomP)
	if(str == null || str == ""){cutomP--;return}
	s.options[s.length] = new Option(str)
	if(s.length < 30) s.size = s.length
}
function PaletteRenew(){
	d = document
	Palettes[d.Palette.select.selectedIndex] = String(d.PaintBBS.getColors())
}
function PaletteDel(){
	p = Palettes.length
	s = document.Palette.select
	i = s.selectedIndex
	if(i == -1)return
	
	flag = confirm("确定删除色盘["+s.options[i].text + "]吗？")
	if (!flag) return
	s.options[i] = null
	while(i<p)
		{
		Palettes[i] = Palettes[i+1]
		i++
		}
	if(s.length < 30) s.size = s.length
}
function P_Effect(v){
	v=parseInt(v)
	x = 1
	if(v==255)x=-1
	d = document.PaintBBS
	p=String(d.getColors()).split("\n")
	l = p.length
	var s = ""
	for(n=0; n<l;n++){
		R = v+(parseInt("0x" + p[n].substr(1,2))*x)
		G = v+(parseInt("0x" + p[n].substr(3,2))*x)
		B = v+(parseInt("0x" + p[n].substr(5,2))*x)
		if(R > 255){ R = 255}
		else if(R < 0){ R = 0}
		if(G > 255){ G = 255}
		else if(G < 0){ G = 0}
		if(B > 255){ B = 255}
		else if(B < 0){ B = 0}
		s += "#"+Hex(R)+Hex(G)+Hex(B)+"\n"
	}
	d.setColors(s)
}
function PaletteMatrixGet(){
	d = document.Palette
	p = Palettes.length
	s = d.select
	m = d.m_m.selectedIndex
	t = d.setr
	t.value = "!Palette\n"+String(document.PaintBBS.getColors())
	switch(m){
	case 0:case 2:default:
		n=0;c=0
		while(n<p){
			if(s.options[n] != null){ t.value = t.value + "\n!"+ s.options[n].text +"\n" + Palettes[n];c++}
			n++
		}
		alert ("已取得色盘颜色咨讯！");break
	case 1:
		alert("已取得色盘颜色咨讯！");break
	}
		t.value = t.value + "\n!Matrix"
}
function PalleteMatrixSet(){
	m = document.Palette.m_m.selectedIndex;
	str = ""
	switch(m){
	case 0:default:
		flag = confirm(str+"\n确定使用此区颜色？");break
	case 1:
		flag = confirm(str+"\n确定使用此区颜色？");break;
	case 2:
		flag = confirm(str+"\n确定使用此区颜色？");break
	}
		if (!flag) return
	
	PaletteSet()
	if(s.length < 30){ s.size = s.length}else{s.size=30};
	
}

function PaletteSet(){
	d = document.Palette
	se = d.setr.value;
	s = d.select;
	m = d.m_m.selectedIndex;
	l = se.length
	if(l<1){
		alert("现在没有任何色盘颜色咨讯！");return
	}
		n = 0;o = 0;e = 0
	switch(m){
	case 0:default:
		n = s.length
		while(n > 0){
			n--
			s.options[n] = null
		}
	case 2:
		i=s.options.length
		n = se.indexOf("!",0)+1
		if(n == 0)return
		while(n<l){
			e = se.indexOf("\n#",n)
			if(e == -1)return
			
			pn = se.substring(n,e-1)
			o = se.indexOf("!",e)
			if(o == -1)return
			pa = se.substring(e+1,o-2)
			if (pn != "Palette"){
			if(i >= 0)s.options[i] = new Option(pn)
			
			Palettes[i] = pa
			i++
			}else{document.PaintBBS.setColors(pa)}
			
			n=o+1
		}
		break
	case 1:
		n = se.indexOf("!",0)+1
		if(n == 0)return
		e = se.indexOf("\n#",n)
		o = se.indexOf("!",e)
			if(e >= 0){
				pa = se.substring(e+1,o-2)
			}
		document.PaintBBS.setColors(pa)
	}
}

function ChengeGrad(){
	d =document
	var st = d.grad.pst.value
	var ed = d.grad.ped.value
	//Chenge_()
	
	var degi_R = parseInt("0x" + st.substr(0,2))
	var degi_G = parseInt("0x" + st.substr(2,2))
	var degi_B = parseInt("0x" + st.substr(4,2))
	 var R = parseInt((degi_R - parseInt("0x" + ed.substr(0,2)))/15)
	 var G = parseInt((degi_G - parseInt("0x" + ed.substr(2,2)))/15)
	 var B = parseInt((degi_B - parseInt("0x" + ed.substr(4,2)))/15)
	 if(isNaN(R)) R = 1
	 if(isNaN(G)) G = 1
	 if(isNaN(B)) B = 1
		var p = new String()
		for(cnt=0,m1=degi_R,m2=degi_G,m3=degi_B; cnt<14; cnt++,m1-=R,m2-=G,m3-=B){
		if ((m1 > 255)||(m1 < 0)){ R *= -1;m1-=R}
		if ((m2 > 255)||(m2 < 0)){ G *= -1;m2-=G}
		if ((m3 > 255)||(m3 < 0)){ B *= -1;m2-=B}
		p += "#"+Hex(m1)+Hex(m2)+Hex(m3)+"\n"
		
		}
	document.PaintBBS.setColors(p);
}
function Hex(n){
	n = parseInt(n);if (n < 0) n *=-1;
	var hex = new String()
	var m
	var k
	while(n > 16){
	m = n
	if (n >16){
		n = parseInt(n/16)
		m -= (n * 16)
	}
		k = Hex_(m)
		hex = k + hex
	}
		k = Hex_(n)
		hex = k + hex
	while(hex.length < 2){hex="0" + hex}
	return hex
}
function Hex_(n){
	if(! isNaN(n)){
		if(n == 10){n="A"}
		else if(n == 11){n="B"}
		else if(n == 12){n="C"}
		else if(n == 13){n="D"}
		else if(n == 14){n="E"}
		else if(n == 15){n="F"}
	}else{n=""}
	return n
}
function GetPalette(){
	d = document
	p = String(document.PaintBBS.getColors());
	 if(p == "null" || p == ""){return};
	ps = p.split("\n");
	st = d.grad.p_st.selectedIndex
	ed = d.grad.p_ed.selectedIndex
	d.grad.pst.value = ps[st].substr(1.6)
	d.grad.ped.value = ps[ed].substr(1.6)
	GradSelC()
	//GradView(ps[st],ps[ed])
}
function GradSelC(){
	//if (! d.grad.view.checked)return
	d = document.grad
	l = ps.length
	pe=""
	for(n=0; n<l;n++){
		R = 255+(parseInt("0x" + ps[n].substr(1,2))*-1)
		G = 255+(parseInt("0x" + ps[n].substr(3,2))*-1)
		B = 255+(parseInt("0x" + ps[n].substr(5,2))*-1)
		if(R > 255){ R = 255}
		else if(R < 0){ R = 0}
		if(G > 255){ G = 255}
		else if(G < 0){ G = 0}
		if(B > 255){ B = 255}
		else if(B < 0){ B = 0}
		pe += "#"+Hex(R)+Hex(G)+Hex(B)+"\n"
	}
	pe = pe.split("\n");
	for(n=0;n < l;n++){
		d.p_st.options[n].style.background = ps[n];
		d.p_st.options[n].style.color = pe[n];
		d.p_ed.options[n].style.background = ps[n];
		d.p_ed.options[n].style.color = pe[n];
	}
}

//-->
</script> <!-- 	<INPUT TYPE="button" VALUE="变比例" onclick="scale()" class="bty" style="width:60px;">
	<INPUT TYPE="button" VALUE="描线" onclick="line()" class="bty" style="width:60px;">
	<INPUT TYPE="button" VALUE="描点" onclick="dot(10,10,0xff0000)" class="bty" style="width:60px;">
 --> </td><td width="146" >&nbsp;</td></tr> <tr> <td align="right" valign=top bgcolor=#cccccc height="410" width="655"> 
<table width="100%" height="100%"> <tr> <td align="right" valign=top> <!-- 		<table  width="100%" border="0" align="right" cellpadding="0" cellspacing="0" id="AutoNumber1">
              <tr> 
                <td align="right" valign=top> --> <applet code="c.ShiPainter.class" name="PaintBBS" width="100%" height="550" archive="spainter.jar,res/normal.zip" MAYSCRIPT align=right CODEBASE="../"> 
<param name="undo" value="50"> 
<param name="undo_in_mg" value="12">
 <param name="image_width" value="<%=w%>"> 
<param name="image_height" value="<%=h%>"> 
<param name="image_size" value="1"> 
<param name="image_jpeg" value="true">
 <param name="image_bk" value=""> 
<param name="image_bkcolor" value="#FFFFFF">
 <param name="color_text" value="#000000"> 
<param name="color_bk" value="#cccccc"> 
<param name="color_bk2" value="#cccccc"> 
<param name="color_icon" value="#dddddd">
 <param name="color_iconselect" value="#cccccc"> 
<param name="url_save" value="<%=user_name%>/saveSP.asp?pic=<%=pic%>&pch=<%=pch%>&PType=jpg"> 
<param name="url_exit" value="<%=user_name%>/getoekaki.asp?tool=spainter&W=<%=w%>&H=<%=h%>&pic=<%=pic%>&pch=<%=pch%>&pname=<%=pname%>&timeStart=<%=timer()%>"> 
 <param name="thumbnail_type2" value="jpg"> 
<param name="poo" value="false">
 <param name="send_advance" value="true"> 
 <param name="send_header" value=""> 
<param name="dir_resource" value="./res/">
 <param name="tt.zip" value="./res/tt.zip"> 
<param name="res.zip" value="./res/res_normal.zip">
 <param name="tools" value="normal"> 
<param name="layer_count" value="3"> 
<param name="send_language" value="utf-8"> 
<param name="thumbnail_width" value="120"> 
<param name="thumbnail_height" value="120"> 
<param name="thumbnail_type" value="animation"> 
<param name="compress_level" value="8"> 
<param name="pch_file" value=""> </applet></td></tr> </table></td><td width="146" align="left" valign="top" nowrap bgcolor=#cccccc> 
<table border="0" cellpadding="0" cellspacing="0" width="100%" height="100%" > 
<form name="Palette" style="margin:0px"> <tr> <td valign="top"> <input type="button" value="加图层" onClick="addLayer()" class="bty" style="width:60px;" name="button"> 
<input type="button" value="描边框" onClick="drawFrame(1,0x000000)" class="bty" style="width:60px;" name="button2"> 
<br> <select name="select" size="13" style="width:70" onChange="setPalette();" class="tx"> 
<option>初始系</option> <option>肤色系</option> <option>红色系</option> <option>黄橙系</option> 
<option>绿色系</option> <option>青色系</option> <option>紫色系</option> <option>黄褐系</option> 
<option>彩虹色</option> <option>淡色系</option> <option>大草原</option> <option>樱花色</option> 
<option>黑白系</option> </select> <br> <input type="button" value="暂存色盘" onClick="PaletteSave()" class="bty" style="width:87px;margin-bottom:1px;" name="button2"> 
<br> <input type="button" value="新 增" onClick="PaletteNew()" class="bty" name="button2"> 
<input type="button" value="更 改" onClick="PaletteRenew()" class="bty" name="button2"> 
<br> <input type="button" value="删 除" onClick="PaletteDel()" class="bty" name="button2"> 
<input type="button" value="加 亮" onClick="P_Effect(10)" class="bty" name="button2"> 
<br> <input type="button" value="反 转" onClick="P_Effect(255)" class="bty" name="button2"> 
<input type="button" value="减 暗" onClick="P_Effect(-10)" class="bty" name="button2"> 
<br> <img src="" height="2px"><br> <select name="m_m"  class="tx" style="width:58px;"> 
<option value=0>全部</option> <option value=1>现在</option> <option value=2>追加</option> 
</select> <br> <nobr> <input name="m_g" type="button" value="取 得" onClick="PaletteMatrixGet()" class="bty" style="width:40px;"> 
<input name="m_s" type="button" value="使 用" onClick="PalleteMatrixSet()" class="bty" style="width:40px;"> 
</nobr><br> <textarea rows="3" name="setr" cols="11" onMouseOver="this.select()" class="tx"></textarea> 
</td></tr> </form><form name="grad" style="margin:0px;"> <tr> <td height="100%" valign="top"><nobr> 
<select name="p_st" onChange="GetPalette()"  class="tx"> 
<option>1</option> <option>2</option> <option>3</option> <option>4</option> <option>5</option> 
<option>6</option> <option>7</option> <option>8</option> <option>9</option> <option>10</option> 
<option>11</option> <option>12</option> <option>13</option> <option>14</option> 
</select> <input type="text" name="pst" size="5" value="" onChange="Chenge_()" class="tx"> 
</nobr><br> <nobr> <select name="p_ed" onChange="GetPalette()"  class="tx"> 
<option>1</option> <option>2</option> <option>3</option> <option>4</option> <option>5</option> 
<option>6</option> <option>7</option> <option>8</option> <option>9</option> <option>10</option> 
<option>11</option> <option selected>12</option> <option>13</option> <option>14</option> 
</select> <input type="text" name="ped" size="5" value="" onChange="Chenge_()" class="tx"> 
</nobr><br> <nobr> <input name="ccccccc" type="button" value="---D" onClick="ChengeGrad()" class="bty" style="width:40px;"> 
<input type="button" value="提 交" onClick="ChengeGrad()" class="bty" style="width:40px;" name="button2"> 
</nobr><br> <br> </td></tr> </form><form name="toForum" method="POST" style="visibility:hidden;margin:0px;"> 
&nbsp; </form></table></td></tr> </table><p> <%end if%> <%If paint= "oekakibbs" then %> <div align="center"><br><applet name="oekakibbs" code="a.p.class" archive="oekakibbs.jar" width="<%if w>=450 then %>90%<%end if %><%if w<450 then %>750<%end if %>" height="<%if h>=450 then %>98%<%end if %><%if h<450 then %>550<%end if %>" mayscript CODEBASE="../"> 
<param name="popup" value="<%if pop="yes" then %>1<%end if %><%if pop<>"yes" then %>0<%end if %>"> 
<param name="width" value="800"> 
<param name="height" value="600"> 
<param name="pwidth" value="800">
 <param name="anime" value="1">
  <param name="readfilepath" value="picdata/"> 
<param name="readpicpath" value="picdata/">
 <param name="readpic" value="">
  <param name="url" value="getoekaki.asp?tool=oekakibbs&W=<%=w%>&H=<%=h%>&pname=<%=pname%>&timeStart=<%=timer()%>"> 
<param name="cgi" value="saveOE.asp?Action=save">
 <param name="popup" value="0"> 
<param name="tooltype" value="full">
 <param name="anime" value="1"> 
 <param name="animesimple" value="0"> 
<param name="tooljpgpng" value="0">
 <param name="toolpng" value="1"> 
 <param name="tooljpg" value="0"> 
<param name="passwd" value="my"> 
<param name="passwd2" value="pass"> 
<param name="picw" value="<%=w%>"> 
<param name="pich" value="<%=h%>"> 
<param name="baseC" value="DDDDDD">
 <param name="brightC" value="FAFAFA">
  <param name="darkC" value="666666"> 
<param name="backC" value="bbbbbb"> 
<param name="mask" value="5"> 
<param name="toolpaintmode" value="1"> 
<param name="toolmask" value="1"> 
<param name="toollayer" value="1">
 <param name="toolalpha" value="1"> 
<param name="toolwidth" value="200">
 <param name="target" value="_self"> 
 <param name="catalog" value="1"> 
<param name="catalogwidth" value="<%if w>=300 then %><%=w-150%><%end if %><%if w<300 then %><%=w-100%><%end if %>"> 
<param name="catalogheight" value="<%if h>=300 then %><%=h-150%><%end if %><%if h<300 then %><%=h-100%><%end if %>"> 
<param name="brushpath" value="./setting/"> 
<param name="allbrushes" value="5"> 
<param name="sampling" value="1"> 
<param name="webid" value="chi"> 
<param name="max_size" value="500"> 
<param name="tool0" value="1"> 
<param name="tool1" value="1"> 
<param name="tool2" value="1"> 
<param name="tool3" value="1">
 <param name="tool4" value="1"> 
 <param name="tool5" value="1"> 
<param name="tool6" value="1"> 
<param name="tool7" value="1"> 
<param name="tool8" value="1"> 
<param name="tool9" value="1"> 
<param name="tool10" value="1"> </applet> </div><P><%end if %> <%If paint= "paintbbs" then %> <%
if w=<300 then w1=450 end if 
if h=<300 then h1=450 end if 
if w>300 then w1=w+150 end if 
if h>300 then h1=h+150 end if

%><Script Language="JavaScript">
<!--

var Palettes = new Array();
Palettes[0] = "#000000\n#FFFFFF\n#B47575\n#888888\n#FA9696\n#C096C0\n#FFB6FF\n#8080FF\n#25C7C9\n#E7E58D\n#E7962D\n#99CB7B\n#FCECE2\n#F9DDCF";
Palettes[1] = "#FFF0DC\n#52443C\n#FFE7D0\n#5E3920\n#FFD6C0\n#B06A54\n#FFCBB3\n#C07A64\n#FFC0A3\n#DEA197\n#FFB7A2\n#ECA385\n#000000\n#FFFFFF";
Palettes[2] = "#FFEEF7\n#FFE6E6\n#FFCAE4\n#FFC4C4\n#FF9DCE\n#FF7D7D\n#FF6AB5\n#FF5151\n#FF2894\n#FF0000\n#CF1874\n#BF0000\n#851B53\n#800000";
Palettes[3] = "#FFE3D7\n#FFFFDD\n#FFCBB3\n#FFFFA2\n#FFA275\n#FFFF00\n#FF8040\n#D9D900\n#FF5F11\n#AAAA00\n#DB4700\n#7D7D00\n#BD3000\n#606000";
Palettes[4] = "#C6FDD9\n#E8FACD\n#8EF09F\n#B9E97E\n#62D99D\n#9ADC65\n#1DB67C\n#65B933\n#1A8C5F\n#4F8729\n#136246\n#2B6824\n#0F3E2B\n#004000";
Palettes[5] = "#DFF4FF\n#C1FFFF\n#80C6FF\n#6DEEFC\n#60A8FF\n#44D0EE\n#1D56DC\n#209CCC\n#273D8F\n#2C769A\n#1C2260\n#295270\n#000040\n#003146";
Palettes[6] = "#E9D2FF\n#E1E1FF\n#DAB5FF\n#C1C1FF\n#CE9DFF\n#8080FF\n#B366FF\n#6262FF\n#9428FF\n#3D44C9\n#6900D2\n#33309E\n#3F007D\n#252D6B";
Palettes[7] = "#ECD3BD\n#F7E2BD\n#E4C098\n#DBC7AC\n#C8A07D\n#D9B571\n#896952\n#C09450\n#825444\n#AE7B3E\n#5E4435\n#8E5C2F\n#493830\n#5F492C";
Palettes[8] = "#FFEADD\n#DED8F5\n#FFCAAB\n#9C89C4\n#F19D71\n#CF434A\n#52443C\n#F09450\n#5BADFF\n#FDF666\n#0077D9\n#4AA683\n#000000\n#FFFFFF";
Palettes[9] = "#F6CD8A\n#FFF99D\n#89CA9D\n#C7E19E\n#8DCFF4\n#8CCCCA\n#9595C6\n#94AAD6\n#AE88B8\n#9681B7\n#F49F9B\n#F4A0BD\n#8C6636\n#FFFFFF";
Palettes[10] = "#C7E19E\n#D1E1FF\n#A8D59D\n#8DCFE0\n#7DC622\n#00A49E\n#528413\n#CBB99C\n#00B03B\n#766455\n#007524\n#5B3714\n#0F0F0F\n#FFFFFF";
Palettes[11] = "#FFFF80\n#F4C1D4\n#EE9C00\n#F4BDB0\n#C45914\n#ED6B9E\n#FEE7DB\n#E76568\n#FFC89D\n#BD3131\n#ECA385\n#AE687E\n#0F0F0F\n#FFFFFF";
Palettes[12] = "#FFFFFF\n#7F7F7F\n#EFEFEF\n#5F5F5F\n#DFDFDF\n#4F4F4F\n#CFCFCF\n#3F3F3F\n#BFBFBF\n#2F2F2F\n#AFAFAF\n#1F1F1F\n#0F0F0F\n#000000";
function setPalette(){
	d = document
	d.paintbbs.setColors(Palettes[d.Palette.select.selectedIndex])
	//if (! d.grad.view.checked){return}
	GetPalette();
}
function PaletteSave(){
	Palettes[0] = String(document.paintbbs.getColors())
}
var cutomP = 0;
function PaletteNew(){
	d = document
	p = String(d.paintbbs.getColors())
	s = d.Palette.select
	Palettes[s.length] = p
	cutomP++
	str = prompt("为新增的色盘取名","新色盘" + cutomP)
	if(str == null || str == ""){cutomP--;return}
	s.options[s.length] = new Option(str)
	if(s.length < 30) s.size = s.length
}
function PaletteRenew(){
	d = document
	Palettes[d.Palette.select.selectedIndex] = String(d.paintbbs.getColors())
}
function PaletteDel(){
	p = Palettes.length
	s = document.Palette.select
	i = s.selectedIndex
	if(i == -1)return
	
	flag = confirm("确定删除色盘["+s.options[i].text + "]吗？")
	if (!flag) return
	s.options[i] = null
	while(i<p){
		Palettes[i] = Palettes[i+1]
		i++
	}
	if(s.length < 30) s.size = s.length
}
function P_Effect(v){
	v=parseInt(v)
	x = 1
	if(v==255)x=-1
	d = document.paintbbs
	p=String(d.getColors()).split("\n")
	l = p.length
	var s = ""
	for(n=0; n<l;n++){
		R = v+(parseInt("0x" + p[n].substr(1,2))*x)
		G = v+(parseInt("0x" + p[n].substr(3,2))*x)
		B = v+(parseInt("0x" + p[n].substr(5,2))*x)
		if(R > 255){ R = 255}
		else if(R < 0){ R = 0}
		if(G > 255){ G = 255}
		else if(G < 0){ G = 0}
		if(B > 255){ B = 255}
		else if(B < 0){ B = 0}
		s += "#"+Hex(R)+Hex(G)+Hex(B)+"\n"
	}
	d.setColors(s)
}
function PaletteMatrixGet(){
	d = document.Palette
	p = Palettes.length
	s = d.select
	m = d.m_m.selectedIndex
	t = d.setr
	t.value = "!Palette\n"+String(document.paintbbs.getColors())
	switch(m){
	case 0:case 2:default:
		n=0;c=0
		while(n<p){
			if(s.options[n] != null){ t.value = t.value + "\n!"+ s.options[n].text +"\n" + Palettes[n];c++}
			n++
		}
		alert ("已取得色盘颜色咨讯！");break
	case 1:
		alert("已取得色盘颜色咨讯！");break
	}
		t.value = t.value + "\n!Matrix"
}
function PalleteMatrixSet(){
	m = document.Palette.m_m.selectedIndex;
	str = ""
	switch(m){
	case 0:default:
		flag = confirm(str+"\n确定使用此区颜色？");break
	case 1:
		flag = confirm(str+"\n确定使用此区颜色？");break;
	case 2:
		flag = confirm(str+"\n确定使用此区颜色？");break
	}
		if (!flag) return
	
	PaletteSet()
	if(s.length < 30){ s.size = s.length}else{s.size=30};
	
}

function PaletteSet(){
	d = document.Palette
	se = d.setr.value;
	s = d.select;
	m = d.m_m.selectedIndex;
	l = se.length
	if(l<1){
		alert("现在没有任何色盘颜色咨讯！");return
	}
		n = 0;o = 0;e = 0
	switch(m){
	case 0:default:
		n = s.length
		while(n > 0){
			n--
			s.options[n] = null
		}
	case 2:
		i=s.options.length
		n = se.indexOf("!",0)+1
		if(n == 0)return
		while(n<l){
			e = se.indexOf("\n#",n)
			if(e == -1)return
			
			pn = se.substring(n,e-1)
			o = se.indexOf("!",e)
			if(o == -1)return
			pa = se.substring(e+1,o-2)
			if (pn != "Palette"){
			if(i >= 0)s.options[i] = new Option(pn)
			
			Palettes[i] = pa
			i++
			}else{document.paintbbs.setColors(pa)}
			
			n=o+1
		}
		break
	case 1:
		n = se.indexOf("!",0)+1
		if(n == 0)return
		e = se.indexOf("\n#",n)
		o = se.indexOf("!",e)
			if(e >= 0){
				pa = se.substring(e+1,o-2)
			}
		document.paintbbs.setColors(pa)
	}
}

function ChengeGrad(){
	d =document
	var st = d.grad.pst.value
	var ed = d.grad.ped.value
	//Chenge_()
	
	var degi_R = parseInt("0x" + st.substr(0,2))
	var degi_G = parseInt("0x" + st.substr(2,2))
	var degi_B = parseInt("0x" + st.substr(4,2))
	 var R = parseInt((degi_R - parseInt("0x" + ed.substr(0,2)))/15)
	 var G = parseInt((degi_G - parseInt("0x" + ed.substr(2,2)))/15)
	 var B = parseInt((degi_B - parseInt("0x" + ed.substr(4,2)))/15)
	 if(isNaN(R)) R = 1
	 if(isNaN(G)) G = 1
	 if(isNaN(B)) B = 1
		var p = new String()
		for(cnt=0,m1=degi_R,m2=degi_G,m3=degi_B; cnt<14; cnt++,m1-=R,m2-=G,m3-=B){
		if ((m1 > 255)||(m1 < 0)){ R *= -1;m1-=R}
		if ((m2 > 255)||(m2 < 0)){ G *= -1;m2-=G}
		if ((m3 > 255)||(m3 < 0)){ B *= -1;m2-=B}
		p += "#"+Hex(m1)+Hex(m2)+Hex(m3)+"\n"
		
		}
	document.paintbbs.setColors(p);
}
function Hex(n){
	n = parseInt(n);if (n < 0) n *=-1;
	var hex = new String()
	var m
	var k
	while(n > 16){
	m = n
	if (n >16){
		n = parseInt(n/16)
		m -= (n * 16)
	}
		k = Hex_(m)
		hex = k + hex
	}
		k = Hex_(n)
		hex = k + hex
	while(hex.length < 2){hex="0" + hex}
	return hex
}
function Hex_(n){
	if(! isNaN(n)){
		if(n == 10){n="A"}
		else if(n == 11){n="B"}
		else if(n == 12){n="C"}
		else if(n == 13){n="D"}
		else if(n == 14){n="E"}
		else if(n == 15){n="F"}
	}else{n=""}
	return n
}
function GetPalette(){
	d = document
	p = String(document.paintbbs.getColors());
	 if(p == "null" || p == ""){return};
	ps = p.split("\n");
	st = d.grad.p_st.selectedIndex
	ed = d.grad.p_ed.selectedIndex
	d.grad.pst.value = ps[st].substr(1.6)
	d.grad.ped.value = ps[ed].substr(1.6)
	GradSelC()
	//GradView(ps[st],ps[ed])
}
function GradSelC(){
	//if (! d.grad.view.checked)return
	d = document.grad
	l = ps.length
	pe=""
	for(n=0; n<l;n++){
		R = 255+(parseInt("0x" + ps[n].substr(1,2))*-1)
		G = 255+(parseInt("0x" + ps[n].substr(3,2))*-1)
		B = 255+(parseInt("0x" + ps[n].substr(5,2))*-1)
		if(R > 255){ R = 255}
		else if(R < 0){ R = 0}
		if(G > 255){ G = 255}
		else if(G < 0){ G = 0}
		if(B > 255){ B = 255}
		else if(B < 0){ B = 0}
		pe += "#"+Hex(R)+Hex(G)+Hex(B)+"\n"
	}
	pe = pe.split("\n");
	for(n=0;n < l;n++){
		d.p_st.options[n].style.background = ps[n];
		d.p_st.options[n].style.color = pe[n];
		d.p_ed.options[n].style.background = ps[n];
		d.p_ed.options[n].style.color = pe[n];
	}
}
//-->
</Script> <br> <table width="52%" border="0" cellspacing="1" cellpadding="1" bgcolor="#999999" align="center"> 
<tr> <td bgcolor="#999999" bordercolor="#333333"> <table width="92%" border="0" cellspacing="0" cellpadding="0"> 
<tr> <td> <div align="left"> <script language="JavaScript">
<!-- Hide
function killErrors() {
  return true;
}
   window.onerror = killErrors;
// -->
</script> <script language="JavaScript">
<!--
 
if (window.Event) 
  document.captureEvents(Event.MOUSEUP); 
 
function nocontextmenu() 
{
 event.cancelBubble = true
 event.returnValue = false;
 
 return false;
}
 
function norightclick(e) 
{
 if (window.Event) 
 {
  if (e.which == 2 || e.which == 3)
   return false;
 }
 else
  if (event.button == 2 || event.button == 3)
  {
   event.cancelBubble = true
   event.returnValue = false;
   return false;
  }
 
}
 
document.oncontextmenu = nocontextmenu;  // for IE5+
document.onmousedown = norightclick;  // for all others
//-->
</script> </div></td></tr> <tr> <td> <table width="598" border="0" bgcolor="#999999" align="center"> 
<tr> <td width="400" bgcolor="#999999"> <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr> <td colspan="2"> <%pic= "paintbbs_"&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&".png"
		pch= "paintbbs_"&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&".pch"%><applet code="pbbs.PaintBBS.class" archive="PaintBBS.jar" name="paintbbs" 
		width="<%=w1%>"
		height="<%=h1%>" CODEBASE="../"> 
		<param name="color_bk" value="#999999"> 
<param name="color_bk2" value="#999999"> 
<param name="color_icon" value="#E6E6E6"> 
<param name="color_iconselect" value="#0099CC"> 
<param name="image_width" value="<%=w%>"> 
<param name="image_height" value="<%=h%>"> 
<param name="color_bar" value="#555555"> 
<param name="color_bar_hl" value="#ffffff"> 
<param name="image_bkcolor" value="#ffffff"> 
<param name="image_interlace" value="true"> 
<param name="thumbnail_type" value="animation"> 
<param name="thumbnail_width" value="100%"> 
<param name="thumbnail_height" value="100%"> 
<param name="undo" value="60"> 
<param name="undo_in_mg" value="60"> 
<param name="image_size" value="60"> 
<param name="compress_level" value="15"> 
<param name="color_text" value="#1D4961"> 
<param name="image_bk" value=""> 
<param name="send_header" value="10"> 
<param name="send_advance" value="true"> 
<param name="bar_size" value="15">
 <param name="url_save" value="<%=user_name%>/savepb.asp?action=save&pic=<%=pic%>&pch=<%=pch%>"> 
<param name="url_exit" value="<%=user_name%>/getoekaki.asp?tool=paintbbs&W=<%=w%>&H=<%=h%>&pic=<%=pic%>&pch=<%=pch%>&pname=<%=pname%>&timeStart=<%=timer()%>"> 
<param name="send_header_image_type" value="true">
 <param name="poo" value="true"> 
<param name="image_interlace" value="true"> 
<param name="tool_alpha" value="true"> 
<param name="pch_file" value=""> 
<param name="image_canvas" value=""> </applet></td></tr> 
<tr> <td> &nbsp; <div align="right"> </div></td><td>&nbsp;</td></tr> </table></td><td width="188"> 
<table border="0" cellpadding="0" cellspacing="0" width="182"> <td align="CENTER" valign="top" height="40" width="184"> <form name="Palette"> 
<table cellpadding="0" cellspacing="0" width=163 height="422"> <tr> <td height="428"> 
<table cellpadding="2" cellspacing="0" width=91% style="border-collapse: collapse" bgcolor="#E6E6E6" border="1"> 
<tr> <td> <font size=2> <input type="button" value="暂存色盘" onClick="PaletteSave()" name="button"> 
<br> <select name="select" size="13" style="width:100" onChange="setPalette()"> 
<option>暂存色盘区</option> <option>皮肤系</option> <option>红系</option> <option>黄、橙系</option> 
<option>绿系</option> <option>青系</option> <option>紫系</option> <option>黄、褐系</option> 
<option>人物系</option> <option>淡色系</option> <option>自然系</option> <option>出生萌芽系</option> 
<option>黑白系</option> </select> <br> &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; </font> <table border="0"> 
<tr> <td><font size=2> <input type="button" value="新增" onClick="PaletteNew()" name="button23"> 
</font></td><td><font size=2> <input type="button" value="更改" onClick="PaletteRenew()" name="button25"> 
</font></td><td><font size=2> <input type="button" value="删除" onClick="PaletteDel()" name="button24"> 
</font></td></tr> <tr> <td><font size=2> <input type="button" value="加亮" onClick="P_Effect(10)" name="button26"> 
</font></td><td><font size=2> <input type="button" value="减暗" onClick="P_Effect(-10)" name="button27"> 
</font></td><td><font size=2> <input type="button" value="反转" onClick="P_Effect(255)" name="button2"> 
</font></td></tr> </table><font size=2> <font color="#0055BB" size="2">MATRIX</font> 
<select name="m_m"> 
<option value=0>全部</option> <option value=1>现在</option> <option value=2>追加</option> 
</select> <br> <input name="m_g" type="button" value="取得" onClick="PaletteMatrixGet()"> 
<input name="m_s" type="button" value="使用" onClick="PalleteMatrixSet()"> <br> 
<textarea rows="1" name="setr" cols="13" onMouseOver="this.select()"></textarea> 
</font> </td></FORM> <table cellpadding="3" cellspacing="1" width=155 style="border-collapse: collapse" align="center"> 
<tr> <form name="grad"> <td> <input type="button" value=" OK " onClick="ChengeGrad()" name="button22"> 
<select name="p_st" onChange="GetPalette()"> 
<option>1</option> <option>2</option> <option>3</option> <option>4</option> <option>5</option> 
<option>6</option> <option>7</option> <option>8</option> <option>9</option> <option>10</option> 
<option>11</option> <option>12</option> <option>13</option> <option>14</option> 
</select> <select name="p_ed" onChange="GetPalette()"> 
<option>1</option> <option>2</option> <option>3</option> <option>4</option> <option>5</option> 
<option>6</option> <option>7</option> <option>8</option> <option>9</option> <option>10</option> 
<option>11</option> <option selected>12</option> <option>13</option> <option>14</option> 
</select> <br> <input type="text" name="ped" size="8" value="" onChange="Chenge_()"> 
<input type="text" name="pst" size="8" value="" onChange="Chenge_()"> </td></form></tr> 
</table></table></tr> </table></td><td width="54">&nbsp; <td height="18" width="178">&nbsp; 
</table></td></tr> <tr> <td width="100%"></td></tr> </table></td></tr> </table></td></tr> 
</table><P>&nbsp;</P><%end if%><%If paint= "painterpro" then %>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td bgcolor="#CCCCCC"> 
      <div align="center"> 
        <%pic= "Shi_pro"&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&".jpg"
		pch= "Shi_pro"&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&".spch"%>
        
        <script language="javascript" src="palette.js">
<!--
var digit=new Array("0","1","2","3","4","5","6","7","8","9","a","b","c","d","e","f");

function getByte(value){
 
 return digit[(value>>>4)&0xf]+digit[value&0xf];
}
function getShort(value){
 return getByte(value>>>8)+getByte(value&0xff);
}
function getInt(value){
 return getShort(value>>>16)+getShort(value&0xffff);
}
function addLayer(){
 var len=eval(PaintBBS.getLSize());
 PaintBBS.send("iHint=14@"+getInt(1)+getInt(len+1),false);// 
}

function scale(){
 PaintBBS.getMi().scaleChange(1,true);
}

function line(){
 var header="iHint=0;iColor="+0x0000ff+";iSize=10;iLayer="+PaintBBS.getInfo().m.iLayer+"@";
 //TRUE 128 2Byte 
 PaintBBS.send(header+getShort(100)+getShort(100)+getByte(0)+getByte(50)+getByte(60)+getByte(-70),true);
 PaintBBS.send(header+getShort(200)+getShort(0)+getByte(0)+getByte(128)+getShort(400),true);
}

// 
function dot(x,y,color){
 PaintBBS.send("iColor="+color+"@"+ getShort(x)+getShort(y)+"0100",true);
}

// 
function drawFrame(size,color){
 var info=PaintBBS.getInfo();
 var m=info.m;
 
 var width=info.imW-1,height=info.imH-1;
  
 PaintBBS.send("iHint="+m.H_FRECT+";iColor="+color+";iSize="+size+";iLayer="+(PaintBBS.getLSize()-1)+"@"+getShort(0)+getShort(0)+getShort(width)+getShort(height),true);
}
//-->
</script>
        <applet code="c.ShiPainter.class" codebase="../" name="paintbbs" width="720" height="550" archive="spainter.jar,res/pro.zip" MAYSCRIPT align=top>
          <!-- <param name="popup" value="0"> -->
          <param name="undo" value="50">
          <param name="undo_in_mg" value="12">
          <param name="image_width" value="<%=w%>">
          <param name="image_height" value="<%=h%>">
          <param name="image_size" value="1">
          <param name="image_jpeg" value="true">
          <param name="image_bk" value="">
          <param name="image_bkcolor" value="#FFFFFF">
          <param name="color_text" value="#000000">
          <param name="color_bk" value="#cccccc">
          <param name="color_bk2" value="#cccccc">
          <param name="color_icon" value="#dddddd">
          <param name="color_iconselect" value="#cccccc">
          <param name="url_save" value="<%=user_name%>/saveSP.asp?pic=<%=pic%>&pch=<%=pch%>&PType=jpg">
          <param name="url_exit" value="<%=user_name%>/getoekaki.asp?tool=spainter&W=<%=w%>&H=<%=h%>&pic=<%=pic%>&pch=<%=pch%>&pname=<%=pname%>&timeStart=<%=timer()%>">
          <param name="jp" value="true">
          <param name="poo" value="false">
          <param name="send_advance" value="true">
          <param name="dir_resource" value="./res/">
          <param name="tt.zip" value="./res/tt.zip">
          <param name="res.zip" value="./res/res_pro.zip">
          <param name="tools" value="pro">
          <param name="layer_count" value="3">
          <param name="send_language" value="utf-8">
          <param name="thumbnail_width" value="120">
          <param name="thumbnail_height" value="120">
          <param name="thumbnail_type" value="animation">
          <param name="thumbnail_type2" value="jpg">
          <param name="compress_level" value="8">
          <!-- <param name="pch_file" value="./picdata/"> -->
        </applet></div>
    </td>
    <td bgcolor="#CCCCCC">&nbsp; 
      <SCRIPT language=JavaScript>
<!--
PaletteInit();
//-->
</SCRIPT> </td>
  </tr>
</table>
<%end if%><%end if%>
</BODY>
</HTML>
