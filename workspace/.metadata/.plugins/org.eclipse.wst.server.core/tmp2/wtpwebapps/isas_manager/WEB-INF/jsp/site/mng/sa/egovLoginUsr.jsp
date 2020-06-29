<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<script type="text/javascript" defer="defer">
	<!--
		function actionLogin() {
		    if (document.loginForm.admId.value =="") {
		        alert("아이디를 입력하세요");
		    } else if (document.loginForm.admPw.value =="") {
		        alert("비밀번호를 입력하세요");
		    } else {
		        document.loginForm.action="${rootUri}${mngUri}sa/actionLogin.action";
		        document.loginForm.submit();
		    }
		}

		function saveid(form) {
		    // 기본적으로 30일동안 기억하게 함. 일수를 조절하려면 * 30에서 숫자를 조절하면 됨
		    var expdate = -1
		    if (form.checkId.checked) expdate = 1000 * 3600 * 24 * 30; // 30일
		    setCookie("admId", form.admId.value, expdate);
		}

		function getid(form) {
		    form.checkId.checked = ((form.admId.value = getCookie("admId")) != "");
		}

		/* function init() {
		    getid(document.loginForm);
		} */
	//-->
</script>
</head>
<body class="noBg">
	<div class="wrap_login" >
		<div>
			<!-- login_con -->
			<div class="content_login">
				<h1 class="login_title"><a href="#none"><img src="${rootUri}images/vis_logo.gif" alt="inus" /></a></h1>
				<form name="loginForm" method="post">
					<div style="visibility:hidden;display:none;">
		                <input name="iptSubmit1" type="submit" value="전송" title="전송" />
		            </div>
					<div class="box">
						<h2><img src="${rootUri}images/h1_login.png" alt="Login" /></h2>
						<p class="detail"><strong>이누스 서비스센터 관리자화면입니다.</strong><br>관리자 아이디와 비밀번호를 입력해 주세요.</p>
						<div class="login_click">
							<ul class="input">
								<li>
									<label for="admId">아 이 디</label>
									<span><input id="admId" name="admId" type="text" class="i_text" value=""></span>
								</li>
								<li>
									<label for="admPw">비밀번호</label>
									<span><input id ="admPw" name="admPw" type="password" class="i_text" value="" onKeyDown="javascript:if (event.keyCode == 13) { actionLogin(); }"></span>
								<li>
								<!-- <li class="btn"><input type="checkbox" name="checkId" id="checkId" title="암호저장여부" onClick="javascript:saveid(document.loginForm);" /> ID저장</li> -->
								<li class="btn"><a href="#LINK" onClick="actionLogin()">로그인</a></li>
							</ul>
						</div>
					</div>
				</form>
			</div>
			<!-- login_con // -->
		</div>
	</div>
</body>
</html>
