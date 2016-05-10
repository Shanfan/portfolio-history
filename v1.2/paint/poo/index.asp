<%@LANGUAGE="VBSCRIPT"%>

<!--#include file="../Connections/may_user.asp" -->
<!--#include file="conn.asp" -->
<!--#include file="user.asp" -->
<!--#include file="color.asp" -->
<!--#include file="../ubbcode.asp" -->
<%
Dim admin_name
if user_name <> "" then admin_name = user_name

set book = Server.CreateObject("ADODB.Recordset")
book.ActiveConnection = MM_may_user_STRING
book.Source = "SELECT *  FROM book  WHERE admin_name = '"&admin_name&"'  ORDER BY toptime DESC"
book.CursorType = 0
book.CursorLocation = 2
book.LockType = 3
book.Open()
book_numRows = 0
%>
<%
set re_book = Server.CreateObject("ADODB.Recordset")
re_book.ActiveConnection = MM_may_user_STRING
re_book.Source = "SELECT * FROM re ORDER BY re_ID ASC"
re_book.CursorType = 0
re_book.CursorLocation = 2
re_book.LockType = 3
re_book.Open()
re_book_numRows = 0

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
set fuadmin = Server.CreateObject("ADODB.Recordset")
fuadmin.ActiveConnection =MM_paint_STRING
fuadmin.Source = "SELECT * FROM fuadmin ORDER BY ID ASC"
fuadmin.CursorType = 0
fuadmin.CursorLocation = 2
fuadmin.LockType = 3
fuadmin.Open()
fuadmin_numRows = 0
%>
<%
Dim HLooper1__numRows
HLooper1__numRows = -200
Dim HLooper1__index
HLooper1__index = 0
fuadmin_numRows = fuadmin_numRows + HLooper1__numRows
%>
<%

Dim Repeat1__numRows
Repeat1__numRows = bbs_list
Dim Repeat1__index
Repeat1__index = 0
book_numRows = book_numRows + Repeat1__numRows
%>
<%
'JomoWeb c2001 nstrpt1
function JomoPrefix(rs, fldName)
dim str, strlen, whereloc, orderloc
str = rs.source
strlen = Len(str)
whereloc=InStr(str," WHERE ")
orderloc=InStr(str," ORDER BY ")
if orderloc = 0 and whereloc = 0 then 
  JomoPrefix = str & " WHERE " & fldName & " = "
else
  if whereloc = 0 then
  	JomoPrefix=Left(str,orderloc) & " WHERE " & fldName & " = "
  else
  	if orderloc = 0 then orderloc = strlen
  	JomoPrefix=Left(str,whereloc+6) &" ( " &  Mid(str, whereloc+7, orderloc - whereloc -6 ) & " )  AND " & fldName & " = "
  end if
end if
end function

function JomoPostfix(rs)
dim str, orderloc
str=rs.source
orderloc = InStr(str," ORDER BY ")
if orderloc = 0 then
  JomoPostfix = ""
else
JomoPostfix = " " & right(str, Len(str) - orderloc)
end if
end function
 %>
<% 
'JomoWeb c2001 nstrpt2
dim re_book_prefix, re_book_postfix
re_book_prefix = JomoPrefix(re_book, "Book_ID")
re_book_postfix=JomoPostfix(re_book)
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
<SCRIPT RUNAT=SERVER LANGUAGE=VBSCRIPT>										
function DoWhiteSpace(str)												
	DoWhiteSpace = Replace((Replace(str, vbCrlf, "<br>")), chr(32)&chr(32), "&nbsp;&nbsp;")			
End Function														
</SCRIPT>
<html>
<head>
<title><%=bbs_name%></title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<link rel="stylesheet" href="CSS.asp" type="text/css">
</head>
<body bgcolor="<%=web_bg%>" text="#000000" background="<%=web_bgimg%>">
<table width="<%=table%>" border="0" cellspacing="1" cellpadding="1" align="center">
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
          <td colspan="2" height="2"> 
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
          <td width="60%" height="16"> 
            <div align="left"><a href="<%=adminhomepage%>">画板主页</a> 
              <a href="http://poo.webfeng.net/tuya/help.asp">使用帮助</a> <a href="javascript:location.reload()">刷新页面</a> 
              <a href="bbssize.asp" target="_blank">目前状态</a> <a href="admin_pass.asp">管理进入</a> 
              <a href="laji.asp">垃圾箱</a> <a href="allpic.asp">图片模式</a> <a href="good_Topic.asp">精华作品</a></div>
          </td>
          <td width="40%" height="16"> 
            <div align="right"> 
              <script language="JavaScript" src="chenkIP.asp">
