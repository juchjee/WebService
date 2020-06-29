<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
	<script type="text/javascript">
	<!--
		function init(){

			var nowTimeArr = "${nowYmd}".split("-");

			var preMonth = nowTimeArr[1] -1;
			var preMonth2 = nowTimeArr[1];
			var aftMonth = parseInt(nowTimeArr[1]) +1;
			aftMonth = (aftMonth < 10) ? '0' + aftMonth : aftMonth;

			if(preMonth==0){
				preMonth = 12;
				var preLast = (new Date(nowTimeArr[0],preMonth,0)).getDate();
				if(preMonth == '12'){
					$("#preDate").text((nowTimeArr[0]-1)+"-"+preMonth2+"-01 ~ "+(nowTimeArr[0]-1)+"-"+preMonth+"-"+preLast);
				}else{
					$("#preDate").text((nowTimeArr[0]-2)+"-"+preMonth2+"-01 ~ "+(nowTimeArr[0]-1)+"-"+preMonth+"-"+preLast);
				}
				//$("#preDate").text((nowTimeArr[0]-2)+"-"+preMonth2+"-01 ~ "+(nowTimeArr[0]-1)+"-"+preMonth+"-"+preLast);
				if(preMonth==12){
					$("#memDate").text((nowTimeArr[0]-1)+"-"+preMonth2+"-01 ~ "+(nowTimeArr[0]-1)+"-"+preMonth+"-"+preLast);
				}else{
					$("#memDate").text((nowTimeArr[0]-2)+"-"+preMonth2+"-01 ~ "+(nowTimeArr[0]-1)+"-"+preMonth+"-"+preLast);
				}
				var memMonth = 1;
				memMonth = (memMonth < 10) ? '0' + memMonth : memMonth;
				var memLast = (new Date(nowTimeArr[0],memMonth,0)).getDate();
				$("#nextMemDate").text((nowTimeArr[0]-1)+"-"+aftMonth+"-01 ~ "+nowTimeArr[0]+"-"+memMonth+"-"+memLast);
			}else{
				preMonth = (preMonth < 10) ? '0' + preMonth : preMonth;
		//		preMonth2 = (preMonth2 < 10) ? '0' + preMonth2 : preMonth2;

				var preLast = (new Date(nowTimeArr[0],preMonth,0)).getDate();
				if(preMonth == '12'){
					$("#preDate").text((nowTimeArr[0])+"-"+preMonth2+"-01 ~ "+(nowTimeArr[0])+"-"+preMonth+"-"+preLast);
				}else{
					$("#preDate").text((nowTimeArr[0]-1)+"-"+preMonth2+"-01 ~ "+(nowTimeArr[0])+"-"+preMonth+"-"+preLast);
				}
				//$("#preDate").text((nowTimeArr[0]-1)+"-"+preMonth2+"-01 ~ "+(nowTimeArr[0])+"-"+preMonth+"-"+preLast);
				$("#memDate").text((nowTimeArr[0]-1)+"-"+preMonth2+"-01 ~ "+(nowTimeArr[0])+"-"+preMonth+"-"+preLast);
				var memMonth = parseInt(preMonth)+1;
				memMonth = (memMonth < 10) ? '0' + memMonth : memMonth;
				var memLast = (new Date(nowTimeArr[0],memMonth,0)).getDate();
				if(aftMonth == '13'){
					$("#nextMemDate").text((nowTimeArr[0])+"-01-01 ~ "+nowTimeArr[0]+"-12-31");
				}else{
					$("#nextMemDate").text((nowTimeArr[0]-1)+"-"+aftMonth+"-01 ~ "+nowTimeArr[0]+"-"+memMonth+"-"+memLast);
				}
			}

			if(aftMonth>12){
				aftMonth = 1;
				aftMonth = (aftMonth < 10) ? '0' + aftMonth : aftMonth;
				nextMonth = 2;
				nextMonth = (nextMonth < 10) ? '0' + nextMonth : nextMonth;

				$("#aftDate").text(nowTimeArr[0]+"-"+memMonth+"-05 ~ "+(parseInt(nowTimeArr[0]))+"-"+(parseInt(aftMonth)+2)+"-04");
				$("#nextAftDate").text((parseInt(nowTimeArr[0])+1)+"-"+aftMonth+"-05 ~ "+(parseInt(nowTimeArr[0])+1)+"-"+(parseInt(nextMonth)+2)+"-04");
			}else{
				var nextMonth = parseInt(aftMonth)+1;
				//aftMonth = (aftMonth < 10) ? '0' + aftMonth : aftMonth;
				nextMonth = (nextMonth < 10) ? '0' + nextMonth : nextMonth;
				var aftMonth_end = parseInt(aftMonth)+2;
				aftMonth_end = (aftMonth < 10) ? '0' + aftMonth_end : aftMonth_end;
				var nextMonth_end = parseInt(nextMonth)+2;
				nextMonth_end = (nextMonth < 10) ? '0' + nextMonth_end : nextMonth_end;
				$("#aftDate").text(nowTimeArr[0]+"-"+memMonth+"-05 ~ "+(parseInt(nowTimeArr[0]))+"-"+aftMonth_end+"-04");
				$("#nextAftDate").text((nowTimeArr[0])+"-"+aftMonth+"-05 ~ "+(nowTimeArr[0])+"-"+nextMonth_end+"-04");
			}
		}
	//-->
	</script>
