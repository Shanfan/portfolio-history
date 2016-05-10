<%@LANGUAGE="VBSCRIPT"%>
<!--#include file="../Connections/may_user.asp" -->
<!--#include file="user.asp" -->
<!--#include file="color.asp" -->
<!--#include file="conn.asp" -->
<%
Dim book__MMColParam
book__MMColParam = "文本" 
%>


<%
set book = Server.CreateObject("ADODB.Recordset")
book.ActiveConnection = MM_may_user_STRING
book.Source = "SELECT * FROM book WHERE use_tool <> '" + Replace(book__MMColParam, "'", "''") + "' ORDER BY book_ID DESC"
book.CursorType = 0
book.CursorLocation = 2
book.LockType = 3
book.Open()
book_numRows = 0
%>
<%
set jump = Server.CreateObject("ADODB.Recordset")
jump.ActiveConnection = MM_may_user_STRING
jump.Source = "SELECT * FROM jump ORDER BY ID ASC"
jump.CursorType = 0
jump.CursorLocation = 2
jump.LockType = 3
jump.Open()
jump_numRows = 0
%>
<%
Dim HLooper1__numRows
HLooper1__numRows =picmode_hang*picmode_lie
Dim HLooper1__index
HLooper1__index = 0
book_numRows = book_numRows + HLooper1__numRows
%>
<%
'  *** 小田工作室UD插件系列  Limit Pages List v1.0.0 (改编自PagesList)

' set the record count
book_total = book.RecordCount

' set the number of rows displayed on this page
If (book_numRows < 0) Then
  book_numRows = book_total
Elseif (book_numRows = 0) Then
  book_numRows = 1
End If

' set the first and last displayed record
book_first = 1
book_last  = book_first + book_numRows - 1

' if we have the correct record count, check the other stats
If (book_total <> -1) Then
  If (book_first > book_total) Then book_first = book_total
  If (book_last > book_total) Then book_last = book_total
  If (book_numRows > book_total) Then book_numRows = book_total
End If
%>
<%
' *** Recordset Stats: if we don't know the record count, manually count them

If (book_total = -1) Then

  ' count the total records by iterating through the recordset
  book_total=0
  While (Not book.EOF)
    book_total = book_total + 1
    book.MoveNext
  Wend

  ' reset the cursor to the beginning
  If (book.CursorType > 0) Then
    book.MoveFirst
  Else
    book.Requery
  End If

  ' set the number of rows displayed on this page
  If (book_numRows < 0 Or book_numRows > book_total) Then
    book_numRows = book_total
  End If

  ' set the first and last displayed record
  book_first = 1
  book_last = book_first + book_numRows - 1
  If (book_first > book_total) Then book_first = book_total
  If (book_last > book_total) Then book_last = book_total

End If
%>
<%
' *** Move To Record and Go To Record: declare variables

Set MM_rs    = book
MM_rsCount   = book_total
MM_size      = book_numRows
MM_uniqueCol = ""
MM_paramName = ""
MM_offset = 0
MM_atTotal = false
MM_paramIsDefined = false
If (MM_paramName <> "") Then
  MM_paramIsDefined = (Request.QueryString(MM_paramName) <> "")
End If
%>
<%
' *** Move To Record: handle 'index' or 'offset' parameter

if (Not MM_paramIsDefined And MM_rsCount <> 0) then

  ' use index parameter if defined, otherwise use offset parameter
  r = Request.QueryString("index")
  If r = "" Then r = Request.QueryString("offset")
  If r <> "" Then MM_offset = Int(r)

  ' if we have a record count, check if we are past the end of the recordset
  If (MM_rsCount <> -1) Then
    If (MM_offset >= MM_rsCount Or MM_offset = -1) Then  ' past end or move last
      If ((MM_rsCount Mod MM_size) > 0) Then         ' last page not a full repeat region
        MM_offset = MM_rsCount - (MM_rsCount Mod MM_size)
      Else
        MM_offset = MM_rsCount - MM_size
      End If
    End If
  End If

  ' move the cursor to the selected record
  i = 0
  While ((Not MM_rs.EOF) And (i < MM_offset Or MM_offset = -1))
    MM_rs.MoveNext
    i = i + 1
  Wend
  If (MM_rs.EOF) Then MM_offset = i  ' set MM_offset to the last possible record

