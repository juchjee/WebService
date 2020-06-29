<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css" media="screen">
body{
  margin:0px !important;
  height: 100%;
}
html{
  height: 100%;
}
pre.code {
  white-space: pre-wrap; 
}

/* a.no-uline { */
/* 	text-decoration : none; */
/* 	color : #303030; */
/* } */
</style>
<script type="text/javascript">
// var menuList = {
// 	id: "loginForm",
// 	css: 'form',
// 	view: "form",
// 	height: $(window).height() * 0.8, //20180820 135 >  수정
// 	elements: [{
// 	view: "list",
// 	type: { width: 'auto', height: 22},
// 	        select:true, scroll: true,template: function(obj){
// 	        	var pmenucd = obj.pmenucd;	//상위메뉴코드
// 	        	var menucd = obj.menucd;
// 	        	var uri = obj.uri;
// 	        	var html = "";
// // 	        	var html = "<ul>";
// // 	        	html += "<li>";
	        	
// 	        	if(pmenucd == '0000000000') {
// 	        		html += obj.menuname;
// // 	        		html += "<a href='/"+ uri + ".do' class='no-uline'>" + obj.menuname + "</a>";
// 	        	} else {
// 	        		html += "&nbsp;&nbsp;&nbsp;└ " + obj.menuname;
// // 	        		html += "<a href='/"+ uri + ".do' class='no-uline'>&nbsp;&nbsp;&nbsp;└ " + obj.menuname + "</a>"
// 	        	}
	        	
// // 	        	html += "</li></ul>";
	        	
// 				return html;
// 			}, id: 'menu', datatype: 'json', url: '/mobile/scm/main/list'
// 	 }]
// };
var menuList = {
	id: "loginForm",
	css: 'form',
	view: "form",
	height: $(window).height() * 0.7, //20180820 135 >  수정  
	elements: [{
	view: "list",
	type: { width: 'auto', height: 22},
	        select:true, scroll: true,template:'#menuname#', id: 'menu', datatype: 'json', url: '/mobile/scm/main/list'
	 }]
};

var loginInfo = {
	    id: "loginInfo",
	    css: 'form',
	    view: "form",
	    height: 90, //20180820 90 >  수정 $(window).height() * 0.2
	    elements: [{
	        view  : "text",
	        label : "",
// 		    template:"<font size='2' style='margin-left:10px;'>접속자 :${id}</font>&nbsp;&nbsp;&nbsp;&nbsp;<font size='2'>거래처명 :${custNm}</font><input type='hidden'>",
		    template:"<div style='text-align:center;'><font size='2'><b>접속자 : ${id} / 거래처명 : ${custNm}</b></font><input type='hidden'></div>",
		    name: "loginId"
	    },{
	        type: "clean",
	        cols: [{
	            view: "button",
	            type: "form",
	            label: "로그아웃",
	            click: "logout();"
	        }]
	    }]
	}; 
	
var toolbar = {
    view: "toolbar",
    elements: [{
        view: "label",
        label: "Main Menu",
        align: "center"
    }]
};
var main = {
    type: "clean",
    css: "layout",
    overflow:"auto",
    rows: [toolbar, {gravity: 1}, { type: "clean", cols: [{ width: 15 }, menuList, {width: 15}]}, {gravity: 1},loginInfo]
};
dhx.ready(function() {
    dhx.ui.fullScreen();
    dhx.ui(main);

	$$("menu").attachEvent("onItemClick",function(id,ev,trg){
		var menuList = $$('menu').item(id);
		var uri =menuList.uri;
		location.assign("/"+uri+".do");
	});
    
});

function logout() {
    dhx.notice({
        delay: 750,
        message: "Checking ..."
    }); 
    $.ajax({
       url:  "/logout",
       type: "POST",
       contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
       data: {},
       dataType: "json"
    });
    location.replace("/mobile/scm/main/login.do");
}
</script>