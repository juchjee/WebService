<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<head>
	<script type="text/javascript">
	<!--

		function init(){
			fnEvent();
		}

		function fnEvent(){
			$("#listBtn").bind("click",function(){

				makeForm("bbt00008.do?pageCd=${param.pageCd}", {"page": "${param.page}", "boardCateNm": "${param.boardCateNm}"});
			});

		}



	//-->
	</script>
</head>
<body>

	<section class="sub">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>동영상 가이드</h2>
		</div>
		<!--// tit_bx -->
		<div class="view_bx">
			<div class="view_top">
				<div class="tit">
					<p><c:out value="${noticeView.boardTitle}"/></p>
					<dl>
						<dt>제목</dt>
						<dd><c:out value="${noticeView.boardTitle}"/></dd>
						<dt>등록일</dt>
						<dd><c:out value="${noticeView.regDt}"/></dd>
						<dt>조회수</dt>
						<dd><c:out value="${noticeView.boardHit}"/></dd>
					</dl>
				</div>
			</div>
			<!--// view_top -->
			<div class="view_cont">
				<p id="boardCont">
					<textarea name="boardCont_Text" id="boardCont_Text" style="display:none;" ><c:if test="${not empty noticeView.boardCont}">${noticeView.boardCont}</c:if></textarea>
					<script type="text/javascript">
		            	$("#boardCont").html(decodeTag($("#boardCont_Text").html()));
			        </script>
				</p>
					<!-- 진짜 이미지 들어오면 삭제(이미지 가상 사이즈) -->
					<c:if test="${param.pageCd eq 'BBM00075'}">
						<div class="preview">
								<c:set var="code1" value="${fn:split(tpMov.youtubeLink, '/')}"/>
								<c:set var="code2" value="${fn:split(code1[fn:length(code1)-1],'=')}"/>
							<iframe width="330" height="250" src="https://www.youtube.com/embed/${code2[fn:length(code2)-1]}" frameborder="0" allowfullscreen></iframe>
						</div>
						<!-- <div class="preview">이미지 표시영역<br>가로 사이드 최대 590px</div> -->
					</c:if>
					<!--// 진짜 이미지 들어오면 삭제(이미지 가상 사이즈) -->
			</div>
			<!--// view_cont -->
			<div class="btnWrap wht type01">
				<a href="/ISDS/bbt/bbt00002.do?pageCd=BBM00003" class="wht_btn">1:1 문의하기</a>
				<a href="/ISDS/cs/telCsI.do" class="wht_btn">전화 상담 예약</a>
				<a href="/ISDS/cs/tserviceI.do" class="wht_btn">출장서비스 예약</a>
			</div>
			<div class="btnWrap ar pd15">
				<a href="javascript:history.back();" class="btn gray2">목록</a>
			</div>
		</div>
		<!--// view_bx -->
	</section>
	<!--// sub -->

</body>