<!--#include file="user.asp" -->
<!--#include file="conn.asp" -->
<%
if  Request("login")="yes" then 

dim sql
	dim rs
	dim username
	dim password
 	set rs=server.createobject("adodb.recordset")
   username=replace(trim(request("username")),"'","")
	password=replace(trim(Request("password")),"'","")
   edit=Request("edit")
 IF Trim(Replace(Request("username"),"'",""))=nichen and Trim(Replace(Request("password"),"'",""))=user_password Then
    Session("admin_name")=user_name
	  Session("admin_pass")=Request("password")
    Response.Redirect ""&edit&""
 Else
  
   sql="select * from fuadmin where pass='"&password&"' and FUadminname='"&username&"'"
	rs.open sql,MM_paint_STRING,1,1
 	if not(rs.bof and rs.eof) then
 '		if password=rs("pass") then
			session("fuadmin")=  Request.Form("UserName")
            session("fuadminpass")= Request.Form("Password")
                     
			Response.Redirect "index.asp"
 		else
		
		Response.Redirect "?error=admin"
	end if
rs.close
	MM_paint_STRING.close
	set rs=nothing
	set MM_paint_STRING=nothing

   
 End IF

end if 
%>





<%
if Request.QueryString("out")="ture" then 
Session("admin_name")=""
Session("admin_pass")=""
session("fuadmin")=""
session("fuadminpass")=""
Response.Redirect "index.asp"
end if 
%>
<html>
<head>
<title>管理入口</title>
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

<body bgcolor="#FFFFFF" text="#000000">
<div align="center"> </div>
<table width="450" border="0" cellspacing="1" cellpadding="1" align="center" height="326" bgcolor="#336699">
  <tr> 
    <td height="5" bgcolor="#006699">&nbsp;</td>
  </tr>
  <tr>
    <td bgcolor="#FFFFFF">
      <div align="center"> <font color="#FF0000">
        <%if Request.QueryString("error")="admin" then 
Response.Write "<center>用户名或密码错误！</center>"
	end if %>
        </font> </div>
      <form name="admin" method="post" action="login.asp">
        <table width="475" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="111">&nbsp;</td>
            <td width="364"><font color="#FF0000">该入口只允许管理员和版主登入！</font></td>
          </tr>
          <tr> 
            <td width="111"> 
              <div align="right">登入名：</div>
            </td>
            <td width="364"> 
              <input type="text" name="username" size="20" maxlength="30">
            </td>
          </tr>
          <tr> 
            <td width="111"> 
              <div align="right">密码：</div>
            </td>
            <td width="364"> 
              <input type="password" name="password" size="20" maxlength="30">
            </td>
          </tr>
          <tr>
            <td width="111"> 
              <div align="center">执行事件</div>
            </td>
            <td width="364">
              <select name="edit">
                <option value="admin_pass.asp" selected>后台设置</option>
                <option value="index.asp">帖子管理</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="111">&nbsp;</td>
            <td width="364"> 
              <input type="hidden" name="login" value="yes">
            </td>
          </tr>
          <tr> 
            <td width="111">&nbsp;</td>
            <td width="364"> 
              <input type="submit" name="Submit" value="登入">
              <input type="button" name="Submit2" value="返回主页" onClick="MM_goToURL('parent','index.asp');return document.MM_returnValue">
            </td>
          </tr>
        </table>
        <p>&nbsp;</p>
        <p>&nbsp;</p>
      </form>
    </td>
  </tr>
</table>
</body>
</html>
