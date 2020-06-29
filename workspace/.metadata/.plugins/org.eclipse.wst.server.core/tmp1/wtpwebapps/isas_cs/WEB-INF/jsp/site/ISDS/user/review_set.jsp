<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--
		function init(){

			$(".jqxRating").jqxRating({
			    disabled:true
			});

			<c:forEach items="${prodAfterList}" var="prodAfterList"  varStatus="nStatus">
				$(".jqxRating").eq('${nStatus.index}').jqxRating('val','${prodAfterList.prodGrade}');
			</c:forEach>

		}

		//태그 문자열을 디코딩 한다
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
		<h3><img src="/common/images/tit/h3_tit7_6.png" alt="나의 제품후기"></h3>

		<ul class="mypage_menu">
					<li class="col1 "><a href="/ISDS/user/mypage.do" ><span>아이콘</span>마이페이지</a></li>
					<li class="col2 "><a href="/ISDS/user/order.do" ><span>아이콘</span>주문/배송 조회</a></li>
					<li class="col3"><a href="/ISDS/user/wishList.do" ><span>아이콘</span>위시리스트</a></li>
					<li class="col4  "><a href="/ISDS/user/cash.do" ><span>아이콘</span>멤버십 혜택/포인트/쿠폰</a></li>
					<li class="col5 "><a href="/ISDS/user/product.do" ><span>아이콘</span>나의 문의내역</a></li>
					<li class="col6 on"><a href="/ISDS/user/review.do" ><span>아이콘</span>나의 제품후기</a></li>
					<li class="col7"><a href="/ISDS/user/setting.do" ><span>아이콘</span>회원정보</a></li>
					<li class="col8"><a href="/ISDS/order/cart.do" ><span>아이콘</span>장바구니</a></li>
		</ul>


		<div class="review">
			<ul class="tabmenu">
				<li><a href="review.do">나의 제품후기 쓰기</a></li>
				<li class="on"><a href="review_set.do">나의 제품후기 관리</a></li>
			</ul>

			<div class="top_info">
				<ul>
					<li>후기 작성시 <span>포인트(텍스트 200점, 포토 500점)</span>가 적립됩니다.</li>
					<li>취소/반품/교환의 경우 작성하신 후기 및 적립금은 자동삭제 됩니다.</li>
					<li>제품후기는 배송완료 후 익일 작성하실 수 있습니다.</li>
				</ul>
			</div>

			<div class="review_list review_set">
				<span class="title_text02"><em>${totalCnt}</em>건의 등록 제품후기가 있습니다.</span>
					<ul>
						<c:forEach items="${prodAfterList}" var="prodAfterList" varStatus="status">
						<li>
							<div>
								<a class="img_box" href="/ISDS/store/store_view.do?prodCd=${prodAfterList.prodCd}">
									<img src="${prodAfterList.basicImg}" alt="${prodAfterList.prodNm}" />
								</a>
								<span class="title"><c:out value="${prodAfterList.prodNm}"/></span>
								<!-- 구매일 추후 추가 -->
								<span class="date">구매일 <em><c:out value="${prodAfterList.orderDt}"/></em></span>
								<span class="date">작성일 <em><c:out value="${prodAfterList.regDt}"/></em></span>
								<span style="margin-left:45px;" class="jqxRating"></span>
								<br/>
								<span class="btn_box">
									<a href="#" onclick="javascript:data_set('${prodAfterList.prodNm}','${prodAfterList.prodGrade}','${prodAfterList.boardTitle}','${prodAfterList.boardCont}','${prodAfterList.secProdNm}','${prodAfterList.basicImg}','${status.count}','${prodAfterList.attchFilePath}');layer_open('layer');return false;" class="btn09">보기</a>
								</span>
								<em>${prodAfterList.pptCd}</em>
							</div>
						</li>
						</c:forEach>
						<c:if test="${empty prodAfterList}">
							<div class="nocomment">등록한 후기가 없습니다.</div>
						</c:if>
					</ul>
			</div>

			<script>
				function data_set(v1,v2,v3,v4,v5,v6,v7,prodFile){
					$("#view_product").html(v5 + "<br/>" + v1);
					$(".viewStar").jqxRating({disabled:true});
					$(".viewStar").jqxRating('val',v2);
					$("#view_title").html(v3);
					var fileImg = '';
					if(prodFile != ''){
						if("${iConstant.isMobile(pageContext.request)}" == 'false'){
							fileImg = '<img src=\"' + prodFile + '\" style="max-width: 400px;"/><br/>';
						}
	 					if("${iConstant.isMobile(pageContext.request)}" == 'true'){
	 						fileImg = '<img src=\"' + prodFile + '\" style="max-width: 150px;"/><br/>';
	 					}
						fileImg += v4;
					}else{
						fileImg = v4;
					}
					$("#view_content").html(fileImg);
					$("#view_img").attr("src",v6);
				}
			</script>
			<!--=============== #layer ===============-->
			<div class="layer cont">
				<div class="bg"></div>
				<div id="layer" class="pop-layer">
					<div class="pop-container">
						<div class="pop-cont">
							<div class="title">
								<strong>나의 제품후기</strong>
								<a href="#" class="cbtn">Close</a>
							</div>
							<div class="pcont">
								<ul class="top_info">
									<li>후기 작성시 <span>포인트(텍스트 200점, 포토 500점)</span>가 적립됩니다.</li>
									<li>구매한 후 6개월이 지난 제품의 후기는 작성하실 수 없습니다.</li>
									<li>취소/반품/교환의 경우 작성하신 후기 및 적립금은 자동삭제 됩니다.</li>
								</ul>

								<table cellpadding="0" cellspacing="0" class="tsytle">
									<colgroup>
										<col width="20%">
										<col width="80%">
									</colgroup>
									<tbody>
										<tr>
											<th>제품 정보</th>
											<td class="product_info">
												<img src="" id="view_img" />
												<span class="" id="view_product"></span>
											</td>
										</tr>
										<tr>
											<th>제품 만족도</th>
											<td>
												<div class="star_wrap">
													<ul>
														<li>
															<span id="view_star" class="viewStar"></span>
														</li>
													</ul>
												</div>
											</td>
										</tr>
										<tr>
											<th>제목</th>
											<td  id="view_title"></td>
										</tr>
										<tr>
											<th>후기내용</th>
											<td class="review_text"  id="view_content"></td>
										</tr>
									</tbody>
								</table>
							</div>
						</div>
					</div>
				</div>
			</div>
			<!--=============== #layer ===============-->

		</div>
	</div>
	<!--=============== #CONNTENTS ===============-->
</div>
<!--=============== #CONTAINER ===============-->

</body>