<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<style type="text/css">
		.access .input_box > input[type="button"] {width:29%;}
	</style>
	<script type="text/javascript" defer="defer">
	<!--

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
		function guest_buy() {
			location.href=mallFullUri + "order/payClause.do";
		}

		function actionGuestLogin() {
			var orderNo = $(document.f.orderNo).val().length;
			var nonPw = $(document.f.nonPw).val().length;
			if(orderNo == 0){
				alert("주문번호를 입력하세요");
				$(document.f.orderNo).focus();
				return false;
			}
			else if (orderNo < 12 || orderNo > 12) {
 				alert("주문번호는 12자리입니다.");
 				$(document.f.orderNo).focus();
 				return false;
 			}
			if(nonPw == 0){
				alert("비밀번호를 입력하세요");
				$(document.f.nonPw).focus();
				return false;
			}else if (nonPw < 4 || nonPw > 16) {
				alert("패스워드는 4~16자까지만 입력 가능합니다.");
				$(document.f.nonPw).focus();
				return false;
			}
	        document.f.action="${actionGuestLoginUri}";
	        document.f.submit();
		}
	//-->
</script>
<script type="text/javascript">
	$(document).ready(function() {
		$("#nonPw").bind("keyup",function(){
			var spcWord = /[~!@\#$%^&*\()\-=+_']/gi;
			var wordChk = $("#nonPw").val();

			//특수문자가 포함되면 특수문자 삭제
			if(spcWord.test(wordChk)){
				alert("특수문자는 입력하실 수 없습니다");
				$("#nonPw").val(wordChk.replace(spcWord, ""));
			}
		});
	});
</script>
</head>
<body>
	<div id="container" class="access">
		  	<!--=============== #CONNTENTS ===============-->
			<div id="contents" class="inner">
				<h3><img src="/common/images/tit/h3_tit6_1.png" alt="로그인"></h3>
				<div class="login_wrap">
					<div class="login">
						<span>
							<strong>회원 로그인</strong>
							<p>가입하신 아이디와 비밀번호를 입력해주세요.<br />비밀번호는 대소문자를 구분합니다.</p>
						</span>
						<form name="loginForm" method="post">
<!-- 							<div style="visibility:hidden;display:none;"> -->
<!-- 				                <input name="iptSubmit1" type="submit" value="전송" title="전송" /> -->
<!-- 				            </div> -->
							<div class="input_box">
								<div>
									<input type="text" name="mbrId" id="mbrId" class="dl_input" required='true!아이디를 입력해주세요' maxlength="16" placeholder="아이디"  tabindex="1" value="${mbrId}"   onkeydown="keydown(1);" autocomplete="off" />
									<input type="password" name="mbrPw" id="mbrPw"  class="dl_input" required="true!비밀번호를 입력해주세요" maxlength="25" placeholder="비밀번호" tabindex="2"  value=""  onkeydown="keydown(1);" autocomplete="off" />
								</div>
								<!-- <input type="image" src="${rootUri}common/img/icon/login_btn.png" alt="로그인" onClick="actionLogin()"/> -->
								<input type="button"  style="float: right;-webkit-border-radius:2px;-webkit-appearance:none;" class="btn12" value="로그인" onClick="actionLogin()" />
							</div>
							<label><input type="checkbox" name="saveIdCookie" id="saveIdCookie"<c:if test="${!empty mbrId}"> checked="checked"</c:if>> 아이디 저장</label>
							<c:forEach var="entry" items="${param}" varStatus="status">
								<input type="hidden" name="${entry.key}" value="${entry.value}">
							</c:forEach>
						</form>
					</div>

					<div class="nonlogin">
						<c:if test="${isOrder}">
						<span>
							<strong>비회원 주문하기</strong>
							<p>비회원으로 구매서비스를 이용하시려면 <em>비회원구매 개인정보 수집/이용 동의</em>를 하셔야 합니다.<br /><em>다음 단계로 이동</em> 버튼을 클릭해 주십시오.<br/>비회원으로 구매하실 경우 듀오락에서 드리는 쿠폰 사용 및 포인트 적립 등의<br />혜택은 받으실 수 없습니다. </p>
						</span>
						<div class="input_box">
							<a href="javascript:;" onclick="guest_buy()" class="btn05">다음 단계로</a>
						</div>
						</c:if>
						<c:if test="${!isOrder}">
						<span>
							<strong>비회원 주문조회</strong>
							<p>주문번호와 비밀번호를 입력해주세요.<br />비밀번호는 대소문자를 구분합니다.</p>
						</span>
						<form name="f" method="post" >
							<!-- <input type="hidden" name="refer_url" value="/user/order.asp"> -->
						<div class="input_box">
							<div>
								<input type="text" class="validation[numberOnlyLeft]" id="orderNo" name="orderNo" class="dl_input" placeholder="주문번호" maxlength="30"  onkeydown="keydown(2);" autocomplete="off" />
								<input type="password" id="nonPw" name="nonPw" class="dl_input" placeholder="비밀번호"   onkeydown="keydown(2);" autocomplete="off" />
							</div>
							<!-- <input type="image" src="${rootUri}common/img/icon/nonlogin_btn.png" alt="비회원 주문 조회하기" /> -->
							<input type="button"  style="float: right;-webkit-border-radius:2px;-webkit-appearance:none;" class="btn12_1" value="조회하기" onClick="actionGuestLogin();"/>
						</div>
						</form>
						</c:if>
					</div>
				</div>

				<div class="login_info">
					<div class="search_lo">
						<div>
							<span>기억나지 않는 아이디와 비밀번호를<br />조회해 보실 수 있습니다.</span>
						 	<a href="${conUrl}searchId.do" class="btn04">아이디찿기</a>
						 	<a href="${conUrl}searchPassword.do" class="btn04">비밀번호찿기</a>
						</div>
					</div>
					<div class="join_lo">
						<div>
							<span>회원가입을 하면<br />포인트적립 등 다양한 혜택을<br />누리실 수 있습니다.</span>

							<a href="join.do" class="btn03">회원가입</a>
						</div>
					</div>
				</div>

				<a href="/ISDS/etc/etc.do?pageCd=SFM00406">
					<c:if test="${iConstant.isMobile(pageContext.request)}">
						<div style="text-align:center;"><img src="${rootUri}common/img/m_member_class_login.jpg"  style="padding-top:30px;"></div>
					</c:if>
					<c:if test="${!iConstant.isMobile(pageContext.request)}">
						<img src="${rootUri}common/img/member_class_login.jpg"  style="padding-top:30px;">
					</c:if>
				</a>
				<div>
				</div>
			</div>
			<!--=============== #CONNTENTS ===============-->
		</div>
</body>