End If
%>
<%
' *** Move To Record: if we dont know the record count, check the display range

If (MM_rsCount = -1) Then

  ' walk to the end of the display range for this page
  i = MM_offset
  While (Not MM_rs.EOF And (MM_size < 0 Or i < MM_offset + MM_size))
    MM_rs.MoveNext
    i = i + 1
  Wend

  ' if we walked off the end of the recordset, set MM_rsCount and MM_size
  If (MM_rs.EOF) Then
    MM_rsCount = i
    If (MM_size < 0 Or MM_size > MM_rsCount) Then MM_size = MM_rsCount
  End If

  ' if we walked off the end, set the offset based on page size
  If (MM_rs.EOF And Not MM_paramIsDefined) Then
    If (MM_offset > MM_rsCount - MM_size Or MM_offset = -1) Then
      If ((MM_rsCount Mod MM_size) > 0) Then
        MM_offset = MM_rsCount - (MM_rsCount Mod MM_size)
      Else
        MM_offset = MM_rsCount - MM_size
      End If
    End If
  End If

  ' reset the cursor to the beginning
  If (MM_rs.CursorType > 0) Then
    MM_rs.MoveFirst
  Else
    MM_rs.Requery
  End If

  ' move the cursor to the selected record
  i = 0
  While (Not MM_rs.EOF And i < MM_offset)
    MM_rs.MoveNext
    i = i + 1
  Wend
End If
%>
<%
' *** Move To Record: update recordset stats

' set the first and last displayed record
book_first = MM_offset + 1
book_last  = MM_offset + MM_size
If (MM_rsCount <> -1) Then
  If (book_first > MM_rsCount) Then book_first = MM_rsCount
  If (book_last > MM_rsCount) Then book_last = MM_rsCount
End If

' set the boolean used by hide region to check if we are on the last record
MM_atTotal = (MM_rsCount <> -1 And MM_offset + MM_size >= MM_rsCount)
%>
<%
' *** Go To Record and Move To Record: create strings for maintaining URL and Form parameters

' create the list of parameters which should not be maintained
MM_removeList = "&index=&god="
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
<%
' *** Move To Record: set the strings for the first, last, next, and previous links

MM_keepMove = MM_keepBoth
MM_moveParam = "index"

' if the page has a repeated region, remove 'offset' from the maintained parameters
If (MM_size > 0) Then
  MM_moveParam = "offset"
  If (MM_keepMove <> "") Then
    params = Split(MM_keepMove, "&")
    MM_keepMove = ""
    For i = 0 To UBound(params)
      nextItem = Left(params(i), InStr(params(i),"=") - 1)
      If (StrComp(nextItem,MM_moveParam,1) <> 0) Then
        MM_keepMove = MM_keepMove & "&" & params(i)
      End If
    Next
    If (MM_keepMove <> "") Then
      MM_keepMove = Right(MM_keepMove, Len(MM_keepMove) - 1)
    End If
  End If
End If

' set the strings for the move to links
If (MM_keepMove <> "") Then MM_keepMove = MM_keepMove & "&"
urlStr = Request.ServerVariables("URL") & "?" & MM_keepMove & MM_moveParam & "="
MM_moveFirst = urlStr & "0"
MM_moveLast  = urlStr & "-1"
MM_moveNext  = urlStr & Cstr(MM_offset + MM_size)
prev = MM_offset - MM_size
If (prev < 0) Then prev = 0
MM_movePrev  = urlStr & Cstr(prev)
%>
<%http = "http://" & request.servervariables("SERVER_NAME") & _            
               left(request.servervariables("SCRIPT_NAME"),len(request.servervariables("SCRIPT_NAME"))-len("allpic.asp"))%>
