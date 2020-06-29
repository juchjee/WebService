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
				var param = "";
				if("${param.page}" != ""){
					 param = "&page=${param.page}";
				}
				location.href="bbt00001.do?pageCd=${param.pageCd}"+param;
			});

		}



	//-->
	</script>
</head>
<body>

	<section class="sub">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>공지사항 상세</h2>
		</div>
		<!--// tit_bx -->
		<div class="view_bx">
			<div class="view_top">
				<div class="tit">
					<p><c:out value="${noticeView.boardTitle}"/></p>
					<dl>
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
					<textarea name="boardCont_Text" id="boardCont_Text" style="display:none;" >
					<c:if test="${not empty noticeView.boardCont}">${noticeView.boardCont}</c:if>
					</textarea>
					<script type="text/javascript">
		            	$("#boardCont").html(decodeTag($("#boardCont_Text").html()));
			        </script>
				</p>
				<div class="box_img mt10">
					<!-- 진짜 이미지 들어오면 삭제(이미지 가상 사이즈) -->
					<!-- <div class="preview">이미지 표시영역<br>가로 사이드 최대 590px</div> -->
					<!--// 진짜 이미지 들어오면 삭제(이미지 가상 사이즈) -->
					<c:if test="${not empty fileList}">
						<c:forEach items="${fileList}" var="fileList" varStatus="status">
							<div class="preview">
								<a href="javascript:;"  onclick="fnFileDownLoad('${fileList.attchCd}');">
									<c:out value="${fileList.attchFileNm}" />
								</a>
							</div>
						</c:forEach>
					</c:if>
				</div>
			</div>
			<!--// view_cont -->
			<div class="btnWrap ar pr15">
				<a href="#" class="btn gray2" id="listBtn">목록</a>
			</div>
		</div>
		<!--// view_bx -->
	</section>
	<!--// sub -->

</body>