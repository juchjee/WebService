<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<style type="text/css">
		.access .input_box > input[type="button"] {width:29%;}
		.btn02Type, .btn03Type{height:100%}
	</style>
	<script type="text/javascript" defer="defer">
		function init(){

			/* CHECKBOX : 아이디 저장 */
			if("${mbrId}" != ""){
				$("#chkIdSave").addClass("on");
			}
			/* CHECKBOX : 자동로그인 */
			if("${mbrId}" != "" && "${mbrPA}" != ""){
				$("#chkAutoLoginSave").addClass("on");
			}


			$("#asPw").bind("keyup",function(){
				var spcWord = /[~!@\#$%^&*\()\-=+_']/gi;
				var wordChk = $("#asPw").val();

				//특수문자가 포함되면 특수문자 삭제
				if(spcWord.test(wordChk)){
					alert("특수문자는 입력하실 수 없습니다");
					$("#asPw").val(wordChk.replace(spcWord, ""));
				}
			});
		}

		function keydown(seq) {
		  var keycode = '';
		  if(window.event) keycode = window.event.keyCode;
		 if(keycode == 13){
			 if(seq == 1){
		 	 	actionLogin();
			 }else{
				 actionGuestLogin();
			 }
		 }
		  return false;
		}


		function actionLogin() {
			var _mbrId = $(document.loginForm.mbrId).val().length;
			var _mbrPw = $(document.loginForm.mbrPw).val().length;


			var mbrIdStr = $(document.loginForm.mbrId).val();
			var mbrPwStr = $(document.loginForm.mbrPw).val();

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


			if($("#autoLoginCookie").is(":checked")){
				//removeSessionId();
				$("saveIdCookie").val("on");
				saveSessionId(mbrIdStr,mbrPwStr,"on");
			}else{
				$("saveIdCookie").val("off");
				//saveSessionId(_mbrId,_mbrPw,"off");
	        	document.loginForm.action="${actionLoginUri}";
		        document.loginForm.submit();
			}

		}



		function savecallback(json){
			 var json = JSON.parse(json);
			   var status = json.status;
			   if(status == 0){
			        document.loginForm.action="${actionLoginUri}";
			        document.loginForm.submit();
			   }else{
				   removeSessionId();
			   }
		}


		function removecallback(json){
			 var json = JSON.parse(json);
			   var status = json.status;
			   if(status == 0){
			        document.loginForm.action="${actionLoginUri}";
			        document.loginForm.submit();
			   }
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


		function fnPopup(val){
			if(val=="hp"){
				woh_open('/ISDS/mm/checkPlusMain.action?param_r1=cs&param_r2=cssearch&certMet=M', 'popup','width=425, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}else{
				woh_open('/ISDS/mm/checkPlusMain.action?param_r1=cs&param_r2=cssearch&certMet=P', 'popup', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}
		}
</script>
</head>
<body>

	<section class="sub">
		<div class="tit_bx">
			<!-- <a href="javascript:history.back();" class="btn_prev">이전 화면</a> -->
			<a href="/ISDS/main/home.do" class="btn_prev">이전 화면</a>
			<h2>로그인</h2>
		</div>

		<form name="loginForm" method="post">

			<!--// tit_bx -->
			<div class="intro">
				<div class="wrap_tabs mt10">
					<ul class="tabs type01">
						<li class="active" rel="tab1"><div class="on">회원</div></li>
						<li rel="tab2"><div>비회원</div></li>
					</ul>
				</div>
				<div class="tab_container">
					<div id="tab1" class="tab_content">
						<div class="login_bx">
							<dl class="usr_id">
								<dt><label for="userID">이름</label></dt>
								<dd><input type="text" placeholder="아이디" class="usrID" name="mbrId" id="mbrId" maxlength="20" value="${mbrId}" /></dd>
							</dl>
							<!--// user ID -->
							<dl class="usr_pw mt15">
								<dt><label for="userPW">비밀번호</label></dt>
								<dd><input type="password" placeholder="비밀번호" class="usrPW" name="mbrPw" id="mbrPw" minlength="8" vlaue="" /></dd>
							</dl>
							<!--// user PW -->
							<div class="mt15">
								<span class="chkbox" id="chkAutoLoginSave">
									<label class="label_txt">
										<input type="checkbox" name="autoLoginCookie" id="autoLoginCookie">
										<span class="txt">자동로그인</span>
									</label>
								</span>
								<span class="chkbox" id="chkIdSave">
									<label class="label_txt">
										<input type="checkbox" name="saveIdCookie" id="saveIdCookie" <c:if test="${!empty mbrId}"> checked="checked"</c:if> >
										<span class="txt">아이디 저장</span>
									</label>
								</span>
								<a href="#none" class="btnType01 mt10" id="btnLogin" onClick="actionLogin()">로그인</a>
								<div class="btnWrap wide wht mt10 mb10">
									<a href="${conUrl}searchId.do" class="btn wht_btn">아이디 찾기</a>
									<a href="${conUrl}searchPassword.do" class="btn wht_btn">비밀번호 찾기</a>
								</div>
							</div>
							<div class="hr">
								<p class="ex">아직 이누스 서비스센터 회원이 아니신가요?<br>회원이 되시면 보다 다양한 서비스를 이용하실 수 있습니다.</p>
								<div class="btnBox mt10">
									<a href="/ISDS/mm/join.do" class="btnType02">회원가입</a>
								</div>
							</div>
						</div>
					</div>
					<!-- #tab1 -->
					<div id="tab2" class="tab_content">
						<div class="member non">
							<h3></h3>
								<fieldset>
									<div class="gray_bx">
											<p style="max-height:370px;"><br><br>비회원일 경우 실명인증으로 서비스를 이용 가능합니다.<br>아래 휴대폰인증 버튼을 눌러주세요.</p>
									<div class="btnBox pd15 mt10">
										<a href="javascript:;" class="btn blue" onclick="fnPopup('hp');">휴대폰인증</a>
									</div>
								</div>
							</fieldset>
						</div>
					</div>
					<!-- #tab1 -->
				</div>
			</div>
			<!--// intro -->

			</form>
	</section>
	<!--// sub -->


</body>