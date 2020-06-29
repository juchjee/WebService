<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<meta name="decorator" content="null" />
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<link rel="stylesheet" type="text/css" href="${rootUri}common/css/owl.carousel.css">
	<link rel="stylesheet" type="text/css" href="${rootUri}common/css/owl.theme.css" />
	<c:import url="/WEB-INF/jsp/general/lib.jsp" />
	<script type="text/javascript" src="${rootUri}common/js/owl.carousel.js"></script>
	<script type="text/javascript" src="${rootUri}common/js/slider.js"></script>
	<script type="text/javascript" src="${rootUri}common/js/jquery.bxslider.min.js"></script>
	<style type="text/css">
		.fancybox-type-iframe .fancybox-nav {width: 60px;}
		.fancybox-type-iframe .fancybox-nav span {visibility: visible;opacity: 0.5;}
		.fancybox-type-iframe .fancybox-nav:hover span {opacity: 1;}
		.fancybox-type-iframe .fancybox-next {right: -60px;}
		.fancybox-type-iframe .fancybox-prev {left: -60px;}
	</style>
	<script type="text/javascript">
	<!--
	//-->
		var errPop = false;
		if('<%=System.getProperty("os.name")%>'.toUpperCase().indexOf('XP') > 0 || '<%=System.getProperty("os.name")%>'.toUpperCase().indexOf('95') > 0 || '<%=System.getProperty("os.name")%>'.toUpperCase().indexOf('98') > 0 || '<%=System.getProperty("os.name")%>'.toUpperCase().indexOf('2000') > 0 || '<%=System.getProperty("os.name")%>'.toUpperCase().indexOf('ME') > 0 ){
			errPop = true;
		}

		var a = navigator.userAgent;
		if (navigator.userAgent.indexOf("MSIE 5.0") != -1 || navigator.userAgent.indexOf("MSIE 6.0") != -1 || navigator.userAgent.indexOf("MSIE 7.0") != -1 || navigator.userAgent.indexOf("MSIE 8.0") != -1){
			errPop = true;
        }

		if(errPop){
			alert('마이크로소프트사의  윈도우 XP, IE(인터넷 익스플로러)8\n이하 버전에 대한 지원 종료로 인하여\n상기 운영체제를 사용 중인 고객님들께서는\n본 페이지, 인증 회원가입 등\n일부 서비스가 정상적으로 이루어지지 않을 수 있습니다.\n불편하시더라도 윈도우즈 업데이트(유료) 또는\n스마트폰을 이용한 사용을 부탁드립니다.');
		}

		var timer;		// setInterval이 리턴하는 inrevalId
		var moveFlag = "N";
		var cur_notice_num = 0;
		var total_notice_num;
		var centerSlide = null;
		var footerSlide = null;

		function init(){
			total_notice_num = $("#notice span[class='text']").size() - 1;
			notice_move('next');
			slideFunc(); //페이지 로딩시 실행
			initEventHandler();
			fnEvent(); //신규

			if('${paramMap.EVENT_CLICK}' == 'ok'){
				fnMovieEvent();
			}
		}

		function slideFunc() {
			if(moveFlag=="N"){
				timer = setInterval(function() {
					notice_move('next');
				}, 3000);
			}else{
				timer = setInterval(function() {
					notice_move('prev');
				}, 3000);
			}
		}

		function notice_move(val){
			$("#notice span[class='text']").hide();
			$("#notice span[class='date']").hide();
			if(val=="next"){
				if(cur_notice_num == total_notice_num){
					cur_notice_num	= 0;
				}else{
					cur_notice_num++;
				}
				$("#notice span[class='text']:eq("+cur_notice_num+")").show();
				$("#notice span[class='date']:eq("+cur_notice_num+")").show();
			}else{
				if(cur_notice_num == 0){
					cur_notice_num	= total_notice_num -1;
				}else{
					cur_notice_num--;
				}
				$("#notice span[class='text']:eq("+cur_notice_num+")").show();
				$("#notice span[class='date']:eq("+cur_notice_num+")").show();
			}

		}

		function initEventHandler(){
			$('#notice').hover(function() {
				clearInterval(timer);	// 사용자가 마우스를 #slider 위에 놓으면 슬라이드를 멈춥니다.
			}, function() {
				slideFunc();			// 마우스를 빼면 슬라이드를 시작합니다.
			});
			$('#nextBtn').click(function() {
				clearInterval(timer);
				moveFlag="N";
				slideFunc();
			});
			$('#prevBtn').click(function() {
				clearInterval(timer);
				moveFlag="P";
				slideFunc();
			});
		}

		function location_url(url) {
			parent.location.href = url;
			if (document.engels1004.noticeOk.checked)
				setCookie("popup_event", "DONE", 0);
			CloseAllInfoWin();
		}

		function showInfo(div, bool, pop_top, pop_left, width) {
			CloseAllInfoWin();
			var oInfo = eval("document.all.info" + div);
			if (bool) {
				oInfo.style.top = pop_top; //10
				oInfo.style.left = pop_left; //220
				oInfo.style.display = "";
			} else {
				oInfo.style.display = "none";
			}
		}

		function CloseAllInfoWin() {
			var allWin = document.getElementsByTagName("DIV");
			for (var i = 0; i < allWin.length; i++) {
				if (allWin[i].isInfoWin) {
					setCookie("popup_event", "DONE", 1);
					allWin[i].style.display = "none";
				}
			}
			return;
		}

		function CloseWin(div, pop_left, width) {
			if (eval("document.engels1004" + div + ".noticeOk != undefined")) {
				if (eval("document.engels1004" + div + ".noticeOk.checked")) {
					setCookie("popup_event" + div, "DONE", 1);
				}
			}
			document.getElementById("info" + div).style.display = "none";
			return;
		}

		function opener_url(url) {
			location.href = url;
		}

		function fnEvent(){
			if($('#best ul li').length > 3){
				$('#best ul').bxSlider({
					auto: true,
					minSlides: 1,
					maxSlides: 3,
					slideWidth: 183,
					slideHeight: 206,
					pager: false,
					controls: false,
					autoHover: true
				});
			}
			var LPopup = false;

			<c:forEach var="popup" items="${popupList}" varStatus="nStatus">
			var popupWinTop = parseInt("${popup.popupWinTop}");
			var popupWinLeft = parseInt("${popup.popupWinLeft}");
			var popupWinWidth = parseInt("${popup.popupWinWidth}");
			var popupWinHeight = parseInt("${popup.popupWinHeight}");

			<c:if test="${!iConstant.isMobile(pageContext.request)}">

			<c:if test="${popup.popupOpenTpWlm eq 'W'}" >
				<c:if test="${empty popup.hidepop}" >
					showPopup("popup.action?popupSeq=${popup.popupSeq}", "pop${popup.popupSeq}", popupWinWidth,popupWinHeight,"${popup.popupCenterYesNo}",popupWinTop,popupWinLeft);
				</c:if>
			</c:if>

			</c:if>
			<c:if test="${popup.popupOpenTpWlm eq 'L'}" >
				<c:if test="${empty hidePopL}" >
 					$("body").append("<a class=\"fancybox fancybox.iframe\" rel=\"popup\" href=\"popup.action?popupSeq=${popup.popupSeq}\" ></a>");
					$("body").append(makeInput("widthL",popupWinWidth));
					$("body").append(makeInput("heightL",popupWinHeight));
					LPopup = true;
 				</c:if>
			</c:if>
			<c:if test="${popup.popupOpenTpWlm eq 'M'}" >
				<c:if test="${empty popup.hidepop}" >
					$("body").append("<div id='popM${popup.popupSeq}'>"+
				        "<div id=\"windowHeader\"><span id=\"windowTitle\">${popup.popupTitle}</span></div>"+
				        "<div style='overflow:hidden;'>"+
				            "<div class=\"container\">"+
				                "<iframe calss=\"windowIframe iframe-class\" style=\"width:"+popupWinWidth+"px;height:"+(popupWinHeight-40)+"px;\" src=\"popup.action?popupSeq=${popup.popupSeq}\"></iframe>"+
				            "</div>"+
				        "</div>"+
				    "</div>");
					<c:if test="${popup.popupCenterYesNo eq 'yes'}">
			            var windowWidth = $( window ).width();
			            var windowHeight = $( window ).height();
						popupWinTop = (windowWidth - popupWinWidth) / 2;
						popupWinLeft = (windowHeight - popupWinHeight) / 2;
			        	$( window ).resize(function() {
				            var windowWidth = $( window ).width();
				            var windowHeight = $( window ).height();
							popupWinTop = (windowWidth - popupWinWidth) / 2;
							popupWinLeft = (windowHeight - popupWinHeight) / 2;
							$('#popM${popup.popupSeq}').jqxWindow({position: {x:popupWinTop,y:popupWinLeft}});
				        });
		        	</c:if>

		            $('#popM${popup.popupSeq}').jqxWindow({
		            	position: {x:popupWinTop,y:popupWinLeft} ,
		                showCollapseButton: false,
		                resizable: false,
		                maxWidth:popupWinWidth,
		                maxHeight:popupWinHeight,
		                width: popupWinWidth,
		                height: popupWinHeight,
		                minWidth: popupWinWidth,
		                minHeight: popupWinHeight
		            });

				</c:if>
			</c:if>
			</c:forEach>

			if(LPopup == true){
				$("a.fancybox").attr('rel', 'popup').fancybox({
					autoSize	: false,
				    autoScale         : true,
				    autoDimensions    : true,
					nextEffect  : 'none',
			        prevEffect  : 'none',
			        padding     : 0,
			        margin      : [0, 0, 0, 0], // Increase left/right margin
				    fitToView: false,
				    afterLoad: function(){
				     this.width = $("input[name=widthL]").eq(this.index).val();
				     this.height = $("input[name=heightL]").eq(this.index).val();
				    }
			    });

				$("a.fancybox").click();
			}
			//중앙 배너
			centerSlide = new Slide({
				slideArea : $('#ebr00002'),
				auto : true,
				speed : 5000
			});
			//하단 배너
			footerSlide = new Slide({
				slideArea : $('#ebr00003'),
				auto : true,
				speed : 5000
			});
			//중앙 모바일 배너
			$("#owl-slide").owlCarousel({
				navigation : false,
				slideSpeed : 300,
				paginationSpeed : 400,
				singleItem:true,
				autoPlay : 4000
			});

			$("#owl-slide2").owlCarousel({
				navigation : false,
				slideSpeed : 300,
				pagination : false,
				paginationSpeed : 400,
				singleItem:true,
				autoPlay : 4000
			});

		}

		function fnEventMove(val){
			makeForm(mallFullUri + "evn/evnDetail.do?eventSeq=" + val + "&pageCd=SFM00301&page=1", null, null, "_self");
		}

	</script>
	<script type="text/javascript">
	function fnMovieEvent(){
		$('a.fancybox').remove();

		<c:if test="${not isLogIn}">
			alert('로그인이 필요합니다.');
			makeForm(mallFullUri + "mm/acessLogin.do?referUrl=/ISDS/main/home.do", {"eventClick": 'ok'});
		</c:if>

		var moviePopup = false;
		var popupWinWidth = 320;
		var popupWinHeight = 240;

		<c:if test="${isLogIn}">
			$("body").append("<a class=\"fancybox fancybox.iframe\" rel=\"popup\" href=\"eventMoviePopup.action?movieSeq=190482926\" ></a>");
			<c:if test="${!iConstant.isMobile(pageContext.request)}">
				popupWinWidth = 640;
				popupWinHeight = 480;
			</c:if>
			$("body").append(makeInput("widthL", popupWinWidth));
			$("body").append(makeInput("heightL", popupWinHeight));
			moviePopup = true;
		</c:if>

		if(moviePopup == true){
			$("a.fancybox").attr('rel', 'popup').fancybox({
				autoSize	: false,
			    autoScale         : true,
			    autoDimensions    : true,
				nextEffect  : 'none',
		        prevEffect  : 'none',
		        padding     : 0,
		        margin      : [0, 0, 0, 0], // Increase left/right margin
			    fitToView: false,
			    afterLoad: function(){
			     this.width = popupWinWidth;
			     this.height = popupWinHeight;
			    }
		    });

			$("a.fancybox").click();
		}
	}
	function fnEventRet(val){
		$.fancybox.close();
		$('a.fancybox').remove();

		var popupWinWidth = 320;
		var popupWinHeight = 240;

		$("body").append("<a class=\"fancybox fancybox.iframe\" rel=\"popup\" href=\"popup.action?popupSeq=" + val + "\" ></a>");
		$("body").append(makeInput("widthL",popupWinWidth));
		$("body").append(makeInput("heightL",popupWinHeight));

		$("a.fancybox").attr('rel', 'popup').fancybox({
			autoSize	: false,
		    autoScale         : true,
		    autoDimensions    : true,
			nextEffect  : 'none',
	        prevEffect  : 'none',
	        padding     : 0,
	        margin      : [0, 0, 0, 0], // Increase left/right margin
		    fitToView: false,
		    afterLoad: function(){
		     this.width = popupWinWidth;
		     this.height = popupWinHeight;
		    }
	    });


		$("a.fancybox").click();
	}

	</script>
