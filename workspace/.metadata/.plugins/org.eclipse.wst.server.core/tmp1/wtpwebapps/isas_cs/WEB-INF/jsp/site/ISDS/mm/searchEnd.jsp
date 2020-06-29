<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<script type="text/javascript">

function init(){
	fnEvent();
}

function fnEvent(){

	/* 비밀번호 변경 이벤트 */
	fnMbrPwChange = function(){

		var mbrId = frmUpdate.mbrId.value;
		var mbrPwNew = frmUpdate.mbrPwNew;
		var mbrPwNewR = frmUpdate.mbrPwNewR;
		if(mbrPwNew.value.length == 0 || mbrPwNew.value == ""){
			alert("새 비밀번호를 입력해 주십시오.");
			mbrPwNew.focus();
			return false;
		}
		if(mbrPwNewR.value.length == 0 || mbrPwNewR.value == ""){
			alert("새 비밀번호를 입력해 주십시오.");
			mbrPwNewR.focus();
			return false;
		}
		if( (mbrPwNew.value.length > 0 && mbrPwNew.value != "") &&
			(mbrPwNewR.value.length > 0 && mbrPwNewR.value != "")){

			var strValue = mbrPwNew.value;
			if(CheckValue_PW(strValue)){
				strValue = mbrPwNewR.value;
				if(!CheckValue_PW(strValue)){
					return false;
				}
			}else{
				return false;
			}

			if(mbrPwNew.value != mbrPwNewR.value){
				alert("입력된 두개의 패스워드가 틀립니다.");
				mbrPwNewR.focus();
				return false;
			}else{
				 /* fnAjax("${rootUri}${conUrl}ISDS/mm/newPwSave.action", {"mbrId":mbrId,"mbrPwNew":mbrPwNew.value,"mbrPwNewR":mbrPwNewR.value},
					function(data, dataType){
						if(data && data.message && data.updateYn){
							alert(data.message);
							if(data.updateYn == "Y"){
								$("#pwUl").html("");
								$("#pwUl").html("<li>비밀번호가 변경되었습니다.</li>");
							}
						}else{
							alert("요청 중 문제가 발생했습니다.");
						}

				 	}
				 ); */
				 fnAjax("${rootUri}${conUrl}ISDS/mm/newPwSave.action", {"mbrId":mbrId,"mbrPwNew":encodeURIComponent(encodeURIComponent(mbrPwNew.value)),"mbrPwNewR":encodeURIComponent(encodeURIComponent(mbrPwNewR.value))},
					function(data, dataType){
						if(data && data.message && data.updateYn){
							alert(data.message);
							if(data.updateYn == "Y"){
								$("#pwUl").html("");
								$("#pwUl").html("<li>비밀번호가 변경되었습니다.</li>");
							}
						}else{
							alert("요청 중 문제가 발생했습니다.");
						}

				 	}
				 );
			}
		}

	}

}

/* 비밀번호 변경 이벤트 */
function CheckValue_PW(strValue) {
	var mbrId = frmUpdate.mbrId.value;
    var strReg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).*$/;
    if (!strReg.test(strValue)) {
    	alert('패스워드는 영문,숫자,특수문자를 조합 해야합니다.');
        return false;
    }
    if (strValue.length < 8 || strValue.length > 15) {
        alert('패스워드는 8~15자까지만 입력이 가능합니다.');
        return false;
    }
    if(mbrId == strValue){
		alert("아이디와 비밀번호는 같을 수 없습니다")
		return false;
	}
    return true;
}

