<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
<head>

	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<script type="text/javascript">
	<!--

	function init(){
		fnEvent();
	}

	function change_email(target){
		$("#mbrEmail2").val($(target).val());
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
// 	                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
// 	                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                    extraAddr = (extraAddr !== '' ? '('+ extraAddr +') ' : '');
	                }
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $('#mbrZipcode').val(data.zonecode);
	                $('#mbrAddr').val(fullAddr);
	                // 커서를 상세주소 필드로 이동한다.
	                $('#mbrAddrDtl').val(extraAddr);
	                $('#mbrAddrDtl').focus();
		        }
		    }).open();
		});

		$("#transBtn").click(function(){
			$("#transBtn").attr("href","pop_delivery.action?mbrId=${mbr.mbrId}");
		});

		$("#transBtn").fancybox({
			width		: 600,
			height		: 800,
			autoSize	: true
		});

	}

	function fnReBasicTransInfo(transSeq){
		if(transSeq > -1){
			$.ajax({
		        type: "POST",
		        url: "/ISDS/order/getBasicTransInfo.action",
		        cache: false,
		        data: {"transSeq" : transSeq},
		        success: onBasicTransInfoSuccess
		    });
		}
	}

	var basicTransInfoObj = null;
	function onBasicTransInfoSuccess(data, result){
		if(data){
			basicTransInfoObj = data;
			setBasicTransInfoObj();
			$.fancybox.close();
		}
	}

	function setBasicTransInfoObj(){
			$("#dr_area").html(basicTransInfoObj.transNm);
			$("#dr_name").html(basicTransInfoObj.transRevNm);
			$("#dr_addr").html("&nbsp;"+basicTransInfoObj.mbrZipcode+"&nbsp;"+basicTransInfoObj.mbrAddr+"&nbsp;"+basicTransInfoObj.mbrAddrDtl);
			$("#dr_tel").html(basicTransInfoObj.mbrPhone);
			$("#dr_phone").html(basicTransInfoObj.mbrMobile);
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

	function checkForm() {

		// 패스워드 유효성 검사
		var mbrId=document.f.mbrId.value;
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

		var mbrMobile1 = $.trim($("select[name=mbrMobile1]").find("option[selected='selected']").val());
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
	//-->
	</script>
</head>
<body>

<!--=============== #CONTAINER ===============-->
<div id="container" class="user">
  	<!--=============== #CONNTENTS ===============-->
	<div id="contents" class="inner">
		<h3><img src="/common/images/tit/h3_tit7_7.png" alt="회원정보"></h3>

		<ul class="mypage_menu">
					<li class="col1 "><a href="/ISDS/user/mypage.do" ><span>아이콘</span>마이페이지</a></li>
					<li class="col2 "><a href="/ISDS/user/order.do" ><span>아이콘</span>주문/배송 조회</a></li>
					<li class="col3"><a href="/ISDS/user/wishList.do" ><span>아이콘</span>위시리스트</a></li>
					<li class="col4  "><a href="/ISDS/user/cash.do" ><span>아이콘</span>멤버십 혜택/포인트/쿠폰</a></li>
					<li class="col5 "><a href="/ISDS/user/product.do" ><span>아이콘</span>나의 문의내역</a></li>
					<li class="col6 "><a href="/ISDS/user/review.do" ><span>아이콘</span>나의 제품후기</a></li>
					<li class="col7 on"><a href="/ISDS/user/setting.do" ><span>아이콘</span>회원정보</a></li>
					<li class="col8"><a href="/ISDS/order/cart.do" ><span>아이콘</span>장바구니</a></li>
		</ul>

		<!--
		<div class="cont">
			<div class="layer">
				<div class="bg"></div>
				<div id="layer" class="pop-layer">
					<div class="pop-container">
						<div class="pop-cont">
							<div class="title">
								<strong>명의변경</strong>
								<a href="#" class="cbtn">Close</a>
							</div>
							<form name="pop_name" method="post" accept-charset="utf-8">
							<div class="pcont">
								<ul class="top_info">
									<li>실명을 변경하시려면 NICE평가정보에 변경된 정보를 적용하고, 본인인증을 해주시기 바랍니다.</li>
								</ul>
								<div class="confirm_box">
									<div class="phone">
										<span class="text_box">
											<span>휴대폰 인증</span>
										</span>
										<input type="radio" name="auth_type" id="conhp" checked/>
									</div>

									<div class="ipin">
										<span class="text_box">
											<span>I-PIN 인증</span>
										</span>
										<input type="radio" name="auth_type" id="conip"/>
									</div>
								</div>
								<a href="#!" onclick="fnPopup();" class="btn01">인증하기</a>
							</div>

							<input type="hidden" name="M_NAME">
							<input type="hidden" name="M_GENDER">
							<input type="hidden" name="M_BIRTHDATE">
							<input type="hidden" name="SAFEID">
							</form>
						</div>
					</div>
				</div>
			</div>
		</div>
		-->

		<form name="f" method="post" action="settingSave.action" onsubmit="return checkForm();">
		<div class="cont">
			<div  class="title_text_wrap">
				<strong class="title_text">필수입력 정보</strong>
				<a href="secede.do" class="btn04 secede_btn">회원탈퇴</a>
			</div>
			<table class="tsytle" summary="필수정보인 이름, 성별,생년월일, 회원 ID,비밀번호, 비밀번호확인, 이메일, 집주소, 전화번호, 휴대폰 입력" cellpadding="0" cellspacing="0">
				<tbody>
					<tr>
						<th><label for="mbrNm">이름</label></th>
						<td>
							<input type="hidden" name="infoType" >
							<input type="hidden" name="m_name" value="">
							<input type="hidden" name="SAFEID" value ="">
							${mbr.mbrNm}
							<!-- &nbsp;&nbsp;&nbsp;<a href="#!" class="btn04" onclick="layer_open('layer');return false;">명의변경</a> -->
						</td>
					</tr>
					<tr>
						<th><label for="year">생년월일</label></th>
						<td class="birth">
							${fn:substring(mbr.mbrBirthdt, 0, 10)}
						</td>
					</tr>
					<tr>
						<th><label for="mbrId">아이디</label></th>
						<td class="">
						${mbr.mbrId}
						<input type="hidden" name="mbrId" id="mbrId" value="${mbr.mbrId}" />
						</td>
					</tr>
					<tr>
						<th><label for="mbrPw">비밀번호</label></th>
						<td><input type="password" name="mbrPw" id="mbrPw" maxlength="12" required="true!비밀번호를 입력해주세요" /></td><!--charlength="4-12!패스워드는 4~12자까지만 입력 가능합니다." datatype="13!숫자,영문 대.소문자만 입력  가능합니다"-->
					</tr>
					<tr>
						<th><label for="mbrPwR">비밀번호확인</label></th>
						<td><input type="password" name="mbrPwR" id="mbrPwR" maxlength="12" required="true!비밀번호를 입력해주세요"  /></td><!--charlength="4-12!패스워드는 4~12자까지만 입력 가능합니다." datatype="13!숫자,영문 대.소문자만 입력  가능합니다"-->
					</tr>
					<tr>
						<th><label for="email">이메일</label></th>
						<td class="email">
							<input type="text" name="mbrEmail1" id="mbrEmail1" maxlength="50" value="${fn:split(mbr.mbrEmail,'@')[0]}" />
							<span class="etc_text">@</span>
							<input type="text" name="mbrEmail2" id="mbrEmail2" maxlength="30" value="${fn:split(mbr.mbrEmail,'@')[1]}" />
							<html:selectList name='mEmailStr' id='mEmailStr' selectedValue="${fn:split(mbr.mbrEmail,'@')[1]}" optionValues='|naver.com|nate.com|gmail.com' optionNames='- 직접입력 -|naver.com|nate.com|gmail.com' script='onchange="change_email(this);"'/>
							<span class="lc_m1">
								<input type="checkbox" id="mbrEmailRcvYn" class="checkbox_spac" name="mbrEmailRcvYn" value="Y" <c:if test="${mbr.mbrEmailRcvYn eq 'Y'}">checked="checked"</c:if> />
								<label for="join_email"> 이메일 수신허용</label>
							</span>
						</td>
					</tr>
					<tr>
						<th><label for="address">집주소</label></th>
						<td class="add">
							<input type="text" name="mbrZipcode" id="mbrZipcode" maxlength="7" value="${mbr.mbrZipcode}" readonly />
                            <a id="addrBtn" class="btn03" href="javascript:;">우편번호찿기</a>
                            <p><input type="text" id="mbrAddr" name="mbrAddr" readonly value="${mbr.mbrAddr}" /></p>
                            <p><input type="text" id="mbrAddrDtl" name="mbrAddrDtl" maxlength="200" value="${mbr.mbrAddrDtl}" /></p>
                            <p style="clear:both;padding-top:2px"><span id="m_addr1_sub1" style="color:#999;"></span>
                            <span id="guide" style="color:#999"></span></p>
						</td>
					</tr>
					<tr>
						<th><label for="tel">전화번호</label></th>
						<td class="call">
							<html:selectList name='mbrPhone1' id='mbrPhone1' selectedValue="${fn:split(mbr.mbrPhone,'-')[0]}" optionValues='|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' optionNames='선택|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' script='class="pay_input_size07"'/>
							<span class="etc_text">-</span>
							<input type="text" class="validation[numberOnlyLeft]" name="mbrPhone2" id="mbrPhone2" maxlength="4" value="${fn:split(mbr.mbrPhone,'-')[1]}"/>
							<span class="etc_text">-</span>
							<input type="text" class="validation[numberOnlyLeft]" name="mbrPhone3" id="mbrPhone3" maxlength="4" value="${fn:split(mbr.mbrPhone,'-')[2]}" />
						</td>
					</tr>
					<tr>
						<th><label for="hp">휴대폰</label></th>
						<td class="call call1">
							<html:selectList name='mbrMobile1' id='mbrMobile1' selectedValue="${fn:split(mbr.mbrMobile,'-')[0]}" optionValues='|010|011|016|017|018|019' optionNames='선택|010|011|016|017|018|019' script='class="pay_input_size07"'/>
							<span class="etc_text">-</span>
							<input type="text" class="validation[numberOnlyLeft]" name="mbrMobile2" id="mbrMobile2" maxlength="4" value="${fn:split(mbr.mbrMobile,'-')[1]}"/>
							<span class="etc_text">-</span>
							<input type="text" class="validation[numberOnlyLeft]" name="mbrMobile3" id="mbrMobile3" maxlength="4" value="${fn:split(mbr.mbrMobile,'-')[2]}"/>
							<input type="checkbox" name="mbrMobileRcvYn" id="mbrMobileRcvYn" value="Y" <c:if test="${mbr.mbrMobileRcvYn == 'Y'}">checked="checked"</c:if> /><label for="join_send"> 듀오락 쇼핑몰 이벤트 수신동의</label>
							<p class="join_hpex01">※ 듀오락 쇼핑몰은 구매 고객님들 중 SMS수신 동의로 이벤트 문자수신에 동의하신 고객님들께만 이벤트 안내 문자를 발송해 드립니다.</p>
						 </td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="cont">
			<strong class="title_text">기본 배송지 정보
			<a id="transBtn"  class="btn04" data-fancybox-type="iframe"  href="javascript:;">배송지관리</a>
			</strong>
			<c:if test="${!empty yTransMap}">
				<table class="tsytle" summary="배송지">
				    <tbody>
				        <tr>
				            <th>배송지 이름</th>
				            <td id="dr_area">${yTransMap.transNm}</td>
				        </tr>
				        <tr>
				            <th>받으시는 분</th>
				            <td id="dr_name">${yTransMap.transRevNm}</td>
				        </tr>
				        <tr>
				            <th>주소</th>
				            <td id="dr_addr">(&nbsp;${yTransMap.mbrZipcode}&nbsp;)&nbsp;${yTransMap.mbrAddr}&nbsp;${yTransMap.mbrAddrDtl}</td>
				        </tr>
				        <tr>
				            <th>전화번호</th>
				            <td id="dr_tel">${yTransMap.mbrPhone}</td>
				        </tr>
				        <tr>
				            <th>휴대폰 번호</th>
				            <td id="dr_phone">${yTransMap.mbrMobile}</td>
				        </tr>
				    </tbody>
				</table>
			</c:if>
			<c:if test="${empty yTransMap}">
				<p>등록된 기본 배송지가 없습니다</p>
			</c:if>
		</div>

		<!--
		<div class="privacy">
			<strong class="title_text">개인정보 수집/이용 동의</strong>
            <p style="color:red; font-weight:bold;">* 동의를 거부하시는 경우에도 듀오락몰 서비스는 이용하실 수 있습니다.</p>
                <table>
                  <tr>
                    <th width="33%" scope="col" >항목</th>
                    <th bgcolor="#76bdc8" scope="col" >수집 및 이용 목적</th>
                    <th bgcolor="#76bdc8" scope="col">보유 및 이용기간</th>
                  </tr>
                  <tr>
                    <td width="33%" align="center">추천인 아이디</td>
                    <td align="center">맞춤 서비스 제공</td>
                    <td align="center">회원 탈퇴 후 5일까지</td>
                  </tr>
                </table>
            <input type="radio" name="m_info_collect_yn" value="1" ><label for="">동의합니다.</label>
            <input style="margin-left:30px;" type="radio" name="m_info_collect_yn" value="0"  checked ><label for="">동의하지 않습니다.</label>
		</div>
        -->
		<div class="btn_wrap">
                  <input type="submit" class="btn01" src="common/img/icon/join_end.png" value="확인">
			<a class="btn01_1" href="/ISDS/user/mypage.do">취소</a>
		</div>
		</form>
	</div>

          <form name="vnoform" method="post">
          <input type="hidden" name="enc_data">
          <!-- 인증받은 사용자 정보 암호화 데이타입니다. -->
          <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다.
               해당 파라미터는 추가하실 수 없습니다. -->
          <input type="hidden" name="param_r1" value="">
          <input type="hidden" name="param_r2" value="">
          <input type="hidden" name="param_r3" value="">
          </form>

	<!--=============== #CONNTENTS ===============-->
</div>
<!--=============== #CONTAINER ===============-->


</body>