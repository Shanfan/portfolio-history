<%@LANGUAGE="VBSCRIPT"%>
<%
	response.expires = 0
	response.expiresabsolute = Now() - 1
	response.addHeader "pragma","no-cache"
	response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
%>
<% 
Dim validateThis
Function TFM_validate(formelement, theType, errormsg, req)'version 1.0.0
    if errormsg = "" Then errormsg = "nodata"
if len(formelement) = 0 AND Not req then 
    errormsg = ""
else	
Select Case theType
    case 1  'empty value
	    If len(formelement) <> 0 then errormsg = ""
	case 2  'email
	    if RegExpCheck("^[\w\.=-]+@[\w\.-]+\.[a-z]{2,3}$",formelement) then errormsg = ""
	case 3  'number
	    if IsNumeric(formelement) Then errormsg = ""
	case 4  'alpha-numeric
		if RegExpCheck("^[a-zA-Z0-9]+$",formelement) then errormsg = ""
	case 5  'valid URL
	    if RegExpCheck("^([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])\.([01]?\d\d?|2[0-4]\d|25[0-5])$",formelement) then errormsg = ""
	case 6  'alpha
	    if RegExpCheck("^[a-zA-Z]+$",formelement) then errormsg = ""
	case 7  'zip code
	    if RegExpCheck("(^\d{5}$)|(^\d{5}-\d{4}$)",formelement) then errormsg = ""
	case 8  '9 digit zip
	    if RegExpCheck("^\d{5}-\d{4}$",formelement) then errormsg = ""
	case 9  'filename
	    if RegExpCheck("^\w+\.\w{3}$",formelement) then errormsg = ""
	case 10  'date
	    if IsDate(formelement) Then errormsg = ""
    case 11  'money
	    if RegExpCheck("^\d*$|^\d*\.\d{2}$",formelement) Then errormsg = ""
	case 12  'us money
	    if RegExpCheck("^(\$\d{1,3}(,\d{3})*\.\d{2}$)|(^\(\$\d{1,3}(,\d{3})*\.\d{2}\)$)",formelement) Then errormsg = ""
    case 13  'time
	    if RegExpCheck("^([1-9]|1[0-2]):[0-5]\d(:[0-5]\d(\.\d{1,3})?)?$",formelement) then errormsg=""
    case 14  'SS number
	    if RegExpCheck("^\d{3}\-\d{2}\-\d{4}$",formelement) Then errormsg = ""
    case 15  '
	    if RegExpCheck("","") Then errormsg = ""
	case 16
	    if RegExpCheck("","") Then errormsg = ""
	case 17
	    if RegExpCheck("","") Then errormsg = ""
end Select
End if

TFM_validate = errormsg
End Function
Function RegExpCheck(theExpression,theString)
    dim theMatch
    Set loRegExp = New RegExp
	loRegExp.Global = True    	
	loRegExp.IgnoreCase = True
	loRegExp.Pattern = theExpression
	set theMatch = loRegExp.Execute(theString)
	RegExpCheck = theMatch.count
End Function
%>
<%
If (false) or (CStr(Request("MM_insert")) <> "") or (CStr(Request("MM_update")) <> "") Then
    validateThis = TFM_validate(CStr(Request("pass")),1,"",true)
    If  validateThis <> "" Then 
        Response.Redirect("error.asp?id=paint&?error=" & Server.URLEncode(validateThis))
    End if
End if
%>
<%
If (false) or (CStr(Request("MM_insert")) <> "") or (CStr(Request("MM_update")) <> "") Then
    validateThis = TFM_validate(CStr(Request("name")),1,"",true)
    If  validateThis <> "" Then 
        Response.Redirect("error.asp?id=paint&?error=" & Server.URLEncode(validateThis))
    End if
End if
%>
<%
If (false) or (CStr(Request("MM_insert")) <> "") or (CStr(Request("MM_update")) <> "") Then
    validateThis = TFM_validate(CStr(Request("title")),1,"",true)
    If  validateThis <> "" Then 
        Response.Redirect("error.asp?id=paint&?error=" & Server.URLEncode(validateThis))
    End if
End if
%>
<%
If (false) or (CStr(Request("MM_insert")) <> "") or (CStr(Request("MM_update")) <> "") Then
    validateThis = TFM_validate(CStr(Request("contents")),1,"",true)
    If  validateThis <> "" Then 
        Response.Redirect("error.asp?id=paint&?error=" & Server.URLEncode(validateThis))
    End if
