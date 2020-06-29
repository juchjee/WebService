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
								$("#pwDiv").html("");
								$("#pwDiv").html("<p>비밀번호가 변경되었습니다.</p>");
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
								$("#pwDiv").html("");
								$("#pwDiv").html("<p>비밀번호가 변경되었습니다.</p>");
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
	<section class="sub">
		<c:choose>
			<c:when test="${param_r1 eq 'id'}">
			<!-- 아이디 찾기 START -->
				<div class="tit_bx">
					<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
					<h2>아이디 찾기</h2>
				</div>
				<!--// tit_bx -->
				<div class="gray_bx">
					<p class="txt">회원가입 시 사용하신 본인확인 인증수단을 선택하세요.</p>
				</div>
				<!--// gray_bx -->
				<c:if test='${param_r1 eq "id"}'>
					<c:if test="${!empty mbrId}">
						<p class="find userId"><strong>${mbrNm}</strong>님의 아이디는 <strong class="fc_blue">${mbrId}</strong>입니다.</p>
						<p class="find userId"><c:if test='${loginStatusH}'>현재 고객님은 휴면계정 상태입니다.</c:if></p>
					</c:if>
					<c:if test="${empty mbrId}">
						<p class="find userId">입력된 정보와 일치하는 회원정보가 없습니다.</p><br />
						<p class="find userId">확인 후 다시 입력해 주세요.</p>
					</c:if>
				</c:if>
				<div class="btnWrap wide pd15 mt10">
					<a href="#" class="btn gray" onclick="location.href='/ISDS/mm/searchPassword.do'">비밀번호 찾기</a>
					<a href="#" class="btn blue" onclick="location.href='/ISDS/mm/acessLogin.do'">로그인</a>
				</div>
			<!-- 아이디 찾기 END -->
			</c:when>
			<c:when test="${param_r1 eq 'pwd'}">
			<!-- 비밀번호 찾기 START -->
				<div class="tit_bx">
					<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
					<h2>비밀번호 찾기</h2>
				</div>
				<!--// tit_bx -->
				<div class="gray_bx">
					<p class="txt">회원가입 시 입력하신 정보로 임시 비밀번호를 발급해 드립니다.</p>
				</div>
				<!--// gray_bx -->
				<div class="pwFind" id="pwDiv">
					<c:if test='${param_r1 eq "pwd"}'>
						<c:if test="${!empty mbrId}">
							<form name="frmUpdate" method="post">
								<input type="hidden" name="mbrId" value="${mbrId}" />
									<dl>
										<dt>아이디 :</dt>
										<dd>${mbrId}</dd>
									</dl>
									<dl class="hr">
										<dt>비밀번호 변경 :</dt>
										<dd>
											<div class="pwView">
												<input type="password" id="mbrPwNew" name="mbrPwNew" placeholder="새 비밀번호" style="display:block;width:100%;">
												<input type="password" id="mbrPwNewR" placeholder="새 비밀번호 확인" style="display:block;margin-top:10px;width:100%">
											</div>
											<a href="#" class="btn wht_btn" id="btnMbrPw" onclick="fnMbrPwChange(); return false;">비밀번호 변경</a>
										</dd>
									</dl>
							</form>
						</c:if>
						<c:if test="${empty mbrId}">
							<p class="find userId">입력된 정보와 일치하는 회원정보가 없습니다.</p><br />
							<p class="find userId">확인 후 다시 입력해 주세요.</p>
						</c:if>
					</c:if>
				</div>
				<div class="btnWrap wide pd15 mt10">
					<a href="/ISDS/mm/acessLogin.do" class="btn blue">로그인</a>
				</div>
			<!-- 비밀번호 찾기 END -->
			</c:when>
			<c:otherwise></c:otherwise>
		</c:choose>
	</section>
	<!--// sub -->
</body>