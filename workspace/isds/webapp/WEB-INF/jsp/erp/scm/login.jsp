<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>로그인</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
</head>
<body style="background-color: white;">
<style>
html {height: 800px; background-color:#FFFFFF;}
body {height: 800px; background-color:#FFFFFF;}
.login_logo { 
     border : 5px; border-color : black;
	 width:800px; left:0; right:0;  margin-left:auto; margin-right:auto; 
	height:60px;  top: 0; bottom:0; margin-top:140px; margin-bottom:auto;
}
.login_main { 
	 width:800px; left:0; right:0; margin-left:auto; margin-right:auto; 
	height:330px; top: 0; bottom:0; margin-top:auto; margin-bottom:auto;
}
.login_info { 
	width:800px; left:0; right:0; margin-left:auto; margin-right:auto;
	top: 0; bottom:0; margin-top:1px;  margin-bottom:auto;
}
</style>
<script type="text/javascript">
$(document).ready(function(){
	fn_chk = function(){
		var uid = $("#id").val();
		if(uid=="") {
			alert("아이디를 입력하세요");
			return;
		}

		var passwd = $("#pw").val();
		if(passwd=="") {
			alert("패스워드를 입력하세요");
			return; 
		}

		var req = $.ajax({
			url: "/loginCheck",
			data: $("#frm").serialize(),
			type: "post",
			dataType: "json"
		});
		
		req.done(function(data) {
			//20180803 useYn, workYn 조건절 추가 [workYn의 경우, 거래처코드가 'a'인 경우, HRA100의 퇴직날짜여부를 확인하며 나머지는 SCM 사용자 등록의 사용여부를 확인한다.]
			if(data.id == null){
				alert("계정정보를 확인해주세요");
			}else if(data.confirmYn == 0){
				alert("미승인 상태입니다.");
			}else if(data.useYn == 0) {
				alert("미사용계정입니다.");
			}else if(data.workYn == 0) {
				alert("재직중인 직원만 로그인 가능합니다.");
			}else{
				location.replace("/erp/scm/main.do");	
			}	
		});		
	};
	
	$('#id').focus();
	
	getjsonData();
	
	//아이디 쿠키저장
	var userInputId = getCookie("userInputId");
    $("#id").val(userInputId); 
    
    if($("#id").val() != ""){ 
        $("#idChk").attr("checked", true); 
    }
    
    $("#idChk").change(function(){ 
        if($("#idChk").is(":checked")){ 
            var userInputId = $("#id").val();
            setCookie("userInputId", userInputId, 300); 
        }else{ // ID 저장하기 체크 해제 시,
            deleteCookie("userInputId");
        }
    });
     
    $("#id").keyup(function(){ 
        if($("#idChk").is(":checked")){ 
            var userInputId = $("#id").val();
            setCookie("userInputId", userInputId, 300);
        }
    });
    
    //랜덤 사진
    var mainImgArr = new Array("/images/logo/scmMain.jpg", "/images/logo/scmMain2.jpg");
    var index = Math.floor(Math.random() * mainImgArr.length);
    $('#mainImg').prop("src",mainImgArr[index]);
	
});
function getjsonData(){
 	if(PARAM_INFO.passwd != undefined){
 		$('#pw').val(PARAM_INFO.passwd);
	}
 	if(PARAM_INFO.loginId != undefined){
 		$('#id').val(PARAM_INFO.loginId);
 		$('#loginBtn').click();
	}
 	
};

function changePasswordPop(){
  var pLayout;
  
  dhxWins = new dhtmlXWindows();
  if (!$('#' + 'w1').length) {
	  if (dhxWins.isWindow('w1')) {
		  while (dhxWins.isWindow('w1')) {
			  var number = eleId.replace(/[^0-9]/g, '');
			  eleId = eleId.replace(/\d+/g, '') + number++;
		  }
	  }
	  var $div = $('<div/>').appendTo('#container');
	  $div.attr('id', 'w1');
  }

  w1 = dhxWins.createWindow('w1', 500, 250, 300, 270);
  dhxWins.window('w1').setModal(true);
  pLayout = w1.attachLayout("1C");
  
  pLayout.cells("a").hideHeader(); 
  ifr = pLayout.cells("a").getFrame();
  w1.setText("비밀번호 변경");
  pLayout.cells("a").attachURL("/erp/scm/changePassword.do");
};

function setCookie(cookieName, value, exdays){
    var exdate = new Date();
    exdate.setDate(exdate.getDate() + exdays);
    var cookieValue = escape(value) + ((exdays==null) ? "" : "; expires=" + exdate.toGMTString());
    document.cookie = cookieName + "=" + cookieValue;
}
 
function deleteCookie(cookieName){
    var expireDate = new Date();
    expireDate.setDate(expireDate.getDate() - 1);
    document.cookie = cookieName + "= " + "; expires=" + expireDate.toGMTString();
}

function getCookie(cookieName) {
    cookieName = cookieName + '=';
    var cookieData = document.cookie;
    var start = cookieData.indexOf(cookieName);
    var cookieValue = '';
    if(start != -1){
        start += cookieName.length;
        var end = cookieData.indexOf(';', start);
        if(end == -1)end = cookieData.length;
        cookieValue = cookieData.substring(start, end);
    }
    return unescape(cookieValue);
}
</script> 
	<form id="frm" name="frm" method="post">
	    <div class="login_logo">
			<img id="scmLogo" name="scmLogo"  src="/images/logo/scmLogo.png" style=" width : 160px; height: 100%; margin-right: 500px;">
		</div>
	    <div class="login_main" style="border: solid 1px;">
			<img id="mainImg" name="mainImg"  src="/images/logo/scmMain.jpg" style="max-width: 796px; padding : 2px; height: 326px;">
	    </div>
	    <div class="login_info" style="border: solid 1px;">
	      <table width="430px;" style="margin-top: 10px; margin-left: 390px;">
	        <tr> 
	          <td align="right" width="140px;" height="30px;">
	            <font size="2px;"><b>ID 입력</b></font> 
	          </td> 
	          <td width="160px;"> 
	            <input name="id" id="id" type="text" value="" style="width: 150px;"> 
	          </td>
	          <td rowspan="2" width="100px;">
	            <input type="button" name="loginBtn" id="loginBtn" value="LOGIN"  style="height: 55px; width: 70px; color:white; background-color: #4A9ABB;" onClick="javascript:fn_chk();" />
	          </td>
	        </tr>
	        <tr>
	          <td align="right" width="140px;" height="30px;">
	            <font size="2px;"><b>PASSWORD 입력</b></font>
	          </td>
	          <td width="160px;">
	           <input name="pw" id="pw" type="password" value="" onKeyPress="if(event.keyCode==13) { fn_chk(); }" style="width: 150px;">
	          </td>
	        </tr>
	        <tr>
	          <td colspan="3" align="center" height="30px;">
	            <input id="idChk" name="idChk" type="checkbox">
	            <label style="text-align: left; width: 120px;"><font size="2px;"><b>ID 저장</b></font></label> 
	            &nbsp;&nbsp;/&nbsp;&nbsp; <a href="javascript:changePasswordPop()">비밀번호변경</a>
	          </td>
	        </tr>
	      </table>
	   </div>
	</form>
</body>
</html>