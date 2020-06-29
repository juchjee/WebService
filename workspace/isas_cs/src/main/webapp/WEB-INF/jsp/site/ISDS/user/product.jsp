<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--

		function decodeTag(str){
			return str && str.replace(/&quot;/g,"\"").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&nbsp;/g," ").replace(/&amp;/g,"&");
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
				<li class="on"><a href="product.do">나의 제품문의</a></li>
				<li><a href="myadvice.do">나의 상담/문의 내역</a></li>
			</ul>

			<div class="top_info">
				<ul>
					<li>제품과 관련하여 남겨주신 문의사항을 편리하게 보실 수 있습니다.</li>
					<li>제품이미지나 제품명을 클릭하시면 제품 상세페이지로 이동하실 수 있습니다.</li>
				</ul>
			</div>

			<div class="product_list">
				<span class="title_text02"><em>${qnaPageInfo.totalCount}</em>건의 제품문의가 있습니다.</span>
				<ul class="request_accordion">
				<c:forEach items="${prodQnaList}" var="prodQnaList" varStatus="status">
					<li>
						<span class="ques">
							<span class="img_box">
								<a href="/ISDS/store/store_view.do?prodCd=${prodQnaList.prodCd}">
									<img src="${prodQnaList.basicImg}" alt="${prodQnaList.prodNm}" width="100" height="100" />
								</a>
							</span>
							<span class="text_box">
								<strong class="icon_q"><em>[<c:out value="${prodQnaList.prodNm}"/>]</em><c:out value="${prodQnaList.boardTitle}"/></strong>
								<span>
									<span id="BoardCont${status.count}">
						            	<textarea name="BoardCont${status.count}_text" id="BoardCont${status.count}_text" style="display:none;" ><c:if test="${not empty prodQnaList.boardCont}">${prodQnaList.boardCont}</c:if></textarea>
					            		<script type="text/javascript">
											$("#BoardCont${status.count}").html(decodeTag($("#BoardCont${status.count}_text").html()));
						            	</script>
									</span>
								</span>
							</span>
							<span class="date"><c:out value="${prodQnaList.regDt}"/></span>
							<c:if test="${prodQnaList.boardState eq '대기'}">
								<em>답변대기</em>
							</c:if>
							<c:if test="${prodQnaList.boardState eq '완료'}">
								<em class="end">답변완료</em>
							</c:if>
						</span>
						<div class="reply">
							<span class="text_box">
								<span class="icon_a"><img src="${rootUri}common/img/icon/end_duolac.png" alt="듀오락" /></span>
								<c:if test="${!empty prodQnaList.boardReply}">
									<p class="text_box">
										<div id="boardReply${status.count}">
											<textarea name="boardReply${status.count}_text" id="boardReply${status.count}_text" style="display:none;" ><c:if test="${not empty prodQnaList.boardReply}">${prodQnaList.boardReply}</c:if></textarea>
											<script type="text/javascript">
											$("#boardReply${status.count}").html(decodeTag($("#boardReply${status.count}_text").html()));
						            		</script>
										</div>
									</p>
								</c:if>
								<c:if test="${empty prodQnaList.boardReply}">
									<p class="text_box">답변대기중입니다.</p>
								</c:if>
							</span>
						</div>
					</li>
				</c:forEach>
				<c:if test="${empty prodQnaList}">
					<div class="nocomment">문의내역이 없습니다</div>
				</c:if>
				</ul>
			</div>

			<ul class="paging">

			</ul>

		</div>
	</div>
	<!--=============== #CONNTENTS ===============-->
</div>
<!--=============== #CONTAINER ===============-->

</body>