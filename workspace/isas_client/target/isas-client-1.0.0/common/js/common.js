$(document).ready(function(){
//	function tab(){
//		$("ul.tabs li").click(function () {
//			$("ul.tabs li").removeClass("active");
//			$("ul.tabs li").children('div').addClass("on");
//			$(this).addClass("active");
//			$(this).children('div').addClass("on");
//			$(".tab_content").hide()
//			var activeTab = $(this).attr("rel");
//			$("#" + activeTab).show()
//		});
//	} tab();

//	function clickGoods(){
//		var clickArea = $('.list_goods a');
//		clickArea.on('click',function(){
//			$(this).addClass('active');
//			$(this).siblings().removeClass('active');
//		});
//	} clickGoods();

	function selectLabel() {
    	$(".select_wrap select").change(function() {
    		var getText = $(this).find("option:selected").text();
    		$(this).prev(".select_label").html(getText);
    	});
	} selectLabel();

	function clickpaging(){
	   var clickArea = $('.paging a');
    	clickArea.on('click',function(){
    		$(this).addClass('current');
    		$(this).siblings().removeClass('current');
    	});
	} clickpaging();

    function familySite(){

    	var $btn = $(".sitelink > button");
    	var $sub = $(".sitelink .sublink");


      $btn.on("click",function(){
        var $this = $(this);

        if($this.hasClass("on")){
    	  $sub.slideUp(300);
          $this.removeClass("on")

        }else{
          $sub.slideDown(300);
    	  $this.addClass("on")
        }
        return false;

      });
     $('body').on('click',function(){
        if($btn.hasClass("on")){
          $sub.slideUp(300);
          $btn.removeClass("on");
        }
      });

    } familySite();

    function tabMn(){

        var $wrap = $(".tab_bx");
        var $mainTabMn = $(".tab_bx > p > a");
        var $mainTab = $(".tab_bx > p");


        $wrap.find(".lstBox").first().addClass("on");

        $mainTabMn.on("click", function(e){
            e.preventDefault();
            $mainTab.removeClass("on");
            $mainTab.next().removeClass("on");
            $(this).parent().addClass("on");
            $(this).parent().next().addClass("on");
        }).first().trigger("click");
    } tabMn();


    function txtAreaOn(){

        var txt = 1;
        var $inText = $("#txtArea").text("고장증상에 대한 상세내용을 입력하시면 더욱 신속히 처리해 드리겠습니다.\n예) 비데 불이 깜빡거려요.");

        $("#txtArea").on('click',function(){
            removeCont();
        });

        function removeCont(){

            if(txt == 1){
                $("#txtArea").val("");
                txt = 0;
            }
        }
    } txtAreaOn();

    function radioBtn(){
        $('input[type="radio"]:checked').next('i').addClass('checked');

        $('input[type="radio"]').on('click',function(){
            var name = $(this).attr('name');

            $("input[name="+name+"]:enabled").next('i').removeClass('checked');
            $(this).next('i').addClass('checked');
        })
    } radioBtn();


	function checkBox(){
		$(".chkbox input").click(function(){
			if ( $(this).is(":checked") ){
				$(this).closest(".chkbox").addClass("on");
			}else{
				$(this).closest(".chkbox").removeClass("on");
			}
		})
	} checkBox();




    function gnb(){

        var $target = $(".mn_bx li");
        var $twoDepth = $(".mn_bx");
        var $header = $(".header");
        var $gnbBg = $(".gnbBg");

        $target.on('click focusin mouseenter', function(){
            $(this).first().addClass("on");
            $header.addClass("open");
           $(".gnb").css("overflow","visible").stop().animate("easeOutCubic");
           $twoDepth.stop().animate({height:192}, 500, "easeOutCubic");
           $gnbBg.css("border-bottom","1px solid #ccc").stop().animate({height:150}, 500, "easeOutCubic");
        });

        $target.on('focusout mouseleave', function(){
            $(this).first().removeClass("on");
        });

        $(".mn_bx").on('focusout mouseleave', function(){
            //e.preventDefault();
            $(this).first().removeClass("on");
            $header.removeClass("open");
             $(".gnb").css("overflow","hidden").stop().animate("easeOutCubic");
            $twoDepth.stop().animate({height:40}, 500, 'easeOutCubic')
            $gnbBg.css("border-bottom","none").stop().animate({height:0}, 500, "easeOutCubic");
        });
    } gnb();

    $('.bxslider').bxSlider({
        auto:true,
        autoHover:true,
        speed:700,
        autoDelay:500,
        controls:false
    });

	/*체크박스 전체 선택*/
	function allChecked(){
		$('.chkbox #agree_all').click(function(){
			var $checkboxes = $(this).parents('.chkbox').siblings('.person_info_agree').find('input:checkbox');
			var $checkboxesOn = $(this).parents('.chkbox').siblings('.person_info_agree').find('.chkbox');
			if(this.checked){
				$checkboxes.prop('checked', 'true');
				$checkboxesOn.addClass('on');
			}else{
				$checkboxes.prop('checked', '');
				$checkboxesOn.removeClass('on');
			};
		})
	} allChecked();

	onChangeColor($(".id")); /* 2017-08-22 추가 */
	onChangeColor($(".pw")); /* 2017-08-22 추가 */
});

/* 2017-08-22 추가 */
function onChangeColor(obj){
	var $target = obj;

	$target.on('focusin click', function(e){
		$(this).addClass('on');
	});

	$target.on('focusout', function(e){
		$(this).removeClass('on');
	});
}
/* 2017-08-22 추가 - 끝 */
function layerPopUp(obj){
    var $temp = $('#' + obj);
    var bg = $temp.prev().hasClass('bg');
    var $btn = $(".layerBtn");

    if(bg){
        $('.layer').fadeIn();
    }else{
        $temp.fadeIn();
    }

    // 화면의 중앙에 레이어를 띄운다.
    if ($temp.outerHeight() < $(document).height() ) $temp.css('margin-top', '-'+$temp.outerHeight()/2+'px');
    else $temp.css('top', '0px');
    if ($temp.outerWidth() < $(document).width() ) $temp.css('margin-left', '-'+$temp.outerWidth()/2+'px');
    else $temp.css('left', '0px');

    $temp.find('a.close_btn').click(function(e){
        if(bg){
            $('.layer').fadeOut();
        }else{
            $temp.fadeOut();
        }
        e.preventDefault();
    });

    $('.layer .bg').click(function(e){
        $('.layer').fadeOut();
        e.preventDefault();
    });

}



function fnPopup(val){
	if(val=="hp"){
		window.open('/ISDS/mm/checkPlusMain.action?param_r1=cs&param_r2=telCsI&certMet=M', 'popup','width=425, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	}else{
		window.open('/ISDS/mm/checkPlusMain.action?param_r1=cs&param_r2=telCsI&certMet=P', 'popup', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
	}
}





