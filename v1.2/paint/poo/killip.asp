<%
ip = Split(CStr(Request.ServerVariables("REMOTE_ADDR")),".")

ipf = Server.MapPath("killip.ini")
Set fso = CreateObject("Scripting.FileSystemObject")
Set ipf = fso.OpenTextFile(ipf)

DO While not ipf.AtEndOfStream
	strline = ipf.Readline
	If InStr(strline,"|")>0 then
		strkillip = Split(CStr(strline),"|")
		killip = Split(strkillip(0),".")
		if ip(0)=killip(0) and ip(1)=killip(1) and ip(2)=killip(2) then
			if (ip(3)=killip(3)) or (killip(3)="*") then
				Response.Write "<font color=#cc0066><b>��ʾ:</b><br><br>�ܱ�Ǹ,������IP��ַ��IP��ַ�α���Ϳѻ��Ĺ���Ա����,�����ʱ�޷�������Ʒ!<br><br>�����йصĺ�����IP��Χ:" & killip(0) & "." & killip(1) & "." & killip(2) & "." & killip(3) & "<br><br>����ԭ����:" & strkillip(1) & "</font><br><br><a href=../index.asp><font color=cc0066>����Ϳѻ����ҳ</font></a>"
				Response.End
			end if
		end if
	end if

Loop
ipf.close
Set fso = nothing
Set ipf = nothing
%>