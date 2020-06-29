<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>

<head>
	<page:applyDecorator name="header" />
	<decorator:head />
</head>
<body>


<!--=============== #HEADER ===============-->
	<page:applyDecorator name="gnb" />
<%-- 	<page:applyDecorator name="top" /> --%>
<!--=============== #/HEADER ===============-->


<!--=============== #CONTAINER ===============-->
		<decorator:body />
<!--=============== #/CONTAINER ===============-->

</body>

</html>