End if
%>
<!--#include file="../Connections/may_user.asp" -->
<!--#include file="color.asp" -->
<%
Dim book__MMColParam
book__MMColParam = "1"
if (Request.Cookies("pic_ID") <> "") then book__MMColParam = Request.Cookies("pic_ID")
%>
<%
set book = Server.CreateObject("ADODB.Recordset")
book.ActiveConnection = MM_may_user_STRING
book.Source = "SELECT * FROM book WHERE book_ID = " + Replace(book__MMColParam, "'", "''") + ""
book.CursorType = 0
book.CursorLocation = 2
book.LockType = 3
book.Open()
book_numRows = 0
%>
<%
Function StrLenB( strString )
 dim intLoop,intReturn
 if isNull(strString) then
  StrLenB = 0
  exit Function
 end if
 intReturn = len(strString)
 for intLoop = 1 to len(strString)
  if ( asc( mid( strString, intLoop, 1 ) ) < 0 ) then intReturn = intReturn + 1
 next
 StrLenB = intReturn
End Function

Function strLeftB( strString ,intLen)
 dim intLenB,intLoop
 if StrLenB(strString) < intLen then
  strLeftB = strString
  exit Function
 end if
 for intLoop = 1 to Len(strString)
  if ( asc( mid( strString, intLoop, 1 ) ) < 0 ) then 
   intLenB = intLenB + 2
  else
   intLenB = intLenB + 1
  end if
  if intLenB > intLen then
   intLoop = intLoop - 1
   exit for
  elseif intLenB = intLen then
   exit for
  end if 
 next
 strLeftB = left(strString,intLoop)
End Function

Function IsLetter( chr )
 dim blnReturn
 blnReturn = false
 if ( ( chr >= asc("a") and chr <= asc("z") )  or ( chr >= asc("A") and chr <= asc("Z") ) or  ( chr >= asc("0") and chr <= asc("9") )  ) then
  blnReturn = true
 end if
 IsLetter = blnReturn
End Function

Function AlignString( string, byVal size )
 dim r,nLen,n,i,a,s_i
 r = string
 nLen = StrLenB( string ) 
 ' if string's width less then size ,return this string .
 if  ( nLen > size ) then
  size = size - 2
  n = 0
  i = 1
  ' cut to index
  do while ( i )
   a = asc( mid( string, i, 1 ) )
   if ( a < 0 ) then 
    if ( n + 1 = size ) then 
     i = i - 1
     exit do
    end if
    n = n + 1
   end if
   n = n + 1
   if ( n = size ) then exit do
   
   i = i + 1
  loop
  'fxDebug( i ) 
  s_i = i 
  a = asc( mid( string, i+1, 1 ) )
  if ( IsLetter(a) ) then
   do while ( 1 )
    a = asc( mid( string, i, 1  ) )
    if ( not IsLetter(a) ) then exit do
    i = i -1
    if  ( i = 0 ) then 
     i = s_i
     exit do
    end if
   loop
  end if

  r = mid( string, 1, i ) & "........"
 end if
 AlignString = r
End Function
%>

<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>										
function DoWhiteSpace(str)												
	DoWhiteSpace = Replace((Replace(str, vbCrlf, "<br>")), chr(32)&chr(32), "&nbsp;&nbsp;")			
End Function														
</SCRIPT>
<%if  Request.form("MM_insert")="true" and  Request.Cookies("guest_pass")=book.Fields.Item("pass").Value  then
gName=Request.form("name")
pass=Request.form("pass")
title=Request.form("title")
content=Request.form("contents")
oicq=Request.form("oicq")
homepage=Request.form("homepage")
ID=Request.QueryString("ID")
filesize=Request.form("filesize")

Response.Cookies("guest_name")= gName
Response.Cookies("guest_pass")= pass
Response.Cookies("oicq")= oicq
Response.Cookies("homepage")= homepage
		 
		 
		book("name")=Server.HTMLEncode(gname)
		book("pass")=Server.HTMLEncode(pass)
		book("Oicq")=Server.HTMLEncode(oicq)
	    book("homepage")=Server.HTMLEncode(homepage)
		book("title")=Server.HTMLEncode(title)
		book("toptime")=now()
		book("posttime")=now()
		book("IP")= request.servervariables("remote_addr")
			book("filesize")=formatnumber(filesize/1024,2,-1)
		book("contents")=DoWhiteSpace(Server.HTMLEncode(content))
book.update 
   
		
	Response.Redirect("MAX_book.asp")

