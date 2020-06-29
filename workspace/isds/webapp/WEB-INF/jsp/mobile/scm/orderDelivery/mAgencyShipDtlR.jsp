<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.dhx_table {
	width: 100%;
	height : 100%; 
	text-align: left; 
	padding: 10px 10px 10px 10px;
}

.dhx_div {
	width: 100%;
	height : 45px; 
	text-align: center; 
	padding: 10px 10px 10px 10px;
}

.dhx_btn {
	width: 100%;
	height : 100%; 
	text-align: center; 
/* 	padding: 10px 10px 10px 10px; */
}

.dhx_title {
	width: 100%;
	height : 35px; 
	text-align: left; 
	padding: 0px 0 0 20px;
	background-color: #c2dae2;
}

.dhx_left_lbl {
	width : 100px;
	height : 35px;
	font-size : 0.8em;
	padding: 5px 0 0 20px;
	border: 0px solid #d3d3d3;
	font-weight	: bold;
	background-color	: #f2f2f2;
}

.dhx_right_lbl {
	width : 200px;
	height : 35px;
	font-size : 0.8em;
	padding: 0 5px 0 10px;
	border: 0px solid #d3d3d3;
	font-weight	: bold;
	background-color	: #f2f2f2;
}

</style>
<script type="text/javascript">
var w = $(window).width(); 
var lw = parseInt(w*0.3);
var rw = parseInt(w*0.7);
var h = $(window).height();
var twidth = w-20;

//부모창 파라미터 받아오기 [stdDt, itmCd]
function fn_setParam(search) {
	var vb = true;
	var uri = decodeURI(search);
	
	if(uri != "" || uri != null || uri != undefined) {
		uri = uri.slice(1, uri.length);
		
		var param = uri.split('?');
		
		for(var i=0; i < param.length; i++) {
			var devide = param[i].split('=');
			$('#' + devide[0]).val(devide[1]);	//val = data 형식
		}
	} else {
		vb = false;
	}
	
	return vb;
}

//준비
dhx.ready(function() {
	dhx.ui.fullScreen();
	$('dhx_btn').css('width', twidth + 'px');
	$('dhx_left_lbl').css('width', lw + 'px');
	$('dhx_right_lbl').css('width', rw + 'px');
	
	if(fn_setParam(window.location.search)) {
	    fn_search();	//자동조회
	}
});

function fn_back() {
	var frDt = searchDate($('#frDt').val());
	var toDt = searchDate($('#toDt').val());
	var custCd = $("#custCd").val();
	var facCd = $("#facCd").val();
// 	frDt = frDt.substring(0,4) + "-" + frDt.substring(4,6) + "-" + frDt.substring(6,8);
// 	toDt = toDt.substring(0,4) + "-" + toDt.substring(4,6) + "-" + toDt.substring(6,8);

	var urlInfo = $('#urlInfo').val();
// 	location.assign("/mobile/scm/orderDelivery/mAgencyShipR.do" + "?custCd=" + custCd + "?facCd=" + facCd + "?frDt=" + frDt + "?toDt=" + toDt);	
	location.assign("/mobile/scm/orderDelivery/mAgencyShipR.do" + "?custCd=" + custCd + "?frDt=" + frDt + "?toDt=" + toDt);	
}

function fn_search(){
	var obj = {};
	obj.outNo = $('#outNo').val();
	obj.outSq = $('#outSq').val();
	
	mobileAjax("/mobile/scm/orderDelivery/mAgencyShipDtlR/list",obj,function(data){
		var d = data[0];
		//현장명, 출고일자, 품목코드, 품목명, 수량, 금액, 차량번호, 운전자, 핸드폰
		$("#outDt").text(d.outDt);
		$("#facNm").text(d.facNm);
		$("#fldNm").text(d.fldNm);
		$("#dlvYard").text(d.dlvYard);
		$("#outDt").text(d.outDt);
		$("#itmCd").text(d.itmCd);
		$("#itmNm").text(d.itmNm);
		$("#outQty").text(addComma(d.outQty)); 
		$("#outAmt").text(addComma(d.outAmt));
		$("#carNo").text(d.carNo);
		$("#drvNm").text(d.drvNm);
		$("#mobile").text(d.mobile);
	});
}

function addComma(num) {
  var regexp = /\B(?=(\d{3})+(?!\d))/g;
   return parseInt(num).toString().replace(regexp,',');
}

//뒤로가기 버튼 이벤트
window.onpageshow = function(event) {
	if(event.persisted) {
		this.fn_back();
	}
}
</script>

<!-- overflow : auto > 브라우저가 결정하게 함 -->
<div style="width:100%; height:100%; overflow:auto;">
<form id="pForm" name="pForm">
<input type="hidden" id="outNo" name="outNo" value="">
<input type="hidden" id="outSq" name="outSq" value="">
<input type="hidden" id="custCd" name="custCd" value="">
<!-- <input type="hidden" id="facCd" name="facCd" value=""> -->
<input type="hidden" id="frDt" name="frDt" value="">
<input type="hidden" id="toDt" name="toDt" value="">
</form>

<div class="dhx_view dhx_el_roundbutton" id="button1" style="width:100%; overflow-y:auto;">
	<table class="dhx_table">
		<tbody>
			<tr>
				<td class="dhx_btn">
					<input type="button" style="width:100%; margin:0px;" value="돌아가기" onclick="fn_back()">
				</td>
			</tr>
		</tbody>
	</table>
</div>

<div id="detail">
<table class="dhx_table">
	<tbody>
		<tr>
			<th colspan='2' class="dhx_title">출하 상세내역</th>
		</tr>
		<!-- 현장명, 출고일자, 품목코드, 품목명, 수량, 금액, 차량번호, 운전자, 핸드폰 -->
		<tr>
			<td class="dhx_left_lbl">출고일자</td>
			<td class="dhx_right_lbl"><span id="outDt"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">출고사업장</td>
			<td class="dhx_right_lbl"><span id="facNm"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">현장명</td>
			<td class="dhx_right_lbl"><span id="fldNm"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">납품장소</td>
			<td class="dhx_right_lbl"><span id="dlvYard"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">품목코드</td>
			<td class="dhx_right_lbl"><span id="itmCd"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">품목명</td>
			<td class="dhx_right_lbl"><span id="itmNm"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">수량</td>
			<td class="dhx_right_lbl"><span id="outQty"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">금액</td>
			<td class="dhx_right_lbl"><span id="outAmt"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">차량번호</td>
			<td class="dhx_right_lbl"><span id="carNo"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">운전자</td>
			<td class="dhx_right_lbl"><span id="drvNm"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">핸드폰</td>
			<td class="dhx_right_lbl"><span id="mobile"></span></td>
		</tr>
	</tbody>
</table>
</div>
</div>
