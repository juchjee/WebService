<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
<head>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript">
	<!--
		$(document).ready(function() {
			$("input").attr("autocomplete","off");
			/** 2중 submit 방지 */
			$("<input type='hidden' name='token' id='token'/>").appendTo("body");
			$(".numberOnly").keyup(function(){
				$(this).val( $(this).val().replace(/[^0-9]/g,"") );
				$(this).val( $(this).val().replace(/[^\!-z]/g,"") );
			});
		});

		function init(){
			fnEvent();
		}

		function fnEvent(){
			/** 주소 찾기 **/
			$("#addrBtn").click(function(){
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
// 		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있을 경우 추가한다.
		                    if(data.buildingName !== ''){
// 		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
// 		                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		                    extraAddr = (extraAddr !== '' ? '('+ extraAddr +') ' : '');
		                }
		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                $('#mbrZipcode').val(data.zonecode); //5자리 새우편번호 사용
		                $('#mbrAddr').val(fullAddr);
		                // 커서를 상세주소 필드로 이동한다.
		                $('#mbrAddrDtl').val(extraAddr);
		                $('#mbrAddrDtl').focus();
			        }
			    }).open();
			});
		}

		function CheckValue_ID(strValue) {
		    var strReg = /^[A-Za-z0-9]+$/;
		    if(!strValue){
		    	alert("아이디를 입력해주세요");
		    	return false;
		    }
		    if (!strReg.test(strValue)) {
		        alert('id는 영문과 숫자만 입력 가능합니다');
		        return false;
		    }else if(strValue.length < 4){
		        alert('id는 4~12자까지만 입력이 가능합니다.');
		        return false;
		    }else {
		        return true;
		    }
		}

		function CheckValue_PW() {
		    var strValue = document.f.mbrPw.value;
		    var strReg = /^[A-Za-z0-9]+$/;
		    if (!strReg.test(strValue)) {
		        alert('패스워드는 영문과 숫자만 입력 가능합니다');
		        return false;
		    }
		    else if (strValue.length < 4 || strValue.length > 12) {
		        alert('패스워드는 4~12자까지만 입력이 가능합니다.');
		        return false;
		    }else {
		        return true;
		    }
		}

		function chk_id()
		{
			var mbrIdT = document.f.mbrIdT.value;
		    if (!CheckValue_ID(mbrIdT)) {
		    	document.f.mbrIdT.focus();
		        return false;
		    }
			document.f.mbrId.value="";
			fnAjax("${rootUri}${conUrl}joinChkId.do", {"mbrId":mbrIdT,"flag":"id"},
				function(data, dataType){
					if(data && data.message){
						if(data.passChk){
							document.f.mbrId.value=data.mbrId;
							alert(data.message);
							document.f.mbrPw.focus();
						}else{
							alert(data.message);
							document.f.mbrIdT.focus();
						}
					}else{
						alert("다시 체크 바랍니다.");
					}
				}
			);
		}

		function chk_recom()
		{
			var mbrIdT = $.trim(document.f.mbrIdT.value);

			if(!CheckValue_ID(mbrIdT)){
				document.f.mbrIdT.focus();
		        return false;
			}
			var mbrId = $.trim(document.f.mbrId.value);
			if(mbrId == ""){
				alert("아이디 중복 확인을 해주세요.");
				$("#btnChkId").focus();
				return false;
			}
			var mbrRecT = $.trim($("#mbrRecT").val());
			if (mbrRecT == ""){
				alert("추천아이디를 입력해주세요");
				$("#mbrRecT").focus();
				return false;
			}
			if(mbrId == mbrRecT){
				alert("본인의 아이디를 \n\n 추천인으로 등록하실 수 없습니다\n\n 다른 아이디를 입력해주세요");
				$("#mbrRecT").focus();
				return false;
			}
			document.f.mbrRec.value = "";
			$(document.f.mbrRec).attr("disabled",true);
			fnAjax("${rootUri}${conUrl}joinChkId.do", {"mbrId":mbrId,"mbrRec":mbrRecT,"flag":"rec"},
				function(data, dataType){
					if(data && data.message){
						if(data.passChk){
							document.f.mbrRec.value = mbrRecT;
							$(document.f.mbrRec).attr("disabled",false);
							alert(data.message);
							document.f.mbrPw.focus();
						}else{
							alert(data.message);
							$("#mbrRecT").focus();
						}
					}else{
						alert("다시 체크 바랍니다.");
					}
				}
			);
		}

		function checkForm() {
		    // 아이디 유효성 검사
		    if (!CheckValue_ID(document.f.mbrIdT.value)){
		        return false;
		    }
		    var mbrId=document.f.mbrId.value;
			if(mbrId == ""){
				alert("아이디 중복 확인을 해주세요.");
				$("#btnChkId").focus();
				return false;
			}
		    // 패스워드 유효성 검사
			if(mbrId == document.f.mbrPw.value){
				alert("아이디와 비밀번호는 같을 수 없습니다")
				document.f.mbrPw.focus();
				return false;
			}
		    // 패스워드 유효성 검사
			if (document.f.mbrPw.value != document.f.mbrPwR.value) {
				alert("입력된 두개의 패스워드가 틀립니다.");
				document.f.mbrPwR.focus();
				return false;
			}

		    // 패스워드 유효성 검사
			if (!CheckValue_PW()) {
			    return false;
			}

			var email_str = document.f.mbrEmail1.value+"@"+document.f.mbrEmail2.value;
			if (!emailCheck(email_str)) {
				return false;
			}

			document.f.mbrEmail.value =  email_str;
			if (document.f.mbrZipcode.value == '' || document.f.mbrAddr.value == '') {
			    alert("주소를 검색하여 입력해 주십시오.");
			    $("#addrBtn").focus();
			    return false;
			}

			if ($.trim(document.f.mbrAddrDtl.value) == ''){
			    if (!confirm("상세주소가 없으십니까?")) {
			    	document.f.mbrAddrDtl.focus();
			    	return false;
			    }
			}

			var mbrRec = document.f.mbrRec.value;
			var mbrRecT = document.f.mbrRecT.value;
			if(mbrRec != ""){
				if(mbrId == mbrRec){
					alert("본인의 아이디를 \n\n 추천인으로 등록하실 수 없습니다\n\n 다른 아이디를 입력해주세요");
					document.f.mbrRecT.focus();
					return false;
				}
			}else if(mbrRecT != ""){
				if(mbrRec == ""){
					alert("추천인 ID확인을 해주세요");
					$("#btnChkRecom").focus();
					return false;
				}
			}
			var mbrMobile1 = $.trim(document.f.mbrMobile1.value);
			var mbrMobile2 = $.trim(document.f.mbrMobile2.value);
			var mbrMobile3 = $.trim(document.f.mbrMobile3.value);
			if(mbrMobile1 == ""){
				alert("<spring:message code="cop.mbtlNum.first" />");
				$(document.f.mbrMobile1).focus();
				return false;
			}
			if(mbrMobile2 == ""){
				alert("<spring:message code="cop.mbtlNum.second" />");
				$(document.f.mbrMobile2).focus();
				return false;
			}
			if(mbrMobile3 == ""){
				alert("<spring:message code="cop.mbtlNum.third" />");
				$(document.f.mbrMobile3).focus();
				return false;
			}
			return true;

		}

		function change_email(target){
			var targetKey = $(target).attr("sb");
			//$(target).find("option:selected").val();

			$("#mbrEmail2").val($(target).val());

		}
	//-->
	</script>
