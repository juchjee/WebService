<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
	<script type="text/javascript">


	function init(){
		fnEvent();
	}

	function fnEvent(){
		$("#listBtn").bind("click", function(){
			var page = "";
			<c:if test="${not empty param.page}">
				page = "?page=${param.page}";
			</c:if>
			location.href = "cssearch.do"+page;
		});

		$("#cancelBtn").bind("click", function(){
			<c:choose>
				<c:when test="${csInfo.statBc eq '0'}">fnSubmit("workForm","예약취소");</c:when>
				<c:otherwise>alert("접수대기 상태에서만 취소할 수 있습니다.");</c:otherwise>
			</c:choose>
		});
	}

	</script>
</head>
<body>
	<form id="workForm" name="workForm" action="csCancel.action" method="post" >
		<input type="hidden" name="asTempNo" id="asTempNo" value="${csInfo.asTempNo}" />
	</form>
	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>예약 상세</h2>
		</div>
		<!--// tit_bx -->
		<div class="ing_bx view nobg">
			<div class="box">
				<div class="tit">서비스 예약 정보</div>
				<dl class="type01 hr">
					<dt>접수번호</dt>
					<dd>${csInfo.asTempNo} <c:if test="${not empty csInfo.asNo}"> / ${csInfo.asNo}</c:if></dd>
					<dt>구분</dt>
					<dd>${csInfo.csTypeNm}</dd>
					<dt>접수일자</dt>
					<dd><span class="date">${csInfo.regDt}</span></dd>
					<dt>예약일자</dt>
					<dd><span class="date">${csInfo.bookingDt}</span><span class="time">${csInfo.csTimeValue}</span></dd>
					<dt>제품</dt>
					<dd>${csInfo.modelItemNm}</dd>
					<dt>모델</dt>
					<dd>${csInfo.spec}</dd>
					<dt>고장증상</dt>
					<dd>${csInfo.ascodeLev1Nm} &gt; ${csInfo.ascodeLev2Nm}</dd>
					<dt>고장증상 상세</dt>
					<dd class="hauto">${csInfo.comment}</dd>
					<dt>성명</dt>
					<dd>${csInfo.tNm}</dd>
					<dt>연락가능번호</dt>
					<dd>${csInfo.tHp}</dd>
					<dt>주소</dt>
					<dd class="hauto">${csInfo.tZipCd} ${csInfo.tAddr} ${csInfo.t_addr2}</dd>
					<c:if test="${not empty fileList}">
						<dt>이미지</dt>
						<dd class="hauto">
							<div class="photo_bx">
								<c:forEach items="${fileList}" var="fileList" varStatus="status">
									<c:choose>
										<c:when test="${status.index eq 0}">
											<div class="photo first">
												<img src="${fileList.attchFilePath}"/>
											</div>
										</c:when>
										<c:otherwise>
											<div class="photo">
												<img src="${fileList.attchFilePath}"/>
											</div>
										</c:otherwise>
									</c:choose>
								</c:forEach>
							</div>
						</dd>
					</c:if>
				</dl>
			</div>
		</div>
		<!--// ing_bx -->

		<div class="btnWrap wide pd15">
			<a href="#none" id="listBtn" class="btn gray">목록</a>
			<c:if test="${csInfo.statBc eq '0'}">
				<a href="#none" id="cancelBtn" class="btn blue">예약취소</a>
			</c:if>
		</div>
	</section>
	<!--// sub -->

</body>