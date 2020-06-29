<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
</head>
<body>
	<!--=============== #CONTAINER ===============-->
	<div id="container" class="clause">
	  	<!--=============== #CONNTENTS ===============-->
		<div id="contents" class="inner">
			<h3><img src="/common/images/tit/h3_tit6_2.png" alt="회원가입"></h3>
			<ul class="step">
				<li class="step01 on"><span><em>STEP 01</em>본인인증</span></li>
				<li class="step02"><span><em>STEP 02</em>정보입력</span></li>
				<li class="step03"><span><em>STEP 03</em>가입완료</span></li>
			</ul>
			<div class="top_info">
				<ul>
					<li>듀오락 온라인 스토어를 이용하기 위해서 소정의 회원가입절차를 거치셔야 합니다.</li>
					<li>가입하시기 전 반드시 <a href="/ISDS/rules/service.do">이용약관</a>과 <a href="/ISDS/rules/privacy.do">개인정보취급방침</a>에 대한 안내를 읽어보시기 바랍니다.</li>
					<li>동의하시면 “동의” 버튼을 클릭해 주세요</li>
				</ul>
				<a class="btn02" href="javascript:;" onClick="checkAll()">전체동의</a>
				<div class="benefit">
					<span>회원가입 혜택안내</span>
					<ul style="display: none;">
						<li class="col1">
							<strong>혜택<em>1</em></strong>
							<span>듀오락 패밀리 멤버십</span>
							<p>등급별 할인<br />쿠폰, 추가혜택</p>
						</li>
						<li class="col2">
							<strong>혜택<em>2</em></strong>
							<span>포인트 지급</span>
							<p>미니제품 신청시 사용<br />가능한 포인트 지급</p>
						</li>
						<li class="col3">
							<strong>혜택<em>3</em></strong>
							<span>추가혜택 제공</span>
							<p>연간 구매 금액에 따라<br />상품권 등 추가혜택 제공</p>
						</li>
						<li class="col4">
							<strong>혜택<em>4</em></strong>
							<span>우선 참여</span>
							<p>각종 행사 및 이벤트 시<br />우선적으로 참여</p>
						</li>
					</ul>
				</div>
			</div>
			<div class="info_cont">
				<strong class="title_text">이용약관 동의</strong>
				<div class="info_text">
					<c:import url="/WEB-INF/jsp/site/ISDS/comm/agreement.jsp" />
				</div>
				<input type="checkbox" name="agree01" id="yes01" value="1" /><label for="yes01">이용약관에 동의합니다</label>
			</div>

			<div class="info_cont">
				<strong class="title_text title_clause1">개인정보 수집/이용 동의
					<span><a class="btn02" href="/ISDS/rules/privacy.do">개인정보취급방침 전체보기</a></span>
				</strong><!-- 2016 수정 -->
				<div class="info_text">
					<c:import url="/WEB-INF/jsp/site/ISDS/comm/privacy.jsp" />
				</div>
                <p style="color:red;">[필수] 듀오락몰 서비스 제공을 위해서 필요한 최소한의 개인정보이므로 동의를 해주셔야 서비스를 이용하실 수 있습니다.</p>
                <input type="checkbox" name="agree03" id="yes03" value="1" /><label for="yes03"> 개인정보 수집/이용에 동의합니다.</label>
			</div>
			<div class="confirm">
				<ul class="union_agree">
					<li>당사이트는 회원 여러분의 <span>개인정보보호를 위해 최선</span>을 다하고 있습니다.</li>
					<li>당사이트에서는 원활한 서비스 이용과 익명사용자로 인한 명예훼손 등의 피해를 방지하기 위해 <span>실명제를 원칙</span>으로 하고 있습니다.</li>
					<li>관련 법률에 따라 듀오락몰은 <span>주민등록번호를 수집</span>하지 않습니다.</li>
					<li>당사이트의 본인인증은 <span>(주)NICE 신용평가정보</span>를 통해 이루어집니다.</li>
					<li>본인인증이 불가능한 경우 <span>(주)NICE 신용평가정보 개인실명등록 콜센터(1600-1522)</span>로 문의해 주시기 바랍니다.</li>
				</ul>

				<strong class="title_text">가입여부 확인 및 본인인증</strong>
				<div class="confirm_box">
					<div class="phone">
						<span class="text_box">
							<span>휴대폰 인증하기</span>
							<p>본인 명의의 휴대전화을 통해 인증을 확인하여 정보가 제공됩니다.</p>
						</span>
						<a class="btn03" href="javascript:fnPopup('hp');">인증하기</a>
					</div>

					<div class="ipin">
						<span class="text_box">
							<span>I-PIN 인증하기</span>
							<p>본인 명의의 아이핀 계정을 통해 인증을 확인하여 정보가 제공됩니다.</p>
						</span>
						<a class="btn03" href="javascript:fnPopup('ipin');">인증하기</a>
					</div>
				</div>
			</div>
		</div>
		<!--=============== #CONNTENTS ===============-->
	</div>
	<script type="text/javascript">
		function fnPopup(val){
			var obj=document.f;
			if($('input:checkbox[name="agree01"]').is(":checked") != true){
				alert("이용약관에 동의하셔야 가입이 가능합니다");
				$('input:checkbox[name="agree01"]').focus();
				return;
			}
			if ($('input:checkbox[name="agree03"]').is(":checked") != true){
			    alert("개인정보 수집/이용에 동의하셔야 가입이 가능합니다");
			    $('input:checkbox[name="agree03"]').focus();
			    return;
			}
			$("#conFlag").val(val);
			if(val=="hp"){
				window.open('checkPlusMain.action?param_r1=join', 'popup', 'width=500, height=461, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}else{
				window.open('checkIpinMain.action?param_r1=join', 'popup', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}
		}
	</script>
</body>