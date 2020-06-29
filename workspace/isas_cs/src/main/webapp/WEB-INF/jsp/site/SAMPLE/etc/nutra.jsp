<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <meta charset="utf-8">


    <!-- [SEO] -->
	<meta name="author" content="Alvaro Trigo Lopez" />
	<meta name="description" content="Nutra 듀오락은 세계특허 듀얼코팅기술로 세계적으로 인정받고 있는 한국형 프로바이오틱스 전문 브랜드 듀오락의 축적된 기술을 바탕으로 고객 여러분께 보다 새롭고 다양한 상품으로 다가가기 위해 만든 새로운 가치의 건강기능식품 브랜드입니다 " />
	<meta name="keywords"  content="듀오락, 프로바이오틱스, 유산균, 듀얼코팅, 세계특허, 세계수출 1위, 한국형 유산균, 맞춤형 복합균주, 기탁균주" />
	<meta name="Resource-type" content="Document" />

    <title>뉴트라 듀오락</title>

    <!-- [loading stylesheets] -->
    <link rel="stylesheet" type="text/css" href="/nutra/css/style.css" />
    <link rel="stylesheet" type="text/css" href="/nutra/css/carousel.css">
    <style>
		.copyright { display: block; background: none; padding-bottom: 80px; }
    </style>

