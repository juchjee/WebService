<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<head>
	<script type="text/javascript">

	function init(){
		fnEvent();
	}


	function fnEvent(){
		noticeCate = function(code){
			$("#page").val(1);
			$("#boardCateSeq").val(code);
			document.noticeForm.action = "bbt00004.do?pageCd=${boardMstCd}";
	    	$('#noticeForm').submit();
		}

		noticeView = function(seq) {
			$("#boardSeq").val(seq);
			document.noticeForm.action = "bbt00004V.do?pageCd=${boardMstCd}";
	    	$('#noticeForm').submit();
		}

		doPage = function(pageNum){
			document.noticeForm.page.value = pageNum;
	    	document.noticeForm.action = "bbt00004.do?pageCd=${boardMstCd}";
	    	$('#noticeForm').submit();
		}

		$("ul.tabs li").bind("click",function () {
			var activeTab = $(this).attr("rel");
			$("#page").val(1);
			$("#orderby").val("");
			$("#skey option:eq(0)").prop("selected","selected");
			$("#sval").val("");
			if(activeTab == "tab1"){
				$("#noticeForm").attr("action", "bbt00004.do?pageCd=BBM00004");
		    	$('#noticeForm').submit();
			}
			if(activeTab == "tab2"){
				$("#noticeForm").attr("action", "bbt00004.do?pageCd=BBM00007");
		    	$('#noticeForm').submit();
			}
			if(activeTab == "tab3"){
				$("#noticeForm").attr("action", "bbt00008.do?pageCd=BBM00075");
		    	$('#noticeForm').submit();
			}
			if(activeTab == "tab4"){
				$("#noticeForm").attr("action", "bbt00009.do?pageCd=BBM00050");
		    	$('#noticeForm').submit();
			}
		});


		fnCateChange = function(optionVal){
			$("#orderby").val("");
			$("#skey option:eq(0)").prop("selected","selected");
			$("#sval").val("");
			$("button[name=boardCate]").each(function(){
				if(optionVal==$(this).val()){
					var boardCateNm =$(this).html();
					$("#boardCateNm").val(boardCateNm);
			    	$('#noticeForm').submit();
				}
			});
		}

		fnOrderbyChange = function(optionVal){
			var orderby =$('#orderby option:selected').val();
	    	$('#noticeForm').submit();
		}

		fnSearch = function(optionVal){
			var boardMstCd = '${boardMstCd}'; 
			$('#noticeForm').attr('action', 'bbt00004.do?pageCd='+boardMstCd);
			$('#noticeForm').submit();
		}

	}

	</script>
