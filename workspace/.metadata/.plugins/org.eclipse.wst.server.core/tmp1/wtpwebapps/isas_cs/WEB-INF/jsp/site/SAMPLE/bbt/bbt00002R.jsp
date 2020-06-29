<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
	<!--

		var oEditors = [];

		function init(){

			fnEvent();
			if('${bbt2View.boardSeq}' == ''){
				$('.btn_wrap').css('width', '400px');
				$('#regBtn').prop('class', 'btn01');
				$('#delBtn').hide();
			}
/*
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "boardCont",
				sSkinURI: "/SE/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				},
				fOnAppLoad : function(){  },
				fCreator: "createSEditor2"
			});
*/
		}

		function fnEvent(){
			$.submit = function(){
				if('${bbt2View.boardSeq}' == ''){
					$('#regBtn').prop('class', 'btn01');
					$('#delBtn').hide();
				}
				if($("#boardTitle").val()==""){
					alert("제목은(는) 필수 항목입니다.");
					$("#boardTitle").focus();
					$('#regBtn').show();
					return false;
				}

				if($("#boardCont").val()==""){
					alert("내용은(는) 필수 항목입니다.");
					$("#boardCont").focus();
					$('#regBtn').show();
					return false;
				}

/*
				if(oEditors[0].getIR()=="<p><br></p>"){
					alert("내용은(는) 필수 항목입니다.");
					return false;
				}
				oEditors.getById["boardCont"].exec("UPDATE_CONTENTS_FIELD", []);
*/
 				$("#workForm").submit();
			}
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
			<h3>${boardMstNm}</h3>

			<script type="text/javascript">
			if($('#contents h3').text()=='고객상담'){
				$('#contents h3').html('<img src="/common/images/tit/h3_tit5_2.png" alt="고객상담">');
			}
			if($('#contents h3').text()=='서비스문의'){
				$('#contents h3').html('<img src="/common/images/tit/h3_tit5_3.png" alt="서비스문의">');
			}
			</script>

			<form id="workForm" name="workForm" action="bbt00002Save.action" method="post" >
			<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" name="boardSeq" id="boardSeq" value="${bbt2View.boardSeq}" />
			<div class="qna_write">
				<ul class="tabmenu">
					<li class="on">
						<a href="#">
							${boardMstNm}
						</a>
					</li>
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
							<td><input type="text" name="boardTitle" id="boardTitle" class="validation[required]" title="제목" value="${bbt2View.boardTitle}" /></td>
						</tr>
						<tr>
							<th>아이디</th>
							<td>
								<c:out value="${mbrId}"/>
								<input type="hidden" name="regId" id="regId" value="${mbrId}" />
							</td>
						</tr>
						<c:choose>
			  				<c:when test="${fn:length(cateList) > 1}">
								<tr>
									<th>분류</th>
									<td>
										<p class="mem_dc">
											<select id="boardCateSeq" name="boardCateSeq">
												<c:if test="${empty bbt2View}">
													<c:forEach items="${cateList}" var="cateList">
														<option value="${cateList.boardCateSeq}" >${cateList.boardCateNm}</option>
													</c:forEach>
												</c:if>
												<c:if test="${!empty bbt2View}">
													<c:forEach items="${cateList}" var="cateList">
														<option value="${cateList.boardCateSeq}" <c:if test="${cateList.boardCateSeq eq bbt2View.boardCateSeq}">selected</c:if> >${cateList.boardCateNm}</option>
													</c:forEach>
												</c:if>
											</select>
										</p>
									</td>
								</tr>
							</c:when>
		  					<c:otherwise>
								<tr style="display:none;">
									<th>분류</th>
									<td>
										<p class="mem_dc">
											<select id="boardCateSeq" name="boardCateSeq">
												<c:forEach items="${cateList}" var="cateList">
													<option value="${cateList.boardCateSeq}" >${cateList.boardCateNm}</option>
												</c:forEach>
											</select>
										</p>
									</td>
								</tr>
		  					</c:otherwise>
		  				</c:choose>
						<tr>
							<th>공개여부</th>
							<td>
								<c:if test="${empty bbt2View}">
									<input type="radio" name="openYn" id="openY" value="N" checked />비공개
									<input type="radio" name="openYn" id="openN" value="Y" />공개
									<!-- 게시물은 기본적으로 비밀글로 설정되어 있습니다. -->
								</c:if>
								<c:if test="${!empty bbt2View}">
									<input type="radio" name="openYn" id="openY" value="N" <c:if test="${bbt2View.openYn eq 'N'}">checked</c:if> />비공개
									<input type="radio" name="openYn" id="openN" value="Y" <c:if test="${bbt2View.openYn eq 'Y'}">checked</c:if> />공개
								</c:if>
							</td>
						</tr>
						<tr>
							<th>내용</th>
							<td class="writing">
								<div>
									<textarea name="boardCont" id="boardCont" rows="10" cols="100" style="width:100%; height:351px;"><c:out value="${bbt2View.boardCont}"/></textarea>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<input type="hidden" name="page" value="${param.page}">
			</form>
			<div class="btn_wrap" style="width: 600px; text-align: center;">
				<%-- <a href="javascript:;" onclick="$.submit();"><img src="${rootUri}common/img/icon/write_btn.png" alt="등록하기" /></a> --%>
				<a class="btn01_1" id="regBtn" href="javascript:;" onclick="$.submit();">등록하기</a>
				<a class="btn01" id="delBtn" href="javascript:;" onclick="$.delSubmit();">삭제하기</a>
				<a class="btn01_1" href="bbt00002.do?pageCd=${boardMstCd}&page=${param.page}">취소</a>
			</div>
		</div>
	</div>
</body>