<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=0, minimum-scale=1.0, user-scalable=no, target-densitydpi=medium-dpi">
	<title>IS동서_모바일(메인)</title>

	<page:applyDecorator name="header_m" />
	<link rel="stylesheet" href="${rootUri}common/css/main_m.css" />

	<script type="text/javascript">

		function init(){
			fnEvent();
		}

		function fnEvent(){

// 			var LPopup = false;

// 			<c:forEach var="popup" items="${popupList}" varStatus="nStatus">
// 			var popupWinTop = parseInt("${popup.popupWinTop}");
// 			var popupWinLeft = parseInt("${popup.popupWinLeft}");
// 			var popupWinWidth = parseInt("${popup.popupWinWidth}");
// 			var popupWinHeight = parseInt("${popup.popupWinHeight}");

// 				<c:if test="${popup.popupOpenTpWlm eq 'L'}" >
// 					<c:if test="${empty hidePopL}" >
// 	 					$("body").append("<a class=\"fancybox fancybox.iframe\" rel=\"popup\" href=\"popup.action?popupSeq=${popup.popupSeq}\" ></a>");
// 						$("body").append(makeInput("widthL",popupWinWidth));
// 						$("body").append(makeInput("heightL",popupWinHeight));
// 						LPopup = true;
// 	 				</c:if>
// 				</c:if>
// 				<c:if test="${popup.popupOpenTpWlm eq 'M'}" >
// 					<c:if test="${empty popup.hidepop}" >
// 						$("body").append("<div id='popM${popup.popupSeq}'>"+
// 					        "<div id=\"windowHeader\"><span id=\"windowTitle\">${popup.popupTitle}</span></div>"+
// 					        "<div style='overflow:hidden;'>"+
// 					            "<div class=\"container\">"+
// 					                "<iframe calss=\"windowIframe iframe-class\" style=\"width:"+popupWinWidth+"px;height:"+(popupWinHeight-40)+"px;\" src=\"popup.action?popupSeq=${popup.popupSeq}\"></iframe>"+
// 					            "</div>"+
// 					        "</div>"+
// 					    "</div>");
// 						<c:if test="${popup.popupCenterYesNo eq 'yes'}">
// 				            var windowWidth = $( window ).width();
// 				            var windowHeight = $( window ).height();
// 							popupWinTop = (windowWidth - popupWinWidth) / 2;
// 							popupWinLeft = (windowHeight - popupWinHeight) / 2;
// 				        	$( window ).resize(function() {
// 					            var windowWidth = $( window ).width();
// 					            var windowHeight = $( window ).height();
// 								popupWinTop = (windowWidth - popupWinWidth) / 2;
// 								popupWinLeft = (windowHeight - popupWinHeight) / 2;
// 								$('#popM${popup.popupSeq}').jqxWindow({position: {x:popupWinTop,y:popupWinLeft}});
// 					        });
// 			        	</c:if>

// 			            $('#popM${popup.popupSeq}').jqxWindow({
// 			            	position: {x:popupWinTop,y:popupWinLeft} ,
// 			                showCollapseButton: false,
// 			                resizable: false,
// 			                maxWidth:popupWinWidth,
// 			                maxHeight:popupWinHeight,
// 			                width: popupWinWidth,
// 			                height: popupWinHeight,
// 			                minWidth: popupWinWidth,
// 			                minHeight: popupWinHeight
// 			            });

// 					</c:if>
// 				</c:if>

// 			</c:forEach>

// 			if(LPopup == true){
// 				$("a.fancybox").attr('rel', 'popup').fancybox({
// 					autoSize	: false,
// 				    autoScale         : true,
// 				    autoDimensions    : true,
// 					nextEffect  : 'none',
// 			        prevEffect  : 'none',
// 			        padding     : 0,
// 			        margin      : [0, 0, 0, 0], // Increase left/right margin
// 				    fitToView: false,
// 				    afterLoad: function(){
// 				     this.width = $("input[name=widthL]").eq(this.index).val();
// 				     this.height = $("input[name=heightL]").eq(this.index).val();
// 				    }
// 			    });

// 				$("a.fancybox").click();
// 			}

		}

	</script>

</head>
<body>

	<page:applyDecorator name="gnb_m" />

	<section class="cont">
		<div class="visual_bx">
			<ul class="bxslider">
			  	<c:forEach var="eBannerTempListItem" items="${eBannerTempList}" varStatus="nStatus">
					<li><img src="${eBannerTempListItem.attchFilePath}" alt="" /></li>
				</c:forEach>
			</ul>
		</div>
		<script>
			$('.bxslider').bxSlider({
			        auto:true,
			        autoHover:true,
			        speed:700,
			        autoDelay:500,
			        controls:false
			    });
		</script>
		<!--// visual_bx -->
		<ul class="reser_bx">
			<li><a href="/ISDS/cs/telCsI.do" class="callAd"><em>전화상담 예약</em></a></li>
			<li><a href="/ISDS/cs/tserviceI.do" class="tripSv"><em>출장서비스 예약</em></a></li>
		</ul>
		<!--// reser_bx -->
		<div class="quick_bx">
			<ul>
				<li class="mq01"><a href="/ISDS/view/view.do?pageCd=resGuid"><span class="txt">서비스요금안내</span></a></li>
				<li class="mq02"><a href="/ISDS/locStore/locStoreL.do?pageCd=BBM00057"><span class="txt">매장찾기</span></a></li>
				<li class="mq03"><a href="/ISDS/bbt/bbt00002.do?pageCd=BBM00003"><span class="txt">1:1문의</span></a></li>
				<li class="mq04"><a href="/ISDS/bbt/bbt00004.do?pageCd=BBM00004"><span class="txt">자주하는 질문</span></a></li>
				<li class="mq05"><a href="/ISDS/bbt/bbt00008.do?pageCd=BBM00075"><span class="txt">동영상가이드</span></a></li>
				<li class="mq06"><a href="/ISDS/bbt/bbt00009.do?pageCd=BBM00050"><span class="txt">제품매뉴얼</span></a></li>
			</ul>
		</div>
		<!--// quick_bx -->
	</section>

	<page:applyDecorator name="footer_m" />

</body>
</html>
