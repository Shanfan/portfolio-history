<%
function ChkBadWords(fString)
    if not(isnull(BadWords) or isnull(fString)) then
    bwords = split(BadWords, "|")
    for i = 0 to ubound(bwords)
        fString = Replace(fString, bwords(i), string(len(bwords(i)),"*")) 
    next
    ChkBadWords = fString
    end if
end function

function HTMLEncode(fString)
if not isnull(fString) then
    'fString = Replace(fString, CHR(38), "&#38;")
    'fString = replace(fString, ">", "&gt;")
    'fString = replace(fString, "<", "&lt;")
    'fString = Replace(fString, CHR(39), "&#39;")
    'fString = Replace(fString, CHR(32), "&nbsp;")
    'fString = Replace(fString, CHR(34), "&quot;")
    'fString = Replace(fString, CHR(13), "")
    fString = Replace(fString, CHR(10), "<br/>")
    HTMLEncode = fString
end if
end function

function HTMLcode(fString)
if not isnull(fString) then
    fString = Replace(fString, CHR(13), "")
    fString = Replace(fString, CHR(10), "<br/>")
    HTMLcode = fString
end if
end function
function HTMLDecode(fString)
if not isnull(fString) then
    'fString = Replace(fString, CHR(38), "&#38;")
    'fString = replace(fString, "&gt;", ">")
    'fString = replace(fString, "&lt;", "<")
    'fString = Replace(fString, CHR(32), "&nbsp;")
    'fString = Replace(fString,"",CHR(13))
    fString = Replace(fString,"<br/>",CHR(10))
    HTMLDecode = fString
end if
end function

