<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />
	<!-- 마케팅관리 : 팝업관리 -->

<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
<script type="text/javaScript" defer="defer">
/*----------------------------------------------------------------------------------------------
 * 화면 load시 실행 함수 (onload)
 *----------------------------------------------------------------------------------------------*/
var oEditors = [];

function init(){
	fnDataSetting();
	fnEvent();
}
var isNotMakeSmartEditors = true;


/*----------------------------------------------------------------------------------------------
 * 페이지 이벤트 함수 모음
 *----------------------------------------------------------------------------------------------*/
function fnEvent(){

	/*----------------------------- 기본이미지 - 버튼 클릭 이벤트 Start -----------------------------*/
	$(".htmlAtt").bind("click",function() {
		fileSearch({fileAttrName:"popHtmlPath",fileViewAttrName:"popHtmlName",form:"workForm",filetype:'html'});
	});
	/*----------------------------- 기본이미지 - 버튼 클릭 이벤트 End-----------------------------*/


	/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 Start -----------------------------*/
	 $.submit = function(){
			 if($("#popupRegTpE").is(":checked")){
				oEditors.getById["popupCont"].exec("UPDATE_CONTENTS_FIELD", []);
			 }else{
				 if($("input[name=popHtmlName").val() == ""){
					 alert("업로드파일을 등록해주세요!");
					 return false;
				 }

			 }

			var prodIconColor = $("#colorPicker").val().replace(/\#/gi,'');
			$("#popupCloseColor").val(prodIconColor);

			fnSubmit("workForm","저장");
	}
		/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 End -----------------------------*/


	//	$("#editView").show();


		$("input[name=popupRegTpFe").bind("click",function() {
			if($(this).val() == 'F'){
				$(".editView").hide();
				$(".uploadView").show();
				$(".noBg").css("height","580px");
				parent.$.fancybox.update();
			}else if($(this).val() == 'E'){
				$(".editView").show();
				$(".uploadView").hide();
				$(".noBg").css("height","810px");
				parent.$.fancybox.update();

				if(isNotMakeSmartEditors){
					isNotMakeSmartEditors = false;
					nhn.husky.EZCreator.createInIFrame({
						oAppRef: oEditors,
						elPlaceHolder: "popupCont",
						sSkinURI: "/SE/SmartEditor2Skin.html",
						htParams : {
							bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
							bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
						},
						fCreator: "createSEditor2"
					});
				}
			}else{
		 		return false;
			}
		});

		$("input[name=popupOpenTpWlm").bind("click",function() {
			 if($(this).val() == 'M'){
				$(".winPosition input").attr("disabled", true);
			}else{
				$(".winPosition input").attr("disabled", false);
				$("input[name=popupCenterYesNo").change();
			}
		});

		$("input[name=popupCenterYesNo").bind("change",function() {
			if($(this).is(":checked")){
				$(".winPosition").find("input[type=text]").attr("disabled", true);
			 }else{
				 $(".winPosition").find("input[type=text]").attr("disabled", false);
			 }
		});

		$("#colorPicker").on('colorchange', function (event) {
            $("#dropDownButton").jqxDropDownButton('setContent', getTextElementByColor(event.args.color));
        });
}

function fnDataSetting(){


	var option = {
			 culture: 'ko'
			, formatString: 'd'
			, width: '140px'
			, height: '26px'
			, showFooter: true
			, animationType: 'none'
			, enableBrowserBoundsDetection:true
			, formatString: 'yyyy-MM-dd HH:mm'
			, showTimeButton: false
			, showCalendarButton: true
			, theme: 'custom'
		};

	 dateTimeInput("popupStartDt", option, "${nowYmd}");
	 dateTimeInput("popupEndDt", option);

		$("input[name=popupRegTpFe]").eq(0).attr("checked",true);
		$("input[name=popupStatusYn]").eq(0).attr("checked",true);
		$("input[name=popupOpenTpWlm]").eq(0).attr("checked",true);

		getTextElementByColor = function (color) {
            if (color == 'transparent' || color.hex == "") {
                return $("<div style='text-shadow: none; position: relative; margin:2px 0 2px 0; line-height:22px;'>transparent</div>");
            }
            var element = $("<div style='text-shadow: none; position: relative; margin:2px 0 2px 0;  line-height:22px;'>#" + color.hex + "</div>");
            var nThreshold = 105;
            var bgDelta = (color.r * 0.299) + (color.g * 0.587) + (color.b * 0.114);
            var foreColor = (255 - bgDelta < nThreshold) ? 'Black' : 'White';
            element.css('color', foreColor);
            element.css('background', "#" + color.hex);
            element.addClass('jqx-rc-all');
            return element;
        }


		  $("#colorPicker").jqxColorPicker({ color: "FFFFFF", colorMode: 'hue', width: 220, height: 220});
         $("#dropDownButton").jqxDropDownButton({ width: 85, height: 26});
         $("#dropDownButton").jqxDropDownButton('setContent', getTextElementByColor(new $.jqx.color({ hex: "FFFFFF" })));

         $(".editView").hide();
}
</script>
</head>

<body class="noBg" style="height:580px">
	<div class="popup_wrap">
		<h2>팝업 등록</h2>
	 <div class="pageContScroll_st2">
	<form id="workForm" name="workForm" action="amM405Save.action" method="post" enctype="multipart/form-data">
	<input type="hidden" name="popupCloseColor" id="popupCloseColor" />
	<div class="table_type2">
		<table>
			<caption>팝업제목, 팝업파일명, 출력여부, 창위치, 창크기, 특정기간동안 무조건 노출, 특정기간내에 특정시간에만 노출, 창타입으로 구성된 팝업 등록에 대한 작성 테이블 입니다.</caption>
			<colgroup>
				<col style="width:120px;">
				<col style="width:*;">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">팝업제목</th>
					<td>
						<input type="text" name="popupTitle" class="validation[required]" style="width:80%;"/>
					</td>
				</tr>
				<tr>
					<th scope="row">팝업등록방식</th>
					<td>
						<input type="radio" id="popupRegTpF" name="popupRegTpFe" class="marR5" value="F"  /><label for="popupRegTpF">파일다운로드</label>
						<input type="radio" id="popupRegTpE" name="popupRegTpFe" class="marR5 marL30" value="E" /><label for="popupRegTpE">에디터등록</label>
					</td>
				</tr>

				<tr  class="uploadView" >
					<th scope="row">팝업파일업로드</th>
					<td>
						<input type="text" name="popHtmlName" class="verT inputPx200" style="width:200px" readonly="readonly" />
			            <a class="htmlAtt btn_type1  marL10" href="javascript:;">파일찾기</a>
					</td>
				</tr>
				<tr class="editView"  >
					<th scope="row">에디터등록</th>
					<td>
						<div class="edit_area">
								<textarea name="popupCont" id="popupCont" class="validation[required]" title="에디터등록"  style="width:100%;height:300px;display:none"></textarea>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">창크기</th>
					<td>
						<div class="fl">
							가로크기 : <input type="text" name="popupWinWidth" class="validation[required,number]" title="창(가로크기)" style="width:40px;" placeholder="0" /> pixel
						</div>
						<div class="fl marL30">
							세로크기 : <input type="text" name="popupWinHeight" class="validation[required,number]" title="창(세로크기)" style="width:40px;" placeholder="0" /> pixel
						</div>
					</td>
				</tr>
				<tr class="winPosition">
					<th scope="row">창위치</th>
					<td>
						<div class="fl">
							상단에서 : <input type="text" name="popupWinTop" class="validation[number]" title="창위치(상단에서)" style="width:40px;" placeholder="0" /> pixel
						</div>
						<div class="fl marL30">
							좌측에서 : <input type="text" name="popupWinLeft" class="validation[number]" title="창위치(좌측에서)" style="width:40px;" placeholder="0" /> pixel
						</div>

						<div class="fl marL30"  style="line-height:26px;">
						    <input type="checkbox" name="popupCenterYesNo" id="popupCenterYesNo" class="marR5"  value="yes" /><label for="popupCenterYesNo">중앙위치</label>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">닫기설정</th>
					<td>
						<div class="fl" style="line-height:26px;">
							닫는 기간 <input type="text" name="popupCloseDay" id="popupCloseDay" class="marR5 validation[number]"  placeholder="1"  value="" style="width:40px;"  />일
						</div>
						 <div class="fl marL30" style="line-height:26px;">색상 :</div><div class="fl"  style="margin-left:5px;" id="dropDownButton"> <div id="colorPicker"></div></div>
						<div class="fl marL30" style="line-height:26px;">
							글씨 크기 : <input type="text" name="popupCloseSize" id="popupCloseSize" class="marR5 validation[number]"  placeholder="12" value=""  style="width:40px;"  />px
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">출력여부</th>
					<td>
						<input type="radio" name="popupStatusYn" id="yesView" class="marR5"  value="Y" /><label for="yesView">출력</label>
						<input type="radio" name="popupStatusYn" id="noView" class="marR5 marL30" value="N"  /><label for="noView">미출력</label>
					</td>
				</tr>
				<tr>
					<th scope="row">노출 기간동안</th>
					<td>
						설정 기간동안 팝업창이 열립니다.
						<div class="marT10">
							<div class="fl" id='popupStartDt'></div>
							<div class="fl" style="line-height:28px;">&nbsp;~&nbsp;</div>
							<div class="fl" id='popupEndDt'></div>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">창타입</th>
					<td>
						<input type="radio" name="popupOpenTpWlm" id="popupOpenTpW" class="marR5" value="W" /><label for="popupOpenTpW">일반 윈도우팝업창</label>
						<input type="radio" name="popupOpenTpWlm" id="popupOpenTpL" class="marR5 marL30" value="L" /><label for="popupOpenTpL">고정레이어</label>
						<input type="radio" name="popupOpenTpWlm" id="popupOpenTpM" class="marR5 marL30" value="M" /><label for="popupOpenTpM">이동레이어</label>
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
		      <a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">닫기</a><a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">등록</a>
		    </div>
		  </div>
	</div>
	<!-- // popup_wrap -->
</body>
</html>
