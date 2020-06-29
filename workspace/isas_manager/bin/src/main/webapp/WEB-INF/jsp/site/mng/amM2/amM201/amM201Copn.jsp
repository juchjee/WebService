<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />
</head>

<body class="noBg">
	<div class="popup_wrap">
		<h2>상품 쿠폰 조회</h2>
		<h3>${prodNm}</h3>

		<!-- // align_area -->
		<div class="table_type2" style="margin-bottom:0px;">
		    <table>
		      <colgroup>
		        <col style="width:160px;">
		        <col style="width:*">
		      </colgroup>
		      <thead>
		       	<tr>
		      		<th class="alignC" style="border-bottom:0px;">쿠폰명</th>
		      		<th class="alignC" style="border-bottom:0px;">쿠폰기간</th>
		      	</tr>
		      </thead>
		  	</table>
		  	</div>
		<div class="table_type3 overH175">
			<table>
		      <colgroup>
		        <col style="width:160px;">
		        <col style="width:*">
		      </colgroup>
		      <tbody  class="overH175">
		       <c:forEach items="${copnList}" var="copn">
		      	<tr>
		      		<td>${copn.copnNm} </td>
		      		<td>[${copn.copnUseStartDt} ~ ${copn.copnUseEndDt}]</td>
		      	</tr>
				</c:forEach>
				<c:if test="${empty copnList}">
			       		<td colspan="2">등록된 쿠폰이 없습니다.</td>
			       </c:if>
		      </tbody>
		    </table>
		</div>
		<!-- // table_type2 -->
		<div class="btn_area">
			<div class="center">
				<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
			</div>
		</div>
		<!-- // btn_area -->
	</div>
	<!-- // popup_wrap -->
</body>
</html>