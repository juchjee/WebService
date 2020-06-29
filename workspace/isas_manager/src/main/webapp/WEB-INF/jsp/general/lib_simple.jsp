<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<meta name="decorator" content="null" />
	<link href="${rootUri}css/font.css" rel="stylesheet" type="text/css"/>
	<link href="${rootUri}css/default.css" rel="stylesheet" type="text/css"/>
	<link href="${rootUri}css/common.css" rel="stylesheet" type="text/css"/>
	<link href="${rootUri}css/site.css" rel="stylesheet" type="text/css"/>
	<link href="${rootUri}css/pqselect.dev.css" rel="stylesheet" type="text/css"/>
	<link rel="stylesheet" href="http://ajax.googleapis.com/ajax/libs/jqueryui/1.11.2/themes/redmond/jquery-ui.css" />

	<script type="text/javascript" src="${rootUri}js/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" src="${rootUri}js/jquery-ui.js"></script>
	<script type="text/javascript" src="${rootUri}js/pqselect.dev.js"></script>
	<script type="text/javascript" src="${rootUri}js/dateFormat.js"></script>
    <script type="text/javascript" src="${rootUri}js/jquery.mCustomScrollbar.concat.min.js"></script>
    <script type="text/javascript" src="${rootUri}js/common.js"></script>
	
	<c:import url="/WEB-INF/jsp/general/lib_fancybox.jsp" />

	<%-- user functions --%>
	<script type="text/javascript" src="${rootUri}js/message.js"></script>
	<script type="text/javascript" src="${rootUri}js/functions.js?ver=20161017"></script>
	<script type="text/javascript" src="${rootUri}js/site.js"></script>
	<c:import url="/WEB-INF/jsp/general/site_javasript.jsp" />
	<%-- /user functions --%>
	
	<%-- daum 우편번호 검색 --%>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>