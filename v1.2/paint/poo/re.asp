<%@LANGUAGE="VBSCRIPT"%>
<% 
Dim validateThis
Function TFM_validate(formelement, theType, errormsg, req)'version 1.0.0
    if errormsg = "" Then errormsg = "There was an error in the data you entered"
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
    validateThis = TFM_validate(CStr(Request("name")),1,"",true)
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
Dim Recordset1__MMColParam
Recordset1__MMColParam = "1"
if (Request.QueryString("book_ID") <> "") then Recordset1__MMColParam = Request.QueryString("book_ID")
%>
<%
set Recordset1 = Server.CreateObject("ADODB.Recordset")
Recordset1.ActiveConnection = MM_may_user_STRING
Recordset1.Source = "SELECT * FROM book WHERE book_ID = " + Replace(Recordset1__MMColParam, "'", "''") + ""
Recordset1.CursorType = 0
Recordset1.CursorLocation = 2
Recordset1.LockType = 3
Recordset1.Open()
Recordset1_numRows = 0
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
content=Request.form("contents")
oicq=Request.form("oicq")
homepage=Request.form("homepage")
Book_ID=Request.form("book_id")

Response.Cookies("guest_name")= gName
Response.Cookies("oicq")= oicq
Response.Cookies("homepage")= homepage
		 
set rec=server.createobject("ADODB.recordset")
rec.Open "SELECT * FROM [re] ORDER BY re_id DESC",connGraph,1,3

		rec.addnew
		rec("name")=Server.HTMLEncode(gname)
		rec("OICQ")=Server.HTMLEncode(oicq)
	    rec("homepage")=Server.HTMLEncode(homepage)
		rec("re_content")=DoWhiteSpace(AlignString(Server.HTMLEncode(content),1000))
		rec("Book_ID")=Book_ID
		rec("IP")= request.servervariables("remote_addr")
	    rec.update
		Response.Redirect "index.asp"
rec.close
set rec=nothing
set connGraph=nothing
end if %>

<html>
<head>
<title>回复帖子</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="CSS.asp" type="text/css">
<script language="JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->
</script>
</head>
<body bgcolor="<%=web_bg%>" text="#000000" background="<%=web_bgimg%>">
<table width="500" border="0" cellspacing="1" cellpadding="1" align="center" height="362" bgcolor="<%=td_bor%>">
  <tr> 
    <td height="2"> 
      <table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr> 
          <td bgcolor="<%=titlebg%>">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td bgcolor="<%=bg_color%>"> 
      <table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr> 
          <td> 
            <div align="center">
              <%if  Recordset1.Fields.Item("picname").Value<>""then %>
              <img src="picdata/<%=(Recordset1.Fields.Item("picname").Value)%>">
              <%end if %>
            </div>
          </td>
        </tr>
      </table>
      <form name="form1" method="post" action="">
        <table width="100%" border="0" cellspacing="1" cellpadding="1">
          <tr> 
            <td width="21%"> 
              <div align="right">发言人:</div>
            </td>
            <td width="79%"> 
              <input type="text" name="name" size="20" maxlength="30" value="<%= Request.Cookies("guest_name") %>">
              * 
              <input type="hidden" name="book_id" value="<%=(Recordset1.Fields.Item("book_ID").Value)%>">
            </td>
          </tr>
          <tr> 
            <td colspan="2"> 
              <div align="center"> 
                <!--#include file="../getubb.asp" -->
              </div>
              <div align="right"></div>
            </td>
          </tr>
          <tr> 
            <td width="21%"> 
              <div align="right">内容: </div>
            </td>
            <td width="79%"> 
              <textarea name="contents" cols="40" rows="4" wrap="VIRTUAL"></textarea>
              * </td>
          </tr>
          <tr> 
            <td colspan="2"> 
              <table width="100%" border="0" id="adv" style="DISPLAY: none" cellpadding="1" cellspacing="1">
                <tr> 
                  <td width="21%" height="26"> 
                    <div align="right">OICQ:</div>
                  </td>
                  <td width="79%" height="26"> 
                    <input type="text" name="oicq" size="15" maxlength="20" value="<%= Request.Cookies("oicq") %>">
                  </td>
                </tr>
                <tr> 
                  <td width="21%"> 
                    <div align="right">主页:</div>
                  </td>
                  <td width="79%"> 
                    <input type="text" name="homepage" size="30" maxlength="225" value="<%= Request.Cookies("homepage") %>">
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="21%"> 
              <div align="right"></div>
            </td>
            <td width="79%"> 
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
            <td width="21%">&nbsp;</td>
            <td width="79%"> 
              <input type="hidden" name="MM_insert" value="true">
            </td>
          </tr>
          <tr> 
            <td width="21%">&nbsp;</td>
            <td width="79%"> 
              <input type="submit" name="Submit" value="回复" OnClick="this.disabled=true;document.form1.submit();">
              <input type="reset" name="Submit2" value="清除">
              <input type="button" name="Submit3" value="返回" onClick="MM_goToURL('parent','javascript:history.back(1)');return document.MM_returnValue">
            </td>
          </tr>
        </table>
      </form>
    </td>
  </tr>
</table>
<br>
<br>
<!--#include file="../foot.htm" -->
</body>
</html>
<%
Recordset1.Close()
%>

