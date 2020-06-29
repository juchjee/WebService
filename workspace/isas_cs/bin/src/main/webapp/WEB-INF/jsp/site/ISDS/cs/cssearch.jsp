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

	//-->
	</script>
</head>
<body>
	<div class="sub">
		<form id="workForm" name="workForm" method="post">
		<input type="hidden" id="page" name="page" value="${param.page}"/>
		<input type="hidden" id="asTempNo" name="asTempNo" />

		<div class="box_guide">
			<h2 class="tit">예약 조회</h2>
			<p class="desc">서비스예약을 조회/취소할 수 있습니다.</p>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">서비스예약</a></li>
					<li class="last"><a href="#">예약 조회</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<div class="tblType02">
			<div class="select_wrap" style="float:right;margin:12px;">
				<c:choose>
					<c:when test="${skey eq '0'}">
						<span id="evenUserAge" class="select_label">접수</span>
					</c:when>
					<c:when test="${skey eq '1'}">
						<span id="evenUserAge" class="select_label">예약취소</span>
					</c:when>
					<c:when test="${skey eq '2'}">
						<span id="evenUserAge" class="select_label">처리완료</span>
					</c:when>
					<c:otherwise>
						<span id="evenUserAge" class="select_label">접수</span>
					</c:otherwise>
				</c:choose>
				<select class="m_select select01" name="skey" id="skey" onchange="fnOrderbyChange(this.value);">
					<option value="0" <c:if test="${skey eq '0'}">selected</c:if>>접수</option>
					<option value="1" <c:if test="${skey eq '1'}">selected</c:if>>예약취소</option>
					<option value="2" <c:if test="${skey eq '2'}">selected</c:if>>처리완료</option>
				</select>
			</div>
			<table>
				<caption>예약 조회 목록</caption>
				<thead>
					<tr>
						<th scope="col" class="num1">번호</th>
						<th scope="col" class="num2">접수번호</th>
						<th scope="col" class="part">구분</th>
						<th scope="col" class="obj">제품</th>
						<th scope="col" class="reP">신청일</th>
						<th scope="col" class="reD">예약일</th>
						<th scope="col" class="ing">진행상태</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${csInfoList}" var="csInfo" varStatus="status">
					<tr style="cursor:pointer;" onclick="csView('${csInfo.asTempNo}');">
						<td class="num1">${csInfo.num}</td>
						<td class="num2">${csInfo.asTempNo}</td>
						<td class="part">${csInfo.csTypeNm}</td>
						<td class="obj">비데</td>
						<td class="reP">${csInfo.regDt}</td>
						<td class="reD">${csInfo.bookingDt}</td>
						<td class="accept"><c:choose><c:when test="${csInfo.statBc eq '0'}">접수대기</c:when><c:when test="${csInfo.statBc eq 'AS204100'}">접수완료</c:when><c:when test="${csInfo.statBc eq 'C'}">예약취소</c:when><c:otherwise>처리완료</c:otherwise></c:choose></td>
					</tr>
					</c:forEach>
					<c:if test="${empty csInfoList}">
						<tr style="cursor:pointer;" onclick="csView('${csInfo.asTempNo}');">
						<td colspan="7">검색된 예약 정보가 없습니다.</td>
						</tr>
					</c:if>
				</tbody>
			</table>
		</div>
		</form>
		<c:out value="${pageTag}" escapeXml="false" />
	</div>
	<!--// sub -->

</body>