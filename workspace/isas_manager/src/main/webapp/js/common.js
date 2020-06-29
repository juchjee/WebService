$(document).ready(function() {
	function lnb() {
		$($(".lnb ul.depths_1 > li > a.on").parent().parent()).prev().addClass("on");
    	$(".lnb ul.depths_0 > li > a").on("click", function() {
    		if(!($(this).hasClass("on"))) {
				$(".lnb ul.depths_0 > li > a").removeClass("on");
    			$(".lnb ul.depths_1").hide();
				$(this).addClass("on");
	    		$(this).siblings(".depths_1").slideDown("slow");
    		} else {
	    		$(this).removeClass("on");
	    		$(this).siblings(".depths_1").slideUp("slow");
    		}
    	})
    } lnb();

    //autocomplete 비활성
    $("input").attr("autocomplete","off");

    // table scroll
    $(window).load(function(){
        $(".lnb").mCustomScrollbar({
            theme:"minimal-dark",
            snapAmount:50,
            //scrollButtons:{enable:true},
            keyboard:{scrollAmount:50},
            mouseWheel:{deltaFactor:50},
            scrollInertia:400
        });


        $(".pageContScroll_st1").mCustomScrollbar({
            theme:"minimal-dark",
            snapAmount:20,
            scrollButtons:{enable:true},
            keyboard:{scrollAmount:50},
            mouseWheel:{deltaFactor:50},
            scrollInertia:400
        });

        $(".pageContScroll_st2").mCustomScrollbar({
            theme:"minimal-dark",
            snapAmount:20,
            scrollButtons:{enable:true},
            keyboard:{scrollAmount:50},
            mouseWheel:{deltaFactor:50},
            scrollInertia:400
        });

        $(".pageContScroll_st3").mCustomScrollbar({
            theme:"minimal-dark",
            snapAmount:20,
            scrollButtons:{enable:true},
            keyboard:{scrollAmount:50},
            mouseWheel:{deltaFactor:50},
            scrollInertia:400
        });

        $(".pageContScroll_st4").mCustomScrollbar({
            theme:"minimal-dark",
            snapAmount:20,
            scrollButtons:{enable:true},
            keyboard:{scrollAmount:50},
            mouseWheel:{deltaFactor:50},
            scrollInertia:400
        });

        $(".pageContScroll_st5").mCustomScrollbar({
            theme:"minimal-dark",
            snapAmount:20,
            scrollButtons:{enable:true},
            keyboard:{scrollAmount:50},
            mouseWheel:{deltaFactor:50},
            scrollInertia:400
        });

        $(".pageContScroll_st6").mCustomScrollbar({
            theme:"minimal-dark",
            snapAmount:20,
            scrollButtons:{enable:true},
            keyboard:{scrollAmount:50},
            mouseWheel:{deltaFactor:50},
            scrollInertia:400
        });

        $(".pageContScroll_st7").mCustomScrollbar({
            theme:"minimal-dark",
            snapAmount:20,
            scrollButtons:{enable:true},
            keyboard:{scrollAmount:50},
            mouseWheel:{deltaFactor:50},
            scrollInertia:400
        });
        var windowHeight = $( window ).height();


        $(".pageContScroll_st1").css("height",windowHeight-220);
        $(".pageContScroll_st2").css("height",windowHeight-170);
        $(".pageContScroll_st3").css("height",windowHeight-120);
        $(".pageContScroll_st4").css("height",windowHeight-160);
        $(".pageContScroll_st5").css("height",windowHeight-50);
        $(".pageContScroll_st6").css("height",windowHeight-210);
        $(".pageContScroll_st7").css("height",windowHeight-150);
        $(".lnb").css("height",windowHeight-170);

        $( window ).resize(function() {
            var windowHeight = $( window ).height();
            $(".pageContScroll_st1").css("height",windowHeight-220);
            $(".pageContScroll_st2").css("height",windowHeight-170);
            $(".pageContScroll_st3").css("height",windowHeight-120);
            $(".pageContScroll_st4").css("height",windowHeight-160);
            $(".pageContScroll_st5").css("height",windowHeight-50);
            $(".pageContScroll_st6").css("height",windowHeight-210);
            $(".pageContScroll_st7").css("height",windowHeight-150);
            $(".lnb").css("height",windowHeight-170);
        });

        //$(window).width()와 $(document).width() 차이
        //$(window).width --> 브라우저의 창너비
       // $(document).width --> 문서의 너비

    });
});

