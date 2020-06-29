<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
	<script type="text/javascript">
	<!--
	function init(){
		fnEvent();
	}

	function fnEvent(){
		<c:if test="${not empty afterMap}">
			$(".jqxRating").jqxRating({
				width: 75,
			    height: 20,
			 	itemWidth:15,
			 	itemHeight:15,
			    disabled:true
			});

			$(".jqxRating").jqxRating('val','${afterMap.prodGrade}');
		</c:if>

		$.orderCancel = function(type,orderNo,regiNo){
			if(regiNo != ''){
				alert('상품 준비중, 배송중에는 왕복택배비 4천원이 발생되며, \n반드시 고객센타(080-668-6108)를 통해 \n주문취소접수 진행 부탁드립니다.');
				return;
			}else{
				//cancel apply return
				$.fancybox.open({
					href: "orderCancel.action?orderNo="+orderNo+"&type="+type,
					type: "iframe",
		 			maxWidth	: 400,
		 			width		: 400,
		 			autoSize	: true,
		 			modal : false
				});
			}
		}

		$.orderAddr = function(orderNo,regiNo){
				$.fancybox.open({
					href: "orderAddr.action?orderNo="+orderNo+"&regiNo="+regiNo,
					type: "iframe",
		 			maxWidth	: 400,
		 			maxHeight	: 450,
		 			height		: 450,
		 			width		: 400,
		 			autoSize	: false,
		 			modal : false
				});
		}

		$.goModify = function(seq,code){
			document.adviceForm.boardSeq.value = seq;
			document.adviceForm.action = "myadvice_write.do?pageCd="+code;
			document.adviceForm.submit();
		}
	}

	function billPop(orderNo){
		window.open('/ISDS/cashbill/getEPrintURL.do?orderNo='+orderNo, '', 'width=800, height=800');
	}

	//-->
	</script>

</head>
<body>

