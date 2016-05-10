
<%@ LANGUAGE="VBSCRIPT" %>
<!-- #include file="color.asp" -->
<!--#include file="user.asp" -->
<%

if Session("admin_name")<>user_name or  Session("admin_pass")<>user_password then 
Response.Redirect "login.asp"
end if 
%>
<%
if Request.form("save")="yes" then 
Dim objFSO, objTextFile
	Set objFSO = CreateObject("Scripting.FileSystemObject")	
	Set objTextFile = objFSO.CreateTextFile(Server.MapPath("color.asp"),TRUE)
		
	objTextFile.WriteLine("<" & "%")
	'fso写入设置
	objTextFile.WriteLine("  td_bor=""" & request("td_bor") & """")
	objTextFile.WriteLine("  bg_color=""" & request("bg_color") & """")
	objTextFile.WriteLine("  titlebg=""" & request("titlebg") & """")
    objTextFile.WriteLine("  title_td=""" & request("title_td") & """")

	objTextFile.WriteLine("  re_tbg=""" & request("re_tbg") & """")
	objTextFile.WriteLine("  re_bg=""" & request("re_bg") & """")
	objTextFile.WriteLine("  title_img=""" & request("title_img") & """")
	objTextFile.WriteLine("  t_bgimg=""" & request("t_bgimg") & """")
	objTextFile.WriteLine("  ta_bor=""" & request("ta_bor") & """")
	objTextFile.WriteLine("   a_w=""" & request("ta_w") & """")
	'web color
	objTextFile.WriteLine("  web_bg=""" & request("web_bg") & """")
	objTextFile.WriteLine("  web_td=""" & request("web_td") & """")
	objTextFile.WriteLine("  web_a=""" & request("web_a") & """")
	objTextFile.WriteLine("  web_a2=""" & request("web_a2") & """")
	objTextFile.WriteLine("  web_link=""" & request("web_link") & """")
	objTextFile.WriteLine("  web_bgimg=""" & request("web_bgimg") & """")


	objTextFile.WriteLine("  font_size=""" & request("font_size") & """")
	'input
	objTextFile.WriteLine("  input_bg=""" & request("input_bg") & """")
	objTextFile.WriteLine("  input_td=""" & request("input_td") & """")
    objTextFile.WriteLine("  table=""" & request("table") & """")
	
	'写入结束。pbver
	objTextFile.WriteLine("%" & ">")		

    objTextFile.Close
	Set objTextFile = Nothing
	Set objFSO = Nothing
		 Response.Redirect("admin_color.asp?设置成功")
	end if 
%><html>
<head>
<title>色彩风格设置</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<script language="JavaScript">
<!--
function MM_openBrWindow(theURL,winName,features) { //v2.0
  window.open(theURL,winName,features);
}
//-->
</script>
<link rel="stylesheet" href="admin.css" type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<form name="form1" method="post" action="admin_color.asp">
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
  <table width="494" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor="">
    <tr> 
      <td width="23%"><b>1.表格<font color=><b>配色</b></font><font color=><b>方案</b></font></b></td>
      <td width="29%"> <a href="javascript:;" onClick="MM_openBrWindow('../colorget/color_set.htm','color','width=430,height=430')">打开色彩调节器</a></td>
      <td width="48%"><a href="index.asp" target="_blank">预览效果</a></td>
    </tr>
    <tr> 
      <td width="23%">表格边框色</td>
      <td width="29%" bgcolor="<%=td_bor%>"> 
        <input type="text" name="td_bor" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" size="10" value="<%=td_bor%>" maxlength="7">
      </td>
      <td width="48%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="23%">表格背景色</td>
      <td width="29%" bgcolor="<%=bg_color%>"> 
        <input type="text" name="bg_color" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"size="10" value="<%=bg_color%>" maxlength="7">
      </td>
      <td width="48%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="23%"><font color="#0066CC">标题背景色</font></td>
      <td width="29%" bgcolor="<%=titlebg%>"> 
        <input type="text" name="titlebg" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"size="10" value="<%=titlebg%>" maxlength="7">
      </td>
      <td width="48%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="23%">标题文字色</td>
      <td width="29%" bgcolor="<%=title_td%>"> 
        <input type="text" name="title_td"onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" size="10" value="<%=title_td%>" maxlength="7">
      </td>
      <td width="48%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="23%">表格大小</td>
      <td width="29%" bgcolor="<%=re_text%>"> 
        <input type="text" name="table"onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" size="10" value="<%=table%>" maxlength="7">
      </td>
      <td width="48%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="23%"><font color="#003399">回复边框色</font></td>
      <td width="29%" bgcolor="<%=re_tbg%>"> 
        <input type="text" name="re_tbg"onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" value="<%=re_tbg%>" size="10" maxlength="7">
      </td>
      <td width="48%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="23%"><font color="#003399">回复背景色</font></td>
      <td width="29%" bgcolor="<%=re_bg%>"> 
        <input type="text" name="re_bg"onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" value="<%=re_bg%>" size="10" maxlength="7">
      </td>
      <td width="48%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="23%">&nbsp;</td>
      <td width="29%">&nbsp;</td>
      <td width="48%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="23%"><b>2.网页色彩设置</b></td>
      <td width="29%">&nbsp; </td>
      <td width="48%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="23%">网页背景色</td>
      <td width="29%" bgcolor="<%=web_bg%>"> 
        <input type="text" name="web_bg"onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" value="<%=web_bg%>" size="10" maxlength="7">
      </td>
      <td width="48%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="23%">网页文字色</td>
      <td width="29%" bgcolor="<%=web_td%>"> 
        <input type="text" name="web_td"onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" value="<%=web_td%>" size="10" maxlength="7">
      </td>
      <td width="48%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="23%">连接色彩</td>
      <td width="29%" bgcolor="<%=web_a%>"> 
        <input type="text" name="web_a"onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" value="<%=web_a%>" size="10" maxlength="7">
      </td>
      <td width="48%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="23%">鼠标移过色彩</td>
      <td width="29%" bgcolor="<%=web_a2%>"> 
        <input type="text" name="web_a2"onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" value="<%=web_a2%>" size="10" maxlength="7">
      </td>
      <td width="48%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="23%">网页背景图片</td>
      <td width="29%"> 
        <input type="text" name="web_bgimg"onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" value="<%=web_bgimg%>" size="20">
      </td>
      <td width="48%">&nbsp; </td>
    </tr>
    <tr> 
      <td width="23%" height="19">&nbsp;</td>
      <td width="29%" height="19">&nbsp; </td>
      <td width="48%" height="19">&nbsp;</td>
    </tr>
    <tr> 
      <td width="23%">&nbsp;</td>
      <td width="29%" bgcolor="<%=input_td%>">&nbsp; 
      </td>
      <td width="48%"> 
        <input type="hidden" name="save" value="yes">
      </td>
    </tr>
    <tr> 
      <td width="23%">&nbsp;</td>
      <td width="29%"> 
        <div align="center"> 
          <input type="submit" name="Submit" value="提 交">
        </div>
      </td>
      <td width="48%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="23%">&nbsp;</td>
      <td width="29%"> 
        <div align="center"></div>
      </td>
      <td width="48%">&nbsp;</td>
    </tr>
  </table>
</form>
</body>
</html>
