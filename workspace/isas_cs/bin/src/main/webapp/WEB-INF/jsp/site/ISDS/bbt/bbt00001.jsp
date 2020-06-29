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
	<div class="sub">
		<form id="noticeForm" name="noticeForm" method="post">
			<input type="hidden" id="boardSeq" name="boardSeq" />
			<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${boardCateSeq}" />
			<input type="hidden" id="page" name="page" value="${param.page}"/>

		<div class="box_guide">
			<h2 class="tit">공지사항</h2>
			<p class="desc">이누스 공지사항을 알려드립니다.</p>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">고객의 소리</a></li>
					<li class="last"><a href="#">공지사항</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<div class="sch_bx">
			<fieldset>
				<legend>공지사항내 검색</legend>
				<div class="tblType01 in_sch_bx">
					<table>
						<caption>공지사항내 검색</caption>
						<tbody>
							<tr>
								<th scope="row"><label for="schTxt">검색</label></th>
								<td>
									<div>
										<select name="skey" id="skey" class="">
											<option value="1" <c:if test="${skey eq '1'}">selected</c:if>>제목</option>
											<option value="2" <c:if test="${skey eq '2'}">selected</c:if>>내용</option>
											<option value="3" <c:if test="${skey eq '3'}">selected</c:if>>제목+내용</option>
										</select>
										<input type="text" name="sval" id="sval" value="${param.sval}" />
									</div>
									<a href="javascript:;" class="btn02Type" onclick="noticeCate('');">검색</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</fieldset>
		</div>
		<!--// sch_bx -->
		<div class="tblType02">
			<div class="box_tit">
				<p class="tit">전체<span>&nbsp;${totalCnt}</span>건</p>
			</div>
			<table>
				<caption>공지사항 목록</caption>
				<colgroup>
					<col width="10%">
					<col width="70%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="num1">번호</th>
						<th scope="col" class="tit">제목</th>
						<th scope="col" class="enD">등록일</th>
						<th scope="col" class="hit">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${noticeList}" var="noticeList" varStatus="status">
						<c:choose>
							<c:when test="${noticeList.boardFirstYn eq 'Y'}">
							<tr style="cursor:pointer;" onclick="noticeView('${noticeList.boardSeq}');">
								<td><img src="/common/img/icon/bo_notice.png" alt="공지"></td>
                                <td class="tit"><a href="javascript:;" ><c:out value="${noticeList.boardTitle}"/></a></td>
								<td class="enD"><c:out value="${noticeList.regDt}"/></td>
								<td>${noticeList.boardHit}</td>
							</tr>
							</c:when>
							<c:otherwise>
							<tr style="cursor:pointer;" onclick="noticeView('${noticeList.boardSeq}');">
								<td class="num1"><c:out value="${noticeList.num}" /></td>
								<td class="tit"><a href="javascript:;" ><c:out value="${noticeList.boardTitle}"/></a></td>
								<td class="enD"><c:out value="${noticeList.regDt}"/></td>
								<td class="hit">${noticeList.boardHit}</td>
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
		</div>
		</form>
		<!--// 공지사항(목록) -->
		<c:out value="${pageTag}" escapeXml="false" />
	</div>
	<!--// sub -->

</body>