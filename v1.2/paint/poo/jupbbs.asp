<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="user.asp" -->
<%

if Session("admin_name")<>user_name or  Session("admin_pass")<>user_password then 
Response.Redirect "login.asp"
end if 
%>
<!--#include file="../Connections/may_user.asp" -->

<% 
if Request.QueryString("del")="yes" then 
dim sql
  
   Sql = "Delete From jump Where ID="&Request.QueryString("ID")
set Command1 = Server.CreateObject("ADODB.Command")
Command1.ActiveConnection =MM_may_user_STRING
Command1.CommandText = sql
Command1.Execute()
 Response.Redirect("jupbbs.asp")
 end if 
%>

<%
' *** Edit Operations: declare variables

MM_editAction = CStr(Request("URL"))
If (Request.QueryString <> "") Then
  MM_editAction = MM_editAction & "?" & Request.QueryString
End If

' boolean to abort record edit
MM_abortEdit = false

' query string to execute
MM_editQuery = ""
%>
<%
' *** Insert Record: set variables

If (CStr(Request("MM_insert")) <> "") Then

  MM_editConnection = MM_may_user_STRING
  MM_editTable = "jump"
  MM_editRedirectUrl = "jupbbs.asp"
  MM_fieldsStr  = "goname|value|url|value"
  MM_columnsStr = "goname|',none,''|url|',none,''"

  ' create the MM_fields and MM_columns arrays
  MM_fields = Split(MM_fieldsStr, "|")
  MM_columns = Split(MM_columnsStr, "|")
  
  ' set the form values
  For i = LBound(MM_fields) To UBound(MM_fields) Step 2
    MM_fields(i+1) = CStr(Request.Form(MM_fields(i)))
  Next

  ' append the query string to the redirect URL
  If (MM_editRedirectUrl <> "" And Request.QueryString <> "") Then
    If (InStr(1, MM_editRedirectUrl, "?", vbTextCompare) = 0 And Request.QueryString <> "") Then
      MM_editRedirectUrl = MM_editRedirectUrl & "?" & Request.QueryString
    Else
      MM_editRedirectUrl = MM_editRedirectUrl & "&" & Request.QueryString
    End If
  End If

End If
%>
<%
' *** Insert Record: construct a sql insert statement and execute it

If (CStr(Request("MM_insert")) <> "") Then

  ' create the sql insert statement
  MM_tableValues = ""
  MM_dbValues = ""
  For i = LBound(MM_fields) To UBound(MM_fields) Step 2
    FormVal = MM_fields(i+1)
    MM_typeArray = Split(MM_columns(i+1),",")
    Delim = MM_typeArray(0)
    If (Delim = "none") Then Delim = ""
    AltVal = MM_typeArray(1)
    If (AltVal = "none") Then AltVal = ""
    EmptyVal = MM_typeArray(2)
    If (EmptyVal = "none") Then EmptyVal = ""
    If (FormVal = "") Then
      FormVal = EmptyVal
    Else
      If (AltVal <> "") Then
        FormVal = AltVal
      ElseIf (Delim = "'") Then  ' escape quotes
        FormVal = "'" & Replace(FormVal,"'","''") & "'"
      Else
        FormVal = Delim + FormVal + Delim
      End If
    End If
    If (i <> LBound(MM_fields)) Then
      MM_tableValues = MM_tableValues & ","
      MM_dbValues = MM_dbValues & ","
    End if
    MM_tableValues = MM_tableValues & MM_columns(i)
    MM_dbValues = MM_dbValues & FormVal
  Next
  MM_editQuery = "insert into " & MM_editTable & " (" & MM_tableValues & ") values (" & MM_dbValues & ")"

  If (Not MM_abortEdit) Then
    ' execute the insert
    Set MM_editCmd = Server.CreateObject("ADODB.Command")
    MM_editCmd.ActiveConnection = MM_editConnection
    MM_editCmd.CommandText = MM_editQuery
    MM_editCmd.Execute
    MM_editCmd.ActiveConnection.Close

    If (MM_editRedirectUrl <> "") Then
      Response.Redirect(MM_editRedirectUrl)
    End If
  End If

End If
%>
<%
set Recordset1 = Server.CreateObject("ADODB.Recordset")
Recordset1.ActiveConnection = MM_may_user_STRING
Recordset1.Source = "SELECT * FROM jump ORDER BY ID ASC"
Recordset1.CursorType = 0
Recordset1.CursorLocation = 2
Recordset1.LockType = 3
Recordset1.Open()
Recordset1_numRows = 0
%>
<%
Dim Repeat1__numRows
Repeat1__numRows = -1
Dim Repeat1__index
Repeat1__index = 0
Recordset1_numRows = Recordset1_numRows + Repeat1__numRows
%>
<%
' *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

