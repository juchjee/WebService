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
			var _dts = ['copnUseStartDt', 'copnUseEndDt'];
			for (var i = 0; i < _dts.length; i++) {
				var _dtName = _dts[i];
				var _dtObj = data[_dtName];
				if (_dtObj) {
					if($.isArray(_dtObj)){
						dateTimeInput(_dtName, {disabled: true}, _dtObj[0]);
					}else{
						if(_dtObj.length > 10){
							dateTimeInput(_dtName, {disabled: true}, _dtObj.substring(0, 10));
						}else{
							dateTimeInput(_dtName, {disabled: true}, _dtObj);
						}
					}
				}else{
					dateTimeInput(_dtName, {disabled: true}, '');
				}
			}
		}

		function fnEvent(){
			$("input[name='copnTargetAobn']").change(function() {//발행조건
				var radioValue = $(this).val();
				$("#eCopnPart4").find("select").each(function(){
					$(this).change();
					$(this).attr("disabled",true);
				});
			});
			$("input[name='copnLimitTpApmd']").change(function() {//쿠폰사용기간 AP
				var radioValue = $(this).val();
				if (radioValue == "A") {//무제한
					$("#copnValidityText").hide();
				} else if (radioValue == "P") {//고정기간
					$("#copnValidityText").hide();
				} else{
					if (radioValue == "M") {//월단위
						$("#copnValidityText").text('개월간');
					} else if (radioValue == "D") {//일단위
						$("#copnValidityText").text('일간');
					}
					$("#copnValidityText").show();
				}
			});
			$("input[name='copnDisTpRap']").change(function() {//할인방식_RAP
				var radioValue = $(this).val();
				if (radioValue == "P") {//상품증정
					$("#copnDisVal").hide();
					$("#copnDisValSpan").hide();
					$("#eCopnPtProdA").show();
					$("#eCopnPtProdDiv").show();
					$("#eCopnPtProdMpg").show();
				}else{
					if (radioValue == "R") {//비율할인
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
			// 개별조건등록
			$("#partTpPmda").change(function() {//기간타입_PMD
				var radioValue = $(this).val();
				if (radioValue == "A") {//전체
					$("#periodText").hide();
				}else if (radioValue == "P") {//고정기간
					$("#periodText").hide();
				} else{
					if (radioValue == "M") {//월단위
						$("#periodText").text('개월간');
					} else if (radioValue == "D") {//일단위
						$("#periodText").text('일간');
					}
					$("#periodText").show();
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
				$(this).attr("disabled",true);
			});
			$("input:text").each(function() {
				var checkName = $(this).attr('name');
				var dataValue = data[checkName];
				if (dataValue) {
					$(this).val(dataValue);
				}
				$(this).attr("disabled",true);
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

		function update(flag) {
			var msg = '';
			if(flag == 'Y') msg = '신규 쿠폰 발행을 종료 하시겠습니까?';
			else  msg = '신규 쿠폰 발행을 재개 하시겠습니까?';
			if(confirm(msg)){
				$("#copnFlagYn").val(flag);
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
		<h2>다운용 쿠폰 상세</h2>
		<div class="table_type2 pageContScroll_st2">
	<form id="workForm" name="workForm" action="amM402DSave.action" method="post" >
		<input name="copnCd" type="hidden" value="${copnCd}">
		<input name="copnTpPdmc" type="hidden" value="D">
		<input id="copnFlagYn" name="copnFlagYn" type="hidden" value="">
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
					<th scope="row">쿠폰종류</th>
						<td>${copnTpPdmm}</td>
					</tr>
<!-- 					<tr> -->
<!-- 						<th scope="row">발행조건</th> -->
<!-- 						<td> -->
<!-- 							<input type="radio" name="copnTargetAobn" id="copnTargetAobn1" value="A" /><label for="copnTargetAobn1">일반조건</label> -->
<!-- 							<input type="radio" name="copnTargetAobn" id="copnTargetAobn2" value="O" class="marL10" /><label for="copnTargetAobn2">개별조건</label> -->
<!-- 							<span>&nbsp;&nbsp;&nbsp;※ 일반조건 일때 전체등급에게 발행 됩니다.</span> -->
<!-- 						</td> -->
<!-- 					</tr> -->
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
							<div class="fl" style="line-height:28px;margin-right:10px;">
								<input type="radio" name="copnLimitTpApmd" id="copnLimitTpApmd3" value="M" /><label for="copnLimitTpApmd3">월단위</label>
								<input type="radio" name="copnLimitTpApmd" id="copnLimitTpApmd4" value="D" class="marL10" /><label for="copnLimitTpApmd4" >일단위</label>
							</div>
							<div class="fl" style="margin-right:5px;line-height:30px">
								<input type="text" id="copnValidity" name="copnValidity" class="alignR validation[number]" style="width:80px;">
								<span id="copnValidityText" class="copnValidityText"></span>
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
							<a id="eCopnPtProdA" class="btn_type1" onclick="return false;">증정상품</a>
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
					<tr>
						<th scope="row">발행수량</th>
						<td>
							<input type="radio" name="copnIsuTpUl" id="copnIsuTpUl1" value="U" /><label for="copnIsuTpUl1">무제한</label>
							<input type="radio" name="copnIsuTpUl" id="copnIsuTpUl2" value="L" class="marL10" /><label for="copnIsuTpUl2" >한정수량</label>
							<span class="marL30"><input id="copnIsuQty" name="copnIsuQty" type="text" class="marR5 alignR validation[number]" style="width:50px;" />개</span>
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
		</div>

<!-- 		<h3 id="eCopnPart1" class="fl">개별조건등록</h3> -->
<%-- 		<c:import url="/WEB-INF/jsp/site/mng/popup/partCondition.jsp" /> --%>
	</form>
	</div>
		<!-- // table_type2 -->
		<div class="btn_area">
			<div class="center">
				<a class="btn_blue_line2" href="#" onclick="return update('${copnFlagYn}');"><c:if test="${copnFlagYn eq 'Y'}">신규발행종료</c:if><c:if test="${copnFlagYn eq 'N'}">신규발행재개</c:if></a>
				<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">닫기</a>
			</div>
		</div>
	</div>
</body>
</html>