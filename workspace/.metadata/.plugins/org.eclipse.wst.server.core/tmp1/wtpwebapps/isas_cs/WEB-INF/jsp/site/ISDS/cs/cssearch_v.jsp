<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<head>
	<script type="text/javascript">

		function init(){
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

		function keydownAjax(seq) {
			  var keycode = '';
			  if(window.event) keycode = window.event.keyCode;
			 if(keycode == 13){
				 if(seq == 1){
			 	 	actionLoginAjax();
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
	        document.loginForm.action="/ISDS/mm/actionLogin.action";
	        document.loginForm.submit();
		}




	</script>
</head>
<body>

	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">예약조회</h2>
			<div class="txt_bx">
				<p class="mark">해당 게시판의 게시물은 작성자와 관리자에게만 보여집니다.</p>
				<p>궁금하신 점을 작성하시면 확인 후 답변 드리겠습니다.<br>운영시간 평일 09:00 ~ 18:00</p>
			</div>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">서비스예약</a></li>
					<li class="last"><a href="#">예약조회</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<div class="msg_bx inquiry mt20">
			<strong>서비스 예약 조회는 로그인 후 글 작성 및 확인이 가능합니다.</strong>
		</div>
		<!--// msg_bx -->

		<div class="btnArea">
			<button class="right" onclick="layerPopUp('layers');">로그인</button>
		</div>
	</div>
	<!--// sub -->

	<!-- 로그인 레이아웃 -->
	 <div class="layer">
		<form name="loginForm" method="post">

		<div class="bg"></div>
		<div id="layers" class="pop-layer">
			<div class="pop-container">
				<div class="pop-conts">
					<strong><span class="f_blue f_bold">로그인</span> 후 이용하실 수 있습니다.</strong>
					<div class="usr_bx">
						<div class="member">
							<h3>회원</h3>
							<fieldset>
								<legend>회원 로그인</legend>
								<div class="input_bx log">
									<input type="text" name="mbrId" id="mbrId" placeholder="아이디" class="id" onkeydown="keydown(1);"/>
									<input type="password" name="mbrPw" id="mbrPw" placeholder="비밀번호" class="pw mt10" onkeydown="keydown(1);"/>
									<div class="id_pw_bx">
										<ul>
											<li>
												<span class="chkbox">
													<label class="label_txt"><input type="checkbox" name="saveIdCookie" id="saveIdCookie"<c:if test="${!empty mbrId}"> checked="checked"</c:if> value="on"><span class="txt" >아이디 저장</span></label>
												</span>
											</li>
											<li>
												<a href="javascript:;">아이디/비밀번호 찾기</a>
											</li>
										</ul>
									</div>
								</div>
								<div class="btn_bx">
									<a href="javascript:;" class="btn btn02Type" onclick="actionLogin();">로그인</a>
								</div>
							</fieldset>
						</div>
						<div class="member non">
							<h3>비회원</h3>
							<fieldset>
							<div class="gray_bx">
								<p>비회원일 경우 실명인증 후 서비스예약이 가능합니다.<br>아래 휴대폰인증 버튼을 눌러주세요.</p>
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
					<a href="javascript:;" class="close_btn" >닫기</a>
				</div>
				<!--// pop_conts -->
			</div>
		</div>
		<!--// pop-layer -->
	    </form>
	 </div>
	 <!-- 로그인 레이아웃 -->

</body>