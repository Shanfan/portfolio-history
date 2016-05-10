<!--#include file="../Connections/may_user.asp" -->
<!--#include file="user.asp" -->

<%if Session("admin_name")=user_name or  Session("FUadmin")<>"" then %>
 <% 
if Request.QueryString("ID")<>"" or  Request.QueryString("picname")<>"" then
dim sql 
   Sql = "Delete From book Where book_id="&Request.QueryString("ID")
set Command1 = Server.CreateObject("ADODB.Command")
Command1.ActiveConnection = MM_may_user_STRING
Command1.CommandText = sql
Command1.Execute()

Dim Dirtpath, Filepath
Dim fso, msg,url
url=Request.QueryString("url")
Dirtpath = "picdata/" ' **上传文件目录名
Filepath = Server.Mappath(Dirtpath & Request.QueryString("picname")) 
pchpath = Server.Mappath(Dirtpath & Request.QueryString("pchname"))'** 上传文件名及其绝对路径
Set fso = CreateObject("Scripting.FileSystemObject")
     If (fso.FileExists(Filepath))or (fso.FileExists(pchpath))Then
         '** 判断文件是否存在
         msg = "文件删除操作成功!"
         fso.DeleteFile(Filepath)
		 fso.DeleteFile(pchpath)
         '** 删除上传文件
     Else
         msg = "文件删除操作失败!"
		
     End If
if url="" then 

Response.write("<br><br><center>操作成功！正在返回......</center>")
Response.write("<script language=javascript>setTimeout(""location.replace('index.asp')"",1000)</script>")
Response.end 
 end if 
 if url<>"" then 
 
Response.write("<br><br><center>操作成功！正在返回......</center>")
Response.write("<script language=javascript>setTimeout(""location.replace('"&url&"')"",1000)</script>")
Response.end 
 'Response.Redirect(""&url&"")
 end if 
 
 fso.close
set  fso=nothing
else
 Response.Redirect("flie_del_poss.asp")
end if 
 %>
 <%end if %>

 