<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/may_user.asp" -->
<!--#include file="user.asp" -->
<%
Dim book__MMColParam
book__MMColParam = "1"
if (Request.QueryString("book_ID") <> "") then book__MMColParam = Request.QueryString("book_ID")
%>
<%
set book = Server.CreateObject("ADODB.Recordset")
book.ActiveConnection = MM_may_user_STRING
book.Source = "SELECT * FROM book WHERE book_ID = " + Replace(book__MMColParam, "'", "''") + ""
book.CursorType = 0
book.CursorLocation = 2
book.LockType = 3
book.Open()
book_numRows = 0
%>
<%
' *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

' create the list of parameters which should not be maintained
MM_removeList = "&index="
If (MM_paramName <> "") Then MM_removeList = MM_removeList & "&" & MM_paramName & "="
MM_keepURL="":MM_keepForm="":MM_keepBoth="":MM_keepNone=""

' add the URL parameters to the MM_keepURL string
For Each Item In Request.QueryString
  NextItem = "&" & Item & "="
  If (InStr(1,MM_removeList,NextItem,1) = 0) Then
    MM_keepURL = MM_keepURL & NextItem & Server.URLencode(Request.QueryString(Item))
  End If
Next

' add the Form variables to the MM_keepForm string
For Each Item In Request.Form
  NextItem = "&" & Item & "="
  If (InStr(1,MM_removeList,NextItem,1) = 0) Then
    MM_keepForm = MM_keepForm & NextItem & Server.URLencode(Request.Form(Item))
  End If
Next

' create the Form + URL string and remove the intial '&' from each of the strings
MM_keepBoth = MM_keepURL & MM_keepForm
if (MM_keepBoth <> "") Then MM_keepBoth = Right(MM_keepBoth, Len(MM_keepBoth) - 1)
if (MM_keepURL <> "")  Then MM_keepURL  = Right(MM_keepURL, Len(MM_keepURL) - 1)
if (MM_keepForm <> "") Then MM_keepForm = Right(MM_keepForm, Len(MM_keepForm) - 1)

' a utility function used for adding additional parameters to these strings
Function MM_joinChar(firstItem)
  If (firstItem <> "") Then
    MM_joinChar = "&"
  Else
    MM_joinChar = ""
  End If
End Function
%>
<html>
<head>
<title><%=(book.Fields.Item("title").Value)%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="CSS.asp" type="text/css">
</head>
<body bgcolor="#CCCCCC" text="#000000">
<%
					  
						'---判断高
						dim x1 
						if book("pic_w")>image_width_out then 
						x1=book("pic_w")-image_width_out '100
					    h1=book("pic_h")-x1
						else h1=book("pic_h")
						end if 
						
						if Book("pic_w")<image_width_out and  Book("pic_h")<image_width_out then 
					   image_w=Book("pic_w")
					   else 
						
						if book("pic_w")>=image_width_out then 
					   image_w=image_width_out
					   else  image_w=book("pic_w")
					   end if 
					   end if 
					 
					   %>
<table border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="#999999">
  <tr> 
    <td bgcolor="#FFFFFF"> 
      <div align="center"> 
        <table border="0" cellspacing="4" cellpadding="4">
          <tr> 
            <td> 
              <div align="center"><img src="picdata/<%=(book.Fields.Item("picname").Value)%>"></div>
            </td>
          </tr>
        </table>
      </div>
    </td>
  </tr>
</table>
<table width="500" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr> 
    <td> 
      <div align="center">作者：<A HREF="find_use.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "name=" & book.Fields.Item("name").Value %>" title="查找这个作者的所有作品"><b><%=(book.Fields.Item("name").Value)%></b></A>&nbsp;&nbsp;&nbsp;时间：<%=(book.Fields.Item("posttime").Value)%></div>
    </td>
  </tr>
  <tr> 
    <td> 
      <div align="center"><b>&nbsp;&nbsp;</b> 实际尺寸:<%=book("pic_W")&"×"&book("pic_H")%>, 文件大小:<%=book("filesize")&"KB"%>,&nbsp;Min: 
        <%if h1>=image_width_out then Response.Write"height="&image_width_out&"" else Response.Write"width="&image_w&""   end if %>
      </div>
    </td>
  </tr>
  <tr> 
    <td>&nbsp; </td>
  </tr>
</table>
</body>
</html>
<%
book.Close()
%>
