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
		<div class="box_guide">
			<h2 class="tit">칭찬합시다</h2>
			<div class="txt_bx">
				<c:if test="${!isLogIn}">
					<p class="mark">글 작성은 로그인 후 가능합니다.</p>
				</c:if>
				<p class="desc">고객 여러분의 칭찬과 격려에 감사 드립니다.<br>따스한 격려 한마디를 본보기로 삼아 더욱 친절한 서비스를 위해 노력하겠습니다. </p>
				<div class="btnArea">
					<c:if test="${isLogIn}">
						<button type="button" class="left" id="myList" >나의 글보기</button>
						<button type="button" class="right" id="regView">글쓰기</button>
					</c:if>
				</div>
			</div>
			<!--// txt_bx -->
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">고객의 소리</a></li>
					<li class="last"><a href="#">칭찬합시다</a></li>
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
											<option value="1" <c:if test="${skey eq '1'}">selected</c:if> >제목</option>
											<option value="2" <c:if test="${skey eq '2'}">selected</c:if> >내용</option>
											<option value="3" <c:if test="${skey eq '3'}">selected</c:if>>제목+내용</option>
										</select>
										<input type="text" name="sval" id="sval" value="${param.sval}" onkeydown="keydown();"/>
									</div>
									<a href="javascript:;" class="btn02Type" onclick="noticeCate();">검색</a>
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
					<col width="60%">
					<col width="10%">
					<col width="10%">
					<col width="10%">
				</colgroup>
				<thead>
					<tr>
						<th scope="col" class="num1">번호</th>
						<th scope="col" class="tit">제목</th>
						<th scope="col" class="author">작성자</th>
						<th scope="col" class="enD">등록일</th>
						<th scope="col" class="hit">조회수</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${noticeList}" var="noticeList" varStatus="status">
					<tr style="cursor:pointer;" onclick="noticeView('${noticeList.boardSeq}');">
						<td class="num1"><c:out value="${noticeList.num}" /></td>
						<td class="tit"><c:out value="${noticeList.boardTitle}"/></td>
						<td class="author"><c:out value="${noticeList.regName}"/></td>
						<td class="enD"><c:out value="${noticeList.regDt}"/></td>
						<td class="hit">${noticeList.boardHit}</td>
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
		</form>
		<!--// 공지사항(목록) -->
		<c:out value="${pageTag}" escapeXml="false" />
	</div>
</body>