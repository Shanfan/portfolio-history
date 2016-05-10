
<%@LANGUAGE="VBSCRIPT"%>
<%
	response.expires = 0
	response.expiresabsolute = Now() - 1
	response.addHeader "pragma","no-cache"
	response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
%>
<!--#include file="user.asp" -->
<!--#include file="../Connections/may_user.asp" -->
<%
set Recordset1 = Server.CreateObject("ADODB.Recordset")
Recordset1.ActiveConnection = MM_may_user_STRING
Recordset1.Source = "SELECT *  FROM user  WHERE username = '"&user_name&"'"
Recordset1.CursorType = 0
Recordset1.CursorLocation = 2
Recordset1.LockType = 3
Recordset1.Open()
Recordset1_numRows = 0
%>
<%
set book = Server.CreateObject("ADODB.Recordset")
book.ActiveConnection = MM_may_user_STRING
book.Source = "SELECT book_ID, picname, pchname FROM book Where good_Topic=0 ORDER BY book_ID ASC"
book.CursorType = 0
book.CursorLocation = 2
book.LockType = 3
book.Open()
book_numRows = 0
%>
<%
'  *** Recordset Stats, Move To Record, and Go To Record: declare stats variables

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
dim delid,picname,pchname
delid=(book.Fields.Item("book_ID").Value)
picname=(book.Fields.Item("picname").Value)
pchname=(book.Fields.Item("pchname").Value)
if (book_total)>=(Recordset1.Fields.Item("max_content").Value)  then 
Session("ADAHVAV_asdf324")="ture"
Response.Redirect("maxdel.asp?delid="&delid&"&picname="&picname&"&pchname="&pchname&"")
else
Response.Redirect("index.asp")
end if %>




<%
Recordset1.Close()
%>

<%
book.Close()
%>
