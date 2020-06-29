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

	<!-- 마케팅관리 : SMS관리 -->

<script type="text/javaScript" defer="defer">

<!--
/*----------------------------------------------------------------------------------------------
 * 화면 load시 실행 함수 (onload)
 *----------------------------------------------------------------------------------------------*/
function init(){
	fnEvent();
	fnDataSetting();
}


/*----------------------------------------------------------------------------------------------
 * 페이지 이벤트 함수 모음
 *----------------------------------------------------------------------------------------------*/
function fnEvent(){
	$("textarea[name=smsCont]").bind("keyup",function(){
			var maxByte = 80;
			var str =  $(this).val();
			var str_len = str.length;
			var rbyte = 0;
			var rlen = 0;
			var one_char = "";
			var str2 = "";

				for(var i=0; i<str_len; i++){
				one_char = str.charAt(i);
				if(escape(one_char).length > 4){
				    rbyte += 2;                                         //한글2Byte
				}else{
				    rbyte++;                                            //영문 등 나머지 1Byte
				}

				if(rbyte <= maxByte){
				    rlen = i+1;                                          //return할 문자열 갯수
				}
			}

			if(rbyte > maxByte){
				$(".smsStrCnt").css("color","red");
			}else{
				$(".smsStrCnt").css("color","");
			}

		$(".smsStrCnt").text(rbyte);
	});


	$.submit = function(){
		var smsCont = $("textarea[name=smsCont]").val();

		if(smsCont.length == 0){
			alert("저장할 문자를 입력해 주세요.");
			return;
		}

		if(parseInt($(".smsStrCnt").text()) > 80){
			if(!confirm("sms는 80이상 작성이 불가능합니다.\n계속 하시겠습니까?")){
				return;
			}
		}
		if(smsCont.length > 1000){
			alert("mms는 1000이상 작성이 불가능합니다.");
			return;
		}
		fnSubmit("workForm","저장");
	}
}

function fnDataSetting(){
	var mgsVarCount = parseInt("${fn:length(msgVariableList)}");

	var nowHeight = $(".noBg").css("height").replace(/\px/gi,'');
	$(".noBg").css("height", (parseInt(nowHeight)+(26*mgsVarCount))+"px");
	parent.$.fancybox.update();

	$("textarea[name=smsCont]").keyup();
}

-->

</script>
</head>
<body class="noBg" style="height:512px;">
	<div class="popup_wrap">
		<h2>SMS 문자편집</h2>
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

	 		<form id="workForm" name="workForm" action="amM403Save.action" method="post" >
	 			<input type="hidden" name="msgDivRc" value="${smsInfo.msgDivRc}" />
	 			<input type="hidden" name="msgRoleCd" value="${smsInfo.msgRoleCd}" />
	 			<h3 style="margin-top:20px;">MMS 제목</h3>
				<input name="mmsSub" style="font-size:14px; padding:5px; width:648px;height:20px;" value="${smsInfo.mmsSub}" maxlength="20"/>
				<h3 style="margin-top:20px;">메시지 작성</h3>
				<div class="textarea_form" >
					<textarea name="smsCont" style="font-size:14px; padding:5px; width:630px;height:120px;word-break:nowrap;" >${smsInfo.smsCont}</textarea>
				</div>
				<p class="alignR" style="margin-top:10px;">(<span class="smsStrCnt" >0</span>/80)</p>
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