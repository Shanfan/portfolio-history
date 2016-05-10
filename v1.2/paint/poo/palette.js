//	BBS Note 摦揑僷儗僢僩仌儅僩儕僋僗 2001/09/01
//	(C) 偺傜僱僐 WonderCatStudio http://www.botan.sakura.ne.jp/~wcs/
//	
//	仏Macintosh偺IE巊梡晄壜 

var TableLineColor,TableBGColor,FontColor

TableLineColor	= "#ffcc77"	// 榞慄
TableBGColor	= "#fff8ff"	// 攚宨怓
FontColor	= "#aa88ff"	// 僼僅儞僩怓

// OS&僽儔僂僓敾掕
var uAgent,aName,version,BROWSER,OS;
uAgent = navigator.userAgent.toUpperCase();
aName   = navigator.appName.toUpperCase();
if (uAgent.indexOf("MAC") >= 0)			{ OS="MAC" }
else if (uAgent.indexOf("WIN") >= 0)		{ OS="WIN" }

if (aName.indexOf("NETSCAPE") >= 0)		{ BROWSER="NN" }
else if (aName.indexOf("MICROSOFT") >= 0)	{ BROWSER="IE" }

if (aName.indexOf("NETSCAPE") >= 0){
	appVer  = navigator.appVersion;
	s = appVer.indexOf(" ",0);
	version = eval(parseInt(appVer.substring(0,s)));
	if (version >= 5) version++;
}else if (aName.indexOf("MICROSOFT") >= 0){
	appVer  = navigator.userAgent;
	s = appVer.indexOf("MSIE ",0) + 5;
	e = appVer.indexOf(";",s);
	version = eval(parseInt(appVer.substring(s,e)));
}

// 弶婜僷儗僢僩儅僩儕僋僗愝掕
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


function PaletteInit(){
html = "<TABLE><TR><TD><TABLE BGCOLOR="+TableLineColor+" CELLPADDING=1 CELLSPACING=0><TR><TD><TABLE BGCOLOR="+TableBGColor+" CELLPADDING=3 CELLSPACING=0><TR><FORM name=Palette><TD><FONT SIZE=2><font face=\"Impact, Arial Black\" color="+FontColor+" size=2>PALETTE</font> <INPUT CLASS=button TYPE=button VALUE=\"临时保存\" OnClick=\"PaletteSave()\"><BR><select name=select size=13 CLASS=button onChange=\"setPalette()\"><option>默认色板</option><option>肌肤色</option><option>红色系</option><option>橘黄系</option><option>绿色草原</option><option>兰色海洋</option><option>篮紫色</option><option>棕黄系</option><option>彩虹色</option><option>粉色板</option><option>自然系</option><option>萌芽系</option><option>黑白灰心情</option></select><BR><INPUT CLASS=button TYPE=button VALUE=\"新建\" OnClick=\"PaletteNew()\"><INPUT CLASS=button TYPE=button VALUE=\"命名\" OnClick=\"PaletteRenew()\"><INPUT CLASS=button TYPE=button VALUE=\"删除\" OnClick=\"PaletteDel()\"><BR><INPUT CLASS=button TYPE=button VALUE=\"加亮\" OnClick=\"P_Effect(10)\"><INPUT CLASS=button TYPE=button VALUE=\"加暗\" OnClick=\"P_Effect(-10)\"><INPUT CLASS=button TYPE=button VALUE=\"反色\" OnClick=\"P_Effect(255)\"><BR><font face=\"Impact, Arial Black\" color="+FontColor+" size=2>MATRIX </font>\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;\&nbsp\;<SELECT name=m_m CLASS=button><option value=0>全部</option><option value=1>现在</option><option value=2>追加</option></SELECT><BR><INPUT CLASS=button name=m_g TYPE=button VALUE=\"取得\" OnClick=\"PaletteMatrixGet()\"><INPUT CLASS=button name=m_s TYPE=button VALUE=\"使用\" OnClick=\"PalleteMatrixSet()\"><INPUT CLASS=button name=m_h TYPE=button VALUE=\" ? \" OnClick=\"PalleteMatrixHelp()\"><BR><TEXTAREA CLASS=button rows=1 name=setr cols=13 onmouseover=\"this.select()\"></TEXTAREA><BR></TD></TR></FORM></TABLE></TD></TR></TABLE><BR><TABLE BGCOLOR="+TableLineColor+" CELLPADDING=1 CELLSPACING=0><TR><TD><TABLE BGCOLOR="+TableBGColor+" CELLPADDING=3 CELLSPACING=0 width=100%><TR><FORM name=grad><TD><FONT SIZE=2><font face=\"Impact, Arial Black\" color="+FontColor+" size=2>GRADATION</font>\&nbsp\;<INPUT TYPE=checkbox name=view OnClick=\"showHideLayer()\"><INPUT CLASS=button TYPE=button VALUE=\" OK \" OnClick=\"ChengeGrad()\"><BR><SELECT name=p_st CLASS=button onChange=\"GetPalette()\"><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option><option>10</option><option>11</option><option>12</option><option>13</option><option>14</option></SELECT><input type=text name=pst size=8 CLASS=button onKeyPress=\"Chenge_()\" onChange=\"Chenge_()\"><BR><SELECT name=p_ed CLASS=button onChange=\"GetPalette()\"><option>1</option><option>2</option><option>3</option><option>4</option><option>5</option><option>6</option><option>7</option><option>8</option><option>9</option><option>10</option><option>11</option><option selected>12</option><option>13</option><option>14</option></SELECT><input type=text name=ped size=8 CLASS=button onKeyPress=\"Chenge_()\" onChange=\"Chenge_()\"><div id=psft style=\"position\:absolute\;width\:100px\;height\:30px\;z-index\:1\;left\:5px\;top\:10px\;\"></div></TD></TR></TABLE></TD></FORM></TR></TABLE></TD></TR></TABLE>";
	if(OS == "MAC" & BROWSER == "IE") return;
	document.write(html)
}
function setPalette(){
	d = document
	d.paintbbs.setColors(Palettes[d.Palette.select.selectedIndex])
	if (! d.grad.view.checked){return}
	GetPalette()
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
	str = prompt("新建立色板","未命名1 " + cutomP)
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
	
	flag = confirm("！"+s.options[i].text + "poobbs.com!")
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
	l = 14||p.length
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
		
		alert ("提示"+c+"\n已经取得色板信息");break
	case 1:
		alert("已经获取现在色板信息");break
	}
	t.value = t.value + "\n!Matrix"
}
function PalleteMatrixSet(){
	m = document.Palette.m_m.selectedIndex
	str = "提示"
	switch(m){
	case 0:default:
		flag = confirm(str+"\n要使用取得的色板信息吗？");break
	case 1:
		flag = confirm(str+"\n追加现在的色板信息？");break;
	case 2:
		flag = confirm(str+"\n追加成功！");break
	}
		if (!flag) return
	
	PaletteSet()
	if(s.length < 30){ s.size = s.length}else{s.size=30}
}
function PalleteMatrixHelp(){
	alert("poobbs.com\n找不到帮助文件！");
}

