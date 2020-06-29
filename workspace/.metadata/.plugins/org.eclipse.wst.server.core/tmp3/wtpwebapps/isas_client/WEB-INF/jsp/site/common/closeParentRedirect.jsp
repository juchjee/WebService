<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:if test="${empty rootUri}"><c:set var="rootUri" value="${iConstant.get('ROOT_URI')}" scope="request" /></c:if>
<head>
	<c:import url="/WEB-INF/jsp/general/head_simple.jsp" />
	<script type="text/javascript" defer="defer">
		<!--
		var _windows = this && this.parent && this.parent.parent && this.parent.parent.parent && this.parent.parent.parent.parent && this.parent.parent.parent.parent.parent;

		<c:if test='${not empty messageBox.message}'>
			alert("<c:out value='${messageBox.message}' />");
		</c:if>

		<c:if test='${reload}'>
			_windows.location.reload();
		</c:if>

		<c:if test='${not empty action}'>
			<c:out value='${action}' escapeXml='false' />
		</c:if>

		<c:if test='${not empty location}'>
			_windows.location = "${rootUri}${location}";
		</c:if>

		<c:if test='${empty location}'>
			_windows.history.back();
		</c:if>
		//-->
	</script>
</head>
<body>
</body>
</html>