 
<style type="text/css">
<!--
body {  font-size: 14px; line-height: 24px; color: #000000; font-family: "Verdana", "Arial", "Helvetica", "sans-serif"}
-->
</style>

<!--#include file="inc/ubbcode.asp" -->

 <%

linkf = Server.MapPath("new.txt")
Set fso = CreateObject("Scripting.FileSystemObject")
Set linkf = fso.OpenTextFile(linkf)
link=linkf.Readall
%>
<%=ubbcode(link)%>
<%

linkf.close
Set fso = nothing
Set linkf = nothing
%>
