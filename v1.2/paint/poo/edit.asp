<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/may_user.asp" -->
<!--#include file="user.asp" -->
<!--#include file="color.asp" -->
<%
Dim book__MMColParam
book__MMColParam = "1"
if (Request.QueryString("book_ID") <> "") then book__MMColParam = Request.QueryString("book_ID")
%>
<%
set book = Server.CreateObject("ADODB.Recordset")
book.ActiveConnection = MM_may_user_STRING
book.Source = "SELECT * FROM book WHERE book_ID = " + Replace(book__MMColParam, "'", "''") + ""
book.CursorType = 0
book.CursorLocation = 2
book.LockType = 3
book.Open()
book_numRows = 0 

%>
<%if Request.form("MM_insert")="true"  and Request.form("edit")="del" then
dim edit,pass
dim ckpass
dim ID,picname
dim pchname

edit=Request.form("edit")
pass=Request.form("pass")
ckpass=book.Fields.Item("pass").Value

ID=book.Fields.Item("book_ID").Value
picname=book.Fields.Item("picname").Value
pchname=book.Fields.Item("pchname").Value
if Server.HTMLEncode(pass)=ckpass or pass=user_password then 
Response.Cookies("guest_pass")=pass
Response.Cookies("del_img_ID_only")=ID
Response.Cookies("del_img_ID_pic")=picname
Response.Redirect("file_del_poss.asp?del_img_ID_pch="&pchname&"")

Else
 Server.HTMLEncode(pass)<>ckpass  
call errormsg()


end if 
 end if 
 %>
<%if  Request.form("MM_insert")="true" and Request.form("edit")="save" or Request.form("edit")="saveas" then
edit=Request.form("edit")
pass=Request.form("pass")
ckpass=book.Fields.Item("pass").Value

ID=book.Fields.Item("book_ID").Value
picname=book.Fields.Item("picname").Value
pchname=book.Fields.Item("pchname").Value
tool=book.Fields.Item("use_tool").Value
if tool="upload" then tool=book("uploadpaint") end if 
if Server.HTMLEncode(pass)=ckpass or pass=user_password then 
Response.Cookies("guest_pass")=pass
Response.Cookies("pic_ID")=ID
 Response.Redirect("edit_paint.asp?edit="&edit&"&tool="&tool&"")
 

Else
 Server.HTMLEncode(pass)<>ckpass  
call errormsg()


end if 
 end if 
 %>
<%if Request.form("MM_insert")="true"  and Request.form("edit")="txt" then

pass=Request.form("pass")
ckpass=user_password

ID=book.Fields.Item("book_ID").Value

if Server.HTMLEncode(pass)=ckpass  then 
Response.Cookies("guest_pass")=pass
Response.Cookies("del_img_ID_only")=ID
Response.Redirect("file_del_poss.asp")

Else
 Server.HTMLEncode(pass)<>ckpass  
call errormsg()


end if 
 end if 
 %>
<html>
<head>
<title>操作</title>
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
<%SUB errormsg()%>
<center>
  <font color="#FF0000">不能完成操作，你的密码不正确！</font> 
</center>
<%end SUB %>
<div align="center"> <font color="#FF0000"> </font></div>
<table width="600" border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="<%=td_bor%>">
  <tr> 
    <td bgcolor="<%=titlebg%>">&nbsp;</td>
  </tr>
  <tr> 
    <td bgcolor="<%=bg_color%>" height="411" valign="top"> 
      <form name="form1" method="post" action="">
        <table width="600" border="0" cellspacing="1" cellpadding="1">
          <tr> 
            <td colspan="3"> 
              <div align="center"> 
                <%if book.Fields.Item("picname").Value<>""  then %>
                <img src="picdata/<%=(book.Fields.Item("picname").Value)%>"> 
                <%end if %>
              </div>
            </td>
          </tr>
          <tr> 
            <td width="135"></td>
            <td colspan="2">作者：<%=(book.Fields.Item("name").Value)%></td>
          </tr>
          <tr> 
            <td width="135"></td>
            <td width="213">作品类型：<%=(book.Fields.Item("use_tool").Value)%></td>
            <td width="242">发表时间：<%=(book.Fields.Item("posttime").Value)%></td>
          </tr>
          <tr bgcolor="#DCE4E7"> 
            <td colspan="3" height="20"> 
              <div align="left">执行操作命令：</div>
            </td>
          </tr>
          <tr> 
            <td width="135"></td>
            <td colspan="2"> 
              <%if book.Fields.Item("pchname").Value<>"" then %>
              <input type="radio" name="edit" value="save" checked>
              继续绘画（覆盖原来作品） 
              <%end if %>
            </td>
          </tr>
          <tr> 
            <td width="135"></td>
            <td colspan="2"> 
              <%if book.Fields.Item("pchname").Value<>"" then %>
              <input type="radio" name="edit" value="saveas">
              继续绘画（保留原作，另存为新作品） 
              <%end if %>
            </td>
          </tr>
          <tr> 
            <td width="135">&nbsp;</td>
            <td colspan="2"> 
              <input type="radio" name="edit" value="<%if book.Fields.Item("use_tool").Value<>"文本"  then %>del<%end if %><%if book.Fields.Item("use_tool").Value="文本"  then %>txt<%end if %>" <%if book.Fields.Item("use_tool").Value="upload" or book.Fields.Item("use_tool").Value="文本"  then %> checked<%end if%>>
              删除帖子和作品。 </td>
          </tr>
          <tr> 
            <td width="135">&nbsp;</td>
            <td colspan="2"><img src="../bbsimages/1.gif" width="12" height="12"> 
              操作密码 
              <input type="password" name="pass" size="15" maxlength="20" value="<%=Request.Cookies("guest_pass")%>">
            </td>
          </tr>
          <tr> 
            <td width="135">&nbsp;</td>
            <td colspan="2"> </td>
          </tr>
          <tr> 
            <td width="135">&nbsp;</td>
            <td colspan="2"> 
              <input type="submit" name="Submit" value="执行">
              <input type="button" name="Submit2" value="返回" onClick="MM_goToURL('parent','javascript:history.back(1)');return document.MM_returnValue">
              <input type="hidden" name="MM_insert" value="true">
            </td>
          </tr>
          <tr> 
            <td width="135">&nbsp;</td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr> 
            <td colspan="3"> 
              <div align="center">注意：必须输入正确的作品保护密码或者管理员密码执行操作！</div>
            </td>
          </tr>
          <tr> 
            <td colspan="3"> 
              <div align="center">Cookies将记录正确的操作密码！</div>
            </td>
          </tr>
        </table>
        <p>&nbsp;</p>
      </form>
    </td>
  </tr>
</table>
</body>
</html>
<%
book.Close()
%>
