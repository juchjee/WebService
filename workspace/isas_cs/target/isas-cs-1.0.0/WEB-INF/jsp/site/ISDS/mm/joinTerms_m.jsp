<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<script type="text/javascript">
	function init(){
		$("#tearmsOk").bind("click",function(){
			if($("#chk1").is(":checked") && $("#chk2").is(":checked")){
				makeForm("join.do", {"termsChk":"ok"});
			}else{
				alert("이용약관에 동의하셔야 가입이 가능합니다.");
			}
		});
	}
</script>
</head>
<body>

	<section class="sub">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>회원가입</h2>
		</div>
		<!--// tit_bx -->
		<div class="agree_bx">
			<div class="top">
				<h3>이용약관</h3>
				<span class="chkbox">
					<label class="label_txt">
						<input type="checkbox" value="ok" name="chk1" id="chk1">
						<span class="txt">동의</span>
					</label>
				</span>
			</div>
			<div class="info_bx mt05">
				<em>제 1조(목적)</em>
				<!-- 20200427 ryul 아이에스동서 > 이누스주식회사 -->
<!-- 				<p class="mt05">이 약관은 아이에스동서가 운영하는 A/S 웹사이트(이하 “사이트”이라<br>한다.)에서 제공하는 인터넷 관련서비스 (이하 “서비스”라 한다.)를<br> 이용함에 있어 서비스 이용자의 권리ㆍ의무 및 책임사항을 규정함으로<br>목적으로 합니다.</p> -->
				<p class="mt05">이 약관은 이누스주식회사가 운영하는 A/S 웹사이트(이하 “사이트”이라<br>한다.)에서 제공하는 인터넷 관련서비스 (이하 “서비스”라 한다.)를<br> 이용함에 있어 서비스 이용자의 권리ㆍ의무 및 책임사항을 규정함으로<br>목적으로 합니다.</p>
				<em class="mt20">제 2조(정의)</em>
				<ol class="non mt05 abc">
					<li>
						<!-- 20200427 ryul 아이에스동서 > 이누스주식회사 -->
<!-- 						<p>“사이트”이란 아이에스동서가 일정 서비스를 이용자에게 제공하기<br>위하여 컴퓨터 등 정보통신설비를 이용하여 서비스를 이용할 수<br>있도록 설정한 가상의 영업장을 말하며, 아울러 사이트를 운영하는<br>사업자의 의미로도 사용합니다.</p> -->
						<p>“사이트”이란 이누스주식회사가 일정 서비스를 이용자에게 제공하기<br>위하여 컴퓨터 등 정보통신설비를 이용하여 서비스를 이용할 수<br>있도록 설정한 가상의 영업장을 말하며, 아울러 사이트를 운영하는<br>사업자의 의미로도 사용합니다.</p>
					</li>
					<li>
						<p>“이용자”란 “사이트”에 접속하여 이 약관에 따라 “사이트”가<br>제공하는 서비스를 이용자를 말합니다.</p>
					</li>
				</ol>
			</div>
			<!--// info_bx -->
		</div>
		<!--// agree_bx -->
		<div class="agree_bx">
			<div class="top">
				<h3>개인정보 수집 및 이용 동의</h3>
				<span class="chkbox">
					<label class="label_txt">
						<input type="checkbox" value="ok" name="chk2" id="chk2">
						<span class="txt">동의</span>
					</label>
				</span>
			</div>
			<div class="info_bx mt05">
				<em>제 1조(목적)</em>
				<!-- 20200427 ryul 아이에스동서 > 이누스주식회사 -->
<!-- 				<p class="mt05">이 약관은 아이에스동서가 운영하는 A/S 웹사이트(이하 “사이트”이라<br>한다.)에서 제공하는 인터넷 관련서비스 (이하 “서비스”라 한다.)를<br> 이용함에 있어 서비스 이용자의 권리ㆍ의무 및 책임사항을 규정함으로<br>목적으로 합니다.</p> -->
				<p class="mt05">이 약관은 이누스주식회사가 운영하는 A/S 웹사이트(이하 “사이트”이라<br>한다.)에서 제공하는 인터넷 관련서비스 (이하 “서비스”라 한다.)를<br> 이용함에 있어 서비스 이용자의 권리ㆍ의무 및 책임사항을 규정함으로<br>목적으로 합니다.</p>
				<em class="mt20">제 2조(정의)</em>
				<ol class="non mt05 abc">
					<li>
						<!-- 20200427 ryul 아이에스동서 > 이누스주식회사 -->
<!-- 						<p>“사이트”이란 아이에스동서가 일정 서비스를 이용자에게 제공하기<br>위하여 컴퓨터 등 정보통신설비를 이용하여 서비스를 이용할 수<br>있도록 설정한 가상의 영업장을 말하며, 아울러 사이트를 운영하는<br>사업자의 의미로도 사용합니다.</p> -->
						<p>“사이트”이란 이누스주식회사가 일정 서비스를 이용자에게 제공하기<br>위하여 컴퓨터 등 정보통신설비를 이용하여 서비스를 이용할 수<br>있도록 설정한 가상의 영업장을 말하며, 아울러 사이트를 운영하는<br>사업자의 의미로도 사용합니다.</p>
					</li>
					<li>
						<p>“이용자”란 “사이트”에 접속하여 이 약관에 따라 “사이트”가<br>제공하는 서비스를 이용자를 말합니다.</p>
					</li>
				</ol>
			</div>
			<!--// info_bx -->
		</div>
		<!--// agree_bx -->
		<span class="chkbox pl15">
			<label class="label_txt">
				<input type="checkbox" id="agree_all" class="allChk">
				<span class="txt">전체동의</span>
			</label>
		</span>
		<div class="btnBox pd15">
			<a href="#" class="btn blue" id="tearmsOk">동의</a>
		</div>
	</section>
	<!--// sub -->

</body>