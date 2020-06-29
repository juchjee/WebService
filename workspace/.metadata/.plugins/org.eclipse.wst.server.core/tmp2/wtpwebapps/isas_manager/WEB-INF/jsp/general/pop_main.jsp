<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<c:if test="${empty rootUri}"><c:set var="rootUri" value="${iConstant.get('ROOT_URI')}" scope="request" /></c:if>
<head>
	<page:applyDecorator name="pop_header" />
	<decorator:head />
</head>
<c:if test="${not empty isCrm}">
<body class="noBg" style="height: 100%; overflow: auto;">
</c:if>
<c:if test="${empty isCrm}">
<body class="noBg">
</c:if>
	<div class="popup_member_wrap">
	<div class="left_con">
		<div class="member_con">
		<!-- top -->
		<page:applyDecorator name="pop_top" />
		<!-- /top -->
			<!-- contents -->
			<div class="contents">
				<decorator:body />
			</div>	<!-- // contents -->
		</div>	<!-- // member_con -->
	    </div>	<!-- // left_con -->
	    <c:choose>
		    <c:when test='${isCrm eq "Y"}'>
		    	<div class="right_con">
			       <page:applyDecorator name="pop_right" />
		    	</div>
	    	</c:when>
		    <c:otherwise>
		        <div class="right_con" style="display: none;">
			       <page:applyDecorator name="pop_right" />
		    	</div>
		    </c:otherwise>
		</c:choose>
	</div>	<!-- // popup_member_wrap -->
	<!-- footer -->
<%-- 	<page:applyDecorator name="footer" /> --%>
	<!-- /footer -->
</body>
</html>
