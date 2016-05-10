<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="user.asp" -->
<!--#include file="../Connections/may_user.asp" -->
<%

if Session("admin_name")<>user_name or  Session("admin_pass")<>user_password then 
Response.Redirect "login.asp"
end if 
%>
<%
set user = Server.CreateObject("ADODB.Recordset")
user.ActiveConnection = MM_may_user_STRING
user.Source = "SELECT user_ID, max_content  FROM user  WHERE user_ID="&user_ID
user.CursorType = 2
user.CursorLocation = 2
user.LockType = 3
user.Open()
user_numRows = 0
%>
<% 
if Request.QueryString("max")<>"" then 
count=Request.QueryString("max")
user("max_content")=count
user.update 
 Response.Redirect("admin_pass.asp?设置成功了")
end if
%>
<html>
<head>
<title>后台设置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="admin.css" type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000">
<%
if Request.form("save")="yes" then 
Dim objFSO, objTextFile,max_bookss,user_name
	Set objFSO = CreateObject("Scripting.FileSystemObject")	
	Set objTextFile = objFSO.CreateTextFile(Server.MapPath("user.asp"),TRUE)
	max_bookss=request("max_book")
	
	'-----------
	user_name=request("user_name")
	nichen=request("nichen")
	user_password=request("user_password")
	adminhomepage=request("adminhomepage")
	bbs_name=request("bbs_name")
	
	objTextFile.WriteLine("<" & "%")
	'fso写入设置
	objTextFile.WriteLine("user_name=""" & Server.HTMLEncode(user_name) & """")
	objTextFile.WriteLine("nichen=""" & Server.HTMLEncode(nichen) & """")
	objTextFile.WriteLine("user_ID=""" & request("user_ID") & """")
    objTextFile.WriteLine("user_password=""" & Server.HTMLEncode(user_password) & """")
	
	objTextFile.WriteLine("adminhomepage=""" & Server.HTMLEncode(adminhomepage) & """")
	
	objTextFile.WriteLine("bbs_name=""" & Server.HTMLEncode(bbs_name) & """")
    objTextFile.WriteLine("top_image=""" & request("top_image") & """")
    objTextFile.WriteLine("top_imglink=""" & request("top_imglink") & """")
    objTextFile.WriteLine("bbs_list=""" & request("bbs_list") & """")
    objTextFile.WriteLine("upload_yes=""" & request("upload_yes") & """")
    objTextFile.WriteLine("upload_sizemax=""" & request("upload_sizemax") & """")
    objTextFile.WriteLine("online_show=""" & request("online_show") & """")
	objTextFile.WriteLine("lockbbs=""" & request("lockbbs") & """")
	objTextFile.WriteLine("fast_re=""" & request("fast_re") & """")
    objTextFile.WriteLine("max_book=""" & request("max_book") & """")
	objTextFile.WriteLine("max_width=" & request("max_width") & "")
	objTextFile.WriteLine("max_height=" & request("max_height") & "")
	objTextFile.WriteLine("image_width_out=" & request("image_width_out") & "")
	objTextFile.WriteLine("image_width_index=" & request("image_width_index") & "")
	objTextFile.WriteLine("links=""" & request("links") & """")
	objTextFile.WriteLine("picmode_width=" & request("picmode_width") & "")
	objTextFile.WriteLine("picmode_hang=" & request("picmode_hang") & "")
	objTextFile.WriteLine("picmode_lie=" & request("picmode_lie") & "")
	
	'写入结束。
	objTextFile.WriteLine("%" & ">")		

    objTextFile.Close
	Set objTextFile = Nothing
	Set objFSO = Nothing
	 Response.Redirect("admin_pass.asp?max="&max_bookss&"")
end if 
%>
<form name="form1" method="post" action="">
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
  <hr width="600">
  <table width="656" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor="">
    <tr bgcolor=""> 
      <td height="23" colspan="2" ><font color=><b>1.密码和涂鸦板设置 </b></font></td>
    </tr>
    <tr> 
      <td colspan="2"><font color=><b><font color="#FF0000">注意：所有设置中不能包含特殊字符<font color="#009900">&quot;&quot; 
        &lt;&gt; ' %</font> 允许使用下划线。</font></b></font></td>
    </tr>
    <tr> 
      <td width="20%">管理员名</td>
      <td width="80%"> 
        <input type="text" name="nichen" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"size="20" value="<%=nichen%>">
        <font color="#FF0000"> 
        <input type="hidden" name="user_name" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"size="25" value="<%=user_name%>">
        <input type="hidden" name="user_ID" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"size="25" value="<%=user_ID%>">
        既管理登入名</font> </td>
    </tr>
    <tr> 
      <td width="20%">登入密码</td>
      <td width="80%"> 
        <input type="password" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"size="25" value="<%=user_password%>" name="user_password">
      </td>
    </tr>
    <tr> 
      <td colspan="2" height="15" bgcolor="#CCCCCC">涂鸦板设置</td>
    </tr>
    <tr> 
      <td width="20%" height="15">涂鸦板名称</td>
      <td width="80%" height="15"> 
        <input type="text" name="bbs_name"onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" size="25" value="<%=bbs_name%>">
      </td>
    </tr>
    <tr> 
      <td width="20%" height="20">个人主页</td>
      <td width="80%" height="20"> 
        <input type="text" name="adminhomepage" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"value="<%=adminhomepage%>" size="25">
      </td>
    </tr>
    <tr> 
      <td width="20%" height="9">顶部图片</td>
      <td width="80%" height="9"> 
        <input type="text" name="top_image" size="30" value="<%=top_image%>">
      </td>
    </tr>
    <tr> 
      <td width="20%" height="20">顶部图片连接</td>
      <td width="80%" height="20"> 
        <input type="text" name="top_imglink" size="30" value="<%=top_imglink%>">
      </td>
    </tr>
    <tr> 
      <td width="20%" height="32">快速回复</td>
      <td width="80%" height="32"> 
        <input type="radio" name="fast_re" value="1" <%if fast_re="1" then %>checked<%end if %>>
        是 
        <input type="radio" name="fast_re" value="0" <%if fast_re="0" then %>checked<%end if %>>
        否</td>
    </tr>
    <tr> 
      <td width="20%" height="9">写论坛顶部广告</td>
      <td width="80%" height="9"><a href="../admin_new.asp" target="_blank"><b>打开</b></a></td>
    </tr>
    <tr> 
      <td width="20%" height="9">论坛跳转</td>
      <td width="80%" height="9"><a href="jupbbs.asp" target="_blank"><b>打开</b></a></td>
    </tr>
    <tr> 
      <td width="20%" height="9"><b><font color="#006600">最多保存作品（张）</font></b></td>
      <td width="80%" height="9"> 
        <input type="text" name="max_book" size="5" maxlength="9" value="<%=max_book%>">
        ( 超过将自动删除旧的作品！) <font color="#FF0000">备注：被设置精华的作品将不会被自动删除。</font></td>
    </tr>
    <tr> 
      <td width="20%" height="9">每页显示作品</td>
      <td width="80%" height="9"> 
        <input type="text" name="bbs_list" maxlength="2" size="2" value="<%=bbs_list%>">
        <font color="#FF0000">（每页帖子作品数,6-10为最佳数字）</font></td>
    </tr>
    <tr> 
      <td colspan="2" height="12" bgcolor="#CCCCCC">文件控制</td>
    </tr>
    <tr> 
      <td width="20%" height="12">是否允许上传</td>
      <td width="80%" height="12"> 
        <input type="radio" name="upload_yes" value="yes" <%if upload_yes="yes" then %>checked<%end if %>>
        是 
        <input type="radio" name="upload_yes" value="no" <%if upload_yes="no" then %>checked<%end if %>>
        否</td>
    </tr>
    <tr> 
      <td width="20%" height="12">允许上传大小</td>
      <td width="80%" height="12"> 
        <input type="text" name="upload_sizemax" size="3" maxlength="3" value="<%=upload_sizemax%>">
        KB <font color="#FF0000">（范围在50KB-200KB之间）</font></td>
    </tr>
    <tr> 
      <td width="20%" height="12">上传图片最大宽和高</td>
      <td width="80%" height="12"> width 
        <input type="text" name="max_width" size="4" maxlength="3" value="<%=max_width%>">
        height 
        <input type="text" name="max_height" size="4" maxlength="3" value="<%=max_height%>">
        建议宽<font color="#FF0000">500-600</font>数字</td>
    </tr>
    <tr> 
      <td width="20%" height="12">显示图片width小于</td>
      <td width="80%" height="12"> 
        <input type="text" name="image_width_out" size="4" maxlength="3" value="<%=image_width_out%>">
        小于这个数字，图片正常显示，大于这个数字，宽固定这个比例（推荐设置<font color="#FF0000">150-300</font>）</td>
    </tr>
    <tr> 
      <td width="20%" height="12">首页调用图片width</td>
      <td width="80%" height="12"> 
        <input type="text" name="image_width_index" size="4" maxlength="3" value="<%=image_width_index%>">
        建议在<font color="#FF0000">50-100</font>数字</td>
    </tr>
    <tr bgcolor="#CCCCCC"> 
      <td colspan="2" height="12">图片模式设置</td>
    </tr>
    <tr> 
      <td width="20%" height="12">显示图片比例width</td>
      <td width="80%" height="12"> 
        <input type="text" name="picmode_width" size="4" maxlength="4" value="<%=picmode_width%>">
        按照宽为这个数字为显示比例</td>
    </tr>
    <tr> 
      <td width="20%" height="12">行显示/列显示</td>
      <td width="80%" height="12"> 
        <input type="text" name="picmode_hang" size="4" maxlength="4" value="<%=picmode_hang%>">
        幅 
        <input type="text" name="picmode_lie" size="4" maxlength="4" value="<%=picmode_lie%>">
        列</td>
    </tr>
    <tr> 
      <td width="20%" height="12">&nbsp;</td>
      <td width="80%" height="12">&nbsp;</td>
    </tr>
    <tr bgcolor="#CCCCCC"> 
      <td colspan="2" height="12">其他设置</td>
    </tr>
    <tr> 
      <td width="20%" height="12">显示记数器</td>
      <td width="80%" height="12"> 
        <input type="radio" name="online_show" value="yes"<%if online_show="yes" then %>checked<%end if %>>
        是 
        <input type="radio" name="online_show" value="no" <%if online_show="no" then %>checked<%end if %>>
        否 
        <input type="hidden" name="save" value="yes">
      </td>
    </tr>
    <tr> 
      <td width="20%" height="12"> 涂鸦板联盟显示</td>
      <td width="80%" height="12"> 
        <input type="radio" name="links" value="yes" <%if links="yes" then %>checked<%end if %>>
        是 
        <input type="radio" name="links" value="no" <%if links="no" then %>checked<%end if %>>
        否</td>
    </tr>
    <tr> 
      <td width="20%" height="12">锁定涂鸦板</td>
      <td width="80%" height="12"> 
        <input type="radio" name="lockbbs" value="1" <%if lockbbs=1 then %>checked<%end if %>>
        是 
        <input type="radio" name="lockbbs" value="0"  <%if lockbbs=0 then %>checked<%end if %>>
        否 （整理涂鸦板时候使用）</td>
    </tr>
    <tr> 
      <td width="20%" height="12">&nbsp;</td>
      <td width="80%" height="12"> 
        <div align="center"> 
          <input type="submit" name="Submit" value="提交">
        </div>
      </td>
    </tr>
    <tr> 
      <td width="20%" height="12">&nbsp;</td>
      <td width="80%" height="12"> 
        <div align="center"></div>
      </td>
    </tr>
  </table>
</form>
</body>
</html>
<%
user.Close()
%>
