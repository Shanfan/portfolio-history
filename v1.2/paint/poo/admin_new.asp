<!--#include file="user.asp" -->
<!--#include file="new_title.txt" -->
<%
if Session("admin_name")<>user_name or  Session("admin_pass")<>user_password then 
Response.Redirect "login.asp"
end if 
%><%
if Request.form("save")="yes" then 
Dim objFSO, objTextFile,titlefile,title
	Set objFSO = CreateObject("Scripting.FileSystemObject")	
	Set objTextFile = objFSO.CreateTextFile(Server.MapPath("new.txt"),TRUE)
	Set titlefile = objFSO.CreateTextFile(Server.MapPath("new_title.txt"),TRUE)	
	title=request.form("title")
	
	'fso写入设置
	titlefile.WriteLine("<" & "%")
	titlefile.WriteLine("news_title=""" &Server.HTMLEncode(title)& """")
	titlefile.WriteLine("%" & ">")
	
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
<title>填写最新消息</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="admin.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form name="frmAnnounce" method="post" action="admin_new.asp">
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
  <table width="583" border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="#CCCCCC">
    <tr>
      <td width="68" bgcolor="#CCCCCC">&nbsp;</td>
      <td width="508" bgcolor="#CCCCCC">&nbsp;</td>
    </tr>
    <tr> 
      <td width="68" bgcolor="#CCCCCC"> 
        <div align="center">主题</div>
      </td>
      <td width="508" bgcolor="#CCCCCC"> 
        <input type="text" name="title" size="60" value="<%=news_title%>">
        <script language="JavaScript" src="inc/ubbcode.js">
</script>
      </td>
    </tr>
    <tr> 
      <td colspan="2" bgcolor="#CCCCCC"> 
        <div align="center">
          <!--#include file="inc/getubb.asp" -->
        </div>
      </td>
    </tr>
    <tr> 
      <td width="68" bgcolor="#CCCCCC"> 
        <div align="center">内容：</div>
      </td>
      <td width="508" bgcolor="#CCCCCC"> 
        <textarea name="Content" cols="70" rows="18" class="unnamed1"><!--#include file="new.txt" --></textarea>
        <input type="hidden" name="save" value="yes">
      </td>
    </tr>
    <tr> 
      <td width="68">&nbsp;</td>
      <td width="508"> 
        <input type="submit" name="Submit" value="确定更新消息" class="unnamed1">
        <a href="new_info.asp" target="_blank"> 浏览新消息</a></td>
    </tr>
  </table>
</form>
</body>
</html>
