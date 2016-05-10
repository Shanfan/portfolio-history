
<!--#include file="../Connections/may_user.asp" -->
<% 
if Request.Cookies("del_img_ID_only")<>"" or  Request.Cookies("del_img_ID_pic")<>"" then
dim sql 
   Sql = "Delete From book Where book_id="&Request.Cookies("del_img_ID_only")
   set Command1 = Server.CreateObject("ADODB.Command")
Command1.ActiveConnection = MM_may_user_STRING
Command1.CommandText = sql
Command1.Execute()

Dim Dirtpath, Filepath
Dim fso, msg
Dirtpath = "picdata/" ' **上传文件目录名
Filepath = Server.Mappath(Dirtpath & Request.Cookies("del_img_ID_pic")) 
pchpath = Server.Mappath(Dirtpath & Request.QueryString("del_img_ID_pch"))'** 上传文件名及其绝对路径
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


Response.Cookies("del_img_ID_only")=""
Response.Cookies("del_img_ID_pic")=""

Response.write("<br><br><center>操作成功！正在返回......</center>")
Response.write("<script language=javascript>setTimeout(""location.replace('index.asp')"",1000)</script>")
Response.end 

 fso.close
set  fso=nothing
else
 Response.Redirect("flie_del_poss.asp")
end if 
 %>
 
 