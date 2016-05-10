<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="conn.asp" -->
<!--#include file="user.asp" -->
<%

if Session("admin_name")<>user_name or  Session("admin_pass")<>user_password then 
Response.Redirect "login.asp"
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

  MM_editConnection = MM_paint_STRING
  MM_editTable = "fuadmin"
  MM_editRedirectUrl = "admin_add.asp"
  MM_fieldsStr  = "name|value|pass|value"
  MM_columnsStr = "FUadminname|',none,''|Pass|',none,''"

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
set rs = Server.CreateObject("ADODB.Recordset")
rs.ActiveConnection = MM_paint_STRING
rs.Source = "SELECT * FROM fuadmin ORDER BY ID ASC"
rs.CursorType = 0
rs.CursorLocation = 2
rs.LockType = 3
rs.Open()
rs_numRows = 0
%>
<%
Dim Repeat1__numRows
Repeat1__numRows = -1
Dim Repeat1__index
Repeat1__index = 0
rs_numRows = rs_numRows + Repeat1__numRows
%>
<!--#include file="user.asp" -->
<html>
<head>
<title>增加版主</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="admin.css" type="text/css">
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
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%

 if   Request.QueryString("ID")<>""and Request.QueryString("del")="yes" then 
 ID=Request.QueryString("ID")
 Sql = "Delete From fuadmin Where ID="&ID
   set Command1 = Server.CreateObject("ADODB.Command")
Command1.ActiveConnection = MM_paint_STRING
Command1.CommandText = sql
Command1.Execute()
Response.Redirect("admin_add.asp")
 end if 
 
%>
<table width="608" border="0" cellspacing="1" cellpadding="1" align="center" height="10" bgcolor="#000000">
  <tr bgcolor="#999999"> 
    <td height="25"> 
      <div align="center"><a href="admin_pass.asp">基本设置</a></div>
    </td>
    <td height="25"> 
      <div align="center"><a href="admin_color.asp">颜色设置</a></div>
    </td>
    <td height="25"> 
      <div align="center"><a href="admin_add.asp">增加版主</a></div>
    </td>
    <td height="25"> 
      <div align="center"><a href="index.asp">帖子管理</a></div>
    </td>
    <td height="25"> 
      <div align="center"><a href="admin_killip.asp">封锁IP</a></div>
    </td>
    <td height="25">
      <div align="center"><a href="admin_link.asp">论坛联盟</a></div>
    </td>
    <td height="25"> 
      <div align="center"><a href="login.asp?out=ture">退出登入</a></div>
    </td>
    <td height="25"> 
      <div align="center"><a href="admin_new.asp">编写新闻</a></div>
    </td>
  </tr>
</table>
<form name="form1" method="POST" action="<%=MM_editAction%>">
  <div align="center"> 
    <p><font color="#FF0000">版主名称和密码不可以和管理员相同，否则将发生错误<br>
      <br>
      版主名称和密码不能包含特殊字符 &quot;&quot; &lt;&gt; % %</font><br>
      <br>
      <font color="#FF0000">版主的权限：删除帖子，固顶帖子，取消固顶</font><br>
    </p>
    </div>
  <table width="413" border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="#CCCCCC">
    <tr> 
      <td width="59">&nbsp;</td>
      <td width="347">&nbsp;</td>
    </tr>
    <tr> 
      <td width="59">版主名</td>
      <td width="347"> 
        <input type="text" name="name" size="20">
      </td>
    </tr>
    <tr> 
      <td width="59">密码</td>
      <td width="347"> 
        <input type="text" name="pass" size="20">
      </td>
    </tr>
    <tr> 
      <td width="59">&nbsp;</td>
      <td width="347"> 
        <input type="submit" name="Submit" value="增加" onClick="MM_validateForm('name','','R','pass','','R');return document.MM_returnValue">
      </td>
    </tr>
    <tr> 
      <td width="59">&nbsp;</td>
      <td width="347">&nbsp;</td>
    </tr>
  </table>
  <input type="hidden" name="MM_insert" value="true">
</form>
<table width="417" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td width="133">版主名</td>
    <td width="103">密码</td>
    <td width="181">操作</td>
  </tr>
  <tr> 
    <td width="133">&nbsp;</td>
    <td width="103">&nbsp;</td>
    <td width="181">&nbsp;</td>
  </tr>
</table>
<% 
While ((Repeat1__numRows <> 0) AND (NOT rs.EOF)) 
%>
<table width="417" border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="#CCCCCC">
  <tr> 
    <td width="128"> 
      <div align="left"></div>
    </td>
    <td width="88"> 
      <div align="left"></div>
    </td>
    <td width="181">&nbsp;</td>
  </tr>
  <tr> 
    <td width="128"> 
      <div align="left"><%=(rs.Fields.Item("FUadminname").Value)%></div>
    </td>
    <td width="88"> 
      <div align="left"><%=(rs.Fields.Item("Pass").Value)%></div>
    </td>
    <td width="181"> 
      <div align="left"><a href="?del=yes&ID=<%=(rs.Fields.Item("ID").Value)%>">删除</a></div>
    </td>
  </tr>
</table>
<% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  rs.MoveNext()
Wend
%>
</body>
</html>
<%
rs.Close()
%>
