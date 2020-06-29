<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />
	
<script type="text/javaScript" defer="defer">

function init(){
	fnDataSetting();
}

function fnDataSetting(){
	  var option = {
		 culture: 'ko'
		, formatString: 'd'
		, width: '140px'
		, height: '26px'
		, showFooter: true
		, animationType: 'none'
		, enableBrowserBoundsDetection:true
		, formatString: 'yyyy-MM-dd'
		, showTimeButton: false
		, showCalendarButton: true
		, theme: 'custom'
	};
	dateTimeInput("planDt", option, "${popupInfo.popupStartDt}");
	
	fnSchedulerP1OnOff();
}

function fnValidation(){
	if(updateForm.planDt.value.length == 0 || updateForm.planDt.value == ""){
		alert("일자를 선택해 주십시오");
		updateForm.planDt.focus();
		return false;
	}
	if(updateForm.planDt.value < '${nowYmd}'){
		alert("오늘 이전의 날짜를 선택할 수 없습니다.");
		updateForm.planDt.focus();
		return false;
	}
	if(confirm("수정하시겠습니까?") == true){
		updateForm.submit();
	}
}

function fnSchedulerP1OnOff(){
	var postData = $("#updateForm").serializeArray();
	$.ajax({
	    url : "calendar.action",
	    type: "POST",
	    data : postData,
	    success:function(data, textStatus, jqXHR){
	    	if(data.length > 0){
	    		var planDt = $("#planDt").val().split('-');
	    		var flagOnOff = "";
	    		var sum = 0;
	    		for (var i = 0; i < data.length; i++) {
	    			if(planDt[2] == data[i].workDd){
	    				sum ++;
	    			}
				}
	    		if(sum > 0){
	    			$("#flag_off").prop("checked","checked");
	    		}else{
	    			$("#flag_on").prop("checked","checked");
	    		}
	    	}
	    }
	});
}

</script>
</head>
<body class="noBg" style="height:680px">
	<div class="popup_wrap">
		<h2>일자별 콜 수정</h2>
		<div class="pageContScroll_st4">
			<div class="table_type2">
				<form id="updateForm" name="updateForm" action="schedulerP1Save.action" method="post">
					<input type="hidden" id="year" name="year" value="${fn:split(workDt,'-')[0]}"/>
					<input type="hidden" id="month" name="month" value="${fn:split(workDt,'-')[1]}"/>
					<table>
						<caption>일자선택, ON/OFF선택 으로 구성된 등록 테이블 입니다.</caption>
						<colgroup>
							<col style="width:20%;">
							<col style="width:80%;">
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">일자선택</th>
								<td>
									<div class="fl" id='planDt' name="planDt" value="${workDt}" readonly onchange="fnSchedulerP1OnOff();"></div>
								</td>
							</tr>
							<tr>
								<th scope="row">ON/OFF 선택</th>
								<td>
									<input type="radio" id="flag_on" name="flagOnOff" value="ON" checked="checked"><i></i>
									<label for="flag_on">ON(하루48콜)</label>
									<input type="radio" id="flag_off" name="flagOnOff" value="OFF"><i></i>
									<label for="flag_off">OFF(하루0콜)</label>
								</td>
							</tr>
						</tbody>
					</table>		
				</form>
			</div>
		</div>
		<div class="btn_area">
			<div class="center">
				<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">닫기</a>
				<a class="btn_blue_line2" href="#" onclick="fnValidation();">수정</a>
			</div>
		</div>
	</div>
</body>
</html>