<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<c:set var="depth1" value="100" scope="session"/>
	<c:set var="depth2" value="0" scope="session"/>

	<!-- header -->
	<header>
		<div class="head_txt">
			<h1><a href="/"><img src="/common/img/logo.png" alt="inus"/>서비스센터<span>대리점/기사용</span></a></h1>
		</div><!--// head_txt -->
		<button type="button" id="mobileMenu">메뉴 바로가기</button>
		<a href="/" class="hd_btn_home">홈으로 이동</a>
		<nav class="mobile-menu mobile-menu-vertical mobile-menu-left" id="mobile-menu">
			<div class="m_head">

				<c:choose>
					<c:when test="${isLogIn}">
						<a href="/ISDS/mm/actionLogSystem.out.action" class="btn_login" style="width:60px;">로그아웃</a>
					</c:when>
					<c:otherwise>
						<a href="/ISDS/mm/acessLogin.do" class="btn_login" style="width:50px;">로그인</a>
					</c:otherwise>
				</c:choose>
				<a href="/" class="btn_home">홈으로 이동</a>
			</div><!--// m_head -->
			<ul>
				<li class="twoDp type01">
					<a href="javascript:;" onclick="location.href='/ISDS/repair/inusRepairState.do'">A/S 접수현황</a>
					<!--  // 서브 메뉴 있을 시 아래 사용
					<ul>
						<li><a href="#">서브 메뉴명</a></li>
					</ul> -->
				</li>
				<li class="twoDp type02"><a href="javascript:;" onclick="location.href='/ISDS/repair/inusRepairStateFinish.do'">A/S 완료현황</a></li>
				<li class="twoDp type03"><a href="javascript:;" onclick="location.href='/ISDS/repair/inusHandling.do'">A/S 수리내역 조회</a></li>
				<li class="twoDp type04"><a href="javascript:;" onclick="location.href='/ISDS/repair/inusInstallAccept.do'">온라인 설치접수내역</a></li>
				<li class="twoDp type05"><a href="javascript:;" onclick="location.href='/ISDS/bbt/bbt00001.do?boardMstCd=BBM00067'">공지사항</a></li>
			</ul>
			<button id="close">모바일 메뉴 닫기</button>
		</nav><!--// mobile-menu -->
	</header>
	<!--// header -->
