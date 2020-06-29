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
			<h3><c:if test='${param_r1 eq "pwd"}'>비밀번호</c:if><c:if test='${param_r1 eq "id"}'>아이디</c:if> 찾기</h3>
			<ul class="union_agree">
				<li>듀오락 아이디가 없으신 분은 <a href="join.do"><회원가입> 후 이용</a>하실 수 있습니다. 회원으로 가입하시면 듀오락만의 차별화된 서비스와 다양한 혜택을 누리실 수 있습니다.</li>
				<li>회원가입은 무료이며, 모든 회원정보는 <a href="#">개인정보보호정책</a>에 의해 안전하게 보호됩니다.</li>
			</ul>
		<c:if test='${param_r1 eq "pwd"}'>
			<c:if test="${!empty mbrId}">
				<div class="cont">
					<strong>회원가입때 입력하신 <span><c:if test='${param_r2 eq "sms"}'>휴대폰으로</c:if><c:if test='${param_r2 eq "email"}'>메일로</c:if></span> <img src="${rootUri}common/img/icon/end_duolac.png"> 비밀번호를 보내드렸습니다.</strong>
					<span><c:if test='${!loginStatusH}'>로그인 후 이용해 주시기 바랍니다.</c:if><c:if test='${loginStatusH}'>현재 고객님은 휴면계정 상태입니다. 휴면계정 해제 페이지에서 로그인 후 이용해 주시기 바랍니다.</c:if></span>
				</div>
				<div class="btn_wrap"  style="width:200px;">
					<a class="btn01" href="${loginStatusURL}">로그인</a>
				</div>
			</c:if>
			<c:if test="${empty mbrId}">
				<div class="cont">
					<strong>입력된 정보와 일치하는 회원정보가 없습니다.<br />확인 후 다시 입력해 주세요.</strong>
				</div>
				<div class="btn_wrap">
					<a class="btn01" href="searchPassword.do">비밀번호 다시 찾기</a>
					<a class="btn01_1" href="join.do">회원가입</a>
				</div>
			</c:if>
		</c:if>
		<c:if test='${param_r1 eq "id"}'>
			<c:if test="${!empty mbrId}">
				<div class="cont">
					<strong><em>${mbrNm}</em>님의 <img src="${rootUri}common/img/icon/end_duolac.png"> 아이디는 <em>${mbrId}</em>입니다.</strong>
					<span><c:if test='${!loginStatusH}'>로그인 후 이용해 주시기 바랍니다.</c:if><c:if test='${loginStatusH}'>현재 고객님은 휴면계정 상태입니다. 휴면계정 해제 페이지에서 로그인 후 이용해 주시기 바랍니다.</c:if></span>
				</div>
				<div class="btn_wrap">
					<a class="btn01" href="${loginStatusURL}">로그인</a>
					<a class="btn01_1" href="searchPassword.do">비밀번호찾기</a>
				</div>
			</c:if>
			<c:if test="${empty mbrId}">
				<div class="cont">
					<strong>입력된 정보와 일치하는 회원정보가 없습니다.<br />확인 후 다시 입력해 주세요.</strong>
				</div>
				<div class="btn_wrap">
					<a class="btn01" href="searchId.do">아이디 다시 찾기</a>
					<a class="btn01_1" href="join.do">회원가입</a>
				</div>
			</c:if>
		</c:if>
		</div>
		<!--=============== #CONNTENTS ===============-->
	</div>
	<!--=============== #CONTAINER ===============-->
</body>