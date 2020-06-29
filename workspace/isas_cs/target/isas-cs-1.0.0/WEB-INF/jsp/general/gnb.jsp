<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
	<c:set var="depth1" value="100" scope="session"/>
	<c:set var="depth2" value="0" scope="session"/>

	<!-- header -->
	<header class="header">
		<div class="header_in">
			<h1><a href="/"><img src="/common/img/ico_logo.png" alt="inus서비스센터"></a></h1>
			<nav class="gnb">
				<h2 class="blind">gnb메뉴</h2>
				<ul class="mn_bx">
					<c:forEach items="${frontCategoryList}" var="datas" varStatus="loop">
						<c:if test='${datas.clevel == "1"}'>
							<c:choose>
								<c:when test="${datas.frontSvTp ne 'ALL'}">
									<c:choose>
										<c:when test="${datas2.frontSvTp eq 'UNSIGN' and !isLogIn}">
											<c:set var="signStatus" value="Y"/>
										</c:when>
										<c:when test="${datas2.frontSvTp eq 'SIGN' and isLogIn}">
											<c:set var="signStatus" value="Y"/>
										</c:when>
										<c:otherwise>
											<c:set var="signStatus" value="N"/>
										</c:otherwise>
									</c:choose>
								</c:when>
								<c:otherwise>
									<c:set var="signStatus" value="Y"/>
								</c:otherwise>
							</c:choose>

							<c:if test="${signStatus eq 'Y' }">
								<li class="menu_0${loop.index+1}">
									<a href="${datas.frontUrl}">${datas.frontMenuNm}</a>
									<ul class="submn">
										<c:forEach items="${frontCategoryList}" var="datas2" varStatus="loop">
											<c:if test="${datas.frontMenuCd eq datas2.frontMenuGroup and datas2.clevel == '2'}">
												<c:choose>
													<c:when test="${datas2.frontSvTp ne 'ALL'}">
														<c:choose>
															<c:when test="${datas2.frontSvTp eq 'UNSIGN' and !isLogIn}">
																<c:set var="signStatus2" value="Y"/>
															</c:when>
															<c:when test="${datas2.frontSvTp eq 'SIGN' and isLogIn}">
																<c:set var="signStatus2" value="Y"/>
															</c:when>
															<c:otherwise>
																<c:set var="signStatus2" value="N"/>
															</c:otherwise>
														</c:choose>
													</c:when>
													<c:otherwise>
														<c:set var="signStatus2" value="Y"/>
													</c:otherwise>
												</c:choose>

												<c:if test="${signStatus2 eq 'Y' }">
													<li>
														<a href="${datas2.frontUrl}">${datas2.frontMenuNm}</a>
													</li>
												</c:if>
											</c:if>
										</c:forEach>
									</ul>
								</li>
							</c:if>
						</c:if>
					</c:forEach>
				</ul>
			</nav>

			<c:if test="${isLogIn}">
			<ul class="usr_info_bx">
				<li><a href="http://www.inusmall.com" class="mall" target="_brank">이누스몰</a></li>
				<li><a href="/ISDS/mm/actionLogSystem.out.action" class="login">로그아웃</a></li>
				<li><a href="/ISDS/user/setting.do" class="join">회원정보수정</a></li>
			</ul>
			</c:if>
			<c:if test="${!isLogIn}">
				<c:if test="${not empty nonLogin}">
					<ul class="usr_info_bx">
						<li><a href="http://www.inusmall.com" class="mall" target="_brank">이누스몰</a></li>
						<li><a href="/ISDS/mm/actionLogSystem.out.action" class="login">비회원 로그아웃</a></li>
						<li><a href="/ISDS/mm/join.do" class="join">회원가입</a></li>
						</ul>
				</c:if>
				<c:if test="${empty nonLogin}">
					<ul class="usr_info_bx">
						<li><a href="http://www.inusmall.com" class="mall" target="_brank">이누스몰</a></li>
						<li><a href="/ISDS/mm/acessLogin.do" class="login">로그인</a></li>
						<li><a href="/ISDS/mm/join.do" class="join">회원가입</a></li>
					</ul>
				</c:if>


			</c:if>
		</div>
	</header>
	<div class="gnbBg"></div>
	<!--// header -->
