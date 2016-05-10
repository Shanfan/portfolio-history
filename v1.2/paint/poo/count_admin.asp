<%        dim conn
	dim connstr
	dim db
	db="the1983poobbscade.mdb"
	Set conn = Server.CreateObject("ADODB.Connection")
	connstr="Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" & Server.MapPath(""&db&"")
	conn.Open connstr%>
gg=""
<%'on error resume next
response.expires=0
application.lock
dim style,rs,sql,todaycount,todayipcount,ccount,g,c,i,countlong,todaydate
dim userip,vpage,connip,country,city,tip,sip1,sip2,sip3,sip4,DBPathip,connstrip,ip,screenwidth
dim url1,url2,url,urlview,urlimg
dim cookiepath
url1=request.servervariables("server_name")
url2=request.servervariables("url")
url="http://"&url1&url2
urlimg=replace(url,"count.asp","img")
set rs=server.createobject("adodb.recordset")
sql="select * from cn where id=1"
rs.open sql,conn,3,2
'*************一天一台机子记数一次*************
if request.cookies("dscount")=empty then
response.cookies("dscount")="yes"
rs("count")=rs("count")+1
rs.update
end if
ccount=rs("count")
rs.close
set rs=nothing
conn.close
set conn=nothing
application.unlock
'*******************用图片显示访问总数***********************
g=cstr(ccount)
c=len(g)
countlong=6
if int(c)<int(countlong) then
for i=1 to int(countlong)-int(c)%>
gg=gg+"<img border=0 src=bbsimages/img/0.gif>"
<%
next
end if
for i=1 to c
%>
gg=gg+"<img border=0 src=bbsimages/img/<%=mid(g,i,1)%>.gif>"
<%
next
%>
document.write (gg)
<%'response.write err.description%>
