<!--#include file="user.asp" -->
<%
if Session("admin_name")<>user_name or  Session("admin_pass")<>user_password then 
Response.Redirect "login.asp"
end if 
%>
<link rel="stylesheet" href="admin.css" type="text/css">
<body bgcolor="#FFFFFF" class="sft">



<%
ipf = Server.MapPath("killip.ini")
Set fso = CreateObject("Scripting.FileSystemObject")
if  Request.Form("save") = "yes" then
	iptext = Request.Form("iptext")
	iptext = Split(iptext,CHR(13)&CHR(10))

	Set ipf = fso.OpenTextFile(ipf,2,True)
	for i=0 to UBound(iptext)
		if len(iptext(i))>=8 then ipf.WriteLine(iptext(i))
	next
	ipf.close
	Response.Redirect("admin_killip.asp?保存成功！")
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
<br>
<table align="center"  bgcolor="#333333" border="0" width=500 cellspacing="1" cellpadding="3" class="sft">
<tr>
    <td bgcolor="#999999" class="sfh" align="center">一行表示一个要禁止的IP,左边为地址,右边为原因,中间用|分开</td>
  </tr>
<tr><td bgcolor="#f7f7f7">
<form method="post" action="admin_killip.asp"><p align="center">
<textarea name="iptext" cols="50" rows="10" wrap="OFF"><%
Set ipf = fso.OpenTextFile(ipf)
DO While not ipf.AtEndOfStream
	Response.Write ipf.ReadAll
Loop
ipf.close
%></textarea>
<br>
第四段IP可以用*代替,表示禁止该段所有地址(例如 0.0.0.*)
<input type="hidden" name="save" value="yes"><br>
<input type="submit" name="submit" value="确 定"></p>
</form></td></tr></table>
<%
end if
%>


</body>
</html>