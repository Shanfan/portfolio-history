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
				Response.Write "<font color=#cc0066><b>提示:</b><br><br>很抱歉,由于你IP地址或IP地址段被本涂鸦板的管理员封锁,因此暂时无法发表作品!<br><br>与您有关的黑名单IP范围:" & killip(0) & "." & killip(1) & "." & killip(2) & "." & killip(3) & "<br><br>封锁原因是:" & strkillip(1) & "</font><br><br><a href=../index.asp><font color=cc0066>返回涂鸦板主页</font></a>"
				Response.End
			end if
		end if
	end if

Loop
ipf.close
Set fso = nothing
Set ipf = nothing
%>