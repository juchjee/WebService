<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<head>
	<page:applyDecorator name="header" />
	<decorator:head />
</head>
<body>
	<!-- top -->
	<page:applyDecorator name="top" />
	<!-- /top -->

	<!-- contents -->
	<div class="contents">
		<!-- lnb -->
		<page:applyDecorator name="left" />
		<!-- /lnb -->

		<!-- contentWrap -->
		<div class="contentWrap">
			<div class="content_box">
				<page:applyDecorator name="title_path" />
				<decorator:body />
			</div>
			<!-- // content_box -->
		</div>
		<!-- // contentWrap -->
	</div>
    <!-- // contents -->
	<!-- footer -->
	<page:applyDecorator name="footer" />
	<!-- /footer -->
</body>
</html>
