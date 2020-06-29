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
/* 			win = window.open("width=300px,height=700px");
			self.focus();
			win.document.open();
			win.document.write('<'+'html'+'><'+'head'+'>');
			win.document.write('<'+'link href="${rootUri}css/font.css" rel="stylesheet" type="text/css"'+'/'+'>');
			win.document.write('<'+'link href="${rootUri}css/default.css" rel="stylesheet" type="text/css"'+'/'+'>');
			win.document.write('<'+'link href="${rootUri}css/common.css" rel="stylesheet" type="text/css"'+'/'+'>');
			win.document.write('<'+'link href="${rootUri}css/site.css" rel="stylesheet" type="text/css"'+'/'+'>');
			//win.document.write('<'+'link href="${rootUri}css/jquery.mCustomScrollbar.css" rel="stylesheet"  type="text/css"'+'/'+'>');
			//win.document.write('<'+'link href="${rootUri}js/fancybox/jquery.fancybox.css?v=2.1.5" rel="stylesheet" type="text/css" media="screen"'+'/'+'>');
			win.document.write('<'+'style'+'>');
			win.document.write('body, th, td, ul, li, dl, dt, dd, div, span, p, h1, h3, a {font-family: Nanum Gothic; font-size: 14px;}');
			win.document.write('<'+'/'+'style'+'>');
			win.document.write('<'+'/'+'head'+'><'+'body'+' class="noBg"'+' width="300px" height="700px">');
			win.document.write('<'+'div style="background:#fff"'+'>');
			win.document.write($('.noBg').html());
			win.document.write('<'+'/'+'div'+'>');
			win.document.write('<'+'/'+'body'+'><'+'/'+'html'+'>');
			win.document.close();
			win.print();
			win.close();
 */
 			print();
 		}); // on
	});
	</script>
</head>

<body class="noBg">
	<p style="font-size:12pt; margin-bottom: 10px; margin-top: 10px;">아래 리스트는<c:if test="${not empty param.txtFromDt}"> ${param.txtFromDt}</c:if> ~<c:if test="${not empty param.txtToDt}"> ${param.txtToDt}</c:if> 송장 번호가 존재하고 패킹 날짜가 없는 주문의 합 입니다.</p>
	<table border=1 style="text-align:center;font-size:12pt;">
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
		<c:if test="${empty orderPackingList}">
			<tr><td align='center' colspan="3">목록이 없습니다.</td></tr>
		</c:if>
		<c:set var="sumAllQty" value="0" />
		<c:if test="${not empty orderPackingList}">
			<c:forEach var="orderPackingMap" items="${orderPackingList}" varStatus="nStatus">
				<c:set var="sumQty" value="${orderPackingMap.sumQty}" />
				<c:if test="${orderPackingMap.prodCd == 'PPD00014' || orderPackingMap.prodCd == 'PPD00128'}">
					<c:set var="mergeGold" value="${mergeGold + orderPackingMap.sumQty}" />
					<c:set var="sumQty" value="${mergeGold}" />
				</c:if>
				<c:if test="${orderPackingMap.prodCd == 'PPD00013' || orderPackingMap.prodCd == 'PPD00129'}">
					<c:set var="mergeGoldSet" value="${mergeGoldSet + orderPackingMap.sumQty}" />
					<c:set var="sumQty" value="${mergeGoldSet}" />
				</c:if>
				<c:if test="${orderPackingMap.prodCd == 'PPD00010' || orderPackingMap.prodCd == 'PPD00130'}">
					<c:set var="mergeBaby" value="${mergeBaby + orderPackingMap.sumQty}" />
					<c:set var="sumQty" value="${mergeBaby}" />
				</c:if>
				<c:if test="${orderPackingMap.prodCd == 'PPD00009' || orderPackingMap.prodCd == 'PPD00131'}">
					<c:set var="mergeBabySet" value="${mergeBabySet + orderPackingMap.sumQty}" />
					<c:set var="sumQty" value="${mergeBabySet}" />
				</c:if>
				<c:if test="${orderPackingMap.prodCd == 'PPD00012' || orderPackingMap.prodCd == 'PPD00132'}">
					<c:set var="mergeCare" value="${mergeCare + orderPackingMap.sumQty}" />
					<c:set var="sumQty" value="${mergeCare}" />
				</c:if>
				<c:if test="${orderPackingMap.prodCd == 'PPD00011' || orderPackingMap.prodCd == 'PPD00133'}">
					<c:set var="mergeYam" value="${mergeYam + orderPackingMap.sumQty}" />
					<c:set var="sumQty" value="${mergeYam}" />
				</c:if>

				<c:if test="${orderPackingMap.prodCd != 'PPD00014' && orderPackingMap.prodCd != 'PPD00013' && orderPackingMap.prodCd != 'PPD00010' && orderPackingMap.prodCd != 'PPD00009' && orderPackingMap.prodCd != 'PPD00012' && orderPackingMap.prodCd != 'PPD00011'}">
				<c:set var="cnt" value="${cnt + 1}" />
				<tr>
					<td>${cnt}</td>
					<td>${orderPackingMap.prodNm}</td>
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
	<p style="font-size:12pt; margin-bottom: 10px; margin-top: 10px; text-align: center;">
		<a class="btn_blue_line2" href="javascript:;" id="printDetail">인쇄</a>
	</p>
</body>
</html>
