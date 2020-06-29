<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<style type="text/css">
		body{overflow:hidden;}
	</style>
	<script src="https://player.vimeo.com/api/player.js"></script>
<body>
<c:if test="${!iConstant.isMobile(pageContext.request)}">
	<iframe src="https://player.vimeo.com/video/${paramMap.MOVIE_SEQ}?autoplay=1" width="640" height="480" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
</c:if>
<c:if test="${iConstant.isMobile(pageContext.request)}">
	<iframe src="https://player.vimeo.com/video/${paramMap.MOVIE_SEQ}?autoplay=1" width="320" height="240" frameborder="0" webkitallowfullscreen mozallowfullscreen allowfullscreen></iframe>
</c:if>
<script>
    var iframe = document.querySelector('iframe');
    var player = new Vimeo.Player(iframe);

    player.on('play', function() {
        console.log('played the video!');
    });
    player.on('ended', function() {
        console.log('ended the video!');
        parent.fnEventRet('32');
    });
    player.getVideoTitle().then(function(title) {
        console.log('title:', title);
    });
</script>
</body>
</html>