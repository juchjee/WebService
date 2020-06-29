<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html> 
<html> 
<head> 
	<title>로그인</title> 
	<meta  name = "viewport" content = "initial-scale = 1.0, maximum-scale = 1.0, user-scalable = no"><!-- // meta tag -->
	<script src="http://code.jquery.com/jquery-1.11.1.min.js"></script>
	<link rel="stylesheet" href="/component/dxTouch/codebase/touchui.css" type="text/css"> <!-- // dhtmlx touch file -->	
	<script src="/component/dxTouch/codebase/touchui.js" type="text/javascript"></script>  <!-- // dhtmlx touch file -->
	
</head> 
<body> 
<script type="text/javascript">
var w = $(window).width(); 
var width = parseInt(w*0.6);

//전체적으로 보았을 때, 400이상 넘었을 경우, 찌그러짐 현상 보이므로 400초과는 무조건 400으로 셋팅
if(width> 400) {
	width = 400;
}

var form = {
	    id: "loginForm",
	    css: 'form',
	    view: "form",
	    height: 320,
	    elements: [{
	        view: "imagebutton",
// 	        template:"<img src='/images/logo/m_is_big_logo.jpg' width='200' height='90' style='margin-top:5px; vertical-align:middle;'>", //hegiht=90
	        template:"<img src='/images/logo/isdsLogo.png' id='imgBtn' width='" + width + "' height='100%' style='vertical-align:middle; margin:0;'>", 
	        labelWidth:200,
	        height:120,
	        align:"center"
	    },{
	        view: "text",
	        label: "아이디",
	        name: "login",
	        labelWidth: 90,
	    }, {
	        view: "text",
	        type: "password",
	        label: "비밀번호",
	        name: "password",
	        labelWidth: 90,
	    }, {
	        type: "clean",
	        cols: [{
	            view: "button",
	            type: "form",
	            label: "로그인",
	            click: "login();"
	        }]
	    }]
	};
	
var toolbar = {
    view: "toolbar",
    elements: [{
        view: "label",
        label: "IS 동서 SCM - LOGIN",
        align: "center"
    }]
};
var loginView = {
    type: "clean",
    css: "layout",
    rows: [toolbar, {gravity: 1}, {cols: [form]}, {gravity: 1}]
};

dhx.ready(function() {
	dhx.ui.fullScreen();
    dhx.ui(loginView);
});

function login() {
    dhx.notice({
        delay: 750,
        message: "Checking ..."
    });

    var formData = $$('loginForm').getValues();
    var uid = formData.login,
    	passwd = formData.password;
   
    if ( uid == '' ){
    	dhx.alert(fn_alert('아이디를 입력하세요.'));
    }else if ( passwd == '' ){
    	dhx.alert(fn_alert('패스워드를 입력하세요.'));
    }else{
    	$('#id').val(uid)
    	$('#pw').val(passwd)
    	$.ajax({
        	url:  "/loginCheck",
            type: "POST",
            contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
            data: $("#frm").serialize(),
            dataType: "json",
            success: function(data) {
            	if(data.id == null){
            		dhx.alert(fn_alert("계정정보를 확인해주세요."));
            		return true;
            	}else if(data.confirmYn == 0){
            		dhx.alert(fn_alert("미승인 상태입니다.."));
            		return true;
            	}else{
            		location.assign("/mobile/scm/main/main.do");
            	}		
            },
            error: function(xhr) {
            	dhx.alert(fn_alert(xhr+': error 발생'));
            }
        });
    }
}
</script>
<form id="frm" name="frm" method="post">
<input type="hidden" id="id" name="id" value="">
<input type="hidden" id="pw" name="pw" value="">
</form>
</body>
</html>