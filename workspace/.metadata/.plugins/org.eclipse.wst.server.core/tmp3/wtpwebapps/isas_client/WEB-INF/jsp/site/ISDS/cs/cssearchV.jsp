<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
	<script type="text/javascript">

	<!--
	function init(){
		fnEvent();
	}

	function fnEvent(){
		$("#listBtn").bind("click", function(){
			var page = "";
			<c:if test="${not empty param.page}">
				page = "?page=${param.page}";
			</c:if>
			location.href = "cssearch.do"+page;
		});

		$("#cancelBtn").bind("click", function(){
			<c:choose>
				<c:when test="${csInfo.status eq 'T'}">fnSubmit("workForm","예약취소");</c:when>
				<c:otherwise>alert("접수대기 상태에서만 취소할 수 있습니다.");</c:otherwise>
			</c:choose>
		});
	}
	-->
	</script>
</head>
<body>

	<form id="workForm" name="workForm" action="csCancel.action" method="post" >
		<input type="hidden" name="asTempNo" id="asTempNo" value="${csInfo.asTempNo}" />
	</form>
	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">예약상세</h2>
			<div class="txt_bx">
				<p>예약 상세내역을 확인하세요.</p>
			</div>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">서비스예약</a></li>
					<li><a href="#">예약 취소</a></li>
					<li class="last"><a href="#">예약 상세</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<!--// msg_bx -->
		<div class="reserv mt30">
			<h3>서비스 예약 정보</h3>
			<div class="tblType01 mt15 mb30">
				<table>
					<caption>서비스예약신청 확인란</caption>
					<tbody>
						<tr>
							<th scope="row">접수번호</th>
							<td>${csInfo.asTempNo}</td>
						</tr>
						<tr>
							<th scope="row">구분</th>
							<td>${csInfo.csTypeNm}</td>
						</tr>
						<tr>
							<th scope="row">접수일자</th>
							<td>${csInfo.regDt}</td>
						</tr>
						<tr>
							<th scope="row">예약일자</th>
							<td><span class="date mr30">${csInfo.bookingDt}</span><span class="time">${csInfo.csTimeValue}</span></td>
						</tr>
						<tr>
							<th scope="row">제품</th>
							<td>비데</td>
						</tr>
						<tr>
							<th scope="row">모델</th>
							<td>방수비데 스팀 ss-365</td>
						</tr>
						<tr>
							<th scope="row">고장증상</th>
							<td>${csInfo.ascodeLev1Nm} &gt; ${csInfo.ascodeLev2Nm} </td>
						</tr>
						<tr>
							<th scope="row">고장증상 상세</th>
							<td>${csInfo.comment}</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div class="reserv">
			<h3>고객 정보</h3>
			<div class="tblType01 mt15">
				<table>
					<caption>서비스예약신청 확인란</caption>
					<tbody>
						<tr>
							<th scope="row">성명</th>
							<td>${csInfo.tNm}</td>
						</tr>
						<tr>
							<th scope="row">연락가능번호</th>
							<td>${csInfo.tHp}</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td>${csInfo.tZipCd} ${csInfo.tAddr} ${csInfo.t_addr2}</td>
						</tr>
						<tr>
							<th scope="row">첨부파일</th>
							<td>
								<c:forEach items="${fileList}" var="fileList" varStatus="status">
								<div class="file_add_img">
									<img src="${fileList.attchFilePath}" style="width:140px;height:94px;"/>
								</div>
								</c:forEach>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div class="btnArea">
			<button type="button" id="listBtn" class="left">목록</button>
			<button type="button" id="cancelBtn" class="right" >예약취소</button>
		</div>
	</div>
	<!--// sub -->

</body>