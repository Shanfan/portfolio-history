<!--#include file="poo/user.asp" -->
<%

if Session("admin_name")<>user_name or  Session("admin_pass")<>user_password then 
Response.Redirect "poo/login.asp"
end if 
%>
<%
if Request.form("save")="yes" then 
Dim objFSO, objTextFile,titlefile
	Set objFSO = CreateObject("Scripting.FileSystemObject")	
	Set objTextFile = objFSO.CreateTextFile(Server.MapPath("pop_foot.txt"),TRUE)
	Set titlefile = objFSO.CreateTextFile(Server.MapPath("pop_top.txt"),TRUE)	
	
	'fso写入设置
	titlefile.Writeline(request.form("title"))
	objTextFile.Writeline(request.form("content"))

    objTextFile.Close
	Set objTextFile = Nothing
	
	titlefile.Close
	Set titlefile = Nothing
	Set objFSO = Nothing
	 Response.Redirect("admin_new.asp?设置成功")
end if 
%><html>
<head>
<title>发布广告</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="cdas.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form name="form1" method="post" action="admin_new.asp">
  <br>
  <table width="543" border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="#CCCCCC">
    <tr> 
      <td width="87"> 
        <div align="center">涂鸦板顶</div>
      </td>
      <td width="449"> 
        <textarea name="title"   cols="60" rows="10"><!--#include file="pop_top.txt" --></textarea>
      </td>
    </tr>
    <tr> 
      <td width="87"> 
        <div align="center">涂鸦板底部</div>
      </td>
      <td width="449"> 
        <textarea name="content" cols="60" rows="10"><!--#include file="pop_foot.txt" --></textarea>
        <input type="hidden" name="save" value="yes">
      </td>
    </tr>
    <tr>
      <td width="87">&nbsp;</td>
      <td width="449"> 
        <input type="submit" name="Submit" value="确定更新广告">
        支持<font color="#FF0000">html</font></td>
    </tr>
  </table>
</form>
</body>
</html>