</script>
              <%if lockbbs="0" then %>
              <object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,2,0" width="100" height="20">
                <param name=movie value="button1.swf">
                <param name=quality value=high>
				<PARAM NAME=wmode VALUE=transparent> 
                <param name="BASE" value=".">
                <param name="BGCOLOR" value="">
                <embed src="button1.swf" base="."  quality=high pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="100" height="20" bgcolor="">
                </embed> 
              </object>&nbsp;<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,2,0" width="100" height="20">
                <param name=movie value="button2.swf">
                <param name=quality value=high>
				<PARAM NAME=wmode VALUE=transparent> 
                <param name="BASE" value=".">
                <param name="BGCOLOR" value="">
                <embed src="button2.swf" base="."  quality=high pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="100" height="20" bgcolor="">
                </embed> 
              </object> 
              <%if upload_yes="yes" then %>
              &nbsp;<object classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=4,0,2,0" width="100" height="20">
                <param name=movie value="button3.swf">
                <param name=quality value=high>
				<PARAM NAME=wmode VALUE=transparent> 
                <param name="BASE" value=".">
                <param name="BGCOLOR" value="">
                <embed src="button3.swf" base="."  quality=high pluginspage="http://www.macromedia.com/shockwave/download/index.cgi?P1_Prod_Version=ShockwaveFlash" type="application/x-shockwave-flash" width="100" height="20" bgcolor="">
                </embed> 
              </object> 
              <%end if %>
              <% else Response.Write "<font size=3 color=red>不能发表作品，涂鸦板被管理员锁定！</font>" end if%>
            </div>
          </td>
        </tr>
        <tr> 
          <td> 
            <div align="right"> <marquee scrollamount=2> <a href="new_info.asp" target="_blank"><img src="../bbsimages/tutu43.gif" width="15" height="15" border="0"> 
              <!--#include file="new_title.txt" -->
              <%=news_title%> </a> </marquee> </div>
          </td>
          <td> 
            <div align="right"> 
              <%if online_show="yes" then %>
              <script language="javascript" src="ACTIVE.ASP"></script>
              人在线<br>
              <script language="javascript" src="count.asp"></script>
              <%end if %>
            </div>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center">
        <tr> 
          <td colspan="2">&nbsp;管理员：<%=DoWhiteSpace(nichen)%>&nbsp;&nbsp;&nbsp; &nbsp;版主： 
            <%
startrw = 0
endrw = HLooper1__index
numberColumns = 200
numrows = -1
while((numrows <> 0) AND (Not fuadmin.EOF))
	startrw = endrw + 1
	endrw = endrw + numberColumns
 %>
            <%
While ((startrw <= endrw) AND (Not fuadmin.EOF))
%>
            <%=(fuadmin.Fields.Item("FUadminname").Value)%> &nbsp; 
            <%
	startrw = startrw + 1
	fuadmin.MoveNext()
	Wend
	%>
            <%
 numrows=numrows-1
 Wend
 %>
          </td>
          <td width="36%"> 
            <div align="right"> 
              <!--#include file="../Tefso.asp" -->
            </div>
          </td>
        </tr>
        <tr> 
          <td width="24%"> 
            <form action=./ name=goFORM>
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
            </form>
          </td>
          <td width="40%"> 
            <form name="form1" method="get" action="find.asp">
              <table width="77%" border="0" id="adv" style="DISPLAY: none" cellpadding="1" cellspacing="1">
                <tr> 
                  <td width="26%"> 
                    <div align="right">查找作者:</div>
                  </td>
                  <td width="74%"> 
                    <input type="text" name="find" size="10" maxlength="225" style="ime-mode: disabled">
                    <input type="submit" value="检索" name="submit">
                  </td>
                </tr>
              </table>
              <input id=advcheck name=advshow type=checkbox value=1 onClick=showadv()>
              <span id=advance>显示高级选项 
              <script>
function showadv(){
if (document.form1.advshow.checked == true) {
	adv.style.display = "";
	advance.innerText="关闭高级选项"
}else{
	adv.style.display = "none";
	advance.innerText="显示高级选项"
}
}
</script>
              </span> 
            </form>
          </td>
          <td width="36%"> 
            <div align="right">作品数量:<%=(book_total)%>，每页<%=bbs_list%> 张，最多可保存 <%=max_book%> 张</div>
          </td>
        </tr>
      </table>
      <table width="100%" border="0" cellspacing="2" cellpadding="2" align="center">
        <tr> 
          <td> 
            <% 
Forward = "后60页"
Backward = "前60页"
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
      <% 
