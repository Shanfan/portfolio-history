<%@ LANGUAGE="VBSCRIPT" %><!--#include file="color.asp" -->
<title>Ϳѻ��ռ��ʹ�����</title>
<style type="text/css">
table {  font-size: 9pt}
BODY { FONT-FAMILY: ����; FONT-SIZE: 9pt;
SCROLLBAR-HIGHLIGHT-COLOR: buttonface;
SCROLLBAR-SHADOW-COLOR: buttonface;
SCROLLBAR-3DLIGHT-COLOR: buttonhighlight;
SCROLLBAR-TRACK-COLOR: #eeeeee;
SCROLLBAR-DARKSHADOW-COLOR: buttonshadow}
</STYLE>
<meta NAME=GENERATOR Content=""Microsoft FrontPage 3.0"" CHARSET=GB2312>
<body bgcolor="<%=web_bg%>" text="#000000" background="<%=web_bgimg%>">
<tr>
    
  <td> 
    <tr bgcolor='#EEEEEE'><td align=center colspan="2">&nbsp;</td>
        </tr>
            <tr bgcolor=#FFFFFF>
              <td width="80%" valign=top>

 <% 	
 	Sub ShowSpaceInfo(drvpath)
 		dim fso,d,size,showsize
 		set fso=server.createobject("scripting.filesystemobject") 		
 		drvpath=server.mappath(drvpath) 		 		
 		set d=fso.getfolder(drvpath) 		
 		size=d.size
 		showsize=size & "&nbsp;Byte" 
 		if size>1024 then
 		   size=(size\1024)
 		   showsize=size & "&nbsp;KB"
 		end if
 		if size>1024 then
 		   size=(size/1024)
 		   showsize=formatnumber(size,2) & "&nbsp;MB"		
 		end if
 		if size>1024 then
 		   size=(size/1024)
 		   showsize=formatnumber(size,2) & "&nbsp;GB"	   
 		end if   
 		response.write "<font face=verdana>" & showsize & "</font>"
 	End Sub	
 	
 	Sub Showspecialspaceinfo(method)
 		dim fso,d,fc,f1,size,showsize,drvpath 		
 		set fso=server.createobject("scripting.filesystemobject")
 		drvpath=server.mappath("images1")
 		drvpath=left(drvpath,(instrrev(drvpath,"\")-1))
 		set d=fso.getfolder(drvpath) 		
 		
 		if method="All" then 		
 			size=d.size
 		elseif method="Program" then
 			set fc=d.Files
 			for each f1 in fc
 				size=size+f1.size
 			next	
 		end if	
 		
 		showsize=size & "&nbsp;Byte" 
 		if size>1024 then
 		   size=(size\1024)
 		   showsize=size & "&nbsp;KB"
 		end if
 		if size>1024 then
 		   size=(size/1024)
 		   showsize=formatnumber(size,2) & "&nbsp;MB"		
 		end if
 		if size>1024 then
 		   size=(size/1024)
 		   showsize=formatnumber(size,2) & "&nbsp;GB"	   
 		end if   
 		response.write "<font face=verdana>" & showsize & "</font>"
 	end sub 	 	 	
 	
 	Function Drawbar(drvpath)
 		dim fso,drvpathroot,d,size,totalsize,barsize
 		set fso=server.createobject("scripting.filesystemobject")
 		drvpathroot=server.mappath("images1")
 		drvpathroot=left(drvpathroot,(instrrev(drvpathroot,"\")-1))
 		set d=fso.getfolder(drvpathroot)
 		totalsize=d.size
 		
 		drvpath=server.mappath(drvpath) 		
 		set d=fso.getfolder(drvpath)
 		size=d.size
 		
 		barsize=cint((size/totalsize)*400)
 		Drawbar=barsize
 	End Function 	
 	
 	Function Drawspecialbar()
 		dim fso,drvpathroot,d,fc,f1,size,totalsize,barsize
 		set fso=server.createobject("scripting.filesystemobject")
 		drvpathroot=server.mappath("images1")
 		drvpathroot=left(drvpathroot,(instrrev(drvpathroot,"\")-1))
 		set d=fso.getfolder(drvpathroot)
 		totalsize=d.size
 		
 		set fc=d.files
 		for each f1 in fc
 			size=size+f1.size
 		next	
 		
 		barsize=cint((size/totalsize)*400)
 		Drawspecialbar=barsize
 	End Function 	
 %>

 			
    <table width=659 cellspacing=1 cellpadding=0 bgcolor=#FFFFFF align="center">
      <tr>
  					
            
        <td bgcolor=#CCCCCC> &nbsp;&nbsp; 
          <div align="center">Ϳѻ������ռ�ÿռ����,<b><font color="#FF0000">PICdata</font></b>ΪͿѻ��Ʒ�����ļ���</div>
            </td>
  				</tr> 	
 				<tr>
 					
        <td bgcolor=#999999> 
          <blockquote><br>
            <%
Function TestObj(Str)
On Error Resume Next
TestObj = False
Err.Description = ""
Set TObj = Server.CreateObject(Str)
If Err.Description = "" Then TestObj = True
Set TObj = Nothing
End Function
%>
            <%if not TestObj("Scripting.FileSystemObject") then
	%>
            ��������֧��<font color="#FF0000">fso</font>,�㽫��������ʹ��Ϳѻ�壡�����̨���ñ����ɾ����Ʒ�ȣ� 
            <%
end if %>
            <%if  TestObj("Scripting.FileSystemObject") then
	%>
            ������֧��<font color="#FF0000">FSO</font>����������ʹ��Ϳѻ�壡 
            <%
end if %>
            <br>
            ADO�汾��<font color="#FF0000"> 
            <% 
set myConn = Server.CreateObject("ADODB.Connection")
strConn = myConn.Version
set myConn = Nothing
Response.Write(strConn)
%>
            </font> (ADO�汾2.5����߲��ܱ���ͼ������) 
            <%
 			fsoflag=1
 			if fsoflag=1 then
 			%>
 			<br>
 			<%Function GetPP
 				dim s
 				s=Request.ServerVariables("path_translated")
 				GetPP=left(s,instrrev(s,"\",len(s)))
 			End function
 			if sPP="" then sPP=GetPP
 			if right(sPP,1)<>"\" then sPP=sPP&"\"
 			set fso=server.createobject("scripting.filesystemobject")
 			Set f = fso.GetFolder(sPP)
 			Set fc = f.SubFolders
 			i=1
                        i2=1
 			For Each f in fc%>
            <b>	<%if f.name ="picdata" or f.name="Picdata" or f.name="PICDATA"  then %><%=f.name%>(��Ʒ���ݴ�С)</b>��<img src="pic/bar<%=i2%>.gif" width=<%=drawbar(""&f.name&"")%> height=10 border="1">&nbsp; 
            <%showSpaceinfo(""&f.name&"")%><%end if %>
	
            <%i=i+1
                          if i2<10 then
 			    i2=i2+1
                          else
                            i2=1
                          end if
 					Next%>
            <br>
            Ϳѻ����ռ�ã�<img src="pic/bar8.gif" width=<%=drawspecialbar%> height=10 border="1">&nbsp; 
            <%showSpecialSpaceinfo("Program")%>
            <br>
            <br>
            ռ�ÿռ��ܼƣ�<img src="pic/bar9.gif" width=400 height=10 border="1"> 
            <%showspecialspaceinfo("All")%>
            <%
 			else
 				response.write "<br><li>�������Ѿ����ر�"
 			end if
 			%>
            <br>
          </blockquote>
 					</td>
 				</tr>
 			</table>
 		
    <div align="center"></div>
  </td>