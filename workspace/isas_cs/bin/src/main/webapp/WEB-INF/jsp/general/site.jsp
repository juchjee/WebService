<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>

<c:if test="${!iConstant.isMobile(pageContext.request)}">
	<head>
		<page:applyDecorator name="header" />
		<decorator:head />
	</head>
	<body>

	<p id="skipMenu">
		<a href="#">주메뉴</a>
		<a href="#">본문 바로가기</a>
	</p>
	<!--=============== #WRAP ===============-->
	<div id="wrap">

	<!--=============== #HEADER ===============-->
		<page:applyDecorator name="gnb" />
	<%-- 	<page:applyDecorator name="top" /> --%>
	<!--=============== #/HEADER ===============-->


	<!--=============== #CONTAINER ===============-->
			<decorator:body />
	<!--=============== #/CONTAINER ===============-->


	<!--=============== #FOOTER ===============-->
		<page:applyDecorator name="gnb_footer" />
		<page:applyDecorator name="footer" />
	<!--=============== #/FOOTER ===============-->

	</div>
	<!--=============== #WRAP ===============-->

	<!--=============== #Loading Div ===============-->
		<div id="loader_background" style="text-align:center;width:100%;height:100%;top:0px;position:absolute; z-index:1;background:#1B1B1B;visibility:hidden;">
			<div style="position:absolute; width:100%; top:50%; height:240px; margin-top:-120px;"><img src="${rootUri}common/img/icon/ajaxLoader.gif" alt="Loading" /></div>
		</div>
	<!--=============== #Loading Div ===============-->

	</body>
</c:if>

<c:if test="${iConstant.isMobile(pageContext.request)}">

	<head>
		<page:applyDecorator name="header_m" />
		<decorator:head />
	</head>

	<body>
		<page:applyDecorator name="gnb_m" />

	<!--=============== #CONTAINER ===============-->
		<decorator:body />
	<!--=============== #/CONTAINER ===============-->

	<!--=============== #FOOTER ===============-->
		<page:applyDecorator name="footer_m" />
	<!--=============== #/FOOTER ===============-->

	<!--=============== #Loading Div ===============-->
		<div id="loader_background" style="text-align:center;width:100%;height:100%;top:0px;position:absolute; z-index:1;background:#1B1B1B;visibility:hidden;">
			<div style="position:absolute; width:100%; top:50%; height:240px; margin-top:-120px;"><img src="${rootUri}common/img/icon/ajaxLoader.gif" alt="Loading" /></div>
		</div>
	<!--=============== #Loading Div ===============-->
	</body>
</c:if>
</html>
