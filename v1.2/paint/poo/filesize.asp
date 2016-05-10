<%
if Request.QueryString("picname")<>"" then 
Dim objFSO, theFile,picname
    picname=Request.QueryString("picname")
	Set objFSO = CreateObject("Scripting.FileSystemObject")	
	
	set theFile =objfso.Getfile(Server.MapPath("picdata/"&picname))
				
     %>
	<%=theFile.Size%>
	 <%
	Set  theFile = Nothing
Set objFSO = Nothing
end if 
%>