function UBBCode(strContent)
    if strAllowHTML <> 1 then
        strContent = HTMLEncode(strContent)
    else
	strContent = HTMLcode(strContent)
    end if
    dim re
    Set re=new RegExp
    re.IgnoreCase =true
    re.Global=True

    re.Pattern="\[IMG\](.[^\[]*)\[\/IMG\]"
    strContent=re.Replace(strContent,"<img src=""$1"" border=""0""></img>")
    re.Pattern="\[IMG=*([0-9]*),*([0-9]*)\](.[^\[]*)\[\/IMG\]"
    strContent=re.Replace(strContent,"<a href=""$3"" title=点击看全图 target=_blank><img src=""$3"" width=""$1"" height=""$2"" border=""0""></img></a>")
    
        '图文混排
    re.Pattern="\[PIC\](.[^\[]*)\[\/PIC\]"
    strContent=re.Replace(strContent,"<img src=""$1"" border=""0"" align=""left""></img>")
    re.Pattern="\[PIC=*([0-9]*),*([0-9]*)\](.[^\[]*)\[\/PIC\]"
    strContent=re.Replace(strContent,"<a href=""$3"" title=点击看全图 target=_blank><img src=""$3"" width=""$1"" height=""$2"" border=""0"" align=""left""></img></a>")

    
    
    re.Pattern="\[FLASH=*([0-9]*),*([0-9]*)\](.[^\[]*)\[\/FLASH\]"
    strContent= re.Replace(strContent,"<EMBED SRC=""$3"" width=""$1"" height=""$2""></EMBED>")
    re.Pattern="\[FLASH\](.[^\[]*)\[\/FLASH\]"
    strContent= re.Replace(strContent,"<EMBED SRC=""$1""></EMBED>")

    re.Pattern="(\[URL\])(http:\/\/.[^\[]*)(\[\/URL\])"
    strContent= re.Replace(strContent,"<A HREF=""$2"" TARGET=""_blank"">$2</A>")
    re.Pattern="(\[URL\])(.[^\[]*)(\[\/URL\])"
    strContent= re.Replace(strContent,"<A HREF=""http://$2"" TARGET=""_blank"">$2</A>")

    re.Pattern="(\[EMAIL\])(mailto:\/\/.[^\[]*)(\[\/EMAIL\])"
    strContent= re.Replace(strContent,"<A HREF=""$2"" TARGET=""_blank"">$2</A>")
    re.Pattern="(\[EMAIL\])(.[^\[]*)(\[\/EMAIL\])"
    strContent= re.Replace(strContent,"<A HREF=""MAILTO:$2"" TARGET=""_blank"">$2</A>")

    re.Pattern="(\[URL=(http:\/\/.[^\[]*)\])(.[^\[]*)(\[\/URL\])"
    strContent= re.Replace(strContent,"<A HREF=""$2"" TARGET=""_blank"">$3</A>")
    re.Pattern="(\[URL=(.[^\[]*)\])(.[^\[]*)(\[\/URL\])"
    strContent= re.Replace(strContent,"<A HREF=""http://$2"" TARGET=""_blank"">$3</A>")

	re.Pattern = "^(http://[A-Za-z0-9\./=\?%\-&_~`@':+!]+)"
	strContent = re.Replace(strContent,"<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "(http://[A-Za-z0-9\./=\?%\-&_~`@':+!]+)$"
	strContent = re.Replace(strContent,"<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "[^>=""](http://[A-Za-z0-9\./=\?%\-&_~`@':+!]+)"
	strContent = re.Replace(strContent,"<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "^(ftp://[A-Za-z0-9\./=\?%\-&_~`@':+!]+)"
	strContent = re.Replace(strContent,"<img align=absmiddle src=http://www.ceocio.net/images/url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "(ftp://[A-Za-z0-9\./=\?%\-&_~`@':+!]+)$"
	strContent = re.Replace(strContent,"<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "[^>=""](ftp://[A-Za-z0-9\.\/=\?%\-&_~`@':+!]+)"
	strContent = re.Replace(strContent,"<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "^(rtsp://[A-Za-z0-9\./=\?%\-&_~`@':+!]+)"
	strContent = re.Replace(strContent,"<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "(rtsp://[A-Za-z0-9\./=\?%\-&_~`@':+!]+)$"
	strContent = re.Replace(strContent,"<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "[^>=""](rtsp://[A-Za-z0-9\.\/=\?%\-&_~`@':+!]+)"
	strContent = re.Replace(strContent,"<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "^(mms://[A-Za-z0-9\./=\?%\-&_~`@':+!]+)"
	strContent = re.Replace(strContent,"<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "(mms://[A-Za-z0-9\./=\?%\-&_~`@':+!]+)$"
	strContent = re.Replace(strContent,"<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "[^>=""](mms://[A-Za-z0-9\.\/=\?%\-&_~`@':+!]+)"
	strContent = re.Replace(strContent,"<img align=absmiddle src=images/url.gif><a target=_blank href=$1>$1</a>")



    re.Pattern="\[DIR=*([0-9]*),*([0-9]*)\](.[^\[]*)\[\/DIR]"
	strContent=re.Replace(strContent,"<object classid=clsid:166B1BCA-3F9C-11CF-8075-444553540000 codebase=http://download.macromedia.com/pub/shockwave/cabs/director/sw.cab#version=7,0,2,0 width=$1 height=$2><param name=src value=$3><embed src=$3 pluginspage=http://www.macromedia.com/shockwave/download/ width=$1 height=$2></embed></object>")
	re.Pattern="\[QT=*([0-9]*),*([0-9]*)\](.[^\[]*)\[\/QT]"
	strContent=re.Replace(strContent,"<embed src=$3 width=$1 height=$2 autoplay=true loop=false controller=true playeveryframe=false cache=false scale=TOFIT bgcolor=#000000 kioskmode=false targetcache=false pluginspage=http://www.apple.com/quicktime/>")
	re.Pattern="\[MP=*([0-9]*),*([0-9]*)\](.[^\[]*)\[\/MP]"
	strContent=re.Replace(strContent,"<object align=middle classid=CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95 class=OBJECT id=MediaPlayer width=$1 height=$2 ><param name=ShowStatusBar value=-1><param name=Filename value=$3><embed type=application/x-oleobject codebase=http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701 flename=mp src=$3  width=$1 height=$2></embed></object>")
	re.Pattern="\[RM=*([0-9]*),*([0-9]*)\](.[^\[]*)\[\/RM]"
	strContent=re.Replace(strContent,"<OBJECT classid=clsid:CFCDAA03-8BE4-11cf-B84B-0020AFBBCCFA class=OBJECT id=RAOCX width=$1 height=$2><PARAM NAME=SRC VALUE=$3><PARAM NAME=CONSOLE VALUE=Clip1><PARAM NAME=CONTROLS VALUE=imagewindow><PARAM NAME=AUTOSTART VALUE=true></OBJECT><br><OBJECT classid=CLSID:CFCDAA03-8BE4-11CF-B84B-0020AFBBCCFA height=32 id=video2 width=$1><PARAM NAME=SRC VALUE=$3><PARAM NAME=AUTOSTART VALUE=-1><PARAM NAME=CONTROLS VALUE=controlpanel><PARAM NAME=CONSOLE VALUE=Clip1></OBJECT>")




    re.Pattern="(\[color=(.[^\[]*)\])(.[^\[]*)(\[\/color\])"
    strContent=re.Replace(strContent,"<font color=""$2"">$3</font>")
    re.Pattern="(\[face=(.[^\[]*)\])(.[^\[]*)(\[\/face\])"
    strContent=re.Replace(strContent,"<font face=""$2"">$3</font>")
    re.Pattern="(\[align=(.[^\[]*)\])(.*)(\[\/align\])"
    strContent=re.Replace(strContent,"<div align=""$2"">$3</div>")

    re.Pattern="(\[QUOTE\])(.*)(\[\/QUOTE\])"
    strContent=re.Replace(strContent,"<table cellpadding=""0"" cellspacing=""0"" border=""0"" WIDTH=""94%"" bgcolor=""#D7F0FF"" align=""center""><tr><td><table width=""100%"" cellpadding=""5"" cellspacing=""1"" border=""0""><TR><TD BGCOLOR='"&abgcolor&"'>$2</table></table><br>")
    re.Pattern="(\[fly\])(.*)(\[\/fly\])"
    strContent=re.Replace(strContent,"<marquee width=""90%"" behavior=""alternate"" scrollamount=""3"">$2</marquee>")
    re.Pattern="(\[move\])(.*)(\[\/move\])"
    strContent=re.Replace(strContent,"<MARQUEE scrollamount=""3"">$2</marquee>")	
    re.Pattern="\[GLOW=*([0-9]*),*(#*[a-z0-9]*),*([0-9]*)\](.[^\[]*)\[\/GLOW]"
    strContent=re.Replace(strContent,"<table width=""$1"" style=""filter:glow(color=$2, strength=$3)"">$4</table>")
    re.Pattern="\[SHADOW=*([0-9]*),*(#*[a-z0-9]*),*([0-9]*)\](.[^\[]*)\[\/SHADOW]"
	strContent=re.Replace(strContent,"<table width=$1 style=""filter:shadow(color=$2, strength=$3)"">$4</table>")

    re.Pattern="(\[i\])(.[^\[]*)(\[\/i\])"
    strContent=re.Replace(strContent,"<i>$2</i>")
    re.Pattern="(\[u\])(.[^\[]*)(\[\/u\])"
    strContent=re.Replace(strContent,"<u>$2</u>")
    re.Pattern="(\[b\])(.[^\[]*)(\[\/b\])"
    strContent=re.Replace(strContent,"<b>$2</b>")
    re.Pattern="(\[fly\])(.[^\[]*)(\[\/fly\])"
    strContent=re.Replace(strContent,"<marquee>$2</marquee>")

    re.Pattern="(\[size=1\])(.[^\[]*)(\[\/size\])"
    strContent=re.Replace(strContent,"<font size=""1"">$2</font>")
    re.Pattern="(\[size=2\])(.[^\[]*)(\[\/size\])"
    strContent=re.Replace(strContent,"<font size=""2"">$2</font>")
    re.Pattern="(\[size=3\])(.[^\[]*)(\[\/size\])"
    strContent=re.Replace(strContent,"<font size=""3"">$2</font>")
    re.Pattern="(\[size=4\])(.[^\[]*)(\[\/size\])"
    strContent=re.Replace(strContent,"<font size=""4"">$2</font>")
    re.Pattern="(\[center\])(.[^\[]*)(\[\/center\])"
    strContent=re.Replace(strContent,"<center>$2</center>")
    '以下扩展
    re.Pattern="(\[li\])(.[^\[]*)(\[\/li\])"
    strContent=re.Replace(strContent,"<li>$2</li>")
    '字体背景
    re.Pattern="(\[fontbg=(.[^\[]*)\])(.[^\[]*)(\[\/fontbg\])"
    strContent=re.Replace(strContent,"<span style=background-color:""$2"">$3</span>")
    '删除线
    re.Pattern="(\[strike\])(.[^\[]*)(\[\/strike\])"
    strContent=re.Replace(strContent,"<strike>$2</strike>")

    re.Pattern="(\[HTML\])(.[^\[]*)(\[\/HTML\])"
	strContent=re.Replace(strContent,"<table width='100%' border='0' cellspacing='0' cellpadding='6' bgcolor='"&abgcolor&"'><td><b>以下内容为程序代码:</b><br>$2</td></table>")
	re.Pattern="(\[code\])(.[^\[]*)(\[\/code\])"
	strContent=re.Replace(strContent,"<table width='100%' border='0' cellspacing='0' cellpadding='6' bgcolor='"&abgcolor&"'><td><b>以下内容为程序代码:</b><br>$2</td></table>")




    strContent=ChkBadWords(strContent)

    set re=Nothing
    UBBCode=strContent
end function
%>