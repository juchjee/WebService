<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/egovc.tld"%>
	<div class="header">
		<div class="hs_1">
			<div>
				<h1 style="cursor:pointer;" onclick="location.href='${rootUri}${mngUri}sa/egovLoginUsr.action'"><img src="${rootUri}images/logo.png" alt="logo" width="45%" height="45%"></h1>
				<div class="login_txt">
				<c:if test="${isLogIn}">
					<p>${logInDate}</p>
					<div>
						<p><span>${admName}</span> 님</p>
						<a class="login_history" href="${iConstant.get('MALL_URL')}" target="_blank">홈페이지 바로가기</a>
						<a href="/mng/sa/actionLogout.do">LOG OUT</a>
					</div>
				</c:if>
				<c:if test="${!isLogIn}">
					<div>
						<a class="login_history" href="${iConstant.get('MALL_URL')}" target="_blank">홈페이지 바로가기</a>
						<a href="/mng/sa/egovLoginUsr.do">LOG IN</a>
					</div>
				</c:if>
				</div>
            </div>
		</div>
	</div>
