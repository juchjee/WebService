<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
	<script type="text/javascript">
	<!--

		function init(){
			fnEvent();
			fnDataSetting();
		}



		function fnEvent(){
			noticeCate = function(code){
				$("#page").val(1);
				$("#boardCateSeq").val(code);
				document.noticeForm.action = "bbt00001.do?pageCd=${boardMstCd}";
				document.noticeForm.submit();
			}

			noticeView = function(seq) {
				$("#boardSeq").val(seq);
				document.noticeForm.action = "bbt00001V.do?pageCd=${boardMstCd}";
			   	document.noticeForm.submit();
			}

			doPage = function(pageNum){
				document.noticeForm.page.value = pageNum;
		    	document.noticeForm.action = "bbt00001.do?pageCd=${boardMstCd}";
		       	document.noticeForm.submit();
			}
		}

		function fnDataSetting(){

		}

	//-->
	</script>
</head>
<body>

	<section class="sub">
	
		<form id="noticeForm" name="noticeForm" method="post">
			<input type="hidden" id="boardSeq" name="boardSeq" />
			<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${boardCateSeq}" />
			<input type="hidden" id="page" name="page" value="${param.page}"/>
			
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>공지사항</h2>
		</div>
		<!--// tit_bx -->
		<div class="sch_area">
			<div class="select_guide">
				<select class="m_select select01" name="skey" id="skey">
					<option value="1" <c:if test="${skey eq '1'}">selected</c:if>>제목</option>
					<option value="2" <c:if test="${skey eq '2'}">selected</c:if>>내용</option>
					<option value="3" <c:if test="${skey eq '3'}">selected</c:if>>제목+내용</option>
				</select>
			</div>
			<div class="input_txt_bx">
				<input type="text" name="sval" id="sval" value="${param.sval}" />
			</div>
			<div class="btnWrap">
				<a href="#" class="btn blue" onclick="noticeCate('');">검색</a>
			</div>
		</div>
		<!-- //sch_area -->
		<div class="content">
			<div class="board_area">
				<div class="box_tit pb15">
					<p class="tit">전체<span>${totalCnt}</span>건</p>
				</div>
				<div class="board">
					<table>
						<caption>inus 서비스센터 공지사항 목록</caption>
						<tbody>
							<c:forEach items="${noticeList}" var="noticeList" varStatus="status">
								<tr>
									<td class="subject">
										<a href="#" class="tit" onclick="noticeView('${noticeList.boardSeq}');">
											<p><c:out value="${noticeList.boardTitle}"/></p>
											<ul>
												<li class="date"><c:out value="${noticeList.regDt}"/></li>
												<li class="hit">조회수 <i>${noticeList.boardHit}</i></li>
											</ul>
										</a>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
				<!-- //board -->
			</div>
			<!-- //board_area -->

		</div>
		
		</form>
		
		<c:out value="${pageTag}" escapeXml="false" />
		
	</section>
	<!--// sub -->

</body>