</head>
<body>

<div id="container" class="user">

	<div id="contents" class="inner" style="max-width: 1002px;">
		<h3><img src="/common/images/tit/h3_tit7_4.png" alt="나의 멤버십 혜택/포인트/구분"></h3>

		<ul class="mypage_menu">
					<li class="col1 "><a href="/ISDS/user/mypage.do" ><span>아이콘</span>마이페이지</a></li>
					<li class="col2 "><a href="/ISDS/user/order.do" ><span>아이콘</span>주문/배송 조회</a></li>
					<li class="col3"><a href="/ISDS/user/wishList.do" ><span>아이콘</span>위시리스트</a></li>
					<li class="col4 on"><a href="/ISDS/user/cash.do" ><span>아이콘</span>멤버십 혜택/포인트/쿠폰</a></li>
					<li class="col5"><a href="/ISDS/user/product.do" ><span>아이콘</span>나의 문의내역</a></li>
					<li class="col6"><a href="/ISDS/user/review.do" ><span>아이콘</span>나의 제품후기</a></li>
					<li class="col7"><a href="/ISDS/user/setting.do" ><span>아이콘</span>회원정보</a></li>
					<li class="col8"><a href="/ISDS/order/cart.do" ><span>아이콘</span>장바구니</a></li>
		</ul>

		<div class="my_info" >
			<div class="text_box">
				<span style="font-size:14px;">
					<em class="text_name">${userMap.mbrNm}</em>님 환영합니다!<br />듀오락 패밀리 멤버십 등급은 <br/><em>${userMap.mbrLevNm}</em>입니다.
					<br/><br/>다음달 <em>${userMap.nextLevNm}</em>가 되기 위해 필요한<br/>구매 금액은 <em>
					<c:choose>
						<c:when test="${not empty userMap.nextMbrLevAmot}">
							<fmt:formatNumber value="${userMap.nextMbrLevAmot}" pattern="#,###"/>
						</c:when>
						<c:otherwise>0</c:otherwise>
					</c:choose>
					</em>원 입니다.</span>

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
		<form name="f" method="post" action="/ISDS/user/cash.do">
		<div class="cash bostyle01 question">
			<ul class="tabmenu">
				<li class="on"><a href="/ISDS/user/cash.do">나의 멤버십 혜택</a></li>
				<li><a href="point.do">포인트 내역</a></li>
				<li class="last"><a href="/ISDS/user/coupon.do">쿠폰 내역</a></li>
			</ul>

			<div style="color:#fff;background-color:#ff8f00;font-weight:800;text-align:center;padding-top:10px;padding-bottom:10px;">
			${fn:split(nowYmd,'-')[1]}월 멤버십 등급은 <em id="preDate"></em>
			까지 발송 완료된 주문 금액으로 ${fn:split(nowYmd,'-')[1]}월05일 선정됩니다.
			</div>

			<div class="top_info_l">
				<div class="cont">
					<strong class="title_text_s">${fn:split(nowYmd,'-')[0]}년 ${fn:split(nowYmd,'-')[1]}월, 나의 듀오락 패밀리 멤버십</strong>
					<table class="tsytle_s" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<th>멤버십 등급</th>
								<td>
									<em>${userMap.mbrLevNm}</em>
								</td>
							</tr>
							<tr>
								<th>등급 혜택 기간</th>
								<td>
									<div id="aftDate"></div>
								</td>
							</tr>
							<tr>
								<th>
									산정기준 (<span style="color:red;font-weight:800;">매월 5일 변경</span>)
								</th>
								<td>
									<div id="memDate"></div>
								</td>
							</tr>
							<tr>
								<th>멤버십 등급 산정 기간내 <br class="dn_mc">구매금액</th>
								<td>
								<fmt:formatNumber value="${totalAmt}" pattern="#,###"/> 원
								</td>
							</tr>
							<tr>
								<th>구매기준</th>
								<td>산정기간 내 발송 완료 상태인 주문</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>

			<div class="top_info_r">
				<div class="cont">
					<strong class="title_text_s2">다음 달 <strong>${userMap.nextLevNm}</strong>로 등급 상승 하실려면?</strong>
					<table class="tsytle_s" cellpadding="0" cellspacing="0">
						<tbody>
							<tr>
								<th>멤버십 목표 등급</th>


								<td><em><c:choose><c:when test="${empty userMap.nextLevNm}">VVIP</c:when><c:otherwise>${userMap.nextLevNm}</c:otherwise></c:choose></em>
								</td>
							</tr>
							<tr>
								<th>등급 혜택 기간</th>
								<td>
									<div id="nextAftDate"></div>
								</td>
							</tr>
							<tr>
								<th>산정기준 (<span style="color:red;font-weight:800;">매월 5일 변경</span>)</th>
								<td>
									<div id="nextMemDate"></div>
								</td>
							</tr>
							<tr>
								<th>멤버십 등급 상승 시 <br class="dn_mc">필요한 구매금액</th>
								<td>
								<c:choose>
								<c:when test="${empty userMap.nextMbrLevAmot}">0 </c:when>
								<c:otherwise><fmt:formatNumber value="${userMap.nextMbrLevAmot}" pattern="#,###"/></c:otherwise></c:choose>원
								</td>
							</tr>
							<tr>
								<th>구매기준</th>
								<td>산정기간 내 발송 완료 상태인 주문</td>
							</tr>

						</tbody>
					</table>
				</div>

			</div>

			<div class="top_info">
				<c:choose>
					<c:when test="${userMap.mbrLevCd eq 'MLP00001'}">
                      <img src='${rootUri}common/img/screen/normal_screen.png'>
					</c:when>
					<c:when test="${userMap.mbrLevCd eq 'MLP00002'}">
                      <img src='${rootUri}common/img/screen/bronze_screen.png'>
					</c:when>
					<c:when test="${userMap.mbrLevCd eq 'MLP00003'}">
                      <img src='${rootUri}common/img/screen/silver_screen.png'>
					</c:when>
					<c:when test="${userMap.mbrLevCd eq 'MLP00004'}">
                      <img src='${rootUri}common/img/screen/gold_screen.png'>
					</c:when>
					<c:when test="${userMap.mbrLevCd eq 'MLP00005'}">
                      <img src='${rootUri}common/img/screen/vip_screen.png'>
					</c:when>
					<c:when test="${userMap.mbrLevCd eq 'MLP00006'}">
                      <img src='${rootUri}common/img/screen/vvip_screen.png'>
					</c:when>
				</c:choose>
			</div>
		</div>
		</form>
	</div>
</div>

</body>