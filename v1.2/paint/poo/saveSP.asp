<%@LANGUAGE="VBSCRIPT"%>
<%Option Explicit
'=====///程序编制：V37 (LFGBOX.COM)
'====///代码修订于：2003-7-16 Created by V37 From WWW.LFGBOX.COM================
'====///编写for Shi-Painter And Shi-Painter Pro 1.02_6 ASP 接口=================
'====///接口代码修订版本3.0 (Shi-Painter的全方位保存支持)=======================
'====///缩图，动画，大图，PNG JPG PCH SPCH)=====================================
'====///原则代码仅仅提供给如下Asp程序使用:======================================
'========(1)PaintBlue BBS 1.X 以上 涂丫论坛(From FLGBOX.COM Created by V37)=====
'========(2)PooBBS 3.X 以上涂丫板 (From poo.webfeng.net Create by Chi)==========
'=========如果你移植本代码到第三方程序，请完整保留以上信息======================

Response.Buffer = True 
Response.Expires = 0
Response.AddHeader "Pragma", "no-cache"
Response.AddHeader "cache-control", "no-store" 

Call SaveImg(Request.QueryString("PType")) 
'jpg: Call SaveImg("jpg")
'png: Call SaveImg("png")
'Request.QueryString("PType")是提交页面传过来的字串,"jpg"或"png"

SUB	SaveImg(imgType) 'imType="png"则保存为png格式	
		
		dim logExt
		dim imgExt
		
		Select CASE imgType
		CASE "png"
			imgExt="png"
			logExt="png"
		CASE "jpg"
			imgExt="jpg"
			logExt="jpg"
		End Select
		
		dim picName,AniName,logName
		dim formsize,formdata
		dim Ados,Ados1

	
		formsize=clng(request.totalbytes)
		formdata=request.binaryread(formsize)
		
		dim spchstart
		dim iStart,iEnd,imglen
		dim logStart,logEnd,loglen,spchlen
		
		iStart=Search_ids(1,formdata,imgExt,0)
		iEnd=Search_ids(iStart,formdata,imgExt,1)
	
		spchstart=Search_ids(iEnd,formdata,"spch",0)
		logStart=Search_ids(spchstart,formdata,logExt,0)
		logEnd=Search_ids(logStart,formdata,logExt,1)

		Select Case imgExt
		Case "jpg"  imglen=iEnd-iStart+2
		Case "png"  imglen=iEnd-iStart+8
		end select
		Select Case logExt
		Case "jpg"  loglen=logEnd-logStart+2
		Case "png"  loglen=logEnd-logStart+8
		end select
		spchlen=logStart-spchstart



		picName=Request.QueryString("pic")'"SPro."&imgExt 
		AniName=Request.QueryString("pch")
	
    
	'	logName="SPro."&logExt

		set Ados=Server.CreateObject("Adodb.Stream")
			Ados.Mode=3
			Ados.Type=1
			Ados.Open
		set Ados1=Server.CreateObject("Adodb.Stream")
			Ados1.Mode=3
			Ados1.Type=1
			Ados1.Open

        Ados.write formdata
		'Ados.SaveToFile Server.mappath("PicData/"&imglen&"_"&loglen&"_"&spchlen),2
		'Ados.SaveToFile Server.mappath("PicData/PaintFormdata"),2

	'----Stream写.JPG图像文件部分----------
			Ados.position=iStart-1  '6数值
			Ados.CopyTo Ados1,imglen
		 	Ados1.SaveToFile Server.mappath("PicData/"&picName),2
	
	'----Stream写.spch动画文件部分---------------
			Ados1.setEos '设置当前Stream尾
			Ados.position=spchstart-1  '6数值
			Ados.CopyTo Ados1,spchlen
		 	Ados1.SaveToFile Server.mappath("PicData/"&AniName),2
	
	'----Stream写. logJPG图像文件部分----------
			'Ados1.setEos '设置当前Stream尾
			'Ados.position=logStart-1  '6数值
			'Ados.CopyTo Ados1,loglen
		 	'Ados1.SaveToFile Server.mappath("PicData/"&logName),2

			Ados.Close
			Ados1.close
		set Ados=nothing
		set Ados1=nothing
End SUB	



Function Search_ids(start,str,stype,loc)
	'此搜索PNG结束标志，HEX为下49 45 4E 44 Ae 42 60 82
	'Search_End=instrb(15,str,chrb(&H49) & chrb(&H45) & chrb(&H4E) & chrb(&H44) & chrb(&HAE) & chrb(&H42))+1
	dim pchstar,pngend,iChar,PNGstart
	dim JPGstart,JPGend,SPCHstar
	PCHstar=chrb(&H1F) & chrb(&H8B) & chrb(&H08) & chrb(&H00) & chrb(&H00) & chrb(&H00) & chrb(&H00) & chrb(&H00)
	PNGstart=chrb(&H89) & chrb(&H50) & chrb(&H4E) & chrb(&H47) & chrb(&H0D) & chrb(&H0A) ' PNG start 标识
	PNGend=chrb(&H49) & chrb(&H45) & chrb(&H4E) & chrb(&H44) & chrb(&HAE) & chrb(&H42) & chrb(&H60) & chrb(&H82)

	
	SPCHstar=chrb(&H6C) & chrb(&H61) & chrb(&H79) & chrb(&H65) & chrb(&H72) & chrb(&H5F) & chrb(&H63) & chrb(&H6F)
	JPGstart=chrb(&HFF) & chrb(&HD8) & chrb(&HFF) & chrb(&HE0) & chrb(&H00) & chrb(&H10)'JPG start 标识
	JPGend=chrb(&HFF) & chrb(&HD9)
	
	Select CASE stype
	case "png"
		if loc=0 then
			iChar=PNGstart
		else
			iChar=PNGend
		end if
	case "jpg"
		if loc=0 then
			iChar=JPGstart
		else
			iChar=JPGend
		end if
	case "pch" iChar=PCHstar
	case "spch" iChar=SPCHstar
	end select
	Search_ids=instrb(start,str,iChar) '完整标记
End Function
%>