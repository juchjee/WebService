<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<script type="text/javascript" defer="defer">
		<!--
		function actionLogin() {
			var _mbrId = $(document.loginForm.mbrId).val().length;
			var _mbrPw = $(document.loginForm.mbrPw).val().length;
			if(_mbrId == 0){
				alert("아이디를 입력하세요");
				$(document.loginForm.mbrId).focus();
				return false;
			}else if (_mbrId.length < 4 || _mbrId.length > 16) {
				alert("아이디는 영문숫자조합 최소 4자에서 최대 16자까지 입력 가능합니다");
				$(document.loginForm.mbrId).focus();
				return false;
			}
			if(_mbrPw == 0){
				alert("비밀번호를 입력하세요");
				$(document.loginForm.mbrPw).focus();
				return false;
			}else if (_mbrPw.length < 4 || _mbrPw.length > 16) {
				alert("패스워드는 4~16자까지만 입력 가능합니다.");
				$(document.loginForm.mbrPw).focus();
				return false;
			}
		    document.loginForm.action="unlockLoginProc.do";
		    return true;
		}
	//-->
	</script>
</head>
<body>
	<!--=============== #CONTAINER ===============-->
	<div id="container" class="access">
		<!--=============== #CONNTENTS ===============-->
		<div id="contents" class="inner">
			<h3>휴면계정 해제</h3>
			<div style="border-top: 2px solid #d1d1d1; border-bottom: 2px solid #d1d1d1; padding: 45px 30px 75px;">
				<div>
					<span> <strong>현재 고객님은 휴면계정 상태입니다.</strong>
						<p><c:out value="${mbrId}" />님의 계정은 1년동안 로그인하지 않은 관계로 휴면상태 입니다.<br />아래의 입력란에 "비밀번호"를 입력하시면 휴면계정이 해제되어 회원님의 계정으로 다시 이용하실 수 있습니다.</p>
					</span>
					<form name="loginForm" action="" method="post" onsubmit="return actionLogin();">
						<c:forEach var="entry" items="${param}" varStatus="status">
							<input type="hidden" name="${entry.key}" value="${entry.value}">
						</c:forEach>
						<div style="margin-bottom: 20px;" class="input_box">
							<div>
								<input type="text" name="mbrId" id="mbrId" class="dl_input" required='true!아이디를 입력해주세요' placeholder="아이디" maxlength="16" tabindex="1" value="${mbrId}" />
								<!--charlength="4-16!영문숫자조합 최소 4자에서 최대 16자까지 입력 가능합니다"-->
								<input type="password" name="mbrPw" id="mbrPw" class="dl_input" required="true!비밀번호를 입력해주세요" placeholder="비밀번호" tabindex="2" />
								<!--charlength="4-16!패스워드는 4~16자까지만 입력 가능합니다."-->
							</div>
							<input style="float: left; margin-left: 10px;" type="image" src="${rootUri}common/img/icon/login_btn.png" alt="로그인" />
						</div>
					</form>
					<div>
						<a class="btn04" href="searchPassword.do">비밀번호찿기</a>
					</div>
				</div>
			</div>
		</div>
		<!--=============== #CONNTENTS ===============-->
	</div>
	<!--=============== #CONTAINER ===============-->
</body>
</html>
