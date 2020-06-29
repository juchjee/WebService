<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<head>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javascript">
$(document).ready(function() {
	// 선택된 topmenu 적용
	var obj = $(".gnb > ul >li > a")[1];
	$(obj).addClass("on");

	/** 주소 찾기 **/
	$(".addrS").click(function(){
		new daum.Postcode({
	        oncomplete: function(data) {
	        	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var fullAddr = ''; // 최종 주소 변수
                var extraAddr = ''; // 조합형 주소 변수

                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    fullAddr = data.roadAddress;

                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    fullAddr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                if(data.userSelectedType === 'R'){
                    //법정동명이 있을 경우 추가한다.
                    if(data.bname !== ''){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있을 경우 추가한다.
                    if(data.buildingName !== ''){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                    extraAddr = (extraAddr !== '' ? '('+ extraAddr +') ' : '');
                }

                // 우편번호와 주소 정보를 해당 필드에 넣는다.
                document.getElementById('mbrZipcode').value = data.zonecode; //5자리 새우편번호 사용
                document.getElementById('mbrAddr').value = fullAddr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById('mbrAddrDtl').value = extraAddr;
                document.getElementById('mbrAddrDtl').focus();

	        }
	    }).open();
	});
	/* 주소찾기 END */

	/* 수정된 회원정보 저장 */
	$(".userInfoSubmit").click(function(){

		//VALIDATION
		if(!checkForm()){
			return false;
		}
		
		$("#frmUserInfo").attr("action", "amM1022Save.action");
		fnSubmit("frmUserInfo", "변경된 내용을 저장");
	}); /* 수정된 회원정보 저장 END */
	

});

/* 이메일 직접입력 선택 이벤트 */
function change_email(value){
	document.frmUserInfo.mbrEmail2.value="";
	document.frmUserInfo.mbrEmail2.value=value;
}

function checkForm() {
	
	//휴대폰번호
	var mbrMobile1 = $.trim(document.frmUserInfo.mbrMobile1.value);
	var mbrMobile2 = $.trim(document.frmUserInfo.mbrMobile2.value);
	var mbrMobile3 = $.trim(document.frmUserInfo.mbrMobile3.value);
	if(mbrMobile1 == ""){
		alert("<spring:message code="cop.mbtlNum.first" />");
		$(document.frmUserInfo.mbrMobile1).focus();
		return false;
	}
	if(mbrMobile2 == ""){
		alert("<spring:message code="cop.mbtlNum.second" />");
		$(document.frmUserInfo.mbrMobile2).focus();
		return false;
	}
	if(mbrMobile3 == ""){
		alert("<spring:message code="cop.mbtlNum.third" />");
		$(document.frmUserInfo.mbrMobile3).focus();
		return false;
	}
	
	
	//전화번호
	var mbrPhone1 = $.trim(document.frmUserInfo.mbrPhone1.value);
	var mbrPhone2 = $.trim(document.frmUserInfo.mbrPhone2.value);
	var mbrPhone3 = $.trim(document.frmUserInfo.mbrPhone3.value);
	if(mbrPhone1 != "" || mbrPhone2 != "" || mbrPhone3 !=""){
		if(mbrPhone1 == ""){
			alert("<spring:message code="cop.phoneNum.first" />");
			$(document.frmUserInfo.mbrPhone1).focus();
			return false;
		}
		if(mbrPhone2 == ""){
			alert("<spring:message code="cop.phoneNum.second" />");
			$(document.frmUserInfo.mbrPhone2).focus();
			return false;
		}
		if(mbrPhone3 == ""){
			alert("<spring:message code="cop.phoneNum.third" />");
			$(document.frmUserInfo.mbrPhone3).focus();
			return false;
		}
	}
	
	//주소
	if (document.frmUserInfo.mbrZipcode.value == '' || document.frmUserInfo.mbrAddr.value == '') {
	    alert("주소를 검색하여 입력해 주십시오.");
	    $("#addrBtn").focus();
	    return false;
	}
	if ($.trim(document.frmUserInfo.mbrAddrDtl.value) == ''){
	    if (!confirm("상세주소가 없으십니까?")) {
	    	document.frmUserInfo.mbrAddrDtl.focus();
	    	return false;
	    }
	}
	
	//이메일
	var email_str = document.frmUserInfo.mbrEmail1.value+"@"+document.frmUserInfo.mbrEmail2.value;
	if (!emailCheck(email_str)) {
		return false;
	}
	document.frmUserInfo.mbrEmail.value =  email_str;
	
	return true;
}

</script>
</head>
<body class="noBg">
	<div class="member_detail_con">
	<form id="frmUserInfo" name="frmUserInfo" method="post">
		<h2>회원정보 수정</h2>
		<!-- <div style="float:left;"><h3>회원 정보 수정</h3></div> -->
		<div style="float:right;"><a class="btn_type1 marL10 userInfoSubmit" href="#">저장</a></div>
		<div class="table_type2">
		<input type="hidden" name="mbrId" value="${userInfo.mbrId}">
		<input type="hidden" name="mbrNm" value="${userInfo.mbrNm}">
		<input type="hidden" name="mbrSeq" value="${userInfo.mbrSeq}">
			<table>
				<caption>아이디, 성명, 휴대폰번호, 전화번호, 주소, 이메일, 회원가입일, 최근로그인, 회원상태로 구성된 회원정보 수정에 대한 수정 테이블 입니다.</caption>
				<colgroup>
					<col style="width:20%;" />
					<col style="width:80%;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">아이디</th>
						<td>
							${userInfo.mbrId}
						</td>
					</tr>
					<tr>
						<th scope="row">성명</th>
						<td>
							${userInfo.mbrNm}
						</td>
					</tr>
					<tr>
						<th scope="row">휴대폰번호</th>
						<td>
							<c:set var="mbrMobile" value="${fn:split(userInfo.mbrMobile,'-')}" />
							<c:if test="${fn:length(mbrMobile) eq 3}">
								<c:forEach var="mbrMobileArr" items="${mbrMobile}" varStatus="loop2">
									<c:choose>
										<c:when test="${loop2.index == 0}">
											<input id="mbrMobile1" name="mbrMobile1" class="validation[required, numberOnly]" value="${mbrMobileArr}" title="휴대폰번호" type="text" style="width:30px;" maxlength="3"/>
										</c:when>
										<c:when test="${loop2.index == 1}">
											<input id="mbrMobile2" name="mbrMobile2" class="validation[required, numberOnly]" value="${mbrMobileArr}" title="휴대폰번호" type="text" style="width:40px;" maxlength="4"/>
										</c:when>
										<c:when test="${loop2.index == 2}">
											<input id="mbrMobile3" name="mbrMobile3" class="validation[required, numberOnly]" value="${mbrMobileArr}" title="휴대폰번호" type="text" style="width:40px;" maxlength="4"/>
										</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
								</c:forEach>
							</c:if>
							<c:if test="${fn:length(mbrMobile) < 3}">
								<input id="mbrMobile1" name="mbrMobile1" class="validation[required, numberOnly]" title="휴대폰번호" type="text" style="width:30px;" maxlength="3"/>
								<input id="mbrMobile2" name="mbrMobile2" class="validation[required, numberOnly]" title="휴대폰번호" type="text" style="width:40px;" maxlength="4"/>
								<input id="mbrMobile3" name="mbrMobile3" class="validation[required, numberOnly]" title="휴대폰번호" type="text" style="width:40px;" maxlength="4"/>									
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">전화번호</th>
						<td>
							<c:set var="mbrPhone" value="${fn:split(userInfo.mbrPhone,'-')}" />
							<c:if test="${fn:length(mbrPhone) eq 3}">
								<c:forEach var="mbrPhoneArr" items="${mbrPhone}" varStatus="loop2">
									<c:choose>
										<c:when test="${loop2.index == 0}">
											<input id="mbrPhone1" name="mbrPhone1" class="validation[numberOnly]" value="${mbrPhoneArr}" title="전화번호" type="text" style="width:30px;" maxlength="3"/>
										</c:when>
										<c:when test="${loop2.index == 1}">
											<input id="mbrPhone2" name="mbrPhone2" class="validation[numberOnly]" value="${mbrPhoneArr}" title="전화번호" type="text" style="width:40px;" maxlength="4"/>
										</c:when>
										<c:when test="${loop2.index == 2}">
											<input id="mbrPhone3" name="mbrPhone3" class="validation[numberOnly]" value="${mbrPhoneArr}" title="전화번호" type="text" style="width:40px;" maxlength="4"/>
										</c:when>
										<c:otherwise></c:otherwise>
									</c:choose>
								</c:forEach>
							</c:if>
							<c:if test="${fn:length(mbrPhone) < 3}">
								<input id="mbrPhone1" name="mbrPhone1" class="validation[numberOnly]" title="전화번호" type="text" style="width:30px;" maxlength="3"/>
								<input id="mbrPhone2" name="mbrPhone2" class="validation[numberOnly]" title="전화번호" type="text" style="width:40px;" maxlength="4"/>
								<input id="mbrPhone3" name="mbrPhone3" class="validation[numberOnly]" title="전화번호" type="text" style="width:40px;" maxlength="4"/>									
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td colspan="3">
							<div class="adrs_bx">
								<div class="post">
									<input type="text" name="mbrZipcode" id="mbrZipcode" value="${userInfo.mbrZipcode}" style="width:45px;" readonly/>
									<a class="btn_type1 marL10 addrS" href="#">주소검색</a>
								</div>
								<input type="text" id="mbrAddr"	name="mbrAddr" value="${userInfo.mbrAddr}" class="marL10" style="width:320px;" readonly /><br>
								<input type="text" id="mbrAddrDtl" class="validation[required]" value="${userInfo.mbrAddrDtl}" title="상세주소" name="mbrAddrDtl" class="marL10" style="width:240px;" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>
							<!-- <input type="text" id="mbrEmail" name="mbrEmail"  style="width:230px;" maxlength="150" /> -->
							<c:set var="mbrEmail" value="${fn:split(userInfo.mbrEmail,'@')}" />
							<input type="text" name="mbrEmail"  style="display:none" />
							<c:if test="${fn:length(mbrEmail) eq 2}">
								<c:forEach var="mbrEmailArr" items="${mbrEmail}" varStatus="loop3">
										<c:choose>
											<c:when test="${loop3.index == 0}">
												<input type="text" name="mbrEmail1" id="mbrEmail1" value="${mbrEmailArr}" required/>
												<span class="sign">@</span>
											</c:when>
											<c:when test="${loop3.index == 1}">
												<input type="text" name="mbrEmail2" id="mbrEmail2" value="${mbrEmailArr}" required/>
												<select  id="mbrEmail2_str" onChange="change_email(this.value);">
													<option value="" selected>직접입력</option>
													<option value='naver.com' <c:if test="${mbrEmailArr eq 'naver.com'}">selected</c:if> >naver.com</option>
													<option value='nate.com' <c:if test="${mbrEmailArr eq 'nate.com'}">selected</c:if>>nate.com</option>
													<option value='gmail.com' <c:if test="${mbrEmailArr eq 'gmail.com'}">selected</c:if>>gmail.com</option>
												</select>
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
								</c:forEach>
							</c:if>
							<c:if test="${fn:length(mbrEmail) < 2}">	
								<input type="text" name="mbrEmail1" id="mbrEmail1" required/>
								<span class="sign">@</span>
								<input type="text" name="mbrEmail2" id="mbrEmail2" required/>
								<select  id="mbrEmail2_str" onChange="change_email(this);">
									<option value="" selected>- 직접입력 -</option>
									<option value='naver.com'>naver.com</option>
									<option value='nate.com'>nate.com</option>
									<option value='gmail.com'>gmail.com</option>
								</select>
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">회원가입일</th>
						<td>
							${userInfo.mbrJoinDt}
						</td>
					</tr>
					<tr>
						<th scope="row">최근로그인</th>
						<td>
							${userInfo.mbrLoginDt}
						</td>
					</tr>
					<tr>
						<th scope="row">회원상태</th>
						<td>
							<select id="mbrLoginStatusYhn" name="mbrLoginStatusYhn">
								<option value="Y" <c:if test="${userInfo.mbrLoginStatusYhn eq 'Y' || userInfo.mbrLoginStatusYhn eq 'H'}">selected</c:if> >정상</option>
								<option value="N" <c:if test="${userInfo.mbrLoginStatusYhn eq 'N'}">selected</c:if>>탈퇴</option>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
	</div>
	<!-- // member_detail_con -->
</body>
</html>
