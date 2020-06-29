<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:if test="${empty rootUri}"><c:set var="rootUri" value="${iConstant.get('ROOT_URI')}" scope="request" /></c:if>
<head>
	<c:import url="/WEB-INF/jsp/general/head_simple.jsp" />
	<script type="text/javascript" defer="defer">
		<!--
		<c:if test='${not empty messageBox.message}' >
			alert("<c:out value='${messageBox.message}'/>");
		</c:if>
		<c:if test='${not empty location}'>
			if(window.close){
				var reJsonObj = {};
				reJsonObj.error = "${rootUri}${location}";
				window.returnValue = JSON.stringify(reJsonObj);
			}else{
				var _opener = opener;
				var _windows = null;
				if(_opener){
					_windows = _opener && _opener.parent && _opener.parent.parent && _opener.parent.parent.parent && _opener.parent.parent.parent.parent && _opener.parent.parent.parent.parent.parent;
				}else{
					_windows = this && this.parent && this.parent.parent && this.parent.parent.parent && this.parent.parent.parent.parent && this.parent.parent.parent.parent.parent;
				}
				_windows.location = "${rootUri}${location}";
			}
		</c:if>
	    if(window.close){
	    	window.close();
	    }else if(self.close){
	    	self.close();
	    }
	  //-->
	</script>
</head>
<body>
</body>
</html>
