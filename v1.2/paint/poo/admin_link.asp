<!--#include file="user.asp" -->
<!--#include file="color.asp" -->
<%

if Session("admin_name")<>user_name or  Session("admin_pass")<>user_password then 
Response.Redirect "login.asp"
end if 
%>
<html>
<head>

<link rel="stylesheet" href="admin.css" type="text/css">
<title>涂鸦联盟连接</title></head>
<body bgcolor="#FFFFFF" class="sft">


<%
ipf = Server.MapPath("link.ini")
Set fso = CreateObject("Scripting.FileSystemObject")
if  Request.Form("save") = "yes" then
	iptext = Request.Form("iptext")
	iptext = Split(iptext,CHR(13)&CHR(10))

	Set ipf = fso.OpenTextFile(ipf,2,True)
	for i=0 to UBound(iptext)
		if len(iptext(i))>1 then ipf.WriteLine(iptext(i))
	next
	ipf.close
	 Response.Redirect("admin_link.asp?设置成功")
else
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
<br>
<table align="center"  bgcolor="#333333" border="0" width=611 cellspacing="1" cellpadding="3" class="sft">
  <tr>
    <td bgcolor="#CCCCCC" class="sfh" align="center">每4行表示一个链接,设置如下:</td>
  </tr>
<tr><td bgcolor="#f7f7f7"><br>
      第1行: 链接地址 ( http://ice.7i24.com)<br>
      <br>
      第2行: logo图片 (http://www.163.com/logo.gif)<br>
      <br>
      第3行: 连接说明 (Chi的小站点) <br>
      <br>
      第4行：分隔线 （ --------------------------）
<form method="post" action="admin_link.asp">
<p align="center">
          <textarea name="iptext" cols="80" rows="15" wrap="OFF"><%
Set ipf = fso.OpenTextFile(ipf)
DO While not ipf.AtEndOfStream
	Response.Write ipf.ReadAll
Loop
ipf.close
%></textarea>
<br>
<input type="hidden" name="save" value="yes">
<input type="submit" name="submit" value="确 定"></p>
</form>
</td></tr></table>
<br>
<table width="<%=table%>" border="0" cellspacing="1" cellpadding="1" bgcolor="#CCCCCC" align="center">
  <tr> 
    <td bgcolor="#CCCCCC">&nbsp;<img src="../bbsimages/msn-gray.gif" width="16" height="15"> 
      <font color="#FFFFFF"><b>涂鸦板联盟连接效果：</b></font></td>
  </tr>
  <tr> 
    <td bgcolor="#FFFFFF"><br>
      <table style="TABLE-LAYOUT: fixed"  width="90%" border="0" cellspacing="1" cellpadding="1" align="center">
        <tr> 
          <td class="lines"> 
            <script language="JavaScript" src="link.asp">
</script>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<br>
<br>
<br>
<br>
<%
end if
%>

