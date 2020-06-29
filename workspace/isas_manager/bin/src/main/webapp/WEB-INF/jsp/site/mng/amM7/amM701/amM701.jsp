<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

<!-- 설정관리 : 회사기본정보설정 -->

<script type="text/javaScript" defer="defer">
	var contUrl = "${rootUri}${conUrl}amM701";

	/* function init(){
		
	} */

	$("#document").ready(function(){

		if($("#companyBizNo").val() != ""){
			$("#companyBizNo1").val($("#companyBizNo").val().substring(0,3));
			$("#companyBizNo2").val($("#companyBizNo").val().substring(3,5));
			$("#companyBizNo3").val($("#companyBizNo").val().substring(5,10));
		}

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
	                    extraAddr = (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                }

	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('companyZipcode').value = data.zonecode; //5자리 새우편번호 사용
	                document.getElementById('companyAddr').value = fullAddr;

	                // 커서를 상세주소 필드로 이동한다.
	                document.getElementById('companyAddrDtl').value = extraAddr;
	                document.getElementById('companyAddrDtl').focus();

		        }
		    }).open();
		});
	});

</script>
</head>
<body>

	<div class="pageContScroll_st1">
	<form id="workForm" name="workForm" action="amM701Save.action" method="post">
	<input type="hidden" name="companyRegKey" id="companyRegKey" value="${amM701Com.companyRegKey}" />
	<h3>일반정보 등록</h3>
	<div class="table_type2">
		<table>
			<caption>상호, 대표자, 사업자등록번호, 유선연락처, 이메일 발송자명, 대표 이메일 주소, 업태, 종목, 주소, 통신판매신고번호, 개인정보관리자, 기타신고번호, 팩스번호, 고객상담실전화번호로 구성된 일반정보 등록에 대한 작성 테이블 입니다.</caption>
			<colgroup>
				<col style="width:10%;" />
				<col style="width:40%;" />
				<col style="width:10%;" />
				<col style="width:40%;" />
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">상호</th>
					<td>
						<input type="text" name="companyNm" id="companyNm" value="${amM701Com.companyNm}" style="width:154px" />
					</td>
					<th scope="row">대표자</th>
					<td>
						<input type="text" name="companyOwner" id="companyOwner" value="${amM701Com.companyOwner}" style="width:154px" />
					</td>
				</tr>
				<tr>
					<th scope="row">사업자등록번호</th>
					<td>
						<input type="text" class="validation[numberOnlyLeft]" id="companyBizNo1" name="companyBizNo1" maxlength="3" style="width:50px" /> - <input id="companyBizNo2" name="companyBizNo2" type="text" class="validation[numberOnlyLeft]" maxlength="2"  style="width:50px" /> - <input type="text" class="validation[numberOnlyLeft]" id="companyBizNo3" name="companyBizNo3" maxlength="5" style="width:100px" />
						<input type="hidden" id="companyBizNo" name="companyBizNo" value="${amM701Com.companyBizNo}" />
					</td>
					<th scope="row">유선연락처</th>
					<td>
						<input type="text" name="companyTel" id="companyTel" value="${amM701Com.companyTel}" style="width:154px;" />
					</td>
				</tr>
				<tr>
					<th scope="row">이메일 발송자명</th>
					<td>
						<input type="text" name="companyEmailSender" id="companyEmailSender" value="${amM701Com.companyEmailSender}" style="width:154px" />
					</td>
					<th scope="row">대표 이메일 주소</th>
					<td>
						<input type="text" name="companyEmail" id="companyEmail" value="${amM701Com.companyEmail}" style="width:154px" />
					</td>
				</tr>
				<tr>
					<th scope="row">업태</th>
					<td>
						<input type="text" name="companyCategory" id="companyCategory" value="${amM701Com.companyCategory}" style="width:154px" />
					</td>
					<th scope="row">종목</th>
					<td>
						<input type="text" name="companyEvent" id="companyEvent" value="${amM701Com.companyEvent}" style="width:154px" />
					</td>
				</tr>
				<tr>
					<th scope="row">주소</th>
					<td colspan="3">
						<input type="text" readonly="readonly" name="companyZipcode" id="companyZipcode" value="${amM701Com.companyZipcode}" style="width:48px;" />
						<input type="text" readonly="readonly" name="companyAddr" id="companyAddr" value="${amM701Com.companyAddr}" class="marL10" style="width:372px;" />
						<input type="text" name="companyAddrDtl" id="companyAddrDtl" value="${amM701Com.companyAddrDtl}" class="marL10" style="width:244px;" />
						<a class="addrS btn_type1 marL10" href="javascript:;">주소검색</a>
					</td>
				</tr>
				<tr>
					<th scope="row">통신판매신고번호</th>
					<td>
						<input type="text" name="companyTelesalesNo" id="companyTelesalesNo" value="${amM701Com.companyTelesalesNo}" style="width:154px" />
					</td>
					<th scope="row">개인정보관리자</th>
					<td>
						<input type="text" name="companyPrivacyAdm" id="companyPrivacyAdm" value="${amM701Com.companyPrivacyAdm}" style="width:154px" />
					</td>
				</tr>
				<tr>
					<th scope="row">기타신고번호</th>
					<td colspan="3">
						신고종목 <input type="text" name="companyOtherRegNm" id="companyOtherRegNm" value="${amM701Com.companyOtherRegNm}" class="marL10" style="width:200px;" />
						신고번호 <input type="text" name="companyOtherRegNo" id="companyOtherRegNo" value="${amM701Com.companyOtherRegNo}" class="marL10" style="width:200px;" />
					</td>
				</tr>
				<tr>
					<th scope="row">팩스번호</th>
					<td>
						<input type="text" name="companyFax" id="companyFax" value="${amM701Com.companyFax}" style="width:154px" />
					</td>
					<th scope="row">고객상담실전화번호</th>
					<td>
						<input type="text" name="companyCsTel" id="companyCsTel" value="${amM701Com.companyCsTel}" style="width:154px" />
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	</form>
	<!-- // table_type2 -->
	<div class="btn_area"  style="margin:0 0 0 0;">
		<div class="center">
			<a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">저장</a>
		</div>
	</div>

	<br/><br/>
	</div>

</body>