</head>
<body>
	<div id="container" class="join">
	  	<!--=============== #CONNTENTS ===============-->
		<form name="f" method="post" action="${rootUri}${conUrl}joinI.do" onSubmit="return checkForm();">
			<div id="contents" class="inner">
				<h3><img src="/common/images/tit/h3_tit6_2.png" alt="회원가입"></h3>
				<ul class="step">
					<li class="step01"><span><em>STEP 01</em>본인인증</span></li>
					<li class="step02 on"><span><em>STEP 02</em>정보입력</span></li>
					<li class="step03"><span><em>STEP 03</em>가입완료</span></li>
				</ul>
				<div class="cont" style="margin-bottom:30px;">
					<strong class="title_text">필수입력 정보</strong>
					<table class="tsytle" summary="필수정보인 이름, 성별,생년월일, 회원 ID,비밀번호, 비밀번호확인, 이메일, 집주소, 전화번호, 휴대폰 입력">
						<tbody>
							<tr>
								<th>이름</th>
								<td>
									${niceCheckMap.name}
									<input type="hidden" name="mbrNm" value="${niceCheckMap.name}">
								</td>
							</tr>
							<tr>
								<th>생년월일</th>
								<td class="birth">
									${niceCheckMap.mbrBirthdt}
									<input type="hidden" name="mbrBirthdtTypeGl" value="G">
									<input type="hidden" name="mbrBirthdt" value="${niceCheckMap.mbrBirthdt}">
								</td>
							</tr>
							<tr>
								<th><label for="mbrId">아이디 *</label></th>
								<td class="">
									<input type="text"  name="mbrIdT" id="mbrIdT"  maxlength="12" required />
									<input type="hidden" name="mbrId" value="">
									<a href="javascript:;" class="btn03" id="btnChkId" onClick="chk_id();">중복확인</a>
								</td>
							</tr>
							<tr>
								<th><label for="mbrPw">비밀번호 *</label></th>
								<td><input type="password" name="mbrPw" id="mbrPw" maxlength="12" required /></td>
							</tr>
							<tr>
								<th><label for="mbrPwR">비밀번호확인 *</label></th>
								<td><input type="password" name="mbrPwR" id="mbrPwR" maxlength="12" required  /></td>
							</tr>
							<tr>
								<th><label for="mbrEmail">이메일 *</label></th>
								<td class="email">
									<input type="text" name="mbrEmail"  style="display:none" />
									<input type="text" name="mbrEmail1" id="mbrEmail1" required/>
									<span class="etc_text">@</span>
									<input type="text" name="mbrEmail2" id="mbrEmail2" required/>
									<select  id="mbrEmail2_str" onChange="change_email(this);">
										<option value="">- 직접입력 -</option>
										<option value='naver.com'>naver.com</option>
										<option value='nate.com'>nate.com</option>
										<option value='gmail.com'>gmail.com</option>
									</select>
									<span class="lc_m1">
										<input type="checkbox" name="mbrEmailRcvYn" id="mbrEmailRcvYn" class="checkbox_spac" value="Y"/><label for="mbrEmailRcvYn"> 이메일 수신허용 <font color="#dd143f"> [선택]</font></label>
									</span>
								</td>
							</tr>
							<tr>
								<th><label for="address">집주소 *</label></th>
								<td class="add">
									<input type="text" name="mbrZipcode" id="mbrZipcode" maxlength="7" readonly/>
	                                   <a id="addrBtn" class="btn03" href="javascript:;">우편번호찿기</a>
	                                   <p><input type="text" id="mbrAddr" name="mbrAddr" readonly/></p>
	                                   <p><input type="text" id="mbrAddrDtl" name="mbrAddrDtl" /></p>
									<p style="clear:both;padding-top:2px">
	                                   <span id="mbrAddr_sub" style="color:#999"></span>
	                                   <span id="guide" style="color:#999"></span>
									<p>
								</td>
							</tr>
							<tr>
								<th><label for="tel">전화번호</label></th>
								<td class="call">
									<html:selectList name='mbrPhone1' id='mbrPhone1'  optionValues='|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' optionNames='선택|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' script='class="pay_input_size07"'/>
									<span class="etc_text">-</span>
									<input type="text" name="mbrPhone2"  class="numberOnly" maxlength="4" />
									<span class="etc_text">-</span>
									<input type="text" name="mbrPhone3"  class="numberOnly" maxlength="4" />
								</td>
							</tr>
							<tr>
								<th><label for="mbrMobile1">휴대폰 *</label></th>
								<td class="call call1">
									<html:selectList name='mbrMobile1' id='mbrMobile1'  selectedValue="010" optionValues='|010|011|016|017|018|019' optionNames='선택|010|011|016|017|018|019' script='class="pay_input_size07"'/>
									<span class="etc_text">-</span>
									<input type="text" name="mbrMobile2" class="numberOnly" maxlength="4"/>
									<span class="etc_text">-</span>
									<input type="text" name="mbrMobile3" class="numberOnly"  maxlength="4"/>
									<span class="lc_m1">
										<input type="checkbox" name="mbrMobileRcvYn" id="mbrMobileRcvYn" value="Y"/>
										<label for="mbrMobileRcvYn"> 듀오락 쇼핑몰 이벤트 수신동의 <font color="#dd143f"> [선택]</font></label>
									</span>
								 </td>
							</tr>
						</tbody>
					</table>
					<p class="join_hpex01">
						<font style="font-size: 12px; color: #dd143f;">※ *는 필수 입력 사항 입니다. 듀오락 쇼핑몰은 구매 고객님들 중 이메일 수신허용 및 SMS 수신동의로 이벤트 수신에 동의하신 고객님들께만 이벤트 안내 이메일 및 문자를 발송해 드립니다.
						</font>
					</p>
				</div>

				<div class="cont">
					<strong class="title_text">선택입력 정보</strong>
					<table class="tsytle" summary="옵션정보인 추천인ID,직업,직장주소, 결혼정보, 사이트를 알게된 경로, 듀오락섭취이유">
						<tbody>
							<tr>
								<th><label for="mbrRecT">추천인 아이디</label></th>
								<td class="">
									<input type="text" id="mbrRecT" name="mbrRecT"/>
									<input type="hidden" name="mbrRec" id="mbrRec" disabled="disabled"/>
									<a href="javascript:;" class="btn03" id="btnChkRecom" onClick="chk_recom();">추천인 ID확인</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="btn_wrap">
					<input type="submit" class="btn01" src="common/img/icon/join_end.png" value="회원가입">
					<a class="btn01_1" href="${rootUri}${conUrl}join.do">취소</a>
				</div>
			</div>
			<input type="hidden" name="mbrSexMw" value="${niceCheckMap.mbrSexMw}">
			<input type="hidden" name="mbrDi" value="${niceCheckMap.di}">
			<input type="hidden" name="mbrLoginStatusYhn" value="Y">
			<input type="hidden" name="mbrTpBte" value="B">
		</form>
		<!--=============== #CONNTENTS ===============-->
	</div>
</body>