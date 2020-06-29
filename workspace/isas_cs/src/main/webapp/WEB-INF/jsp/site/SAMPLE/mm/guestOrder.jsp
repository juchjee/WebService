<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
	<script type="text/javascript">
	<!--

		function init(){
			fnEvent();
		}

		function fnEvent(){
			$.orderCancel = function(type,orderNo,regiNo){
				if(regiNo != ''){
					alert('상품 준비중, 배송중에는 왕복택배비 4천원이 발생되며, \n반드시 고객센타(080-668-6108)를 통해 \n주문취소접수 진행 부탁드립니다.');
					return;
				}else{
					//cancel apply return
					$.fancybox.open({
						href: "/ISDS/user/orderCancel.action?orderNo="+orderNo+"&type="+type,
						type: "iframe",
			 			maxWidth	: 400,
			 			width		: 400,
			 			autoSize	: true,
			 			modal : false
					});
				}
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
				<h3>주문/배송 조회</h3>

				<form name="f" method="post" >
				<input type="hidden" name="countn">
				<input type="hidden" name="why1">
				<input type="hidden" name="mtype">
				<input type="hidden" name="order_tr">
				<input type="hidden" name="termMode" id="termMode">

				<div class="order bostyle01" style="margin-bottom:30px;">

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
								<td><strong class="dn_pc">주문번호 : </strong> <a href="/ISDS/user/orderDetail.do?orderNo=${order.orderNo}" style="color:#65bacd;text-decoration:underline;">${order.orderNo}</a></td>
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
										<div class="txt_order1"><strong><span class="validation[number]">${order.orderSum}</span>&nbsp;원</strong></div>
										<c:if test="${order.orderSum != order.orderAmt}">
										<div class="txt_orderbox">
											<div class="txt_order2">상품금액 : <span class="validation[number]">${order.orderAmt}</span>&nbsp;원</div>
											<c:if test="${order.orderSaleAmt != 0}">
											<div class="txt_order3">상품할인 : -&nbsp;<span class="validation[number]">${order.orderSaleAmt}</span>&nbsp;원</div>
											</c:if>
											<c:if test="${order.orderCopnAmt != 0}">
											<div class="txt_order3">쿠폰할인 : -&nbsp;<span class="validation[number]">${order.orderCopnAmt}</span>&nbsp;원</div>
											</c:if>
											<c:if test="${order.orderResvAmt != 0}">
											<div class="txt_order3">적립금사용 : -&nbsp;<span class="validation[number]">${order.orderResvAmt}</span>&nbsp;원</div>
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
												<c:when test="${order.orderCashCd eq 'Online'  || order.orderStatusCd eq 'Vbank'  || order.orderStatusCd eq 'Escrow'}">
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
										<c:if test="${order.orderStatusCd eq 'OOS00003' || order.orderStatusCd eq 'OOS00004' }">
											<div class="div_margin m_float"><a href="javascript:;"  onclick="$.orderCancel('apply','${order.orderNo}','${order.regiNo}');" class="btn04">취소신청</a></div>
										</c:if>
										<c:if test="${order.orderStatusCd eq 'OOS00009'}">
<!-- 											<div class="div_margin">배송완료</div> -->
										</c:if>
										<c:if test="${not empty order.regiNo}">

											<div class="div_margin smallText m_cb">
												(우체국택배)<br class="dn_mc">
												${order.regiNo}<br class="dn_mc">
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
			</div>
				</div>

				<c:if test="${not empty traceList}">
				<div class="bostyle01">
					<strong class="title_text">구매상품 배송현황</strong>
					<div class="table_wrap tbl_res1">
						<table cellpadding="0" cellspacing="0">
							<colgroup>
								<col width="25%">
								<col width="20%">
								<col width="*">
								<col width="20%">
							</colgroup>
							<thead>
								<tr>
									<th>날짜</th>
									<th>시간</th>
									<th>현재위치</th>
									<th>처리현황</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${traceList}" var="item">
								<tr>
									<td>${item.sortingdate}</td>
									<td>${item.eventhms}</td>
									<td>${item.eventregiponm}</td>
									<td>${item.tracestatus}</td>
								</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
				</div>
				</c:if>

				<input type="hidden" name="otype" value="2">
				</form>
			</div>

			<!--=============== #CONNTENTS ===============-->
		</div>
		<!--=============== #CONTAINER ===============-->


</body>