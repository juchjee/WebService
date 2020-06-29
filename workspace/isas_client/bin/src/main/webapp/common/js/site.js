$(function() {
	/** @설명 : init() 체크 및 자동 실행 */
	$(document).ready(function() {
	    //autocomplete 비활성
	    $("input").attr("autocomplete","off");
		/** 2중 submit 방지 */
		$("<input type='hidden' name='token' id='token'/>").appendTo("body");
		window.menuInit && window.menuInit();
		window.init && window.init();
	});
});
$(window).load(function(){
	$("body").append("<div id='jqxLoader'></div>");

	$("input[class*=validation]").each(function(index, value){
		if($(this).attr("class").indexOf("number") > -1){
			if($(this).attr("class").indexOf("Left") > -1){
				$(this).css("text-align","left");
			}else if($(this).attr("class").indexOf("center") > -1){
				$(this).css("text-align","center");
			}else{
				$(this).css("text-align","right");
			}
				if($(this).attr("class").indexOf("Only") > -1){
					$(this).val(numberOnly($(this).val()));
					$(this).bind("keyup",function() { $(this).val(numberOnly($(this).val()));});
				}else{
					$(this).val(setComma($(this).val()));
					$(this).bind("keyup",function() { $(this).val(setComma($(this).val()));});
				}
		}

		if($(this).attr("class").indexOf("telNo") > -1){
			$(this).val(setTelNo($(this).val()));
		}


	});
	$("div[class*=validation]").each(function(index, value){
		if($(this).attr("class").indexOf("number") > -1){
			if($(this).attr("class").indexOf("Left") > -1){
				$(this).css("text-align","left");
			}else if($(this).attr("class").indexOf("center") > -1){
				$(this).css("text-align","center");
			}else{
				$(this).css("text-align","right");
			}
				if($(this).attr("class").indexOf("Only") > -1){
					$(this).text(numberOnly($(this).text()));
				}else{
					$(this).text(setComma($(this).text()));
				}
		}
	});

	$("span[class*=validation]").each(function(index, value){
		if($(this).attr("class").indexOf("number") > -1){
			if($(this).attr("class").indexOf("Left") > -1){
				$(this).css("text-align","left");
			}else if($(this).attr("class").indexOf("center") > -1){
				$(this).css("text-align","center");
			}else{
				$(this).css("text-align","right");
			}
				if($(this).attr("class").indexOf("Only") > -1){
					$(this).text(numberOnly($(this).text()));
				}else{
					$(this).text(setComma($(this).text()));
				}
		}
	});
});

//캘린더
function dateTimeInput(id, option, firstVal){
	var defaultOption = {
		culture: 'ko'
		, formatString: 'd'
		, width: '82px'
		, height: '24px'
		, showFooter: true
		, animationType: 'none'
		, enableBrowserBoundsDetection:true
	};
	if(option != undefined || option != null){
		$.extend(defaultOption, option);
	}
	if(firstVal != undefined && firstVal != null && firstVal != ''){
		defaultOption.value = firstVal;
	}else{
		defaultOption.value = null;
	}
	$("#"+id).jqxDateTimeInput(defaultOption);
	$("#"+id).on('open', function (event) {
		if($.type(event.args.date) != "date"){
			$("#"+id).jqxDateTimeInput('val', window.$nowDate);
		}
	});
}

function modalPopUp(url, height) {
	var $url = url;
	$.fancybox({
		'href' : $url,
		showCloseButton : false,
		hideOnOverlayClick : false,
		padding : 0,
		height : height,
		width : 1000,
		scrolling : 'no',
		'autoScale' : false,
		'transitionIn' : 'none',
		'transitionOut' : 'none',
		'type' : 'iframe'
	});
}

//파일 다운로드
function file_onClick(full_file_name , contextPath){
	var sub_path = "/FILESV/";
	var encodeName = getContextPath();
	encodeName += sub_path + encodeURI(full_file_name);
	window.open(encodeName);
}


//파일 다운로드
function fnFileDownLoad(fileCd){
	var obj = {"attchCd" : fileCd};
		makeForm('/ISDS/bbt/fileDownLoad.action', obj);
}

/**
 * Loading중 On
 */
function displayLoadingOn(){
    $('#jqxLoader').jqxLoader({ width: 60, height: 60, autoOpen: true, isModal: true, text:''});
}

/**
 * Loading중 Off
 */
function displayLoadingOff(){
    $('#jqxLoader').jqxLoader('close');
}


function fnSubmit(form,msg){
	if(fnValidation()){
		if(confirm(msg+"하시겠습니까?")){
			$("input[class*=validation]").each(function(index, value){
				if($(this).is(":disabled") == false){
					if($(this).attr("class").indexOf("number") > -1){
						$(this).val(removeComma($(this).val()));
						$(this).unbind("keyup");
					}
				}
			});

//		    $('#jqxLoader').jqxLoader({ width: 250, height: 100, autoOpen: true, isModal: true, text:'저장중입니다. 잠시만 기다려주세요!'});
			$("form[name="+form+"]").submit();
		}
	}
}

function pordDtlLink(prodCd){
	document.location.href = "/ISDS/store/store_view.do?prodCd="+prodCd;
}
