<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
		function fnPopup(val){
			if(val=="hp"){
				window.open('checkPlusMain.action?param_r1=join&certMet=M', 'popup','width=425, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}else{
				window.open('checkPlusMain.action?param_r1=join&certMet=P', 'popup', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}
		}
	</script>
</head>
<body>
	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">회원가입</h2>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li class="last"><a href="#">회원가입</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<ol class="join_step_bx">
			<li><span>STEP 1.약관동의</span></li>
			<li class="on"><span>STEP 2.본인인증</span></li>
			<li><span>STEP 3.정보입력</span></li>
			<li><span>STEP 4.가입완료</span></li>
		</ol>
		<!--// join_step_bx -->
		<div class="txtBox">
			<p>이누스 서비스센터 회원에 가입하기 위해서는 본인인증이 필요합니다.</p>
			<p>아래의 휴대폰 인증 버튼을 클릭해주세요.</p>
		</div>

		<div class="certify_bx">
			<div>
				<p>본인 명의의 휴대전화를 통해 본인 인증을 진행하실 수 있습니다.<br>본인 명의 휴대전화가 아닐 경우 인증이 되지 않습니다.<br>아래 휴대폰인증 버튼을 눌러주세요.</p>
				<a href="javascript:;" class="btn btn01Type" onclick="fnPopup('hp');">휴대폰인증</a>
			</div>
		</div>

		<dl class="note">
			<dt>본인 인증 유의사항</dt>
			<dd>개인정보를 도용하는 경우, 서비스 이용에 제한이 있을 수 있습니다.</dd>
			<dd>본인 인증에 문제가 있을 경우, 이누스 고객센터(1599-8613)로 문의해 주시기 바랍니다.</dd>
		</dl>
	</div>


	<!--// sub -->
</body>