<!--#include file="color.asp" --><!--#include file="user.asp" -->
<HTML>
<HEAD>
<TITLE>设置画板</TITLE> <META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=gb2312"> 
<LINK REL="stylesheet" HREF="CSS.asp" TYPE="text/css"> 
<script language="JavaScript">
<!--
function MM_goToURL() { //v3.0
  var i, args=MM_goToURL.arguments; document.MM_returnValue = false;
  for (i=0; i<(args.length-1); i+=2) eval(args[i]+".location='"+args[i+1]+"'");
}

function MM_findObj(n, d) { //v4.01
  var p,i,x;  if(!d) d=document; if((p=n.indexOf("?"))>0&&parent.frames.length) {
    d=parent.frames[n.substring(p+1)].document; n=n.substring(0,p);}
  if(!(x=d[n])&&d.all) x=d.all[n]; for (i=0;!x&&i<d.forms.length;i++) x=d.forms[i][n];
  for(i=0;!x&&d.layers&&i<d.layers.length;i++) x=MM_findObj(n,d.layers[i].document);
  if(!x && d.getElementById) x=d.getElementById(n); return x;
}

function YY_checkform() { //v4.02
  var args = YY_checkform.arguments; var myDot=true; var myV=''; var myErr='';var addErr=false;
  var myForm = MM_findObj(args[0]);
  for (var i=1; i<args.length;i=i+4){
    if (args[i+1].charAt(0)=='#'){var myReq=true; args[i+1]=args[i+1].substring(1);}else{myReq=false}
    var myObj = MM_findObj(args[i].replace(/\[\d+\]/ig,""));//eval(myForm+'.'+args[i]);
    myV=myObj.value;
    if (myObj.type=='text'||myObj.type=='password'){
      if (myReq&&myObj.value.length==0){addErr=true}
      if ((myV.length>0)&&(args[i+2]==1)){ //fromto
        if (isNaN(parseInt(myV))||myV<args[i+1].substring(0,args[i+1].indexOf('_'))/1||myV > args[i+1].substring(args[i+1].indexOf('_')+1)/1){addErr=true}
      }
      if ((myV.length>0)&&(args[i+2]==2)&&!myV.match("^[\\w\\.=-]+@[\\w\\.-]+\\.[a-z]{2,4}$")){addErr=true}// email
      if ((myV.length>0)&&(args[i+2]==3)){ // date
        var myD=''; myM=''; myY=''; myYY=0; myDot=true;
        for(var j=0;j<args[i+1].length;j++){
          var myAt = args[i+1].charAt(j);
          if(myAt=='D')myD=myD.concat(myObj.value.charAt(j));
          if(myAt=='M')myM=myM.concat(myObj.value.charAt(j));
          if(myAt=='Y'){myY=myY.concat(myObj.value.charAt(j)); myYY++}
          if(myAt=='-'&&myObj.value.charAt(j)!='-')myDot=false;
          if(myAt=='.'&&myObj.value.charAt(j)!='.')myDot=false;
          if(myAt=='/'&&myObj.value.charAt(j)!='/')myDot=false;
        }
        if(myD/1<1||myD/1>31||myM/1<1||myM/1>12||myY.length!=myYY)myDot=false;
        if(!myDot){addErr=true}
       }
      if ((myV.length>0)&&(args[i+2]==4)){ // time
        myDot=true;
        var myH = myObj.value.substr(0,myObj.value.indexOf(':'))/1;
        var myM = myObj.value.substr(myObj.value.indexOf(':')+1,2)/1;
                var myP = myObj.value.substr(myObj.value.indexOf(':')+3,2);
        if ((args[i+1])=="12:00pm"){if(myH<0||myH>12||myM<0||myM>59||(myP!="pm"&&myP!="am")||myObj.value.length>7)myDot=false;}
        if ((args[i+1])=="12:00"){if(myH<0||myH>12||myM<0||myM>59||myObj.value.length>5)myDot=false;}
        if ((args[i+1])=="24:00"){if(myH<0||myH>23||myM<0||myM>59||myObj.value.length>5)myDot=false;}
        if(!myDot){addErr=true}
      }
      if (myV.length>0&&args[i+2]==5){
            var myObj1 = MM_findObj(args[i+1].replace(/\[\d+\]/ig,""));
            if(!myObj1[args[i+1].replace(/(.*\[)|(\].*)/ig,"")].checked){addErr=true} // check this 2
          }
    }else
    if (!myObj.type&&myObj.length>0&&myObj[0].type=='radio'){
      if (args[i+2]==1&&myObj.checked&&MM_findObj(args[i+1]).value.length/1==0){addErr=true}
      if (args[i+2]==2){
        var myDot=false;
        for(var j=0;j<myObj.length;j++){myDot=myDot||myObj[j].checked}
        if(!myDot){myErr+='* ' +args[i+3]+'\n'}
      }
    }else
    if (myObj.type=='checkbox'){
      if(args[i+2]==1&&myObj.checked==false){addErr=true}
      if(args[i+2]==2&&myObj.checked&&MM_findObj(args[i+1]).value.length/1==0){addErr=true}
    }else
    if (myObj.type=='select-one'||myObj.type=='select-multiple'){
      if(args[i+2]==1&&myObj.selectedIndex/1==0){addErr=true}
    }else
    if (myObj.type=='textarea'){
      if(myV.length<args[i+1]){addErr=true}
    }
    if (addErr){myErr+='* '+args[i+3]+'\n'; addErr=false}
  }
  if (myErr!=''){alert('Submit message error\t\t\t\t\t\n\n'+myErr)}
  document.MM_returnValue = (myErr=='');
}
//-->
</script> 
</HEAD>

