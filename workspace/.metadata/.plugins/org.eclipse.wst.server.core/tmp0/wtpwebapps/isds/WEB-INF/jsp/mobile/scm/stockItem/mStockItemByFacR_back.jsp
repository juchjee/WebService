<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.dhx_loading_overlay{
	width:100%;
	height:100%;
	background-color:#D6D6D6;
	opacity:0.5;
	background-image:url(/component/dxTouch/codebase/imgs/loading.png);
	background-repeat:no-repeat;
	background-position:center;
};
.dhx_form{
background: #FFFFFF;
};
</style>
<script type="text/javascript">
var newWin;	//새창
var cnt = 0;
var w = $(window).width(); 
var h = $(window).height();
var h = h-175;
var date = dateformat(new Date());
var fullDate = new Date();
var hour = fullDate.getHours()+'';
var minute = fullDate.getMinutes();
if(minute <= 9){
	minute = '0'+minute;
}
var form = { id: 'app', view: 'layout',
		rows: [
				{ view: 'layout', type: 'wide',
					rows: [
						{   type: "clean", height: 45,
					        cols: [
					          { view: "button", type: "round", label: "조회", click: "fn_search();" }, 
						    ]
					    },
						{ view: 'form', scroll: true, height : 130,
							elements: [
								{ view: 'text', label: '기준일자', id: 'stdDt', value:date, readonly:true},
								{ view:"combo", label:'사업장', id: "facCd",select:true,datatype:'json',url:'/mobile/scm/stockItem/stockItemByFacR/combo'},
// 								{ view:"combo", label:'품목정보', id: "itmCd",select:true,datatype:'json',url:'/mobile/scm/stockItem/stockItemR/combo'},	//combo
								{ view: "text", label: '품목정보', id: "itmInfo"}	//코드/명으로 like 검색	- input
							], id: 'frmMain',
						},
						
						{ view: 'grid', datatype: 'json', id:'gridMain', select: true, scroll: "xy", height : h,
							fields: [
								{ width: 110, label: '품목코드'	, template: '#itmCd#'	, type: 'custom', align: 'left'},
// 								{ width: 65	, label: '총합'		, template: '#tot#'		, type: 'custom', align: 'right'},
								{ width: 80	, label: '재고량'	, template: '#qty#'		, type: 'custom', align: 'right'},
								{ width: 100, label: '창고'		, template: '#whNm#'	, type: 'custom', align: 'left'},
								{ width: 140, label: '품목명'	, template: '#itmNm#'	, type: 'custom', align: 'left'},
							], header: true,
						}
					], id: 'stockItem',
				}
			]
		}

var loginView = {
    type: "clean",
    css: "layout",
    rows: [toolbar, {gravity: 1}, { type: "clean", cols: [{ width: 15 }, form, {width: 15}]}, {gravity: 2}]
};
dhx.ready(function() {
	dhx.ui.fullScreen();
    dhx.ui(form); 
    doDisplay();
    $$("gridMain").attachEvent("onItemClick",function(id,ev,trg){
		var rId = $('#gridId').val(id);
		var list = $$('gridMain').item(rId);
		doDisplay();
// 		openWin = location.assign("/mobile/scm/stockItem/mStockItemDetailR.do");	//상세내역
// 		openWin.document.getElementById("stdDt").value = searchDate($$('stdDt').wg,"-");
// 		openWin.document.getElementById("itmCd").value = list.itmCd;
	});
});
function fn_search(){
	cnt = 0;
	
	var gridMain = $$('gridMain');
	dhx.extend(gridMain, dhx.OverlayBox);
	gridMain.showOverlay();

	var obj = {};
	obj.stdDt = searchDate($$('stdDt').wg,"-");
// 	obj.itmCd = $$('itmCd').getValue();
	obj.itmInfo = $$('itmInfo').getValue();
	obj.facCd = $$('facCd').getValue();
	
	mobileAjax("/mobile/scm/stockItem/stockItemByFacR/list",obj,function(data){
		gridMain.clearAll();
		gridMain.define('datatype', 'json');
		gridMain.define('data', data);
		gridMain.adjust();
		//상단에 x,y에 대해 scroll이 지정되어 있으므로 별도로 안줘도 됨
// 		gridMain.define('scroll', 'y');
// 		gridMain.define('scroll', 'x');
		fn_searchCB(gridMain);
		gridMain.refresh();
		gridMain.hideOverlay();
	});
}

function fn_searchCB(gridMain) {
	var cnt = gridMain.dataCount();
	var befItmCd = "";
	var itmCd = "";
	
	for(var i=0; i < cnt; i++) {
		itmCd = "";
		
		if(i > 0) {
			befItmCd = gridMain.data.getIndexRange()[i-1].itmCd;
			itmCd = gridMain.data.getIndexRange()[i].itmCd;	
		}
		
		if((befItmCd == itmCd) && (befItmCd != "")) {
			gridMain.data.getIndexRange()[i].itmCd = "";
			gridMain.data.getIndexRange()[i].tot = "";
			befItmCd = itmCd;
		}
		
	}
}

//표 보였다가 안보였다 하기 
function doDisplay() {
	var rId = $('#gridId').val();
	var detail = document.getElementById('detail');
	var list = $$('gridMain').item(rId);
	var bizAreaNm = "";
	var spec = "";
	var itmBcNm = "";
	var bQty = "";
	var cQty = "";
	var jQty = "";
	var lQty = "";
	var yQty = "";
	var eQty = "";
	
	detail.style.display = 'none';
	if(list!= undefined) {
		bizAreaNm = list.bizAreaNm;
		spec = list.spec;
		itmBcNm = list.itmBcNm;
		bQty = list.bQty;
		cQty = list.cQty;
		jQty = list.jQty;
		lQty = list.lQty;
		yQty = list.yQty;
		eQty = list.eQty;
		
		detail.style.display = 'block';
	} 
	
	$("#bizAreaNm").text(bizAreaNm);
	$("#spec").text(spec);
	$("#itmBcNm").text(itmBcNm);
	$("#bQty").text(bQty); 
	$("#cQty").text(cQty);
	$("#jQty").text(jQty);
	$("#lQty").text(lQty);
	$("#yQty").text(yQty);
	$("#eQty").text(eQty);
}
</script>
<form id="pForm" name="pForm">
<input type="hidden" id="gridId" name="gridId">
</form>


<div id="detail">
<table class="dhx_grid_row">
	<tbody>
		<tr>
			<td style="width:110px;">사업군</td>
			<td><span id="bizAreaNm"></span></td>
		</tr>
		<tr>
			<td style="width:110px;">규격</td>
			<td><span id="spec"></span></td>
		</tr>
		<tr>
			<td style="width:110px;">구분</td>
			<td><span id="itmBcNm"></span></td>
		</tr>
		<tr>
			<td style="width:110px;">진주영업</td>
			<td><span id="bQty"></span></td>
		</tr>
		<tr>
			<td style="width:110px;">아산</td>
			<td><span id="cQty"></span></td>
		</tr>
		<tr>
			<td style="width:110px;">전시장창고</td>
			<td><span id="jQty"></span></td>
		</tr>
		<tr>
			<td style="width:110px;">용인물류</td>
			<td><span id="lQty"></span></td>
		</tr>
		<tr>
			<td style="width:110px;">괴산</td>
			<td><span id="yQty"></span></td>
		</tr>
		<tr>
			<td style="width:110px;">예산완제품</td>
			<td><span id="eQty"></span></td>
		</tr>
	</tbody>
</table>
</div>
