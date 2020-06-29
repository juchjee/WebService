<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
response.setHeader("Pragma","no-cache"); 
response.setHeader ("Cache-Control", "no-cache");
response.setDateHeader("Expires", 0);
%> 

<title>ERP</title> 
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Cache-Control" content="no-cache; no-store; no-save" /> 
<meta http-equiv="Expires" content="-1" />
<meta http-equiv="X-UA-Compatible" content="IE=EDGE" />

<script type="text/javascript">
	var PARAM_INFO = JSON.parse('<c:out value="${PARAM_INFO}" escapeXml="false"></c:out>');
</script> 

<!--Jquery google CDN 추가  -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.min.js"></script>

<script type="text/javascript" src="/common/js/sockjs-0.3.js"></script>
<script type="text/javascript" src="/common/js/jquery-extend.js"></script>

<!--jQuery Mask 추가  -->
<script type="text/javascript" src="/component/jquery-mask-plugin/jquery.mask.js"></script>
<script type="text/javascript" src="/component/jquery-mask-plugin/jquery.mask_extends.js"></script>

<script type="text/javascript" src="/common/js/common.js"></script>
<script type="text/javascript" src="/common/js/jquery.form.js"></script>
<script type="text/javascript" src="/common/js/msg_manager.js"></script>

<link rel="stylesheet" type="text/css" href="/common/css/common.css" />
<link rel="stylesheet" type="text/css" href="/component/dhtmlxSuite/codebase/dhtmlx.css" />
<link rel="stylesheet" type="text/css" href="/common/css/dhtmlx_layout.css" />

<!-- Dhtmlx Componet 추가  -->
<script type="text/javascript" src="/component/component-extends/dhtmlx/commonDhtmlx.js"></script>
<script type="text/javascript" src="/component/dhtmlxSuite/codebase/dhtmlx.js"></script>
<script type="text/javascript" src="/component/dhtmlxSuite/codebase/dhtmlx_deprecated.js"></script>

<!-- Dhtmlx extends 추가  -->
<script type="text/javascript" src="/component/component-extends/dhtmlx/dhtmlx_extend.js"></script>
<script type="text/javascript" src="/component/component-extends/dhtmlx/dhtmlx_combo_extend.js"></script>
<script type="text/javascript" src="/component/component-extends/dhtmlx/dxgrid_extend.js"></script>
<script type="text/javascript" src="/component/component-extends/dhtmlx/dxtree_extend.js"></script>
<script type="text/javascript" src="/component/component-extends/dhtmlx/dxformat_extend.js"></script>
<script type="text/javascript" src="/component/component-extends/dhtmlx/dhtmlx_module.js"></script>
<script type="text/javascript" src="/component/component-extends/dhtmlx/source.js"></script>