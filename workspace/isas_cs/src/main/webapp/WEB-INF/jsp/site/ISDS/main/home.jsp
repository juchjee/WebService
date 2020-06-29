<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<head>
	<page:applyDecorator name="header" />
	<link rel="stylesheet" media="all" type="text/css" href="${rootUri}common/css/main.css" />

	<script type="text/javascript">

		function init(){
			fnEvent();
		}

		function fnEvent(){

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



			faqView1 = function(title, pageCd, url) {
				document.faqForm1.boardMstCd.value = pageCd;
				document.faqForm1.boardCateNm.value = title;
				document.faqForm1.action = url;
				document.faqForm1.submit();
			}

			faqView2 = function(seq) {
				document.faqForm2.boardSeq.value = seq;
				document.faqForm2.action = "/ISDS/bbt/bbt00004V.do?pageCd=BBM00004";
				document.faqForm2.submit();
			}

			noticeView = function(seq) {
				document.noticeForm.boardSeq.value = seq;
				document.noticeForm.action = "/ISDS/bbt/bbt00001V.do?pageCd=BBM00001";
				document.noticeForm.submit();
			}

		}

	</script>
</head>

<body>
	<p id="skipMenu">
	<a href="#">주메뉴</a>
	<a href="#">본문 바로가기</a>
</p>

<!--=============== #WRAP ===============-->
<div id="wrap">

<!--=============== #HEADER ===============-->
	<page:applyDecorator name="gnb" />
