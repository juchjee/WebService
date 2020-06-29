<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />

<script type="text/javaScript" defer="defer">
/*----------------------------------------------------------------------------------------------
 * 화면 load시 실행 함수 (onload)
 *----------------------------------------------------------------------------------------------*/
function init(){
	fnEvent();
	fnDataSetting();
}

/*----------------------------------------------------------------------------------------------
 * 페이지 이벤트 함수 모음
 *----------------------------------------------------------------------------------------------*/
function fnEvent(){

}

function fnDataSetting(){


}
</script>
</head>

<body class="noBg">
	<div class="popup_wrap">
		<c:choose>
			<c:when test="${popupInfo.popupRegTpFe eq 'F'}">
			<c:import url="popHtm.jsp?attchCd=${popupInfo.attchCd}"></c:import>
			</c:when>
			<c:when test="${popupInfo.popupRegTpFe eq 'E'}">
				${popupInfo.popupCont}
			</c:when>
		</c:choose>
	</div>
	<!-- // popup_wrap -->
</body>
</html>