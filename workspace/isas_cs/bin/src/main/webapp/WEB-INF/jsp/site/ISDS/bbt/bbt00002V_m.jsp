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

	<section class="sub">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>1:1문의 상세</h2>
		</div>
		<!--// tit_bx -->
		<div class="view_bx">
			<div class="view_top">
				<div class="tit">
					<p>${bbt2View.boardTitle}</p>
					<dl>
						<dt>문의구분</dt>
						<dd>${bbt2View.questionTp}</dd>
						<dt>작성자</dt>
						<dd>${bbt2View.regId}</dd>
						<dt>등록일</dt>
						<dd>${bbt2View.regDt}</dd>
					</dl>
				</div>
			</div>
			<!--// view_top -->
			<div class="view_cont qna_q">
				<p>${bbt2View.boardCont}</p>
				<div class="box_img mt10">
					<!-- 진짜 이미지 들어오면 삭제(이미지 가상 사이즈) -->
					<!-- <div class="preview">이미지 표시영역<br>가로 사이드 최대 590px</div> -->
					<!--// 진짜 이미지 들어오면 삭제(이미지 가상 사이즈) -->
					<c:forEach items="${fileList}" var="fileList" varStatus="status">
						<div class="preview">
							<img src="${fileList.attchFilePath}"/>
						</div>
					</c:forEach>
				</div>
			</div>
			<!--// view_cont -->
			<c:if test="${bbt2View.boardReply ne null && bbt2View.boardReply ne '' }">
				<div class="qna_a gray_bx">
					<div class="toparea_qna_a">
						<span class="m_name">${bbt2View.repId}</span>
						<div class="info">
							<span class="date">${bbt2View.repDt}</span>
						</div>
					</div>
					<div class="contarea_qna_a">
						<span class="tit_qna_a">${bbt2View.boardTitle}</span>
						<p class="cont_qna_a" id="boardReplyP">${bbt2View.boardReply}</p>
						<script type="text/javascript">
			            	$("#boardReplyP").html(decodeTag($("#boardReplyP").html()));
				        </script>
					</div>
	
				</div>
			</c:if>
			<div class="btnWrap ar pd15">
				<a href="#" class="btn gray2" id="listBtn">목록</a>
			</div>
		</div>
		<!--// view_bx -->
	</section>
	<!--// sub -->
	
</body>