<BODY BGCOLOR="<%=web_bg%>" TEXT="#000000" background="<%=web_bgimg%>">
<FORM NAME="form1" ACTION="paint.asp" METHOD="POST">
  <%if lockbbs="0" then %>
  <TABLE WIDTH="516" BORDER="0" CELLSPACING="1" CELLPADDING="1" ALIGN="CENTER" BGCOLOR="<%=td_bor%>" height="433">
    <TR> 
      <TD bgcolor="<%=titlebg%>">&nbsp;</TD>
    </TR>
    <TR> 
      <TD BGCOLOR="<%=bg_color%>"> 
        <div align="center"><br>
          <img src="../poobbs.gif" width="369" height="60"><BR>
        </div>
        <div align="center"> 
          <TABLE WIDTH="100%" BORDER="0" CELLSPACING="2" CELLPADDING="1">
            <TR> 
              <TD COLSPAN="3">&nbsp;</TD>
            </TR>
            <TR> 
              <TD COLSPAN="3">&nbsp;</TD>
            </TR>
            <TR> 
              <TD COLSPAN="3"><img src="../bbsimages/sw_grey_arrow_rnd.gif" width="11" height="11"> 
                请选择Java画图板</TD>
            </TR>
            <TR> 
              <TD WIDTH="6%"> 
                <INPUT TYPE="radio" NAME="paint" VALUE="painter" CHECKED>
              </TD>
              <TD COLSPAN="2"><b>Shi Oekaki Painter(中文)</b></TD>
            </TR>
            <TR> 
              <TD WIDTH="6%"> 
                <INPUT TYPE="radio" NAME="paint" VALUE="painterpro">
              </TD>
              <TD COLSPAN="2"><b>Shi Oekaki Painter Pro</b></TD>
            </TR>
            <TR> 
              <TD WIDTH="6%"> 
                <INPUT TYPE="radio" NAME="paint" VALUE="oekakibbs">
              </TD>
              <TD COLSPAN="2"><b>Poo Oekakibbs 2.64 </b></TD>
            </TR>
            <TR> 
              <TD WIDTH="6%"> 
                <INPUT TYPE="radio" NAME="paint" VALUE="paintbbs">
              </TD>
              <TD COLSPAN="2"><b>Shi Paintbbs 2.22 </b></TD>
            </TR>
            <TR> 
              <TD COLSPAN="3"><img src="../bbsimages/sw_grey_arrow_rnd.gif" width="11" height="11"> 
                设置画布大小</TD>
            </TR>
            <TR>
              <TD WIDTH="6%">&nbsp;</TD>
              <TD COLSPAN="2"><b>
                <input type="checkbox" name="pop" value="yes">
                全屏(oekakibbs有效)</b></TD>
            </TR>
            <TR> 
              <TD WIDTH="6%">&nbsp;</TD>
              <TD COLSPAN="2">画布宽 
                <INPUT TYPE="text" NAME="w" SIZE="5" MAXLENGTH="3" VALUE="300">
                &nbsp;&nbsp;画布高 
                <INPUT TYPE="text" NAME="h" SIZE="5" MAXLENGTH="3" VALUE="300">
                20-650 </TD>
            </TR>
            <TR> 
              <TD WIDTH="6%">&nbsp;</TD>
              <TD COLSPAN="2">作者： 
                <INPUT TYPE="text" NAME="name" SIZE="15" MAXLENGTH="30" value="<%= Request.Cookies("guest_name") %>">
              </TD>
            </TR>
            <TR> 
              <TD WIDTH="6%">&nbsp;</TD>
              <TD COLSPAN="2">&nbsp;</TD>
            </TR>
            <TR> 
              <TD WIDTH="6%">&nbsp;</TD>
              <TD COLSPAN="2"> 
                <div align="left"> 
                  <INPUT TYPE="submit" VALUE="确定" onClick="YY_checkform('form1','w','#100_650','1','宽的数值在100-650之间','h','#100_650','1','高的数值在30-650之间','name','#q','0','必须输入发言者姓名');return document.MM_returnValue">
                  &nbsp;&nbsp; 
                  <INPUT TYPE="button" VALUE="返回" NAME="Button" ONCLICK="MM_goToURL('parent','javascript:history.back(1)');return document.MM_returnValue">
                </div>
              </TD>
            </TR>
          </TABLE>
          <BR>
        </div>
      </TD>
    </TR>
  </TABLE>
  <% else Response.Write "<font size=3 color=red>不能发表作品，涂鸦板被管理员锁定！</font>" end if%>
</FORM> 
<br>
<!--#include file="../foot.htm" -->
</BODY>
</HTML>
