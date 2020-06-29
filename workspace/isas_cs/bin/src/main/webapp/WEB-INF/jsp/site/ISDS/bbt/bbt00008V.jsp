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


	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">동영상 가이드</h2>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">빠른 해결</a></li>
					<li class="last"><a href="javascript:;">동영상 가이드</a></li>
				</ul>
			</div>
		</div>
		<div class="board_view">
			<table>
				<caption>동영상가이드 상세</caption>
				<thead>
				<tr>
					<th><c:out value="${noticeView.boardTitle}"/></th>
				</tr>
				<tr>
					<td>
						<p><strong class="txt3">등록일</strong> <span><c:out value="${noticeView.regDt}"/></span></p>
						<p class="right"><strong class="txt3">조회수</strong><span><c:out value="${noticeView.boardHit}"/></span></p>
					</td>
				</tr>
				</thead>
				<tbody>
				<tr>
					<td class="cont">
						<p id="boardCont" class="txt">
							<textarea name="boardCont_Text" id="boardCont_Text" style="display:none;" ><c:if test="${not empty noticeView.boardCont}">${noticeView.boardCont}</c:if></textarea>
							<script type="text/javascript">
				            	$("#boardCont").html(decodeTag($("#boardCont_Text").html()));
					        </script>
						</p>
						<div class="box_video">
								<c:set var="code1" value="${fn:split(tpMov.youtubeLink, '/')}"/>
								<c:set var="code2" value="${fn:split(code1[fn:length(code1)-1],'=')}"/>
							<iframe width="670" height="376" src="https://www.youtube.com/embed/${code2[fn:length(code2)-1]}" frameborder="0" allowfullscreen></iframe>
						</div>
					</td>
				</tr>

				</tbody>
			</table>
		</div>
		<div class="btnArea"><button class="left" id="listBtn">목록</button></div>
		<div class="box_service">
			<div class="tit">문제해결이 되지 않으셨다면 아래의 서비스를 이용해 보시기 바랍니다.</div>
			<div class="guide_btn_list">
				<a href="/ISDS/bbt/bbt00002.do?pageCd=BBM00003" class="gb01"><strong class="hv">1:1 문의하기</strong><span>신속하게 답변 드리겠습니다.</span></a>
				<a href="/ISDS/cs/telCsI.do" class="gb02"><strong class="hv">전화 상담 예약</strong><span>도움이 필요하시다면 문의주세요.</span></a>
				<a href="/ISDS/cs/tserviceI.do" class="gb03"><strong class="hv">출장서비스 예약</strong><span>전문기사가 방문드리겠습니다.</span></a>
			</div>
		</div>
	</div>

</body>