<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/egovc.tld"  %>
<%@page language="java" import="egovframework.cmmn.util.CommonUtil, java.util.Map, java.util.List"%>
<!DOCTYPE html>
<html>

<head>
<script type="text/javascript">
/**
*
*/
var isMobile = {
	    Android: function() {
	        return navigator.userAgent.match(/Android/i);
	    },
	    BlackBerry: function() {
	        return navigator.userAgent.match(/BlackBerry/i);
	    },
	    iOS: function() {
	        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
	    },
	    Opera: function() {
	        return navigator.userAgent.match(/Opera Mini/i);
	    },
	    Windows: function() {
	        return navigator.userAgent.match(/IEMobile/i) || navigator.userAgent.match(/WPDesktop/i);
	    },
	    any: function() {
	        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
	    }
	};

function callNative(cmd){
	if(isMobile.iOS()){
		var location = "iscs://callNative("+cmd+")";
		window.location = location;
	}else if(isMobile.Android()){
		alert("callNative Android start");
		window.iscs.callNative(cmd);
	}
}

//저장된 id 값 불러오기
//ex) {"cmdId":"js_loadSessionId", "successFunc" : "callback 함수명", "failFunc" : "callback 함수명"}
function loadSessionId() {
	callNative("{\"cmdId\":\"js_loadSessionId\", \"successFunc\" : \"callback\", \"failFunc\" : \"callback\"}");
}

//저장할 id 값 전달
//ex) {"cmdId":"js_saveSessionId", "params" : "{\"id\" : \"저장할 id값\"}" }
function saveSessionId(id){
   // id값 체크
	callNative("{\"cmdId\":\"js_saveSessionId\", \"successFunc\" : \"savecallback\", \"failFunc\" : \"savecallback\", \"params\" : \"{\\\"id\\\" : \\\""+id+"\\\"}\" }");
}

//저장된 id 값 삭제
function removeSessionId(){
   callNative("{\"cmdId\":\"js_removeSessionId\", \"successFunc\" : \"removecallback\", \"failFunc\" : \"removecallback\"}");
}

//loadSession callback
//ex) {"status" : 0, "data" : "{\"id\" : \"저장된 id 값\"}"}
function savecallback(json){

 var json = JSON.parse(json);
 var status = json.status;
 if(status == 0){
     // 0 성공
     alert(0);

     // 저장된 id 전달
 }else if(status = 1){
     alert('Non');
     // 저장된 id 정보가 없을 경우
 }else{
     alert('error');
     // 실패시
 }
}
function removecallback(json){

	 var json = JSON.parse(json);
	 var status = json.status;
	 if(status == 0){
	     // 0 성공
	     alert(0);

	     // 저장된 id 전달
	 }else if(status = 1){
	     alert('Non');
	     // 저장된 id 정보가 없을 경우
	 }else{
	     alert('error');
	     // 실패시
	 }
	}

//loadSession callback
//ex) {"status" : 0, "data" : "{\"id\" : \"저장된 id 값\"}"}
function callback(json){
   var json = JSON.parse(json);
   var status = json.status;
   if(status == 0){
       // 0 성공
       var data = JSON.parse(json.data);

       var id = data.id;

		alert(id);
       // 저장된 id 전달
   }else if(status = 1){
       alert('Non');
       // 저장된 id 정보가 없을 경우
   }else{
       alert('error');
       // 실패시
   }
}


function testIn(){
	saveSessionId("test___test2");
	//location.href="/";
}

function testOut(){
	loadSessionId();
}


function testRemove(){
	alert("테스트입니다.remove");
	removeSessionId();
	//location.href="/";

}

</script>
</head>
<body>
	<!-- sub -->
	<div  style="width:100%;text-align:center;">
		<button type="button" onclick="testIn();" style="width:300px;height:200px;padding:30px;cursor:pointer;font-size:20px;">데이터 IN 테스트</button>
		<button type="button" onclick="testOut();" style="width:300px;height:200px;padding:30px;cursor:pointer;font-size:20px;">데이터 OUT 테스트</button>
		<button type="button" onclick="testRemove();" style="width:300px;height:200px;padding:30px;cursor:pointer;font-size:20px;">데이터 삭제 테스트</button>
	</div>
</body>
</html>