<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

	<footer class="foot">
		<ul>
			<li class="call"><span>고객센터 대표전화 : 1588-8613</span></li>
			<li class="fax"><span>Fax : 02-3445-1687</span></li>
		</ul>
		<p class="copy">COPYRIGHT ⓒ 2017 IS DONGSEO. ALL RIGHTS RESERVED.</p>
	</footer>
	<!-- <a href="callto:01234567890" class="callBt">상담전화연결</a> -->

	<c:if test="${iConstant.isMobile(pageContext.request)}">
		<c:if test="${!isLogIn}">
			<script type="text/javascript">
				loadSessionId();
			</script>
		</c:if>
	</c:if>