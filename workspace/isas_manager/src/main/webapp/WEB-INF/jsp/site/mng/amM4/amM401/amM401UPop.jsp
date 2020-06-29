<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />


<style>
</style>
</head>

<body class="noBg">
	<div class="popup_wrap" style="background:#fff">
		<h2>401수정팝업</h2>
	 <div class="pageContScroll_st2">
	 	<form id="workForm" name="workForm" action="amM202Save.action" method="post" enctype="multipart/form-data">

		</form>
	  </div>
		  <!-- // table_type2 -->
		  <div class="btn_area">
		    <div class="center">
		      <a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">수정</a><a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
		    </div>
		  </div>
	</div>
</body>