</head>
<body>

	<!--=============== #WRAP ===============-->
	<div id="wrap" class="main">
		<!--=============== #HEADER ===============-->
		<c:import url="/WEB-INF/jsp/general/gnb.jsp" />
		<!--=============== #/HEADER ===============-->

		<!--=============== #CONTAINER ===============-->
		<div id="container">
			<!-- 메인 비쥬얼 -->
			<div class="main_visual_new">
				<ul>
				<c:forEach var="EBR00002Item" items="${EBR00002}" varStatus="nStatus">
					<li>
						<a href="${EBR00002Item.bannerLink}" class="<c:if test="${fn:length(EBR00002) > 1}">panel</c:if><c:if test='${nStatus.index == 0}'> html5lightbox</c:if>" target="_self" title="${EBR00002Item.bannerTitle}">
							<img class="pt" src="${EBR00002Item.attchFilePath}" alt="" />
							<img class="mobile" src="${EBR00002Item.attchMobileFilePath}" />
						</a>
					</li>
					</c:forEach>

				</ul>
				<div class="wing_bnr">
					<a href="/ISDS/bbt/bbt00001V.do?pageCd=BBM00001&boardSeq=38841&boardMstCd=BBM00001">
						<img class="pt" src="${rootUri}common/images/main/cardInfo.jpg" alt="" />
						<img class="mobile" src="${rootUri}common/images/main/mobCardInfo.jpg" alt="" />
					</a>
					<a href="#" class="btn on"></a>
				</div>
			</div>
			<!-- // 메인 비쥬얼 -->
			<div class="mc_wrap">
				<div class="mc_left">
					<dl>
						<dt><a href="/ISDS/bbt/bbt00001.do?pageCd=BBM00001">공지사항</a></dt><!-- 170102 수정 -->
						<dd>
							<div class="noti_wrap">
								<ul class="noti_sdr">
									<c:forEach var="mainNotice" items="${mainNoticeList}" varStatus="nStatus">
										<c:if test="${nStatus.index < 2}">
											<li><a href="${rootUri}${frontUri}bbt/bbt00001V.do?pageCd=${mainNotice.boardMstCd}&boardSeq=${mainNotice.boardSeq}&boardMstCd=${mainNotice.boardMstCd}"><span>[${mainNotice.boardCateNm}]</span> ${mainNotice.boardTitle}</a></li>
										</c:if>
									</c:forEach>
								</ul>
							</div>
							<ul class="noti_control">
								<li><a href="#" class="prev">이전</a></li>
								<li><a href="#" class="next">다음</a></li>
							</ul>
						</dd>
					</dl>
				</div>
				<div class="mc_right">
					<a href="/ISDS/etc/etc.do?pageCd=SFM00406">
						<img src="${rootUri}common/images/main/main_duolac_bnr.jpg" />
					</a>
				</div>
			</div>
			<!-- // mc_wrap -->
			<div class="main_pro_wrap">
				<div class="best_seller">
					<h3><img src="${rootUri}common/images/main/seller_tit1.png" alt="BEST SELLER" /></h3>
					<div class="pro_list_wrap">
						<ul class="pro_list">
							<c:forEach var="bestPProdMap" items="${bestPProdList}" varStatus="nStatus">
							<li>
								<dl>
									<dt>
										<a href="${rootUri}${frontUri}store/store_view.do?prodCd=${bestPProdMap.prodCd}"><img src="${bestPProdMap.basicImg}" width="180" height="180" alt="" /></a>
										<div class="icons_wrap">
											<ul>
												<li><a href="#" title="위시리스트"  onclick="wishList('${bestPProdMap.prodCd}')"><img src="${rootUri}common/images/main/pro_icon1.png" alt="" /></a></li>
												<li><a href="#" title="장바구니"  onclick="orderCart('${bestPProdMap.prodCd}')"><img src="${rootUri}common/images/main/pro_icon2.png" alt="" /></a></li>
												<li><a href="#" title="바로구매" onclick="orderDirect('${bestPProdMap.prodCd}')"><img src="${rootUri}common/images/main/pro_icon3.png" alt="" /></a></li>
												<input type="hidden" id="orderQty${bestPProdMap.prodCd}" value="${bestPProdMap.orderQty}" readonly="readonly">
											</ul>
										</div>
									</dt>
									<dd>
										<a href="#">
											<span class="tag">${bestPProdMap.secProdNm}</span>
											<span class="name">${bestPProdMap.prodNm}</span>
											<span class="price">${bestPProdMap.prodPrice}</span>
										</a>
									</dd>
								</dl>
							</li>
							</c:forEach>
						</ul>
					</div>
					<!-- // pro_list_wrap -->
				</div>
				<div class="new_product">
					<h3><img src="${rootUri}common/images/main/seller_tit2.png" alt="NEW PRODUCT" /></h3>
					<div class="pro_list_wrap">
						<ul>
						<c:forEach var="newPProdMap" items="${newPProdList}" varStatus="nStatus">

								<c:if test='${nStatus.index == 0 }'>
								<li>
								 <ul class="pro_list">
								 </c:if>
								<c:if test='${nStatus.index != 0 and nStatus.index mod 2 == 0 }'>
								<li>
								<ul class="pro_list">
								 </c:if>
									<li>
										<dl>
											<dt>
												<a href="${rootUri}${frontUri}store/store_view.do?prodCd=${newPProdMap.prodCd}">
												<img src="${newPProdMap.basicImg}" alt="" width="180" height="180" />
												</a>
												<div class="icons_wrap">
													<ul>
														<li><a href="#" title="위시리스트" onclick="wishList('${newPProdMap.prodCd}')"><img src="${rootUri}common/images/main/pro_icon1.png" alt="" /></a></li>
														<li><a href="#" title="장바구니" onclick="orderCart('${newPProdMap.prodCd}')"><img src="${rootUri}common/images/main/pro_icon2.png" alt="" /></a></li>
														<li><a href="#" title="바로구매" onclick="orderDirect('${newPProdMap.prodCd}')"><img src="${rootUri}common/images/main/pro_icon3.png" alt="" /></a></li>
														<input type="hidden" id="orderQty${newPProdMap.prodCd}" value="${newPProdMap.orderQty}" readonly="readonly">
													</ul>
												</div>
											</dt>
											<dd>
												<a href="#">
													<span class="tag">&nbsp;</span>
													<span class="name">${newPProdMap.prodNm}</span>
									<c:choose>
									<c:when test="${newPProdMap.prodSalePrice ne '0'}">
													<span class="price">${newPProdMap.prodSalePrice}</span>
									</c:when>
									<c:otherwise>
										<span class="price">${newPProdMap.prodPrice}</span>
									</c:otherwise>
									</c:choose>
												</a>
											</dd>
										</dl>
									</li>
								<c:if test='${(nStatus.index+1) mod 2 == 0 }'>
								 </ul>
								 </li>
								 </c:if>

							</c:forEach>
						</ul>
					</div>
					<!-- // pro_list_wrap -->
				</div>
			</div>
			<!-- // main_pro_wrap -->
			<div class="main_con_wrap">
				<ul>
					<li>
						<a href="/ISDS/evn/evn.do?pageCd=SFM00301">
							<dl>
								<dt>
									<img src="${rootUri}common/images/main/mcircle1.jpg" alt="" />
									<!-- <span class="mlabel"><img src="0common/images/main/mlabel.png" alt="" /></span> -->
								</dt>
								<dd>
									<p class="tit"><span>이벤트 &amp; 프로모션 </span></p>
									<p class="con"><span>듀오락의 모든 이벤트를 <br />한눈에 모아 볼 수 있습니다. </span></p>
									<span class="btn"><img src="${rootUri}common/images/main/mcircle_arrow.png" alt="바로가기 버튼" /></span>
								</dd>
							</dl>
						</a>
					</li>
					<li>
						<a href="/ISDS/bbt/bbt00003.do?pageCd=BBM00005">
							<dl>
								<dt><img src="${rootUri}common/images/main/mcircle2.jpg" alt="" /></dt>
								<dd>
									<p class="tit"><span>생생고객후기</span></p>
									<p class="con"><span>듀오락의 건강함을 함께<br />만나 보세요.</span></p>
									<span class="btn"><img src="${rootUri}common/images/main/mcircle_arrow.png" alt="바로가기 버튼" /></span>
								</dd>
							</dl>
						</a>
					</li>
					<li>
						<a href="/ISDS/bbt/bbt00005.do?pageCd=BBM00002">
							<dl>
								<dt><img src="${rootUri}common/images/main/mcircle3.jpg" alt="" /></dt>
								<dd>
									<p class="tit"><span>듀오락 소식</span></p>
									<p class="con"><span>듀오락의 다양한 소식을 <br />매일 만나보실 수 있습니다.</span></p>
									<span class="btn"><img src="${rootUri}common/images/main/mcircle_arrow.png" alt="바로가기 버튼" /></span>
								</dd>
							</dl>
						</a>
					</li>
				</ul>
			</div>
			<!-- // main_con_wrap -->
			<div class="main_bnr_wrap">
				<div class="main_bnr_right">
					<div id="main_bnr">
						<ul>
							<c:set var="cntBottomBanner" value="0"/>
							<c:forEach var="EBR00003Item" items="${EBR00003}" varStatus="nStatus">
							<c:set var="cntBottomBanner" value="${nStatus.index}"/>
								<li><a href="${EBR00003Item.bannerLink}" class="panel<c:if test='${nStatus.index == 0}'> html5lightbox</c:if>" target="_self" ><img src="${EBR00003Item.attchMobileFilePath}" alt="" /></a></li>
							</c:forEach>
						</ul>
					</div>
				</div>
				<div class="main_bnr_left">
					<!--
					vimeo 사용 시 소스
					<iframe class="main_iframe" src="//player.vimeo.com/video/190482926?autoplay=0" width="100%" height="100%" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
					<div class="cover"><img src="${rootUri}common/images/main/main_mv.jpg" alt="" /></div>
					-->
					<div id="mvPlay">
						<img class="pt" src="${rootUri}common/images/main/main_ytb_thum.jpg" onclick="javascript:mvPlay();"/>
						<img class="mobile" src="${rootUri}common/images/main/mob_main_ytb_thum.jpg" onclick="javascript:mvPlay();"/>
					</div>
				</div>
				<script type="text/javascript">
				function mvPlay(){
					$("#mvPlay").html("<iframe width='100%' height='100%' src='https://www.youtube.com/embed/CKkKe-f3GyI?rel=0&amp;controls=1&amp;showinfo=0&amp;autoplay=1' frameborder='0' allowfullscreen ></iframe>");
				}
				</script>
			</div>
			<!-- // main_bnr_wrap -->
			<div class="main_customer">
				<ul>
					<li class="li1">
						<div>
							<p class="stit">고객지원센터</p>
							<p class="num"><a href="tel:080-668-6108">080-668-6108</a></p>
							<ul class="info">
								<li><span>월요일 ~ 금요일(평일)</span>AM 9:00 ~ PM 6:00</li>
								<li><span>토요일(일,공휴일 휴무)</span>AM 9:00 ~ PM 1:00</li>
							</ul>
						</div>
					</li>
					<li class="li2">
						<div>
							<p class="stit">무통장입금 안내</p>
							<p class="bank">예금주 : (주)쎌바이오텍 인터내셔날</p>
							<ul class="info bank">
								<li><span>국민은행</span>695001-01-162988</li>
								<li><span>신한은행</span>140-007-363942</li>
							</ul>
						</div>
					</li>
					<li class="li3">
						<div>
							<ul class="mlist">
								<li class="m1"><a href="${rootUri}${frontUri}bbt/bbt00002.do?pageCd=BBM00007">서비스<br />문의하기</a></li>
								<li class="m2"><a href="${rootUri}${frontUri}bbt/bbt00004.do?pageCd=BBM00004">자주하는<br />질문</a></li>
								<li class="m3"><a href="${rootUri}${frontUri}etc/etc.do?pageCd=SFM00405">교환/반품<br />안내</a></li>
							</ul>
						</div>
					</li>
					<li class="li4">
						<a href="${rootUri}${frontUri}rules/genuine.do">
							<div>
								<p class="stit">듀오락 정품인증 안내</p>
								<p class="label">제품에 부착된 홀로그램 <br />라벨을 확인하세요</p>
								<p class="con">정품인증 확인이 불가한 경우 반품, 교환 등의 <br />판매 후 서비스를 보장할 수 없습니다.</p>
							</div>
						</a>
					</li>
				</ul>
			</div>
			<!-- // main_customer -->
		</div>

		<script>
		$('.main_visual_new > ul').bxSlider({
			auto: true,
			speed: 1000,
			mode: 'fade',
			autoControls: true,
			autoControlsCombine: true,
			controls: false,
			onSliderLoad: function(){
				// $('.main_visual_new').css({'height':'auto'});
				$('.main_visual_new li').removeClass('hid');
			}
		});
		$('.main_visual_new a.btn').on('click', function(){
			var ww = $(window).width();
			if(!$(this).hasClass('on')){
				$(this).addClass('on');
				$('.wing_bnr').stop().animate({'right':0}, 300);
			}else{
				$(this).removeClass('on');
				if(ww >= 1100){
					$('.wing_bnr').stop().animate({'right':'-311px'}, 300);
				}else{
					$('.wing_bnr').stop().animate({'right':'-28.1%'}, 300);
				}
			}
			return false;
		});
		setTimeout(function(){ $('.main_visual_new a.btn').click() }, 5000)

		var noti_sdr = $('.noti_sdr').bxSlider({
			auto: true,
			pager: false,
			controls: false,
			mode: 'vertical',
			responsive: true
		});
		$(window).resize(function(){
			noti_sdr.reloadSlider({
				auto: true,
				pager: false,
				controls: false,
				mode: 'vertical',
				responsive: true
			});
		});
		$('.noti_control a.prev').on('click', function(){
			noti_sdr.goToPrevSlide();
			return false;
		});
		$('.noti_control a.next').on('click', function(){
			noti_sdr.goToNextSlide();
			return false;
		});

		/*
		$('.mc_left ul.noti_sdr a').dotdotdot({
			watch: window
		});
		*/
		$('.mc_left ul.noti_sdr a').each(function(){
			$(this).css({'padding-left': $(this).children('span').width() + 10});
			if($(this).height() <= 16){ // 1줄인 경우
				$(this).addClass('line1');
			}else{ // 2줄인 경우
				$(this).addClass('line2');
			}
		});

		if(parseInt('${cntBottomBanner}') > 0){
			$('#main_bnr > ul').bxSlider({
				auto: true,
				mode: 'fade',
				controls: false
			});
		}

		$('.main_con_wrap ul li').on('mouseenter', function(){
			$(this).find('p.tit span').css({'border-bottom':'1px solid #737373'});
			$(this).find('p.con span').css({'border-bottom':'1px solid #909bac'});
		});
		$('.main_con_wrap ul li').on('mouseleave', function(){
			$(this).find('p.tit span').css({'border-bottom':'none'});
			$(this).find('p.con span').css({'border-bottom':'none'});
		});

		// BEST SELLER & NEW PRODUCT 슬라이드 영역
		ov_effect();

		var best_sdr = $('.best_seller .pro_list_wrap > ul').bxSlider({
			auto: true,
			slideWidth: 218,
			minSlides:3,
			maxSlides:3,
			moveSlides: 1,
			controls: false,
			pager: false,
			onSlideAfter: function(){
				ov_effect();
			}
		});
		var new_sdr = $('.new_product .pro_list_wrap > ul').bxSlider({
			auto: true,
			mode: 'fade',
			pager: false
		});

		var ww = $(window).width();
		if(ww > 1100){
			best_sdr.reloadSlider({
				auto: true,
				slideWidth: 218,
				minSlides:3,
				maxSlides:3,
				moveSlides: 1,
				controls: false,
				pager: false,
				responsive: true,
				onSlideAfter: function(){
					ov_effect();
				}
			});
		}else{
			best_sdr.reloadSlider({
				auto: true,
				slideWidth: 320,
				minSlides:2,
				maxSlides:2,
				moveSlides: 1,
				controls: false,
				pager: false,
				responsive: true,
				onSlideAfter: function(){
					ov_effect();
				}
			});
		}

		function ov_effect(){
			$('.main_pro_wrap ul.pro_list li').on('mouseenter', function(){
				$(this).find('div.icons_wrap').stop().animate({'bottom':0}, 300);
				$(this).find('div.over').fadeIn('fast');
			});
			$('.main_pro_wrap ul.pro_list li').on('mouseleave', function(){
				$(this).find('div.icons_wrap').stop().animate({'bottom':-84}, 300);
				$(this).find('div.over').fadeOut('fast');
			});
		}

		// 브라우저 리사이즈 시
		$(window).resize(function(){
			var ww = $(window).width();
			if(ww > 1100){
				best_sdr.reloadSlider({
					auto: true,
					slideWidth: 218,
					minSlides:3,
					maxSlides:3,
					moveSlides: 1,
					controls: false,
					pager: false,
					responsive: true,
					onSlideAfter: function(){
						ov_effect();
					}
				});
			}else{
				best_sdr.reloadSlider({
					auto: true,
					slideWidth: 320,
					minSlides:2,
					maxSlides:2,
					moveSlides: 1,
					controls: false,
					pager: false,
					responsive: true,
					onSlideAfter: function(){
						ov_effect();
					}
				});
			}
			new_sdr.reloadSlider({
				auto: true,
				mode: 'fade',
				pager: false,
				responsive: true
			});

			if(!$('.main_visual_new a.btn').hasClass('on')){ // 윙배너가 닫혀있는 상태
				if(ww >= 1100){
					$('.wing_bnr').stop().animate({'right':'-311px'}, 300);
				}else{
					$('.wing_bnr').stop().animate({'right':'-28.1%'}, 300);
				}
			}
		});
		</script>

		<!--=============== #/CONTAINER ===============-->
		<!--=============== #FOOTER ===============-->
		<c:import url="/WEB-INF/jsp/general/footer.jsp" />
		<!--=============== #/FOOTER ===============-->
	</div>
	<!--=============== #WRAP ===============-->
	<!--=============== #Loading Div ===============-->
	<div id="loader_background" style="text-align: center; width: 100%; height: 100%; top: 0px; position: absolute; z-index: 1; background: #1B1B1B; visibility: hidden;">
		<div style="position: absolute; width: 100%; top: 50%; height: 240px; margin-top: -120px;">
			<img src="${rootUri}common/img/icon/ajaxLoader.gif" alt="Loading" />
		</div>
	</div>
	<!--=============== #Loading Div ===============-->
	<script type="text/javascript">
		<!--
			function menuInit(){gnbMenu('${depth1}', '${depth2}');}
		//-->
	</script>

	<script type="text/javascript">
		function isMobile(){
			var UserAgent = navigator.userAgent;
			var mobileChk = "";

			if (UserAgent.match(/iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null)
			{
				return true;
			}else{
				return false;
			}
		}
	</script>

	<script type="text/javascript" src="//static.criteo.net/js/ld/ld.js" async="true"></script>
	<script type="text/javascript">
		var mobileChk 	= "d";	//PC

		if(isMobile()){
			mobileChk = "m"; //모바일
		}

		window.criteo_q = window.criteo_q || [];
		window.criteo_q.push(
		        { event: "setAccount", account: 28205 },
		        { event: "setSiteType", type: mobileChk },
		        { event: "viewHome" }
		);
	</script>
</body>
</html>