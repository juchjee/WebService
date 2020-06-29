<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_fancybox.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx_core.jsp" />
	<script type="text/javaScript" defer="defer">
	<!--
		var contUrl = "${rootUri}${conUrl}amM201";
		(function(){
			parent.fnCallBackHandler && parent.fnCallBackHandler(855, 605);
		})();

		function init(){
			fnSearchInit();
			//fnSearch();
			fnEvent();
			fnExecEvent();
		}

		function fnSearchInit(){
			var _dts = ['copnUseStartDt', 'copnUseEndDt', 'purchaseStartDt', 'purchaseEndDt'];
			for (var i = 0; i < _dts.length; i++) {
				var _dtName = _dts[i];
				var _dtObj = data[_dtName];
				if (_dtObj) {
					if($.isArray(_dtObj)){
						dateTimeInput(_dtName, null, _dtObj[0]);
					}else{
						if(_dtObj.length > 10){
							dateTimeInput(_dtName, null, _dtObj.substring(0, 10));
						}else{
							dateTimeInput(_dtName, null, _dtObj);
						}
					}
				}else{
					if(_dts[i] == 'copnUseStartDt'){
						dateTimeInput(_dtName, null, "${nowYmd}");
					}else{
						dateTimeInput(_dtName);
					}
				}
			}
		}

		function fnEvent(){
			$("input:radio[name='copnLimitTpApmd']").bind("click", function(){//쿠폰사용기간 AP
				var radioValue = $(this).val();
				if (radioValue == "A") {//무제한
					$("#copnUseStartDt").jqxDateTimeInput({disabled: false});
					$("#copnUseEndDt").jqxDateTimeInput({disabled: true});
					$("#copnValidity").attr("disabled",true);
					$("#copnValidityText").hide();
				} else if (radioValue == "P") {//고정기간
					$("#copnUseStartDt").jqxDateTimeInput({disabled: false});
					$("#copnUseEndDt").jqxDateTimeInput({disabled: false});
					$("#copnValidity").attr("disabled",true);
					$("#copnValidityText").hide();
				} else{
					if (radioValue == "M") {//월단위
						$("#copnValidityText").text('개월간');
					} else if (radioValue == "D") {//일단위
						$("#copnValidityText").text('일간');
					}
					$("#copnUseStartDt").jqxDateTimeInput({disabled: true});
					$("#copnUseEndDt").jqxDateTimeInput({disabled: true});
					$("#copnValidity").attr("disabled",false);
					$("#copnValidityText").show();
				}
			});
			$("input:radio[name='copnTargetAobn']").bind("click", function() {//발행조건
				var radioValue = $(this).val();
				if (radioValue == "A") {//일반조건
					$("#copnTargetAobnAO").find("input:radio").attr("disabled",false);
					$("#copnTargetAobnB").find("input").attr("disabled",true);
					$("#copnTargetAobnN").find("input").attr("disabled",true);
					$("#eCopnPart4").find("input,select").attr("disabled",true);
					$("#purchaseStartDt").jqxDateTimeInput({disabled: true});
					$("#purchaseEndDt").jqxDateTimeInput({disabled: true});
					$("#copnTargetAobnAO").show();
					$("#copnTargetAobnB").hide();
					$("#copnTargetAobnN").hide();
					$("input:radio[name='copnLimitTpApmd']:checked").click();
					$("#eCopnPart2").hide();
					$("#eCopnPart3").hide();
				} else if (radioValue == "O") {//개별조건
					$("#copnTargetAobnAO").find("input:radio").attr("disabled",false);
					$("#copnTargetAobnB").find("input").attr("disabled",true);
					$("#copnTargetAobnN").find("input").attr("disabled",true);
					$("#eCopnPart4").find("input,select").attr("disabled",false);
					$("#eCopnPart4").find("select").each(function(){
						$(this).change();
					});
					$("#copnTargetAobnAO").show();
					$("#copnTargetAobnB").hide();
					$("#copnTargetAobnN").hide();
					$("input:radio[name='copnLimitTpApmd']:checked").click();
					$("#eCopnPart2").show();
					$("#eCopnPart3").show();
				} else if (radioValue == "B") {//생일쿠폰
					$("#copnTargetAobnB").find("input").attr("disabled",false);
					$("#copnTargetAobnAO").find("input").attr("disabled",true);
					$("#copnTargetAobnN").find("input").attr("disabled",true);
					$("#eCopnPart4").find("input,select").attr("disabled",false);
					$("#eCopnPart4").find("select").each(function(){
						$(this).change();
					});
					$("#copnUseStartDt").jqxDateTimeInput({disabled: true});
					$("#copnUseEndDt").jqxDateTimeInput({disabled: true});
					$("#copnValidity").prop("disabled",false);
					$("#copnValidity").prop("readOnly",true);
					$("#copnValidity").val();
					$("#copnTargetAobnAO").hide();
					$("#copnTargetAobnB").show();
					$("#copnTargetAobnN").hide();
					$("#eCopnPart2").show();
					$("#eCopnPart3").show();
				} else if (radioValue == "N") {//신규가입
					$("#copnTargetAobnN").find("input").attr("disabled",false);
					$("#copnTargetAobnAO").find("input").attr("disabled",true);
					$("#copnTargetAobnB").find("input").attr("disabled",true);
					$("#eCopnPart4").find("input,select").attr("disabled",true);
					$("#purchaseStartDt").jqxDateTimeInput({disabled: true});
					$("#purchaseEndDt").jqxDateTimeInput({disabled: true});
					$("#copnValidity").attr("disabled",true);
					$("#copnTargetAobnAO").hide();
					$("#copnTargetAobnB").hide();
					$("#copnTargetAobnN").show();
					$("#eCopnPart2").hide();
					$("#eCopnPart3").hide();
				}
			});
			$("input:radio[name='copnDisTpRap']").bind("click", function() {//할인방식_RAP
				var radioValue = $(this).val();
				if (radioValue == "P") {//상품증정
					$("#copnDisVal").attr("disabled",true);
					$("#copnDisVal").hide();
					$("#copnDisValSpan").hide();
					$("#eCopnPtProdA").show();
					$("#eCopnPtProdDiv").show();
					$("#eCopnPtProdMpg").show();
				}else{
					$("#copnDisVal").attr("disabled",false);
					if (radioValue == "R") {//비율할인
						var copnDisVal = removeComma($("#copnDisVal").val());
						if(copnDisVal.length > 2){
							$("#copnDisVal").val(copnDisVal.substring(0, 2));
						}
						$("#copnDisVal").attr('maxlength', 2);
						$("#copnDisValSpan").text('%');
					} else if (radioValue == 'A') {//금액할인
						$("#copnDisVal").removeAttr('maxlength');
						$("#copnDisValSpan").text('원');
					}
					$("#eCopnPtProdA").hide();
					$("#eCopnPtProdDiv").hide();
					$("#eCopnPtProdMpg").hide();
					$("#copnDisVal").show();
					$("#copnDisValSpan").show();
				}
			});
			$("input:radio[name='copnIsuTpUl']").bind("click", function() {//발행수량
				var radioValue = $(this).val();
				if (radioValue == "U") {//무제한
					$("#copnIsuQty").attr("disabled",true);
				} else if (radioValue == "L") {//한정수량
					$("#copnIsuQty").attr("disabled",false);
				}
			});
			// 개별조건등록
			$("#partTpPmda").change(function() {//기간타입_PMD
				var radioValue = $(this).val();
				if (radioValue == "A") {//전체
					$("#purchaseStartDt").jqxDateTimeInput({disabled: true});
					$("#purchaseEndDt").jqxDateTimeInput({disabled: true});
					$("#period").attr("disabled",true);
					$("#periodText").hide();
				}else if (radioValue == "P") {//고정기간
					$("#purchaseStartDt").jqxDateTimeInput({disabled: false});
					$("#purchaseEndDt").jqxDateTimeInput({disabled: false});
					$("#period").attr("disabled",true);
					$("#periodText").hide();
				} else{
					if (radioValue == "M") {//월단위
						$("#periodText").text('개월간');
					} else if (radioValue == "D") {//일단위
						$("#periodText").text('일간');
					}
					$("#purchaseStartDt").jqxDateTimeInput({disabled: true});
					$("#purchaseEndDt").jqxDateTimeInput({disabled: true});
					$("#period").attr("disabled",false);
					$("#periodText").show();
				}
			});

			//발행간격
			$("input:radio[name='copnIntervalTpOumd']").bind("click", function() {//발행수량
				var radioValue = $(this).val();
				if (radioValue == "O" || radioValue == "U" ) {//일회성, 사용후즉시재발행
					$("#copnInterval").attr("disabled",true);
				} else {//한정수량
					$("#copnInterval").attr("disabled",false);
				}
			});

		}

		function fnExecEvent() {
			$("select").each(function() {
				var checkName = $(this).attr('name');
				var dataValue = data[checkName];
				if (dataValue) {
					$(this).val(dataValue);
				} else {
					$(this).find('option:first').click();
				}
				$(this).change();
			});
			var radioName = "";
			$("input:radio").each(function() {
				if (radioName != $(this).attr('name')) {
					radioName = $(this).attr('name');
					var dataValue = data[radioName];
					if (dataValue) {
						$("input:radio[name='" + radioName + "']:input[value='" + dataValue + "']").click();
					} else {
						$("input:radio[name='" + radioName + "']:eq(0)").click();
					}
				}
			});
			$("input:text").each(function() {
				var checkName = $(this).attr('name');
				var dataValue = data[checkName];
				if (dataValue) {
					$(this).val(dataValue);
				}
			});
			var eCopnPtProdMpgArr = data["eCopnPtProdMpgArr"];
			if(eCopnPtProdMpgArr){
				if(eCopnPtProdMpgArr.length > 0){
					for (var i = 0; i < eCopnPtProdMpgArr.length; i++) {
						var obj = eCopnPtProdMpgArr[i];
						if(obj){
							$("#workForm").append(makeInput("eCopnPtProdMpgArr", obj['prodCd']));
							$("#eCopnPtProdMpg").append("<li><div>"+obj['prodNm']+"</div></li>");
						}
					}
				}
			}
		}

		function save() {
			var copnNm = $("#copnNm").val();//쿠폰명
			if (!copnNm) {
				alert(message(MESSAGES_VALID.REQUIRED, [ '쿠폰명' ]));
				$("#copnNm").focus();
				return false;
			}
			var copnDisTpRap = $("input:radio[name='copnDisTpRap']:checked").val();//할인방식
			if (copnDisTpRap == "R") {//비율할인 일 경우
				var copnDisVal = $("#copnDisVal").val();
				if (!copnDisVal) {
					alert(message(MESSAGES_VALID.REQUIRED, [ '할인방식이 비율할인 일 경우 비율' ]));
					$("#copnDisVal").focus();
					return false;
				}
			} else if (copnDisTpRap == "A") {//금액할인 일 경우
				var copnDisVal = $("#copnDisVal").val();
				if (!copnDisVal) {
					alert(message(MESSAGES_VALID.REQUIRED, [ '할인방식이 금액할인 일 경우 금액' ]));
					$("#copnDisVal").focus();
					return false;
				}
			} else {//증정 상품명 일 경우
				var eCopnPtProdMpgArr = $("input:hidden[name='eCopnPtProdMpgArr']");//증정 상품명
				if (eCopnPtProdMpgArr.length < 1) {
					alert(message(MESSAGES_ERR.LENGTH_FAIL, ['할인방식이 증정상품 일 경우 증정상품', '하나' ]));
					$("#eCopnPtProdA").focus();
					return false;
				}
			}
			var copnIsuTpUl = $("input:radio[name='copnIsuTpUl']:checked").val();//발행수량
			if (copnIsuTpUl == "L") {
				var copnIsuQty = $("#copnIsuQty").val();
				if (!copnIsuQty) {
					alert(message(MESSAGES_VALID.REQUIRED, [ '발행수량 한정수량 일 경우 발행 수량' ]));
					$("#copnIsuQty").focus();
					return false;
				}
			}
			var copnTargetAobn = $("input:radio[name='copnTargetAobn']:checked").val();//발행조건
			if (copnTargetAobn == 'A' || copnTargetAobn == 'O') {//발행조건이 일반조건이나 개별조건일 경우
				var copnLimitTpApmd = $("input:radio[name='copnLimitTpApmd']:checked").val();//쿠폰사용기간
				if (copnLimitTpApmd == 'A') {//쿠폰사용기간 무제한 일 경우
					var copnUseStartDt = $("#copnUseStartDt").val();
					if (!copnUseStartDt && copnUseStartDt.length < 10) {//쿠폰사용 시작 일 체크
						alert(message(MESSAGES_VALID.REQUIRED, [ '쿠폰사용기간' ]));
						$('#copnUseStartDt').jqxDateTimeInput('focus');
						return false;
					}
				} else if (copnLimitTpApmd == 'P') {//쿠폰 사용 기간이 고정기간 일 경우
					var copnUseStartDt = $("#copnUseStartDt").val();
					var copnUseEndDt = $("#copnUseEndDt").val();
					if (!copnUseStartDt && copnUseStartDt.length < 10) {//쿠폰사용 시작 일 체크
						alert(message(MESSAGES_VALID.REQUIRED, [ '쿠폰사용기간 시작일' ]));
						$('#copnUseStartDt').jqxDateTimeInput('focus');
						return false;
					}
					if (!copnUseEndDt && copnUseEndDt.length < 10) {//쿠폰사용 끝 일 체크
						alert(message(MESSAGES_VALID.REQUIRED, [ '쿠폰사용기간 마지막일' ]));
						$('#copnUseEndDt').jqxDateTimeInput('focus');
						return false;
					}
				} else if (copnLimitTpApmd == 'M') {//쿠폰 사용 기간이 월단위 일 경우
					var copnValidity = $("#copnValidity").val();//쿠폰 사용 기간
					if (!copnValidity) {
						alert(message(MESSAGES_VALID.REQUIRED, [ '쿠폰 사용 개월' ]));
						$("#copnValidity").focus();
						return false;
					}
				} else if (copnLimitTpApmd == 'D') {//쿠폰 사용 기간이 일다위 일 경우
					var copnValidity = $("#copnValidity").val();//쿠폰 사용 기간
					if (!copnValidity) {
						alert(message(MESSAGES_VALID.REQUIRED, [ '쿠폰 사용 일' ]));
						$("#copnValidity").focus();
						return false;
					}
				}
				if(copnTargetAobn == 'O'){// 개별조건일 경우
					var partTpPmda = $("#partTpPmda").val();
					if (partTpPmda == "P") {//고정기간
						var purchaseStartDt = $("#purchaseStartDt").val();
						var purchaseEndDt = $("#purchaseEndDt").val();
						if (!purchaseStartDt && purchaseStartDt.length < 10) {//쿠폰사용 시작 일 체크
							alert(message(MESSAGES_VALID.REQUIRED, [ '개별조건이 고정기간 일 경우 시작 일' ]));
							$('#purchaseStartDt').jqxDateTimeInput('focus');
							return false;
						}
						if (!purchaseEndDt && purchaseEndDt.length < 10) {//쿠폰사용 끝 일 체크
							alert(message(MESSAGES_VALID.REQUIRED, [ '개별조건이 고정기간 일 경우 마지막 일' ]));
							$('#purchaseEndDt').jqxDateTimeInput('focus');
							return false;
						}
					} else if (partTpPmda == "M") {//월단위
						var period = $("#period").val();
						if (!period) {
							alert(message(MESSAGES_VALID.REQUIRED, [ '개별조건이 월단위 일 경우 개월' ]));
							$('#period').focus();
							return false;
						}
					} else if (partTpPmda == "D") {//일단위
						var period = $("#period").val();
						if (!period) {
							alert(message(MESSAGES_VALID.REQUIRED, [ '개별조건이 일단위 일 경우 일' ]));
							$('#period').focus();
							return false;
						}
					}
				}
			}else if(copnTargetAobn == 'B') {//발행조건이 생일 일 경우
				var copnBeforDayB = $("#copnBeforDayB").val();
				if (!copnBeforDayB) {
					alert(message(MESSAGES_VALID.REQUIRED, [ '발행조건이 생일 일 경우 생일 전 일' ]));
					$('#copnBeforDayB').focus();
					return false;
				}
				var copnAfterDayB = $("#copnAfterDayB").val();
				if (!copnAfterDayB) {
					alert(message(MESSAGES_VALID.REQUIRED, [ '발행조건이 생일 일 경우 생일 후 일' ]));
					$('#copnAfterDayB').focus();
					return false;
				}
				$("#copnValidity").val(parseInt($("#copnBeforDayB").val()) + parseInt($("#copnAfterDayB").val()));
				$("#workForm").append('<input type="hidden" name="copnLimitTpApmd" value="D"/>');
			}else if(copnTargetAobn == 'N') {//발행조건이 신규가입 일 경우
				var copnAfterDayN = $("#copnAfterDayN").val();
				if (!copnAfterDayN) {
					alert(message(MESSAGES_VALID.REQUIRED, [ '발행조건이  신규가입 일 경우 신규가입 후 일' ]));
					$('#copnAfterDayN').focus();
					return false;
				}
			}

			if(confirm('<spring:message code="common.regist.msg"/>')){
				$("input[class*=validation]").each(function(index, value){
					if($(this).is(":disabled") == false){
						if($(this).attr("class").indexOf("number") > -1){
							$(this).val(removeComma($(this).val()));
							$(this).unbind("keyup");
						}
					}
				});
				$('#workForm').submit();
			}
			return false;
		}
		var data = ${dataMap};
	//-->
	</script>