</head>

    <script>
    jQuery(document).ready(function($) {
            $(".scroll").click(function(event){
                    event.preventDefault();
                    $('html,body').animate({scrollTop:$(this.hash).offset().top}, 500);
            });
    });
    </script>

    <!-- [videoplay] -->
	<script>
    jQuery(document).ready(function($) {
        $('.video-image').click(function() {
            $('.video-image').css('display', 'none');
        });
    });
    </script>

    <!-- [gotop] -->


    <body>
        <div class="pc_web">
            <div data-page="event" id="mainslide" class="section clearfix">
            	<div class="container">
                	<div class="maintitle"><img src="/nutra/images/maintitle.png"></div>

    				<div class="row">
                      <ul class="carousel">
                        <li class="item active"><img src="/nutra/images/duolac1.png"></li>
                        <li class="item"><img src="/nutra/images/duolac2.png"></li>
                        <li class="item"><img src="/nutra/images/duolac3.png"></li>
                        <li class="item"><img src="/nutra/images/duolac4.png"></li>
                      </ul>
                    </div>
                    <div class="controls">
                     <a href="#" class="previous"><img src="/nutra/images/btn-prev.png"></a>
                     <a href="#" class="next"><img src="/nutra/images/btn-next.png"></a>
                    </div>
    			</div>
            </div>
            <div id="section0" class="section clearfix">
            	<div class="container">
                	<div class="sectiontitle"><img src="/nutra/images/section0-title.png"></div>
                    <div class="sectionimg"><img src="/nutra/images/section0-img.png"></div>
                </div>
            </div>
            <div id="section1" class="section clearfix">
            	<div class="container">
            		<div id="section1-pos"></div>
                </div>
            	<div class="container">
                	<div class="sectiontitle"><img src="/nutra/images/section1-title.png"></div>
                    <div class="sectionimg"><img src="/nutra/images/section1-img.png"></div>
                </div>
            </div>
            <div id="section2" class="section clearfix">
            	<div class="container">
            		<div id="section2-pos"></div>
                </div>
            	<div class="container">
                	<div class="sectiontitle"><img src="/nutra/images/section2-title.png" id="section2-1"></div>
                    <div class="sectionimg"><img src="/nutra/images/section2-img.png"></div>
                </div>
            </div>
            <div id="section3" class="section clearfix">
            	<div class="container">
            		<div id="section3-pos"></div>
                </div>
            	<div class="container">
    	            <div class="video">
                    	<div class="video-box"><iframe width="650" height="380" src="https://www.youtube.com/embed/uYppUDF5lBk?rel=0&amp;controls=0&amp;showinfo=0" frameborder="0" allowfullscreen></iframe></div>
    					<div class="video-image"> <img src="/nutra/images/videoimg.png"></div>
                        <!-- <div class="video-frame"> <img src="/nutra/images/videoframe.png"></div> -->
                    </div>
                	<div class="sectiontitle"><img src="/nutra/images/section3-title.png"></div>
                </div>
            </div>
            <div id="section4" class="section clearfix">
            	<div class="container">
                	<div class="superbiotics"><img src="/nutra/images/superbiotics.png"></div>
                	<div class="sectiontitle"><img src="/nutra/images/section4-title.png"></div>
                    <div class="sectionimg"><img src="/nutra/images/section4-img.png"></div>
                </div>
            </div>
            <div id="section5" class="section clearfix">
            	<div class="container">
                	<div class="sectiontitle"><img src="/nutra/images/section5-title.png"></div>
                    <div class="sectionimg"><img src="/nutra/images/section5-img.png"></div>
                </div>
            </div>
        </div>
        <div class="mobile_web">
            <div id="header_mobile" class="container">
                <img src="/nutra/images/header.png">
            </div>
            <img src="/nutra/images/content.jpg">
        </div>
        <div id="section6" class="section clearfix">
        	<div class="container">
            	<div class="sectiontitle"><img src="/nutra/images/section6-title.png"></div>
                <div class="sectionimg"><img src="/nutra/images/section6-img.png"></div>
            </div>
        </div>
        <div id="section7" class="section clearfix">
        	<div class="container">
            	<ul id="product" class="scroll">
                    <li>
                        <a onclick="location.href='/ISDS/store/store_view.do?prodCd=PPD00006'" target="_parent" style="cursor:pointer;">
                        <div class="thumb"><img src="/nutra/images/product1.jpg"></div>
                        <h3>데일리 바이탈리티</h3>
                        <img src="/nutra/images/btn.png"></a>
                    </li>
                    <li>
                        <a onclick="location.href='/ISDS/store/store_view.do?prodCd=PPD00005'" target="_parent" style="cursor:pointer;">
                        <div class="thumb"><img src="/nutra/images/product2.jpg"></div>
                        <h3>데일리 키즈</h3>
                        <img src="/nutra/images/btn.png"></a>
                    </li>
                    <li>
                        <a onclick="location.href='/ISDS/store/store_view.do?prodCd=PPD00003'" target="_parent" style="cursor:pointer;">
                        <div class="thumb"><img src="/nutra/images/product3.jpg"></div>
                        <h3>듀오락 위청장쾌</h3>
                        <img src="/nutra/images/btn.png"></a>
                    </li>
                    <li>
                        <a onclick="location.href='/ISDS/store/store_view.do?prodCd=PPD00004'" target="_parent" style="cursor:pointer;">
                        <div class="thumb"><img src="/nutra/images/product4.jpg"></div>
                        <h3>듀오락 스탑 츄어블</h3>
                        <img src="/nutra/images/btn.png"></a>
                    </li>
                </ul>
            </div>
        </div>


		<!-- 2016-07-19 삭제
        <div class="footer">
            <div class="container">
            	<div class="footertop"><img src="/nutra/images/footer.png"></div>
            </div>
            <div class="copyright">
            	<div class="container">
                    <div class="tel">
                        <h3>고객센터/제품상담</h3>
                        <a href="tel:080-668-6108">080-668-6108</a>
                    </div>
                    <div class="email">
                        <h3>이메일</h3>
                        <a href="mailto:duolacshop@cellbiotech.com">duolacshop@cellbiotech.com</a>
                    </div>
                    <p>
                    <strong>(주)쎌바이오텍 인터내셔날</strong><br>
                    본사:경기도 김포시 월곶면 애기봉로 409번길 50 ㅣ 대표자:정명준 <br>
                    개인정보관리책임자 : 강인홍 ㅣ 사업자등록번호 : 220-81-52116  <br>
                    통신판매업신고 : 제 2012-경기김포-0298호 ㅣ 건강기능식품판매업 영업신고 : 김포 제 684호<br>
                    본 사이트에 표시된 각종 도안 및 문구 등은 국내외 특허 및 디자인, 상표법에 의해 보호받고 있습니다.<br>
                    따라서 이를 당사의 허락없이 사용, 배포, 게시 할 경우 민,형사 상의 책임을 질수 있습니다.<br>
                    CopyrightⓒCellbiotech CO.,LTD ALL Rights Reserved.<br>
                    </p>
                </div>
            </div>
        </div>
		-->

        <div id="footerlink">
			<!-- 2016-07-19 삭제
        	<div class="container">
            	<div class="gotop"><a href="#mainslide" class="scroll"><img src="/nutra/images/gotop.png"></a></div>
            </div>
			-->
        	<div class="container">
                <ul>
                    <li><a href="/ISDS/main/home.do" target="_new">듀오락Mall 메인</a></li>
                    <li><a href="#section1-pos" class="scroll"><span>01</span><strong>세계특허 듀얼코팅</strong></a></li>
                    <li><a href="#section2-pos" class="scroll"><span>02</span><strong>한국형 유산균</strong></a></li>
                    <li><a href="#section3-pos" class="scroll"><span>03</span><strong>맞춤형 복합균주</strong></a></li>
                    <li><a href="#section4" class="scroll"><span>04</span><strong>기탁균주 사용</strong></a></li>
                    <li><a href="#section5" class="scroll"><span>05</span><strong>수출 1위 듀오락</strong></a></li>
                    <li><a href="/ISDS/store/store.do" class="scroll">제품구매</a></li>
                </ul>
            </div>
        </div>

        <!-- [main slide] -->
        <script src="/nutra/http://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script src="/nutra/js/jquery.circular-carousel.js"></script>
        <script src="/nutra/js/script.js"></script>

        <!-- [target link] -->
    </body>

</html>
