<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<script type="text/javascript">

		function init(){
			fnEvent();
		}

		function fnEvent(){

			$("#listBtn").bind("click",function(){
				var param = "";
				if("${param.page}" != ""){
					 param = "&page=${param.page}";
				}
				location.href="bbt00002R.do?pageCd=${boardMstCd}"+param;
			});

		}
	</script>
</head>
<body>

	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">1:1문의</h2>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">고객의소리</a></li>
					<li class="last"><a href="#">1:1문의</a></li>
				</ul>
			</div>
		</div>
		<div class="board_view">
			<table>
				<caption>1:1문의 상세</caption>
				<thead>
					<tr>
						<th>${bbt2View.boardTitle}</th>
					</tr>
					<tr>
						<td>
							<p><strong>문의구분</strong><span>${bbt2View.questionTp}</span></p>
						</td>
					</tr>
					<tr>
						<td>
							<p><strong>작성자</strong><span>${bbt2View.regId}</span></p>
						</td>
					</tr>
					<tr>
						<td>
							<p><strong>등록일</strong><span>${bbt2View.regDt}</span></p>
						</td>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="cont">
							<p class="txt">
								${bbt2View.boardCont}
							</p>
							<div class="box_img">
								<!-- 진짜 이미지 들어오면 삭제(이미지 가상 사이즈) -->
								<!-- <div class="preview">이미지 표시영역<br>가로 사이드 최대 960px</div> -->
								<!--// 진짜 이미지 들어오면 삭제(이미지 가상 사이즈) -->
								<c:forEach items="${fileList}" var="fileList" varStatus="status">
										<div class="preview">
											<img src="${fileList.attchFilePath}" style="width:140px;height:94px;" />
										</div>
								</c:forEach>
							</div>
						</td>
					</tr>
					<c:if test="${bbt2View.boardReply ne null && bbt2View.boardReply ne '' }">
					<tr>
						<td class="reply">
							<dl class="reply_top">
								<dt><span class="name pr20">${bbt2View.repId}</span>
									<div class="">
										<span class="date pr20">${bbt2View.repDt}</span>
										<span class="hit"><i class="mr5">조회수</i>${bbt2View.boardHit}</span>
									</div>
								</dt>
								<dd>
									<p class="tit mb15">${bbt2View.boardTitle}</p>
									<p class="content" id="boardReplyP">${bbt2View.boardReply}</p>
									<script type="text/javascript">
						            	$("#boardReplyP").html(decodeTag($("#boardReplyP").html()));
							        </script>
								</dd>
							</dl>
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		<div class="btnArea"><button class="left" id="listBtn">목록</button></div>
		<div class="box_service">
			<div class="tit">문제해결이 되지 않으셨다면 아래의 서비스를 이용해 보시기 바랍니다.</div>
				<div class="guide_btn_list">
					<a href="/ISDS/bbt/bbt00002R.do?pageCd=${boardMstCd}" class="gb01"><strong class="hv">1:1 문의하기</strong><span>신속하게 답변 드리겠습니다.</span></a>
					<a href="/ISDS/cs/telCsI.do" class="gb02"><strong class="hv">전화 상담 예약</strong><span>도움이 필요하시다면 문의주세요.</span></a>
					<a href="/ISDS/cs/tserviceI.do" class="gb03"><strong class="hv">출장서비스 예약</strong><span>전문기사가 방문드리겠습니다.</span></a>
				</div>
			</div>
		</div>

</body>