          <%
Function TestObj(Str)
On Error Resume Next
TestObj = False
Err.Description = ""
Set TObj = Server.CreateObject(Str)
If Err.Description = "" Then TestObj = True
Set TObj = Nothing
End Function
if not TestObj("Scripting.FileSystemObject") then
Response.Write("<font color='#FF0000'><b>���棺</b></font>�ÿռ䲻֧��<font color='#FF0000'><b>FSO</b></font>������������ʹ��Ϳѻ����߻���֧��FSO�Ŀռ䣡 ")
end if 
if  TestObj("Scripting.FileSystemObject") then 
Response.Write("<font size=2>Fso test successfully!</font>")
end if %>