<html>
<head>
<title>图片模式</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="CSS.asp" type="text/css">
</head>
<body bgcolor="<%=web_bg%>" text="#000000" background="<%=web_bgimg%>">
<table width="<%=table%>" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="1" cellpadding="1" align="CENTER" height="32">
        <tr> 
          <td colspan="2"><a href="<%=top_imglink%>" target="_blank"><img src="<%=top_image%>" border="0"></a></td>
        </tr>
        <tr> 
          <td colspan="2"> 
            <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
              <tr> 
                <td> 
                  <div align="left"> 
                    <!--#include file="../pop_top.txt" -->
                  </div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td colspan="2" height="5"> 
            <div align="center"><font color="#FF0000"><a href="login.asp?out=ture"> 
              <%if Session("admin_name")=user_name or  Session("admin_pass")=user_password then %>
              &nbsp;<b><font color="#FF3333">退出登入，<%=Session("admin_name")%></font></b></a></font> 
              <% end if%>
              <%
if session("fuadmin")<>"" then 
dim rs,sql
 	set rs=server.createobject("adodb.recordset")
   username=session("fuadmin")
	password=session("fuadminpass")
   
   sql="select * from fuadmin where pass='"&password&"' and FUadminname='"&username&"'"
	rs.open sql,MM_paint_STRING,1,3
 	if not(rs.bof and rs.eof) then %>
              <font color="#FF0000"><a href="login.asp?out=ture"><b><font color="#FF3333">退出登入，<%=Session("fuadmin")%></font></b></a></font> 
              <%else
		
		Response.Write "<font></font>"
	end if
rs.close
	
	set rs=nothing
end if 
%>
            </div>
          </td>
        </tr>
        <tr> 
          <td width="61%" height="20"> 
            <div align="left"><a href="index.asp">涂鸦板主页</a> <a href="http://poo.webfeng.net/tuya/help.asp">使用帮助</a> 
              <a href="javascript:location.reload()">刷新页面</a> <a href="bbssize.asp" target="_blank">目前状态</a> 
              <a href="admin_pass.asp">管理进入</a> <a href="laji.asp">垃圾箱</a> <a href="allpic.asp">图片模式</a><font color="#FF0000"> 
              <a href="login.asp?out=ture"> </a><a href="good_Topic.asp">精华作品</a></font></div>
          </td>
          <td width="39%" height="20"> 
            <div align="right"> 
              <script language="JavaScript" src="chenkIP.asp">
</script>
              <%if lockbbs="0" then %>
              <a href="set_cav.asp">开始涂鸦</a>&nbsp;&nbsp;&nbsp;<a href="post.asp">发表文本主题</a> 
              <%if upload_yes="yes" then %>
              &nbsp;&nbsp;<a href="UPLOAD.ASP">上传作品</a> 
              <%end if %>
              <% else Response.Write "<font size=3 color=red>不能发表作品，涂鸦板被管理员锁定！</font>" end if%>
            </div>
          </td>
        </tr>
        <tr> 
          <td width="61%"> 
            <div align="right"> <marquee scrollamount=2> <a href="new_info.asp" target="_blank"><img src="../bbsimages/tutu43.gif" width="15" height="15" border="0"> 
              <!--#include file="new_title.txt" -->
              <%=news_title%> </a> </marquee> </div>
          </td>
          <td width="39%"> 
            <div align="right"> 
              <%if online_show="yes" then %>
              <script language="javascript" src="ACTIVE.ASP"></script>
              人在线<br>
              <script language="javascript" src="count.asp"></script>
              <%end if %>
            </div>
          </td>
        </tr>
        <tr> 
          <td width="61%">作品数量：<%=(book_total)%> 幅，显示比例：Width:<%=picmode_width%> 行=<%=picmode_hang%>,列=<%=picmode_lie%>显示</td>
          <td width="39%"> 
            <form action=./ name=goFORM>
              <div align="right"> 
                <script language=JavaScript>
<!--- 旕昞帵
function quick_go(w){
if (w == "") { return; }
document.goFORM.lists.selectedIndex = 0;
location.href = w;
}
//end --->
</script>
                <select name=lists>
                  <option selected>快速通道</option>
                  <%
