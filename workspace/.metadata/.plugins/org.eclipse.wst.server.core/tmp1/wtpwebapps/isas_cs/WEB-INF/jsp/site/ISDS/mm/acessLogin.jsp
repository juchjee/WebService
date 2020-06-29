<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<style type="text/css">
		.access .input_box > input[type="button"] {width:29%;}
		.btn02Type, .btn03Type{height:100%}
	</style>
	<script type="text/javascript" defer="defer">
	<!--
		function fnPopup(val){
			if(val=="hp"){
				window.open('/ISDS/mm/checkPlusMain.action?param_r1=cs&param_r2=cssearch&certMet=M', 'popup','width=425, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}else{
				window.open('/ISDS/mm/checkPlusMain.action?param_r1=cs&param_r2=cssearch&certMet=P', 'popup', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}
		}

		function keydown(seq) {
			var keycode = '';
			if(window.event) keycode = window.event.keyCode;
			if(keycode == 13){
				if(seq == 1){
					actionLogin();
				}
			}
			return false;
		}


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
	        document.loginForm.action="${actionLoginUri}";
	        document.loginForm.submit();
		}

		function actionGuestLogin() {
			var asNo = $(document.nonMbrFrom.asNo).val().length;
			var asPw = $(document.nonMbrFrom.asPw).val().length;
			if(asNo == 0){
				alert("접수번호를 입력하세요");
				$(document.nonMbrFrom.asNo).focus();
				return false;
			}

			if(asPw == 0){
				alert("비밀번호를 입력하세요");
				$(document.nonMbrFrom.asPw).focus();
				return false;
			}else if (asPw < 4 || asPw > 16) {
				alert("패스워드는 4~16자까지만 입력 가능합니다.");
				$(document.nonMbrFrom.asPw).focus();
				return false;
			}
	        document.nonMbrFrom.action="${actionGuestLoginUri}";
	        document.nonMbrFrom.submit();
		}
	//-->
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#asPw").bind("keyup",function(){
			var spcWord = /[~!@\#$%^&*\()\-=+_']/gi;
			var wordChk = $("#asPw").val();

			//특수문자가 포함되면 특수문자 삭제
			if(spcWord.test(wordChk)){
				alert("특수문자는 입력하실 수 없습니다");
				$("#asPw").val(wordChk.replace(spcWord, ""));
			}
		});
	});
</script>
</head>
<body>
	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">로그인</h2>
			<div class="txt_bx log mt50">
				<strong><span class="f_blue">이누스 서비스센터</span>에 오신 걸 환영합니다.</strong>
				<p>로그인하시면 보다 다양한 서비스를 이용하실 수 있습니다.</p>
			</div>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li class="last"><a href="#">로그인</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<div class="m-conts">
			<div class="usr_bx mb200">
			<div class="member">
				<h3>회원</h3>
				<fieldset>
					<legend>회원 로그인</legend>
					<form name="loginForm" method="post">
					<div class="input_bx log">
						<input type="text" name="mbrId" id="mbrId" title="아이디"  placeholder="아이디" value="${mbrId}" class="id" onkeydown="keydown(1);"/>
						<input type="password" name="mbrPw" id="mbrPw" title="비밀번호" placeholder="비밀번호" class="pw mt10" onkeydown="keydown(1);"/>
						<div class="id_pw_bx">
							<ul>
								<li>
									<span class="chkbox">
										<label class="label_txt"><input type="checkbox" name="saveIdCookie" id="saveIdCookie"<c:if test="${!empty mbrId}"> checked="checked"</c:if>><span class="txt">아이디 저장</span></label>
									</span>
								</li>
								<li>
									<a href="${conUrl}searchId.do">아이디/비밀번호 찾기</a>
								</li>
							</ul>
						</div>
					</div>
					<div class="btn_bx">
						<a href="#" class="btn btn02Type" onClick="actionLogin()" >로그인</a>
					</div>
					<c:forEach var="entry" items="${param}" varStatus="status">
						<input type="hidden" name="${entry.key}" value="${entry.value}">
					</c:forEach>
					</form>
				</fieldset>
			</div>
			<div class="member non">
				<h3>비회원</h3>
					<fieldset>
						<div class="gray_bx">
								<p style="max-height:370px;">비회원일 경우 실명인증으로 서비스를 이용 가능합니다.<br>아래 휴대폰인증 버튼을 눌러주세요.</p>
						<div class="btnWrap ac">
							<a href="javascript:;" onclick="fnPopup('hp');" class="btn btn01Type">휴대폰인증</a>
						</div>
					</div>
				</fieldset>
			</div>
			<div class="usr_info_txt">
				<p>아직 이누스 서비스센터 회원이 아니신가요?<br>회원이 되시면 보다 다양한 서비스를 이용하실 수 있습니다.</p>
				<a href="/ISDS/mm/join.do" class="btn btn03Type">회원가입</a>
			</div>
		</div>
		<!--// usr_bx -->
		</div>
	</div>
	<!--// sub -->

</body>