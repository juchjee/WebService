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
			<h3><img src="/common/images/tit/h3_tit6_3.png" alt="아이디 찾기"></h3>
			<div class="chk">
				<ul class="union_agree">
					<li>아이디가 기억나지 않으실 경우 <span>본인인증 확인 후 확인</span>이 가능합니다.
					</li>
					<li>아래의 인증방법 중 한가지를 선택해 주십시오.</li>
				</ul>
				<div class="confirm_box">
					<div class="phone">
						<span class="text_box"> <span>휴대폰으로 인증하기</span>
							<p>
								본인 명의의 휴대전화을 통해<br />인증을 확인하여 정보가 제공됩니다.
							</p>
						</span> <input type="radio" name="auth_type" id="conhp" value="hp" checked="checked"/><label for="conhp">휴대폰인증</label>
					</div>

					<div class="ipin">
						<span class="text_box"> <span>I-PIN으로 인증하기</span>
							<p>
								본인 명의의 아이핀 계정을 통해<br />인증을 확인하여 정보가 제공됩니다.
							</p>
						</span> <input type="radio" name="auth_type" id="conipin" value="ipin" /><label for="conipin">아이핀 인증</label>
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
				var _val = $('input:radio[name="auth_type"]:checked').val();
				if(_val== "hp"){
					window.open('checkPlusMain.action?param_r1=id', 'popup', 'width=500, height=461, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
					//window.open('checkPlusSuccessTest.action?param_r1=id', 'popup', 'width=500, height=461, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				}else if(_val== "ipin"){
					window.open('checkIpinMain.action?param_r1=id', 'popup', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
					//window.open('checkIpinProcessTest.action?param_r1=id', 'popup', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
				}
			});
		})();
	//-->
	</script>
</body>