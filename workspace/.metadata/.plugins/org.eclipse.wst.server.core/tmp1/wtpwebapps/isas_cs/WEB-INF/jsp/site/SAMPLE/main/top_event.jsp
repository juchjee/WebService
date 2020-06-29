<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
$(document).ready(function() {
	// 현재시간 표시
	var rootUri = "${rootUri}";
	$.ajax({
	    url : "/ISDS/evn/eBannerTop.do",
	    type: "POST",
	    data : "",
	    success:function(data, textStatus, jqXHR)
	    {
	    	if(data.EBR00001 != undefined){
	    		$('#top_banner_fr').show();
		    	if(data.message == "OK"){
		    		$('#top_banner_fr').css('background-color', '#' + data.EBR00001.backgRoundColor);
		    		$('#top_banner_tw').html('<a href="' + data.EBR00001.bannerLink + '"}"><img src="' + homeUrl + data.EBR00001.attchFilePath + '" alt="' + data.EBR00001.bannerTitle + '" /></a>');
		    		$('#top_button').html('<img src="' + rootUri + 'common/img/btn_close_top.png" style="width: 20px;" alt="닫기" />');
		    		//btn_close
		    		//alert("저장되었습니다.");
		    	}
		    	var topBanner = $('#wrap > .banner');
		    	topBanner.find('button').on( 'click', function() {
		    		if ($('#top_check').prop('checked')){
		    			setEncryptionCookie( 'hideBanner', Math.floor(Math.random()*1000) + 1, 60 * 60 * 24);
		    		} else {
		    			setEncryptionCookie( 'hideBanner', 'N', 0);
		    		}
		    		topBanner.stop().animate({height : 0}, 300);
		    	});
		    }else{
	    		$('#top_banner_fr').hide();
		    }
	    },
	    error: function(jqXHR, textStatus, errorThrown)
	    {
	    	//alert("통신에 실패 하였습니다. 관리자에게 문의해 주세요.");
	    }
	}); // ajax


});
</script>
	<div class="banner" id="top_banner_fr" style="display:none">
		<div class="inner">
			<div class="top_banner" id="top_banner_tw">
			</div>
			<div class="btn_close">
				<input type="checkbox" id="top_check" style="cursor: pointer;"/>
				<label for="top_check" style="cursor: pointer;">1일간 열지 않음</label>
				<button type="button" style="cursor: pointer;" id="top_button"></button>
			</div>
		</div>
	</div>