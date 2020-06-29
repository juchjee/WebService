<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

		$('.list_goods a').bind("click",function () {
			$("#orderby").val("");
			$("#skey option:eq(0)").prop("selected","selected");
			$("#sval").val("");
			$("#boardCateNm").val($(this).text());
	    	$('#noticeForm').submit();
		});

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

	function fnDataSetting(){

		<c:choose>
		<c:when test="${param.pageCd eq 'BBM00004'}">
			$("ul.tabs li").eq(0).addClass("active");
			$("ul.tabs li").eq(0).children('div').addClass("on");
		</c:when>
		<c:when test="${param.pageCd eq 'BBM00007'}">
			$("ul.tabs li").eq(1).addClass("active");
			$("ul.tabs li").eq(1).children('div').addClass("on");
		</c:when>
		<c:when test="${param.pageCd eq 'BBM00075'}">
			$("ul.tabs li").eq(2).addClass("active");
			$("ul.tabs li").eq(2).children('div').addClass("on");
		</c:when>
		<c:when test="${param.pageCd eq 'BBM00050'}">
			$("ul.tabs li").eq(3).addClass("active");
			$("ul.tabs li").eq(3).children('div').addClass("on");
		</c:when>
		<c:otherwise>location.href="/";</c:otherwise>
	</c:choose>


	}



	//-->
	</script>
</head>
<body>
	<div class="sub">

		<form id="noticeForm" name="noticeForm" method="post">
			<input type="hidden" id="boardSeq" name="boardSeq" />
			<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${boardCateSeq}" />
			<input type="hidden" id="boardCateNm" name="boardCateNm" value="${boardCateNm}" />
			<input type="hidden" id="page" name="page" value="${param.page}"/>
		<div class="box_guide">
			<c:choose>
				<c:when test="${boardMstCd eq 'BBM00004'}">
					<h2 class="tit">자주하는 질문</h2>
				</c:when>
				<c:when test="${boardMstCd eq 'BBM00007'}">
					<h2 class="tit">간단 조치 방법</h2>
				</c:when>
				<c:otherwise>
					<h2 class="tit"></h2>
				</c:otherwise>
			</c:choose>
			<p class="desc">제품을 선택해주세요.</p>
			<div class="page_location">
				<ul>
					<li><a href="javascript:;"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="javascript:;">빠른해결</a></li>
					<c:choose>
						<c:when test="${boardMstCd eq 'BBM00004'}">
							<li class="last"><a href="javascript:;">자주하는 질문</a></li>
						</c:when>
						<c:when test="${boardMstCd eq 'BBM00007'}">
							<li class="last"><a href="javascript:;">간단 조치 방법</a></li>
						</c:when>
					</c:choose>
				</ul>
			</div>
		</div>
		<div class="list_goods">
			<c:forEach items="${cateList}" var="cateList" varStatus="status">
				<c:choose>
					<c:when test="${status.last}"><a href="javascript:;" rel="tab1" class="gd0${status.index+1} <c:if test='${cateList.boardCateNm eq boardCateNm}'>active</c:if> last" >${cateList.boardCateNm}</a></c:when>
					<c:otherwise><a href="javascript:;" rel="tab${status.index+1}" class="gd0${status.index+1} <c:if test='${cateList.boardCateNm eq boardCateNm}'>active</c:if>" >${cateList.boardCateNm}</a></c:otherwise>
				</c:choose>
			</c:forEach>
		</div>
		<div id="box_tabs">
			<div class="wrap_tabs">
				<ul class="tabs">
					<li rel="tab1" ><div class="on">자주하는 질문</div></li>
					<li rel="tab2"><div>간단 조치 방법</div></li>
					<li rel="tab3"><div>동영상 가이드</div></li>
					<li rel="tab4"><div>제품메뉴얼</div></li>
				</ul>
			</div>
			
			<div class="sch_bx">
				<fieldset>
					<legend>검색</legend>
					<div class="tblType01 in_sch_bx">
						<table>
							<caption>검색</caption>
							<tbody>
								<tr>
									<th scope="row"><label for="schTxt">검색</label></th>
									<td>
										<div>
											<select name="skey" id="skey">
												<option value="1" <c:if test="${skey eq '1'}">selected</c:if>>제목</option>
												<option value="2" <c:if test="${skey eq '2'}">selected</c:if>>내용</option>
												<option value="3" <c:if test="${skey eq '3'}">selected</c:if>>제목+내용</option>
											</select>
											<input type="text" name="sval" id="sval" value="${param.sval}" />
										</div>
										<a href="javascript:;" class="btn02Type" onclick="fnSearch(this.value);">검색</a>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
				</fieldset>
			</div>
			<!--// sch_bx -->
			
			<div class="tab_container">
				<div id="tab1" class="tab_content">
					<div class="box_tit">
						<p class="tit">전체<span>&nbsp;${totalCnt}</span>건</p>
						<div class="select_wrap">
							<c:choose>
								<c:when test="${orderby eq 1}">
									<span id="evenUserAge" class="select_label">조회수</span>
								</c:when>
								<c:when test="${orderby eq 2}">
									<span id="evenUserAge" class="select_label">제목</span>
								</c:when>
								<c:when test="${orderby eq 3}">
									<span id="evenUserAge" class="select_label">등록일</span>
								</c:when>
								<c:otherwise>
									<span id="evenUserAge" class="select_label">정렬</span>
								</c:otherwise>
							</c:choose>
							<select class="m_select select01" name="orderby" id="orderby" onchange="fnOrderbyChange(this.value);">
								<option value="" selected>정렬</option>
								<option value="1" <c:if test="${orderby eq 1}">selected</c:if> >조회수</option>
								<option value="2" <c:if test="${orderby eq 2}">selected</c:if> >제목</option>
								<option value="3" <c:if test="${orderby eq 3}">selected</c:if> >등록일</option>
							</select>
						</div>
					</div>
					<div class="board">
						<table cellspacing="0">
							<c:choose>
								<c:when test="${boardMstCd eq 'BBM00004'}">
									<caption>is 동서 빠른해결 자주하는 질문입니다.</caption>
								</c:when>
								<c:when test="${boardMstCd eq 'BBM00007'}">
									<caption>is 동서 빠른해결 간단 조치 방법 입니다.</caption>
								</c:when>
								<c:otherwise>
									<caption></caption>
									<li class="last"><a href="javascript:;"></a></li>
								</c:otherwise>
							</c:choose>
							<colgroup>
								<col style="width:90%"><col style="width:*">
							</colgroup>
							<tbody>
								<c:forEach items="${faqList}" var="faq" varStatus="status">
								<tr style="cursor:pointer;" onclick="noticeView('${faq.boardSeq}');">
									<td class="subject"><a href="javascript:;" class="tit">${faq.boardTitle}</a><p class="dateInTit">${faq.regDt}</p></td>
									<td class="count">조회수 <span class="vaildation[number]">${faq.boardHit}</span></td>
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
			</div>
			<!-- .tab_container -->
		</div>
		<!-- javascript:;box_tabs -->
		<c:out value="${pageTag}" escapeXml="false" />
		</form>
	</div>

</body>