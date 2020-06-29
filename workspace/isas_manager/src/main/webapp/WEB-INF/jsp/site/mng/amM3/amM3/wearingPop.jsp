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
		/*----------------------------------------------------------------------------------------------
		 * 화면 load시 실행 함수 (onload)
		 *----------------------------------------------------------------------------------------------*/
		function init(){
			fnEvent();
			fnDataSetting();
		}

		/*----------------------------------------------------------------------------------------------
		 * 이벤트 Setting
		 *----------------------------------------------------------------------------------------------*/
		 function fnEvent(){
			$.submit = function(){
				fnAjax("wearingSave.action", {orderNo : "${param.orderNo}",type : "${param.type}",claimProcInfo: $("#claimProcInfo").val()},function(data, dataType){
					var data = data.replace(/\s/gi,'');
					alert(data);
					parent.$('#jqxgrid').jqxGrid('clearselection');
					parent.fnSearch();
					parent.$.fancybox.close();
				},'POST','text');
			}
		}


		/*----------------------------------------------------------------------------------------------
		 * 화면 기본 데이터 셋팅
		 *----------------------------------------------------------------------------------------------*/
		function fnDataSetting(){

			<c:choose>
				<c:when test="${param.type eq 'orderNormalWear'}">
					$("#msg").text("반품물품 정상입고 처리 하시겠습니까?");
					$("#claimProcInfo").prop("placeholder", "제품상태 - 미입력시:(정상입고)");
				</c:when>
				<c:when test="${param.type eq 'orderFailureWear'}">
					$("#msg").text("반품물품 파손입고 처리 하시겠습니까?");
					$("#claimProcInfo").prop("placeholder", "제품상태 - 미입력시:(반품물품 파손입고)");
				</c:when>
				<c:when test="${param.type eq 'orderFailureProducts'}">
					$("#msg").text("반품물품 제품불량입고 처리 하시겠습니까?");
					$("#claimProcInfo").prop("placeholder", "제품상태 - 미입력시:(반품물품 제품불량입고)");
				</c:when>
				<c:when test="${param.type eq 'orderFailureWearOpen'}">
					$("#msg").text("반품물품 고객개봉입고 처리 하시겠습니까?");
					$("#claimProcInfo").prop("placeholder", "제품상태 - 미입력시:(반품물품 고객개봉입고)");
				</c:when>
			</c:choose>

		}
	</script>
</head>

<body class="noBg">
	<div class="popup_wrap">
		<div class="font14 alignC">
			<p><strong>주문번호 - ${param.orderNo}</strong></p>
			<p class="marT10"><strong id="msg"></strong></p>
			<p class="marT10"><input type="text" style="width:230px;" name="claimProcInfo" id="claimProcInfo"  maxlength="50" /></p>
		</div>
		<div class="btn_area">
			<div class="center">
				<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">취소</a><a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">확인</a>
			</div>
		</div>
		<!-- // btn_area -->
	</div>
	<!-- // popup_wrap -->
</body>
</html>
