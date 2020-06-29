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
					          { view: "button", type: "round", label: "돌아가기", click: "fn_back();" }, 
					          { view: "button", type: "round", label: "조회", click: "fn_search();" }, 
						    ]
					    },
						{ view: 'form', scroll: false, height : 130,
							elements: [
								{ view: 'text', label: '기준일자', id: 'stdDt', value:date, readonly:true},
								{ view: "text", label: '품목코드', id: "itmCd", readonly:true},
								{ view: "text", label: '품목명', id: "itmNm", readonly:true},
								{ view: "text", label: '공장코드', id: "facCd", readonly:true},
								{ view: "text", label: '품목정보', id: "itmInfo", readonly:true},
							], id: 'frmMain'
						},
						
						{ view: 'grid', datatype: 'json', id:'gridMain', select: true, scroll: "xy", height : h,
							fields: [
// 								{ view:"combo", label:'창고정보', template : function(obj) {
// 									var whCd = fn_baseCdSrch("whCd", obj.whCd);
// 									return whNm;
// 								}, type: 'custom', align: 'left'},
// 								{ width: 60 , label: '구분'	, template: function(obj) {
// 									var itmBc = fn_baseCdSrch("itmBc", obj.itmBc);
// 									return itmBcNm;
// 								}, type: 'custom', align: 'center'},
// 								{ width: 60	, label: '규격'	, template: '#stdNm#'	, type: 'custom', align: 'center'},
// 								{ width: 60	, label: '색상'	, template: function(obj) {
// 									var tcolor = fn_baseCdSrch("color", obj.tcolor);
// 									return tcolorNm;
// 								} , type: 'custom', align: 'center'},
// 								{ width: 70	, label: '사이즈'	, template: function(obj) {
// 									var tsize = fn_baseCdSrch("size", obj.tsize);
// 									return tsizeNm;
// 								} , type: 'custom', align: 'center'},
// 								{ width: 70	, label: '등급'	, template: function(obj) {
// 									var tgrade = fn_baseCdSrch("grade", obj.tgrade);
// 									return tgradeNm;
// 								} , type: 'custom', align: 'center'},
								{ view:"combo", label:'창고정보', template : '#whNm#', type: 'custom', align: 'left'},
								{ width: 60	, label: '색상'	, template: '#tcolorNm#' , type: 'custom', align: 'center'},
								{ width: 70	, label: '사이즈'	, template: '#tsizeNm#' , type: 'custom', align: 'center'},
								{ width: 70	, label: '등급'	, template: '#tgradeNm#' , type: 'custom', align: 'center'},
// 								{ width: 60	, label: '기초'	, template: function(obj){
// 									var basQty = addComma(obj.basQty);
// 									return basQty;
// 								}, type: 'custom', align: 'right'},
// 								{ width: 60	, label: '입고'	, template: function(obj){
// 									var inQty = addComma(obj.inQty);
// 									return inQty;
// 								}, type: 'custom', align: 'right'},
// 								{ width: 60	, label: '출고'	, template: function(obj){
// 									var outQty = addComma(obj.outQty);
// 									return outQty;
// 								}, type: 'custom', align: 'right'},
								{ width: 60	, label: '재고'	, template: function(obj){
									var endQty = addComma(obj.endQty);
									return endQty;
								}, type: 'custom', align: 'right'},
								{ width: 60 , label: '구분'	, template: '#itmBcNm#', type: 'custom', align: 'center'},
								{ width: 60	, label: '규격'	, template: '#stdNm#'	, type: 'custom', align: 'center'},
							], header: true,
						},
					], id: 'stockItem'
				}
			]
		}

var loginView = {
    type: "clean",
    css: "layout",
    rows: [toolbar, {gravity: 1}, { type: "clean", cols: [{ width: 15 }, form, {width: 15}]}, {gravity: 2}]
};

var search = "";
dhx.ready(function() {
	dhx.ui.fullScreen();
    dhx.ui(form); 
    
    search = window.location.search;
    if(search) {
    	if(fn_setParam(search)) {
    		fn_search();
    	}
	}
});


function fn_setParam(search) {
	var vb = true;
	var uri = decodeURI(search);
	
	if(uri != "" || uri != null || uri != undefined) {
		uri = uri.slice(1, uri.length);
		
		var param = uri.split('?');
		
		for(var i=0; i < param.length; i++) {
			var devide = param[i].split('=');
			$$(devide[0]).setValue(devide[1]);
		}
	} else {
		vb = false;
	}
	
	return vb;
}

function fn_back() {
	location.assign("/mobile/scm/stockItem/mStockItemR.do" + "?stdDt=" + $$('stdDt').getValue() + "?facCd=" + $$('facCd').getValue() + "?itmInfo=" + $$('itmInfo').getValue());	
}


function fn_search(){
	var gridMain = $$('gridMain');
	dhx.extend(gridMain, dhx.OverlayBox);
	gridMain.showOverlay();

	var obj = {};
	obj.stdDt = searchDate($$('stdDt').wg,"-");
	obj.facCd = $$('facCd').getValue();
	obj.itmCd = $$('itmCd').getValue();
	
	mobileAjax("/mobile/scm/stockItem/stockItemGrdDtlR/list",obj,function(data){
		search = "";
		gridMain.clearAll();
		gridMain.define('datatype', 'json');
		gridMain.define('data', data);
		gridMain.adjust();
		fn_searchCB();
		gridMain.refresh();
		gridMain.hideOverlay();
	});
}

var tcolorNm = "";
var tsizeNm = "";
var tgradeNm = "";
var whNm = "";
var itmBcNm = "";
function fn_baseCdSrch(div, cd){
	tcolorNm = "";
	tsizeNm = "";
	tgradeNm = "";
	whNm = "";
	itmBcNm = "";
	
	var obj = {};
	
	if("whCd"==div) {
		obj.whCd = cd;
		mobileAjax("/mobile/scm/stockItem/stockItemGrdDtlR/listWhNm",obj,function(data){
				whNm = data[0].whNm;
		});	
	} else {
		obj.baseCd = cd;
		mobileAjax("/mobile/scm/stockItem/stockItemGrdDtlR/listBaseNm",obj,function(data){
			if("color"==div) {
				tcolorNm = data[0].title;
			} else if ("size"==div) {
				tsizeNm = data[0].title;
			} else if("grade"==div) {
				tgradeNm = data[0].title;
			} else if("itmBc"==div) {
				itmBcNm = data[0].title;
			}
		});
	}
}

function fn_searchCB() {
	
}

function addComma(num) {
  var regexp = /\B(?=(\d{3})+(?!\d))/g;
//   return parseInt(num.toString().replace(regexp, ','));
  return parseInt(num).toString().replace(regexp,',');
}
</script>
<form id="pForm" name="pForm">
<input type="hidden" id="gridId" name="gridId">
</form>