<!--=============== #CONTAINER ===============-->
<div id="container" class="user">
  	<!--=============== #CONNTENTS ===============-->
	<div id="contents" class="inner">
		<h3><img src="/common/images/tit/h3_tit7_1.png" alt="마이페이지"></h3>

		<ul class="mypage_menu">
					<li class="col1 on"><a href="/ISDS/user/mypage.do" ><span>아이콘</span>마이페이지</a></li>
					<li class="col2 "><a href="/ISDS/user/order.do" ><span>아이콘</span>주문/배송 조회</a></li>
					<li class="col3"><a href="/ISDS/user/wishList.do" ><span>아이콘</span>위시리스트</a></li>
					<li class="col4"><a href="/ISDS/user/cash.do" ><span>아이콘</span>멤버십 혜택/포인트/쿠폰</a></li>
					<li class="col5"><a href="/ISDS/user/product.do" ><span>아이콘</span>나의 문의내역</a></li>
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
		<div class="order bostyle01">
			<strong class="title_text">주문/배송조회 <span>최근 1개월간 구매하신 상품의 주문현황입니다.</span></strong>

			<div class="step_wrap">
				<ul>
					<li class="col1"><span>주문접수 <em class="validation[number]">${cntMap.orderCnt}</em>건</span>
					<li class="col2"><span>입금확인 <em class="validation[number]">${cntMap.depositCnt}</em>건</span>
					<li class="col3"><span>발송완료 <em class="validation[number]">${cntMap.sendCnt}</em>건</span>
					<li class="col4"><span>주문취소 <em class="validation[number]">${cntMap.claimCnt}</em>건</span>
				</ul>
			</div>

			<div class="table_wrap pd10">
				<table cellpadding="0" cellspacing="0">
					<colgroup>
						<col width="100">
						<col width="100">
						<col width="*">
						<col width="140">
						<col width="140">
						<col width="140">
					</colgroup>
					<thead>
						<tr>
							<th>주문번호</th>
							<th>주문일자</th>
							<th>상품정보</th>
							<th>결제방법</th>
							<th>결제금액</th>
							<th>주문처리상태</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${orderList}" var="order">
							<tr>
								<td>
									<strong class="dn_pc m_float" style="line-height:26px;">주문번호 : </strong> <div class="div_margin m_float"><a href="/ISDS/user/orderDetail.do?orderNo=${order.orderNo}" style="color:#65bacd;text-decoration:underline;">${order.orderNo}</a></div>
									<c:if test="${order.claimYn eq 'N'}">
										<c:if test="${order.orderStatusCd eq 'OOS00001' || order.orderStatusCd eq 'OOS00002'}">
											<div class="div_margin m_float"><a href="javascript:;"  onclick="$.orderAddr('${order.orderNo}','${order.regiNo}');" class="btn04">배송지 변경</a></div>
										</c:if>
									</c:if>
								</td>
								<td><strong class="dn_pc">주문일자 : </strong> ${order.orderDt}</td>
								<td>
									<div class="prodBox">
									<c:forEach items="${order.prodInfoList}" var="prodInfo" varStatus="idx">
										<div class="prodUit" onclick="pordDtlLink('${prodInfo.prodCd}');">
											<div class="prodImg"><img src="${prodInfo.prodImg}" /></div>
											<div class="prodExp">
												<div>${prodInfo.prodNm}<c:if test="${prodInfo.prodTypeGsp eq 'P'}"><span class="ptText">(포인트상품)</span></c:if></div>
												<div>수량 : <span class="validation[number]">${prodInfo.prodQty}</span> 개</div>
											</div>
										</div>
										<%-- <c:if test="${!idx.last}"><center><div style="width:96%;height:1px;margin-bottom:5px;border-top:#ccc 1px dotted;"></div></center></c:if> --%>
									</c:forEach>
									</div>
								</td>
								<td><strong class="dn_pc">결제방법 : </strong> ${order.orderCashNm}</td>
								<td>
										<div class="txt_order1"><span class="validation[number]">${order.orderSum}</span> 원</div>
										<c:if test="${order.orderSum != order.orderAmt}">
										<div class="txt_orderbox">
											<div class="txt_order2">상품금액 : <span class="validation[number]">${order.orderAmt}</span> 원</div>
											<c:if test="${order.orderSaleAmt != 0}">
											<div class="txt_order3">상품할인 : - <span class="validation[number]">${order.orderSaleAmt}</span> 원</div>
											</c:if>
											<c:if test="${order.orderCopnAmt != 0}">
											<div class="txt_order3">쿠폰할인 : - <span class="validation[number]">${order.orderCopnAmt}</span> 원</div>
											</c:if>
											<c:if test="${order.orderResvAmt != 0}">
											<div class="txt_order3">적립금사용 : - <span class="validation[number]">${order.orderResvAmt}</span> 원</div>
											</c:if>
										</div>
										</c:if>

											<c:choose>
												<c:when test="${order.orderDeliCharge == 0}">
													<div class="txt_order2"><strong>배송비 :  무료배송</strong></div>
												</c:when>
												<c:otherwise>
													<div class="txt_order2"><strong>배송비 : <span class="validation[number]">${order.orderDeliCharge}</span>&nbsp;원</strong></div>
												</c:otherwise>
											</c:choose>
								</td>
								<td>
									<c:if test="${order.claimYn eq 'N'}">
									<div class="div_margin m_float"><strong class="dn_pc">주문처리상태 : </strong> ${order.orderStatusNm}</div>
									<%/*
										OOS00001	입금대기
										OOS00002	입금확인
										OOS00003	상품준비중
										OOS00004	배송준비중
										OOS00005	배송중
										OOS00009	배송완료
									*/ %>
										<c:if test="${order.orderStatusCd eq 'OOS00001'}">
												<div class="div_margin m_float"><a href="javascript:;"  onclick="$.orderCancel('cancel','${order.orderNo}','${order.regiNo}');" class="btn04">주문취소</a></div>
												<c:if test="${ order.orderCashCd eq 'Escrow' || order.orderCashCd eq 'Vbank' || order.orderCashCd eq 'Online' }">
													<div class="div_margin smallText m_float">${order.orderPayDt} 까지</div>
												</c:if>
										</c:if>
										<c:if test="${order.orderStatusCd eq 'OOS00002'}">
											<c:choose>
												<c:when test="${order.orderCashCd eq 'Online'}">
												<div class="div_margin m_float"><a href="javascript:;"  onclick="$.orderCancel('apply','${order.orderNo}','${order.regiNo}');" class="btn04">취소신청</a></div>
												</c:when>
												<c:otherwise>
													<div class="div_margin m_float"><a href="javascript:;"  onclick="$.orderCancel('cancel','${order.orderNo}','${order.regiNo}');" class="btn04">주문취소</a></div>
												</c:otherwise>
											</c:choose>
											<c:choose>
												<c:when test="${order.orderCashCd eq 'Online'}">
													<div class="div_margin m_float">
														<a class="btn04" href="#" onclick="billPop('${order.orderNo}');">
															현금영수증
														</a>
													</div>
												</c:when>
												<c:otherwise>
													<div class="div_margin m_float">
													<a class="btn04" href="#" onclick="window.open('https://iniweb.inicis.com/ISDS/cr/cm/mCmReceipt_head.jsp?noTid=${order.tid}&noMethod=1', '', 'width=399, height=709');return false">
														<c:choose>
															<c:when test="${ order.orderCashCd eq 'Card'}">
																카드매출전표출력
															</c:when>
															<c:when test="${ order.orderCashCd eq 'HPP'}">
																휴대폰결제 영수증
															</c:when>
															<c:otherwise>
																현금영수증
															</c:otherwise>
														</c:choose>
													</a>
													</div>
												</c:otherwise>
											</c:choose>
										</c:if>
										<c:if test="${order.orderStatusCd eq 'OOS00003' || order.orderStatusCd eq 'OOS00004'}">
											<div class="div_margin  m_float"><a href="javascript:;"  onclick="$.orderCancel('apply','${order.orderNo}','${order.regiNo}');" class="btn04">취소신청</a></div>
										</c:if>
										<c:if test="${order.orderStatusCd eq 'OOS00009'}">
