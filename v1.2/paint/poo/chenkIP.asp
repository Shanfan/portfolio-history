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

win2.document.write("<font size='2'>IP=<%=rs("ip")%>的客人在涂鸦板丢弃了一张作品！使用工具:<%=rs("tool")%><br>丢弃时间：<%=rs("timenow")%><br>请自觉删除它，空间有限，请大家珍惜，谢谢合作。<br><a href='laji.asp?imageID=<%=rs("imageID")%>&picname=<%=rs("picName")%>&pchname=<%=rs("oebName")%>&win=win' target='_self'>删除这个图象文件</a>&nbsp;&nbsp; <font color=red>声明：这个IP和你机器的IP完全匹配！</font></font><br><br><img src='picdata/<%=rs("picname")%>'>")

<%else
		
		Response.Write " "
	end if
rs.close
	
	set rs=nothing
end if 
%>
