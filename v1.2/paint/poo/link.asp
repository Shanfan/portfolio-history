
      <%

linkf = Server.MapPath("link.ini")
Set fso = CreateObject("Scripting.FileSystemObject")
Set linkf = fso.OpenTextFile(linkf)
dim link(4)
DO While not linkf.AtEndOfStream
	for i = 1 to 4
		if linkf.AtEndOfStream then
			exit for
		else
			link(i)=linkf.Readline
		end if
	next
%>
document.write ("<a href='<%=link(1)%>' target=_blank title='<%=link(3)%>'><img src='<%=link(2)%>' border=0></a>&nbsp;&nbsp;&nbsp;")
<%
Loop
linkf.close
Set fso = nothing
Set linkf = nothing
%>
