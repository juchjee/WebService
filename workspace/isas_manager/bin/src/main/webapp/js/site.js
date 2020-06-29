$(function() {

	/*window.history.forward(1); // 뒤로가기 방지
	window disable backspace 8, F5 116
	document.onkeydown = function(e) {
		var _event = (e) ? e : event;
		var key = _event.keyCode;
		var target = $(_event.target);
		if(target.is('input') || target.is('textArea') ){
			if(key == 116){
				if(_event.stopPropagation) _event.stopPropagation();
				if(_event.preventDefault) _event.preventDefault();
				return false;
			}else if(key == 8 && target.attr('readonly') == 'readonly'){
				if(_event.stopPropagation) _event.stopPropagation();
				if(_event.preventDefault) _event.preventDefault();
				return false;
			}
		}else{
			if(key == 8 || key == 116){
				if(_event.stopPropagation) _event.stopPropagation();
				if(_event.preventDefault) _event.preventDefault();
				return false;
			}
		}
	}*/
    $("input:text").keydown(function(evt) {
        if (evt.keyCode == 13)
            return false;
    });
});
	/** @설명 : init() 체크 및 자동 실행 */
	$(document).ready(function() {

		//2중 submit 방지
		$("<input type='hidden' name='token' id='token'/>").appendTo("body");
		window.menuInit && window.menuInit();

		/*-----------------------------일반 레이어 팝업 -----------------------------*/
		if($(".fancybox.bis").length > 0){
			$(".fancybox.bis").fancybox({
				maxWidth	: 400,
				maxHeight	: 486,
				width		: 400,
				height		: 482,
				autoSize	: true,
			    autoScale         : true,
			    autoDimensions    : true,
			    scrolling         : 'no',
			    transitionIn      : 'none',
			    transitionOut     : 'none',
			    type              : 'iframe',
				modal : false,
			    beforeClose : function(){},
			    afterClose : function(){}
			});

			$.fancybox.open({
				modal : false
			});
		}
		/*-----------------------------네이버 스마트 에디터 레이어 팝업 -----------------------------*/
		if($(".fancybox.sme").length > 0){
			// 네이버 스마트 에디터 레이어 팝업 - 미리보기 스크롤 이벤트 디자인
			 $(".editScroll").mCustomScrollbar({
			    theme:"minimal-dark",
				scrollButtons:{enable:true,scrollType:"stepped"},
				keyboard:{scrollAmount:50},
			    snapAmount:20,
			    mouseWheel:{deltaFactor:50},
			    scrollInertia:400
			});
			$(".fancybox.sme").fancybox({
				maxWidth	: 1350,
				maxHeight	: 550,
				width		: '100%',
				height		: '100%',
				autoSize	: false,
				openEffect	: 'none',
				closeEffect	: 'none',
			    iframe : { preload: false },
			    beforeClose : function(){
			    	var this_ifram = this.content.get(0).contentWindow;
			    	if(this_ifram){
			    		if(this_ifram.$_fancyboxIsAutoClose){
				    		if(confirm(message(MESSAGES_CFM.POPUP_CANCEL))){
				    			this_ifram.fnFancyboxClose();
								return true;
					    	}else{
					    		return false;
					    	}
				    	}
			    	}
			    },
			    afterClose : function(){ $(".editScroll").mCustomScrollbar("update");}
			});
		}
		window.init && window.init();
	});

	$(window).load(function(){
		$("body").append("<div id='jqxLoader'></div>");

		$("input[class*=validation]").each(function(index, value){
			if($(this).attr("class").indexOf("number") > -1){
				if($(this).attr("class").indexOf("Left") > -1){
					$(this).css("text-align","left");
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
				$(this).bind("keyup",function() { $(this).val(setTelNo($(this).val()));});
			}
		});
		$("div[class*=validation]").each(function(index, value){
			if($(this).attr("class").indexOf("number") > -1){
				if($(this).attr("class").indexOf("Left") > -1){
					$(this).css("text-align","left");
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

/**
 * Loading중 On
 */
function displayLoadingOn(){
    $('#jqxLoader').jqxLoader({ width: 60, height: 60, autoOpen: true, isModal: true, text:''});
}

function displayLoadingForAjaxOn(){
    $('#jqxLoader').jqxLoader({ width: 60, height: 60, autoOpen: false, isModal: true, text:''});
}


/**
 * Loading중 Off
 */
function displayLoadingOff(){
    $('#jqxLoader').jqxLoader('close');
}

//파일 다운로드
function fnFileDownLoad(fileCd){
	var obj = {"attchCd" : fileCd};
	if(mngFullUri){
		makeForm(mngFullUri+'fileDownLoad.action', obj);
	}else{
		makeForm('/mng/fileDownLoad.action', obj);
	}
}

//$.gridAutoScroll = function(objArr){
//	$( window ).resize(function() {
//        var windowHeight = $( window ).height();
//
//        $.each(objArr, function (id, size) {
//            $("#"+id).css("height",size-220);
//            $("#"+id +"> div").css("height",size-220);
//            $("#pagerjqxgrid").css("top",size-250);
//            $("#pagerjqxgrid").css("width","100%");
//
//    	});
//    });
//}

function fnSubmit(form,msg){
	if(fnFormValidation(form)){
		if(confirm(message(MESSAGES_CFM.VALID_CFM,[msg]))){
			$("form[name='"+form+"'] input[class*=validation]").each(function(index, value){
				if($(this).is(":disabled") == false){
					if($(this).attr("class").indexOf("number") > -1){
						$(this).val(removeComma($(this).val()));
						$(this).unbind("keyup");
					}
				}
			});

		    $('#jqxLoader').jqxLoader({ width: 250, height: 100, autoOpen: true, isModal: true, text:'저장중입니다. 잠시만 기다려주세요!'});
			$("form[name="+form+"]").submit();
		}
	}
}
