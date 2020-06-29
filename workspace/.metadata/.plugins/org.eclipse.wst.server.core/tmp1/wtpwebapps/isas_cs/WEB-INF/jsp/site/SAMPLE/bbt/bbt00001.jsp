<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--

		function init(){
			var seq = $("#boardCateSeq").val();
			if(seq==""){
				$("#col1").addClass("on");
			}
			else{
				$("#col"+seq).addClass("on");
			}
		}

		function noticeCate(code){
			$("#page").val(1);
			$("#boardCateSeq").val(code);
			document.noticeForm.action = "bbt00001.do?pageCd=${boardMstCd}";
			document.noticeForm.submit();
		}

		function noticeView(seq){
			$("#boardSeq").val(seq);
			document.noticeForm.action = "bbt00001V.do?pageCd=${boardMstCd}";
		   	document.noticeForm.submit();
		}

		function doPage(pageNum){
			document.noticeForm.page.value = pageNum;
	    	document.noticeForm.action = "bbt00001.do?pageCd=${boardMstCd}";
	       	document.noticeForm.submit();
		}

	//-->
	</script>
</head>
<body>

	<div id="container" class="notice">
		<div id="contents" class="inner">
			<h3><img src="/common/images/tit/h3_tit5_1.png" alt="공지사항"></h3>
			<form id="noticeForm" name="noticeForm" method="post">
			<input type="hidden" id="boardSeq" name="boardSeq" />
			<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${boardCateSeq}" />
			<input type="hidden" id="page" name="page" value="${param.page}"/>
			<div class="bostyle01">
				<ul class="title">
					<li id="col1"><a class="col1" href="javascript:;" onclick="noticeCate('');"><span>전체</span><em>(${allCnt})</em></a></li>
					<c:forEach items="${cateList}" var="cateList" varStatus="status">
						<li id="col${cateList.boardCateSeq}">
							<a class="col${status.count+1}" href="javascript:;" onclick="noticeCate('${cateList.boardCateSeq}');">
								<span><c:out value="${cateList.boardCateNm}"/></span><em>(${cateList.boardCnt})</em>
							</a>
						</li>
					</c:forEach>
				</ul>
				<div class="table_wrap tbl_res1">
					<table cellpadding="0" cellspacing="0">
						<colgroup>
							<col style="width:8%">
							<col style="width:13%">
							<col style="width:64%">
							<col style="width:15%">
						</colgroup>
						<thead>
							<tr>
								<th>번호</th>
								<th>분류</th>
								<th>제목</th>
								<th>작성일</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${noticeList}" var="noticeList" varStatus="status">
								<c:choose>
									<c:when test="${noticeList.boardFirstYn eq 'Y'}">
									<tr >
										<td><img src="/common/img/icon/bo_notice.png" alt="공지"></td>
	                                    <td><c:out value="${noticeList.boardCateNm}"/></td>
										<td class="cont"><a href="javascript:;" onclick="noticeView('${noticeList.boardSeq}');"><c:out value="${noticeList.boardTitle}"/></a></td>
										<td><c:out value="${noticeList.regDt}"/></td>
									</tr>
									</c:when>
									<c:otherwise>
									<tr>
	                                    <td>
	                                    	<c:out value="${noticeList.boardSeq}" />
	                                    </td>
	                                    <td><c:out value="${noticeList.boardCateNm}"/></td>
	                                    <td class="cont"><a href="javascript:;" onclick="noticeView('${noticeList.boardSeq}');"><c:out value="${noticeList.boardTitle}"/></a></td>
	                                    <td><c:out value="${noticeList.regDt}"/></td>
	                                </tr>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							<c:if test="${empty noticeList}">
								<tr>
					                <td colspan="4">내용이 없습니다.</td>
					            </tr>
				            </c:if>
						</tbody>
					</table>

					<c:out value="${pageTag}" escapeXml="false" />

				</div>
			</div>
			</form>
		</div>
	</div>

</body>