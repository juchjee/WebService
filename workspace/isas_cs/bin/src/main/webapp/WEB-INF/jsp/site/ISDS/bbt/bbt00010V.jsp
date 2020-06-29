<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
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

			$("#delBtn").bind("click",function(){
				if(confirm('삭제하겠습니까?')){
					$('#workForm').attr('action', 'bbt00010Del.action');
					$("#workForm").submit();
				}else{
					return;
				}
			});
			$("#modBtn").bind("click",function(){
				var param = "";
				if("${param.page}" != ""){
					 param = "&page=${param.page}";
				}
				$('#workForm').attr("action","bbt00010R.do?pageCd=${param.pageCd}", {"boardSeq": "${param.boardSeq}"});
				$("#workForm").submit();
			});


		}
	</script>
</head>
<body>
	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">칭찬합시다</h2>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">고객의 소리</a></li>
					<li><a href="#">칭찬합시다</a></li>
					<li class="last"><a href="#">칭찬합시다</a></li>
				</ul>
			</div>
		</div>

		<form action="bbt00010Del.action" id="workForm" method="post">
		<input type="hidden" id="boardSeq" name="boardSeq" value="${noticeView.boardSeq}">
		<div class="board_view">
			<table>
				<caption>칭찬합시다 상세</caption>
				<thead>
					<tr>
						<th>${noticeView.boardTitle}</th>
					</tr>
					<tr>
						<td>
							<p><strong>작성자</strong><span>${noticeView.regName}</span></p>
						</td>
					</tr>
					<tr>
						<td>
							<p><strong>칭찬대상자</strong><span>${noticeView.recomName}</span></p>
						</td>
					</tr>
					<tr>
						<td>
							<p><strong class="txt3">등록일</strong> <span>${noticeView.regDt}</span></p>
							<p class="right"><strong class="txt3">조회수</strong><span class="validation[number]">${noticeView.boardHit}</span></p>
						</td>
					</tr>
				</thead>
				<tbody>
				<tr>
					<td class="cont">
						<div id="boardCont"></div>
			            <textarea name="boardCont_Text" id="boardCont_Text" style="display:none;" ><c:if test="${not empty noticeView.boardCont}">${noticeView.boardCont}</c:if></textarea>
						<script type="text/javascript">
		            		$("#boardCont").html(decodeTag($("#boardCont_Text").html()));
			            </script>
					</td>
				</tr>
				</tbody>
			</table>
		</div>
		</form>

		<div class="btnArea">
			<button class="left" id="listBtn">목록</button>
			<c:if test="${noticeY eq 'Y'}">
				<button class="center" id="modBtn">수정</button>
				<button class="right" id="delBtn">삭제</button>
			</c:if>
		</div>
	</div>
</body>