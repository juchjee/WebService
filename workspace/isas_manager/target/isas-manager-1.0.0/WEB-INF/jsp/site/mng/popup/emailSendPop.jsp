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

	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	 var oEditors = [];

	 function init(){
	 	fnEvent();
	 	fnDataSetting();
	 }


		// 이벤트
		function fnEvent(){
			$.submit = function(){
				var partMbrCount = parseInt($("input[name=partMbrCount]").val());
				var remainCnt = ${remainCnt};

				if(partMbrCount == 0){
					alert("조건별 인원 수 조회 후 이용가능합니다.");
					return;
				}

				if(partMbrCount < 10){
					alert("최소 인원 10명 이상 검색 되어야 이용 가능합니다.");
					return;
				}

				if(partMbrCount > remainCnt){
					alert("대용량 메일 잔여 건수를 초과하였습니다.");
					return;
				}

				oEditors.getById["mailCont"].exec("UPDATE_CONTENTS_FIELD", []);
				oEditors.getById["mailFooterCont"].exec("UPDATE_CONTENTS_FIELD", []);

				fnSubmit("workForm","발송");
			}

			// 개별조건등록
			$("#partTpPmda").change(function() {//기간타입_PMD
				var radioValue = $(this).val();
				if (radioValue == "A") {//전체
					$("#purchaseStartDt").jqxDateTimeInput({disabled: true});
					$("#purchaseEndDt").jqxDateTimeInput({disabled: true});
					$("#period").attr("disabled",true);
					$("#periodText").hide();
				}else if (radioValue == "P") {//고정기간
					$("#purchaseStartDt").jqxDateTimeInput({disabled: false});
					$("#purchaseEndDt").jqxDateTimeInput({disabled: false});
					$("#period").attr("disabled",true);
					$("#periodText").hide();
				} else{
					if (radioValue == "M") {//월단위
						$("#periodText").text('개월간');
					} else if (radioValue == "D") {//일단위
						$("#periodText").text('일간');
					}
					$("#purchaseStartDt").jqxDateTimeInput({disabled: true});
					$("#purchaseEndDt").jqxDateTimeInput({disabled: true});
					$("#period").attr("disabled",false);
					$("#periodText").show();
				}

			});
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

			dateTimeInput('purchaseStartDt', null, "${nowYmd}");
			dateTimeInput('purchaseEndDt');
			$("#partTpPmda").change();

			var mgsVarCount = parseInt("${fn:length(msgVariableList)}");

			var nowHeight = $(".noBg").css("height").replace(/\px/gi,'');
			$(".noBg").css("height", (parseInt(nowHeight)+(26*mgsVarCount))+"px");
			parent.$.fancybox.update();

			$(".tpText").text("에게 메일을 발송함");
		}

	</script>
</head>

<body class="noBg" style="height:740px;">
	 <form id="workForm" name="workForm" action="/mng/popup/emailSendPop.action" method="post" >
	 	<input type="hidden" name="condiTp" id="condiTp" value="MAIL" />
	 	<input type="hidden" name="msgDivRc" value="${emailInfo.msgDivRc}" />
	 	<input type="hidden" name="msgRoleCd" value="${emailInfo.msgRoleCd}" />
		<div class="popup_wrap">
			<h2>이메일 발송 (대용량 메일 잔여 건수 : <span class="validation[number]">${remainCnt}</span>건)</h2>
			<div class="pageContScroll_st4">
			<div class="top_box">
				<div class="text_type">
					<c:forEach items="${msgVariableList}" var="msgVariable">
						<p style="padding:3px;">${msgVariable.msgVariableCd}<span class="colRed"> ----- ${msgVariable.msgVariableNm}</span></p>
					</c:forEach>
				</div>
				<!-- // text_type -->
			</div>
			<h3 style="margin-top:20px;">발송 조건</h3>
						<c:import url="/WEB-INF/jsp/site/mng/popup/partCondition.jsp" />

			<!-- // align_area -->
			<h3 style="margin-top:20px;">메일 제목</h3>
					<input name="mailTitle"  class="validation[required]"style="font-size:14px; padding:5px; width:745px;height:30px;" value="${emailInfo.mailTitle}"/>

			<h3 style="margin-top:20px;">메일 내용</h3>
					<textarea name="mailCont" id="mailCont" class="validation[required]" title="이메일내용"  style="width:100%; height:200px; display:none;">${emailInfo.mailCont}</textarea>
			<h3 style="margin-top:20px;">메일 Footer</h3>
					<textarea name="mailFooterCont" id="mailFooterCont" class="validation[required]" title="이메일Footer"  style="width:100%; height:200px; display:none;">${emailInfo.mailFooterCont}</textarea>
			</div>
			<div class="btn_area">
				<div class="center">
					<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
					<a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">발송</a>
				</div>
			</div>
			<!-- // btn_area -->
		</div>
		<!-- // popup_wrap -->
	</form>
</body>
</html>
