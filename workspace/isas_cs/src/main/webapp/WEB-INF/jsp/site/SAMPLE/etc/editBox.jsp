<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<style type="text/css">
		body{overflow:hidden;}
	</style>
<script type="text/javaScript" defer="defer">

	function decodeTag(str){
		return str && str.replace(/&quot;/g,"\"").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&nbsp;/g," ").replace(/&amp;/g,"&");
	}

</script>
</head>
<body class="noBg" >
	<div class="popup_wrap">
		<div id="boardCont"></div>
		<textarea name="boardCont_text" id="boardCont_text" style="display:none;" ><c:if test="${not empty viewMap.boardCont}">${viewMap.boardCont}</c:if></textarea>
		<script type="text/javascript">
			$("#boardCont").html(decodeTag($("#boardCont_text").html()));
		</script>
	</div>
</body>
</html>