While (NOT jump.EOF)
%>
                  <option value="<%=(jump.Fields.Item("url").Value)%>" ><%=(jump.Fields.Item("goname").Value)%></option>
                  <%
  jump.MoveNext()
Wend
If (jump.CursorType > 0) Then
  jump.MoveFirst
Else
  jump.Requery
End If
%>
                </select>
                <input onClick=quick_go(this.form.lists.options[this.form.lists.selectedIndex].value) type=button value=GO! name="button">
              </div>
            </form>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<table width="<%=table%>" border="0" cellspacing="3" cellpadding="3" align="center">
  <tr> 
    <td> 页数： 
      <% 
Forward = "前60页"
Backward = "后60页"
Delimiter = " - "
Rec_Name = book_total
List_Num = 60
Godspeed = 1
if request.querystring("god") <> "" then 
Godspeed = request.querystring("god")
end if
if Godspeed <> 1 then
Response.Write("<a href=" & Request.ServerVariables("URL") & "?" & MM_keepMove & "offset=" & Godspeed - MM_Size - 1 & "&god=" & Godspeed - MM_Size * List_Num & ">") 
Response.Write(Backward & "</a>  ")
end if
if Rec_Name < Godspeed + MM_Size * List_Num then
Matrix = Rec_Name
else
Matrix = Godspeed + MM_Size * (List_Num - 1) 
end if
if MM_size=0 then
   mm_size=1
end if

TM_counter = ( Godspeed - 1 )/MM_Size
For i = Godspeed to Matrix step MM_Size 
TM_counter = TM_counter + 1
if i <> MM_offset + 1 then
Response.Write("<a href=" & Request.ServerVariables("URL") & "?" & MM_keepMove & "offset=" & i-1 & "&god=" & Godspeed & ">")
Response.Write(TM_counter & "</a>")
else
Response.Write("<b>" & TM_counter & "</b>")
End if
if( i <= Matrix - MM_Size ) then Response.Write(Delimiter)
next
if Rec_Name > Godspeed + MM_Size * List_Num - 1 then
Response.Write("  <a href=" & Request.ServerVariables("URL") & "?" & MM_keepMove & "offset=" & Godspeed + MM_Size * List_Num - 1 & "&god=" & Godspeed + MM_Size * List_Num & ">") 
Response.Write(Forward & "</a>")
end if
%>
    </td>
  </tr>
</table>
<table width="<%=table%>" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=td_bor%>" align="center">
  <tr> 
    <td bgcolor="<%=titlebg%>">&nbsp;</td>
  </tr>
  <tr> 
    <td bgcolor="<%=bg_color%>"> 
      <table align="center" cellpadding="4" cellspacing="4">
        <%
startrw = 0
endrw = HLooper1__index
numberColumns =picmode_hang
numrows =picmode_lie
while((numrows <> 0) AND (Not book.EOF))
	startrw = endrw + 1
	endrw = endrw + numberColumns
 %>
        <tr align="center" valign="top"> 
          <%
While ((startrw <= endrw) AND (Not book.EOF))
%>
          <td> 
            <table width="<%=(image_width_index)+10%>" border="1" cellspacing="0" cellpadding="0" height="<%=(image_width_index)+10%>">
              <tr> 
                <td bgcolor="#CCCCCC"> 
                  <div align="center"> 
                    <%dim x1 
						if book("pic_w")>picmode_width then 
						x1=book("pic_w")-picmode_width '100
					    h1=book("pic_h")-x1
						else h1=book("pic_h")
						end if 
						
						if Book("pic_w")<picmode_width and  Book("pic_h")<picmode_width then 
					   image_w=Book("pic_w")
					   else 
						
						if book("pic_w")>=picmode_width then 
					   image_w=picmode_width
					   else  image_w=book("pic_w")
					   end if 
					   end if 
					   %>
                    <A HREF="showToppic.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "book_ID=" & book.Fields.Item("book_ID").Value %>" title="实际尺寸:<%=book("pic_W")&"×"&book("pic_H")%>, 大小:<%=book("filesize")&"KB"%>,&nbsp;Min: 
                          <%if h1>=image_width_out then Response.Write"height="&image_width_out&"" else Response.Write"width="&image_w&""   end if %>" target="_blank"><img src='<%=http%>picdata/<%=book("picname")%>' <%if h1=<picmode_width then Response.Write"width="&image_w&"" else Response.Write"height="&picmode_width&""  end if %> border="0"></A></div>
                </td>
              </tr>
            </table>
          &nbsp;&nbsp; 
                  <%if Session("admin_name")=user_name or  Session("admin_pass")=user_password then %>
            <a href="file_del_poss_admin.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "ID=" & book.Fields.Item("book_ID").Value %>&picname=<%=book.Fields.Item("picname").Value%>&pchname=<%=book.Fields.Item("pchname").Value%>&url=allpic.asp" title="删除图片和关联帖子">Delete</a>&nbsp;&nbsp;&nbsp; 
            <% end if%>
                  <%
