<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<style type="text/css">
		.access .input_box > input[type="button"] {width:29%;}
		.btn02Type, .btn03Type{height:100%}
	</style>
	<script type="text/javascript" defer="defer">
	<!--
		function init(){
			fnEvent();
			fnDataSetting();
		}

		function fnEvent(){

		}

		function fnDataSetting(){
		}
	//-->
</script>

</head>
<body>
	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:" onclick="location.href='inusRepairState.do'" class="btn_prev">이전 화면</a>
			<h2>A/S 접수현황 상세</h2>
		</div>
		<!--// tit_bx -->
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">A/S접수 현황</div>
				<dl class="situ2">
					<dt>접수번호</dt>
					<dd>${repairStateView.asNo}</dd>
				</dl>
				<dl class="situ2">
					<dt>접수일자</dt>
					<dd>${repairStateView.recDt}</dd>
				</dl>
				<dl class="situ2">
					<dt>고객명</dt>
					<dd>${repairStateView.tNm}</dd>
				</dl>
				<dl class="situ2">
					<dt>핸드폰번호</dt>
					<dd><div class="call"><a href="tel:${repairStateView.tHp}">${repairStateView.tHp}</a></div></dd>
				</dl>
				<dl class="situ2">
					<dt>주소</dt>
					<dd class="lheight">${repairStateView.tAddrNm}</dd>
				</dl>
				<dl class="situ2">
					<dt>품목구분</dt>
					<dd>
					<c:choose>
						<c:when test="${repairStateView.itmGubun eq 'SDH0809'}">비데</c:when>
						<c:when test="${repairStateView.itmGubun eq 'SDH0817'}">위생도기</c:when>
						<c:when test="${repairStateView.itmGubun eq 'SDH0802'}">수전</c:when>
						<c:when test="${repairStateView.itmGubun eq 'SDH0818'}">블랜더</c:when>
						<c:otherwise>이수스바스</c:otherwise>
					</c:choose>
					</dd>
				</dl>
				<dl class="situ2">
					<dt>품목코드/품목명</dt>
					<dd class="lheight">${repairStateView.itmCd} / ${repairStateView.itmNm}</dd>
				</dl>
				<dl class="situ2">
					<dt>접수증상대분류</dt>
					<dd>${repairStateView.reBcNm}</dd>
				</dl>
				<dl class="situ2">
					<dt>접수증상중분류</dt>
					<dd>${repairStateView.re2BcNm}</dd>
				</dl>
				<dl class="situ2 bdn">
					<dt>증상상세</dt>
					<dd class="lheight">${repairStateView.reNm}</dd>
				</dl>
				<a href="inusRepairStateHistory.do?asNo=${repairStateView.asNo}" class="btn line pop">History</a>
			</div>
		</div>
		<!--// ing_bx(A/S접수) -->
		<div class="btnBox pd15">
		<%-- 20190509 기존 품목코드가 등록내역 모델에 셋팅되게끔 oriItmId 추가 --%>
<%-- 			<a href="inusRepairStateRegister.do?asNo=${repairStateView.asNo}&itmId=${repairStateView.itmId}&itmGubun=${repairStateView.itmGubun}" class="btn">A/S 수리내역 등록</a> --%>
			<a href="inusRepairStateRegister.do?asNo=${repairStateView.asNo}&itmId=${repairStateView.itmId}&itmGubun=${repairStateView.itmGubun}&oriItmId=${repairStateView.oriItmId}" class="btn">A/S 수리내역 등록</a>
		</div>
	</section>
	<!--// sub -->
</body>