
<%@LANGUAGE="VBSCRIPT"%>

<!--#include file="../Connections/may_user.asp" -->
<!--#include file="user.asp" -->
<%if Session("admin_name")=user_name or Session("fuadmin")<>"" then %>
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
%><%
if Request.QueryString("top")="no" then 

book("toptime")=book.Fields.Item("posttime").Value
book.update 

Response.write("<br><br><center>操作成功！正在返回......</center>")
Response.write("<script language=javascript>setTimeout(""location.replace('index.asp')"",1000)</script>")
Response.end 

end if 
%>
<%
if    Request.QueryString("top")="yes" then 
book("toptime")="8888-8-11"
book.update 


Response.write("<br><br><center>操作成功！正在返回......</center>")
Response.write("<script language=javascript>setTimeout(""location.replace('index.asp')"",1000)</script>")
Response.end 
end if 
%>

<%
if Request.QueryString("Good")="yes" then 

book("good_Topic")=1
book.update 
Response.write("<br><br><center>操作成功！正在返回......</center>")
Response.write("<script language=javascript>setTimeout(""location.replace('index.asp')"",1000)</script>")
Response.end 
end if 
%>


<%
book.Close()
else 
 Response.Redirect"index.asp"
end if 
%>