</script>
</head>
<body>
	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">아이디/비밀번호 찾기</h2>
			<div class="txt_bx log mt50">
				<p>아이디/비밀번호가 기억나지 않으세요?<br>휴대폰/아이핀 인증으로 찾을 수 있습니다.</p>
			</div>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">아이디/비밀번호 찾기</a></li>
					<li class="last"><a href="#">로그인</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->

		<div id="box_tabs" class="mb200">
			<div class="wrap_tabs find">
				<ul class="tabs">
					<c:choose>
						<c:when test="${param_r1 eq 'id'}">
							<li class="active" rel="tab1"><div class="on">아이디찾기</div></li>
							<li rel="tab2" onclick="location.href='/ISDS/mm/searchPassword.do'"><div class="on">비밀번호찾기</div></li>
						</c:when>
						<c:when test="${param_r1 eq 'pwd'}">
							<li rel="tab1" onclick="location.href='/ISDS/mm/searchId.do'"><div class="on">아이디찾기</div></li>
							<li class="active" rel="tab2"><div class="on">비밀번호찾기</div></li>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
				</ul>
			</div>
			<div class="tab_container">
				<c:choose>
					<c:when test="${param_r1 eq 'id'}">
					<!-- 아이디 찾기 START -->
						<div id="tab1" class="tab_content" style="display: block;">
							<div class="find_bx">
								<c:if test='${param_r1 eq "id"}'>
									<c:if test="${!empty mbrId}">
										<p><strong>${mbrNm}</strong>님의 아이디는<strong class="f_blue">${mbrId}</strong>입니다.</p>
										<p><c:if test='${loginStatusH}'>현재 고객님은 휴면계정 상태입니다.</c:if></p>
									</c:if>
									<c:if test="${empty mbrId}">
										<p>입력된 정보와 일치하는 회원정보가 없습니다.</p><br />
										<p>확인 후 다시 입력해 주세요.</p>
									</c:if>
								</c:if>
								<div class="btnAreaW mt100">
									<a href="/ISDS/mm/searchPassword.do" class="btn btn01Type">비밀번호 찾기</a>
									<a href="/ISDS/mm/acessLogin.do" class="btn btn02Type">로그인</a>
								</div>
							</div>
						</div>
					<!-- 아이디 찾기 END -->
					</c:when>
					<c:when test="${param_r1 eq 'pwd'}">
					<!-- 비밀번호 찾기 START -->
						<div id="tab2" class="tab_content" style="display: block;">
							<div class="find_bx pwfind">
								<c:if test='${param_r1 eq "pwd"}'>
									<c:if test="${!empty mbrId}">
										<form name="frmUpdate" method="post">
											<input type="hidden" name="mbrId" value="${mbrId}" />
											<ul id="pwUl">
												<li>
													<dl>
														<dt style="display:inline;">아이디 :</dt>
														<dd style="display:inline;">${mbrId}</dd>
													</dl>
												</li>
												<li>
													<dl>
														<dt>비밀번호 변경</dt>
														<dd style="padding-top:10px;">
															<div><input type="password" id="mbrPwNew" name="mbrPwNew" placeholder="새 비밀번호" style="display:block;width:307px"></div>
															<div><input type="password" id="mbrPwNewR" placeholder="새 비밀번호 확인" style="display:block;margin-top:10px;width:307px"></div>
															<div><a href="#" class="btn btn01Type" id="btnMbrPw" onclick="fnMbrPwChange(); return false;">비밀번호 변경</a></div>
														</dd>
													</dl>
												</li>
											</ul>
											<div class="btnAreaW mt50">
												<a href="/ISDS/mm/acessLogin.do" class="btn btn02Type">로그인</a>
											</div>
										</form>
									</c:if>
									<c:if test="${empty mbrId}">
										<p>입력된 정보와 일치하는 회원정보가 없습니다.</p><br />
										<p>확인 후 다시 입력해 주세요.</p>
									</c:if>
								</c:if>
							</div>
						</div>
					<!-- 비밀번호 찾기 END -->
					</c:when>
					<c:otherwise></c:otherwise>
				</c:choose>
			</div>
			<!--// tab_container -->
		</div>
		<!--// box_tabs -->
	</div>
	<!--// sub -->
</body>