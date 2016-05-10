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
Response.Write("<font color='#FF0000'><b>警告：</b></font>该空间不支持<font color='#FF0000'><b>FSO</b></font>，建议您放弃使用涂鸦板或者换个支持FSO的空间！ ")
end if 
if  TestObj("Scripting.FileSystemObject") then 
Response.Write("<font size=2>Fso test successfully!</font>")
end if %>