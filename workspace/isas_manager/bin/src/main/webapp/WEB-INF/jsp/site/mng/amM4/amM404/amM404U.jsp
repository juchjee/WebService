<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />

	<!-- 마케팅관리 : 이메일관리 -->

<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
<script type="text/javaScript" defer="defer">

<!--
/*----------------------------------------------------------------------------------------------
 * 화면 load시 실행 함수 (onload)
 *----------------------------------------------------------------------------------------------*/
 var oEditors = [];

 function init(){
 	fnEvent();
 	fnDataSetting();
 }


/*----------------------------------------------------------------------------------------------
 * 페이지 이벤트 함수 모음
 *----------------------------------------------------------------------------------------------*/
function fnEvent(){

	$.submit = function(){
		oEditors.getById["mailCont"].exec("UPDATE_CONTENTS_FIELD", []);
		oEditors.getById["mailFooterCont"].exec("UPDATE_CONTENTS_FIELD", []);
		fnSubmit("workForm","저장");
	}
}

function fnDataSetting(){
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "mailCont",
		sSkinURI: "/SE/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		},
		fCreator: "createSEditor2"
	});

	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "mailFooterCont",
		sSkinURI: "/SE/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		},
		fCreator: "createSEditor2"
	});

	var mgsVarCount = parseInt("${fn:length(msgVariableList)}");

	var nowHeight = $(".noBg").css("height").replace(/\px/gi,'');
	$(".noBg").css("height", (parseInt(nowHeight)+(26*mgsVarCount))+"px");
	parent.$.fancybox.update();

}

-->
</script>
</head>
<body class="noBg" style="height:740px;">
	<div class="popup_wrap">
		<h2>이메일 편집</h2>
		<div class="pageContScroll_st4">
			<h3>메시지 변환코드표</h3>
			<div class="top_box">
				<div class="text_type">
					<c:forEach items="${msgVariableList}" var="msgVariable">
						<p style="padding:3px;">${msgVariable.msgVariableCd}<span class="colRed"> ----- ${msgVariable.msgVariableNm}</span></p>
					</c:forEach>
				</div>
				<!-- // text_type -->
			</div>

	 		<form id="workForm" name="workForm" action="amM404Save.action" method="post" >
	 			<input type="hidden" name="msgDivRc" value="${emailInfo.msgDivRc}" />
	 			<input type="hidden" name="msgRoleCd" value="${emailInfo.msgRoleCd}" />
				<h3 style="margin-top:20px;">메일 제목</h3>
					<input name="mailTitle" class="validation[required]" style="font-size:14px; padding:5px; width:745px;height:30px;" value="${emailInfo.mailTitle}"/>
				<h3 style="margin-top:20px;">메일 내용</h3>
					<textarea name="mailCont" id="mailCont" class="validation[required]" title="이메일내용"  style="width:100%; height:200px; display:none;">${emailInfo.mailCont}</textarea>
				<h3 style="margin-top:20px;">메일 Footer</h3>
					<textarea name="mailFooterCont" id="mailFooterCont" class="validation[required]" title="이메일Footer"  style="width:100%; height:200px;  display:none;">${emailInfo.mailFooterCont}</textarea>
			</form>
		</div>
		<!-- // table_type2 -->
		<div class="btn_area">
			<div class="center">
				<a class="btn_blue_line2" href="javascript:;" onclick="iframe_send_msg('fnFancyboxCloseHandler();')">취소</a><a class="btn_blue_line2" href="javascript:void(0)" onclick="$.submit();">저장</a>
			</div>
		</div>
		<!-- // btn_area -->
	</div>
	<!-- // popup_wrap -->
</body>