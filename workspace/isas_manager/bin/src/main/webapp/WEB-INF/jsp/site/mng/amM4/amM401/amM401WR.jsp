<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />

<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>

<script type="text/javascript" src="/js/functions.js"></script>
<script type="text/javaScript" defer="defer">
var contUrl = "${rootUri}${conUrl}amM401";

var oEditors = []; // 네이버 스마트 에디터
/*----------------------------------------------------------------------------------------------
 * 화면 load시 실행 함수 (onload)
 *----------------------------------------------------------------------------------------------*/
function init(){
	//이벤트 설정
	fnEvent();

	//초기 데이터 셋팅
	fnDataSetting();

	/*----------------------------- 네이버 스마트 에디터 Start -----------------------------*/
	nhn.husky.EZCreator.createInIFrame({
		oAppRef: oEditors,
		elPlaceHolder: "eventWinnersCont",
		sSkinURI: "/SE/SmartEditor2Skin.html",
		htParams : {
			bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
			bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
		},
		fOnAppLoad : function(){
			//_${divName}Arr.getById["${divName}"].exec("PASTE_HTML", [parent.$("#${divName}_Text").text()]);//부모 윈도우의  당첨자 명단을 가지고 온다.
			//$("#btn_div").show();
		},
		fCreator: "createSEditor2"
	});
	/*----------------------------- 네이버 스마트 에디터 End -----------------------------*/
}

/*----------------------------------------------------------------------------------------------
 * 페이지 이벤트 함수 모음
 *----------------------------------------------------------------------------------------------*/
function fnEvent(){

	/*----------------------------- 당첨자발표 등록 Start -----------------------------*/
	$.submit = function(){

		if($("#eventWinnersTitle").val()==""){
			alert("제목은(는) 필수 항목입니다.");
			$("#eventWinnersTitle").focus();
			return false;
		}
		if(oEditors[0].getIR()=="<p><br></p>"){
			alert("당첨자 명단은(는) 필수 항목입니다.");
			return false;
		}

		oEditors.getById["eventWinnersCont"].exec("UPDATE_CONTENTS_FIELD", []);
		fnSubmit("eventForm","저장");
	}
	/*----------------------------- 당첨자발표 등록 End -----------------------------*/
}
/*----------------------------------------------------------------------------------------------
 * 페이지 데이터 셋팅
 *----------------------------------------------------------------------------------------------*/
function fnDataSetting(){

}
</script>
</head>
<body class="noBg">
	<div class="popup_wrap">
		<h2>당첨자 관리</h2>
		<div class="pageContScroll_st2">
			<div class="table_type2">
			<form id="eventForm" name="eventForm" action="amM401WSave.action" method="post">
				<input type="hidden" name="eventSeq" id="eventSeq" value="${params.eventSeq}"/>
				<input type="hidden" name="modHis" id="modHis" value="${params.modHis}"/>
				<table>
					<caption>이벤트 당첨자에 대한 등록, 수정 테이블 입니다.</caption>
					<colgroup>
						<col style="width:12%;">
						<col style="width:42%;">
						<col style="width:12%;">
						<col style="width:43%;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">제목</th>
							<td colspan="3">
								<input type="text" name="eventWinnersTitle" id="eventWinnersTitle" class="validation[required]" title="제목" value="${resultMap.eventWinnersTitle}" style="width:600px;">
							</td>
						</tr>
						<tr>
							<!-- 등록/수정 구분 -->
							<th scope="row">당첨자 명단&nbsp;</th>
							<td colspan="3">
								<div class="edit_area">
									<div class="editScroll" style="height: 600px;">
										<textarea name="eventWinnersCont" id="eventWinnersCont" class="validation[required]" title="당첨자 명단" rows="30" cols="100" style="width:99%; height:330px;">${resultMap.eventWinnersCont}</textarea>
						            </div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
			</div>
	</div>
	<div class="btn_area">
		<div class="center">
			<a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">등록</a>
			<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">취소</a>
		</div>
	</div>
	</div>

</body>