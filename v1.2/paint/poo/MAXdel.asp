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
	 Session("ADAHVAV_asdf324")=""
 Response.Redirect("index.asp")
 fso.close
set  fso=nothing
else
 Response.Redirect("flie_del_poss.asp")
end if 
 %>

 