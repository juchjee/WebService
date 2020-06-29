<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<script type="text/javascript">
	$(document).ready(function() {
		$('#printDetail').on("click", function(){
 			print();
 		}); // on
	});
	</script>
</head>

<body class="noBg" style="height:800px;">
	<p style="text-align:center;font-size:17px;margin-bottom:10px;margin-top:10px;font-weight:bold;">
		${param.orderPackingTime} 회차별 상품 목록
	</p>
	<div style="width:100%;height:40px;">
		<div style="float:left;font-weight:bold;">
			▣  ${param.packingTime} 회차 (송장번호 존재하는 주문 건에 한함)
		</div>
		<div style="float:right;padding-bottom:10px;">
			<a href="#" class="listBtn btn_type1" id="printDetail" style="font-weight:bold;">인쇄</a>
		</div>
	</div>
<!-- 	<div class="pageContScroll_st2"> -->
		<table border=1 style="text-align:center;font-size:15px;">
			<colgroup>
				<col style="width:15%;" />
				<col style="width:65%;" />
				<col style="width:25%;" />
			</colgroup>
			<thead>
				<tr>
					<th style="background: #e8e8e8;">순번</th>
					<th style="background: #e8e8e8;">제품명</th>
					<th style="background: #e8e8e8;">수량</th>
				</tr>
			</thead>
			<tbody>
			<c:if test="${empty timeOrderList}">
				<tr>
					<td align='center' colspan="3">목록이 없습니다.</td>
				</tr>
			</c:if>
			<c:set var="sumAllQty" value="0" />
			<c:if test="${not empty timeOrderList}">
				<c:forEach var="timeOrderList" items="${timeOrderList}" varStatus="nStatus">
					<c:set var="sumQty" value="${timeOrderList.sumQty}" />
					<c:if test="${timeOrderList.prodCd == 'PPD00014' || timeOrderList.prodCd == 'PPD00128'}">
						<c:set var="mergeGold" value="${mergeGold + timeOrderList.sumQty}" />
						<c:set var="sumQty" value="${mergeGold}" />
					</c:if>
					<c:if test="${timeOrderList.prodCd == 'PPD00013' || timeOrderList.prodCd == 'PPD00129'}">
						<c:set var="mergeGoldSet" value="${mergeGoldSet + timeOrderList.sumQty}" />
						<c:set var="sumQty" value="${mergeGoldSet}" />
					</c:if>
					<c:if test="${timeOrderList.prodCd == 'PPD00010' || timeOrderList.prodCd == 'PPD00130'}">
						<c:set var="mergeBaby" value="${mergeBaby + timeOrderList.sumQty}" />
						<c:set var="sumQty" value="${mergeBaby}" />
					</c:if>
					<c:if test="${timeOrderList.prodCd == 'PPD00009' || timeOrderList.prodCd == 'PPD00131'}">
						<c:set var="mergeBabySet" value="${mergeBabySet + timeOrderList.sumQty}" />
						<c:set var="sumQty" value="${mergeBabySet}" />
					</c:if>
					<c:if test="${timeOrderList.prodCd == 'PPD00012' || timeOrderList.prodCd == 'PPD00132'}">
						<c:set var="mergeCare" value="${mergeCare + timeOrderList.sumQty}" />
						<c:set var="sumQty" value="${mergeCare}" />
					</c:if>
					<c:if test="${timeOrderList.prodCd == 'PPD00011' || timeOrderList.prodCd == 'PPD00133'}">
						<c:set var="mergeYam" value="${mergeYam + timeOrderList.sumQty}" />
						<c:set var="sumQty" value="${mergeYam}" />
					</c:if>

					<c:if test="${timeOrderList.prodCd != 'PPD00014' && timeOrderList.prodCd != 'PPD00013' && timeOrderList.prodCd != 'PPD00010' && timeOrderList.prodCd != 'PPD00009' && timeOrderList.prodCd != 'PPD00012' && timeOrderList.prodCd != 'PPD00011'}">
					<c:set var="cnt" value="${cnt + 1}" />
					<tr>
						<td>${cnt}</td>
						<td>${timeOrderList.prodNm}</td>
						<td>${sumQty}</td>
						<c:set var="sumAllQty" value="${sumAllQty + sumQty}" />
					</tr>
					</c:if>
				</c:forEach>
			</c:if>
			<tr>
				<th colspan="2" style="background: #e8e8e8;">합 계</th>
				<th style="background: #e8e8e8;">${sumAllQty}</th>
			</tr>
			</tbody>
		</table>
<!-- 	</div> -->

<!-- 	<div class="btn_area" style="padding-top:20px;"> -->
<!-- 		<div class="center"> -->
<!-- 		  	<a href="#" class="btn_blue_line2" id="printDetail">인쇄</a> -->
<!-- 		</div> -->
<!-- 	</div> -->

</body>
</html>