<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
	<script type="text/javascript">
	<!--

		function doPage(pageNum){
			document.f.page.value = pageNum;
			document.f.action = "point.do";
	   		document.f.submit();
		}

	//-->
	</script>
</head>
<body>

<!--=============== #CONTAINER ===============-->
<div id="container" class="user">
  	<!--=============== #CONNTENTS ===============-->
	<div id="contents" class="inner">
		<h3><img src="/common/images/tit/h3_tit7_4.png" alt="나의 멤버십 혜택/포인트/구분"></h3>

		<ul class="mypage_menu">
					<li class="col1 "><a href="/ISDS/user/mypage.do" ><span>아이콘</span>마이페이지</a></li>
					<li class="col2 "><a href="/ISDS/user/order.do" ><span>아이콘</span>주문/배송 조회</a></li>
					<li class="col3"><a href="/ISDS/user/wishList.do" ><span>아이콘</span>위시리스트</a></li>
					<li class="col4  on"><a href="/ISDS/user/cash.do" ><span>아이콘</span>멤버십 혜택/포인트/쿠폰</a></li>
					<li class="col5 "><a href="/ISDS/user/product.do" ><span>아이콘</span>나의 문의내역</a></li>
					<li class="col6"><a href="/ISDS/user/review.do" ><span>아이콘</span>나의 제품후기</a></li>
					<li class="col7"><a href="/ISDS/user/setting.do" ><span>아이콘</span>회원정보</a></li>
					<li class="col8"><a href="/ISDS/order/cart.do" ><span>아이콘</span>장바구니</a></li>
		</ul>

		<div class="my_info" >
			<div class="text_box">
				<span style="font-size:14px;">
					<em class="text_name">${userMap.mbrNm}</em>님 환영합니다!<br />듀오락 패밀리 멤버십 등급은 <br/><em>${userMap.mbrLevNm}</em>입니다.
					<br/><br/>다음달 <em>${userMap.nextLevNm}</em>가 되기 위해 필요한<br/>구매 금액은 <em><fmt:formatNumber value="${userMap.nextMbrLevAmot}" pattern="#,###"/></em>원 입니다.</span>

			</div>

			<ul class="info_box">
				<li class="col1">
					<c:if test="${userMap.mbrLevCd eq 'MLP00001'}">
						<img src="${rootUri}common/img/normal.png" >
					</c:if>
					<c:if test="${userMap.mbrLevCd eq 'MLP00002'}">
						<img src="${rootUri}common/img/bronze.png">
					</c:if>
					<c:if test="${userMap.mbrLevCd eq 'MLP00003'}">
						<img src="${rootUri}common/img/silver.png">
					</c:if>
					<c:if test="${userMap.mbrLevCd eq 'MLP00004'}">
						<img src="${rootUri}common/img/gold.png">
					</c:if>
					<c:if test="${userMap.mbrLevCd eq 'MLP00005'}">
						<img src="${rootUri}common/img/vip.png">
					</c:if>
					<c:if test="${userMap.mbrLevCd eq 'MLP00006'}">
						<img src="${rootUri}common/img/vvip.png">
					</c:if>
					<div class="text_box_btn">
						<a href="/ISDS/user/cash.do">
							<span>나의 멤버십 혜택 자세히 보기</span>
						</a>
					</div>
				</li>
				<li class="col2">
					<div class="col_tit">포인트/쿠폰</div>
					<span>
						<a href="/ISDS/user/point.do">
							<span>보유 포인트</span>
							<span><em><fmt:formatNumber value="${userMap.prodPtOutScore}" pattern="#,###"/></em>점</span>
						</a>
					</span>
				</li>
				<li class="col3">
				<div class="col_tit"><br/> </div>
					<span>
						<a href="/ISDS/user/coupon.do">
							<span>보유 쿠폰</span>
							<span><em><fmt:formatNumber value="${userMap.copnCount}" pattern="#,###"/></em>장</span>
						</a>
					</span>
				</li>
			</ul>
		</div>

		<form name="f" method="post" >

		<input type="hidden" id="page" name="page" />
		<div class="cash bostyle01">
			<ul class="tabmenu">
				<li><a href="/ISDS/user/cash.do?pageSubCd=MYP00104&depths=3">나의 멤버십 혜택</a></li>
				<li class="on"><a href="/ISDS/user/point.do">포인트 내역</a></li>
				<li class="last"><a href="/ISDS/user/coupon.do">쿠폰 내역</a></li>
			</ul>

			<div class="top_info">
				<ul>
					<li>포인트는 적립일로부터 1년간 유효하며, 1년이 경과된 적립금은 순차적으로 소멸됩니다.
					<li>포인트는 현금으로 환원이 불가능하며, 포인트 상품 구매시 사용 가능합니다,</li>
					<li>포인트 상품 구매는 제품 구매시에 함께 구매가능하며, 포인트 상품만 별도로 구매하실 수 없습니다.</li>
					<li>포인트는 타인에게 양도할 수 없으며, 운영 정책에 따라 변경 될 수 있습니다.</li>
				</ul>
			</div>

			<div class="table_wrap tbl_res3">
				<table cellpadding="0" cellspacing="0" class="table_first">
					<colgroup>
						<col width="">
						<col width="200">
						<col width="200">
					</colgroup>

					<thead>
						<tr>
							<th>적립내역</th>
							<th>포인트</th>
							<th>적립일</th>
						</tr>
					</thead>
					<tbody>
                    	<c:forEach items="${pointList}" var="pointList" varStatus="status">
							<tr>
								<td>${pointList.ptNm}</td>
								<c:if test="${pointList.aState == '적립'}">
								<td class="plus">
								</c:if>
								<c:if test="${pointList.aState == '차감'}">
								<td class="minus">
								</c:if>
									<span>${pointList.mbrPtScore}</span>
								</td>
								<td>${fn:substring(pointList.mbrPtAccDt,0,10)}</td>
							</tr>
                    	</c:forEach>
					</tbody>
				</table>
				<ul class="paging">
					<c:out value="${pageTag}" escapeXml="false" />
				</ul>
			</div>
		</div>
		</form>
	</div>
	<!--=============== #CONNTENTS ===============-->
</div>
<!--=============== #CONTAINER ===============-->


</body>