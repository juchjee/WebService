<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
</head>
<body>
	<!--=============== #CONTAINER ===============-->
	<div id="container" class="info_search">
		<!--=============== #CONNTENTS ===============-->
		<div id="contents" class="inner">
			<h3><img src="/common/images/tit/h3_tit6_4.png" alt="비밀번호 찾기"></h3>
			<div class="chk">
				<ul class="union_agree">
					<li>비밀번호가 기억나지 않으실 경우 본인인증 확인 후 <span>임시 비밀번호를 발급</span>해 드립니다.
					</li>
					<li>아래의 인증방법 중 한가지를 선택해 주십시오.</li>
				</ul>
				<strong>인증하기</strong>
				<div class="confirm_box">
					<div class="phone">
						<span class="text_box"> <span>휴대폰으로 인증하기</span>
							<p>
								본인 명의의 휴대전화을 통해<br />인증을 확인하여 정보가 제공됩니다.
							</p>
						</span>
						<input type="radio" name="auth_type" id="conhp" value="hp" checked="checked"/><label for="conhp">휴대폰인증</label>
					</div>
					<div class="ipin">
						<span class="text_box"> <span>I-PIN으로 인증하기</span>
							<p>
								본인 명의의 아이핀 계정을 통해<br />인증을 확인하여 정보가 제공됩니다.
							</p>
						</span>
						<input type="radio" name="auth_type" id="conipin" value="ipin" /><label for="conipin">아이핀 인증</label>
					</div>
				</div>
				<strong>임시비밀번호 받기</strong>
				<div class="confirm_box">
					<div class="email" style="display: none"><!-- display:none 이유/ 서버에서 메일발송이 안됨 cdo.message 함수 사용 불가함, 세팅 필요 -->
						<span class="text_box"> <span>이메일로 받기 </span>
							<p>
								가입시 등록하신 이메일로<br />임시 비밀번호가 발송됩니다.
							</p>
						</span>
						<input type="radio" name="send_type" id="conEmail" value="email" /><label for="conEmail">이메일로 받기</label>
					</div>
					<div class="message">
						<span class="text_box"> <span>휴대폰으로 받기</span>
							<p>
								가입시 등록하신 휴대폰 문자 메세지로<br />임시 비밀번호가 발송됩니다.
							</p>
						</span>
						<input type="radio" name="send_type" id="conSns" value="sms" checked="checked"/><label for="conSns">휴대폰으로 받기</label>
					</div>
				</div>
				<a href="javascript:;" id="btnChk" class="btn01">인증하기</a>
			</div>
		</div>
		<!--=============== #CONNTENTS ===============-->
	</div>
	<!--=============== #CONTAINER ===============-->
	<script type="text/javascript" defer="defer">
	<!--
		(function(){
			$("#btnChk").on('click', function(){
				var authType = $('input:radio[name="auth_type"]:checked').val();
				var sendType = $('input:radio[name="send_type"]:checked').val();
				if(authType== "hp"){
					window.open('checkPlusMain.action?param_r1=pwd&param_r2='+sendType, 'popup', 'width=500, height=461, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
					//window.open('checkPlusSuccessTest.action?param_r1=pwd&param_r2='+sendType, 'popup', 'width=500, height=461, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				}else if(authType== "ipin"){
					window.open('checkIpinMain.action?param_r1=pwd&param_r2='+sendType, 'popup', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
					//window.open('checkIpinProcessTest.action?param_r1=pwd&param_r2='+sendType, 'popup', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				}
			});
		})();
	//-->
	</script>
</body>