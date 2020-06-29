<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${empty rootUri}"><c:set var="rootUri" value="${iConstant.get('ROOT_URI')}" scope="request" /></c:if>
<head>
	<c:import url="/WEB-INF/jsp/general/head_simple.jsp" />
	<script type="text/javascript" defer="defer">
	<!--
		function init() {
			<c:if test='${not empty messageBox.message}'>alert($("#messageText").text());</c:if>
			<c:if test='${not empty action}'>${action}</c:if>
			<c:if test='${not empty back}'>history.back();</c:if>
			<c:if test='${not empty reload}'>document.location.reload();</c:if>
			<c:if test='${not empty location}'>
				<c:if test='${empty dataMap}'>document.location.href = "${rootUri}${location}";</c:if>
				<c:if test='${not empty dataMap}'> var obj = ${dataMap};makeForm("${rootUri}${location}", {"page": "${param.page}"});</c:if>
			</c:if>
		}
	//-->
	</script>
</head>
<body class="noBg">
<div id="loader_background" style="text-align:center;width:100%;height:100%;top:0px;position:absolute;">
	<div style="position:absolute; width:100%; top:50%; height:240px; margin-top:-120px;"><img src="${rootUri}common/img/header/logo2.png" alt="ISDS" /></div>
<%-- 	<div style="position:absolute; width:100%; top:50%; height:240px; margin-top:-120px;"><img src="${rootUri}common/img/icon/ajaxLoader.gif" alt="Loading" /></div> --%>
</div>
<c:if test='${not empty messageBox.message}'>
<textarea id="messageText" rows="10" cols="100" style="width:100px; height:10px; display:none;">${messageBox.message}</textarea>
</c:if>
</body>
</html>