</head>
<body class="noBg">
	<div class="popup_wrap" style="background: #fff">
		<h2>회원 쿠폰 등록</h2>
		<div class="table_type2 pageContScroll_st2">
	<form id="workForm" name="workForm" action="amM402MSave.action" method="post" >
		<input name="copnCd" type="hidden" value="${copnCd}">
		<input name="copnTpPdmc" type="hidden" value="M">
		<div class="table_type2">
			<table>
				<caption>쿠폰명, 쿠폰종류, 발생대상, 쿠폰사용기간, 할인방식, 사용방식, 발행수량으로 구성된 쿠폰등록에 대한 작성 테이블 입니다.</caption>
				<colgroup>
					<col style="width:120px;">
					<col style="width:3*">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">쿠폰명</th>
						<td>
							<input type="text" id="copnNm" name="copnNm" maxlength="50" style="width: 80%;"/>
						</td>
					</tr>
					<tr>
						<th scope="row">발행조건</th>
						<td>
							<input type="radio" name="copnTargetAobn" id="copnTargetAobn1" value="A" /><label for="copnTargetAobn1">일반조건</label>
							<input type="radio" name="copnTargetAobn" id="copnTargetAobn2" value="O" class="marL10" /><label for="copnTargetAobn2">개별조건</label>
							<input type="radio" name="copnTargetAobn" id="copnTargetAobn3" value="B" class="marL10" /><label for="copnTargetAobn3">생일</label>
							<input type="radio" name="copnTargetAobn" id="copnTargetAobn4" value="N" class="marL10" /><label for="copnTargetAobn4" >신규가입</label>
							<span>&nbsp;&nbsp;&nbsp;※ 일반조건 일때 전체등급에게 발행 됩니다.</span>
						</td>
					</tr>
					<tr>
						<th scope="row">쿠폰사용기간</th>
						<td>
							<div id="copnTargetAobnAO">
								<div class="fl" style="line-height:28px;margin-right:10px;">
									<input type="radio" name="copnLimitTpApmd" id="copnLimitTpApmd1" value="A" /><label for="copnLimitTpApmd1">무제한</label>
									<input type="radio" name="copnLimitTpApmd" id="copnLimitTpApmd2" value="P" class="marL10" /><label for="copnLimitTpApmd2" >고정기간</label>
								</div>
								<div id="copnUseDtDiv" class="fl" style="margin-right:5px;line-height:30px">
									<div id='copnUseStartDt' name="copnUseStartDt" style='float:left;'></div>
									<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
									<div id='copnUseEndDt' name="copnUseEndDt" style='float:left;'></div>
									<span>까지</span>
								</div>
								<div class="fl" style="line-height:28px;margin-right:10px;">
									<input type="radio" name="copnLimitTpApmd" id="copnLimitTpApmd3" value="M" /><label for="copnLimitTpApmd3">월단위</label>
									<input type="radio" name="copnLimitTpApmd" id="copnLimitTpApmd4" value="D" class="marL10" /><label for="copnLimitTpApmd4" >일단위</label>
								</div>
								<div class="fl" style="margin-right:5px;line-height:30px">
									<input type="text" id="copnValidity" name="copnValidity" class="alignR validation[number]" style="width:80px;">
									<span id="copnValidityText" class="copnValidityText"></span>
								</div>
							</div>
							<div id="copnTargetAobnB" style="display: none;">
								<div class="fl" style="line-height:28px;margin-right:10px;">
									<span>생일 전</span>
									<input type="text" id="copnBeforDayB" name="copnBeforDay" class="alignR validation[number]" style="width:80px;" placeholder="0">
									<span>일 ~ 생일 후</span>
									<input type="text" id="copnAfterDayB" name="copnAfterDay" class="alignR validation[number]" style="width:80px;" placeholder="0">
									<span>일 까지 사용 가능</span>
								</div>
							</div>
							<div id="copnTargetAobnN" style="display: none;">
								<div class="fl" style="line-height:28px;margin-right:10px;">
									<span>신규가입 후</span>
									<input type="text" id="copnAfterDayN" name="copnAfterDay" class="alignR validation[number]" style="width:80px;" placeholder="0">
									<span>일 까지 사용 가능</span>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">할인방식</th>
						<td>
							<div class="fl" style="line-height:28px;margin-right:10px;">
								<input type="radio" name="copnDisTpRap" id="copnDisTpRap1" value="R" /><label for="copnDisTpRap1">비율할인</label>
								<input type="radio" name="copnDisTpRap" id="copnDisTpRap2" value="A" class="marL10" /><label for="copnDisTpRap2">금액할인</label>
								<input type="text" id="copnDisVal" name="copnDisVal" class="marL5 marR5 alignR validation[number]" style="width:100px;" /><span id="copnDisValSpan"></span>
								<input type="radio" name="copnDisTpRap" id="copnDisTpRap3" value="P" class="marL10" /><label for="copnDisTpRap3">상품증정</label>
							</div>
							<div class="fl add_field"  style="line-height:28px;">
								<a id="eCopnPtProdA" class="fancybox bis btn_type1" data-fancybox-type="iframe" href="/mng/popup/prodSearchPop.do?tp=eCopnPtProd">증정상품검색</a>
					            <div id="eCopnPtProdDiv" class="field_ul">
					               <ul id="eCopnPtProdMpg"></ul>
					            </div>
					            <!-- // field_ul -->
				            </div>
						</td>
					</tr>
					<tr>
						<th scope="row">사용방식</th>
						<td>
							<div class="fl" style="line-height:28px;margin-right:10px;">
								<input type="radio" name="copnUseTpGo" id="copnUseTpGo1" value="G" /><label for="copnUseTpGo1">일반할인</label>
								<input type="radio" name="copnUseTpGo" id="copnUseTpGo2" value="O" class="marL10" /><label for="copnUseTpGo2">중복할인</label>
							</div>
						</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<th scope="row">발행수량</th> -->
