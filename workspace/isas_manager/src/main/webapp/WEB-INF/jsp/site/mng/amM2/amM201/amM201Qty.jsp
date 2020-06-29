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
	<script type="text/javascript">
	<!--
		function init(){
			fnEvent();
		}
		/*----------------------------------------------------------------------------------------------
		 * 페이지 이벤트 함수 모음
		 *----------------------------------------------------------------------------------------------*/

		function fnEvent(){
			$.qtySave = function(){
					fnSubmit("workForm","입고 추가");
			}


		}

		//-->
	</script>
</head>

<body class="noBg">
	<div class="popup_wrap">
		<h2>상품 입고 정보</h2>
		<h3>${prodNm}</h3>
		<!-- // align_area -->
		<div class="table_type2" style="margin-bottom:0px;">
			<div class="align_area" style="margin:0 0 10px 0; padding:0 0 0 0; display: none;">
	 			<form id="workForm" name="workForm" action="amM201QtySave.action" method="post">
					<input type="hidden" name="prodSet" value="N" />
					<input type="hidden" id="prodCd" name="prodCd" value="${param.prodCd}" />
					<div class="fl" ><input type="text" id="prodWearingQty" name="prodWearingQty" class="alignR validation[number,required]" title="입고수량"   placeholder="입고 수량을 입력하세요!" /></div>
			         <div class="fl" ><a class="btn_type1" style="margin-left:5px " href=javascript:; onclick="$.qtySave();">추가</a></div>
		         </form>
			</div>
		    <table>
		      <colgroup>
		        <col style="width:120px;">
		        <col style="width:120px;">
		        <col style="width:*">
		      </colgroup>
		      <thead>
		       	<tr>
		      		<th class="alignC" style="border-bottom:0px;">입고수량</th>
		      		<th class="alignC" style="border-bottom:0px;">입고일</th>
		      		<th class="alignC" style="border-bottom:0px;">입고자아이디</th>
		      	</tr>
		      </thead>
		  	</table>
		  	</div>
		<div class="table_type3 overH175">
			<table>
		      <colgroup>
		        <col style="width:120px;">
		        <col style="width:120px;">
		        <col style="width:*">
		      </colgroup>
		      <tbody  id="qtyList" class="overH175">
			       <c:forEach items="${prodQtyList}" var="prodQty">
			       <tr>
			          <td class="alignR">${prodQty.prodWearingQty}</td>
			          <td class="alignC">${prodQty.prodWearingDt}</td>
			          <td class="alignC">${prodQty.prodWearingId}</td>
			       </tr>
			       </c:forEach>
			       <c:if test="${empty prodQtyList}">
			       		<td colspan="3">등록된 재고가없습니다.</td>
			       </c:if>
		      </tbody>
		    </table>
		</div>

		<div class="table_type2" style="margin-bottom:0px;">
		    <table>
		      <colgroup>
		        <col style="width:25%">
		        <col style="width:25%">
		        <col style="width:25%">
		        <col style="width:*">
		      </colgroup>
		      <thead>
		       	<tr>
		      		<th class="alignC" style="border-bottom:0px;">총 입고수량</th>
		      		<th class="alignC" style="border-bottom:0px;">총 판매수량</th>
		      		<th class="alignC" style="border-bottom:0px;">총 파손입고수량</th>
		      		<th class="alignC" style="border-bottom:0px;">현재<br/>재고수량</th>
		      	</tr>
		      </thead>
		  	</table>
		 </div>
		<div class="table_type3 overH175">
			<table>
		      <colgroup>
		        <col style="width:25%">
		        <col style="width:25%">
		        <col style="width:25%">
		        <col style="width:*">
		      </colgroup>
		      <tbody>
			       <tr>
			          <td><div class="validation[number]">${prodInventory.wearingQty}</div></td>
			          <td><div class="validation[number]">${prodInventory.prodQty}</div></td>
			          <td><div class="validation[number]">${prodInventory.damageProdQty}</div></td>
			          <td><div class="validation[number]">${prodInventory.inventoryQty}</div></td>
			       </tr>
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