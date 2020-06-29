<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<head>
	<script type="text/javascript">
	<!--

	function init(){
		var seq = $("#boardCateSeq").val();
		if(seq==""){
			$("#col").addClass("on");
		}
		else{
			$("#col"+seq).addClass("on");
		}
	}

	function serviceCate(code){
		$("#page").val(1);
		$("#boardCateSeq").val(code);
		document.adviceForm.action = "bbt00002.do?pageCd=${boardMstCd}";
		document.adviceForm.submit();
	}

	function serviceCate2(){
		$("#page").val(1);
		$("#boardCateSeq").val($("select[name=boardCateList]").val());
		document.adviceForm.action = "bbt00002.do?pageCd=${boardMstCd}";
		document.adviceForm.submit();
	}

	function doPage(pageNum){
		document.adviceForm.page.value = pageNum;
   		document.adviceForm.action = "bbt00002.do?pageCd=${boardMstCd}";
      		document.adviceForm.submit();
	}

	function goModify(seq){
		document.modForm.boardSeq.value = seq;
		document.modForm.page.value = document.adviceForm.page.value;
   		document.modForm.action = "bbt00002R.do?pageCd=${boardMstCd}";
      		document.modForm.submit();
	}

	function goView(seq){
		document.modForm.boardSeq.value = seq;
		document.modForm.page.value = document.adviceForm.page.value;
   		document.modForm.action = "bbt00002V.do?pageCd=${boardMstCd}";
      		document.modForm.submit();
	}

	//-->
	</script>
</head>
<body>