<!-- 						<td> -->
<!-- 							<input type="radio" name="copnIsuTpUl" id="copnIsuTpUl1" value="U" /><label for="copnIsuTpUl1">무제한</label> -->
<!-- 							<input type="radio" name="copnIsuTpUl" id="copnIsuTpUl2" value="L" class="marL10" /><label for="copnIsuTpUl2" >한정수량</label> -->
<!-- 							<span class="marL30"><input id="copnIsuQty" name="copnIsuQty" type="text" class="marR5 alignR validation[number]" style="width:50px;" />개</span> -->
<!-- 						</td> -->
<!-- 					</tr> -->
					<tr>
						<th scope="row">발행간격</th>
						<td>
							<div class="fl" style="line-height:28px;margin-right:10px;">
								<input type="radio" name="copnIntervalTpOumd" id="copnIntervalTpOumd1" value="O" /><label for="copnIntervalTpOumd1">일회성</label>
								<input type="radio" name="copnIntervalTpOumd" id="copnIntervalTpOumd2" value="U" class="marL10" /><label for="copnIntervalTpOumd2">사용 후 즉시 재발행</label>
								<input type="radio" name="copnIntervalTpOumd" id="copnIntervalTpOumd3" value="M" class="marL10" /><label for="copnIntervalTpOumd3">월단위</label>
								<input type="radio" name="copnIntervalTpOumd" id="copnIntervalTpOumd4" value="D" class="marL10" /><label for="copnIntervalTpOumd4">일단위</label>
								<input type="text" id="copnInterval" name="copnInterval" class="marL5 marR5 alignR validation[number]" style="width:50px;" />
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">사용제한금액</th>
						<td>
							<input id="copnLimitAmt" name="copnLimitAmt" type="text" class="marR5 alignR validation[number]" style="width:50px;" />원
						</td>
					</tr>
				</tbody>
			</table>

			<input type="hidden" name="copnIsuTpUl"  value="U" />
		</div>

		<h3 id="eCopnPart1" class="fl">개별조건등록</h3>
		<c:import url="/WEB-INF/jsp/site/mng/popup/partCondition.jsp" />
	</form>
	</div>
	<!-- // table_type2 -->
	<div class="btn_area">
		<div class="center">
			<a class="btn_blue_line2" href="#" onclick="return save();">등록</a><a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">닫기</a>
		</div>
	</div>
	</div>
</body>
</html>