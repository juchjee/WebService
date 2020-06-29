function gnbMenu(depth1,depth2){
	$(window).on("load resize", function() {
        if ($(window).width() > 1024) {
            $("#nav > li a").bind('focusin mouseenter',function() {
                    $(this).parent().find("ul").css("display", "block");
                    $(this).addClass('on');
                    $(this).parent().siblings().find("ul").css("display", "none");
                    $(this).parent().siblings().find("a").removeClass('on');
            });
            $("#nav").bind('mouseleave',function() {
                $(this).children('li').find('ul').css("display", "none");
                $(this).children('li').find("a").removeClass('on');
                $('#nav > li:eq('+depth1+') > a').addClass("on")
                $('#nav > li:eq('+depth1+') > a').parent().find("ul").css("display", "none");
                $('#nav > li:eq('+depth1+') ul li:eq('+depth2+') > a').addClass("on")
            });
            if ( $('#nav > li').size() > depth1){
                $('#nav > li:eq('+depth1+') > a').addClass("on")
                $('#nav > li:eq('+depth1+') > a').parent().find("ul").css("display", "none");
                $('#nav > li:eq('+depth1+') ul li:eq('+depth2+') > a').addClass("on")
            }
            $("#nav li:last-child ul li:last-child a").bind('focusout',function() {
                $(this).parents('#nav ul').css("display", "none");
                $(this).parents('#nav li').find("a").removeClass('on');
                $('#nav > li:eq('+depth1+') > a').addClass("on")
                $('#nav > li:eq('+depth1+') > a').parent().find("ul").css("display", "block");
                $('#nav > li:eq('+depth1+') ul li:eq('+depth2+') > a').addClass("on")
            });
        } else {
            var winHeight = $(window).height();
            $(window).on("orientationchange resize" , function(){
                winHeight = $(window).height();
            });
            $(".gnb_mobile a").on("click", function() {
            	$("#nav").find("ul").show();
            	$("#nav").find("a").removeClass("on");
            	if ($(this).hasClass("on")) {
                    $("#wrap").css({"height":"auto", "overflow":"visible"});
                    $(this).removeClass("on");
                } else {
                	$("#quick_menu > div").hide();
                    $("#wrap").css({"height":winHeight+"px", "overflow":"hidden"});
                    $(this).addClass("on");
                }
                $(".nav_bg").css({"height":(winHeight-90)+"px"});
                $(".nav_bg").toggle();
                $("#nav").css({"height":(winHeight-90)+"px"});
                $("#nav").toggle();
            });
        }
    });
    
}