While ((Repeat1__numRows <> 0) AND (NOT book.EOF)) 
%>
      <table width="100%" border="0" cellspacing="1" cellpadding="1" align="center" bgcolor="<%=td_bor%>" height="210">
        <tr> 
          <td colspan="2" bgcolor="<%=titlebg%>" height="20"> 
            <table width="80%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td height="15"> &nbsp;<img src="../bbsimages/red_folder.gif" width="18" height="12"> 
                  <b><font color="<%=title_td%>">主题：<%=(book.Fields.Item("title").Value)%></font></b><b><font color="<%=title_td%>"> 
                  <% if book.Fields.Item("toptime").Value="8888-8-11" then %>
                  <font color="#FF0000">（该主题被管理员固顶）</font> 
                  <%end if %>
                  </font></b></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td colspan="2" bgcolor="<%=bg_color%>" valign="top"> 
            <table width="100%" border="0" cellspacing="1" cellpadding="1">
              <tr> 
                <td valign="middle"><img src="../bbsimages/name.gif" width="48" height="18"><b> 
                  <%=(book.Fields.Item("name").Value)%></b> 
                  <%if book.Fields.Item("oicq").Value<>""and  Isnumeric(book.Fields.Item("oicq").Value)then %>
                  <a href="http://search.tencent.com/cgi-bin/friend/user_show_info?ln=<%=(book.Fields.Item("oicq").Value)%>" target="_blank"><img src="../bbsimages/qq.gif" alt="<%=(book.Fields.Item("oicq").Value)%>" border="0" width="43" height="16"></a> 
                  <%end if %>
                  <%if book.Fields.Item("homepage").Value <>""then %>
                  <a href="<%=(book.Fields.Item("homepage").Value)%>" target="_blank"><img src="../bbsimages/homepage.gif" border="0" alt="访问主页" width="47" height="18"></a> 
                  <%end if %>
                  <a href="find_use.asp?name=<%=(book.Fields.Item("name").Value)%>"><img src="../bbsimages/find2.gif" alt="查找该作者的所有作品！" border="0"></a> 
                  <a href="edit.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "book_ID=" & book.Fields.Item("book_ID").Value %>"><img src="../bbsimages/aEdit.gif" width="41" height="15" border="0" alt="继续绘画，删除作品等"></a> 
                  <img src="../bbsimages/time.gif" width="44" height="20" alt="<%=(book.Fields.Item("posttime").Value)%>"><%=(book.Fields.Item("posttime").Value)%>&nbsp;&nbsp; 
                  <%if Session("admin_name")=user_name or  Session("admin_pass")=user_password then %>
                  <a href="file_del_poss_admin.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "ID=" & book.Fields.Item("book_ID").Value %>&picname=<%=book.Fields.Item("picname").Value%>&pchname=<%=book.Fields.Item("pchname").Value%>">删除</a>&nbsp;&nbsp;<a href="istop.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "book_ID=" & book.Fields.Item("book_ID").Value %>&top=yes">固顶</a> 
                  &nbsp;<a href="istop.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "book_ID=" & book.Fields.Item("book_ID").Value %>&top=no">取消固顶</a> 
                  <a href="istop.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "book_ID=" & book.Fields.Item("book_ID").Value %>&Good=yes">设为精华</a> 
                  <%="<b>IP：</b>"&book("IP")%> 
                  <% end if%>
                  <%
if session("fuadmin")<>"" then 

 	set rs=server.createobject("adodb.recordset")
   username=session("fuadmin")
	password=session("fuadminpass")
   
   sql="select * from fuadmin where pass='"&password&"' and FUadminname='"&username&"'"
	rs.open sql,MM_paint_STRING,1,3
 	if not(rs.bof and rs.eof) then %>
                  <a href="file_del_poss_admin.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "ID=" & book.Fields.Item("book_ID").Value %>&picname=<%=book.Fields.Item("picname").Value%>&pchname=<%=book.Fields.Item("pchname").Value%>">删除</a>&nbsp;&nbsp;<a href="istop.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "book_ID=" & book.Fields.Item("book_ID").Value %>&top=yes">固顶</a> 
                  &nbsp;<a href="istop.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "book_ID=" & book.Fields.Item("book_ID").Value %>&top=no">取消固顶</a> 
                  <a href="istop.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "book_ID=" & book.Fields.Item("book_ID").Value %>&Good=yes">设为精华</a> 
                  <%else
		
		Response.Write "<font></font>"
	end if
rs.close
	
	set rs=nothing
