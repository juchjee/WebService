<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
	
	function init(){
		fnEvent();
	}
	
	function fnEvent(){
		
		questionView = function(seq) {
			$("#boardSeq").val(seq);
			document.questionForm.action = "bbt00002R.do?pageCd=${boardMstCd}";
		   	document.questionForm.submit();
		}
		
		$("#writeBtn").bind("click",function(){
			var param = "";
			if("${param.page}" != ""){
				 param = "&page=${page}";
			}
			location.href="bbt00002I.do?pageCd=${boardMstCd}"+param;
		});
		
		doPage = function(pageNum){
			questionform.page.value = pageNum;
	    	questionform.action = "bbt00002.do?pageCd=${boardMstCd}";
	       	questionform.submit();
		}
		
	}
	
	</script>
</head>
<body>

	<section class="sub">
		
		<form id="questionform" name="questionForm" method="post">
			<input type="hidden" id="boardSeq" name="boardSeq" />
			<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" id="page" name="page" value="${page}"/>
			
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>1:1 문의</h2>
		</div>
		<!--// tit_bx -->
		<div class="gray_bx">
			<p class="txt type2">
				<span>궁금하신 점을 작성하시면 확인 후 답변 드리겠습니다.</span>
				<span>운영시간 평일 09:00 ~ 18:00</span>
				<span>1:1 문의는 로그인 후 글 작성 및 확인이 가능합니다.</span>
				<span class="noti">* 해당 게시판의 게시물은 작성자와 관리자에게만 보여집니다</span>
			</p>
		</div>
		<!--// gray_bx -->
		<div class="btnWrap pdl10 mt10 ar">
			<a href="#" class="btn blue" id="writeBtn">글쓰기</a>
		</div>
		<!-- //btnWrap -->
		<div class="board_area pd10">
			<div class="board add_ico">
				<table>
					<caption>1:1문의 목록</caption>
					<tbody>
						<c:forEach items="${questionList}" var="list">
							<tr>
								<td class="subject">
									<a href="#" class="tit" onclick="questionView('${list.boardSeq}');">
										<p>${list.boardTitle}</p>
										<ul>
											<li class="date">${list.regId}</li>
										</ul>
										<span class="ico_brd_red">${list.boardState}</span>
									</a>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty questionList}">
							<tr>
				                <td colspan="1">내용이 없습니다.</td>
				            </tr>
			            </c:if>
					</tbody>
				</table>
			</div>
			<!-- //board -->
		</div>
		<!-- //board_area -->

		<c:out value="${pageTag}" escapeXml="false" />
		
		</form>
		
	</section>
	<!--// sub -->
		
</body>