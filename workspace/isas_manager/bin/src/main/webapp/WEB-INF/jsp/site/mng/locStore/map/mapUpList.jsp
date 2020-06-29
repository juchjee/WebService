<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<script type="text/javascript" src="/js/jquery-1.11.1.min.js"></script>

	<script type="text/javascript" src="//apis.daum.net/maps/maps3.js?apikey=57619b8daffdc2edbdd923eb2edb812f&libraries=services,clusterer"></script>

	<script type="text/javascript">

	/** 주소정보를 좌표정보로 자동변환 **/
	$(document).ready(function(){

		var geocoder = new daum.maps.services.Geocoder();

		var listSz = ${mapList.size()};
		var addrArry = new Array();
		var coords = new Array();
		var coordsX = new Array();
		var coordsY = new Array();

		for(var i=0;i<listSz;i++){
			addrArry[i] = $("#mapCustomerAddr"+i).val();
			addrChang(addrArry[i],i);
		};

		function addrChang(conArry,i){
			geocoder.addr2coord(conArry, function(status, result) {
				if (status == daum.maps.services.Status.OK) {
					coords[i] = new daum.maps.LatLng(result.addr[0].lat, result.addr[0].lng);
					coordsY[i] = result.addr[0].lat;
					coordsX[i] = result.addr[0].lng;
					$("#pinX"+i).val(coordsX[i]);
					$("#pinY"+i).val(coordsY[i]);
				};
			});
		}

	});

	function mapSave(){
		if(confirm("저장하시겠습니까?")){
			frm = document.mapForm;
  			frm.action = '<c:url value="/mng/crm/map/mapSave.action"/>';
    		frm.submit();
		} else {
			return false;
		}
	}

	</script>

</head>
<body>

<form id="mapForm" name="mapForm" action="" method="post">
<table border="1">
	<tr>
		<th>고객번호</th>
		<th>고객이름</th>
		<th>고객연락처</th>
		<th>담당자이름</th>
		<th>담당자연락처</th>
		<th>주소</th>
		<th>상세주소</th>
		<th>DB X좌표</th>
		<th>DB Y좌표</th>
		<th>등록일</th>
		<th>주소 좌표</th>
	</tr>
	<c:forEach var="list" items="${mapList}" varStatus="status" >
	<tr>
		<td>${list.mapCustomerId}
			<input type="hidden" name="arrId" value="${list.mapCustomerId}" />
		</td>
		<td>${list.mapCustomerName}<input type="hidden" name="arrName" value="${list.mapCustomerName}"></td>
		<td>${list.mapCustomerPhone}<input type="hidden" name="arrPhone" value="${list.mapCustomerPhone}"></td>
		<td>${list.mapManager}<input type="hidden" name="arrManager" value="${list.mapManager}"></td>
		<td>${list.mapManagerPhone}<input type="hidden" name="arrManagerP" value="${list.mapManagerPhone}"></td>
		<td>${list.mapCustomerAddr}<input type="hidden" name="arrAddr" id="mapCustomerAddr${status.index}" value="${list.mapCustomerAddr}" /> </td>
		<td>${list.mapEtc}<input type="hidden" name="arrEtc" value="${list.mapEtc}"></td>
		<td>${list.pointX}</td>
		<td>${list.pointY}</td>
		<td>${list.regDate}</td>
		<td>
			<input type="text" name="arrPointY" id="pinY${status.index}"/><br/>
			<input type="text" name="arrPointX" id="pinX${status.index}"/>
		</td>
	</tr>
	</c:forEach>
	<c:if test="${empty mapList}">
	<tr>
		<td colspan="10">내용이 없습니다.</td>
	</tr>
	</c:if>
</table>
</form>

<button onclick="javascript:mapSave();">저장</button>

</body>
</html>