<%
'图象上传和上传信息获取CLASS
'用法:
'set imgUp=new BoxInfoImg
'属性: 
'imgUp.width	'宽
'imgUp.height	'高
'imgUp.imgSize	'大小
'imgUp.imgType	'类型
'imgUp.fileName	'文件名
'imgUp.filepath	'上传初试路径目录
'imgUp.GetForm(formName)	'代替request.form的表单
'imgUp.GetFile(formName)	'文件名集合的表单
'方法:
'imgUp.saveImg(fullpath)	'保存图像文件
'imgUp.saveAs(fullpath)		'保存任意文件


Class BoxInfoImg

	dim ADOS_bin,ADOS,ADOS_text
	dim width,height,imgSize,imgType
	dim fileName,filepath
	dim GetForm,GetFile,Version
	
	Private Sub Class_Initialize
		set ADOS_bin=Server.CreateObject("Adodb.Stream")
			ADOS_bin.Type=1 
			ADOS_bin.Mode=3 
			ADOS_bin.Open 
		set ADOS=Server.CreateObject("Adodb.Stream")
			ADOS.Type=1 
			ADOS.Mode=3 
			ADOS.Open 
		set ADOS_text=Server.CreateObject("Adodb.Stream")
			ADOS_text.Type=1 
			ADOS_text.Mode=3 
			ADOS_text.Open 
		set GetForm=Server.CreateObject("Scripting.Dictionary")
			getImageSize
			addForm
	End Sub
	
	Private Sub Class_Terminate
		if Request.TotalBytes>0 then
			GetForm.RemoveAll
			GetFile.RemoveAll
			set GetForm=nothing
			set GetFile=nothing
		end if
		ADOS.Close
		ADOS_bin.close
		'ADOS_text.close
		set ADOS_bin=nothing
		set ADOS=nothing
		set ADOS_text=nothing
	End Sub

	Private Function Bin2Str(Bin)
		Dim I,Str,clow
		For I=1 to LenB(Bin)
			clow=MidB(Bin,I,1)
		if ASCB(clow)<128 then
			Str = Str & Chr(ASCB(clow))
		else
			I=I+1
			if I <= LenB(Bin) then Str = Str & Chr(ASCW(MidB(Bin,I,1)&clow))
		end if
		Next 
			Bin2Str = Str
	End Function

	Private Function Num2Str(num,base,lens)
		dim ret:ret = ""
		while(num>=base)
			ret=(num mod base) & ret
			num=(num - num mod base)/base
		wend
			Num2Str = right(string(lens,"0") & num & ret,lens)
	End Function

	Private Function Str2Num(str,base)
		dim ret:ret = 0
		for i=1 to len(str)
			ret = ret *base + cint(mid(str,i,1))
		next
			Str2Num=ret
	End Function

	Private Function BinVal(bin)
		dim ret:ret = 0
		for i = lenb(bin) to 1 step -1
			ret = ret *256 + ascb(midb(bin,i,1))
		next
			BinVal=ret
	End Function

	Private Function BinVal2(bin)
		dim ret:ret = 0
		for i = 1 to lenb(bin)
			ret = ret *256 + ascb(midb(bin,i,1))
		next
			BinVal2=ret
	End Function

	Public Function getImageSize() 
		dim ret(3),bFlag,istar,RequestData,ccc,fdata,fsize
		dim iend,isize
		dim imgStartChar
		dim imgEndChar
		dim filePathStartChar
		dim filePathEndChar
		dim filePathStart
		dim filePathEnd
		dim fstring
		dim NameData
			imgStartChar=chrb(&H0D) & chrb(&H0A) & chrb(&H0D) & chrb(&H0A)
			imgEndChar	=chrb(&H0D) & chrb(&H0A) & chrb(&H2D) & chrb(&H2D)
			
			filePathStartChar="filename="
			filePathEndChar="Content-Type"
			
			fsize=clng(Request.TotalBytes)
			fdata=Request.BinaryRead(fsize)
			
			ADOS.Write fdata
			ADOS.Position=0
			''ADOS.savetofile "d:\www\ccc",2

			ADOS.CopyTo ADOS_text,fsize
			ADOS_text.Position=0
			ADOS_text.Type=2
			ADOS_text.Charset ="gb2312"
			NameData=ADOS_text.ReadText
						
			filePathStart=InStr(1,NameData,filePathStartChar)+10
			
			filePathEnd=InStr(1,NameData,filePathEndChar)
			if filePathEnd>3 then filePathEnd=filePathEnd-3
			
			'上传本地文件名路径
			Fstring=mid(NameData,filePathStart,filePathEnd-filePathStart)
			
			'response_write NameData,1
			'response_write filePathStart,1
			'response_write filePathEnd,1
			'response_write filePathEnd-filePathStart,1
			'response_write Fstring,0

			istar= InStrB(filePathEnd,fdata,imgStartChar)+3
			iend= InStrB(istar,fdata,imgEndChar)-1
			isize=iend-istar
			
			ADOS.Position=istar
			ADOS.CopyTo ADOS_bin,isize
			ADOS_bin.Position=0 '重置数据开始位置 
			bFlag=ADOS_bin.read(3)
			
			if isNull(bFlag) then 
				width=0
				height=0
				imgSize=0
				imgType="unknow"
				fileName=getfileName(Fstring)
				filePath=getfilePath(Fstring)
				ret(0)=imgType:ret(1)=width:ret(2)=height:ret(3)=""
				getimagesize=ret
				exit function
			end if
		
			select case hex(binVal(bFlag))
			case "4E5089":
				ADOS_bin.read(15)
				ret(0)="PNG"
				ret(1)=BinVal2(ADOS_bin.read(2))
				ADOS_bin.read(2)
				ret(2)=BinVal2(ADOS_bin.read(2))
			case "464947":
				ADOS_bin.read(3)
				ret(0)="GIF"
				ret(1)=BinVal(ADOS_bin.read(2))
				ret(2)=BinVal(ADOS_bin.read(2))
			case "FFD8FF":
				dim p1
				do 
				do: p1=binVal(ADOS_bin.Read(1)): loop while p1=255 and not ADOS_bin.EOS
				if p1>191 and p1<196 then exit do else ADOS_bin.read(binval2(ADOS_bin.Read(2))-2)
				do:p1=binVal(ADOS_bin.Read(1)):loop while p1<255 and not ADOS_bin.EOS
			loop while true
				ADOS_bin.Read(3)
				ret(0)="JPG"
				ret(2)=binval2(ADOS_bin.Read(2))
				ret(1)=binval2(ADOS_bin.Read(2))
			
			case "535746":
				dim binData,sConv,nBits
				ADOS_bin.read(5)
				binData=ADOS_bin.Read(1)
			'response_write "0--"&ascb(binData),1
			'response_write hex(ascb(binData)),1
				sConv=Num2Str(ascb(binData),2 ,8)
				nBits=Str2Num(left(sConv,5),2)
			'response_write "1--"&sConv,1
				sConv=mid(sConv,6)
			'response_write "2--"&sConv,1
				while(len(sConv)<=16)
					binData=ADOS_bin.Read(1)
				'while(len(sConv) binData=ADOS_bin.Read(1)
				'while binData=ADOS_bin.Read(1)
					sConv=sConv&Num2Str(ascb(binData),2 ,8)
			'response_write "cc--"&sConv,1
				wend
				ret(0)="SWF"
				ret(1)=int(abs(Str2Num(mid(sConv,1*nBits+1,nBits),2)-Str2Num(mid(sConv,0*nBits+1,nBits),2))/20)
				ret(2)=int(abs(Str2Num(mid(sConv,3*nBits+1,nBits),2)-Str2Num(mid(sConv,2*nBits+1,nBits),2))/20)		
				ret(1)=400
				ret(2)=400
			'	response_write 	Str2Num(mid(sConv,2*nBits+1,nBits),2),1
			'	response_write "十进制to2进制"&Num2Str(3,2,8),1
			'	response_write "2进制to十进制"&Str2Num(11111111,2),1
			'	response_write "2进制to十进制"&Str2Num(sConv,2),1
			'	response_write ret(0),1
			'	response_write "nBits:"&nBits,1
			'	response_write "宽:"&ret(1),1
			'	response_write "高:"&ret(2),1
			'	response_write sConv,1
			'	response.end
			case else:
				if left(Bin2Str(bFlag),2)="BM" then
					ADOS_bin.Read(15)
					ret(0)="BMP"
					ret(1)=binval(ADOS_bin.Read(4))
					ret(2)=binval(ADOS_bin.Read(4))
				else
					ret(0)=""
				end if
			end select

			Select case ret(0)
			case "PNG","JPG","BMP","GIF","SWF"
				width=ret(1)
				height=ret(2)
				imgSize=isize
				imgType=ret(0)
				fileName=getfileName(Fstring)
				filePath=getfilePath(Fstring)
			case else
				width=0
				height=0
				imgSize=0
				imgType="unknow"
				fileName=""
				filePath=""
			end select 
			getimagesize=ret
	End Function

	Public function SaveImg(FullPath)
		SaveImg=false
		if trim(fullpath)="" or _
			width=0 or _ 
			height=0 or _
			imgSize=0 or _
			imgType="unknow" or _
			right(fullpath,1)="/" then exit function end if
		ADOS_bin.Position=0
			'on error resume next
		ADOS_bin.SaveToFile FullPath,2
			'if err.number<>0 then GetError Err.Description
			'on error goto 0
		SaveImg=true
	End function

	Private function GetFilePath(FullPath)
	If FullPath <> "" Then
		GetFilePath = left(FullPath,InStrRev(FullPath, "\"))
	Else
		GetFilePath = ""
	End If
	End  function
	
	Private function GetFileName(FullPath)
	If FullPath <> "" Then
		GetFileName = mid(FullPath,InStrRev(FullPath, "\")+1)
	Else
		GetFileName = ""
	End If
	End  function

	Private Sub addForm()
	  dim RequestData,sStart,vbCrlf,sInfo,iInfoStart,iInfoEnd,iStart,theFile
	  dim iFileSize,sFilePath,sFileType,sFormValue,sFileName
	  dim iFindStart,iFindEnd
	  dim iFormStart,iFormEnd,sFormName
	  Version="Fast Version 2.0"
	  set GetForm=Server.CreateObject("Scripting.Dictionary")
	  set GetFile=Server.CreateObject("Scripting.Dictionary")
	  if Request.TotalBytes<1 then Exit Sub
	  set ADOS_text = Server.CreateObject("adodb.stream")
	  ADOS.Position=0
	  RequestData =ADOS.Read 

	  iFormStart = 1
	  iFormEnd = LenB(RequestData)
	  vbCrlf = chrB(13) & chrB(10)
	  sStart = MidB(RequestData,1, InStrB(iFormStart,RequestData,vbCrlf)-1)
	  iStart = LenB (sStart)
	  iFormStart=iFormStart+iStart+1
	  while (iFormStart + 10) < iFormEnd 
		iInfoEnd = InStrB(iFormStart,RequestData,vbCrlf & vbCrlf)+3
		ADOS_text.Type = 1
		ADOS_text.Mode =3
		ADOS_text.Open
		ADOS.Position = iFormStart
		ADOS.CopyTo ADOS_text,iInfoEnd-iFormStart
		ADOS_text.Position = 0
		ADOS_text.Type = 2
		ADOS_text.Charset ="gb2312"
		sInfo = ADOS_text.ReadText
		ADOS_text.Close
		'取得表单项目名称
		iFormStart = InStrB(iInfoEnd,RequestData,sStart)
		iFindStart = InStr(22,sInfo,"name=""",1)+6
		iFindEnd = InStr(iFindStart,sInfo,"""",1)
		'sFormName = lcase(Mid (sinfo,iFindStart,iFindEnd-iFindStart))
		sFormName = Mid (sinfo,iFindStart,iFindEnd-iFindStart)
		'如果是文件
		if InStr (45,sInfo,"filename=""",1) > 0 then
			set theFile=new FileInfo
			'取得文件名
			iFindStart = InStr(iFindEnd,sInfo,"filename=""",1)+10
			iFindEnd = InStr(iFindStart,sInfo,"""",1)
			sFileName = Mid (sinfo,iFindStart,iFindEnd-iFindStart)
			theFile.FileName=getFileName(sFileName)
			theFile.FilePath=getFilePath(sFileName)
			'取得文件类型
			iFindStart = InStr(iFindEnd,sInfo,"Content-Type: ",1)+14
			iFindEnd = InStr(iFindStart,sInfo,vbCr)
			theFile.FileType =Mid (sinfo,iFindStart,iFindEnd-iFindStart)
			theFile.FileStart =iInfoEnd
			theFile.FileSize = iFormStart -iInfoEnd -3
			theFile.FormName=sFormName
			if not GetFile.Exists(sFormName) then
			  GetFile.add sFormName,theFile
			end if
		else
		'如果是表单项目
			ADOS_text.Type =1
			ADOS_text.Mode =3
			ADOS_text.Open
			ADOS.Position = iInfoEnd 
			ADOS.CopyTo ADOS_text,iFormStart-iInfoEnd-3
			ADOS_text.Position = 0
			ADOS_text.Type = 2
			ADOS_text.Charset ="gb2312"
				sFormValue = ADOS_text.ReadText 
				ADOS_text.Close
			if GetForm.Exists(sFormName) then
			  GetForm(sFormName)=GetForm(sFormName)&", "&sFormValue		  
			else
			  GetForm.Add sFormName,sFormValue
			end if
		end if
		iFormStart=iFormStart+iStart+1
		wend
	  RequestData=""
	  set ADOS_text =nothing
	End Sub

	Public function Form(strForm)
	   'strForm=lcase(strForm)
	   strForm=strForm
	   if not GetForm.exists(strForm) then
		 Form=""
	   else
		 Form=GetForm(strForm)
	   end if
	 end function

	Public function File(strFile)
	   'strFile=lcase(strFile)
	   if not GetFile.exists(strFile) then
		 set File=new FileInfo
	   else
		 set File=GetFile(strFile)
	   end if
	end function
End Class

CLASS FileInfo

		dim FormName,FileName,FilePath,FileSize,FileType,FileStart
		Private Sub CLASS_Initialize 
			FileName = ""
			FilePath = ""
			FileSize = 0
			FileStart= 0
			FormName = ""
			FileType = ""
		End Sub
		  
		Public function SaveAs(FullPath)
			dim dr,ErrorChar,i
			SaveAs=true
			if trim(fullpath)="" or FileStart=0 or FileName="" or right(fullpath,1)="/" then exit function
			set dr=CreateObject("Adodb.Stream")
			dr.Mode=3
			dr.Type=1
			dr.Open
			ADOS.position=FileStart
			ADOS.copyto dr,FileSize
			dr.SaveToFile FullPath,2
			dr.Close
			set dr=nothing 
			SaveAs=false
		end function

End CLASS
%>
<html>
<head>

<link rel="stylesheet" href="fso/css_s.css" type="text/css">
<title>sorry!</title></head>
<body bgcolor="#FFFFFF" class="sft"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<!--#include FILE="user.asp"-->
<div align="center"><br>
  <br>
  <%
UpLoadSize=upload_sizemax
dim imgUp,max_height,max_width
max_w=max_width 
max_h=max_height


set imgUp=new BoxInfoImg
if imgUp.imgType<>"JPG" and imgUp.imgType<>"JPEG" and imgUp.imgType<>"PNG" and imgUp.imgType<>"GIF" then
	response.write "错误:上传的文件格式不对! "&imgUp.imgType&"<a href='javascript:history.go(-1)'>退回上一步</a>"
	response.end
end if

if imgUp.width>max_w or imgUp.height>max_h then
	response.write "图象尺寸太大!"&imgUp.width&"X"&imgUp.height&" <a href='javascript:history.go(-1)'>退回上一步</a>"
	response.end
end if

if imgUp.imgSize<10 or imgUp.imgSize>UpLoadSize*1024 then
	response.write "错误:上传的图片大小超过了限制!"&uploadsize&"KB以下 <a href='javascript:history.go(-1)'>退回上一步</a>"
	response.end
end if


	
ufp="Upload_"&year(now)&month(now)&day(now)&hour(now)&minute(now)&second(now)&"."&imgUp.imgType
imgUp.saveImg server.mappath("picdata/"&ufp)

paint=imgUp.GetForm("paint")
response.Cookies("Uploadname")=ufp
response.Cookies("upw")=imgUp.width
response.Cookies("uph")=imgUp.height
response.Cookies("filesize")=formatnumber(imgUp.imgSize/1024,2,-1)
Response.Redirect("getupload.asp?upload_picname="&ufp&"&w="&imgUp.width&"&h="&imgUp.height&"&filesize="&formatnumber(imgUp.imgSize/1024,2,-1)&"&paint="&paint&"&imgtype="&imgUp.imgType&"")
%>




</div>
</body></html>