end if 
%>
                </td>
              </tr>
            </table>
            <table width="100%" border="0" cellspacing="0" cellpadding="0">
              <tr> 
                <td width="43%" rowspan="2"> 
                  <table border="0" cellspacing="2" cellpadding="3" align="CENTER">
                    <tr> 
                      <td> 
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
                        <%if book.Fields.Item("picname").Value<>"" then %>
                        <A HREF="showToppic.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "book_ID=" & book.Fields.Item("book_ID").Value %>" target="_blank"><img src="picdata/<%=(book.Fields.Item("picname").Value)%>" <%if h1=<image_width_out then Response.Write"width="&image_w&"" else Response.Write"height="&image_width_out&""  end if %> alt="查看大图" border="0"></A> 
                        <%end if %>
                      </td>
                    </tr>
                  </table>
                  <table width="100%" border="0" cellspacing="2" cellpadding="2">
                    <tr> 
                      <td> 
                        <div align="center">使用工具：<%=(book.Fields.Item("use_tool").Value)%> 
                          <%if book("uploadpaint")<>"none" then %>
                          <br>
                          <br>
                          该图象使用<%=book("uploadpaint")%>编辑过 
                          <%end if %>
                        </div>
                      </td>
                    </tr>
                    <tr> 
                      <td> 
                        <div align="center"> 
                          <%if book.Fields.Item("pchname").Value<>"" then %>
                          <a href="play.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "book_ID=" & book.Fields.Item("book_ID").Value %>&tool=<%=(book.Fields.Item("use_tool").Value)%>" target="_blank">回放过程</a>&nbsp;<a href="picdata/<%=(book.Fields.Item("pchname").Value)%>">保存文件</a> 
                          耗时:<%=(book.Fields.Item("painttime").Value)%> 
                          <%end if %>
                        </div>
                      </td>
                    </tr>
                    <tr> 
                      <td> 
                        <div align="center"> 
                          <%if (book.Fields.Item("use_tool").Value)<>"文本"then %>
                          实际尺寸:<%=book("pic_W")&"×"&book("pic_H")%>, 大小:<%=book("filesize")&"KB"%>,&nbsp;Min: 
                          <%if h1>=image_width_out then Response.Write"height="&image_width_out&"" else Response.Write"width="&image_w&""   end if %>
                          <%end if %>
                        </div>
                      </td>
                    </tr>
                  </table>
                </td>
                <td valign="top" width="57%"> 
                  <table width="97%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=re_tbg%>">
                    <tr> 
                      <td bgcolor="<%=re_bg%>"> 
                        <table style="TABLE-LAYOUT: fixed" width="95%" border="0" cellspacing="2" cellpadding="2" align="center">
                          <tr> 
                            <td><%=ubbcode(book.Fields.Item("contents").Value)%></td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <br>
                  <%
'JomoWeb c2001 nstrpt3
if "re_book" <> "book" then
  re_book.close()
  if book.state = 1 then book_Fld = book("book_ID")
re_book.source = re_book_prefix & book_Fld & re_book_postfix
  re_book.open()
end if
while NOT re_book.EOF
 %>
                  <table width="97%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=re_tbg%>">
                    <tr> 
                      <td bgcolor="<%=re_bg%>"> 
                        <table width="99%" border="0" cellspacing="1" cellpadding="1">
                          <tr> 
                            <td><img src="../bbsimages/boook.gif">Name:<b>&nbsp;<%=(re_book.Fields.Item("name").Value)%></b> 
                              <%if re_book.Fields.Item("oicq").Value<>""and  Isnumeric(re_book.Fields.Item("oicq").Value)then %>
                              &nbsp;<a href="http://search.tencent.com/cgi-bin/friend/user_show_info?ln=<%=(re_book.Fields.Item("oicq").Value)%>" target="_blank"><img src="../bbsimages/qq.gif" border="0" alt="<%=(re_book.Fields.Item("oicq").Value)%>"></a> 
                              <%end if %>
                              <%if re_book.Fields.Item("homepage").Value <>""then %>
                              <a href="<%=(re_book.Fields.Item("homepage").Value)%>" target="_blank"><img src="../bbsimages/homepage.gif" border="0" width="47" height="18"></a> 
                              <%end if %>
                              Time: 
                              <%re_time=re_book.Fields.Item("post_time").Value%>
                              <%=re_time%> 
                              <%if Session("admin_name")=user_name or  Session("admin_pass")=user_password then %>
                              &nbsp;&nbsp;&nbsp;<a href="re_del.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "ID=" & re_book.Fields.Item("re_ID").Value %>"><img src="../bbsimages/delete.gif" width="18" height="18" alt="删除回复" border="0"></a> 
                              &nbsp;<%="<b>IP：</b>"&re_book("IP")%> 
                              <% end if%>
                              <a href="re_del.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "ID=" & re_book.Fields.Item("re_ID").Value %>"> 
                              <%
