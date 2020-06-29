<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout;
var gridMain;
var calMain; 
var config={id:"changePass"}
$(document).ready(function(){//비밀번호변경
    Ubi.setContainer(0,[],"1C");
		
	layout = Ubi.getLayout();
	toolbar = Ubi.getToolbar();
	subLayout = Ubi.getSubLayout(); 
		
	layout.cells("b").attachObject("bootContainer");
	
});
function change(){
	var uid = $("#id").val();
	var passwd = $("#pw").val();
	var newPw = $("#newPw").val();
	var newPw2 = $("#newPw2").val();
	if(uid=="") {
		alert("아이디를 입력하세요");
		return;
	}
	if(passwd=="") {
		alert("패스워드를 입력하세요");
		return;
	}
	if(newPw=="") {
		alert("새로운 패스워드를 입력하세요");
		return;
	}
	if(newPw2=="" || newPw != newPw2) {
		alert("새로운 패스워드를 확인하세요");
		return;
	}

    var obj = {};
    obj.id = uid;
    obj.pw = passwd;
	var req = $.ajax({
		url: "/chageCheck",
		data: obj,
		type: "post",
		dataType: "json"
	});
	
	req.done(function(data) {
		if(data == 0){
			alert("계정정보를 확인해 주세요");
		}else if(data == 1){
			var params = {};
			params.id = uid;
			params.pw = newPw;
			chageSavePw(params);
		};
	});	
};

function chageSavePw(params){
	var req = $.ajax({
		url: "/passwordSave",
		data: params,
		type: "post",
		dataType: "json" 
	});
	 alert("암호가 정상적으로 변경되었습니다.");  
     cancel();
}

function cancel(){
	parent.dhxWins.window("w1").close();
}
</script>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="title2">현재 아이디</label>
				<input name="id" id="id" type="text" value="" placeholder="" class="inputbox1">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="title2">현재 암호</label>
				<input name="pw" id="pw" type="password" value="" placeholder="" class="inputbox1">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="title2">새로운 암호</label>
				<input name="newPw" id="newPw" type="password" value="" placeholder="" class="inputbox1">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="title2">새로운 암호 확인</label>
				<input name="newPw2" id="newPw2" type="password" value="" placeholder="" class="inputbox1">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml50">
				<button name="okBtn" id="okBtn" onclick="change()" style="margin-left: 50px;">확인</button>
				<button name="cancelBtn" id="cancelBtn" onclick="cancel()" style="margin-left: 30px;">취소</button>
			</div>
		</div>
	</div>
</div>
<div id="container"></div>