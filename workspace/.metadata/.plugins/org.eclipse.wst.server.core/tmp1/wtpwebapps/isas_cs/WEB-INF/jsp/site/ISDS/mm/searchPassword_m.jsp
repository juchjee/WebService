<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
</head>
<body>
	
	<section class="sub">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>비밀번호 찾기</h2>
		</div>
		<!--// tit_bx -->
		<div class="gray_bx">
			<p class="txt">회원가입 시 사용하신 본인확인 인증수단을 선택하세요.</p>
		</div>
		<!--// gray_bx -->
		<div class="btnWrap wide pd15 mt10">
			<a href="#" class="btn gray" id="idConhp">휴대폰인증</a>
		</div>
	</section>
	<!--// sub -->
	
	<script type="text/javascript" defer="defer">
		(function(){
			$("#idConhp").click(function(){
				privteCheck("hp");
			});
		})();
		
		function privteCheck(data){
			var _val = data;
			if(_val == "hp"){
				/*★ 로컬에서 테스트 START , checkPlusSuccess.jsp*/ 
				//location.href = '/ISDS/mm/searchEnd.do?param_r1=pwd';
				/*★ 로컬에서 테스트 END*/
				//★ 운영올릴때 주석제거할곳
				window.open('checkPlusMain.action?param_r1=pwd', 'popup', 'width=500, height=461, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}
		}
	</script>
</body>