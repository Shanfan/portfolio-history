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

'=======����ͼ���ֽ�λ�ú�OEB �������ֽ�λ��
		a=":catalog/"
		b=":image/"
		for i=1 to 9
			Imgids_log=Imgids_log&chrB(ascB(mid(a,i,1)))
		next
		for i=1 to 7
			Imgids=Imgids&chrB(ascB(mid(b,i,1)))
		next
		JPGids=chrb(&HFF)& chrb(&HD8)& chrb(&HFF)& chrb(&HE0)& chrb(&H00)& chrb(&H10)'JPG start ��ʶ
		PNGids=chrb(&H89)& chrb(&H50)& chrb(&H4E)& chrb(&H47)& chrb(&H0D)& chrb(&H0A) 'PNG start ��ʶ
		imgStar=chrb(&HD)& chrb(&H0A)& chrb(&H0D)& chrb(&H0A)				'ͼ��start ���������
		AniStar=chrb(&H50)&chrb(&H4F)& chrb(&H4F)& chrb(&H45)& chrb(&H4B)& chrb(&H41)'����start ���
		lee_2=inStrB(formdata,imgStar)				'ͷ�ο���1
		lee_1=inStrB(lee_2+4,formdata,imgStar)		'ͷ�ο���2
		istar_log=inStrB(formdata,Imgids_log)+5+9	'��ͼ��ʼ��
		istar=inStrB(istar_log,formdata,Imgids)+5+7	'��ͼ��ʼ��
		iend_log=istar-24							'��ͼ�յ�
		loeb=inStrB(iend_log,formdata,AniStar)		'�����ļ����
		iend=loeb-29								'��ͼ�յ�
		loglen=iend_log-istar_log					'��ͼ�ļ���С
		imglen=iend-istar							'��ͼ�ļ���С
'---------------//

'====ͷ������ʹ�ü�¼����

		drawinfo_end=inStrB(1,formdata,chrB(&H43)&chrB(&H6F))-1 '�滭��Ϣ������
		draw_info=midB(formdata,3,istar_log)
		for i=1 to drawinfo_end-2
			ibyte=midB(draw_info,i,1)
			iASC=ascB(ibyte)
			if iASC<48 or iASC>57 then iASC=44
			iascstr=chr(iASC)
			spstr=spstr&iascstr
		next

'=====ͷ��������ȡ
		for i=lee_2+2 to lee_1-22
			pass=pass&chr(ascB(midB(draw_info,i,1)))
		next
		for i=lee_1+2 to istar_log-29
			nowpass=nowpass&chr(ascB(midB(draw_info,i,1)))
		next
'----------//
'========���ͼ���ʽ������չ��			
		Extids=midB(formdata,istar_log,6)
		Select Case Extids
			CASE JPGids imgExt="jpg"
			CASE PNGids imgExt="png"
		End Select
'----------------//
'========дͼ�����ݿ�����
		Pwidth=request.QueryString("wid")
		Pheight=request.QueryString("hgi")  
		
	
		''sql="insert into [img] (id,picName,oebName,piclog,img_width,img_height,draw_info,pass) values ("&id+1&",'"&picName&"','"&oebName&"','s"&picName&"',"&Pwidth&","&Pheight&",'"&spstr&"','"&pass&","&nowpass&"')"
		''CONN.execute sql


		
		
		

'-------------//

'========Create����Stream����
	set Ados=Server.CreateObject("Adodb.Stream")
		Ados.Mode=3
		Ados.Type=1
		Ados.Open
	set Ados1=Server.CreateObject("Adodb.Stream")
		Ados1.Mode=3
		Ados1.Type=1
		Ados1.Open
'-------------//	
'=========���ļ�����

		Ados.write formdata 'дform���ݽ����һ������
	
		'//Streamд.JPG��PNG��ͼ�ļ�����
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

		'//Streamд.JPG��PNG��ͼ�ļ�����

		Ados1.setEos '���õ�ǰStreamβ
		Ados.position=istar-1
		Ados.CopyTo Ados1,imglen
	 	Ados1.SaveToFile Server.mappath("picdata/"&picName),2

		'//Streamд.oeb�����ļ�����

		Ados1.setEos '���õ�ǰStreamβ
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
		   
		   Ados1.setEos '���õ�ǰStreamβ
		Ados.position=istar-1
		Ados.CopyTo Ados1,imglen
	 	Ados1.SaveToFile Server.mappath("picdata/"&picName),2

		'//Streamд.oeb�����ļ�����

		Ados1.setEos '���õ�ǰStreamβ
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

