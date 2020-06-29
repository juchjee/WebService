$(document).ready(function() {
	 radioBtn();
     checkBox();
	 onChangeColor($(".usrID"));
     onChangeColor($(".usrCode"));
     onChangeColor($(".usrPW"));
	 mobileMenu();
     slideToggle($(".box .drop"));
     goTop();
     tab();
     $('.select_guide').jqTransform();
    // selectOnChange($(".select_guide > div"));
    selectOnChange($(".input_txt_bx"));
    reMoveText($(".txtArea > p"));
    
    // 2017-09-18 selectBox -> button 변경
	$(".top_btn_box > button").on('click',function(){
		$(this).addClass("on");
		if($(this).siblings().hasClass("on")){
			$(this).siblings().removeClass("on");
			$(this).addClass("on");
		};
	});	
    
});


function reMoveText($obj){

    $obj.on('click',function(e){
        e.preventDefault();
        $(this).remove();
    })
}



function selectOnChange(obj){

    obj.on("click",function(){

        if(obj.hasClass("on")){
            $("dl.type01 dd").children().removeClass("on");
            $(this).addClass("on");
        }else{
            $(this).addClass("on");
        }
    })

    obj.on('focusout', function(){
        $(this).removeClass("on");
    })


    $(".select_guide > div").on("click",function(){

        if($(this).hasClass("on")){
            $(this).removeClass("on");
        }else{
           $("dl.type01 dd > .select_guide").children().removeClass("on");
           $(this).addClass("on");
        }
    })
}


function checkBox(){
    var $chkInput = $(".chkbox input");
    var $allChkInput = $(".chkbox .allChk");

    $chkInput.on('click',function(){
        checked($(this));
    })

    $allChkInput.on('click',function(){
        if($(this).prop("checked")){
            $chkInput.prop("checked",true);
            $chkInput.closest(".chkbox").addClass("on");
        }else{
            $chkInput.prop("checked",false);
            $chkInput.closest(".chkbox").removeClass("on");
        }
    })// 전체 선택

    function checked($this){
        if ( $this.is(":checked") ){
            $this.closest(".chkbox").addClass("on");
        }else{
           $this.closest(".chkbox").removeClass("on");
        }
    }
}


function radioBtn(){
    $('input[type="radio"]:checked').next('i').addClass('checked');

    $('input[type="radio"]').on('click',function(){
        var name = $(this).attr('name');

        $("input[name="+name+"]:enabled").next('i').removeClass('checked');
        $(this).next('i').addClass('checked');
    })
}


function tab(){
    $("ul.tabs li").click(function () {
        $("ul.tabs li").removeClass("active");
        $("ul.tabs li").children('div').addClass("on");
        $(this).addClass("active");
        $(this).children('div').addClass("on");
        $(".tab_content").hide()
        var activeTab = $(this).attr("rel");
        $("#" + activeTab).show()
    });
}


function onChangeColor(obj){

	var $target = obj;

	$target.on('focusin click', function(e){
		$(this).parents('dl').addClass('on');
	});

	$target.on('focusout', function(e){
		$(this).parents('dl').removeClass('on');
	});


}

function mobileMenu(){

    var menuLeft = document.getElementById('mobile-menu'),
        $showLeft = $("#mobileMenu"),
        $hideLeft = $("#close"),
        layerBg = "<div class='layerbg'></div>",
        twoDepMn = $("#mobile-menu > ul > li.twoDp > a"),
        twoDepList = $("#mobile-menu > ul > li.twoDp > ul"),
        lnbMn = $("#mobile-menu > ul > li.non > a"),
        lnbTime = 300,
        body = document.body;

    $showLeft.on("click",function(){
        classie.toggle( this, 'active' );
        classie.toggle( menuLeft, 'cbp-spmenu-open' );
        disableOther( 'moblieMenu' );

        // 2 Depth 메뉴 있을 경우
        twoDepMn.on('click',function(e){
            e.preventDefault();

			twoDepMn.removeClass("on");
            $(this).parents(".twoDp").addClass("on");
            $(this).parents(".twoDp").siblings().removeClass("on");
			$(this).addClass("on");

            if($(this).next().css('display')=="none"){
                twoDepMn.removeClass("on");
                twoDepList.slideUp(lnbTime,"easeOutExpo");
                lnbMn.removeClass("on");
                $(this).addClass('on');

                $(this).next().slideDown(lnbTime,"easeOutExpo");
            }
        });

        $("#close").css({'display':'block','right':'20px'});
        $("body").append(layerBg);
        $("html, body").css({'height': '100%'});   // 2017-09-13 수정 => 'overflow': 'hidden' 삭제
        $("body").on('scroll touchmove mousewheel', function(e){
            e.preventDefault();
            e.stopPropagation();

            return false;
        })
    });

     $hideLeft.on("click",function(){
        classie.remove( menuLeft, 'cbp-spmenu-open' )
        disableOther('moblieMenu');

        $("#close").css("display","none");
        $(".layerbg").remove();
        $("body").off('scroll touchmove mousewheel');
    });

    function disableOther( button ) {
        if( button !== 'moblieMenu' ) {
            classie.toggle( menuLeft, 'disabled' );
        }
    }
};


function slideToggle(obj){

    var $target = obj;

    $(".ing_bx .cont").not($(".drop.on").next()).slideUp(500,"easeOutExpo");

    $target.on('click',function(){

           if($(this).hasClass("on")){
                $(this).removeClass("on");
                $(this).next().slideUp(500,"easeOutExpo");
           }else{
             $(this).addClass("on");
             $(this).next().slideDown(500,"easeOutExpo");

           }
    })
    //trigger("click");

};

function goTop(){

    var $btn = $(".top_btn");

    $btn.on('click', function(){

         $( 'html, body' ).animate( { scrollTop : 0 }, 400 );
    });
};


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