if session("fuadmin")<>"" then 

 	set rs=server.createobject("adodb.recordset")
   username=session("fuadmin")
	password=session("fuadminpass")
   
   sql="select * from fuadmin where pass='"&password&"' and FUadminname='"&username&"'"
	rs.open sql,MM_paint_STRING,1,3
 	if not(rs.bof and rs.eof) then %>
                              <img src="../bbsimages/delete.gif" width="18" height="18" alt="删除回复" border="0"></a> 
                              <%else
		
		Response.Write "<font></font>"
	end if
rs.close
	
	set rs=nothing
end if 
%>
                            </td>
                          </tr>
                          <tr> 
                            <td> 
                              <table width="98%" border="0" cellspacing="1" cellpadding="1" align="center">
                                <tr> 
                                  <td><%=ubbcode(re_book.Fields.Item("re_content").Value)%></td>
                                </tr>
                              </table>
                            </td>
                          </tr>
                        </table>
                      </td>
                    </tr>
                  </table>
                  <table width="30" border="0" cellspacing="0" cellpadding="0" align="center">
                    <tr> 
                      <td height="9"></td>
                    </tr>
                  </table>
                  <%
'JomoWeb c2001 nstrpt4
re_book.moveNext()
wend
 %>
                </td>
              </tr>
              <tr> 
                <td valign="bottom" width="57%"> 
                  <%if fast_re="1" then %>
                  <table width="100%" border="0" cellspacing="0" cellpadding="0">
                    <tr> 
                      <td> 
                        <form name="chi<%=book("book_ID")%>" method="post" action="re.asp">
                          <table width="100%" border="0" cellspacing="0" cellpadding="1">
                            <tr> 
                              <td width="13%"> 
                                <div align="right">大名:</div>
                              </td>
                              <td width="87%"> 
                                <input type="text" name="name" size="25" maxlength="30" value="<%= Request.Cookies("guest_name") %>">
                                <input type="hidden" name="MM_insert" value="true">
                                <input type="hidden" name="book_id" value="<%=(book.Fields.Item("book_ID").Value)%>">
                              </td>
                            </tr>
                            <tr> 
                              <td width="13%"> 
                                <div align="right">内容:</div>
                              </td>
                              <td width="87%"> 
                                <textarea name="contents" style="overflow:auto;" cols="30" rows="3" wrap="VIRTUAL"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="13%">&nbsp;</td>
                              <td width="87%"> 
                                <input type="submit" name="Submit" value="快速回复"  OnClick="this.disabled=true;document.chi<%=book("book_ID")%>.submit();">
                              </td>
                            </tr>
                          </table>
                        </form>
                      </td>
                    </tr>
                  </table>
                  <%end if %>
                  <table width="100" border="0" cellspacing="0" cellpadding="2" align="right">
                    <tr> 
                      <td> 
                        <div align="center"><a href="re.asp?<%= MM_keepNone & MM_joinChar(MM_keepNone) & "book_ID=" & book.Fields.Item("book_ID").Value %>"><img src="../bbsimages/reply_a.gif" border="0"></a></div>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <table width="75" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
          <td height="13"></td>
        </tr>
      </table>
      <% 
  Repeat1__index=Repeat1__index+1
  Repeat1__numRows=Repeat1__numRows-1
  book.MoveNext()
Wend
%>
      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
        <tr> 
          <td> 
            <% 
Forward = "后60页"
Backward = "前60页"
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
      <br>
      <table width="600" border="0" cellspacing="2" cellpadding="2" align="center">
        <tr> 
          <td> 
            <div align="center"> 
              <!--#include file="../pop_foot.txt" -->
            </div>
          </td>
        </tr>
      </table>
      <%if links="yes" then %>
      <table width="100%" border="0" cellspacing="1" cellpadding="1" bgcolor="<%=td_bor%>">
        <tr> 
          <td bgcolor="<%=titlebg%>">&nbsp;<img src="../bbsimages/msn-gray.gif" width="16" height="15"> 
            <font color="<%=title_td%>"><b>涂鸦板联盟：</b></font></td>
        </tr>
        <tr> 
          <td bgcolor="<%=bg_color%>"><br>
            <table style="TABLE-LAYOUT: fixed"  width="90%" border="0" cellspacing="1" cellpadding="1" align="center">
              <tr> 
                <td class="lines"> 
                  <script language="JavaScript" src="link.asp">
</script>
                </td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <%end if %><br>
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
re_book.Close()
%>
<%
jump.Close()
%>
<%
fuadmin.Close()
%>
