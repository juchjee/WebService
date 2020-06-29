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

	<div class="sub">
	<form id="questionform" name="questionForm" method="post">
		<input type="hidden" id="boardSeq" name="boardSeq" />
		<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
		<input type="hidden" id="page" name="page" value="${page}"/>

		<div class="box_guide">
			<h2 class="tit">1:1 문의</h2>
			<div class="txt_bx">
				<p class="mark">해당 게시판의 게시물은 작성자와 관리자에게만 보여집니다.</p>
				<p>궁금하신 점을 작성하시면 확인 후 답변 드리겠습니다.<br>운영시간 평일 09:00 ~ 18:00</p>
			</div>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">고객의소리</a></li>
					<li class="last"><a href="#">1:1 문의</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<div class="tblType02">
			<table>
				<caption>1:1문의 목록</caption>
				<colgroup>
					<col width="10%">
					<col width="10%">
					<col width="50%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="num1">번호</th>
						<th scope="col" class="part">문의구분</th>
						<th scope="col" class="tit">제목</th>
						<th scope="col" class="author">작성자</th>
						<th scope="col" class="enD">등록일</th>
						<th scope="col" class="ing">진행상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${questionList}" var="list">
						<tr onclick="questionView('${list.boardSeq}');">
							<td class="num1">${list.num}</td>
							<td class="part">${list.questionTp}</td>
							<td class="tit">${list.boardTitle}</td>
							<td class="author">${list.regId}</td>
							<td class="enD">${list.regDt}</td>
							<td class="ing">${list.boardState}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty questionList}">
						<tr>
			                <td colspan="6">내용이 없습니다.</td>
			            </tr>
		            </c:if>
				</tbody>
			</table>
		</div>
		<!--// 공지사항(목록) -->
		<c:out value="${pageTag}" escapeXml="false" />
		<div class="btnArea" id="writeBtn"><button type="button" class="right">글쓰기</button></div>

	</form>
	</div>
	<!--// sub -->

</body>