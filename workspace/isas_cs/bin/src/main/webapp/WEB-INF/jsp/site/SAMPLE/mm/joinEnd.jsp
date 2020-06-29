<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--

	//-->
	</script>
</head>
<body>
	<!--=============== #CONTAINER ===============-->
	<div id="container" class="end">
	  	<!--=============== #CONNTENTS ===============-->
		<div id="contents" class="inner">
			<h3><img src="/common/images/tit/h3_tit6_2.png" alt="회원가입"></h3>

			<ul class="step">
				<li class="step01"><span><em>STEP 01</em>본인인증</span></li>
				<li class="step02"><span><em>STEP 02</em>정보입력</span></li>
				<li class="step03 on"><span><em>STEP 03</em>가입완료</span></li>
			</ul>

			<div class="cont">
				<strong><em>${mbrNm}</em>님의 <img src="${rootUri}common/img/icon/end_duolac.png"> 회원가입을 환영합니다!</strong>
				<span>아이디 <em>${mbrId}</em></span>
			</div>

			<div class="btn_wrap">
				<a class="btn01" href="${rootUri}${iConstant.get('LOGIN_PAGE')}">로그인</a>
				<a class="btn01_1" href="${iConstant.get('HOME_URL')}">메인으로</a>
			</div>
		</div>
		<!--=============== #CONNTENTS ===============-->
	</div>
	<!--=============== #CONTAINER ===============-->

	<!-- 다음 전환추적 코드 -->
	<script type="text/javascript">
	//<![CDATA[
		var DaumConversionDctSv="type=M,orderID=,amount=";
		var DaumConversionAccountID="SQmoaYzEa62TkxXhpgBKiQ00";
		if(typeof DaumConversionScriptLoaded=="undefined"&&location.protocol!="file:"){
			var DaumConversionScriptLoaded=true;
			document.write(unescape("%3Cscript%20type%3D%22text/javas"+"cript%22%20src%3D%22"+(location.protocol=="https:"?"https":"http")+"%3A//t1.daumcdn.net/cssjs/common/cts/vr200/dcts.js%22%3E%3C/script%3E"));
		}
	//]]>
	</script>
	<!-- 다음 전환추적 코드 -->
</body>
