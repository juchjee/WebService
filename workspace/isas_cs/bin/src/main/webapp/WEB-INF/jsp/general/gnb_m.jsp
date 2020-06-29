<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<c:set var="depth1" value="100" scope="session"/>
<c:set var="depth2" value="0" scope="session"/>

	<header>
		<div class="head_txt">
			<h1><a href="/ISDS/main/home.do"><img src="${rootUri}common/img_m/cmn/inus_logo.png" alt="inus"/><span>서비스센터</span></a></h1>
		</div><!--// head_txt -->
		<button type="button" id="mobileMenu">메뉴 바로가기</button>
		<a href="/ISDS/main/home.do" class="hd_btn_home">홈으로 이동</a>
		<nav class="mobile-menu mobile-menu-vertical mobile-menu-left" id="mobile-menu">
			<div class="m_head">
				<div class="your_info">
					<c:choose>
						<c:when test="${isLogIn}">
							<em class="usrName">${mbrNm}님</em>
							<a href="javascript:;" onclick="fnLogout();" class="btn_logout">로그아웃</a>
						</c:when>
						<c:when test="${!isLogIn}">
							<c:if test="${not empty nonLogin}">
							<a href="/ISDS/mm/actionLogSystem.out.action" class="btn_log">비회원 로그아웃</a>
							</c:if>
							<c:if test="${empty nonLogin}">
								<a href="/ISDS/mm/acessLogin.do" class="btn_log">로그인</a>
							</c:if>
						</c:when>
						<c:otherwise></c:otherwise>
					</c:choose>
				</div>
				<a href="/ISDS/main/home.do" class="btn_home">홈으로 이동</a>
			</div><!--// m_head -->
			<ul>
				<li class="twoDp type01">
					<a href="#none">빠른 해결</a>
					<ul>
						<li><a href="/ISDS/bbt/bbt00004.do?pageCd=BBM00004">자주하는 질문</a></li>
						<li><a href="/ISDS/bbt/bbt00004.do?pageCd=BBM00007">간단 조치 방법</a></li>
						<li><a href="/ISDS/bbt/bbt00008.do?pageCd=BBM00075">동영상 가이드</a></li>
						<li><a href="/ISDS/bbt/bbt00009.do?pageCd=BBM00050">제품매뉴얼</a></li>
					</ul>
				</li>
				<li class="twoDp type02">
					<a href="#none">서비스 예약</a>
					<ul>
						<li><a href="/ISDS/cs/telCsI.do">전화상담 예약</a></li>
						<li><a href="/ISDS/cs/tserviceI.do">출장서비스 예약</a></li>
						<li><a href="/ISDS/view/view.do?pageCd=resGuid">서비스 요금 안내</a></li>
						<li><a href="/ISDS/cs/cssearch.do">예약 조회</a></li>
					</ul>
				</li>
				<li class="twoDp type03">
					<a href="#none">부품구매</a>
					<ul>
						<li><a href="/ISDS/bbt/bbt00007.do?pageCd=BBM00056">비데</a></li>
						<li><a href="/ISDS/bbt/bbt00007.do?pageCd=BBM00068">위생도기</a></li>
						<li><a href="/ISDS/bbt/bbt00007.do?pageCd=BBM00069">수전</a></li>
						<li><a href="/ISDS/bbt/bbt00007.do?pageCd=BBM00071">이누스바스</a></li>
					</ul>
				</li>
				<li class="twoDp type04">
					<a href="#none">매장찾기</a>
					<ul>
						<li><a href="/ISDS/locStore/locStoreL.do?pageCd=BBM00057">전시장 찾기</a></li>
						<li><a href="/ISDS/locStore/locStoreL.do?pageCd=BBM00058">A/S센터 찾기</a></li>
						<li><a href="/ISDS/locStore/locStoreL.do?pageCd=BBM00059">대리점</a></li>
					</ul>
				</li>
				<li class="twoDp type05">
					<a href="#none">고객의 소리</a>
					<ul>
						<li><a href="/ISDS/bbt/bbt00001.do?pageCd=BBM00001">공지사항</a></li>
						<li><a href="/ISDS/bbt/bbt00002.do?pageCd=BBM00003">1:1 문의</a></li>
						<li><a href="/ISDS/bbt/bbt00010.do?pageCd=BBM00006">칭찬합시다</a></li>
					</ul>
				</li>
				<li class="twoDp type06">
					<a href="#none">마이페이지</a>
					<ul>
						<li><a href="/ISDS/user/setting.do">회원정보 수정</a></li>
					</ul>
				</li>
			</ul>
			<button id="close">모바일 메뉴 닫기</button>
		</nav><!--// mobile-menu -->
	</header>