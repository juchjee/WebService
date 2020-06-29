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

	<script type="text/javascript" src="${rootUri}js/jwplayer/jwplayer.js"></script>

	<script type="text/javascript">
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){
	    fnEvent();
	    fnDataSetting();
	}

	function fnEvent(){
		$("#subBtn").bind("click",function(){
			parent.$("#accountMsg").val($("#accountMsg").val());
			parent.$("#receiptMoblie").val($("#receiptMoblie").val());
			parent.$("#senderMoblie").val($("#senderMoblie").val());
			parent.$.claimProcSpecificSave(parent.$("#claimProcStatusCd").val(),parent.$("#claimProcStatusNm").val());
		});

		$("#accountMsg").bind("keyup",function(){
			fnChkByte(this,'80')
		});
	}

	 /*----------------------------------------------------------------------------------------------
	 * 화면 기본 데이터 셋팅
	 *----------------------------------------------------------------------------------------------*/
	function fnDataSetting(){
		if(parent.$("#claimTpCd").val() =="OCT00004"){
			$("#accountMsg").val("[inus]반품비 :"+setComma(parseInt(parent.$("#receivedCharge").val())+parseInt(parent.$("#claimDeliCharge").val()))+"원 " + parent.$("#accountMsg").val());
		}else{
			$("#accountMsg").val("[inus]반품 택배비 :"+setComma(parent.$("#claimDeliCharge").val())+"원 " + parent.$("#accountMsg").val());
		}
		$("#receiptMoblie").val(parent.$("#receiptMoblie").val());
		$("#accountMsg").keyup();
	}
	</script>
</head>

<body class="noBg" >
	<div class="popup_wrap" style="background:#fff">
	<h2>반품 정보 확인</h2>
			<form name="smsForm" id="smsForm" method="post">
			<div class="table_type1" style="margin-bottom:10px;" >
				<table>
					<tr>
						<td colspan="2" >
							<textarea id="accountMsg" name="accountMsg" cols="60" rows="5" style="padding:5px;resize:none;">
							</textarea>
						</td>
					</tr>
					<tr>
						<td>보내는 전화번호:<br>
							   <input type="text"  size="20" class="input" name="senderMoblie" id="senderMoblie" value="02-6205-3337"><p>
						</td>
						<td>받는 전화번호:<br>
							   <input type="text" name="receiptMoblie" id="receiptMoblie" size="20" class="input" value="${pakingMap.ordersMobile}">
							   <!-- http://58.229.234.98/${pakingMap.orderPackingDt}/${pakingMap.regiNo}.mp4 -->
						</td>
					</tr>
				</table>
			</div>
			<div class="btn_area" style="height:10px;">
		    <div class="center" >
		      	<a id="subBtn" class="btn_blue_line2" href="javascript:;">SMS발송 및 확인 처리</a>
		      	<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
		    </div>
		  </div>
			</form>
	</div>
	<!-- // member_con -->
</body>
</html>
