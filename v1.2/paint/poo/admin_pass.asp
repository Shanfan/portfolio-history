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
 Response.Redirect("admin_pass.asp?���óɹ���")
end if
%>
<html>
<head>
<title>��̨����</title>
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
	'fsoд������
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
	
	'д�������
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
        <div align="center"><a href="admin_pass.asp">��������</a></div>
      </td>
      <td height="25"> 
        <div align="center"><a href="admin_color.asp">��ɫ����</a></div>
      </td>
      <td height="25"> 
        <div align="center"><a href="admin_add.asp">���Ӱ���</a></div>
      </td>
      <td height="25"> 
        <div align="center"><a href="index.asp">���ӹ���</a></div>
      </td>
      <td height="25"> 
        <div align="center"><a href="admin_killip.asp">����IP</a></div>
      </td>
      <td height="25"> 
        <div align="center"><a href="admin_link.asp">��̳����</a></div>
      </td>
      <td height="25"> 
        <div align="center"><a href="login.asp?out=ture">�˳�����</a></div>
      </td>
      <td height="25"> 
        <div align="center"><a href="admin_new.asp">��д����</a></div>
      </td>
    </tr>
  </table>
  <hr width="600">
  <table width="656" border="0" cellspacing="1" cellpadding="3"  align=center bordercolor="">
    <tr bgcolor=""> 
      <td height="23" colspan="2" ><font color=><b>1.�����Ϳѻ������ </b></font></td>
    </tr>
    <tr> 
      <td colspan="2"><font color=><b><font color="#FF0000">ע�⣺���������в��ܰ��������ַ�<font color="#009900">&quot;&quot; 
        &lt;&gt; ' %</font> ����ʹ���»��ߡ�</font></b></font></td>
    </tr>
    <tr> 
      <td width="20%">����Ա��</td>
      <td width="80%"> 
        <input type="text" name="nichen" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"size="20" value="<%=nichen%>">
        <font color="#FF0000"> 
        <input type="hidden" name="user_name" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"size="25" value="<%=user_name%>">
        <input type="hidden" name="user_ID" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"size="25" value="<%=user_ID%>">
        �ȹ��������</font> </td>
    </tr>
    <tr> 
      <td width="20%">��������</td>
      <td width="80%"> 
        <input type="password" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"size="25" value="<%=user_password%>" name="user_password">
      </td>
    </tr>
    <tr> 
      <td colspan="2" height="15" bgcolor="#CCCCCC">Ϳѻ������</td>
    </tr>
    <tr> 
      <td width="20%" height="15">Ϳѻ������</td>
      <td width="80%" height="15"> 
        <input type="text" name="bbs_name"onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;" size="25" value="<%=bbs_name%>">
      </td>
    </tr>
    <tr> 
      <td width="20%" height="20">������ҳ</td>
      <td width="80%" height="20"> 
        <input type="text" name="adminhomepage" onKeyPress="if (event.keyCode==34 || event.keyCode==39) event.returnValue = false;"value="<%=adminhomepage%>" size="25">
      </td>
    </tr>
    <tr> 
      <td width="20%" height="9">����ͼƬ</td>
      <td width="80%" height="9"> 
        <input type="text" name="top_image" size="30" value="<%=top_image%>">
      </td>
    </tr>
    <tr> 
      <td width="20%" height="20">����ͼƬ����</td>
      <td width="80%" height="20"> 
        <input type="text" name="top_imglink" size="30" value="<%=top_imglink%>">
      </td>
    </tr>
    <tr> 
      <td width="20%" height="32">���ٻظ�</td>
      <td width="80%" height="32"> 
        <input type="radio" name="fast_re" value="1" <%if fast_re="1" then %>checked<%end if %>>
        �� 
        <input type="radio" name="fast_re" value="0" <%if fast_re="0" then %>checked<%end if %>>
        ��</td>
    </tr>
    <tr> 
      <td width="20%" height="9">д��̳�������</td>
      <td width="80%" height="9"><a href="../admin_new.asp" target="_blank"><b>��</b></a></td>
    </tr>
    <tr> 
      <td width="20%" height="9">��̳��ת</td>
      <td width="80%" height="9"><a href="jupbbs.asp" target="_blank"><b>��</b></a></td>
    </tr>
    <tr> 
      <td width="20%" height="9"><b><font color="#006600">��ౣ����Ʒ���ţ�</font></b></td>
      <td width="80%" height="9"> 
        <input type="text" name="max_book" size="5" maxlength="9" value="<%=max_book%>">
        ( �������Զ�ɾ���ɵ���Ʒ��) <font color="#FF0000">��ע�������þ�������Ʒ�����ᱻ�Զ�ɾ����</font></td>
    </tr>
    <tr> 
      <td width="20%" height="9">ÿҳ��ʾ��Ʒ</td>
      <td width="80%" height="9"> 
        <input type="text" name="bbs_list" maxlength="2" size="2" value="<%=bbs_list%>">
        <font color="#FF0000">��ÿҳ������Ʒ��,6-10Ϊ������֣�</font></td>
    </tr>
    <tr> 
      <td colspan="2" height="12" bgcolor="#CCCCCC">�ļ�����</td>
    </tr>
    <tr> 
      <td width="20%" height="12">�Ƿ������ϴ�</td>
      <td width="80%" height="12"> 
        <input type="radio" name="upload_yes" value="yes" <%if upload_yes="yes" then %>checked<%end if %>>
        �� 
        <input type="radio" name="upload_yes" value="no" <%if upload_yes="no" then %>checked<%end if %>>
        ��</td>
    </tr>
    <tr> 
      <td width="20%" height="12">�����ϴ���С</td>
      <td width="80%" height="12"> 
        <input type="text" name="upload_sizemax" size="3" maxlength="3" value="<%=upload_sizemax%>">
        KB <font color="#FF0000">����Χ��50KB-200KB֮�䣩</font></td>
    </tr>
    <tr> 
      <td width="20%" height="12">�ϴ�ͼƬ����͸�</td>
      <td width="80%" height="12"> width 
        <input type="text" name="max_width" size="4" maxlength="3" value="<%=max_width%>">
        height 
        <input type="text" name="max_height" size="4" maxlength="3" value="<%=max_height%>">
        �����<font color="#FF0000">500-600</font>����</td>
    </tr>
    <tr> 
      <td width="20%" height="12">��ʾͼƬwidthС��</td>
      <td width="80%" height="12"> 
        <input type="text" name="image_width_out" size="4" maxlength="3" value="<%=image_width_out%>">
        С��������֣�ͼƬ������ʾ������������֣���̶�����������Ƽ�����<font color="#FF0000">150-300</font>��</td>
    </tr>
    <tr> 
      <td width="20%" height="12">��ҳ����ͼƬwidth</td>
      <td width="80%" height="12"> 
        <input type="text" name="image_width_index" size="4" maxlength="3" value="<%=image_width_index%>">
        ������<font color="#FF0000">50-100</font>����</td>
    </tr>
    <tr bgcolor="#CCCCCC"> 
      <td colspan="2" height="12">ͼƬģʽ����</td>
    </tr>
    <tr> 
      <td width="20%" height="12">��ʾͼƬ����width</td>
      <td width="80%" height="12"> 
        <input type="text" name="picmode_width" size="4" maxlength="4" value="<%=picmode_width%>">
        ���տ�Ϊ�������Ϊ��ʾ����</td>
    </tr>
    <tr> 
      <td width="20%" height="12">����ʾ/����ʾ</td>
      <td width="80%" height="12"> 
        <input type="text" name="picmode_hang" size="4" maxlength="4" value="<%=picmode_hang%>">
        �� 
        <input type="text" name="picmode_lie" size="4" maxlength="4" value="<%=picmode_lie%>">
        ��</td>
    </tr>
    <tr> 
      <td width="20%" height="12">&nbsp;</td>
      <td width="80%" height="12">&nbsp;</td>
    </tr>
    <tr bgcolor="#CCCCCC"> 
      <td colspan="2" height="12">��������</td>
    </tr>
    <tr> 
      <td width="20%" height="12">��ʾ������</td>
      <td width="80%" height="12"> 
        <input type="radio" name="online_show" value="yes"<%if online_show="yes" then %>checked<%end if %>>
        �� 
        <input type="radio" name="online_show" value="no" <%if online_show="no" then %>checked<%end if %>>
        �� 
        <input type="hidden" name="save" value="yes">
      </td>
    </tr>
    <tr> 
      <td width="20%" height="12"> Ϳѻ��������ʾ</td>
      <td width="80%" height="12"> 
        <input type="radio" name="links" value="yes" <%if links="yes" then %>checked<%end if %>>
        �� 
        <input type="radio" name="links" value="no" <%if links="no" then %>checked<%end if %>>
        ��</td>
    </tr>
    <tr> 
      <td width="20%" height="12">����Ϳѻ��</td>
      <td width="80%" height="12"> 
        <input type="radio" name="lockbbs" value="1" <%if lockbbs=1 then %>checked<%end if %>>
        �� 
        <input type="radio" name="lockbbs" value="0"  <%if lockbbs=0 then %>checked<%end if %>>
        �� ������Ϳѻ��ʱ��ʹ�ã�</td>
    </tr>
    <tr> 
      <td width="20%" height="12">&nbsp;</td>
      <td width="80%" height="12"> 
        <div align="center"> 
          <input type="submit" name="Submit" value="�ύ">
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
