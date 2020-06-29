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
		<div id="contents" class="inner" style="max-width: 1001px;">
			<h3><img src="/common/images/tit/h3_tit5_7.png" alt="패밀리 멤버십"></h3>

			<ul class="center_info">
				<li>
					<div class="fm_large"><img src="${rootUri}common/img/membership_01.jpg"></div>
					<div class="fm_small">
						<div>
							<span style="font-size:18px;font-weight:400;color:#3d3e72;display:none;">DUOLAC 패밀리 맴버십<br></span>
							<span style="font-size:18px;font-weight:400;color:#3d3e72;">듀오락 <b>패밀리 멤버십 혜택</b><br><br></span>
							DUOLAC 쇼핑몰 회원들에게만 제공되는<br>
							<span style="font-weight:400;color:#3d3e72;">'DUOLAC Family Membership'<br></span>
							듀오락을 사랑해 주시는 고객님을 위해 멤버십 등급에 따라 쇼핑몰 상시 할인, 등급 UP 축하 쿠폰, 추가 상품제공 등의 다양하고 풍선한 혜택을 감사의 마음으로 드리는 고객혜택 서비스입니다.
						</div>
						<div class="membership">
							<ul>
								<li>
									<a href="#bronze"><img src="${rootUri}common/img/bronze_off.png"></a>
									<a href="#bronze" class="on"><img src="${rootUri}common/img/bronze_on.png"></a>
								</li>
								<li>
									<a href="#silver" class="on"><img src="${rootUri}common/img/silver_off.png"></a>
									<a href="#silver"><img src="${rootUri}common/img/silver_on.png"></a>
								</li>
								<li>
									<a href="#gold" class="on"><img src="${rootUri}common/img/gold_off.png"></a>
									<a href="#gold"><img src="${rootUri}common/img/gold_on.png"></a>
								</li>
								<li>
									<a href="#vip" class="on"><img src="${rootUri}common/img/vip_off.png"></a>
									<a href="#vip"><img src="${rootUri}common/img/vip_on.png"></a>
								</li>
								<li>
									<a href="#vvip" class="on"><img src="${rootUri}common/img/vvip_off.png"></a>
									<a href="#vvip"><img src="${rootUri}common/img/vvip_on.png"></a>
								</li>
							</ul>
							<div>
								<img src="${rootUri}common/img/m_bronze_screen.png" class="on">
								<img src="${rootUri}common/img/m_silver_screen.png">
								<img src="${rootUri}common/img/m_gold_screen.png">
								<img src="${rootUri}common/img/m_vip_screen.png">
								<img src="${rootUri}common/img/m_vvip_screen.png">
							</div>
						</div>
					</div>
				</li>
			<li>
				<ul>
					<li>
						<span>&diams; 듀오락몰 패밀리 멤버십 등급 선정 기준 안내</span>
					</li>
					<li>듀오락 패밀리 멤버십 등급은 매월 5일 선정됩니다.</li>
					<li>멤버십 등급 선정 실적 기준은 선정 월 직전 말일까지의 발송완료 처리된 주문 실적을 반영합니다.(취소/반품 시 제외)</li>
					<li>부당한 방법으로 듀오락 패밀리 멤버십 등급을 획득 시 심사 후 등급 제외 및 재조정 될 수 있습니다.</li>
				</ul>
			</li>
			<li>
				<ul>
					<li>
						<span>&diams; 등급별 혜택 세부사항</span>
					</li>
					<li>주문 취소시 주문 취소 완료 후에 쿠폰은 복원됩니다.</li>
					<li>등급 업 쿠폰은 해당 등급으로 상향 진입 최초 1회 한정하여 증정됩니다.</li>
					<li>등급 하락 후 동일 등급으로 재 등급 UP 시에는 축하 쿠폰 미 발행(생일 축하 쿠폰은 이전에 미 발행 시에만 발행함)</li>
					<li>상시 할인은 상시 할인 등급에 해당하실 경우 할인 받으실 수 있습니다.</li>
					<li>우수고객에게 드리는 고객 초청행사 및 신제품 개발 정보 공유, 방문 상담 서비스 등은 비정기적으로 운영되며 오픈 시 해당되시는 등급 회원들에게 당사 SMS 마케팅 수신 동의를 해주신 고객에 한해 일부 선정하여 공지 드리겠습니다.</li>
					<li>스페셜혜택 해당 상품에 대한 포인트 제공 후 제품으로 전환제공합니다.
	  듀오락몰(PC버전)에 로그인 후 지정된 기한내에 신청하신분에 한하여 발송됩니다. 관련 내용은 개별 문자를 통하여 확인하여 주시기 바랍니다.  </li>
					<li>문자 수신 거부 시에는 신청안내를 받지 못하시오니 회원정보에서 듀오락 쇼핑몰 이벤트 수신동의를 확인하여주시기 바랍니다. </li>
					<li>각 혜택은 당사의 사정에 따라 변경 또는 중지 될 수 있습니다.</li>
				</ul>
			</li>
			<li>
				<ul>
					<li>
						<span>&diams; 쿠폰 별 발행 시기 및 사용 기간</span>
					</li>
					<li>등급 UP 쿠폰: 등급 상향 일 10시 부터 사용 가능, 사용기간(60일)</li>
					<li>생일 축하 쿠폰: 생일 7일 전부터 사용 가능, 사용기간(30일)</li>
					<li>신규 가입 축하 쿠폰: 신규 가입과 동시에 지급, 구매 시 바로 사용 가능, 2016/1/5일 이후 신규 가입자에 한함, 사용기간: 30일</li>
					<li>첫 구매 감사 쿠폰: 듀오락 몰 가입 후 첫 구매 해당 고객에게 지급, 첫 구매 당일 발송 완료된 건에 한하여 5시에 일괄 지급, 두 번째 구매 시 부터 사용 가능, 사용기간(60일)</li>
				</ul>
			</li>
<!-- 		<li>
				<ul>
					<li>
						<span>&diams; 적립금 전환 쿠폰 안내</span>
					</li>
					<li>2016년 듀오락 패밀리 멤버십 서비스가 신규 오픈 됨에 따라 듀오락 쇼핑몰의 적립금 제도는 2015년 12월 31일까지 운영되고 종료 되었습니다.</li>
					<li>2015년 12월 31일까지 누적된 적립금은 적립금 구간별로 2016년 적립금 할인 쿠폰으로 발행되었습니다.</li>
					<li>적립금 쿠폰은 듀오락몰의 마이페이지에서 확인하실 수 있으면 구매시 쿠폰을 이용하여 구매하실 수 있습니다.(구매 건 별 쿠폰 1회)</li>
					<li>쿠폰은 구매 건수별로 1회 한정입니다.(주문 취소시에는 주문 취소완효 후에 쿠폰 복원)</li>
					<li>적립금 쿠폰은 유효 기간 (2016년 12월 31일) 내에 사용하지 않으면 소멸됩니다.</li>
				</ul>
			</li>
 -->
			</ul>
		</div>
	</div>

</body>