<div id="container" class="qna">
	<div id="contents" class="inner">

		<h3>${boardMstNm}</h3>

		<script type="text/javascript">
		if($('#contents h3').text()=='고객상담'){
			$('#contents h3').html('<img src="/common/images/tit/h3_tit5_2.png" alt="고객상담">');
		}
		if($('#contents h3').text()=='서비스문의'){
			$('#contents h3').html('<img src="/common/images/tit/h3_tit5_3.png" alt="서비스문의">');
		}
		</script>

		<div class="bostyle01">
			<ul class="tabmenu">
				<li class="on">
					<a href="bbt00002.do?pageCd=${boardMstCd}">
						${boardMstNm}
					</a>
				</li>
			</ul>
			<c:choose>
				<c:when test="${boardMstCd eq 'BBM00003'}">
					<div class="qna_title">
						<div class="text_box">
							<strong>프로바이오틱스 듀오락 제품에 대한 궁금증을 풀어드립니다!</strong>
							<span>
								프로바이오틱스 듀오락 제품에 대해 궁금한점이 있으신가요?<br />
								문의하시려면 로그인이 필요하며, 문의글은 관리자에게만 공개됩니다.
							</span>
						</div>
						<ul>
							<li>
								<!-- 로그인 체크 -->
								<a class="btn07" href="bbt00002R.do?pageCd=${boardMstCd}" >상담하기</a>
							</li>
							<li>
								<!-- 로그인 체크 -->
								<a class="btn07" href="/ISDS/user/myadvice.do">나의 문의내역</a>
							</li>
						</ul>
					</div>
				</c:when>
				<c:when test="${boardMstCd eq 'BBM00007'}">
					<div class="qna_title">
						<div class="text_box qanda">
							<strong>듀오락 상담원이 빠르고 친절하게 답변해 드립니다.</strong>
							<span>
								듀오락 쇼핑몰 이용에 불편하신 점이나, 궁금하신 점이 있으신가요?<br />
								상담원이 친절하고 빠르게 답변드립니다. 무엇이든 물어보세요.
							</span>
						</div>
						<ul>
							<li>
								<!-- 로그인 체크 -->
								<a class="btn07" href="bbt00002R.do?pageCd=${boardMstCd}" >상담하기</a>
							</li>
							<li>
								<!-- 로그인 체크 -->
								<a class="btn07" href="/ISDS/user/myadvice.do">나의 문의내역</a>
							</li>
						</ul>
					</div>
				</c:when>
				<c:otherwise>
					<div  style="float:right;margin:0 0 10px 3px;"><a class="btn07" href="/ISDS/user/myadvice.do">나의 문의내역</a></div>
					<div  style="float:right;margin:0 3px 10px 0;"><a class="btn07" href="bbt00002R.do?pageCd=${boardMstCd}" >상담하기</a></div>
				</c:otherwise>
			</c:choose>
			<c:if test="${fn:length(cateList) > 1 && fn:length(cateList) < 6}">
				<ul class="title">
					<li id="col"><a class="col1" href="javascript:;" onclick="serviceCate('');"><span>전체</span><em>(${allCnt})</em></a></li>
					<c:forEach items="${cateList}" var="cateList" varStatus="status">
						<li id="col${cateList.boardCateSeq}">
							<a class="col${status.count+1}" href="javascript:;" onclick="serviceCate('${cateList.boardCateSeq}');">
								<span><c:out value="${cateList.boardCateNm}"/></span><em>(${cateList.boardCnt})</em>
							</a>
						</li>
					</c:forEach>
				</ul>
			</c:if>
			<c:if test="${fn:length(cateList) > 6}">
				<div class="qna_title2">
				<strong class="tit">분류별 보기</strong>

				<span class="request_cate">
					<select name="boardCateList" onchange="serviceCate2();">
						<option value="">전체 (${allCnt})</option>
						<c:forEach items="${cateList}" var="cateList" varStatus="status">
							<option value="${cateList.boardCateSeq}" <c:if test="${cateList.boardCateSeq eq boardCateSeq}">selected</c:if>>${cateList.boardCateNm} (${cateList.boardCnt})</option>
						</c:forEach>
					</select>
				</span>
			</div>
			</c:if>

			<form id="modForm" name="modForm" method="post">
				<input type="hidden" name="boardSeq" id="boardSeq" />
				<input type="hidden" name="page" value="${param.page}"/>
			</form>
				<c:choose>
					<c:when test="${fn:length(cateList) > 1}">
								<div class="table_wrap tbl_res2">
							</c:when>
							<c:otherwise>
								<div class="table_wrap tbl_res1">
					</c:otherwise>
				</c:choose>
				<table cellpadding="0" cellspacing="0">
					<colgroup>
						<c:choose>
		  					<c:when test="${fn:length(cateList) > 1}">
		  						<col width="80">
								<col width="100">
								<col width="450">
								<col width="110">
								<col width="130">
								<col width="130">
		  					</c:when>
		  					<c:otherwise>
		  						<col width="80">
								<col width="550">
								<col width="110">
								<col width="130">
								<col width="130">
		  					</c:otherwise>
		  				</c:choose>
					</colgroup>
					<thead>
						<tr>
							<c:choose>
		  						<c:when test="${fn:length(cateList) > 1}">
		  							<th>번호</th>
									<th>분류</th>
									<th>제목</th>
									<th>답변여부</th>
									<th>작성자</th>
									<th>작성일</th>
		  						</c:when>
		  						<c:otherwise>
		  							<th>번호</th>
									<th>제목</th>
									<th>답변여부</th>
									<th>작성자</th>
									<th>작성일</th>
		  						</c:otherwise>
		  					</c:choose>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${mList}" var="mList" varStatus="status">
							<c:choose>
									<c:when test="${mList.boardFirstYn eq 'Y'}">
									<tr>
										<td><img src="${rootUri}common/img/icon/bo_notice.png" alt="공지"></td>
										<td class='none_class_not_view' style='cursor:default'><span><c:out value="${mList.boardTitle}"/></span></td>
										<td></td>
		                               	<td>${mList.regId}</td>
		                               	<td>${mList.regDt}</td>
		                           	</tr>
									</c:when>
							<c:otherwise>
							<tr>
								<td><c:out value="${mList.boardSeq}"/></td>
								<c:if test="${fn:length(cateList) > 1}">
									<td><c:out value="${mList.boardCateNm}"/></td>
								</c:if>
								<td class="none_class_not_view" style='cursor:default'>
									<span>
										<c:choose>
											<c:when test="${mList.openYn eq 'N'}">
										<!-- 비공개 -->
												<c:if test="${mbrId eq mList.regId}">
						            				<a href="javascript:;" onclick="goModify('${mList.boardSeq}');">
							            				듀오락 제품에 대한 문의입니다.
							            				<img src="${rootUri}common/img/icon/lock_icon.png">
							            			</a>
						            			</c:if>
						            			<c:if test="${mbrId != mList.regId}">
						            				<a href="javascript:alert('비공개 문의입니다.');">
							            				듀오락 제품에 대한 문의입니다.
							            				<img src="${rootUri}common/img/icon/lock_icon.png">
							            			</a>
						            			</c:if>
						            			<c:if test="${mList.boardState eq '대기'}">
													<td><em>답변대기</em></td>
												</c:if>
												<c:if test="${mList.boardState eq '완료'}">
													<td class="end"><em>답변완료</em></td>
												</c:if>
											</c:when>
											<c:when test="${mList.openYn eq 'Y'}">
					            		<!-- 공개 : 로그인/비로그인 & 로그인아이디/등록아이디 -->
												<c:if test="${iConstant.isLogIn()}">
