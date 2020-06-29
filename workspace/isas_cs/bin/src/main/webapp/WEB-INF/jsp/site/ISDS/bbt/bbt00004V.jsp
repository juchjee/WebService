<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--

		function init(){
			fnEvent();
		}

		function fnEvent(){
			$("#listBtn").bind("click",function(){

				makeForm("bbt00004.do?pageCd=${param.pageCd}", {"page": "${param.page}", "boardCateNm": "${param.boardCateNm}"});
			});

		}



	//-->
	</script>
</head>
<body>


	<div class="sub">
		<div class="box_guide">
			<c:choose>
				<c:when test="${param.pageCd eq 'BBM00004'}">
					<h2 class="tit">자주하는 질문</h2>
				</c:when>
				<c:when test="${param.pageCd eq 'BBM00007'}">
					<h2 class="tit">간단 조치 방법</h2>
				</c:when>
				<c:otherwise>
					<h2 class="tit"></h2>
				</c:otherwise>
			</c:choose>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">빠른 해결</a></li>
					<c:choose>
						<c:when test="${param.pageCd eq 'BBM00004'}">
							<li class="last"><a href="javascript:;">자주하는 질문</a></li>
						</c:when>
						<c:when test="${param.pageCd eq 'BBM00007'}">
							<li class="last"><a href="javascript:;">간단 조치 방법</a></li>
						</c:when>
						<c:otherwise>
							<li class="last"><a href="javascript:;"></a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
		<div class="board_view">
			<table>
				<c:choose>
					<c:when test="${boardMstCd eq 'BBM00004'}">
						<caption>자주하는 질문 상세</caption>
					</c:when>
					<c:when test="${boardMstCd eq 'BBM00007'}">
						<caption>간단 조치 방법 상세</caption>
					</c:when>
					<c:otherwise>
						<caption></caption>
					</c:otherwise>
				</c:choose>
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
				<c:if test="${not empty fileList}">
						<tr>
							<td  style="z-index: 0;">
								<div style="float:left;"><strong class="txt3">첨부파일</strong></div>
								<div style="float:left;">
									<c:forEach items="${fileList}" var="fileList" varStatus="status">
							         <div class="nowDtlAtt" style="margin-left:5px;<c:if test="${!status.frist}">margin-top:8px;</c:if>">
										<a href="javascript:;"  onclick="fnFileDownLoad('${fileList.attchCd}');">
											<c:out value="${fileList.attchFileNm}" />
										</a>
									</div>
							   		 </c:forEach>
								</div>
							    <div style="clear: both;"></div>
							</td>
						</tr>
				</c:if>
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