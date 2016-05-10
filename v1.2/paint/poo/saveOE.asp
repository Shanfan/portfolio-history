<% @ LANGUAGE="VBSCRIPT" %>
<%Option Explicit%>

<%
Response.Buffer = True 
Response.Expires = -1
Response.AddHeader "Pragma", "no-cache"
Response.AddHeader "cache-control", "no-store"
		dim i
		dim Pwidth,Pheight,picName,oebName
		dim formsize,formdata
		dim JPGids,PNGids
		dim lee,lee_1,lee_2,loeb
		dim imgStar,AniStar
		dim imgExt
		dim Extids
		dim istar_log,iend_log,istar,iend
		dim Imgids_log,Imgids
		dim loglen,imglen
		dim Ados,Ados1
		dim rs,sql
		dim a,b
		dim drawinfo_end,draw_info,splitinfo,spstr,str		
		dim ibyte,iASC,iascstr
		dim pass,nowpass

		formsize=clng(request.totalbytes)
		formdata=request.binaryread(formsize)

'=======计算图像字节位置和OEB 动画的字节位置
		a=":catalog/"
		b=":image/"
		for i=1 to 9
			Imgids_log=Imgids_log&chrB(ascB(mid(a,i,1)))
		next
		for i=1 to 7
			Imgids=Imgids&chrB(ascB(mid(b,i,1)))
		next
		JPGids=chrb(&HFF)& chrb(&HD8)& chrb(&HFF)& chrb(&HE0)& chrb(&H00)& chrb(&H10)'JPG start 标识
		PNGids=chrb(&H89)& chrb(&H50)& chrb(&H4E)& chrb(&H47)& chrb(&H0D)& chrb(&H0A) 'PNG start 标识
		imgStar=chrb(&HD)& chrb(&H0A)& chrb(&H0D)& chrb(&H0A)				'图像start 标记搜索点
		AniStar=chrb(&H50)&chrb(&H4F)& chrb(&H4F)& chrb(&H45)& chrb(&H4B)& chrb(&H41)'动画start 标记
		lee_2=inStrB(formdata,imgStar)				'头参考点1
		lee_1=inStrB(lee_2+4,formdata,imgStar)		'头参考点2
		istar_log=inStrB(formdata,Imgids_log)+5+9	'缩图起始点
		istar=inStrB(istar_log,formdata,Imgids)+5+7	'大图起始点
		iend_log=istar-24							'缩图终点
		loeb=inStrB(iend_log,formdata,AniStar)		'动画文件起点
		iend=loeb-29								'大图终点
		loglen=iend_log-istar_log					'缩图文件大小
		imglen=iend-istar							'大图文件大小
'---------------//

'====头部工具使用记录解码

		drawinfo_end=inStrB(1,formdata,chrB(&H43)&chrB(&H6F))-1 '绘画信息结束点
		draw_info=midB(formdata,3,istar_log)
		for i=1 to drawinfo_end-2
			ibyte=midB(draw_info,i,1)
			iASC=ascB(ibyte)
			if iASC<48 or iASC>57 then iASC=44
			iascstr=chr(iASC)
			spstr=spstr&iascstr
		next

'=====头部密码提取
		for i=lee_2+2 to lee_1-22
			pass=pass&chr(ascB(midB(draw_info,i,1)))
		next
		for i=lee_1+2 to istar_log-29
			nowpass=nowpass&chr(ascB(midB(draw_info,i,1)))
		next
'----------//
'========检测图像格式决定扩展名			
		Extids=midB(formdata,istar_log,6)
		Select Case Extids
			CASE JPGids imgExt="jpg"
			CASE PNGids imgExt="png"
		End Select
'----------------//
'========写图像数据库资料
		Pwidth=request.QueryString("wid")
		Pheight=request.QueryString("hgi")  
		
	
		''sql="insert into [img] (id,picName,oebName,piclog,img_width,img_height,draw_info,pass) values ("&id+1&",'"&picName&"','"&oebName&"','s"&picName&"',"&Pwidth&","&Pheight&",'"&spstr&"','"&pass&","&nowpass&"')"
		''CONN.execute sql


		
		
		

'-------------//

'========Create二个Stream对象
	set Ados=Server.CreateObject("Adodb.Stream")
		Ados.Mode=3
		Ados.Type=1
		Ados.Open
	set Ados1=Server.CreateObject("Adodb.Stream")
		Ados1.Mode=3
		Ados1.Type=1
		Ados1.Open
'-------------//	
'=========存文件部分

		Ados.write formdata '写form数据进入第一个对象
	
		'//Stream写.JPG或PNG缩图文件部分
if request.QueryString("Action")="save" and request.QueryString("pic")="" then 
 
  
         dim  pname 
		pname=year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)
        picName="oekaki"&pname&"."&imgExt
		oebName="oekaki"&pname&".oeb"
			Response.Cookies("picname")= picName
		Response.Cookies("oebname")= oebName
	
		
		
	
		 
		'Ados.position=istar_log-1
		'Ados.CopyTo Ados1,loglen
	 '	Ados1.SaveToFile Server.mappath("getpic/1.jpg"),2

		'//Stream写.JPG或PNG大图文件部分

		Ados1.setEos '设置当前Stream尾
		Ados.position=istar-1
		Ados.CopyTo Ados1,imglen
	 	Ados1.SaveToFile Server.mappath("picdata/"&picName),2

		'//Stream写.oeb动画文件部分

		Ados1.setEos '设置当前Stream尾
		Ados.position=loeb-1 
		Ados.CopyTo Ados1,formsize-loeb+1
		Ados1.SaveToFile Server.mappath("picdata/"&oebName),2
'--------------//			
		Ados.Close
		Ados1.close
	set Ados=nothing
	set Ados1=nothing

end if 




		   if request.QueryString("pic")<>"" and request.QueryString("pch")<>""then 
		   picName=request.QueryString("pic")
		   oebName=request.QueryString("pch")
		   
		   Ados1.setEos '设置当前Stream尾
		Ados.position=istar-1
		Ados.CopyTo Ados1,imglen
	 	Ados1.SaveToFile Server.mappath("picdata/"&picName),2

		'//Stream写.oeb动画文件部分

		Ados1.setEos '设置当前Stream尾
		Ados.position=loeb-1 
		Ados.CopyTo Ados1,formsize-loeb+1
		Ados1.SaveToFile Server.mappath("picdata/"&oebName),2
'--------------//			
		Ados.Close
		Ados1.close
	set Ados=nothing
	set Ados1=nothing
		   end if 
			
Function Search_End(str,charB,m)
	Search_End=inStrB(15,str,charB)+m
End Function
 
'------------------------------------------------
' Created by V37 //www.lfgbox.com//2003-2-15 5:24
'------------------------------------------------

%>

