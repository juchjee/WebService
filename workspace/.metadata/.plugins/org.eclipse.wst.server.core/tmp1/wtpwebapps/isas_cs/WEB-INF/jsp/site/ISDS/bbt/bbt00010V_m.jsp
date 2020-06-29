<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
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

				location.href="bbt00010.do?pageCd=${param.pageCd}"+param;
			});

			$("#modBtn").bind("click",function(){
				var param = "";
				if("${param.page}" != ""){
					 param = "&page=${param.page}";
				}
				$('#workForm').attr("action","bbt00010R.do?pageCd=${param.pageCd}", {"boardSeq": "${param.boardSeq}"});
				$("#workForm").submit();
			});

			$("#delBtn").bind("click",function(){
				if(confirm('삭제하겠습니까?')){
					$('#workForm').attr('action', 'bbt00010Del.action');
					$("#workForm").submit();
				}else{
					return;
				}
			});

		}

	</script>
</head>
<body>
	<div class="sub">
		<div class="tit_bx">
			<a href="javascript:history.back()" class="btn_prev">이전 화면</a>
			<h2>칭찬합시다 상세</h2>
		</div>
		<form action="bbt00010Del.action" id="workForm" method="post">
		<input type="hidden" id="boardSeq" name="boardSeq" value="${noticeView.boardSeq}">
		<!--// tit_bx -->
		<div class="view_bx">
			<div class="view_top">
				<div class="tit">
					<p>${noticeView.boardTitle}</p>
					<dl>
						<dt>제목</dt>
						<dd>${noticeView.boardTitle}</dd>
						<dt>칭찬대상자</dt>
						<dd>${noticeView.recomName}</dd>
						<dt>등록일</dt>
						<dd>${noticeView.regDt}</dd>
						<dt>조회수</dt>
						<dd>${noticeView.boardHit}</dd>
					</dl>
				</div>
			</div>
			<!--// view_top -->
			<div class="view_cont">
				<!-- <p>내용내용내용내용내용내용내용내용내용내용<br>내용내용내용내용내용내용내용내용내용내용<br>내용내용내용내용내용내용내용내용내용내용<br>내용내용내용내용내용내용내용내용내용내용</p> -->
				<p id="boardCont"></p>
				<textarea name="boardCont_Text" id="boardCont_Text" style="display:none;" ><c:if test="${not empty noticeView.boardCont}">${noticeView.boardCont}</c:if></textarea>
				<script type="text/javascript">
		            		$("#boardCont").html(decodeTag($("#boardCont_Text").html()));
			            </script>
				<div class="box_img mt10">
					<!-- 진짜 이미지 들어오면 삭제(이미지 가상 사이즈) -->
					<!-- <div class="preview">이미지 표시영역<br>가로 사이드 최대 590px</div> -->
					<!--// 진짜 이미지 들어오면 삭제(이미지 가상 사이즈) -->
				</div>
			</div>
			<!--// view_cont -->
			<div class="btnWrap ar pr15">
				<a href="javascript:;" class="btn left" id="listBtn">목록</a>
				<c:if test="${noticeY eq 'Y'}">
					<a href="javascript:;" class="btn center" id="modBtn">수정</a>
					<a href="javascript:;" class="btn right" id="delBtn">삭제</a>
				</c:if>
			</div>
		</div>
		</form>
		<!--// view_bx -->
	</div>

</body>