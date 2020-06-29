<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
<head>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>


	<script type="text/javascript">

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
			$.element_layer = document.getElementById('zipcodeLayer');

			$.closeDaumPostcode = function(){
				$.element_layer.style.display = 'none';
			}

			// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
		    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
		    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
		    $.initLayerPosition = function(){
		        var width = 300; //우편번호서비스가 들어갈 element의 width
		        var height = 400; //우편번호서비스가 들어갈 element의 height
		        var borderWidth = 5; //샘플에서 사용하는 border의 두께

		        // 위에서 선언한 값들을 실제 element에 넣는다.
		        $.element_layer.style.width = width + 'px';
		        $.element_layer.style.height = height + 'px';
		        $.element_layer.style.border = borderWidth + 'px solid';
		        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
		        $.element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
		        $.element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
		    }

			/** 주소 찾기 **/
			$("#addrBtn").click(function(){

				new daum.Postcode({
		            oncomplete: function(data) {
		                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var fullAddr = data.address; // 최종 주소 변수
		                var extraAddr = ''; // 조합형 주소 변수

		                // 기본 주소가 도로명 타입일때 조합한다.
		                if(data.addressType === 'R'){
		                    //법정동명이 있을 경우 추가한다.
		                    if(data.bname !== ''){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있을 경우 추가한다.
		                    if(data.buildingName !== ''){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
		                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		                }

		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                $('#mbrZipcode').val(data.zonecode); //5자리 새우편번호 사용
		                $('#mbrAddr').val(fullAddr);
		                // 커서를 상세주소 필드로 이동한다.
		                $('#mbrAddrDtl').val(extraAddr);
		                $('#mbrAddrDtl').focus();

		                // iframe을 넣은 element를 안보이게 한다.
		                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
		                $.element_layer.style.display = 'none';
		            },
		            width : '100%',
		            height : '100%',
		            maxSuggestItems : 5
		        }).embed($.element_layer);

		        // iframe을 넣은 element를 보이게 한다.
		        $.element_layer.style.display = 'block';

		        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
		        $.initLayerPosition();
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
		    	document.f.mbrId.value = document.f.mbrIdT.value; //bk
		        return true;
		    }
		}

		function CheckValue_PW() {
		    var strValue = document.f.mbrPw.value;
		    var strReg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^~*+=-])(?=.*[0-9]).*$/;
		    if (!strReg.test(strValue)) {
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

		    // 성명 유효성 검사
			//fnValidation();
		    document.f.mbrNm.value
			if (document.f.mbrNm.value == '' || document.f.mbrNm.value == '') {
			    alert("성명을 입력해 주십시오.");
			    document.f.mbrNm.focus();
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

			/*  ★개발 : 본인인증 로직 확인을 못하니 하드코딩 S */
			//document.f.mbrDi.value = document.f.mbrDi.value + document.f.mbrId.value;
			/*  ★개발 : 본인인증 로직 확인을 못하니 하드코딩 E */
			document.f.submit();

		}

		function change_email(target){
			var targetKey = $(target).attr("sb");
			//$(target).find("option:selected").val();

			$("#mbrEmail2").val($(target).val());

		}

	</script>
</head>
<body>
	<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="zipcodeLayer" style="display:none;position:fixed;position:absoluteoverflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;width:20px; height:20px; right:-3px;top:-3px;z-index:1" onclick="$.closeDaumPostcode()" alt="닫기 버튼">
</div>
	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>회원가입</h2>
		</div>
		<!--// tit_bx -->

		<form name="f" method="post" action="${rootUri}${conUrl}joinI.do">
			<!-- ★개발 : 본인인증 로직 확인을 못하니 하드코딩 S -->
			<!-- <input type="hidden"  name="mbrDi" id="mbrDi" value="MC0GCCqGSIb3DQIJAyEAbgDuBi8u2DphPdNHcSK4nYeSRwhiSAeCVEQuinB6Ysc=" />
			<input type="hidden" name="mbrSexMw" value="">
			<input type="hidden" name="mbrLoginStatusYhn" value="Y"> -->
			<!-- ★개발 : 본인인증 로직 확인을 못하니 하드코딩 E -->
			<!-- ★서버 : 서버 올릴때에는 아래 HIDDEN 주석을 풀어야한다. S -->
			<input type="hidden" name="mbrDi" value="${niceCheckMap.mbrDi}">
			<input type="hidden" name="mbrSexMw" value="${niceCheckMap.mbrSexMw}">
			<input type="hidden" name="mbrLoginStatusYhn" value="Y">
			<!-- ★서버 : 서버 올릴때에는 아래 HIDDEN 주석을 풀어야한다. E -->

			<div class="ing_bx nobg">
				<div class="box">
					<div class="tit">회원정보<span class="star">필수입력사항</span></div>
					<dl class="type01">
						<dt class="star">아이디</dt>
						<dd>
							<div class="input_txt_bx">
								<input type="text" name="mbrIdT" id="mbrIdT" maxlength="12"/>
								<input type="hidden" name="mbrId" >
								<a href="javascript:;" class="smBtn" id="btnChkId" onClick="chk_id();">중복확인</a>
							</div>
						</dd>
						<dt class="star">비밀번호</dt>
						<dd class="h75px">
							<div class="input_txt_bx">
								<input type="password"  name="mbrPw" id="mbrPw" maxlength="15" />
								<p class="txt">비밀번호는 공백 없이 8~15자 이내의<br>영문,숫자,특수문자 조합으로 지정해주세요.</p>
							</div>
						</dd>
						<dt class="star">비밀번호 확인</dt>
						<dd>
							<div class="input_txt_bx">
								<input type="password" name="mbrPwR" id=mbrPwR maxlength="15" />
							</div>
						</dd>
						<dt class="star">성명</dt>
						<dd>
							<div class="input_txt_bx">
								<input type="text" name="mbrNm" id=mbrNm maxlength="15" title="성명" class="validation[required]" />
							</div>
						</dd>
						<dt class="star">휴대폰번호</dt>
						<dd class="hauto">
							<div class="input_txt_bx">
								<html:selectList name='mbrMobile1' id='mbrMobile1'  selectedValue="010" optionValues='|010|011|016|017|018|019' optionNames='선택|010|011|016|017|018|019' script='class="pay_input_size07"'/>
								<input type="text" id="mbrMobile2" name="mbrMobile2" class="validation[numberOnlycenter]" maxlength="4">
								<input type="text" id="mbrMobile3" name="mbrMobile3" class="validation[numberOnlycenter]" maxlength="4">
								<!-- <a href="#" class="smBtn">인증번호</a> -->
							</div>
						</dd>
						<dt>전화번호</dt>
						<dd class="hauto">
							<div class="input_txt_bx">
								<html:selectList name='mbrPhone1' id='mbrPhone1'  optionValues='|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' optionNames='선택|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' script='class="pay_input_size07"'/>
								<input type="text" name="mbrPhone2" id="mbrPhone2" class="validation[numberOnlycenter]" maxlength="4">
								<input type="text" name="mbrPhone3" id="mbrPhone3"  class="validation[numberOnlycenter]" maxlength="4">
							</div>
						</dd>
						<dt class="star">주소</dt>
						<dd>
							<div class="input_txt_bx">
								<input type="text" class="smInput1" name="mbrZipcode" id="mbrZipcode" maxlength="7" readonly />
								<a href="#" class="smBtn" id="addrBtn">우편번호</a>
							</div>
						</dd>
						<dt></dt>
						<dd>
							<div class="input_txt_bx">
								<input type="text" id="mbrAddr" name="mbrAddr" readonly/>
							</div>
						</dd>
						<dt></dt>
						<dd>
							<div class="input_txt_bx">
								<input type="text" id="mbrAddrDtl" name="mbrAddrDtl" />
							</div>
						</dd>
						<dt class="star">이메일</dt>
						<dd class="h122px">
							<div class="input_txt_bx">
								<div><input type="text" name="mbrEmail"  style="display:none" /></div>
								<div style="margin-left:35%;"><input type="text" name="mbrEmail1" id="mbrEmail1" style="position:relative; margin-bottom:5px;" /><span class="sign" style="line-height:35px;">@</span></div>
								<div style="margin-left:35%;"><input type="text" name="mbrEmail2" id="mbrEmail2" style="position:relative;" /></div>

								<div class="select_wrap">
									<select  id="mbrEmail2_str" onChange="change_email(this);" class="pay_input_size07" style="top:40px;left:79%">
										<option value="">- 직접입력 -</option>
										<option value='naver.com'>naver.com</option>
										<option value='nate.com'>nate.com</option>
										<option value='gmail.com'>gmail.com</option>
									</select>
								</div>

							</div>
						</dd>
					</dl>
				</div>
			</div>
			<!--// ing_bx -->

			<div class="btnWrap wide pd15">
				<a href="#none" class="btn blue" onclick="checkForm();">가입완료</a>
			</div>

		</form>

	</section>
	<!--// sub -->

</body>