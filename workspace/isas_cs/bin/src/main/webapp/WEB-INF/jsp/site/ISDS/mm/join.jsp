<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
<head>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript">
	<!--

		function init(){
			fnDataSetting();
			fnEvent();
		}


		function fnDataSetting(){
			$("input").attr("autocomplete","off");
			/** 2중 submit 방지 */
			$("<input type='hidden' name='token' id='token'/>").appendTo("body");
			$(".numberOnly").keyup(function(){
				$(this).val( $(this).val().replace(/[^0-9]/g,"") );
				$(this).val( $(this).val().replace(/[^\!-z]/g,"") );
			});
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
		    //var strReg = /^[A-Za-z0-9]+$/;
		    var strReg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).*$/;
		    if (!strReg.test(strValue)) {
		        //alert('패스워드는 영문과 숫자만 입력 가능합니다');
		        alert('패스워드는 영문,숫자,특수문자를 조합 해야합니다.');
		        return false;
		    }
		    else if (strValue.length < 8 || strValue.length > 15) {
		        alert('패스워드는 8~15자까지만 입력이 가능합니다.');
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
			fnAjax("${rootUri}${conUrl}joinChkId.action", {"mbrId":mbrIdT,"flag":"id"},
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


			f.submit();

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
	<body>
	<div class="sub">

	  	<!--=============== #CONNTENTS ===============-->
		<form name="f" method="post" action="${rootUri}${conUrl}joinI.do" ">
		<div class="box_guide">
			<h2 class="tit">회원가입</h2>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li class="last"><a href="#">회원가입</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<ol class="join_step_bx">
			<li><span>STEP 1.약관동의</span></li>
			<li><span>STEP 2.본인인증</span></li>
			<li class="on"><span>STEP 3.정보입력</span></li>
			<li><span>STEP 4.가입완료</span></li>
		</ol>
		<!--// join_step_bx -->
		<p class="essential">필수 입력사항</p>
		<!--// box_guide -->
		<div class="tblType01 mt10">
			<table>
				<caption>고객 정보 입력란</caption>
				<tbody>
					<tr>
						<th scope="row" class="star"><label for="model">아이디</label></th>
						<td>
						<div class="txt_regist">
							<input type="text"  name="mbrIdT" id="mbrIdT"  maxlength="12" required />
							<input type="hidden" name="mbrId" value="">
							<a href="javascript:;" class="btn01Type ml10" id="btnChkId" onClick="chk_id();">중복확인</a>
						</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="model">비밀번호</label></th>
						<td>
						<div class="txt_regist">
							<input type="password" name="mbrPw" id="mbrPw" maxlength="15" /><span class="txt_desc_01" style="display:inline-block;margin-top:12px;">비밀번호는 공백 없이 8~15자 이내의 영문,숫자,특수문자 조합으로 지정해주세요.</span>
						</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="model">비밀번호 확인</label></th>
						<td>
						<div class="txt_regist">
							<input type="password" name="mbrPwR" id=mbrPwR maxlength="15"  />
						</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="model">성명</label></th>
						<td>
						<div class="txt_regist">
							${niceCheckMap.name}
							<input type="hidden" name="mbrNm" value="${niceCheckMap.name}">
						</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="call">휴대폰번호</label></th>
						<td>
							<div class="call_bx">
								<html:selectList name='mbrMobile1' id='mbrMobile1'  selectedValue="010" optionValues='|010|011|016|017|018|019' optionNames='선택|010|011|016|017|018|019' script='class="pay_input_size07"'/>
								<div class="centerNum">
									<input type="text" id="mbrMobile2" name="mbrMobile2" class="validation[numberOnlycenter]" style="padding-left:0px;" maxlength="4">
								</div>
									<input type="text" id="mbrMobile3" name="mbrMobile3" class="validation[numberOnlycenter]" style="padding-left:0px;" maxlength="4">
<!-- 								<a href="#" class="btn01Type ml10">인증번호 전송</a> -->
							</div>
<!-- 							<div class="box_ctf"> -->
<!-- 								<p class="guide_ctf">입력하신 휴대폰번호로 인증번호가 전송 되었습니다<span class="time">3분</span></p> -->
<!-- 								<div class="inner_number"> -->
<!-- 									<div class="txt_regist"> -->
<!-- 										<input type="text" style="width:137px;" /><a href="#" class="btn03Type ml9">확인</a><a href="#" class="btn01Type ml9">인증번호 재전송</a> -->
<!-- 									</div> -->
<!-- 								</div> -->
<!-- 							</div> -->
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="call">전화번호</label></th>
						<td>
							<div class="call_bx">
								<html:selectList name='mbrPhone1' id='mbrPhone1'  optionValues='|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' optionNames='선택|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' script='class="pay_input_size07"'/>
								<div class="centerNum">
									<input type="text" name="mbrPhone2" id="mbrPhone2" class="validation[numberOnlycenter]" style="padding-left:0px;" maxlength="4">
								</div>
								<input type="text" name="mbrPhone3" id="mbrPhone3"  class="validation[numberOnlycenter]" style="padding-left:0px;" maxlength="4">
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="adrs">주소</label></th>
						<td>
							<div class="adrs_bx">
								<div class="post">
									<input type="text" name="mbrZipcode" id="mbrZipcode" maxlength="7" readonly/>
									<a href="javascript:;" id="addrBtn" class="btn01Type ml10">우편번호 찾기</a>
								</div>
								<input type="text" id="mbrAddr" name="mbrAddr" readonly/>
								<input type="text" id="mbrAddrDtl" name="mbrAddrDtl" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="model">이메일</label></th>
						<td>
							<input type="text" name="mbrEmail"  style="display:none" />
							<div class="email_box">
								<input type="text" name="mbrEmail1" id="mbrEmail1" required/><span class="sign">@</span>
								<input type="text" name="mbrEmail2" id="mbrEmail2" required/>
								<div class="select_wrap">
									<span id="evenUserAge" class="select_label">직접입력</span>
									<select  id="mbrEmail2_str" onChange="change_email(this);">
										<option value="">- 직접입력 -</option>
										<option value='naver.com'>naver.com</option>
										<option value='nate.com'>nate.com</option>
										<option value='gmail.com'>gmail.com</option>
									</select>
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="btnArea ac">
			<button type="button" onclick="checkForm();" class="right">가입완료</button>
		</div>
			<input type="hidden" name="mbrDi" value="${niceCheckMap.mbrDi}">
			<input type="hidden" name="mbrSexMw" value="${niceCheckMap.mbrSexMw}">
			<input type="hidden" name="mbrLoginStatusYhn" value="Y">
		</form>
	</div>
	<!--// sub -->
</body>