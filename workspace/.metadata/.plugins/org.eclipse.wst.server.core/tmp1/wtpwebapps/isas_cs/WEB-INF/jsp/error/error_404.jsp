<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:if test="${empty rootUri}"><c:set var="rootUri" value="${iConstant.get('ROOT_URI')}" scope="request"/></c:if>
<!DOCTYPE html>
<html lang="ko">
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp"/>
	<script type="text/javaScript" defer="defer">
		<!--
		var _windows = this && this.parent && this.parent.parent && this.parent.parent.parent && this.parent.parent.parent.parent && this.parent.parent.parent.parent.parent;
		function replaceUrl(url){
			if(window.dialogArguments){
				var reJsonObj = {};
				reJsonObj.error = url;
				window.returnValue = JSON.stringify(reJsonObj);
				window.close();
			}else{
				var _opener = opener;
				if(_opener){
					_windows = _opener && _opener.parent && _opener.parent.parent && _opener.parent.parent.parent && _opener.parent.parent.parent.parent && _opener.parent.parent.parent.parent.parent;
				}
				_windows.location = url;
				if(_opener){
					window.close();
				}
			}
		}
		//-->
	</script>
</head>
<body class="checkBg">
	<div class="errorBoxWrap">
		<div><img src=/common/img/header/logo.gif alt="ISDS" /></div>
		<div class="errorBox">
			<div>
				<div class="errorImg">404</div>
				<div class="errorTxt">
					죄송합니다.<br />
				   	요청하신 페이지를 찾을 수 없습니다.<br />
					페이지의 주소가 잘못 입력되었거나 변경 또는 삭제된 페이지입니다.<br />
					입력하신 주소를 확인하여 주시거나 홈페이지로 이동하여 주십시오.
				<c:if test='${not empty messageBox.message}'>
					<c:out value='${messageBox.message}' />
				</c:if>
	        	<c:if test='${not empty messageBox.exception}'>
					<br /><c:out value='${messageBox.exception}' />
				</c:if>
				</div>
				<div class="errorBtn">
					<a href="${rootUri}" >홈으로</a>
				</div>
			</div>
		</div>
	</div>
</body>
</html>