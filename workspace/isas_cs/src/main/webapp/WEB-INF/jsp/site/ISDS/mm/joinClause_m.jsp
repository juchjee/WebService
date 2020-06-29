<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
		function fnPopup(val){
			if(val=="hp"){
				woh_open('checkPlusMain.action?param_r1=join&certMet=M', 'popup','width=425, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}else{
				woh_open('checkPlusMain.action?param_r1=join&certMet=P', 'popup', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}
		}
	</script>
</head>
<body>
	<section class="sub">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>회원가입</h2>
		</div>
		<!--// tit_bx -->
		<div class="gray_bx">
			<p class="cert_txt">본이니 명의의 휴대전화를 통해 본인 인증을<br>진행하실 수 있습니다.<br>본인 명의 휴대전화가 아닐 경우 인증이 되지 않습니다.<br>아래 휴대폰인증 버튼을 눌러주세요.</p>
		</div>
		<!--// gray_bx -->
		<div class="btnBox pd15 mt10">
			<a href="javascript:;" class="btn blue" onclick="fnPopup('hp');">휴대폰인증</a>
		</div>
	</section>
	<!--// sub -->
</body>