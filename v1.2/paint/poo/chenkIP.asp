<!--#include file="../Connections/may_user.asp" -->
<%
	response.expires = 0
	response.expiresabsolute = Now() - 1
	response.addHeader "pragma","no-cache"
	response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
%>
 <%
if Request.Cookies("IP")<>""  then 

 	set rs=server.createobject("adodb.recordset")
   IP=Request.Cookies("IP")
   sql="select * from img where IP='"&IP&"'  ORDER BY imageID DESC"
	rs.open sql,MM_may_user_STRING,1,3
 	if not(rs.bof and rs.eof) then %>
	
var win2=window.open("chenkIP.asp", "", "scrollbars=yes,resizable,height=400,width=400")

win2.document.write("<font size='2'>IP=<%=rs("ip")%>�Ŀ�����Ϳѻ�嶪����һ����Ʒ��ʹ�ù���:<%=rs("tool")%><br>����ʱ�䣺<%=rs("timenow")%><br>���Ծ�ɾ�������ռ����ޣ�������ϧ��лл������<br><a href='laji.asp?imageID=<%=rs("imageID")%>&picname=<%=rs("picName")%>&pchname=<%=rs("oebName")%>&win=win' target='_self'>ɾ�����ͼ���ļ�</a>&nbsp;&nbsp; <font color=red>���������IP���������IP��ȫƥ�䣡</font></font><br><br><img src='picdata/<%=rs("picname")%>'>")

<%else
		
		Response.Write " "
	end if
rs.close
	
	set rs=nothing
end if 
%>
