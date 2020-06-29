<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
<head>
	<script type="text/javascript">
		function init(){
			/* 약관 class 이벤트 */
			if($(".footer div div ul").find("li:eq(0)").find("a").attr("class") == ""){
				$(".footer div div ul").find("li:eq(0)").find("a").addClass("glay");
			}
			if($(".footer div div ul").find("li:eq(1)").find("a").attr("class") == ""){
				$(".footer div div ul").find("li:eq(1)").find("a").addClass("glay");
			}
			if($(".footer div div ul").find("li:eq(2)").find("a").attr("class") != ""){
				$(".footer div div ul").find("li:eq(2)").find("a").removeClass();
			}
		}
	</script>
</head>
<body>
	<body>
	<div class="sub">
	  	<!--=============== #CONNTENTS ===============-->
		<div class="box_guide">
			<h2 class="tit">이메일무단수집거부</h2>		
			<p class="desc">이누스 이메일무단수집거부 방침입니다.</p>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>					
					<li class="last"><a href="#">이메일무단수집거부</a></li>
				</ul>
			</div>
		</div>
		<div class="box_terms type1">
			<div class="inner">
			<!-- 20200427 ryul 아이에스동서 > 이누스주식회사 -->
<!-- 				<p class="txt under ffb">아이에스동서는 정보통신망법 제50조의 2, 제50조의 7 등에 의거하여, 아이에스동서가 운영,관리하는 웹페이지 상에서,</p> -->
<!-- 				<p class="txt mt34 pl16"><span class="num">1.</span>이메일 주소 수집 프로그램이나 그 밖에 기술적 장치 등을 이용하여 이메일 주소를 무단으로 수집하는 행위를 거부합니다.</p> -->
<!-- 				<p class="txt pl16"><span class="num">2.</span>당사의 동의없이 ‘아이에스동서’ 문구를 사용하거나 영리 목적의 광고성 정보를 게시하는 행위를 거부합니다. <br /> -->
<!-- 				위를 위반 시 정보통신망법에 의해 형사처벌됩니다.</p>							 -->
				<p class="txt under ffb">이누스주식회사는 정보통신망법 제50조의 2, 제50조의 7 등에 의거하여, 이누스주식회사가 운영,관리하는 웹페이지 상에서,</p>
				<p class="txt mt34 pl16"><span class="num">1.</span>이메일 주소 수집 프로그램이나 그 밖에 기술적 장치 등을 이용하여 이메일 주소를 무단으로 수집하는 행위를 거부합니다.</p>
				<p class="txt pl16"><span class="num">2.</span>당사의 동의없이 ‘이누스주식회사’ 문구를 사용하거나 영리 목적의 광고성 정보를 게시하는 행위를 거부합니다. <br />
				위를 위반 시 정보통신망법에 의해 형사처벌됩니다.</p>
			</div>			
		</div>
	</div>
	<!--// sub -->
</body>