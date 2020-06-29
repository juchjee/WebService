<%@page language="java" contentType="text/json; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:if test="${not empty outData}"><c:out value='${outData}' escapeXml='false'/></c:if>

