<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
</head>
<body>
	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">아이디/비밀번호 찾기</h2>
			<div class="txt_bx log mt50">
				<p>아이디/비밀번호가 기억나지 않으세요?<br>휴대폰/아이핀 인증으로 찾을 수 있습니다.</p>
			</div>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">아이디/비밀번호 찾기</a></li>
					<li class="last"><a href="#">로그인</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->

		<div id="box_tabs" class="mb200">
			<div class="wrap_tabs find">
				<ul class="tabs">
					<li class="active" rel="tab1"><div class="on">아이디찾기</div></li>
					<li rel="tab2" class="" onclick="location.href='/ISDS/mm/searchPassword.do'"><div class="on">비밀번호찾기</div></li>
				</ul>
			</div>
			<div class="tab_container">
				<div id="tab1" class="tab_content">
					<ul class="confirm_bx">
						<li>
							<dl>
								<dt><span>휴대폰 인증</span><a href="javascript:;" id="idConhp" class="btn btn01Type">휴대폰 본인인증</a></dt>
								<dd>본인 명의의 휴대폰 번호 인증 후 아이디를 찾을 수 있습니다.</dd>
							</dl>
						</li>
					</ul>
				</div>
			</div>
			<!--// tab_container -->
		</div>
		<!--// box_tabs -->
	</div>
	<script type="text/javascript" defer="defer">
		(function(){
			$("#idConhp").click(function(){
				privteCheck("hp");
			});
		})();
		
		function privteCheck(data){
			var _val = data;
			if(_val == "hp"){
				/*★ 로컬에서 테스트 START , checkPlusSuccess.jsp*/ 
				//location.href = '/ISDS/mm/searchEnd.do?param_r1=id';
				/*★ 로컬에서 테스트 END*/
				//★ 운영올릴때 주석제거할곳 
				window.open('checkPlusMain.action?param_r1=id', 'popup', 'width=500, height=461, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}
		}
	</script>
</body>