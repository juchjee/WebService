<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
<script type="text/javaScript" defer="defer">

var m_oMonth = new Date();

var nowYear = "${fn:split(iConstant.nowYmd(),'-')[0]}";
var nowMonth = parseInt("${fn:split(iConstant.nowYmd(),'-')[1]}") - parseInt(1);
var nowDay = "${fn:split(iConstant.nowYmd(),'-')[2]}";

m_oMonth.setFullYear(nowYear) ;
m_oMonth.setMonth(nowMonth);
m_oMonth.setDate(nowDay);

var todayDate = parseInt(m_oMonth.getDate());
var todayYear = parseInt(m_oMonth.getFullYear());
var todayMonth = parseInt(m_oMonth.getMonth()+1);

m_oMonth.setDate(1);

function init(){

	fnClose();
	fnDataSetting();

}

function fnDataSetting(){

	printCalendar();
	$.renderCalendar();
	$.initEvent();
}

function fnClose(){
	$("#jqxgrid").jqxGrid({source: ""});
	fnResetGridEditData('jqxgrid');
	return false;
}

function spanText(day){

	var spanMonth = m_oMonth.getMonth()+1;
	if(spanMonth < 10){
		spanMonth = '0' + spanMonth;
	}

	if(day < 10){
		day = '0' + day;
	}

	$('.rsv td').removeClass('s');
	$("#"+day).addClass("s");

	var spanDay = $("#year").val()+"-"+spanMonth+"-"+day
	
	setTimeout(function(){
		$("#fancyBtn").attr("href","/mng/cs/schedulerP1.action?workDt="+spanDay);
		$("#fancyBtn").click();
	},200);
	
	$("#fancyBtn").fancybox({
		maxWidth	: 1920,
		maxHeight	: 1100,
		width		: 1000,
		autoSize	: true,
		beforeClose : function(){
			fnClose();
			location.reload();
		}
	});

}