<!--=============== #/HEADER ===============-->
	<div class="content">
		<section class="cont_top_bx">
			<h2 class="blind">이누스제품홍보 및 빠른메뉴이동</h2>
			<div class="visual_bx">
				<ul class="bxslider">
					<c:forEach var="eBannerTempListItem" items="${eBannerTempList}" varStatus="nStatus">
						<li><img src="${eBannerTempListItem.attchFilePath}" alt="" /></li>
					</c:forEach>
				</ul>
			</div>
			<ul class="quick_bx">
				<li><a href="/ISDS/cs/telCsI.do" class="quick01"><span>전화상담 예약</span></a></li>
				<li><a href="/ISDS/cs/tserviceI.do" class="quick02"><span>출장서비스 예약</span></a></li>
				<li><a href="/ISDS/view/view.do?pageCd=resGuid" class="quick03"><span>서비스 요금 안내</span></a></li>
				<li><a href="/ISDS/locStore/locStoreL.do?pageCd=BBM00057" class="quick04"><span>매장찾기</span></a></li>
			</ul>
		</section>

		<section class="cont_btm_bx">
			<h2 class="blind">이누스 관련 공지,가이드,메뉴얼 정보</h2>
			<div class="btm_in">
				<form id="faqForm1" name="faqForm1" method="post">
					<input type="hidden" name="boardMstCd" value="" />
					<input type="hidden" name="boardCateNm" value="" />
					<div class="product_bx">
						<h3>제품별 빠른 해결</h3>
						<div class="tab_bx">
							<p class="tabM01"><a href="#">비데</a></p>
							<div class="lstBox" id="tab_num1">
								<ul>
									<li onclick="faqView1('비데', 'BBM00004', '/ISDS/bbt/bbt00004.do?pageCd=BBM00004');"><a href="#">자주하는 질문</a></li>
									<li onclick="faqView1('비데', 'BBM00007', '/ISDS/bbt/bbt00004.do?pageCd=BBM00007');"><a href="#">간단 조치 방법</a></li>
									<li onclick="faqView1('비데', 'BBM00075', '/ISDS/bbt/bbt00008.do?pageCd=BBM00075');"><a href="#">동영상 가이드</a></li>
									<li onclick="faqView1('비데', 'BBM00050', '/ISDS/bbt/bbt00009.do?pageCd=BBM00050');"><a href="#">제품 메뉴얼</a></li>
								</ul>
								<a href="#" onclick="faqView1('비데', 'BBM00004', '/ISDS/bbt/bbt00004.do?pageCd=BBM00004');" class="moreBtn01">비데 빠른해결 더보기</a>
							</div><!--// 비데 -->
							<p class="tabM02"><a href="#">위생도기</a></p>
							<div class="lstBox" id="tab_num2">
								<ul>
									<li onclick="faqView1('위생도기', 'BBM00004', '/ISDS/bbt/bbt00004.do?pageCd=BBM00004');"><a href="#">자주하는 질문</a></li>
									<li onclick="faqView1('위생도기', 'BBM00007', '/ISDS/bbt/bbt00004.do?pageCd=BBM00007');"><a href="#">간단 조치 방법</a></li>
									<li onclick="faqView1('위생도기', 'BBM00075', '/ISDS/bbt/bbt00008.do?pageCd=BBM00075');"><a href="#">동영상 가이드</a></li>
									<li onclick="faqView1('위생도기', 'BBM00050', '/ISDS/bbt/bbt00009.do?pageCd=BBM00050');"><a href="#">제품 메뉴얼</a></li>
								</ul>
								<a href="#"  onclick="faqView1('위생도기', 'BBM00004', '/ISDS/bbt/bbt00004.do?pageCd=BBM00004');" class="moreBtn01">위생도기 빠른해결 더보기</a>
							</div><!--// 위생도기 -->
							<p class="tabM03"><a href="#">수전</a></p>
							<div class="lstBox" id="tab_num3">
								<ul>
									<li onclick="faqView1('수전', 'BBM00004', '/ISDS/bbt/bbt00004.do?pageCd=BBM00004');"><a href="#">자주하는 질문</a></li>
									<li onclick="faqView1('수전', 'BBM00007', '/ISDS/bbt/bbt00004.do?pageCd=BBM00007');"><a href="#">간단 조치 방법</a></li>
									<li onclick="faqView1('수전', 'BBM00075', '/ISDS/bbt/bbt00008.do?pageCd=BBM00075');"><a href="#">동영상 가이드</a></li>
									<li onclick="faqView1('수전', 'BBM00050', '/ISDS/bbt/bbt00009.do?pageCd=BBM00050');"><a href="#">제품 메뉴얼</a></li>
								</ul>
								<a href="#"  onclick="faqView1('수전', 'BBM00004', '/ISDS/bbt/bbt00004.do?pageCd=BBM00004');" class="moreBtn01">수전 빠른해결 더보기</a>
							</div><!--// 수전 -->
							<p class="tabM04"><a href="#">블렌더</a></p>
							<div class="lstBox" id="tab_num4">
								<ul>
									<li onclick="faqView1('블렌더', 'BBM00004', '/ISDS/bbt/bbt00004.do?pageCd=BBM00004');"><a href="#">자주하는 질문</a></li>
									<li onclick="faqView1('블렌더', 'BBM00007', '/ISDS/bbt/bbt00004.do?pageCd=BBM00007');"><a href="#">간단 조치 방법</a></li>
									<li onclick="faqView1('블렌더', 'BBM00075', '/ISDS/bbt/bbt00008.do?pageCd=BBM00075');"><a href="#">동영상 가이드</a></li>
									<li onclick="faqView1('블렌더', 'BBM00050', '/ISDS/bbt/bbt00009.do?pageCd=BBM00050');"><a href="#">제품 메뉴얼</a></li>
								</ul>
								<a href="#"  onclick="faqView1('블렌더', 'BBM00004', '/ISDS/bbt/bbt00004.do?pageCd=BBM00004');" class="moreBtn01">블렌더 빠른해결 더보기</a>
							</div><!--// 블렌더 -->
							<p class="tabM05 last"><a href="#">이누스바스</a></p>
							<div class="lstBox" id="tab_num5">
								<ul>
									<li onclick="faqView1('이누스바스', 'BBM00004', '/ISDS/bbt/bbt00004.do?pageCd=BBM00004');"><a href="#">자주하는 질문</a></li>
									<li onclick="faqView1('이누스바스', 'BBM00007', '/ISDS/bbt/bbt00004.do?pageCd=BBM00007');"><a href="#">간단 조치 방법</a></li>
									<li onclick="faqView1('이누스바스', 'BBM00075', '/ISDS/bbt/bbt00008.do?pageCd=BBM00075');"><a href="#">동영상 가이드</a></li>
									<li onclick="faqView1('이누스바스', 'BBM00050', '/ISDS/bbt/bbt00009.do?pageCd=BBM00050');"><a href="#">제품 메뉴얼</a></li>
								</ul>
								<a href="#"  onclick="faqView1('이누스바스', 'BBM00004', '/ISDS/bbt/bbt00004.do?pageCd=BBM00004');" class="moreBtn01">이누스바스 빠른해결 더보기</a>
							</div><!--// 이누스바스 -->
						</div>
					</div>
				</form>
				<!--// product_bx -->
				<div class="brd_bx">
					<div class="brdlst">
						<h3>공지사항</h3>
							<form id="noticeForm" name="noticeForm" method="post">
								<input type="hidden" name="boardSeq" />
								<input type="hidden" id="boardMstCd" name="boardMstCd" value="BBM00001" />
								<ul class="list">
										<c:forEach var="mainNotice" items="${mainNoticeList}" varStatus="nStatus">
											<li class="num${nStatus.index+1}" onclick="noticeView('${mainNotice.boardSeq}');">
												<a href="#" onclick="noticeView('${mainNotice.boardSeq}');">
													<span class="tit elip">${mainNotice.boardTitle}</span>
													<i class="date">${mainNotice.regDt}</i>
												</a>
											</li>
										</c:forEach>
								</ul>
							</form>
						<a href="/ISDS/bbt/bbt00001.do?pageCd=BBM00001" class="moreBtn02">공지사항 더 보기</a>
					</div>
					<!--// notice -->
					<div class="brdlst">
						<h3>자주하는 질문</h3>
							<form id="faqForm2" name="faqForm2" method="post">
								<input type="hidden"  name="boardSeq" />
								<input type="hidden" id="boardMstCd" name="boardMstCd" value="BBM00004" />
								<input type="hidden" id="boardCateNm" name="boardCateNm" value="비데" />
								<ul class="list">
									<c:forEach var="mainFaq" items="${mainFaqList}" varStatus="nStatus">
										<li class="num${nStatus.index+1}" onclick="faqView2('${mainFaq.boardSeq}');">
											<a href="#" onclick="faqView2('${mainFaq.boardSeq}');">
												<span class="tit elip">${mainFaq.boardTitle}</span>
												<i class="date">${mainFaq.regDt}</i>
											</a>
										</li>
									</c:forEach>
								</ul>
							</form>
						<a href="/ISDS/bbt/bbt00004.do?pageCd=BBM00004" class="moreBtn02">자주하는 질문 더 보기</a>
					</div>
					<!--// faq -->
				</div>
				<!--// brd_bx -->

				<div class="guide_bx">
					<a href="/ISDS/bbt/bbt00008.do?pageCd=BBM00075" class="movie">
						<h2 class="blind">동영상 가이드 더 보기</h2>
						<h3>동영상 가이드</h3>
						<p>제품 확인 후 동영상을<br> 확인해 주세요!</p>
						<i class="moreBtn03">더보기</i>
					</a>
					<a href="/ISDS/bbt/bbt00009.do?pageCd=BBM00050" class="manual">
						<h2 class="blind">제품매뉴얼 더 보기</h2>
						<h3>제품매뉴얼</h3>
						<p>제품에 맞는 설명을<br> 확인하세요!</p>
						<i class="moreBtn03">더보기</i>
					</a>
					<div class="app">
						<h3>서비스센터 <br>앱 다운로드</h3>
						<div class="btn_wrap">
							<a href="https://play.google.com/store/apps/details?id=com.inusbath.cs" class="gp_btn">Google Play</a>
							<a href="https://itunes.apple.com/us/app/inus-서비스센터/id1289570519?l=ko&ls=1&mt=8" class="as_btn">App Store</a>
						</div>
					</div>
					<div class="call">
						<dl class="ct call_one">
							<dt>고객센터 대표상담</dt>
							<dd><span class="blind">1588-8613</span></dd>
						</dl>
						<dl class="ct call_two">
							<dt>욕실리모델링 상담</dt>
							<dd><span class="blind">1522-8760</span></dd>
						</dl>
						<dl class="time">
							<dt>평일 -</dt>
							<dd>09:00 ~ 18:00<span class="dayOff">(주말/공휴일 휴무)</span></dd>
							<dt>점심시간 -</dt>
							<dd>12:00 ~ 13:00</dd>
						</dl>
					</div>
				</div>
				<!--// guide_bx -->
			</div>
		</section>
		<!--// cont_btm_bx -->
	</div>

<!--=============== #FOOTER ===============-->
	<page:applyDecorator name="gnb_footer" />
	<page:applyDecorator name="footer" />
<!--=============== #/FOOTER ===============-->
</div>
<!--=============== #WRAP ===============-->

</body>
</html>