<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
		<c:if test="${!isLogIn && empty nonLogin}">
			<script type="text/javascript">
				location.href="/ISDS/mm/acessLogin.do";
			</script>
		</c:if>
	<script type="text/javascript">

	function init(){
		fnEvent();
		fnDataSetting();
	}



	function fnEvent(){
		csView = function(asTempNo) {
			$("#asTempNo").val(asTempNo);
			document.workForm.action = "cssearchV.do";
		   	document.workForm.submit();
		}

		doPage = function(pageNum){
			document.workForm.page.value = pageNum;
	    	document.workForm.action = "cssearch.do";
	       	document.workForm.submit();
		}


		$("#regView").bind("click", function(){
			$("#workForm").attr("action","cssearchR.do");
			$("#workForm").submit();
		});

		$("#myList").bind("click", function(){
			$("#myListFlag").val("Y");
			$("#workForm").attr("action","cssearch.do");
			$("#workForm").submit();
		});
		
		fnOrderbyChange = function(optionVal){
			var orderby =$("#skey option:selected").val();
			$("#workForm").submit();
		}

	}

	function fnDataSetting(){

	}

	</script>
</head>
<body>

	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>예약 조회</h2>
		</div>
		<!--// tit_bx -->
		<form id="workForm" name="workForm" method="post">
		<input type="hidden" id="page" name="page" value="${param.page}"/>
		<input type="hidden" id="asTempNo" name="asTempNo" />
		<div class="box_tit" style="margin:15px;padding-bottom:25px;">
			<div class="select_guide w30">
				<select class="m_select select01" name="skey" id="skey" onchange="fnOrderbyChange(this.value);">
					<option value="0" <c:if test="${skey eq 0}">selected</c:if> >접수</option>
					<option value="1" <c:if test="${skey eq 1}">selected</c:if> >예약취소</option>
					<option value="2" <c:if test="${skey eq 2}">selected</c:if> >처리완료</option>
				</select>
			</div>
			<!-- select_guide -->
		</div>
		<c:forEach items="${csInfoList}" var="csInfo" varStatus="status">
			<div class="ing_bx view bdbtm mb0">
				<div class="box">
					<dl class="type01" onclick="csView('${csInfo.asTempNo}');">
						<dt>접수번호</dt>
						<dd>${csInfo.asTempNo}</dd>

						<dt>구분</dt>
						<dd>${csInfo.csTypeNm}</dd>

						<dt>제품</dt>
						<dd>비데</dd>

						<dt>신청일</dt>
						<dd><span class="date">${csInfo.regDt}</span></dd>

						<!-- 20191119 주석처리 -->
						<%--
						<dt>예약일</dt>
						<dd><span class="date">${csInfo.bookingDt}</span></dd>
						--%>
						<dt>진행상태</dt>
						<dd class="fc-red">
							<c:choose>
								<c:when test="${csInfo.statBc eq '0'}">
									접수대기
								</c:when>
								<c:when test="${csInfo.statBc eq 'AS204100'}">
									접수완료
								</c:when>
								<c:when test="${csInfo.statBc eq 'C'}">
									예약취소
								</c:when>
								<c:otherwise>
									처리완료
								</c:otherwise>
							</c:choose>
						</dd>
					</dl>
				</div>
			</div>
			<!--// ing_bx -->
			<div class="btnWrap pd15 mgl15 bd">
				<a href="javaScript:;" onclick="csView('${csInfo.asTempNo}');" class="btn blue">상세보기</a>
			</div>
		</c:forEach>
		<c:if test="${empty csInfoList}">
		<div style="margin-top:15px;"></div>
		<div class="btnWrap pd15 mgl15 bd">
			<div class="box" >
				<dl class="type01">
					<dt></dt>
						<dd> 검색된 내용이 없습니다.<br></dd>
				</dl>
			</div>
		</div>
		</c:if>
			</form>
	</section>
	<div style="padding-top:10px;">
	</div>
	<!--// sub -->

</body>