function printCalendar() {

    /* 달력 UI 생성 */
	$.renderCalendar = function() {

		var postData = $("#calendarFrm").serializeArray();
		$.ajax({
		    url : "calendar.action",
		    type: "POST",
		    data : postData,
		    success:function(data, textStatus, jqXHR)
		    { 
		    	var joinMonth = parseInt($("#month").val());

				if($("#month").val() == ''){
					joinMonth = todayMonth;
					$("#year").val(todayYear);
					$("#month").val("0"+(todayMonth+1));
				}

				var arrTable = [];

				arrTable.push('<table class="rsv">');
				arrTable.push('<caption>달력</caption>');
				arrTable.push('<thead><tr>');

				var arrWeek = "일월화수목금토".split("");

				for(var i=0, len=arrWeek.length; i<len; i++) {
					arrTable.push('<th scope="col">' + arrWeek[i] + '</th>');
				}
				arrTable.push('</tr></thead>');
				arrTable.push('<tbody>');

				var oStartDt = new Date(m_oMonth.getTime());
		        // 1일에서 1일의 요일을 빼면 그 주 첫번째 날이 나온다.
				oStartDt.setDate(oStartDt.getDate() - oStartDt.getDay());


				for(var i=0; i<100; i++) {

					var dayValue = oStartDt.getDate();
					if(dayValue < 10){
						dayValue = '0' + dayValue;
					}

					if(i % 7 == 0) {
						arrTable.push('<tr>');
					}

					var sClass = '';
		            sClass += m_oMonth.getMonth() != oStartDt.getMonth() ? 'not-this-month ' : '';
					sClass += i % 7 == 0 ? 'sun' : '';
					sClass += i % 7 == 6 ? 'sat' : '';

					var notMonth = m_oMonth.getMonth() != oStartDt.getMonth() ? 'notMonth ' : '';

		            if(notMonth != ''){
		            	arrTable.push('<td></td>');
		            }else{
		            	var holly = "N";
						if(data.length > 0){
							for (key in data) {
								if(data[key].workDd == dayValue){
									holly = "Y";
									break;
								}
							}
						}

						var on = "ON";
						var off = "OFF";
						if(i % 7 == 0 || i % 7 == 6){  //주말제외
							arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '(OFF)' + '</td>');
						}else if(todayYear < $("#year").val()){
							if(holly == "N"){
								arrTable.push('<td id="'+dayValue+'" style="cursor:pointer;" class="y" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '(ON)' + '</td>');
								}else{
									arrTable.push('<td id="'+dayValue+'" class="'+sClass+'" style="cursor:pointer;" onclick="spanText('+oStartDt.getDate()+')">' + oStartDt.getDate() + '(OFF)' + '</td>');
								}
						}else if(todayYear == $("#year").val() && todayMonth < joinMonth){
							if(holly == "N"){
								arrTable.push('<td id="'+dayValue+'" class="y" style="cursor:pointer;" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '(ON)' + '</td>');
								}else{
									arrTable.push('<td id="'+dayValue+'" class="'+sClass+'" style="cursor:pointer;" onclick="spanText('+oStartDt.getDate()+')">' + oStartDt.getDate() + '(OFF)' + '</td>');
								}
						}else if(todayYear == $("#year").val() && todayMonth == joinMonth){
							if(todayDate < oStartDt.getDate() ){
								if(holly == "N"){
								arrTable.push('<td id="'+dayValue+'" class="y" style="cursor:pointer;" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '(ON)' + '</td>');
								}else{
									arrTable.push('<td id="'+dayValue+'" class="'+sClass+'" style="cursor:pointer;" onclick="spanText('+oStartDt.getDate()+')">' + oStartDt.getDate() + '(OFF)' + '</td>');
								}
							}else{
								arrTable.push('<td id="'+dayValue+'" class="'+sClass+'" style="cursor:pointer;" onclick="spanText('+oStartDt.getDate()+')">' + oStartDt.getDate() + '(OFF)' + '</td>');
							}
						}else{
							arrTable.push('<td id="'+dayValue+'" class="'+sClass+'" style="cursor:pointer;" onclick="spanText('+oStartDt.getDate()+')">' + oStartDt.getDate() + '(OFF)' + '</td>');
						}
		            }
					oStartDt.setDate(oStartDt.getDate() + 1);

					if(i % 7 == 6) {
						arrTable.push('</tr>');
						if(m_oMonth.getMonth() != oStartDt.getMonth()) {
							break;
						}
					}
				}
				arrTable.push('</tbody></table>');

				$('#calendar').html(arrTable.join(""));
				$.changeMonth();

		    },
		    error: function(jqXHR, textStatus, errorThrown)
		    {
		    	alert("통신에 실패 하였습니다. 관리자에게 문의해 주세요.");
		    }
		}); // ajax

	}//function : renderCalendar

	
	/* Next, Prev 버튼 이벤트 */
	$.initEvent = function() {
		$('#btnPrev').bind("click",function(){
			$.onPrevCalendar();
		});

		$('#btnNext').bind("click",function(){
			$.onNextCalendar();
		});
	}

    /* 이전 달력 */
	$.onPrevCalendar = function() {
		m_oMonth.setMonth(m_oMonth.getMonth() - 1);
		var spanMonth = m_oMonth.getMonth()+1;
		if(spanMonth < 10){
			spanMonth = '0' + spanMonth;
		}
		$("#month").val(spanMonth);

		if($("#month").val() > 11){
			$("#year").val(m_oMonth.getFullYear());
		}

		$.renderCalendar();
	}

    /* 다음 달력 */
	$.onNextCalendar = function() {
		m_oMonth.setMonth(m_oMonth.getMonth() + 1);

		var spanMonth = m_oMonth.getMonth()+1;
		if(spanMonth < 10){
			spanMonth = '0' + spanMonth;
		}
		$("#month").val(spanMonth);

		if($("#month").val() < 2){
			$("#year").val(m_oMonth.getFullYear());
		}

		$.renderCalendar();

	}

    /* 달력 이동되면 상단에 현재 년 월 다시 표시 */
	$.changeMonth = function() {
		$('#currentDate').text($.getYearMonth(m_oMonth).substr(0,9));
	}

    /* 날짜 객체를 년 월 문자 형식으로 변환 */
	$.getYearMonth = function(oDate) {
		var spanMonth = oDate.getMonth()+1;
		if(spanMonth < 10){
			spanMonth = '0' + spanMonth;
		}
		return oDate.getFullYear() + '년 ' + spanMonth + '월';
	}
}

</script>
</head>

<body>

	<form id="calendarFrm" name="calendarFrm" method="post">
		<input type="hidden" id="year" name="year" value="${fn:split(iConstant.nowYmd(),'-')[0]}"/>
		<input type="hidden" id="month" name="month" value="${fn:split(iConstant.nowYmd(),'-')[1]}"/>
	</form>
	
	<div class="rsv_wrap_bx">
		<div class="rsv_date_bx w100">
			<div class="body">
				<div class="ymd">
					<a href="javascript:;" id="btnPrev" class="prev">이전</a>
					<span id="currentDate"></span>
					<a href="javascript:;" id="btnNext" class="next">다음</a>
				</div>
				<div class="month" id="calendar">
				</div>
			</div><!--// body -->


			<!-- <div class="btm">선택일 : <span id="selectText" class="fc-blue">날짜를 선택하세요</span></div> --><!--// date_btm -->
		</div>
		<!--// rsv_date_bx -->
	</div>
	
	<a id="fancyBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;"></a>
	<div class="grid_type1" style="display:none;">
		<div id="jqxgrid"></div>
	</div>

</body>