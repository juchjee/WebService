<%@page import="egovframework.cmmn.IConstants"%>
<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<div class="tit_path">
	<h2 id="tit_depths0">HOME</h2>
	<c:set var="SA_MAIN_PAGE" value="/${iConstant.get('SA_MAIN_PAGE')}"/>
<%-- 	<c:if test="${SA_MAIN_PAGE ne pageContext.request.requestURI}"> --%>
		<div class="path">
			<span><img src="${rootUri}images/blt_iconpath.png" alt="홈 아이콘"></span>
			<a href="${rootUri}${iConstant.get('SA_MAIN_PAGE')}">Home</a>
			<a id="tit_depths1" href="${rootUri}"></a>
			<a id="tit_depths2" class="now" href=""></a>
		</div>
<%-- 	</c:if> --%>
	<!-- // path -->
</div>
