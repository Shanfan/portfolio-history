
<!--#include file="conn.asp" --><%
Response.Buffer = True 
Response.Expires = -1
Response.AddHeader "Pragma", "no-cache"
Response.AddHeader "cache-control", "no-store"
%>
<%
'花费时间=Ctime(timer-startime)
function Ctime(num)
	dim h,m_s,m,s
	h=num\3600
	m_s=num mod 3600
	m=(num mod 3600)\60
	s=m_s mod 60
	Ctime=h&"小时"&m&"分"&s&"秒"
end function
dim timeEnd,timeStart,newTimer,PaintTime
			timeEnd=timer()
			timeStart=Request.QueryString("timeStart")
			newTimer=timeEnd-timeStart
			
			PaintTime=Ctime(newTimer)
%>

<%if request.QueryString("tool")="oekakibbs" and  Request.Cookies("picname") <>"" then
set connGraph=server.CreateObject("ADODB.connection")
connGraph.ConnectionString= MM_paint_STRING
connGraph.Open

picName=Request.Cookies("picname")
oebName=Request.Cookies("oebname")
Pwidth=request.QueryString("w")
Pheight=request.QueryString("h")
username=Request.QueryString("pname")
set rec=server.createobject("ADODB.recordset")
rec.Open "SELECT * FROM [img] ORDER BY imageid DESC",connGraph,1,3

		rec.addnew
		rec("picname")=picName
		rec("oebname")=oebName
	    rec("username")=Server.HTMLEncode(username)
		rec("img_width")=Pwidth
		rec("img_height")=Pheight
		rec("painttime")=PaintTime
		rec("tool")="oekakibbs"
		rec("IP")= request.servervariables("remote_addr")
	    rec.update 
Response.Cookies("IP")=request.servervariables("remote_addr")
Response.Cookies("IP").expires=dateadd("d",365,date())
		
Response.Redirect "write.asp?picname="&picname&""
      	  
rec.close
set rec=nothing
set connGraph=nothing
end if %>





<%if request.QueryString("tool")="paintbbs"  then 
set connGraph=server.CreateObject("ADODB.connection")
connGraph.ConnectionString= MM_paint_STRING
connGraph.Open

picname=Request.QueryString("pic")
oebname=Request.QueryString("pch")
Pwidth=request.QueryString("w")
Pheight=request.QueryString("h")
username=Request.QueryString("pname")

set rec=server.createobject("ADODB.recordset")
rec.Open "SELECT * FROM [img] ORDER BY imageid DESC",connGraph,1,3

		rec.addnew
		rec("picname")=picName
		rec("oebname")=oebName
	    rec("username")=Server.HTMLEncode(username)
		rec("img_width")=Pwidth
		rec("img_height")=Pheight
		rec("painttime")=PaintTime
		rec("tool")="paintbbs"
		rec("IP")= request.servervariables("remote_addr")
	    rec.update
Response.Cookies("IP")=request.servervariables("remote_addr")
Response.Cookies("IP").expires=dateadd("d",365,date())
		
Response.Redirect "write.asp?picname="&picname&""
rec.close
set rec=nothing
set connGraph=nothing
end if %>


<%if request.QueryString("tool")="spainter"  then 
set connGraph=server.CreateObject("ADODB.connection")
connGraph.ConnectionString= MM_paint_STRING
connGraph.Open

picname=Request.QueryString("pic")
oebname=Request.QueryString("pch")
Pwidth=request.QueryString("w")
Pheight=request.QueryString("h")
username=Request.QueryString("pname")
set rec=server.createobject("ADODB.recordset")
rec.Open "SELECT * FROM [img] ORDER BY imageid DESC",connGraph,1,3

		rec.addnew
		rec("picname")=picName
		rec("oebname")=oebName
	    rec("username")=Server.HTMLEncode(username)
		rec("img_width")=Pwidth
		rec("img_height")=Pheight
		rec("painttime")=PaintTime
		rec("tool")="Shi-painter"
		rec("IP")= request.servervariables("remote_addr")
		Response.Cookies("IP").expires=dateadd("d",365,date())
	    rec.update
Response.Cookies("IP")=request.servervariables("remote_addr")		
Response.Redirect "write.asp?picname="&picname&""
rec.close
set rec=nothing
set connGraph=nothing
end if %>





