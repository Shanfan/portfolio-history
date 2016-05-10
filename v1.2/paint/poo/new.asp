<!--#include file="conn.asp" -->
<!--#include file="user.asp" -->
<%
set book = Server.CreateObject("ADODB.Recordset")
book.ActiveConnection = MM_may_user_STRING
book.Source = "SELECT * FROM book ORDER BY posttime DESC"
book.CursorType = 0
book.CursorLocation = 2
book.LockType = 3
book.Open()
book_numRows = 0

%><%			dim x1 
						if book("pic_w")>image_width_index then 
						x1=book("pic_w")-image_width_index '100
					    h1=book("pic_h")-x1
						else h1=book("pic_h")
						end if 
						
						if Book("pic_w")<image_width_index and  Book("pic_h")<image_width_index then 
					   image_w=Book("pic_w")
					   else 
						
						if book("pic_w")>=image_width_index then 
					   image_w=image_width_index
					   else  image_w=book("pic_w")
					   end if 
					   end if 
					   %>
					   <%http = "http://" & request.servervariables("SERVER_NAME") & _            
               left(request.servervariables("SCRIPT_NAME"),len(request.servervariables("SCRIPT_NAME"))-len("new.asp"))%>

 document.write ("<%if book("picname")<>"" then %><img src='<%=http%>picdata/<%=book("picname")%>' <%if h1=<image_width_index then Response.Write"width="&image_w&"" else Response.Write"height="&image_width_index&""  end if %>><%else %><img src='poo/noimage.gif'><%end if %>")
     document.write ("<br><font face='Verdana, Arial, Helvetica, sans-serif' size=1>Size:<%=book("filesize")%>KB</font>")
  document.write ("<br><font face='Verdana, Arial, Helvetica, sans-serif' size=1>Widht:<%=book("pic_W")%>¡Á<%=book("pic_h")%></font>")
   document.write ("<br><font face='Verdana, Arial, Helvetica, sans-serif' size=1>Time:<%=book("posttime")%></font>")