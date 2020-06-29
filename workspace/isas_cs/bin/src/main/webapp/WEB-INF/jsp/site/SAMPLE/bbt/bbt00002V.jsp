<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<script type="text/javascript">
	<!--

		function init(){
			fnEvent();
		}

		function fnEvent(){
			$.delSubmit = function(){
				if(confirm('삭제하겠습니까?')){
					$('#workForm').attr('action', 'bbt00002Del.action');
					$("#workForm").submit();
				}else{
					return;
				}
			}
		}
	//-->
	</script>
</head>
<body>

	<div id="container" class="qna">
		<div id="contents" class="inner">

			<h3><img src="/common/images/tit/h3_tit8_3.png" alt="고객상담"></h3>

			<form id="workForm" name="workForm" action="bbt00002Save.action" method="post" >
			<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" name="boardSeq" id="boardSeq" value="${bbt2View.boardSeq}" />
			<input type="hidden" name="page" value="${param.page}">

			<div class="qna_write">
				<ul class="tabmenu">
					<li class="on"><a href="bbt00002.do?pageCd=${boardMstCd}">고객상담</a></li>
				</ul>

				<div class="top_info">
					<ul>
						<li> 듀오락 담당자가 직접 제품에 대한 궁금증을 풀어 드립니다.</li>
						<li>작성하신 고객상담 내역은 <a href="${rootUri}${frontUri}user/myadvice.do">마이페이지 > 나의 문의내역</a>에서 손쉽게 확인하실 수 있습니다.</li>
						<li>작성하신 고객상담 내역은 자동으로 비공개 처리 됩니다.</li>
						<!-- <li>답변 등록 완료 후 이메일&SMS로 답변 등록 알람 메시지가 날아갑니다</li> -->
					</ul>
				</div>

				<table class="tsytle tbl_res4" cellpadding="0" cellspacing="0">
					<colgroup>
						<col width="250">
						<col width="750">
					</colgroup>
					<tbody>
						<tr>
							<th>제목</th>
							<td>
								<c:out value="${bbt2View.boardTitle}"/>
							</td>
						</tr>
						<tr>
							<th>아이디</th>
							<td>
								<c:out value="${bbt2View.regId}"/>
							</td>
						</tr>
						<tr>
							<th>분류</th>
							<td>
								<c:out value="${bbt2View.boardCateNm}" />
							</td>
						</tr>
						<tr>
							<th>공개여부</th>
							<td>
								<input disabled="disabled" type="radio" name="openYn" id="openY" value="N" <c:if test="${bbt2View.openYn eq 'N'}">checked</c:if> />비공개
								<input disabled="disabled" type="radio" name="openYn" id="openN" value="Y" <c:if test="${bbt2View.openYn eq 'Y'}">checked</c:if> />공개
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td class="writing">
								<div id="boardCont">
			            		  <textarea name="boardCont_Text" id="boardCont_Text" style="display:none;" ><c:if test="${not empty bbt2View.boardCont}">${bbt2View.boardCont}</c:if></textarea>
								<script type="text/javascript">
		            				$("#boardCont").html(decodeTag($("#boardCont_Text").html()));
			            		</script>
								</div>
							</td>
						</tr>
						<c:if test="${!empty bbt2View.boardReply}" >
						<tr>
							<th>답글</th>
							<td class="writing">
								<div id="boardReply">
									 <textarea name="boardReply_Text" id="boardReply_Text" style="display:none;" ><c:if test="${not empty bbt2View.boardReply}">${bbt2View.boardReply}</c:if></textarea>
									<script type="text/javascript">
			            				$("#boardReply").html(decodeTag($("#boardReply_Text").html()));
				            		</script>
								</div>
							</td>
						</tr>
						</c:if>
					</tbody>
				</table>
			</div>
			</form>
			<div class="btn_wrap" style="width:400px;">
				<c:if test="${bbt2View.regId eq mbrId}">
					<a class="btn01"  href="javascript:;" onclick="$.delSubmit();">삭제하기</a>
				</c:if>
				<a class="btn01_1" href="bbt00002.do?pageCd=${boardMstCd}&page=${param.page}">취소</a>
			</div>
		</div>
	</div>
</body>