</head>
<body>

	<section class="sub">

	<form id="noticeForm" name="noticeForm" method="post">
		<input type="hidden" id="boardSeq" name="boardSeq" />
		<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
		<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${boardCateSeq}" />
		<input type="hidden" id="boardCateNm" name="boardCateNm" value="${boardCateNm}" />
		<input type="hidden" id="page" name="page" value="${param.page}"/>

		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<c:choose>
				<c:when test="${boardMstCd eq 'BBM00004'}">
					<h2>자주하는 질문</h2>
				</c:when>
				<c:when test="${boardMstCd eq 'BBM00007'}">
					<h2>간단 조치 방법</h2>
				</c:when>
				<c:otherwise>
					<h2></h2>
				</c:otherwise>
			</c:choose>
		</div>
		<!--// tit_bx -->
		<div class="content">
			<div class="top_btn_box">
				<c:forEach items="${cateList}" var="cateList" varStatus="status">
					<c:choose>
						<c:when test="${cateList.boardCateNm eq '이누스바스'}">
							<button type="button" style="white-space:normal;" name="boardCate" value="${cateList.boardCateSeq}" onclick="fnCateChange(this.value);" <c:if test="${cateList.boardCateNm eq boardCateNm}"> class="on" </c:if>>${cateList.boardCateNm}</button>
						</c:when>
						<c:otherwise>
							<button type="button" name="boardCate" value="${cateList.boardCateSeq}" onclick="fnCateChange(this.value);" <c:if test="${cateList.boardCateNm eq boardCateNm}"> class="on" </c:if>>${cateList.boardCateNm}</button>
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<!-- select_guide -->
			<div class="wrap_tabs mt10">
				<ul class="tabs">
					<c:choose>
						<c:when test="${boardMstCd eq 'BBM00004'}">
							<li class="active" rel="tab1"><div class="on">자주하는<br>질문</div></li>
							<li rel="tab2"><div>간단 조치<br>방법</div></li>
							<li rel="tab3"><div>동영상<br>가이드</div></li>
							<li rel="tab4"><div>제품<br>메뉴얼</div></li>
						</c:when>
						<c:when test="${boardMstCd eq 'BBM00007'}">
							<li  rel="tab1"><div class="on">자주하는<br>질문</div></li>
							<li class="active"rel="tab2"><div class="on">간단 조치<br>방법</div></li>
							<li rel="tab3"><div>동영상<br>가이드</div></li>
							<li rel="tab4"><div>제품<br>메뉴얼</div></li>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
				</ul>
			</div>
			<div class="sch_area" style="margin-top:12px;padding:0px;">
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
					<a href="#" class="btn blue" onclick="fnSearch(this.value);">검색</a>
				</div>
			</div>
			<!-- //sch_area -->
			<div class="tab_container">
				<div id="tab1" class="tab_content">
					<div class="box_tit">
						<p class="tit">전체<span>${totalCnt}</span>건의 자료가 있습니다.</p>
						<div class="select_guide w30">
							<select class="m_select select01" name="orderby" id="orderby" onchange="fnOrderbyChange(this.value);">
								<option value="" selected>정렬</option>
								<option value="1" <c:if test="${orderby eq 1}">selected</c:if> >조회수</option>
								<option value="2" <c:if test="${orderby eq 2}">selected</c:if> >제목</option>
								<option value="3" <c:if test="${orderby eq 3}">selected</c:if> >등록일</option>
							</select>
						</div>
						<!-- select_guide -->
					</div>
					<div class="board">
						<table>
							<c:choose>
								<c:when test="${boardMstCd eq 'BBM00004'}">
									<caption>is 동서 빠른해결 자주하는 질문입니다.</caption>
								</c:when>
								<c:when test="${boardMstCd eq 'BBM00007'}">
									<caption>is 동서 빠른해결 간단조치 방법입니다.</caption>
								</c:when>
								<c:otherwise></c:otherwise>
							</c:choose>
							<tbody>
								<c:forEach items="${faqList}" var="faq" varStatus="status">
									<tr style="cursor:pointer;" onclick="noticeView('${faq.boardSeq}');">
										<td class="subject">
											<a href="javascript:;" class="tit">
												<p>${faq.boardTitle}</p>
												<ul>
													<li class="date">${faq.regDt }</li>
													<li class="hit">조회수 <i  class="vaildation[number]">${faq.boardHit }</i></li>
												</ul>
											</a>
										</td>
									</tr>
	                    		</c:forEach>
                    			<c:if test="${empty faqList}">
	                    			<tr>
										<td colspan="2" style="text-align:center;">검색된 내용이 없습니다.</td>
									</tr>
                    			</c:if>
							</tbody>
						</table>
					</div>
				</div>
				<!-- #tab1 -->
				<div id="tab2" class="tab_content">
					<div class="box_tit">
						<p class="tit">전체<span>100</span>건의 자료가 있습니다.</p>
						<div class="select_guide w30">
							<select class="m_select select01" name="#" id="ct_select">
								<option value="#">조회수</option>
								<option value="#">제목</option>
								<option value="#">등록일</option>
							</select>
						</div>
						<!-- select_guide -->
					</div>
				</div>
				<!-- #tab4 -->
			</div>
			<!--// tab_container -->
		</div>

		<c:out value="${pageTag}" escapeXml="false" />

	</form>

	</section>
	<!--// sub -->


</body>
</html>
