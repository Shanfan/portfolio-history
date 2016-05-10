<html>
<head>
<title>错误</title>
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
<style type="text/css">
<!--
td {  font-family: "Geneva", "Arial", "Helvetica", "san-serif"; font-size: 14px; color: #333333}
a {  color: #0066CC}
a:hover {  color: #0066CC}
-->
</style>
</head>

<body bgcolor="#FFFFFF" text="#000000">
<%if Request.QueryString("id")="paint"then  %>
<table width="470" border="0" cellspacing="2" cellpadding="2" align="center">
  <tr>
    <td><img src="../bbsimages/030306xbutton07.jpg" width="128" height="128"></td>
  </tr>
  <tr> 
    <td>你所发送的数据可能包含以下错误信息：</td>
  </tr>
  <tr> 
    <td>1.没有填写发言人姓名</td>
  </tr>
  <tr> 
    <td>2.没有填写作品保护密码</td>
  </tr>
  <tr> 
    <td>3.没有填写主题</td>
  </tr>
  <tr> 
    <td>4.没有填写发言内容</td>
  </tr>
  <tr> 
    <td> 
      <div align="center"><a href="javascript:history.back(1)">请返回认真填写</a></div>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
</table>
<%end if %> 
</body>
</html>
