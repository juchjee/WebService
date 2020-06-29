<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
	<div class="leftWrap">
		<p class="lnb_tit">이누스서비스센터 관리자</p>
		<div class="lnb">
			<ul class="depths_0">
				<c:forEach var="map" items="${categoryList}" varStatus="nStatus">
					<c:if test="${map.level == 1}"><c:if test="${!nStatus.first}"></ul></li></c:if><li><a href="javascript:;">${map.admMenuNm}</a><ul class="depths_1"></c:if>
					<c:if test="${map.level > 1}"><li><a href="${rootUri}${mngUri}${map.admUrl}"<c:if test="${fn:contains(nowCategoryUrl, map.testUrl)}"> class="on"</c:if>>${map.admMenuNm}</a></li></c:if>
					<c:if test="${nStatus.last}"></ul></li></c:if>
				</c:forEach>
			</ul>
		</div>
	</div>
<!-- // leftwrap -->
