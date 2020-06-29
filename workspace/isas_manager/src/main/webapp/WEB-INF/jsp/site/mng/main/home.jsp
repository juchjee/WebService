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
	//-->
</script>
</head>
<body class="noBg">
	<div class="wrap_login" >
		<div>
			<!-- login_con -->
			<div class="content_login">
				<h1 class="login_title"><a href="#none"><img src="${rootUri}images/vis_logo.gif" alt="ISDS" /></a></h1>
				<form name="loginForm" method="post">
					<div class="box">
						<h2><img src="${rootUri}images/h1_login.png" alt="Login" /></h2>
						<p class="detail"><strong>이누스 서비스센터 관리자화면입니다.</strong>
						<div class="login_click">
							<ul class="input">
								<c:if test="${isLogIn}">
								<li class="btn"><a href="${rootUri}${iConstant.get('SA_MAIN_PAGE')}">관리자화면</a></li>
								</c:if>
								<c:if test="${!isLogIn}">
								<li class="btn"><a href="${rootUri}${mngUri}sa/egovLoginUsr.action">로그인</a></li>
								</c:if>

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
