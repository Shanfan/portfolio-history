
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
Dirtpath = "picdata/" ' **�ϴ��ļ�Ŀ¼��
Filepath = Server.Mappath(Dirtpath & Request.Cookies("del_img_ID_pic")) 
pchpath = Server.Mappath(Dirtpath & Request.QueryString("del_img_ID_pch"))'** �ϴ��ļ����������·��
Set fso = CreateObject("Scripting.FileSystemObject")
     If (fso.FileExists(Filepath))or (fso.FileExists(pchpath))Then
         '** �ж��ļ��Ƿ����
         msg = "�ļ�ɾ�������ɹ�!"
         fso.DeleteFile(Filepath)
		 fso.DeleteFile(pchpath)
         '** ɾ���ϴ��ļ�
     Else
         msg = "�ļ�ɾ������ʧ��!"
		
     End If


Response.Cookies("del_img_ID_only")=""
Response.Cookies("del_img_ID_pic")=""

Response.write("<br><br><center>�����ɹ������ڷ���......</center>")
Response.write("<script language=javascript>setTimeout(""location.replace('index.asp')"",1000)</script>")
Response.end 

 fso.close
set  fso=nothing
else
 Response.Redirect("flie_del_poss.asp")
end if 
 %>
 
 