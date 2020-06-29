<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
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
		 //${prodQty.prodCd}

		function fnEvent(){
			$.qtySave = function(){
				if($("select[name=prodCd]").val() != ""){
					fnSubmit("workForm","입고 추가");
				}else{
					alert("입고할 상품을 선택해주세요!");
					return false;
				}
			};
/*
			$("a#orderQty0").bind("click", function(e){

					var prodCd = $("#orderQty0").data("value");

					if($(this).attr("id") == "orderQty0"){

							$("#orderQty0").attr("href","amM201Qty.action?prodCd="+prodCd);

					}else{
						return false;
					}

			});
*/

/*
			$("#orderQty0").fancybox({
				maxWidth	: 400,
				maxHeight	: 800,
				width		: 400,
				height		: 482,
				modal : false,
				autoSize	: true,
			    transitionIn      : 'none',
			    transitionOut     : 'none',
			    type              : 'iframe',
				beforeClose : function(){
			    	fnSearch();
				}
			});
*/

		}

		//-->
		function callPop (prodCd) {
			window.parent.openFancy(prodCd);
		}
	</script>
</head>

<body class="noBg">
	<div class="popup_wrap">
		<h2>상품 입고 정보</h2>
		<h3>${prodNm}</h3>
		<!-- // align_area -->
		<div class="table_type2" style="margin-bottom:0px;">
			<div class="align_area" style="margin:0 0 10px 0; padding:0 0 0 0">
	 			<form id="workForm" name="workForm" action="amM201QtySave.action" method="post">
					<input type="hidden" name="prodSet" value="Y" />
					<input type="hidden" name="prodSetCd" value="${param.prodCd}" />
					<!-- <div class="fl" style="margin-right:5px"><html:selectList name='prodCd' id='prodCd' list='${prodQtySetList}' listValue='prodCd' listName='prodNm' optionValues="" optionNames="선택하세요!" script='style="width:130px;"'/></div>
					<div class="fl"  style="margin-right:5px"><input type="text" id="prodWearingQty" style="width:145px;"  name="prodWearingQty" class="alignR validation[number,required]" title="입고수량"   placeholder="입고 수량을 입력하세요!" /></div>
			        <div class="fl"> <a class="btn_type1"  href=javascript:; onclick="$.qtySave();">추가</a></div> -->
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
		      		<th class="alignC" style="border-bottom:0px;">단위별 상품명</th>
		      		<th class="alignC" style="border-bottom:0px;">단위별<br/>총 입고수량</th>
		      		<th class="alignC" style="border-bottom:0px;">최근입고일</th>
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
			       <c:forEach items="${prodQtySetList}" var="prodQty">
			       <tr>
			          <td class="alignL">
			           <a id="orderQty0" data-fancybox-type="iframe"  href="javascript:callPop('${prodQty.prodCd}');" data-value="${prodQty.prodCd}">${prodQty.prodNm}</a>
			          </td>
			          <td class="alignR">${prodQty.prodWearingQty}</td>
			          <td class="alignC">${prodQty.prodWearingDt}</td>
			       </tr>
			       </c:forEach>
			       <c:if test="${empty prodQtySetList}">
			       		<td colspan="3">등록된 재고가없습니다.</td>
			       </c:if>
		      </tbody>
		    </table>
		</div>
		<div class="top_box" style="margin-bottom:10px;">
			<div class="text_type">
				<p>세트상품은 단위별상품의 가장 적은 입고수량이 사용됩니다.</p>
			</div>
			<!-- // text_type -->
		</div>
		<div class="table_type2" style="margin-bottom:0px;">
		    <table>
		      <colgroup>
		        <col style="width:200px;">
<%-- 		        <col style="width:120px;"> --%>
		        <col style="width:*">
		      </colgroup>
		      <thead>
		       	<tr>
<!--
		      		<th class="alignC" style="border-bottom:0px;">총 입고수량</th>
		      		<th class="alignC" style="border-bottom:0px;">총 판매수량</th>
		      		<th class="alignC" style="border-bottom:0px;">현재 재고수량</th>
 -->
		      		<th class="alignC" style="border-bottom:0px;">총 판매가능수량</th>
		      		<th class="alignC" style="border-bottom:0px;">총 판매수량</th>
		      	</tr>
		      </thead>
		  	</table>
		 </div>
		<div class="table_type3 overH175">
			<table>
		      <colgroup>
		        <col style="width:200px;">
<%-- 		        <col style="width:120px;"> --%>
		        <col style="width:*">
		      </colgroup>
		      <tbody>
			       <tr>
			          <td><div class="validation[number]">${prodInventory.wearingQty}</div></td>
			          <td><div class="validation[number]">${prodInventory.prodQty}</div></td>
<%-- 			          <td><div class="validation[number]">${prodInventory.inventoryQty}</div></td> --%>
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