<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<c:if test="${empty rootUri}"><c:set var="rootUri" value="${iConstant.get('ROOT_URI')}" scope="request" /></c:if>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
	<!--
		var $_fancyboxIsAutoClose = true;
		var _${divName}Arr = [];
		function init(){
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: _${divName}Arr,
				elPlaceHolder: "${divName}",
				sSkinURI: "/SE/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				},
				fOnAppLoad : function(){
					_${divName}Arr.getById["${divName}"].exec("PASTE_HTML", [parent.$("#${divName}_Text").text()]);//부모 윈도우의  내용을 가지고 온다.
					$("#btn_div").show();
				},
				fCreator: "createSEditor2"
			});
		}

		function fnSave(){
			$_fancyboxIsAutoClose = false;
			_${divName}Arr.getById["${divName}"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
			var sHTML = _${divName}Arr.getById["${divName}"].getIR();
			sHTML = sHTML.replace(/<(no)?script[^>]*>/ig, '').replace(/<\/(no)?script>/ig, '');// 자바 태그 제거
			sHTML = sHTML.replace(/(<p><br><\/p>)$/, '');
			parent.$("#${divName}_Text").html(sHTML);
			parent.$("#${divName}").html(sHTML);
			parent.$("a.fancybox-item.fancybox-close").click();
		}

		function fnCancel(){
			_${divName}Arr.getById["${divName}"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
			parent.$("a.fancybox-item.fancybox-close").click();
		}

		function fnFancyboxClose(){
			_${divName}Arr.getById["${divName}"].exec("UPDATE_CONTENTS_FIELD", []);	// 에디터의 내용이 textarea에 적용됩니다.
		}
		//-->
	</script>
</head>
<body class="noBg">
	<textarea name="${divName}" id="${divName}" rows="10" cols="100" style="width:100%; height:450px; display:none;"></textarea>
	<div id="btn_div" class="btn_area">
		<div class="right">
			<a href="javascript:;" onClick="fnSave()" class="btn_blue_line">확인</a>
			<a href="javascript:;" onClick="fnCancel()" class="btn_blue_line">취소</a>
		</div>
	</div>
</body>
</html>