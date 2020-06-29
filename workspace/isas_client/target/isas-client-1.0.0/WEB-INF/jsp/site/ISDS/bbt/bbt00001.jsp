<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
	<script type="text/javascript">

		function init(){
			fnEvent();
		}

		function fnEvent(){

			noticeView = function(seq) {
				$("#boardSeq").val(seq);
				document.noticeForm.action = "/ISDS/bbt/bbt00001V.do";
			   	document.noticeForm.submit();
			}

			doPage = function(pageNum){
				document.noticeForm.page.value = pageNum;
		    	document.noticeForm.action = "/ISDS/bbt/bbt00001.do?pageCd=${boardMstCd}";
		       	document.noticeForm.submit();
			}
		}

	</script>
</head>
<body>
	<section class="sub cont">
	
		<form id="noticeForm" name="noticeForm" method="post">
			<input type="hidden" id="boardSeq" name="boardSeq" />
			<input type="hidden" id="pageCd" name="pageCd" value="${boardMstCd}" />
			<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${boardCateSeq}" />
			<input type="hidden" id="page" name="page" value="${page}"/>
		</form>
		
		<div class="tit_bx">
			<a href="javascript:" onclick="location.href='/'" class="btn_prev">이전 화면</a>
			<h2>공지사항</h2>
		</div>
		<!--// tit_bx -->
		<div class="ntc">
			
			<c:forEach items="${noticeList}" var="noticeList" varStatus="status">
				<c:choose>
					<c:when test="${noticeList.boardFirstYn eq 'Y'}">
						<div class="box">
							<a href="javascript:" onclick="noticeView('${noticeList.boardSeq}');">
								<p>${noticeList.boardTitle}</p>
								<ul>
									<li>${noticeList.regDt}</li>
								</ul>
							</a>
						</div>
					</c:when>
					<c:when test="${noticeList.boardFirstYn eq 'N'}">
						<div class="box">
							<a href="javascript:" onclick="noticeView('${noticeList.boardSeq}');">
								<p>${noticeList.boardTitle}</p>
								<ul>
									<li>${noticeList.regDt}</li>
								</ul>
							</a>
						</div>
					</c:when>
				</c:choose>
			</c:forEach>
			<c:if test="${empty noticeList}">
				<div class="box">
					<a href="#">
						<p>내용이 없습니다.</p>
					</a>
				</div>
            </c:if>
		</div>
		<c:out value="${pageTag}" escapeXml="false" />
		<!--// ntc_list -->
	</section>
	<!--// sub -->
</body>