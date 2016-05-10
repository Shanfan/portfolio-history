<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="conn.asp" -->
<!--#include file="color.asp" -->
 <% 
if Request.QueryString("imageID")<>"" then
dim sql 
   Sql = "Delete From img Where imageID="&Request.QueryString("imageID")
set Command1 = Server.CreateObject("ADODB.Command")
Command1.ActiveConnection = MM_paint_STRING
Command1.CommandText = sql
Command1.Execute()

Dim Dirtpath, Filepath
Dim fso, msg

Closes=Request.QueryString("win")

Dirtpath = "picdata/" ' **上传文件目录名
Filepath = Server.Mappath(Dirtpath & Request.QueryString("picname")) 
pchpath = Server.Mappath(Dirtpath & Request.QueryString("pchname"))'** 上传文件名及其绝对路径
Set fso = CreateObject("Scripting.FileSystemObject")
     If (fso.FileExists(Filepath))or (fso.FileExists(pchpath))Then
         '** 判断文件是否存在
         msg = "文件删除操作成功!"
         fso.DeleteFile(Filepath)
		 fso.DeleteFile(pchpath)
         '** 删除上传文件
     Else
         msg = "文件删除操作失败!"
		
     End If
	 if Closes="" then 

Response.write("<br><br><center>操作成功！正在返回......</center>")
Response.write("<script language=javascript>setTimeout(""location.replace('laji.asp')"",1000)</script>")
Response.end 

 end if 
 if Closes="win" then 
  Response.Redirect("laji.asp?my=win")
 end if 
 fso.close
set  fso=nothing
end if 
 %>


 
<%
set Recordset1 = Server.CreateObject("ADODB.Recordset")
Recordset1.ActiveConnection = MM_paint_STRING
Recordset1.Source = "SELECT * FROM img  where timenow<(date()-1) ORDER BY imageID DESC"
Recordset1.CursorType = 0
Recordset1.CursorLocation = 2
Recordset1.LockType = 3
Recordset1.Open()
Recordset1_numRows = 0
%>
<%
Dim Repeat1__numRows
Repeat1__numRows = -1
Dim Repeat1__index
Repeat1__index = 0
Recordset1_numRows = Recordset1_numRows + Repeat1__numRows
%>
<html>
<head>
<title>垃圾箱</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="admin.css" type="text/css">
</head>
<body bgcolor="<%=web_bg%>" text="#000000" background="<%=web_bgimg%>">
<table width="429" border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="<%=td_bor%>">
  <tr> 
    <td bgcolor="<%=titlebg%>">&nbsp;</td>
  </tr>
  <tr> 
    <td bgcolor="<%=bg_color%>"> 
      <div align="center"> 
        <p>垃圾箱<br>
          <br>
          <a href="index.asp">涂鸦板主页</a></p>
        <table width="93%" border="0" cellspacing="1" cellpadding="1">
          <tr> 
            <td>存放被作者丢弃的涂鸦作品和已经上传但是没有发表的作品。<br>
              删除垃圾作品以腾出更多的空间。</td>
          </tr>
        </table>
        <p><br>
          <br>
          <font color="#FF0000"> 
          <% If Recordset1.EOF And Recordset1.BOF Then %>
          没有任何记录！ 
          <% End If ' end Recordset1.EOF And Recordset1.BOF %>
          </font> <br>
        </p>
      </div>
     <% 
While ((Repeat1__numRows <> 0) AND (NOT Recordset1.EOF)) 
%>
      <table width="404" border="0" cellspacing="1" cellpadding="1" align="center" height="11" bgcolor="#CCCCCC">
        <tr> 
          <td width="80%"><%=(Recordset1.Fields.Item("picName").Value)%></td>
          <td width="20%"> <a href="laji.asp?imageID=<%=Recordset1.Fields.Item("imageID").Value %>&picname=<%=(Recordset1.Fields.Item("picName").Value)%>&pchname=<%=(Recordset1.Fields.Item("oebName").Value)%>">删除</a></td>
        </tr>
      </table>
      <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  Recordset1.MoveNext()
Wend
%>
<%if Request.QueryString("my")="win" then %>
<script LANGUAGE="JavaScript">
setTimeout('window.close();', 500); 
</script>
<%end if %>
    </td>
  </tr>
</table>
</body>
</html>
<%
Recordset1.Close()
%>