end if %>
<html>
<head>
<title>Post message!</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="CSS.asp" type="text/css">
</head>
<body bgcolor="<%=web_bg%>" text="#000000" leftmargin="0" topmargin="5" background="<%=web_bgimg%>">
<form name="form1" action="write_save.asp?ID=<%=(book.Fields.Item("Book_ID").Value)%>" method="post">
  <table width="526" border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="<%=td_bor%>">
    <tr> 
      <td bgcolor="<%=titlebg%>">&nbsp;</td>
    </tr>
    <tr> 
      <td bgcolor="<%=bg_color%>"> 
        <table align="center" width="396">
          <tr> 
            <td nowrap align="right" valign="baseline" colspan="2" height="9"> 
              <div align="center"><img src="picdata/<%=(book.Fields.Item("picname").Value)%>"></div>
            </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline" colspan="2"> 
              <div align="center"><a href="javascript:location.reload()">刷新可显示修改过的作品</a></div>
            </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline">主题:</td>
            <td valign="baseline"> 
              <input type="text" name="title" size="32" maxlength="50" value="<%=(book.Fields.Item("title").Value)%>">
              * </td>
          </tr>
          <tr> 
            <td nowrap align="right" colspan="2"> 
              <div align="center"> 
                <!--#include file="../getubb.asp" -->
              </div>
            </td>
          </tr>
          <tr> 
            <td nowrap align="right">内容:<br>
              <img onClick="contents.value+='[url=http://www.poobbs.com]涂鸦王国[/url]'" src="../bbsimages/TEAM.GIF" alt="超级连接" border="0"> 
            </td>
            <td valign="top"> 
              <textarea name="contents" cols="40" wrap="VIRTUAL" rows="5"><%=(book.Fields.Item("contents").Value)%></textarea>
              * </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline">发言者</td>
            <td valign="baseline"> 
              <input type="text" name="name" size="15" maxlength="30" value="<%=(book.Fields.Item("name").Value)%>">
              * </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline">保护密码</td>
            <td valign="baseline"> 
              <input type="password" name="pass" size="10" maxlength="30" value="<%=(book.Fields.Item("pass").Value)%>">
              * 
              <%if Request.QueryString("administrator")="getpassword" then %>
              <%=(book.Fields.Item("pass").Value)%> 
              <%end if %>
            </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline" colspan="2"> 
              <table width="100%" border="0" id="adv" style="DISPLAY: none" cellpadding="1" cellspacing="1">
                <tr> 
                  <td width="17%" height="28"> 
                    <div align="right">OICQ:</div>
                  </td>
                  <td width="83%" height="28"> 
                    <input type="text" name="oicq" size="15" maxlength="20" value="<%= Request.Cookies("oicq") %>" style="ime-mode: disabled">
                  </td>
                </tr>
                <tr> 
                  <td width="17%"> 
                    <div align="right">主页:</div>
                  </td>
                  <td width="83%"> 
                    <input type="text" name="homepage" size="30" maxlength="225" value="<%= Request.Cookies("homepage") %>" style="ime-mode: disabled">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline">&nbsp;</td>
            <td valign="baseline"> 
              <input id=advcheck name=advshow type=checkbox value=1 onClick=showadv()>
              <span id=advance>显示高级选项 
              <script>
function showadv(){
if (document.form1.advshow.checked == true) {
	adv.style.display = "";
	advance.innerText="关闭高级选项"
}else{
	adv.style.display = "none";
	advance.innerText="显示高级选项"
}
}
</script>
              </span> </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline">&nbsp;</td>
            <td valign="baseline"> 
              <input type="hidden" name="MM_insert" value="true">
<%
Function TestObj(Str)
On Error Resume Next
TestObj = False
Err.Description = ""
Set TObj = Server.CreateObject(Str)
If Err.Description = "" Then TestObj = True
Set TObj = Nothing
End Function
%>
              <input type="hidden" name="filesize" value="<%if  TestObj("Scripting.FileSystemObject") then
if book.Fields.Item("picname").Value<>"" then 
Dim objFSO, theFile,picname
    picname=book.Fields.Item("picname").Value
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	
	Filepath =Server.MapPath("picdata/"&picname)	
If (objFSO.FileExists(Filepath))Then
	
	set theFile =objfso.Getfile(Server.MapPath("picdata/"&picname))
				
    Response.write(""&theFile.Size&"")
else   

Response.write("0")
	 end if 
	Set  theFile = Nothing
Set objFSO = Nothing
end if 
end if 
%>">            </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline">&nbsp;</td>
            <td valign="baseline"> 
              <input type="submit" name="Submit" value="发表作品" OnClick="this.disabled=true;document.form1.submit();"> 
              <input type="reset" name="Reset" value="重写">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
<p>&nbsp;</p>
</body>
</html>
<%
book.Close()
%>
