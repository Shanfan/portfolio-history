<!--#include file="../Connections/may_user.asp" -->
<!--#include file="user.asp" -->
<!--#include file="color.asp" -->
<%
	response.expires = 0
	response.expiresabsolute = Now() - 1
	response.addHeader "pragma","no-cache"
	response.addHeader "cache-control","private"
	Response.CacheControl = "no-cache"
%>
<html>
<head>
<title>上传作品</title>
<script language="JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}
//-->
</script>
<link rel="stylesheet" href="CSS.asp" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=gb2312">
</head>
<body bgcolor=<%=web_bg%> class="sft"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<%if lockbbs="0" then %>
<br>

<table width="538" border="0" cellspacing="1" cellpadding="1" height="350" align="center" bgcolor="<%=td_bor%>" >
  <tr> 
    <td  align="center" height="14" bgcolor="<%=titlebg%>">&nbsp;</td>
  </tr>
  <tr> 
    <td  bgcolor="<%=bg_color%>" align="center" valign="top" nowrap height="338"> 
      <form name="form2" method="post" action="upload2.asp" enctype="multipart/form-data" target="">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="27%" align="right">&nbsp;</td>
            <td width="73%" align="">&nbsp;</td>
          </tr>
          <tr> 
            <td width="27%" align="right">&nbsp;</td>
            <td width="73%" align="">&nbsp;</td>
          </tr>
          <tr> 
            <td width="27%" align="right">请选择作品上传</td>
            <td width="73%" align=""> 
              <input type="file" name="sf_upfile" value="" onBlur="javascript:previewImg.src=sf_upfile.value" onMouseOut="javascript:previewImg.src=sf_upfile.value" size="28">
            </td>
          </tr>
          <tr> 
            <td width="27%" align="right" height="27">&nbsp;</td>
            <td width="73%" align="" height="27"><br>
              作品预览：<br>
            </td>
          </tr>
          <tr> 
            <td colspan="2" align="right"> 
              <div align="center"><img name="previewImg" alt="预览" border="0" class="img" src="noimage.gif"></div>
            </td>
          </tr>
          <tr> 
            <td width="27%" align="right" height="25">&nbsp;</td>
            <td width="73%" align="" height="25">&nbsp;</td>
          </tr>
          <tr> 
            <td width="27%" align="right" height="25"> 
              <div align="center">动作：</div>
            </td>
            <td width="73%" align="" height="25"> 
              <table width="320" border="0" cellspacing="1" cellpadding="1">
                <tr> 
                  <td> 
                    <input type="radio" name="paint" value="upload" checked>
                    <b>直接Upload发表作品</b></td>
                </tr>
                <tr> 
                  <td> 
                    <div align="left"><font color="#FF0000"><img src="../bbsimages/icon-style-zip.gif" width="26" height="21"><font color="#006699">用Java画板继续绘画(Upload 
                      to paint)</font></font></div>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <input type="radio" name="paint" value="painter">
                    <b>Shi Oekaki Painter(中文)</b></td>
                </tr>
                <tr> 
                  <td> 
                    <input type="radio" name="paint" value="painterpro">
                    <b>Shi Oekaki Painter Pro</b> </td>
                </tr>
                <tr> 
                  <td> 
                    <input type="radio" name="paint" value="oekakibbs">
                    <b>Poo Oekakibbs 2.64 </b> </td>
                </tr>
                <tr> 
                  <td>&nbsp; </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td colspan="2" align="right" height="30"> 
              <div align="center"><b><font color="#FF0000">警告</font></b>：继续绘画只支持<font color="#FF0000">JPG</font>格式图象， 
                请将格式转化成JPG后操作！ </div>
            </td>
          </tr>
          <tr> 
            <td width="27%" align="right">&nbsp;</td>
            <td width="73%" align=""> 
              <div align="left"> 
                <%if upload_yes="yes" then %>
                <input type="submit" name="submit" value="上 传" class="box">
                <input type="button" name="Button" value="返回" onClick="MM_goToURL('parent','javascript:history.back(1)');return document.MM_returnValue">
                <%end if %>
                <%if upload_yes="no" then %>
                <font color="#FF0000">对不起，上传功能已经关闭！</font> 
                <%end if %>
              </div>
            </td>
          </tr>
        </table>
      </form>
      <script language="javascript">
		            	<!--						
	            			var popupWin		         		
								function openPopupWin(wName) {
									if (!popupWin || popupWin.closed) {
										var left = screen.width/2-300;
										var top = screen.height/2-200;	
										popupWin = window.open("",wName, "resizable=false, scrollbars, left=" + left + ", top="+  top + ", width=618, height=400");		
									} else {
										popupWin.close
										openPopupWin(wName)
									}
								}
									
								function checkForm(){
									theForm = document.uploadImg;
									if (theForm.uploadFile.value=="") {
										alert("请选择作品缩小图！")
										theForm.uploadFile.focus()
									}
									if (!popupWin || popupWin.closed) {
										popupWin = window.open("","tangtang","height=1,width=1,top=6000,left=6000,")
										//popupWin = window.open("","tangtang","height=110,width=100,top=60,left=60,")
									} else {
										popupWin.close()
										popupWin = window.open("","tangtang","height=1,width=1,top=6000,left=6000,")
										//popupWin = window.open("","tangtang","height=110,width=100,top=60,left=60,")
									}
									theForm.target = "tangtang"
									theForm.submit();
									popupWin.focus()
								}
		            	-->
		            </script>
      <table width="100%" border="0" cellspacing="1" cellpadding="1">
        <tr> 
          <td width="16%">&nbsp;</td>
          <td width="84%">贴图须知：</td>
        </tr>
        <tr> 
          <td width="16%"> 
            <div align="right">1</div>
          </td>
          <td width="84%">允许上传类型：<b><font color="#FF0000">jpg&nbsp; png&nbsp; 
            gif</font></b> &nbsp;允许文件大小：<font color="#FF0000"><b><%=upload_sizemax%>KB</b></font></td>
        </tr>
        <tr> 
          <td width="16%"> 
            <div align="right">2</div>
          </td>
          <td width="84%">尽量发放原创作品。</td>
        </tr>
        <tr> 
          <td width="16%"> 
            <div align="right">3</div>
          </td>
          <td width="84%">禁止发放广告，打造良好的涂鸦板环境。</td>
        </tr>
        <tr> 
          <td width="16%"> 
            <div align="right">4</div>
          </td>
          <td width="84%">请把作品尺寸控制在<%=max_width%>×<%=max_height%>Pix 以下。</td>
        </tr>
        <tr> 
          <td width="16%"> 
            <div align="right"></div>
          </td>
          <td width="84%">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
<% else Response.Write "<font size=3 color=red>不能发表作品，涂鸦板被管理员锁定！</font>" end if%>
<br>
<br>
</body></html>