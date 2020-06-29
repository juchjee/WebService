<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!DOCTYPE html>
<html lang="ko">
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title>NICE평가정보 가상주민번호 서비스</title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
</head>
<body>
    <table id='waiting' style='position:absolute;margin:0;width:100%;height:100%;'>
    	<tr><td align='center' style='font-size:10pt; background:#FFFFFF;'><img src='${rootUri}common/img/icon/ajaxLoader.gif'/><br><br></td></tr>
    </table>
    <c:set var="param_r1" value="${sessionScope.niceCheckMap.param_r1}" />
	<script type="text/javascript">
	<!--
		function init(){
			<c:if test='${not empty sMessage}'>alert($("#messageText").text());</c:if>
			<c:if test='${not empty action}'>${action}</c:if>
			if(opener){
				<c:if test='${not empty location}'>
					var dataStr = "document.location.href = '${rootUri}${location}'";
					iframe_send_msg(dataStr);
				</c:if>
				var dataStr = "makeForm("
				<c:choose>
					<c:when test="${param_r1 eq 'id' or param_r1 eq 'pwd'}">dataStr += "'searchEnd.do'";</c:when>
					<c:when test="${param_r1 eq 'join'}">dataStr += "'join.do'";</c:when>
				</c:choose>
				dataStr += ", {'mbrDi':'${mbrDi}'});";
				iframe_send_msg(dataStr);
			}else{
				alert('<spring:message code="fail.user.connectFail" />');
			}
			self.close();
		}
	//-->
	</script>
</body>
<textarea id="messageText" rows="1" cols="50" style="width:100px; height:10px; display:none;">${sMessage}</textarea>
</html>