<%-- 					            				<c:if test="${mbrId eq mList.regId}"> --%>
<%-- 													<a href="javascript:;" onclick="goModify('${mList.boardSeq}');"> --%>
<!-- 						            					듀오락 제품에 대한 문의입니다. -->
<!-- 													</a> -->
<%-- 												</c:if> --%>
<%-- 												<c:if test="${mbrId != mList.regId}"> --%>
<%-- 													<a href="javascript:;" onclick="goModify('${mList.boardSeq}');"> --%>
<!-- 						            					듀오락 제품에 대한 문의입니다. -->
<!-- 													</a> -->
<%-- 												</c:if> --%>
						            				<a href="javascript:;" onclick="goModify('${mList.boardSeq}');">
							            				듀오락 제품에 대한 문의입니다.
							            			</a>
												</c:if>
												<c:if test="${!iConstant.isLogIn()}">
													<a href="javascript:alert('로그인 후 열람 할 수 있습니다.');">
							            				듀오락 제품에 대한 문의입니다.
													</a>
												</c:if>
												<c:if test="${mList.boardState eq '대기'}">
														<td><em>답변대기</em></td>
													</c:if>
													<c:if test="${mList.boardState eq '완료'}">
														<td class="end"><em>답변완료</em></td>
												</c:if>
											</c:when>
											<c:otherwise>
												<a href="javascript:;" onclick="goModify('${mList.boardSeq}');">
													${mList.boardTitle}
												</a>
												<td></td>
											</c:otherwise>
										</c:choose>

									</span>
								</td>

								<td><c:out value="${mList.regId}"/></td>
								<td><c:out value="${mList.regDt}"/></td>
							</tr>
							</c:otherwise>
							</c:choose>
						</c:forEach>
						<c:if test="${empty mList}">
							<tr>
				                <td colspan="5">내용이 없습니다.</td>
				            </tr>
			            </c:if>
					</tbody>
				</table>
				<form id="adviceForm" name="adviceForm" method="post">
				<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
				<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${boardCateSeq}" />
				<input type="hidden" id="page" name="page" value="${param.page}"/>
				<p class="search_bar">
					<select title="고객상담 검색" name="skey">
						<option value="1" >제목</option>
						<option value="2" >내용</option>
						<option value="3" >제목+내용</option>
					</select>
					<input type="text"  name="sval" maxlength="50" value="${param.sval}" />
					<input type="image" src="${rootUri}common/img/icon/btn_search.png" class="faqInputBtn" alt="FAQ검색"/>
				</p>
				</form>

				<c:out value="${pageTag}" escapeXml="false" />

			</div>
		</div>
	</div>
</div>

</body>