<!-- 											<div class="div_margin">배송완료</div> -->
										</c:if>

										<c:if test="${not empty order.regiNo}">

											<div class="div_margin smallText m_cb">
												(우체국택배) <br class="dn_mc" />
												${order.regiNo}<br class="dn_mc"/>
												<a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=${order.regiNo}&displayHeader=N" target="_blank" class="btn13" title="배송조회 상세보기">배송추적</a>
											</div>
										</c:if>
									</c:if>
									<c:if test="${order.claimYn eq 'Y'}">
									<div class="div_margin">${order.claimTpNm}</div>
									</c:if>
								</td>
							</tr>
						</c:forEach>
						<c:if test="${empty orderList}">
							<tr><td colspan=10 height="25" align="center">주문 내역이 없습니다.</td></tr>
						</c:if>
					</tbody>
				</table>
				<a class="more" href="order.do">더보기</a>
			</div>

			<form id="adviceForm" name="adviceForm" method="post">
				<input type="hidden" name="boardSeq" id="boardSeq" />
			</form>

			<div class="my_service">
				<div class="my_advice">
					<strong class="title_text">나의 문의내역</strong>
					<ul>
						<c:forEach items="${adviceList}" var="adviceList">
							<li>
								<span>[${adviceList.boardMstNm}]</span>
								<c:choose>
									<c:when test="${adviceList.boardProdYn eq 'N'}">
										<a href="javascript:;" onclick="$.goModify('${adviceList.boardSeq}','${adviceList.boardMstCd}');">${adviceList.boardTitle}</a>
									</c:when>
									<c:otherwise>
										<a href="${rootUri}${frontUri}user/product.do">${adviceList.boardTitle}</a>
									</c:otherwise>
								</c:choose>

								<c:if test="${adviceList.boardState eq '완료'}">
									<em>답변완료</em>
								</c:if>
								<c:if test="${adviceList.boardState eq '대기'}">
									<em>답변대기</em>
								</c:if>
							</li>
						</c:forEach>
							<c:if test="${empty adviceList}">
							<li style="line-height:142px;text-align:center;">문의내역이 없습니다.</li>
							</c:if>
					</ul>
					<a class="more" href="${rootUri}${frontUri}user/product.do">더보기</a>
				</div>

				<div class="my_comment">
					<strong class="title_text">나의 제품후기</strong>
						<c:if test="${!empty afterMap}">
							<div>
								<a href="${rootUri}${frontUri}user/review_set.do" class="img_box">
									<img src="${afterMap.basicImg}" width="100" height="100">
								</a>
								<a href="${rootUri}${frontUri}user/review_set.do" class="text_box">
									<em>듀오락</em>
									<strong>${afterMap.prodNm}</strong>
									<span>
										<p>
											${afterMap.boardTitle}
										</p>
										<span class="star">
											<span class="jqxRating"></span>
										</span>
										<em class="date">${afterMap.regDt}</em>
									</span>
								</a>
							</div>
						</c:if>
						<c:if test="${empty afterMap}">
							<div class="nocomment">후기가 없습니다.</div>
						</c:if>
					<a class="more" href="${rootUri}${frontUri}user/review_set.do">더보기</a>
				</div>

			</div>
		</div>
	</div>
	<!--=============== #CONNTENTS ===============-->


</div>
<!--=============== #CONTAINER ===============-->


</body>