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
/*----------------------------------------------------------------------------------------------
 * 화면 load시 실행 함수 (onload)
 *----------------------------------------------------------------------------------------------*/
function init(){
	fnDataSetting();
	fnEvent();
}

/*----------------------------------------------------------------------------------------------
 * 페이지 이벤트 함수 모음
 *----------------------------------------------------------------------------------------------*/
function fnEvent(){
		$('.btn_close').bind( 'click', function() {
			var popupCloseDay = parseInt("${popupInfo.popupCloseDay}");
		<c:choose>
			<c:when test="${popupInfo.popupOpenTpWlm eq 'L'}">
// 				setEncryptionCookie( 'hidePopL', 'true', 60 * 60 * (24*popupCloseDay));
				parent.$.fancybox.close();
			</c:when>
			<c:when test="${popupInfo.popupOpenTpWlm eq 'W'}">
// 				setEncryptionCookie( "${param.popupSeq}", 'true', 60 * 60 * (24*popupCloseDay));
				setTimeout(function(){window.close()},200);
			</c:when>
			<c:when test="${popupInfo.popupOpenTpWlm eq 'M'}">
// 				setEncryptionCookie( "${param.popupSeq}", 'true', 60 * 60 * (24*popupCloseDay));
				parent.$('#popM${param.popupSeq}').jqxWindow('close');
			</c:when>
		</c:choose>
		});

		var popupWinWidth = parseInt("${popupInfo.popupWinWidth}");
		var popupWinHeight = parseInt("${popupInfo.popupWinHeight}");
		<c:choose>

		<c:when test="${popupInfo.popupOpenTpWlm eq 'M'}">
    			var widthLocal = 70;
    			var heightLocal = 15;
		</c:when>
		<c:otherwise>
			var widthLocal = 40;
			var heightLocal = 10;
		</c:otherwise>
	</c:choose>
	$(".btn_close").css("top",popupWinHeight-widthLocal);
	$(".btn_close").css("right",heightLocal);
}

function fnDataSetting(){
    $(".contView").html(decodeTag($("#cont").html()));

}
</script>
</head>
<body class="noBg">
	<div class="popup_wrap" style="border:0px;padding:0 0 0 0; margin:0 0 0 0;">
		<c:choose>
			<c:when test="${popupInfo.popupRegTpFe eq 'F'}">
			<div class="contView" >
				<c:import url="${homeUrl}${popupInfo.attchFilePath}" charEncoding="UTF-8" />
			</div>
			</c:when>
			<c:when test="${popupInfo.popupRegTpFe eq 'E'}">
				<textarea  id="cont" style="display:none">${popupInfo.popupCont}</textarea>
			     <div class="contView">${popupInfo.popupCont}</div>
			</c:when>
		</c:choose>
		<div class="btn_close" style="position: absolute;  font-size:${popupInfo.popupCloseSize}px;color:#${popupInfo.popupCloseColor};">
			<div  class="closeTxt" style="cursor: pointer; padding:4px 7px 4px 7px;border:1px solid #${popupInfo.popupCloseColor}; border-radius:3px;letter-spacing: -1px;}">${popupInfo.popupCloseDay}일간 열지 않음</div>
		</div>
	</div>
	<!-- // popup_wrap -->
</body>
</html>