' create the list of parameters which should not be maintained
MM_removeList = "&index="
If (MM_paramName <> "") Then MM_removeList = MM_removeList & "&" & MM_paramName & "="
MM_keepURL="":MM_keepForm="":MM_keepBoth="":MM_keepNone=""

' add the URL parameters to the MM_keepURL string
For Each Item In Request.QueryString
  NextItem = "&" & Item & "="
  If (InStr(1,MM_removeList,NextItem,1) = 0) Then
    MM_keepURL = MM_keepURL & NextItem & Server.URLencode(Request.QueryString(Item))
  End If
Next

' add the Form variables to the MM_keepForm string
For Each Item In Request.Form
  NextItem = "&" & Item & "="
  If (InStr(1,MM_removeList,NextItem,1) = 0) Then
    MM_keepForm = MM_keepForm & NextItem & Server.URLencode(Request.Form(Item))
  End If
Next

' create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL & MM_keepForm
if (MM_keepBoth <> "") Then MM_keepBoth = Right(MM_keepBoth, Len(MM_keepBoth) - 1)
if (MM_keepURL <> "")  Then MM_keepURL  = Right(MM_keepURL, Len(MM_keepURL) - 1)
if (MM_keepForm <> "") Then MM_keepForm = Right(MM_keepForm, Len(MM_keepForm) - 1)

' a utility function used for adding additional parameters to these strings
Function MM_joinChar(firstItem)
  If (firstItem <> "") Then
    MM_joinChar = "&"
  Else
    MM_joinChar = ""
  End If
End Function
%>
<html>
<head>
<title>论坛跳转编辑</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="cdas.css" type="text/css">
<script language="JavaScript">
<!--
function MM_findObj(n, d) { //v4.0
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && document.getElementById) x=document.getElementById(n); return x;
}

function MM_validateForm() { //v4.0
  var i,p,q,nm,test,num,min,max,errors='',args=MM_validateForm.arguments;
  for (i=0; i<(args.length-2); i+=3) { test=args[i+2]; val=MM_findObj(args[i]);
    if (val) { nm=val.name; if ((val=val.value)!="") {
      if (test.indexOf('isEmail')!=-1) { p=val.indexOf('@');
        if (p<1 || p==(val.length-1)) errors+='- '+nm+' must contain an e-mail address.\n';
      } else if (test!='R') {
        if (isNaN(val)) errors+='- '+nm+' must contain a number.\n';
        if (test.indexOf('inRange') != -1) { p=test.indexOf(':');
          min=test.substring(8,p); max=test.substring(p+1);
          if (val<min || max<val) errors+='- '+nm+' must contain a number between '+min+' and '+max+'.\n';
    } } } else if (test.charAt(0) == 'R') errors += '- '+nm+' is required.\n'; }
  } if (errors) alert('The following error(s) occurred:\n'+errors);
  document.MM_returnValue = (errors == '');
}
//-->
</script>
<style type="text/css">
<!--
td {  font-size: 12px}
-->
</style>
</head>
<body bgcolor="#FFFFFF" text="#000000">
<form method="post" action="<%=MM_editAction%>" name="form1">
  <table align="center" width="397" bgcolor="#CCCCCC">
    <tr valign="baseline"> 
      <td nowrap align="right" width="63">&nbsp;</td>
      <td width="322"><a href="admin_new.asp">写广告</a></td>
    </tr>
    <tr valign="baseline"> 
      <td nowrap align="right" width="63">名字:</td>
      <td width="322"> 
        <input type="text" name="goname" value="" size="32">
      </td>
    </tr>
    <tr valign="baseline"> 
      <td nowrap align="right" width="63">URL连接:</td>
      <td width="322"> 
        <input type="text" name="url" value="" size="32">
      </td>
    </tr>
    <tr valign="baseline"> 
      <td nowrap align="right" width="63">&nbsp;</td>
      <td width="322"> 
        <input type="submit" value="增加" onClick="MM_validateForm('goname','','R','url','','R');return document.MM_returnValue">
      </td>
    </tr>
  </table>
  <input type="hidden" name="MM_insert" value="true">
</form>
<% 
While ((Repeat1__numRows <> 0) AND (NOT Recordset1.EOF)) 
%>
<table width="399" border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="#CCCCCC">
  <tr> 
    <td width="323"><%=(Recordset1.Fields.Item("goname").Value)%></td>
    <td width="69"><A HREF="jupbbs.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "ID=" & Recordset1.Fields.Item("ID").Value %>&del=yes">删除</A></td>
  </tr>
  <tr> 
    <td colspan="2"><%=(Recordset1.Fields.Item("url").Value)%></td>
  </tr>
</table>
<% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  Recordset1.MoveNext()
Wend
%>
<p>&nbsp;</p>
</body>
</html>
<%
Recordset1.Close()
%>
