<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
<head>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript">

		function init(){
			fnDataSetting();
			fnEvent();

			/* 취소버튼 : 홈으로 이동 */
			$("#cancleBtn").bind("click",function(){
				location.href="/ISDS/main/home.do";
			});
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

			/* 비밀번호 변경 이벤트 */
			var mbrPwChangeSum = 0;
			fnMbrPwChange = function(){
				mbrPwChangeSum ++;
				var	mbrPwChangeHtml = '<input type="password" id="mbrPw" name="mbrPw" value="" class="" maxlength="15" placeholder="현재 비밀번호" style="display:block;width:307px">'+
					'<input type="password" id="mbrPwNew" name="mbrPwNew" value="" class="" placeholder="새 비밀번호" style="display:block;width:307px">'+
					'<input type="password" id="mbrPwNewR" value="" class="" placeholder="새 비밀번호 확인" style="display:block;margin-top:10px;width:307px">';

				if(mbrPwChangeSum == 1){
					$("#btnMbrPw").attr("style","background:#02A7CB");
					$("#mbrPwChangeDiv").append(mbrPwChangeHtml);

				}else if(mbrPwChangeSum > 1){

					var mbrId = document.f.mbrId.value;
					var mbrPw = document.f.mbrPw;
					var mbrPwNew = document.f.mbrPwNew;
					var mbrPwNewR = document.f.mbrPwNewR;
					if(mbrPw.value.length == 0 || mbrPw.value == ""){
						alert("현재 비밀번호를 입력해 주십시오.");
						mbrPw.focus();
						return false;
					}
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
					if( (mbrPw.value.length > 0 && mbrPw.value != "") &&
						(mbrPwNew.value.length > 0 && mbrPwNew.value != "") &&
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
							 fnAjax("${rootUri}${conUrl}ISDS/user/pwSave.action", {"mbrId":mbrId,"mbrPw":mbrPw.value,"mbrPwNew":mbrPwNew.value,"mbrPwNewR":mbrPwNewR.value},
								function(data, dataType){
									if(data && data.message && data.updateYn){
										alert(data.message);
										if(data.updateYn == "Y"){
											$("#btnMbrPw").attr("style","");
											$("#mbrPw").remove();
											$("#mbrPwNew").remove();
											$("#mbrPwNewR").remove();
											mbrPwChangeSum = 0;
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


			/* 회원탈퇴 */
			secessionForm = function(){
				if(confirm("탈퇴하시겠습니까?") == true){
					/* document.f.action = "${rootUri}${conUrl}ISDS/user/secessionSave.action";
					document.f.submit(); */
					var mbrId = document.f.mbrId.value;
					var mbrNm = document.f.mbrNm.value;
					var mbrJoinDt = document.f.mbrJoinDt.value;
					fnAjax("${rootUri}${conUrl}ISDS/user/secessionSave.action", {"mbrId":mbrId,"mbrNm":mbrNm,"mbrJoinDt":mbrJoinDt},
							function(data, dataType){
								if(data && data.message){
									alert(data.message);
									location.href="/ISDS/mm/actionLogSystem.out.action";
								}else{
									alert("요청 중 문제가 발생했습니다.");
								}

						 	}
						 );
				}
			}

		}

		function CheckValue_PW(strValue) {
			var mbrId = document.f.mbrId.value;
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


		function checkForm() {
		    // 패스워드 유효성 검사
			if(document.f.mbrPw != undefined){
				alert("비밀번호 변경을 해주십시오.");
				document.f.mbrPw.focus();
				return false;
			}

			if(document.f.mbrNm.value == ""){
				alert("성명을 입력해 해주십시오.");
				document.f.mbrNm.focus();
				return false;
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

			var mbrPhone1 = $.trim(document.f.mbrPhone1.value);
			var mbrPhone2 = $.trim(document.f.mbrPhone2.value);
			var mbrPhone3 = $.trim(document.f.mbrPhone3.value);
			if(mbrPhone1 != "" || mbrPhone2 != "" || mbrPhone3 !=""){
				if(mbrPhone1 == ""){
					alert("<spring:message code="cop.phoneNum.first" />");
					$(document.f.mbrPhone1).focus();
					return false;
				}
				if(mbrPhone2 == ""){
					alert("<spring:message code="cop.phoneNum.second" />");
					$(document.f.mbrPhone2).focus();
					return false;
				}
				if(mbrPhone3 == ""){
					alert("<spring:message code="cop.phoneNum.third" />");
					$(document.f.mbrPhone3).focus();
					return false;
				}
			}

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

			var email_str = document.f.mbrEmail1.value+"@"+document.f.mbrEmail2.value;
			if (!emailCheck(email_str)) {
				return false;
			}
			document.f.mbrEmail.value =  email_str;

			document.f.action = "${rootUri}${conUrl}ISDS/user/settingSave.action";
			document.f.submit();

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

	<div class="sub">

	<form name="f" method="post" action="${rootUri}${conUrl}ISDS/user/settingSave.action">
		<input type="hidden" name="mbrId" value="${mbr.mbrId}" />
		<input type="hidden" name="mbrSeq" value="${mbr.mbrSeq}" />
		<input type="hidden" name="mbrJoinDt" value="${mbr.mbrJoinDt}" />

		<div class="box_guide">
			<h2 class="tit">회원정보수정</h2>
			<p class="essential">필수 입력사항</p>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">마이페이지</a></li>
					<li class="last"><a href="#">회원정보수정</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<div class="tblType01 mt10">
			<table>
				<caption>고객 정보 입력란</caption>
				<tbody>
					<tr>
						<th scope="row" class="star"><label for="model">아이디</label></th>
						<td>${mbr.mbrId}</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="model">비밀번호</label></th>
						<td>
							<div class="adrs_bx" id="mbrPwChangeDiv">
								<div class="post">
									<a href="#" class="btn01Type" id="btnMbrPw" onclick="fnMbrPwChange(); return false;">비밀번호 변경</a>
									<span class="txt_desc_01">비밀번호는 공백 없이 8~15자 이내의 영문,숫자,특수문자 조합으로 지정해주세요.</span>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="model">성명</label></th>
						<td>
						<div class="txt_regist">
							<input type="text" name="mbrNm" value="${mbr.mbrNm}">
						</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="call">휴대폰번호</label></th>
						<td>
							<div class="call_bx">
								<c:set var="mbrMobile" value="${fn:split(mbr.mbrMobile,'-')}" />
								<c:if test="${fn:length(mbrMobile) eq 3}">
									<c:forEach var="mbrMobileArr" items="${mbrMobile}" varStatus="loop">
										<c:choose>
											<c:when test="${loop.index == 0}">
												<html:selectList name='mbrMobile1' id='mbrMobile1'  selectedValue="${mbrMobileArr}" optionValues='|010|011|016|017|018|019' optionNames='선택|010|011|016|017|018|019' script='class="pay_input_size07"'/>
											</c:when>
											<c:when test="${loop.index == 1}">
											<div class="centerNum">
												<input type="text" id="mbrMobile2" name="mbrMobile2" value="${mbrMobileArr}" class="validation[numberOnlyLeft]" maxlength="4">
											</div>
											</c:when>
											<c:when test="${loop.index == 2}">
												<input type="text" id="mbrMobile3" name="mbrMobile3" value="${mbrMobileArr}" class="validation[numberOnlyLeft]" maxlength="4">
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(mbrMobile) < 3}">
									<html:selectList name='mbrMobile1' id='mbrMobile1' selectedValue="010" optionValues='|010|011|016|017|018|019' optionNames='선택|010|011|016|017|018|019' script='class="pay_input_size07"'/>
									<div class="centerNum">
										<input type="text" id="mbrMobile2" name="mbrMobile2"  class="validation[numberOnlyCenter]" maxlength="4">
									</div>
									<input type="text" id="mbrMobile3" name="mbrMobile3" value="${mbrMobileArr}" class="validation[numberOnlyCenter]" maxlength="4">
								</c:if>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="call">전화번호</label></th>
						<td>
							<div class="call_bx">
								<c:set var="mbrPhone" value="${fn:split(mbr.mbrPhone,'-')}" />
								<c:if test="${fn:length(mbrPhone) eq 3}">
									<c:forEach var="mbrPhoneArr" items="${mbrPhone}" varStatus="loop2">
										<c:choose>
											<c:when test="${loop2.index == 0}">
												<html:selectList name='mbrPhone1' id='mbrPhone1' selectedValue="${mbrPhoneArr}" optionValues='|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' optionNames='선택|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' script='class="pay_input_size07"'/>
											</c:when>
											<c:when test="${loop2.index == 1}">
												<div class="centerNum">
													<input type="text" name="mbrPhone2" id="mbrPhone2" value="${mbrPhoneArr}" class="validation[numberOnly]" maxlength="4">
												</div>
											</c:when>
											<c:when test="${loop2.index == 2}">
												<input type="text" name="mbrPhone3" id="mbrPhone3" value="${mbrPhoneArr}" class="validation[numberOnly]" maxlength="4">
											</c:when>
											<c:otherwise></c:otherwise>
										</c:choose>
									</c:forEach>
								</c:if>
								<c:if test="${fn:length(mbrPhone) < 3}">
									<html:selectList name='mbrPhone1' id='mbrPhone1' optionValues='|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' optionNames='선택|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' script='class="pay_input_size07"'/>
									<div class="centerNum">
										<input type="text" name="mbrPhone2" id="mbrPhone2" class="validation[numberOnly]" maxlength="4">
									</div>
									<input type="text" name="mbrPhone3" id="mbrPhone3" class="validation[numberOnly]" maxlength="4">
								</c:if>

							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="adrs">주소</label></th>
						<td>
							<div class="adrs_bx">
								<div class="post">
									<input type="text" name="mbrZipcode" id="mbrZipcode" value="${mbr.mbrZipcode}" maxlength="7" readonly/>
									<a href="javascript:;" id="addrBtn" class="btn01Type ml10">우편번호 찾기</a>
								</div>
								<input type="text" id="mbrAddr" name="mbrAddr" value="${mbr.mbrAddr}"  readonly/>
								<input type="text" id="mbrAddrDtl" name="mbrAddrDtl" value="${mbr.mbrAddrDtl}"  />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="model">이메일</label></th>
						<td>
							<c:set var="mbrEmail" value="${fn:split(mbr.mbrEmail,'@')}" />
							<input type="text" name="mbrEmail"  style="display:none" />
							<c:if test="${fn:length(mbrEmail) eq 2}">
								<div class="email_box">
									<c:forEach var="mbrEmailArr" items="${mbrEmail}" varStatus="loop3">
											<c:choose>
												<c:when test="${loop3.index == 0}">
													<input type="text" name="mbrEmail1" id="mbrEmail1" value="${mbrEmailArr}" required/>
													<span class="sign">@</span>
												</c:when>
												<c:when test="${loop3.index == 1}">
													<input type="text" name="mbrEmail2" id="mbrEmail2" value="${mbrEmailArr}" required/>
													<div class="select_wrap">
														<c:choose>
															<c:when test="${mbrEmailArr eq 'naver.com'}">
																<span id="evenUserAge" class="select_label">naver.com</span>
															</c:when>
															<c:when test="${mbrEmailArr eq 'nate.com'}">
																<span id="evenUserAge" class="select_label">nate.com</span>
															</c:when>
															<c:when test="${mbrEmailArr eq 'gmail.com'}">
																<span id="evenUserAge" class="select_label">gmail.com</span>
															</c:when>
															<c:otherwise>
																<span id="evenUserAge" class="select_label">직접입력</span>
															</c:otherwise>
														</c:choose>

														<select  id="mbrEmail2_str" onChange="change_email(this);">
															<option value="" selected>직접입력</option>
															<option value='naver.com' <c:if test="${mbrEmailArr eq 'naver.com'}">selected</c:if> >naver.com</option>
															<option value='nate.com' <c:if test="${mbrEmailArr eq 'nate.com'}">selected</c:if>>nate.com</option>
															<option value='gmail.com' <c:if test="${mbrEmailArr eq 'gmail.com'}">selected</c:if>>gmail.com</option>
														</select>
													</div>
												</c:when>
												<c:otherwise></c:otherwise>
											</c:choose>
									</c:forEach>
								</div>
							</c:if>
							<c:if test="${fn:length(mbrEmail) < 2}">
								<div class="email_box">
									<input type="text" name="mbrEmail1" id="mbrEmail1" required/><span class="sign">@</span>
									<input type="text" name="mbrEmail2" id="mbrEmail2" required/>
									<div class="select_wrap">
										<span id="evenUserAge" class="select_label">직접입력</span>
										<select  id="mbrEmail2_str" onChange="change_email(this);">
											<option value="" selected>- 직접입력 -</option>
											<option value='naver.com'>naver.com</option>
											<option value='nate.com'>nate.com</option>
											<option value='gmail.com'>gmail.com</option>
										</select>
									</div>
								</div>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
		</div>


	</form>

	<div class="btnArea">
		<button class="left" onclick="secessionForm();">회원탈퇴</button>
		<button class="middle" id="cancleBtn">취소</button>
		<button class="right" onclick="checkForm();">수정완료</button>
	</div>

	</div>
	<!--// sub -->


</body>