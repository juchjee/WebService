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
	height : 40px; 
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
	var stdDt = searchDate($('#stdDt').val());
	stdDt = stdDt.substring(0,4) + "-" + stdDt.substring(4,6) + "-" + stdDt.substring(6,8);

	var urlInfo = $('#urlInfo').val();
	if(urlInfo.includes("mStockItemByFacR")) {	//사업장별 현황
		location.assign("/mobile/scm/stockItem/mStockItemByFacR.do" + "?stdDt=" + stdDt + "?itmInfo=" + $('#itmInfo').val() + "?facCd=" + $('#facCd').val());	
	} else if(urlInfo.includes("mStockItemR")) {	//품목별 현황
		location.assign($('#urlInfo').val() + ".do?stdDt=" + stdDt + "?itmCd=" + $('#itmCd').val());
	}
}

function fn_search(){
	var obj = {};
	obj.stdDt = searchDate($('#stdDt').val());
	obj.itmCd = $('#schItmCd').val();
	
	mobileAjax("/mobile/scm/stockItem/stockItemR/list",obj,function(data){
		var d = data[0];
		$("#itmCdT").text(d.itmCd);
		$("#itmNm").text(d.itmNm);
		$("#bizAreaNm").text(d.bizAreaNm);
		$("#spec").text(d.spec);
		$("#itmBcNm").text(d.itmBcNm);
		$("#bQty").text(addComma(d.bQty)); 
		$("#cQty").text(addComma(d.cQty));
		$("#jQty").text(addComma(d.jQty));
		$("#yQty").text(addComma(d.yQty));
		$("#lQty").text(addComma(d.lQty));
		$("#eQty").text(addComma(d.eQty));
		$("#pQty").text(addComma(d.pQty));
	});
}

function addComma(num) {
  var regexp = /\B(?=(\d{3})+(?!\d))/g;
//    return parseInt(num.toString().replace(regexp, ','));
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
<input type="hidden" id="stdDt" name="stdDt" value="">
<input type="hidden" id="schItmCd" name="schItmCd" value="">
<input type="hidden" id="itmCd" name="itmCd" value="">
<input type="hidden" id="facCd" name="facCd" value="">
<input type="hidden" id="itmInfo" name="itmInfo" value="">
<input type="hidden" id="urlInfo" name="urlInfo" value="">
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
			<th colspan='2' class="dhx_title">제품별 재고 상세내역</th>
		</tr>
		<tr>
			<td class="dhx_left_lbl">제품코드</td>
			<td class="dhx_right_lbl"><span id="itmCdT"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">제품명</td>
			<td class="dhx_right_lbl"><span id="itmNm"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl"><label>사업군</label></td>
			<td class="dhx_right_lbl"><span id="bizAreaNm"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">규격</td>
			<td class="dhx_right_lbl"><span id="spec"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">구분</td>
			<td class="dhx_right_lbl"><span id="itmBcNm"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">진주영업</td>
			<td class="dhx_right_lbl"><span id="bQty" style="select:format-number(current(), '###,###.00');"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">아산</td>
			<td class="dhx_right_lbl"><span id="cQty" style="select:format-number(current(), '###,###.00');"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">전시장창고</td>
			<td class="dhx_right_lbl"><span id="jQty" style="select:format-number(current(), '###,###.00');"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">용인물류</td>
			<td class="dhx_right_lbl"><span id="yQty" style="select:format-number(current(), '###,###.00');"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">괴산</td>
			<td class="dhx_right_lbl"><span id="lQty" style="select:format-number(current(), '###,###.00');"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">예산완제품</td>
			<td class="dhx_right_lbl"><span id="eQty" style="select:format-number(current(), '###,###.00');"></span></td>
		</tr>
		<tr>
			<td class="dhx_left_lbl">부산물류기지</td>
			<td class="dhx_right_lbl"><span id="pQty" style="select:format-number(current(), '###,###.00');"></span></td>
		</tr>
	</tbody>
</table>
</div>
</div>
