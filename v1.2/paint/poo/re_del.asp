<!--#include file="../Connections/may_user.asp" -->
<!--#include file="user.asp" -->

<%if Session("admin_name")=user_name or  Session("FUadmin")<>"" then %>
 <% 
if Request.QueryString("ID")<>"" or  Request.QueryString("picname")<>"" then
dim sql 
   Sql = "Delete From re Where re_id="&Request.QueryString("ID")
set Command1 = Server.CreateObject("ADODB.Command")
Command1.ActiveConnection = MM_may_user_STRING
Command1.CommandText = sql
Command1.Execute()

Response.write("<br><br><center>操作成功！正在返回......</center>")
Response.write("<script language=javascript>setTimeout(""location.replace('index.asp')"",1000)</script>")
Response.end 
 end if 
 %>
 <%end if %>
 