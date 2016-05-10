<!--#include file="../Connections/may_user.asp" -->
 <% 
if Session("ADAHVAV_asdf324")="ture" then
dim sql 
   Sql = "Delete From book Where book_id="&Request.QueryString("delid")
set Command1 = Server.CreateObject("ADODB.Command")
Command1.ActiveConnection = MM_may_user_STRING
Command1.CommandText = sql
Command1.Execute()

Dim Dirtpath, Filepath
Dim fso, msg
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
	 Session("ADAHVAV_asdf324")=""
 Response.Redirect("index.asp")
 fso.close
set  fso=nothing
else
 Response.Redirect("flie_del_poss.asp")
end if 
 %>

 