if session("fuadmin")<>"" then 

 	set rs=server.createobject("adodb.recordset")
   username=session("fuadmin")
	password=session("fuadminpass")
   
   sql="select * from fuadmin where pass='"&password&"' and FUadminname='"&username&"'"
	rs.open sql,MM_paint_STRING,1,3
 	if not(rs.bof and rs.eof) then %>
            <a href="file_del_poss_admin.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "ID=" & book.Fields.Item("book_ID").Value %>&picname=<%=book.Fields.Item("picname").Value%>&pchname=<%=book.Fields.Item("pchname").Value%>&url=allpic.asp"title="删除图片和关联帖子">Delete</a> 
            <%else
		
		Response.Write " "
	end if
rs.close
	
	set rs=nothing
end if 
%>
</td>
          <%
	startrw = startrw + 1
	book.MoveNext()
	Wend
	%>
        </tr>
        <%
 numrows=numrows-1
 Wend
 %>
      </table>
    </td>
  </tr>
</table>
<table width="<%=table%>" border="0" cellspacing="3" cellpadding="3" align="center">
  <tr> 
    <td> 
      <div align="right">页数： 
        <% 
Forward = "前60页"
Backward = "后60页"
Delimiter = " - "
Rec_Name = book_total
List_Num = 60
Godspeed = 1
if request.querystring("god") <> "" then 
Godspeed = request.querystring("god")
end if
if Godspeed <> 1 then
Response.Write("<a href=" & Request.ServerVariables("URL") & "?" & MM_keepMove & "offset=" & Godspeed - MM_Size - 1 & "&god=" & Godspeed - MM_Size * List_Num & ">") 
Response.Write(Backward & "</a>  ")
end if
if Rec_Name < Godspeed + MM_Size * List_Num then
Matrix = Rec_Name
else
Matrix = Godspeed + MM_Size * (List_Num - 1) 
end if
if MM_size=0 then
   mm_size=1
end if

TM_counter = ( Godspeed - 1 )/MM_Size
For i = Godspeed to Matrix step MM_Size 
TM_counter = TM_counter + 1
if i <> MM_offset + 1 then
Response.Write("<a href=" & Request.ServerVariables("URL") & "?" & MM_keepMove & "offset=" & i-1 & "&god=" & Godspeed & ">")
Response.Write(TM_counter & "</a>")
else
Response.Write("<b>" & TM_counter & "</b>")
End if
if( i <= Matrix - MM_Size ) then Response.Write(Delimiter)
next
if Rec_Name > Godspeed + MM_Size * List_Num - 1 then
Response.Write("  <a href=" & Request.ServerVariables("URL") & "?" & MM_keepMove & "offset=" & Godspeed + MM_Size * List_Num - 1 & "&god=" & Godspeed + MM_Size * List_Num & ">") 
Response.Write(Forward & "</a>")
end if
%>
      </div>
    </td>
  </tr>
</table>
<br>
<table width="<%=table%>" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td> 
      <!--#include file="../foot.htm" -->
    </td>
  </tr>
</table>
</body>
</html>
<%
book.Close()
%>
<%
jump.Close()
%>
