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

    fString = Replace(fString, CHR(10), "<br/>")
    HTMLEncode = fString
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
	strContent = re.Replace(strContent,"<img align=absmiddle src=url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "(http://[A-Za-z0-9\./=\?%\-&_~`@':+!]+)$"
	strContent = re.Replace(strContent,"<img align=absmiddle src=url.gif><a target=_blank href=$1>$1</a>")
	re.Pattern = "[^>=""](http://[A-Za-z0-9\./=\?%\-&_~`@':+!]+)"
	strContent = re.Replace(strContent,"<img align=absmiddle src=url.gif><a target=_blank href=$1>$1</a>")
	
re.Pattern="\[b\](.[^\[]*)(\[\/b\])"
strContent=re.Replace(strContent,"<b>$1</b>")


re.Pattern="\[em([a-z])\]"
strContent=re.Replace(strContent,"&nbsp;<IMG src=../smface/em$1.gif border=0>&nbsp;")

    



    strContent=ChkBadWords(strContent)

    set re=Nothing
    UBBCode=strContent
end function
%>