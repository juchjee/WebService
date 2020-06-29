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
			parent.fnCallBackHandler && parent.fnCallBackHandler(855, 355);
		})();

		function init(){
			fnSearchInit();
			//fnSearch();
			fnEvent();
			fnExecEvent();
		}

		function fnSearchInit(){
			var _dts = ['copnUseStartDt', 'copnUseEndDt'];
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
			$("input[name='copnLimitTpApmd']").change(function() {//쿠폰사용기간 AP
				var radioValue = $(this).val();
				if (radioValue == "A") {//무제한
					$("#copnUseEndDt").jqxDateTimeInput({disabled: true});
				} else if (radioValue == "P") {//고정기간
					$("#copnUseEndDt").jqxDateTimeInput({disabled: false});
				}
			});
			$("input[name='copnDisTpRap']").change(function() {//할인방식_RAP
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
			$("input[name='copnIsuTpUl']").change(function() {//발행수량
				var radioValue = $(this).val();
				if (radioValue == "U") {//무제한
					$("#copnIsuQty").attr("disabled",true);
				} else if (radioValue == "L") {//한정수량
					$("#copnIsuQty").attr("disabled",false);
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
			var copnLimitTpApmd = $("input:radio[name='copnLimitTpApmd']:checked").val();//쿠폰사용기간
			if (copnLimitTpApmd == 'A') {//쿠폰사용기간 무제한 일 경우
				var copnUseStartDt = $("#copnUseStartDt").val();
				if (!copnUseStartDt && copnUseStartDt.length < 10) {//쿠폰사용 시작 일 체크
					alert(message(MESSAGES_VALID.REQUIRED, [ '쿠폰사용기간' ]));
					$('#copnUseStartDt').jqxDateTimeInput('focus');
					return false;
				}
			} else {
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
		<h2>CS쿠폰 등록</h2>
		<div class="table_type2 pageContScroll_st2">
	<form id="workForm" name="workForm" action="amM402CSave.action" method="post" >
		<input name="copnCd" type="hidden" value="${copnCd}" />
		<input name="copnTpPdmc" type="hidden" value="C" />
		<input name="copnTargetAobn" type="hidden" value="A" />
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
						<th scope="row">쿠폰사용기간</th>
						<td>
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
				</tbody>
			</table>

			<input type="hidden" name="copnIsuTpUl"  value="U" />
		</div>
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