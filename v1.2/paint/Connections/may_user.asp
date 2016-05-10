<%
' FileName="Connection_odbc_conn_dsn.htm"
' Type="ADO"
' HTTP="false"
' Catalog=""
' Schema=""
MM_may_user_STRING = "dsn=may_user;"
MM_may_user_STRING = "DRIVER={Microsoft Access Driver (*.mdb)}; DBQ="& Server.Mappath("../dbconePoochi.mdb")
%>
<!--#include file="../poo/killip.asp" -->