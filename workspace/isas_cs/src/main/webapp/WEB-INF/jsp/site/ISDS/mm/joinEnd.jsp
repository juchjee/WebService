<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--
	function init(){
		$("#loginBtn").bind("click",function(){
			location.href="/ISDS/mm/acessLogin.do";
		})
	}
	//-->
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
			<li><span>STEP 2.본인인증</span></li>
			<li><span>STEP 3.정보입력</span></li>
			<li class="last on"><span>STEP 4.가입완료</span></li>
		</ol>
		<!--// join_step_bx -->

		<div class="msg_bx inquiry mt20">
			<strong>이누스 서비스센터 회원가입을 환영합니다.</strong>
		</div>
		<!--// msg_bx -->

		<div class="btnArea">
			<button id="loginBtn" class="right">로그인</button>
		</div>


	</div>
	<!--// sub -->
</body>
