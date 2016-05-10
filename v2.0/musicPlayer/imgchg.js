<!--
//
// ■ 进行动态按钮图档的切换动作
//

toggleKey = new Object();
toggleKey[0] = "_off";
toggleKey[1] = "_on";
toggleKey[2] = "_ovr";
toggleKey[3] = "_out";
toggleKey[4] = "_mdn";
toggleKey[5] = "_mup";

function imgChange(id,act){
 if(document.images){ document.images[id].src = eval("img." + id + toggleKey[act] + ".src");}
}

// 当这段程序码应用到播放器使用时：(exobud.js)
// 以函式 imgChange('按钮识别名称',0) 进行的动作即使用 "off" 的图档；
// 以函式 imgChange('按钮识别名称',1) 进行的动作即使用 "on"  的图档。

if(document.images){
 img = new Object();

 // 显示播放状态的 Scope 动态图档 (静止╱转动)
 img.scope_off = new Image();
 img.scope_off.src = "img/scope_off.gif";
 img.scope_on = new Image();
 img.scope_on.src = "img/scope_on.gif";
}

//-->