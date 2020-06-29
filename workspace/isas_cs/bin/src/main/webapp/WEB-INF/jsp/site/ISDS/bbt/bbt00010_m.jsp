<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
	<script type="text/javascript">
	function init(){
		fnEvent();
		fnDataSetting();
	}



	function fnEvent(){
		noticeCate = function(code){
			$("#page").val(1);
			$("#boardCateSeq").val($("#boardCateSeq").val());
			$("#myListFlag").val("N");
			document.noticeForm.action = "bbt00010.do?pageCd=${boardMstCd}";
			document.noticeForm.submit();
		}
		
		keydown = function(){
			if(window.event) keycode = window.event.keyCode;
			if(keycode == 13){
				noticeCate();
			}
		}

		noticeView = function(seq) {
			$("#boardSeq").val(seq);
			document.noticeForm.action = "bbt00010V.do?pageCd=${boardMstCd}";
		   	document.noticeForm.submit();
		}

		doPage = function(pageNum){
			document.noticeForm.page.value = pageNum;
	    	document.noticeForm.action = "bbt00010.do?pageCd=${boardMstCd}";
	       	document.noticeForm.submit();
		}


		$("#regView").bind("click", function(){
			$("#noticeForm").attr("action","bbt00010R.do?pageCd=${boardMstCd}");
			$("#noticeForm").submit();
		});

		$("#myList").bind("click", function(){
			$("#sval").val("");
			$("#myListFlag").val("Y");
			$("#page").val("1");
			$("#noticeForm").attr("action","bbt00010.do?pageCd=${boardMstCd}");
			$("#noticeForm").submit();
		});

	}

	function fnDataSetting(){

	}


	</script>
</head>
<body>
	<div class="sub">
		<form id="noticeForm" name="noticeForm" method="post">
			<input type="hidden" id="boardSeq" name="boardSeq" />
			<input type="hidden" id="regId" name="regId" value="${mbrId}"/>
			<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${cateList[0].boardCateSeq}" />
			<input type="hidden" id="page" name="page" value="${param.page}"/>
			<c:if test="${myListFlag ne 'Y'}">
				<input type="hidden" id="myListFlag" name="myListFlag" value="N"/>
			</c:if>
			<c:if test="${myListFlag eq 'Y'}">
				<input type="hidden" id="myListFlag" name="myListFlag" value="Y"/>
			</c:if>
		<div class="tit_bx">
			<a href="javascript:history.back()" class="btn_prev">이전 화면</a>
			<h2>칭찬합시다</h2>
		</div>
		<!--// tit_bx -->
		<div class="sch_area">
			<div class="select_guide">
				<select class="m_select select01" name="skey" id="skey">
					<option value="1" <c:if test="${skey eq '1'}">selected</c:if> >제목</option>
					<option value="2" <c:if test="${skey eq '2'}">selected</c:if> >내용</option>
					<option value="3" <c:if test="${skey eq '3'}">selected</c:if>>제목+내용</option>
				</select>
			</div>
			<div class="input_txt_bx">
				<input type="text" name="sval" id="sval" value="${param.sval}" onkeydown="keydown();"/>
			</div>
			<div class="btnWrap">
				<a href="javascript:;" class="btn blue" onclick="noticeCate();">검색</a>
			</div>
		</div>
		<!-- //sch_area -->
		<div class="content">
			<div class="board_area">
				<div class="box_tit">
					<p class="tit">전체<span>${totalCnt}</span>건</p>
					<div class="btnWrap">
						<c:if test="${isLogIn}">
							<a href="javascript:;" id="myList" class="btn gray">나의글보기</a>
							<a href="javascript:;" id="regView" class="btn blue">글쓰기</a>
						</c:if>
					</div>
				</div>
				<div class="board mt10">
					<table>
						<caption>is 동서 칭찬합시다 목록</caption>
						<tbody>
							<c:forEach items="${noticeList}" var="noticeList" varStatus="status">
								<tr onclick="noticeView('${noticeList.boardSeq}');">
									<td class="subject">
										<a href="#" class="tit">
											<p><c:out value="${noticeList.boardTitle}"/></p>
											<ul>
												<li class="writer"><c:out value="${noticeList.regName}"/></li>
												<li class="date"><c:out value="${noticeList.regDt}"/></li>
												<li class="hit">조회수 <i>${noticeList.boardHit}</i></li>
											</ul>
										</a>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty noticeList}">
			                    <tr>
									<td colspan="5">검색된 내용이 없습니다.</td>
			                    </tr>
		                    </c:if>
						</tbody>
					</table>
				</div>
				<!-- //board -->
			</div>
			<!-- //board_area -->
			</div>
			</form>
			<c:out value="${pageTag}" escapeXml="false" />
		</div>
</body>