function PaletteSet(){
	d = document.Palette
	se = d.setr.value;
	s = d.select;
	m = d.m_m.selectedIndex;
	l = se.length
	if(l<1){
		alert("该色板信息已经被使用");return
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
		if(BROWSER=="NN" & version=="6"){
			Matrix1 = 0
			Matrix2 = -1
		}else{
			Matrix1 = -1
			Matrix2 = -2
		}
		while(n<l){
			e = se.indexOf("\n#",n)
			if(e == -1)return
			
			pn = se.substring(n,e+Matrix1)
			o = se.indexOf("!",e)
			if(o == -1)return
			pa = se.substring(e+1,o+Matrix2)
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
				pa = se.substring(e+1,o+Matrix2)
			}
		document.paintbbs.setColors(pa)
	}

}
function Chenge_(){
	var st = document.grad.pst.value
	var ed = document.grad.ped.value
	
	if(isNaN(parseInt("0x" + st)))return
	if(isNaN(parseInt("0x" + ed)))return
	GradView("#"+st,"#"+ed);
}
function ChengeGrad(){
	d =document
	st = d.grad.pst.value
	ed = d.grad.ped.value
	Chenge_()
	
	degi_R = parseInt("0x" + st.substr(0,2))
	degi_G = parseInt("0x" + st.substr(2,2))
	degi_B = parseInt("0x" + st.substr(4,2))
	 R = parseInt((degi_R - parseInt("0x" + ed.substr(0,2)))/15)
	 G = parseInt((degi_G - parseInt("0x" + ed.substr(2,2)))/15)
	 B = parseInt((degi_B - parseInt("0x" + ed.substr(4,2)))/15)
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
	d.paintbbs.setColors(p)
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
	if(OS == "WIN" & (BROWSER == "IE" | (BROWSER == "NN" & version == "6"))) GradSelC()
	GradView(ps[st],ps[ed])
}
function GradSelC(){
	if (! d.grad.view.checked)return
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
function GradView(st,ed){
	d = document
	if (! d.grad.view.checked)return
	 html = "<TABLE BGCOLOR=white cellspacing=0 cellpadding=0><TR><TD colspan=2><TT><font >缓和</TT></TD></TR><TR><TD><TT><font color=#FF6699>START </TT></TD><TD><FONT COLOR="+st+" SIZE=4>色</FONT></TD></TR><TR><TD><font color=#FF6699><TT>END </TT></TD><TD><FONT COLOR="+ed+" SIZE=4>色</FONT></TD></TR></TABLE>";
	  if(d.layers) {
	     with(d.layers["psft"]){
	     	left = window.innerWidth - 120
	     	top = window.pageYOffset+5
		   d = document
		   d.open()
   		   d.write(html)
    		   d.close();
	       }
	  }
	else if(d.all){
		with(d.all("psft")){
		style.left = d.body.offsetWidth - 120
		style.top = d.body.scrollTop+5
		innerHTML = html
		}
	}
}

function showHideLayer() { //v3.0
	d = document
	var l
  if(d.layers) {
  	l = d.layers["psft"]
  }else{
  	l = d.all("psft").style
  	
  }
 if (! d.grad.view.checked){
  	l.visibility = "hidden"
 }
 if (d.grad.view.checked){
  	l.visibility = "visible";GetPalette();
 }
}