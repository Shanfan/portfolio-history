<%@LANGUAGE="VBSCRIPT"%>

<%Response.Buffer = True 
Response.Expires = -1
Response.AddHeader "Pragma", "no-cache"
Response.AddHeader "cache-control", "no-store" %>

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
<!--#include file="user.asp" -->
<!--#include file="conn.asp" -->
<!--#include file="../Connections/may_user.asp" -->

<%
Dim rs__MMColParam
rs__MMColParam = "1"
if (Request.QueryString("picname") <> "") then rs__MMColParam = Request.QueryString("picname")
%>
<%
set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = MM_paint_STRING
rs.Source = "SELECT * FROM img WHERE picname = '" + Replace(rs__MMColParam, "'", "''") + "'"
rs.CursorType = 0
rs.CursorLocation = 2
rs.LockType = 3
rs.Open()
rs_numRows = 0

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
<%if  Request.form("MM_insert")="true" then


set connGraph=server.CreateObject("ADODB.connection")
connGraph.ConnectionString= MM_may_user_STRING
connGraph.Open

gName=Request.form("name")
pass=Request.form("pass")
title=Request.form("title")
content=Request.form("contents")
oicq=Request.form("oicq")
homepage=Request.form("homepage")
pic=Request.form("picname")
oeb=Request.form("oebname")
w=Request.form("w")
h=Request.form("h")
tool=Request.form("tool")
uploadpaint=Request.form("uploadpaint")


imageID=Request.form("imageid")
painttime=Request.form("painttime")
fsosize=Request.form("filesize")
filesizes=formatnumber(fsosize/1024,2,-1)

Response.Cookies("guest_name")= gName
Response.Cookies("guest_pass")= pass
Response.Cookies("oicq")= oicq
Response.Cookies("homepage")= homepage
		 
set rec=server.createobject("ADODB.recordset")
rec.Open "SELECT * FROM [Book] ORDER BY book_id DESC",connGraph,1,3

		rec.addnew
		rec("name")=Server.HTMLEncode(gname)
		rec("pass")=Server.HTMLEncode(pass)
		rec("Oicq")=Server.HTMLEncode(oicq)
	    rec("homepage")=Server.HTMLEncode(homepage)
		rec("title")=Server.HTMLEncode(title)
		rec("contents")=DoWhiteSpace(AlignString(Server.HTMLEncode(content),1000))
		rec("use_tool")=tool
		rec("IP")= request.servervariables("remote_addr")
		rec("picname")=pic
		rec("pchname")=oeb
		rec("pic_W")=w
		rec("pic_H")=h
		rec("user_ID")=user_ID
		rec("painttime")=painttime
			rec("filesize")=filesizes
		rec("admin_name")=user_name
		if uploadpaint<>""then 
		rec("uploadpaint")=uploadpaint
	end if 
		
	    rec.update
	Response.Cookies("filesize")=""
    Response.Cookies("uploadpaint")=""
	Response.Redirect("?imageid="&imageID&"")
rec.close
set rec=nothing
set connGraph=nothing
end if %>

<%
if Request.QueryString("imageid")<>"" then 
 Sql = "Delete From Img Where imageid="&Request.QueryString("imageid")
   set Command1 = Server.CreateObject("ADODB.Command")
Command1.ActiveConnection = MM_paint_STRING
Command1.CommandText = sql
Command1.Execute()

Response.Redirect("MAX_book.asp")
 end if
 
%>
<!--#include file="color.asp" -->
<html>
<head>
<title>Post message!</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="CSS.asp" type="text/css">
</head>
<body bgcolor="<%=web_bg%>" text="#000000" leftmargin="0" topmargin="5">
<form name="form1" action="write.asp" method="post">
  <table width="527" border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="<%=td_bor%>">
    <tr> 
      <td bgcolor="<%=titlebg%>">&nbsp;</td>
    </tr>
    <tr> 
      <td bgcolor="<%=bg_color%>"> 
        <table align="center" width="396">
          <tr> 
            <td nowrap align="right" valign="baseline" colspan="2" height="9"> 
              <div align="center"><br>
                <a href="javascript:location.reload()"><img src="picdata/<%=(rs.Fields.Item("picname").Value)%>" border="0" alt="刷新显示"></a></div>
            </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline" colspan="2">
              <div align="center"><a href="javascript:location.reload()">刷新该页</a></div>
            </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline">主题:</td>
            <td valign="baseline"> 
              <input type="text" name="title" size="32" maxlength="50" value="无主题">
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
              <textarea name="contents" cols="40" wrap="VIRTUAL" rows="5"></textarea>
              * </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline">发言者</td>
            <td valign="baseline"> 
              <%pname=rs.Fields.Item("username").Value %>
              <input type="text" name="name" size="15" maxlength="30" value="<%=pname%>">
              * 
              <input type="hidden" name="picname" value="<%=rs.Fields.Item("picname").Value%>">
              <input type="hidden" name="oebname" value="<%=rs.Fields.Item("oebname").Value%>">
              <input type="hidden" name="w" value="<%=rs.Fields.Item("img_width").Value%>">
              <input type="hidden" name="h" value="<%=rs.Fields.Item("img_height").Value%>">
              <input type="hidden" name="tool" value="<%=rs.Fields.Item("tool").Value%>">
              <input type="hidden" name="imageid" value="<%=rs.Fields.Item("imageid").Value%>">
              <input type="hidden" name="painttime" value="<%=rs.Fields.Item("painttime").Value%>">
            </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline">保护密码</td>
            <td valign="baseline"> 
              <input type="password" name="pass" size="10" maxlength="30" value="<%=Request.Cookies("guest_pass")%>">
              * 
              <input type="hidden" name="uploadpaint" value="<%=Request.QueryString("uploadpaint")%>">
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
if Request.QueryString("picname")<>"" then 
Dim objFSO, theFile,picname
    picname=Request.QueryString("picname")
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
%>">
              <span id=advance> </span> </td>
          </tr>
          <tr> 
            <td nowrap align="right" valign="baseline">&nbsp;</td>
            <td valign="baseline"> 
              <input type="submit" name="Submit" value="发表作品" OnClick="this.disabled=true;document.form1.submit();">
              <input type="reset" name="Reset" value="重写">
            </td>
          </tr>
        </table>
        <br>
      </td>
    </tr>
  </table>
  <br>
  <br>

</form>
<p>&nbsp;</p>
</body>
</html>
<%
rs.Close()
%>
