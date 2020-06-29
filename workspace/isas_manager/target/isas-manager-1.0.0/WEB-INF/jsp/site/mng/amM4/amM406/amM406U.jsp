<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx_core.jsp" />
	<!-- 마케팅관리 : 팝업관리 -->

	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
	<script type="text/javaScript" defer="defer">

		/*----------------------------------------------------------------------------------------------
		 * 화면 load시 실행 함수 (onload)
		 *----------------------------------------------------------------------------------------------*/
		function init() {
			fnDataSetting();
			fnEvent();
			fnExecEvent();
		}

		/*----------------------------------------------------------------------------------------------
		 * 페이지 이벤트 함수 모음
		 *----------------------------------------------------------------------------------------------*/
		function fnEvent() {
			/*----------------------------- 기본이미지 - 버튼 클릭 이벤트 Start -----------------------------*/
			$("#btnAddFile").bind("click", function() {
				fileSearch({
					fileAttrName : "bannerImg",
					fileViewAttrName : "attchFileNm",
					form : "workForm",
					filetype : 'image'
				});
			});
			$("#btnAddMobileFile").bind("click", function() {
				fileSearch({
					fileAttrName : "bannerMobileImg",
					fileViewAttrName : "attchMobileFileNm",
					form : "workForm",
					filetype : 'image'
				});
			});
			/*----------------------------- 기본이미지 - 버튼 클릭 이벤트 End-----------------------------*/
			$("#bannerLocalCd").change(function(){
				var _bannerSize = eBannerObj[$(this).val()];
				$("#bannerWidthSize").val(_bannerSize["bannerWidthSize"]);
				$("#bannerHeightSize").val(_bannerSize["bannerHeightSize"]);
				$("#bannerMobileWidthSize").val(_bannerSize["bannerMobileWidthSize"]);
				$("#bannerMobileHeightSize").val(_bannerSize["bannerMobileHeightSize"]);
			});
			/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 Start -----------------------------*/
			$.submit = function() {
				if (!$("#bannerImg").val() && !$("input[name='attchFileNm']").val()){
					alert("업로드파일을 등록해주세요!");
					return false;
				}
				var prodIconColor = $("#colorPicker").val().replace(/\#/gi, '');
				$("#backgRoundColor").val(prodIconColor);
				fnSubmit("workForm", "저장");
			}
			/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 End -----------------------------*/
			$("#colorPicker").on('colorchange', function(event) {
				$("#dropDownButton").jqxDropDownButton('setContent', getTextElementByColor(event.args.color));
			});
		}

		function getTextElementByColor(color){
			if (color == 'transparent' || color.hex == "") {
				return $("<div style='text-shadow:none;position:relative;margin:2px 0 2px 0;line-height:22px;'>transparent</div>");
			}
			var element = $("<div style='text-shadow:none;position:relative;margin:2px 0 2px 0;line-height:22px;text-align:center;'>#" + color.hex + "</div>");
			var nThreshold = 105;
			var bgDelta = (color.r * 0.299) + (color.g * 0.587) + (color.b * 0.114);
			var foreColor = (255 - bgDelta < nThreshold) ? 'Black' : 'White';
			element.css('color', foreColor);
			element.css('background', "#" + color.hex);
			element.addClass('jqx-rc-all');
			return element;
		}

		function fnDataSetting() {
			var option = {
				culture : 'ko',
				formatString : 'd',
				width : '140px',
				height : '26px',
				showFooter : true,
				animationType : 'none',
				enableBrowserBoundsDetection : true,
				formatString : 'yyyy-MM-dd HH:mm',
				showTimeButton : false,
				showCalendarButton : true,
				theme : 'custom'
			};
			dateTimeInput("bannerStartDt", option, "${nowYmd}");
			dateTimeInput("bannerEndDt", option);
			$("#colorPicker").jqxColorPicker({
				color : "EFE7DC",
				colorMode : 'hue',
				width : 220,
				height : 220
			});
			$("#dropDownButton").jqxDropDownButton({
				width : 120,
				height : 26
			});
		}

		function fnExecEvent(){
			$("select").each(function() {
				var checkName = $(this).attr('name');
				var dataValue = eBannerListMap[checkName];
				if (dataValue) {
					$(this).val(dataValue);
				} else {
					$(this).find('option:first').click();
				}
				$(this).change();
			});
			$("input:hidden").each(function() {
				var checkName = $(this).attr('name');
				var dataValue = eBannerListMap[checkName];
				if (dataValue) {
					if(checkName == "backgRoundColor"){
						$("#colorPicker").jqxColorPicker("setColor", "#" + dataValue);
						$("#dropDownButton").jqxDropDownButton('setContent', getTextElementByColor(new $.jqx.color({hex:dataValue})));
					}else{
						$(this).val(dataValue);
					}
				}
			});
			$("input:text").each(function() {
				var checkName = $(this).attr('name');
				var dataValue = eBannerListMap[checkName];
				if (dataValue) {
					$(this).val(dataValue);
				}
			});
			$("input[type='textarea']").each(function() {
				var checkName = $(this).attr('name');
				var dataValue = eBannerListMap[checkName];
				if (dataValue) {
					$("#" + checkName).val(dataValue);
				}
			});
			var radioName = "";
			$("input:radio").each(function() {
				if (radioName != $(this).attr('name')) {
					radioName = $(this).attr('name');
					var dataValue = eBannerListMap[radioName];
					if (dataValue) {
						$("input:radio[name='" + radioName + "']:input[value='" + dataValue + "']").click();
					} else {
						$("input:radio[name='" + radioName + "']:eq(0)").click();
					}
				}
			});
		}
		var eBannerObj = ${eBannerObj};
		var eBannerListMap = ${eBannerListMap};
	</script>
	<c:if test="${not empty param.action}">
	<script type="text/javaScript" defer="defer">
		(function(){
			${param.action}
		})();
	</script>
	</c:if>
</head>

<body class="noBg">
	<div class="popup_wrap">
		<h2>배너 수정</h2>
	 <div class="pageContScroll_st4">
	<form id="workForm" name="workForm" action="amM406S.action" method="post" enctype="multipart/form-data">
		<input type="hidden" name="backgRoundColor" id="backgRoundColor" />
		<input type="hidden" name="bannerCd" value="" />
		<input type="hidden" name="attchCd" value="" />
		<div class="table_type2">
			<table>
				<caption>배너위치, 배너제목, 이미지, 링크, 바탕색상, 게시기간, 노출상태, 등록일, 등록자</caption>
				<colgroup>
					<col style="width:120px;">
					<col style="width:*;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">배너위치</th>
						<td><html:selectList id="bannerLocalCd" name="bannerLocalCd" list='${eBanner}' listValue='bannerLocalCd' listName='bannerLocalNm' script='title="배너위치" style="width: 200px;" disabled="disabled"'/></td>
					</tr>
					<tr>
						<th scope="row">배너제목</th>
						<td><input type="text" name="bannerTitle" class="validation[required]" style="width:80%;" title="배너제목"/></td>
					</tr>

					<tr  class="uploadView" >
						<th scope="row">이미지 / 링크</th>
						<td>
							PC 이미지 <input type="text" name="attchFileNm" class="verT inputPx200 marL30" style="width:300px" readonly="readonly" />
							<a id="btnAddFile" class="btn_type1  marL10" href="javascript:;">파일찾기</a>
							<div class="marT10">
								모바일 이미지 <input type="text" name="attchMobileFileNm" class="verT inputPx200" style="margin-left:9px !important;width:300px" readonly="readonly" />
								<a id="btnAddMobileFile" class="btn_type1  marL10" href="javascript:;">파일찾기</a>
							</div>
							<div class="marT10">
								Link URL <input type="text" name="bannerLink" class="verT inputPx200 validation[required]" style="margin-left:36px !important;width:80%;" title="링크 URL"/>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">바탕색상</th>
						<td><div class="fl"  style="margin-left:5px;text-align: center;" id="dropDownButton">
							<div id="colorPicker"></div>
						</div></td>
					</tr>
					<tr>
						<th scope="row">PC 이미지 크기</th>
						<td>
							<div class="fl">
								가로크기 : <input type="text" id="bannerWidthSize" name="bannerWidthSize" class="validation[number]" title="가로크기" style="width:40px;" placeholder="0" readonly="readonly"/> pixel
							</div>
							<div class="fl marL25">
								세로크기 : <input type="text" id="bannerHeightSize" name="bannerHeightSize" class="validation[number]" title="세로크기" style="width:40px;" placeholder="0" readonly="readonly"/> pixel
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">모바일 이미지 크기</th>
						<td>
							<div class="fl">
								가로크기 : <input type="text" id="bannerMobileWidthSize" name="bannerMobileWidthSize" class="validation[number]" title="세로크기" style="width:40px;" placeholder="0" readonly="readonly"/> pixel
							</div>
							<div class="fl marL25">
								세로크기 : <input type="text" id="bannerMobileHeightSize" name="bannerMobileHeightSize" class="validation[number]" title="세로크기" style="width:40px;" placeholder="0" readonly="readonly"/> pixel
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">노출상태</th>
						<td>
							<input type="radio" name="bannerStatus" id="yesView" class="marR5"  value="Y" checked="checked"/><label for="yesView">노출</label>
							<input type="radio" name="bannerStatus" id="noView" class="marR5 marL30" value="N"  /><label for="noView">비노출</label>
						</td>
					</tr>
					<tr>
						<th scope="row">노출 기간동안</th>
						<td>
							설정 기간동안 배너가 노출됩니다.
							<div class="marT10">
								<div class="fl" id='bannerStartDt' name="bannerStartDt"></div>
								<div class="fl" style="line-height:28px;">&nbsp;~&nbsp;</div>
								<div class="fl" id='bannerEndDt' name="bannerEndDt"></div>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row">등록일 / 등록자</th>
						<td>
							<div class="marT10">
								<div class="fl">등록일 : <input type="text" name="regDt" title="등록일" style="width:80px;" placeholder="0" disabled="disabled"/></div>
								<div class="fl marL30">등록자 : <input type="text" name="regNm" title="등록자" style="width:80px;" placeholder="0" disabled="disabled"/></div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</form>
	</div>
	<!-- // table_type2 -->
		  <div class="btn_area">
		    <div class="center">
		      <a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a><a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">수정</a>
		    </div>
		  </div>
	</div>
	<!-- // popup_wrap -->
</body>
</html>
