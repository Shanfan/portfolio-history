<%@LANGUAGE="VBSCRIPT"%> 
<!--#include file="../Connections/may_user.asp" -->
<!--#include file="user.asp" -->
<!--#include file="color.asp" -->
<%
Dim Recordset1__MMColParam
Recordset1__MMColParam = "1"
if (Request.QueryString("book_ID") <> "") then Recordset1__MMColParam = Request.QueryString("book_ID")
%>
<%
set Recordset1 = Server.CreateObject("ADODB.Recordset")
Recordset1.ActiveConnection = MM_may_user_STRING
Recordset1.Source = "SELECT * FROM book WHERE book_ID = " + Replace(Recordset1__MMColParam, "'", "''") + ""
Recordset1.CursorType = 0
Recordset1.CursorLocation = 2
Recordset1.LockType = 3
Recordset1.Open()
Recordset1_numRows = 0
P=Recordset1.Fields.Item("pchname").Value
w=Recordset1.Fields.Item("pic_W").Value
h=Recordset1.Fields.Item("pic_h").Value
%>
<%
	response.expires = 0
%>
<HTML>
<HEAD>
<META HTTP-EQUIV="Content-type" CONTENT="text/html; charset=GB2312">
<TITLE>回放过程 ----<%=bbs_name%></TITLE>
<STYLE type="text/css">
<!--
.fm { background: #ffffff;  color: #FFCC00; font-size: 10pt;border:1;border-color:#ffffff;border-style: solid}
a { text-decoration:none; }
td {  font-size: 12px; font-family: "Verdana", "Arial", "Helvetica", "sans-serif"; color: #333333}
-->
</STYLE>
</HEAD>
<BODY BGCOLOR="<%=web_bg%>" LINK="003366" VLINK="003366" ALINK="003366" background="<%=web_bgimg%>" >
<center>
  <table width="100%" border="0">
    <tr> 
      <td> 
        <div align="center"> 
          <%if Request.QueryString("tool")="oekakibbs" then %>
          <applet	code=a.p.class
	codebase="../"
	archive=oekakibbs.jar
	width=<%=w+5%>
	height=<%=h+40%> border="1">
            <param name="popup" value="0">
            <param name="anime" value="2">
            <param name="readanm" value="<%=p%>">
            <param name="readanmpath" value="picdata/">
            <param name="animeplay" value="0">
            <param name="width" value="<%=w%>">
            <param name="height" value="<%=h%>">
            <param name="pwidth" value="<%=w%>">
            <param name="pheight" value="<%=h%>">
            <param name="picw" value="<%=w%>">
            <param name="pich" value="<%=h%>">
            <param name="baseC" value="CAE3EE">
            <param name="brightC" value="FAFAFA">
            <param name="darkC" value="cccccc">
            <param name="backC" value="bbbbbb">
            <param name="buffer_canvas" value="true">
          </applet> 
          <%end if %>
          <%if Request.QueryString("tool")="paintbbs" then %>
          <applet height=<%=h+20%>  


 archive=PCHViewer.jar width=<%=w%>  
code=pch.PCHViewer.class border=1 name=pch codebase="../">
            <param name="speed" value="1">
            <param name="image_width" value="<%=w%>">
            <param name="image_height" value="<%=h%>">
            <param name="pch_file" value="<%=user_name%>/picdata/<%=p%>">
            <param name="run" value="true">
            <param name="color_text" value="#000000">
            <param name="color_back" value="#CCCCFF">
            <param name="color_icon" value="#9999FF">
            <param name="color_bar" value="#6666FF">
            <param name="color_bar_select" value="#ffffff">
            <param name="buffer_progress" value="true">
            <param name="buffer_canvas" value="true">
          </applet> 
          <%end if %>
          <%if Request.QueryString("tool")="Shi-painter" then %>
          <applet name="pch"
 code="pch2.PCHViewer.class"
 archive="SPCHViewer.jar"
 width="<%=w%>"
 height="<%=h+20%>" codebase="../" 
>
            <param name="speed" value="-1">
            <param name="pch_file" value="<%=user_name%>/picdata/<%=p%>">
            <param name="buffer_progress" value="false">
            <param name="buffer_canvas" value="false">
            <!--偙偺曈偼偍奊偐偒僣乕儖偲摨偠條側愝掕丅-->
            <param name="res.zip" value="./res/res.zip">
            <param name="tt.zip" value="./res/tt.zip"

>
            <param name=tt_size value=31>
            <param name=image_width value="<%=w%>">
            <param name=image_height value="<%=h%>">
          </applet> 
          <%end if %>
        </div>
      </td>
    </tr>
    <tr> 
      <td> 
        <div align="center">请点▲开始播放</div>
      </td>
    </tr>
    <tr> 
      <td> 
        <div align="center"> 实际尺寸:<%=w&"×"&h%>, 大小:<%
Function TestObj(Str)
On Error Resume Next
TestObj = False
Err.Description = ""
Set TObj = Server.CreateObject(Str)
If Err.Description = "" Then TestObj = True
Set TObj = Nothing
End Function
%>
              <%if  TestObj("Scripting.FileSystemObject") then
if p<>"" then 
Dim objFSO, theFile,picname
    picname=p
	Set objFSO = CreateObject("Scripting.FileSystemObject")
	
	Filepath =Server.MapPath("picdata/"&picname)	
If (objFSO.FileExists(Filepath))Then
	
	set theFile =objfso.Getfile(Server.MapPath("picdata/"&picname))
				
    Response.write(""&formatnumber(theFile.Size/1024,2,-1)&"")
else   

Response.write("0")
	 end if 
	Set  theFile = Nothing
Set objFSO = Nothing
end if 
end if 
%>
          KB</div>
      </td>
    </tr>
    <tr> 
      <td>&nbsp;</td>
    </tr>
  </table>
  <table width="100%" border="0">
    <tr> 
      <td height="52"> 
        <div align="center"> </div>
      </td>
    </tr>
  </table>
  <p align="left"><br>
    <BR>
  </p>
</center>
<P> 
</BODY>
</HTML>
<%
Recordset1.Close()
%>
