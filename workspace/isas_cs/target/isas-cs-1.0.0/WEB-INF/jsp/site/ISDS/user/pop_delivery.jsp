<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<link rel="stylesheet" media="all" type="text/css" href="/common/css/mediaquery.css?ver=20160827">

<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javaScript" defer="defer">
	$(document).ready(function() {
		$(".numberOnly").keyup(function(){
			$(this).val( $(this).val().replace(/[^0-9]/g,"") );
			$(this).val( $(this).val().replace(/[^\!-z]/g,"") );
		});
	});

	function init(){
		fnEvent();

		$("#transSeq").val('${yTransMap.transInfoSeq}');

		if($("#transInfoSeq").val()!=""){
			$(".delivery").slideToggle(300);
		}

	}

	function fnEvent(){

		$('#addBtn').click(function() {
			$(".delivery").slideToggle(300);
		});

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
// 	                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                    extraAddr = (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
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

		$("#addTrans").click(function(){
			if ($.trim(document.f.transNm.value) == ''){
				alert("배송지 이름을 입력해주세요");
				$(document.f.transNm).focus();
		    	return false;
			}
			if ($.trim(document.f.TransRevNm.value) == ''){
			    alert("받으시는 분을 입력해주세요.");
			    $(document.f.TransRevNm).focus();
		    	return false;
			}
			if (document.f.mbrZipcode.value == '' || document.f.mbrAddr.value == '') {
			    alert("주소를 검색하여 입력해 주십시오.");
			    $("#addrBtn").focus();
			    return false;
			}
			if ($.trim(document.f.mbrAddrDtl.value) == ''){
			    if (!confirm("상세주소가 없으십니까?")) {
			    	$(document.f.mbrAddrDtl).focus();
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
			document.f.action = "pop_deliverySave.action";
	       	document.f.submit();
		});

		$("#ynBtn").click(function(){
			if(!$("#transSeq").val()){
				alert("기본 배송지를 선택해 주세요!");
				return false;
			}
			document.ynForm.action = "pop_deliveryYn.action";
	       	document.ynForm.submit();
		});

	}

	function ynState(seq){
		$("#transSeq").val(seq);
	}

	function goModify(seq){
		$("#transSeq").val(seq);
		document.ynForm.action = "pop_delivery.action?mbrId=${mbrId}";
       	document.ynForm.submit();
	}

</script>
</head>
<body class="noBg">
	<div class="popup_wrap">
		<div class="user">
		<div id="layer" class="cont">
			<div class="pop-container">
				<div class="pop-cont">

					<div class="title">
						<strong>배송지 관리</strong>
					</div>

					<div class="pcont">
						<ul class="top_info">
							<li>선택하신배송지를 기본 배송지로 설정합니다.</li>
							<li>배송지는 기본주소 포함 최대 4개까지 등록 가능하며, 제품 구매시 장바구니에서 선택 및 수정이 가능합니다.</li>
						</ul>

						<form name="f" method="post" class="ship_addex01">
						<input type="hidden" name="transInfoSeq" id="transInfoSeq" value="${viewMap.transInfoSeq}" />
						<div class="delivery">
							<table class="tsytle tbl_res4">
								<colgroup>
									<col width="30%">
									<col width="70%">
								</colgroup>
								<tbody>
									<tr>
										<th>배송지 이름</th>
										<td><input type="text" name="transNm" id="transNm" maxlength="5" value="${viewMap.transNm}"><span class="etc_text">(5자 내외)</span></td>
									</tr>
									<tr>
										<th>받으시는 분</th>
										<td><input type="text" name="TransRevNm" id="transRevNm" maxlength="5" value="${viewMap.transRevNm}"><span class="etc_text">(5자 내외)</span></td>
									</tr>
									<tr>
										<th>전화번호</th>
										<td class="call">
											<html:selectList name='mbrPhone1' id='mbrPhone1' selectedValue="${fn:split(viewMap.mbrPhone,'-')[0]}" optionValues='|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' optionNames='선택|02|031|032|033|041|042|043|044|051|052|053|054|055|061|062|063|064|070|050' script='class="pay_input_size07"'/>
											<span class="etc_text">-</span>
											<input type="text" class="numberOnly" name="mbrPhone2" id="mbrPhone2" maxlength="4" value="${fn:split(viewMap.mbrPhone,'-')[1]}" />
											<span class="etc_text">-</span>
											<input type="text" class="numberOnly" name="mbrPhone3" id="mbrPhone3" maxlength="4" value="${fn:split(viewMap.mbrPhone,'-')[2]}" /> <!-- required="true!받는분 일반전화를 입력해주세요" -->
										</td>
									</tr>
									<tr>
										<th>휴대폰 번호</th>
										<td class="call call1">
											<html:selectList name='mbrMobile1' id='mbrMobile1' selectedValue="${fn:split(viewMap.mbrMobile,'-')[0]}" optionValues='|010|011|016|017|018|019' optionNames='선택|010|011|016|017|018|019' script='class="pay_input_size07"'/>
											<span class="etc_text">-</span>
											<input type="text" class="numberOnly" name="mbrMobile2" id="mbrMobile2" maxlength="4" value="${fn:split(viewMap.mbrMobile,'-')[1]}" />
											<span class="etc_text">-</span>
											<input type="text" class="numberOnly" name="mbrMobile3" id="mbrMobile3" maxlength="4" value="${fn:split(viewMap.mbrMobile,'-')[2]}" /><!-- required="true!받는분 휴대폰을 입력해주세요" -->
										 </td>
									</tr>
									<tr>
										<th>주소</th>
										<td class="float add">
											<input type="text" name="mbrZipcode" id="mbrZipcode" maxlength="7" value="${viewMap.mbrZipcode}" readonly/>
		                                    <a id="addrBtn" class="btn03" href="javascript:;">우편번호찿기</a>
		                                    <p><input type="text" id="mbrAddr" name="mbrAddr" value="${viewMap.mbrAddr}" readonly/></p>
											<p style="clear:both;padding-top:2px">
		                                    <span id="dr_addr1_sub" style="color:#999"></span>
		                                    <span id="guide" style="color:#999; display:none"></span>
											</p>
		                                    <p><input type="text" id="mbrAddrDtl" maxlength="200" name="mbrAddrDtl" value="${viewMap.mbrAddrDtl}" /></p>
										</td>
									</tr>
								</tbody>
							</table>
							<p class="popup_btnbox">
								<input type="submit" id="addTrans" class="btn01" value="확인" />
								<a href="pop_delivery.action?mbrId=${mbrId}" class="btn01_1">취소하기</a>
							</p>
						</div>
						</form>

						<form name="ynForm" method="post">
							<input type="hidden" name="transSeq" id="transSeq" />
						</form>
						<c:if test="${empty viewMap}">
						<div class="bostyle01 pop_delivery">
							<table class="table_wrap" cellpadding="0" cellspacing="0">
								<colgroup>
									<col width="8%">
									<col width="12%">
									<col width="12%">
									<col width="38%">
									<col width="15%">
									<col width="15%">
								</colgroup>
								<thead>
									<tr>
										<th>기본배송지</th>
										<th>배송지명</th>
										<th>받는사람</th>
										<th>주소</th>
										<th>전화번호</th>
										<th>관리</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${deliveryList}" var="deliveryList" varStatus="status">
										<tr>
											<td><strong class="dn_pc">기본 : </strong> <input type="radio" name="basicTransYn" value="Y" <c:if test="${deliveryList.basicTransYn eq 'Y'}">checked="checked"</c:if> onclick="ynState('${deliveryList.transInfoSeq}');"></td>
											<td><strong class="dn_pc">배송지명 : </strong> <a href="#" onclick="do_sel(12486, this);">${deliveryList.transNm}</a></td>
											<td><strong class="dn_pc">받는사람 : </strong> <a href="#" onclick="do_sel(12486, this);">${deliveryList.transRevNm}</a></td>
											<td class="re_basic06">
												<strong class="dn_pc">주소 : </strong> ${deliveryList.mbrAddr}&nbsp;${deliveryList.mbrAddrDtl}
											</td>
											<td>
												<strong class="dn_pc">전화번호 : </strong> ${deliveryList.mbrMobile}
											</td>
											<td class="re_basic07">
												<strong class="dn_pc">관리 : </strong>
												<a class="btn04 toggle" href="javascript:;" onclick="goModify(${deliveryList.transInfoSeq});">수정</a>
												<a class="btn04" href="pop_deliveryDel.action?transInfoSeq=${deliveryList.transInfoSeq}" >삭제</a>
											</td>
										</tr>
									</c:forEach>
								</tbody>
							</table>
							<p class="popup_btnbox">
								<a href="#" id="ynBtn" class="btn01">배송지로 선택</a>
								<a href="#" class="toggle btn01" id="addBtn">배송지 추가</a>
							</p>
							<p class="popup_btnbox">
								<a href="javascript:parent.$.fancybox.close();" class="btn01_1 m_mt20">닫기</a>
							</p>
						</div>
						</c:if>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
</body>
</html>