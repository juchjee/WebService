<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
	<script type="text/javascript">
	<!--

		function init(){
		}

	//-->
	</script>
</head>
<body>

	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>출장서비스 예약 완료</h2>
		</div>
		<!--// tit_bx -->
		<div class="gray_bx">
			<p class="trip al">출장서비스 예약 신청이 완료되었습니다.<br>전문 엔지니어가 확인 후 전화 드리겠습니다.</p>
		</div>
		<!--// gray_bx -->
		<div class="ing_bx view nobg">
			<div class="box">
				<div class="tit">서비스 예약 정보</div>
				<dl class="type01 hr">
					<dt>접수번호</dt>
					<dd>${csInfo.asTempNo}</dd>
					<dt>구분</dt>
					<dd>${csInfo.csTypeNm}</dd>
					<dt>접수일자</dt>
					<dd><span class="date">${csInfo.regDt}</span></dd>
					<dt>예약일자</dt>
					<dd><span class="date">${csInfo.bookingDt}</span>
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
								<!-- <div class="photo first"><img src="../img/photo_view_img01.png" alt=""></div>
								<div class="photo"><img src="../img/photo_view_img02.png" alt=""></div> -->
							</div>
						</dd>
					</c:if>
				</dl>
			</div>
		</div>
		<!--// ing_bx -->

		<div class="btnBox pd15">
			<a href="cssearch.do" class="btn blue">확인</a>
		</div>
	</section>
	<!--// sub -->

</body>