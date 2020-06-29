<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--
	//-->
	</script>
</head>
<body>

	<div id="container" class="info">
		<div id="contents" class="inner">
			<h3><img src="/common/images/tit/h3_tit5_6.png" alt="이용안내"></h3>

			<ul class="center_info center_res1">
				<li>
					<div class="img_box">
						<img src="${rootUri}common/img/icon/info_icon04.png" />
					</div>
					<ul>
						<li><strong>교환/반품 이용방법</strong></li>
						<li>교환 및 반품은 수령 후 <em>7일 이내에 가능</em>하며, 반드시 <em>고객센터(080-668-6108)에 연락</em>하여 접수해주십시오.</li>
						<li>제품의 하자가 있거나 자 사 귀책사유에 해당하는 경우 100% 교환 및 환불해드립니다.</li>
						<li>제품 하자가 아닌 소비자의 단순 변심, 착오 구매로 인해 교환 및 반품을 하실 경우 발생하는 배송비용은 소비자가 부담해주셔야합니다. <span>(3만원 이하 반품시 2,000원 / 3만원 이상 반품 및 모든 교환시는 왕복 배송비 4,000원)</span></li>
						<li>환불은 반품이 정상적으로 이루어진 후 영업일(주말 및 공휴일 제외) 3일 이내 완료됩니다.</li>
					</ul>
				</li>
				<li>
					<div class="img_box">
						<img src="${rootUri}common/img/icon/info_icon02.png" />
					</div>
					<ul>
						<li><strong>교환/반품이 불가능한 경우</strong></li>
						<li>개봉 및 사용 등으로 인해 상품의 가치가 현저히 훼손되었을경우(전자상거래 법 17조 2항)</li>
						<li>단, 제품에 하자가 있을 경우는 이 상황과 관계없이 교환 및 반품이 가능합니다.</li>
						<li>듀오락 쇼핑몰에서 구입하신 후 상품의 품질 불만 및 피해로 인해 분쟁이 발생하였을경우 소비자기본법의 소비자 분쟁 해결기준에 따라<br />분쟁해결절차를 진행하게 됩니다</li>
					</ul>
				</li>
				<li class="bene">
					<div class="img_box">
						<!-- <img src="../_common/img/icon/info_icon03.png" /> -->
						<!-- <img src="../upload/member/mem_logo.png" /> -->
						<img src="${rootUri}common/img/icon/mem_logo.png" />
					</div>
					<ul>
					<!--20160101 psk start-->
						<!-- <li><strong>듀오락 적립금이란?</strong></li>
						<li>적립금은 제품 구매 시 현금과 동일하게 사용하실 수 있는 사이버머니로 회원가입 시 최종 결제금액의 3%를 지급하여 드립니다.</li>
						<li>1년간 유효하며, 1년이 경과된 적립금은 순차적으로 소멸 됩니다.</li>
						<li>적립금 내역은 <a href="${rootUri}${frontUri}user/cash.do">마이페이지 > 적립금/포인트/쿠폰</a>에서 조회가 가능합니다.</li>
						<li>적립금은 현금으로 환급이 불가능한 비 현금성 금액이므로, 적립금으로 결제하신 금액에 대해서는 재적립이 불가능합니다.</li>
						<li>
							적립금의 적립율은 쇼핑몰의 정책에 따라 수시로 변경될 수 있습니다.
							<div class="btn_group"><a class="btn04" href="${rootUri}${frontUri}user/cash.do">나의 적립금 확인하기</a></div>
						</li> -->
						<li><strong>듀오락 패밀리 멤버십이란?</strong></li>
						<li>듀오락 패밀리 멤버십 서비스는 DUOLAC 쇼핑몰 회원들에게만 제공됩니다.</li>
						<li>듀오락 패밀리 멤버십 서비스는 멤버십 등급에 따라 쇼핑몰 상시 할인, 등급 UP 축하 쿠폰, 추가 상품 제공등의 다양하고 풍성한 혜택이 제공됩니다.</li>
						<li>듀오락 패밀리 멤버십 등급은 마이페이지> 나의 멤버십 혜택에서 확인하실 수 있습니다.</li>
						<li>듀오락 패밀리 멤버십 등급은 쇼핑몰 정책에 따라 변경될 수 있습니다.</li>
						<li>2016년 듀오락 패밀리 멤버십 서비스가 신규 오픈 됨에 따라 듀오락 쇼핑몰의 적립금 제도는 2015년 12월 31일까지 운영되고 종료되었습니다.<br/> 2015년 12월 31일까지 누적된 적립금은 적립금 구간별로 2016년 할인 쿠폰으로 발행되었습니다.

							<div class="btn_group">
								<c:if test="${!isLogIn}">
									<a class="btn04" href="${rootUri}${frontUri}mm/acessLogin.do?pageCd=SFM00406">나의 멤버십 확인하기</a>
