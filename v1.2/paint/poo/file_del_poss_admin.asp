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
Dirtpath = "picdata/" ' **�ϴ��ļ�Ŀ¼��
Filepath = Server.Mappath(Dirtpath & Request.QueryString("picname")) 
pchpath = Server.Mappath(Dirtpath & Request.QueryString("pchname"))'** �ϴ��ļ����������·��
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
if url="" then 

Response.write("<br><br><center>�����ɹ������ڷ���......</center>")
Response.write("<script language=javascript>setTimeout(""location.replace('index.asp')"",1000)</script>")
Response.end 
 end if 
 if url<>"" then 
 
Response.write("<br><br><center>�����ɹ������ڷ���......</center>")
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

 