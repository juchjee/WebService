<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript">
</script>

	<div class="wrap_sitemap">
	<aside class="siteMap_bx">
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
					<c:otherwise><c:set var="signStatus" value="Y"/></c:otherwise>
				</c:choose>
				<c:if test="${signStatus eq 'Y' }">
					<dl>
						<dt>${datas.frontMenuNm}</dt>
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
									<dd><a href="${datas2.frontUrl}">${datas2.frontMenuNm}</a></dd>
								</c:if>
							</c:if>
						</c:forEach>
					</dl>
				</c:if>
			</c:if>
		</c:forEach>
		</aside>
		</div>
		<!--// siteMap_bx -->
