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
	<script type="text/javascript">
		function init(){
			fnEvent();
		    fnDataSetting();
		}

		// 이벤트
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
					alert("발송할 문자를 입력해 주세요.");
					return;
				}
				if(parseInt($(".smsStrCnt").text()) > 1000){
					alert("sms는 1000이상 작성이 불가능합니다.");
					return;
				}

				if($(".partMbrCount").text() == "0" || $(".partMbrCount").text() == "(검색전) - 0"){
					alert("발송할 인원이 검색되지 않았습니다.");
					return;
				}
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
			dateTimeInput('purchaseStartDt', null, "${nowYmd}");
			dateTimeInput('purchaseEndDt');
			$("#partTpPmda").change();
			var mgsVarCount = parseInt("${fn:length(msgVariableList)}");
			var nowHeight = $(".noBg").css("height").replace(/\px/gi,'');
			$(".noBg").css("height", (parseInt(nowHeight)+(26*mgsVarCount))+"px");
			parent.$.fancybox.update();
			$("textarea[name=smsCont]").keyup();
			$(".tpText").text("에게 문자를 발송함");
		}

	</script>
</head>

<body class="noBg" style="height:662px;">
	 <form id="workForm" name="workForm" action="/mng/popup/mmsSendPop.action" method="post" >
	 	<input type="hidden" name="condiTp" id="condiTp" value="SMS" />
	 	<input type="hidden" name="msgRoleCd" id="msgRoleCd" value="${mmsInfo.msgRoleCd}" />
	 	<input type="hidden" name="msgDivRc" id="msgDivRc" value="${mmsInfo.msgDivRc}" />
		<div class="popup_wrap">
			<h2>MMS 발송</h2>
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
			<h3 style="margin-top:10px;">메시지 제목</h3>
			<div class="textarea_form" >
				<input type="text" id="mmsSub" name="mmsSub" class="validation" style="width:620px;" placeholder="0" value="${mmsInfo.mmsSub}">
			</div>
			<!-- // align_area -->
			<h3 style="margin-top:10px;">메시지 정보</h3>
					<div class="textarea_form" >
						<textarea name="smsCont" style="font-size:14px; padding:5px; width:630px;height:120px;word-break:nowrap;" maxlength="1000">${mmsInfo.smsCont}</textarea>
					</div>
					<p class="alignR" style="margin-top:10px;">(<span class="smsStrCnt" >0</span>/1000) byte</p>
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
