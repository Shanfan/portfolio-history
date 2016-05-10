<% @ LANGUAGE="VBSCRIPT" %>


<%
 
'====///2003-3-10 Created by V37 From WWW.LFGBOX.COM  =============
 Option Explicit

Response.Buffer = True 
Response.Expires = 0
Response.AddHeader "Pragma", "no-cache"
Response.AddHeader "cache-control", "no-store" 

if Request.QueryString("action")="save"  then
Call SaveImg()


SUB SaveIMG()
        dim pchname,picname
		dim formsize,formdata
		dim imgExt
		dim pchstart,iStart,iEnd,imglen
	    dim logStart,logEnd,loglen,pchlen
		dim Ados,Ados1
		
		
		formsize=clng(request.totalbytes)
		formdata=request.binaryread(formsize)
		
		iStart=Search_ids(1,formdata,"png",0)
		iEnd=Search_ids(iStart,formdata,"png",1)
		pchstart=Search_ids(iEnd,formdata,"pch",0)


		imglen=iEnd-iStart+8
    
		imgExt="png"
		

		picname=Request.QueryString("pic")
		pchname=Request.QueryString("pch")

	
			
		set Ados=Server.CreateObject("Adodb.Stream")
			Ados.Mode=3
			Ados.Type=1
			Ados.Open
		set Ados1=Server.CreateObject("Adodb.Stream")
			Ados1.Mode=3
			Ados1.Type=1
			Ados1.Open
		
        Ados.write formdata
		
		
	'----Stream写.PNG图像文件部分----------
			Ados.position=iStart-1  '6数值
			Ados.CopyTo Ados1,imglen
		 	Ados1.SaveToFile Server.mappath("PicData/"&picName),2

	'----Stream写.pch动画文件部分---------------
			Ados1.setEos '设置当前Stream尾
			Ados.position=pchstart-1  'old imglen+9
			Ados.CopyTo Ados1
			Ados1.SaveToFile Server.mappath("PicData/"&pchName),2
			
		

		  
			Ados.Close
			Ados1.close
		set Ados=nothing
		set Ados1=nothing
'--------------//
		
		'response.end
End SUB

Function Search_ids(start,str,stype,loc)
	'此搜索PNG结束标志，HEX为下49 45 4E 44 Ae 42 60 82
	'Search_End=instrb(15,str,chrb(&H49) & chrb(&H45) & chrb(&H4E) & chrb(&H44) & chrb(&HAE) & chrb(&H42))+1
	dim pchstar,pngend,iChar,PNGstart
	PCHstar=chrb(&H1F) & chrb(&H8B) & chrb(&H08) & chrb(&H00) & chrb(&H00) & chrb(&H00) & chrb(&H00) & chrb(&H00)
	PNGstart=chrb(&H89) & chrb(&H50) & chrb(&H4E) & chrb(&H47) & chrb(&H0D) & chrb(&H0A) ' PNG start 标识
	PNGend=chrb(&H49) & chrb(&H45) & chrb(&H4E) & chrb(&H44) & chrb(&HAE) & chrb(&H42) & chrb(&H60) & chrb(&H82)
	if stype="png" then 
		if loc=0 then
			iChar=PNGstart
		else
			iChar=PNGend
		end if
	elseif stype="pch"then
		iChar=PCHstar
	end if
	Search_ids=instrb(start,str,iChar) '完整标记
end Function
end if
%>



