<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--

		function doPage(pageNum){
			document.adviceForm.page.value = pageNum;
			document.adviceForm.action = "myadvice.do";
	   		document.adviceForm.submit();
		}

		function goModify(seq,code){
			document.modForm.boardSeq.value = seq;
			document.modForm.action = "myadvice_write.do?pageCd="+code;
	   		document.modForm.submit();
		}

		function goRegist(){
			if($("select[name=boardSel]").val()==""){
				alert("상담 및 문의메뉴를 선택해주세요.");
				return false;
			}
			document.adviceForm.action = "myadvice_write.do?pageCd="+$("select[name=boardSel]").val();
	   		document.adviceForm.submit();
		}

		function goSelect(){
			$("#boardMstCd").val($("select[name=boardSel]").val());
			document.adviceForm.action = "myadvice.do";
	   		document.adviceForm.submit();
		}

	//-->
	</script>
</head>
<body>

<!--=============== #CONTAINER ===============-->
<div id="container" class="user">
  	<!--=============== #CONNTENTS ===============-->
	<div id="contents" class="inner">
		<h3><img src="/common/images/tit/h3_tit7_5.png" alt="나의 문의내역"></h3>

		<ul class="mypage_menu">
					<li class="col1 "><a href="/ISDS/user/mypage.do" ><span>아이콘</span>마이페이지</a></li>
					<li class="col2 "><a href="/ISDS/user/order.do" ><span>아이콘</span>주문/배송 조회</a></li>
					<li class="col3"><a href="/ISDS/user/wishList.do" ><span>아이콘</span>위시리스트</a></li>
					<li class="col4 "><a href="/ISDS/user/cash.do" ><span>아이콘</span>멤버십 혜택/포인트/쿠폰</a></li>
					<li class="col5 on"><a href="/ISDS/user/product.do" ><span>아이콘</span>나의 문의내역</a></li>
					<li class="col6"><a href="/ISDS/user/review.do" ><span>아이콘</span>나의 제품후기</a></li>
					<li class="col7"><a href="/ISDS/user/setting.do" ><span>아이콘</span>회원정보</a></li>
					<li class="col8"><a href="/ISDS/order/cart.do" ><span>아이콘</span>장바구니</a></li>
		</ul>

		<div class="question bostyle01">
			<ul class="tabmenu">
				<li><a href="product.do">나의 제품문의</a></li>
				<li class="on"><a href="myadvice.do">나의 상담/문의 내역</a></li>
			</ul>

			<div class="top_info">
				<ul>
					<li>남겨주신 상담 및 문의내용을 편리하게 보실 수 있습니다.</li>
					<li>상담신청은 <span>24시간 신청가능</span>하며 접수내용은 듀오락 상담원이 직접 답변해드립니다.</li>
					<li>고객상담 답변가능시간 : 평일 9:00 ~ 18:00 /  토요일 9:00 ~ 13:00 (일/공휴일 제외)</li>
				</ul>
			</div>

			<span class="title_text02"><em>${pageInfo.totalCount}</em>건의 고객상담이 있습니다.</span>

			<form id="modForm" name="modForm" method="post">
				<input type="hidden" name="boardSeq" id="boardSeq" />
			</form>

			<div class="table_wrap tbl_res2">
				<table cellpadding="0" cellspacing="0">
					<colgroup>
						<col width="80">
						<col width="200">
						<col width="350">
						<col width="110">
						<col width="130">
						<col width="130">
					</colgroup>
					<thead>
						<tr>
							<th>번호</th>
							<th>메뉴</th>
							<th>제목</th>
							<th>답변여부</th>
							<th>작성자</th>
							<th>작성일</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${bbtMyList}" var="bbtMyList" varStatus="status">
							<tr>
							    <td><c:out value="${pageInfo.totalCount -((pageInfo.currentPageNum-1)*pageInfo.pageSize+status.index)}"/></td>
								<td class="cont">
									<c:choose>
					  					<c:when test="${bbtMyList.cateCnt > 1}">
					  						${bbtMyList.boardMstNm}&nbsp;&nbsp;&gt;&nbsp;${bbtMyList.boardCateNm}&nbsp;
					  					</c:when>
					  					<c:otherwise>
											${bbtMyList.boardMstNm}
					  					</c:otherwise>
					  				</c:choose>
								</td>
								<td class="cont">
									<a href="javascript:;" onclick="goModify('${bbtMyList.boardSeq}','${bbtMyList.boardMstCd}');"><c:out value="${bbtMyList.boardTitle}"/></a>
								</td>
								<c:if test="${bbtMyList.boardState eq '대기'}">
									<td><em>답변대기</em></td>
								</c:if>
								<c:if test="${bbtMyList.boardState eq '완료'}">
									<td class="end"><em>답변완료</em></td>
								</c:if>
								<td><c:out value="${bbtMyList.regId}"/></td>
								<td><c:out value="${bbtMyList.regDt}"/></td>
							</tr>
                        </c:forEach>
                        <c:if test="${empty bbtMyList}">
							<tr>
				                <td colspan="5" scope="row" class="td_num bgnone bm3 nocomment_t">작성한 글이 없습니다.</td>
				            </tr>
			            </c:if>
					</tbody>
				</table>

				<form id="adviceForm" name="adviceForm" method="post">
				<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
				<input type="hidden" id="page" name="page" />
				<p class="search_bar">
					<select title="고객상담 검색" name="skey">
						<option value="1" >제목</option>
						<option value="2" >내용</option>
						<option value="3" >제목+내용</option>
					</select>
					<input type="text"  name="sval" />
					<input type="image" src="${rootUri}common/img/icon/btn_search.png" class="faqInputBtn" alt="FAQ검색"/>
				</p>
				</form>

				<ul class="paging">
					<c:out value="${pageTag}" escapeXml="false" />
				</ul>
				<div class="request_select">
					<!-- <select name="boardSel" id="boardSel" onchange="goSelect();"> -->
					<select name="boardSel" id="boardSel">
						<option value="">메뉴선택</option>
						<c:forEach items="${bbtNmList}" var="bbtNmList" >
							<option value="${bbtNmList.boardMstCd}" <c:if test="${bbtNmList.boardMstCd eq boardMstCd}">selected</c:if>>${bbtNmList.boardMstNm}</option>
						</c:forEach>
					</select>
				</div>

				<a href="javascript:void(0)" onclick="goRegist();" class="btn10">문의하기</a>
			</div>
		</div>
	</div>
	<!--=============== #CONNTENTS ===============-->
</div>
<!--=============== #CONTAINER ===============-->

</body>