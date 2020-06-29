<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@page import="egovframework.cmmn.IConstants"%>
<%
String url = "";
if (request.getQueryString() == null) {
	url = "";
}else{
	url =  "?" + request.getQueryString();
}
response.sendRedirect(IConstants.MAIN_PAGE + url);
%>
<!DOCTYPE html>
<html>
<head>
</head>
<body>

</body>
</html>