<%-- 									<a class="btn04" href="${rootUri}${frontUri}user/cash.do">나의 멤버십 확인하기</a> --%>
								</c:if>
								<c:if test="${isLogIn}">
									<a class="btn04" href="${rootUri}${frontUri}user/cash.do">나의 멤버십 확인하기</a>
								</c:if>
							</div>
						</li>
					<!--20160101 psk end-->
					</ul>
				</li>
				<li>
					<div class="img_box" id="duolacPoint">
						<img src="${rootUri}common/img/icon/info_icon01.png" />
					</div>
					<ul>
						<li><strong>듀오락 포인트란?</strong></li>
						<li>포인트는 제품 구입 시 추가 샘플신청과 각종 이벤트 참여에 사용하실 수 있는 활동점수로 회원등급과 활동내역에 따라 지급하여 드립니다.</li>
						<li>포인트 내역은 <a href="${rootUri}${frontUri}user/point.do">마이페이지 > 적립금/포인트/쿠폰</a>에서 조회가 가능합니다.</li>
						<li>추가 샘플 요청은 본 제품 구매 시에만 가능합니다.</li>
						<li>패밀리 멤버십으로 적립된 포인트는 적립 후 제품으로 전환제공합니다. </li>
						<li>활동내역에 따른 포인트 규정은 쇼핑몰의 정책에 따라 수시로 변경될 수 있습니다.
							<div class="btn_group">
								<c:if test="${!isLogIn}">
									<a class="btn04" href="${rootUri}${frontUri}mm/acessLogin.do?pageCd=SFM00405">나의 포인트 확인하기</a>
								</c:if>
								<c:if test="${isLogIn}">
									<a class="btn04" href="${rootUri}${frontUri}user/point.do">나의 포인트 확인하기</a>
								</c:if>
								<a href="javascript:;" class="btn04 info_btn">포인트 정책 확인</a>
								<div class="info_table" style="width: 300px;">
									<span>포인트 정책</span>
									<table cellpadding="0" cellspacing="0" class="tsytle">
										<colgroup>
											<col width="35%">
											<col width="20%">
											<col width="45%">
										</colgroup>
										<tr>
											<th>회원가입</th>
											<td>500</td>
											<td>최초 1회 한정</td>
										</tr>
										<tr>
											<th>로그인</th>
											<td>10</td>
											<td>1일 1회 한정</td>
										</tr>
										<tr>
											<th>제품문의 작성</th>
											<td>50</td>
											<td>&nbsp;</td>
										</tr>
										<tr>
											<th>제품후기(텍스트)</th>
											<td>200</td>
											<td>제품 구매 시</td>
										</tr>
										<tr>
											<th>제품후기(포토)</th>
											<td>500</td>
											<td>제품 구매 시</td>
										</tr>
										<tr>
											<th>회원 추천</th>
											<td>300</td>
											<td>추천 아이디 등록 시</td>
										</tr>
										<!--
										<tr>
											<th>가족정보 등록</th>
											<td>500</td>
											<td>최초 1회</td>
										</tr> -->

									</table>
									<a href="#" onclick="return false;" class="pop_btn_point_close"><img src="${rootUri}common/img/icon/pop_close_btn.png" /></a><!-- 2016-07-21 추가 -->
								</div>
							</div>
						</li>
					</ul>
				</li>
			</ul>

			<ul class="info_text center_res2">
				<li>
					<div>
						<span>고객센터</span>
						<span class="num">080-668-6108</span>
					</div>
					<div>
						<span><em>월요일~금요일(평일)</em>AM 9:00 ~ PM 6:00</span>
						<span><em>토요일(공휴일 휴무)</em> AM 9:00 ~ PM 1:00</span>
					</div>
				</li>
				<li>
					<div>
						<span>무통자입금 계좌번호</span>
						<span class="name">(주)쎌바이오텍 인터내셔날</span>
					</div>
					<div>
						<span><em>국민은행</em>695001-01-162988</span>
						<span><em>신한은행</em>140-007-363942</span>
					</div>
				</li>
			</ul>
		</div>
	</div>

</body>