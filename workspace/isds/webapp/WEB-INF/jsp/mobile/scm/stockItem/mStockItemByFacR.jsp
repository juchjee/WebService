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
var openWin;	//새창
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
							  { view: "button", type: "round", label: "메뉴목록", click: "fn_moveMain();" }, 
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
								{ width: 120, label: '품목코드'	, template: function(obj) {
									//20181129 사용제한에 입력된 내역이 있으면 품목코드 빨간색 처리
									var itmCd = obj.itmCd == null ? "" : obj.itmCd;
									var chkEnd = obj.chkEnd == null ? "" : obj.chkEnd;
									var tag = itmCd;
									
									if(""!=chkEnd) {
										tag = "<div><font color='#ff0000'>"+ itmCd + "</font></div>";
									}
									
									return tag;
								} , type: 'custom', align: 'center'},
// 								{ width: 65	, label: '총합'		, template: '#tot#'		, type: 'custom', align: 'right'},
								{ width: 80	, label: '재고량'	, template: function(obj){
									var qty = addComma(obj.qty);
									return qty;
								}, type: 'custom', align: 'right'},
								{ width: 100, label: '창고'		, template: '#whNm#'	, type: 'custom', align: 'left'},
								{ width: 140, label: '품목명'	, template: '#itmNm#'	, type: 'custom', align: 'left'},
								{ width: 80, label: '사용제한', template: '#chkEndNm#'	, type: 'custom', align: 'center'},
							], header: true, keys : "chkEnd"
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

var search = "";
dhx.ready(function() {
	dhx.ui.fullScreen();
    dhx.ui(form); 
    
    var search = window.location.search;
    if(search) {
    	if(fn_setParam(search)) {
    		fn_search();
    	}
	}
    
    $$("gridMain").attachEvent("onItemClick",function(id,ev,trg){
    	var id = $('#gridId').val(id);
    	var rId = $('#gridId').val();
    	var list = $$('gridMain').item(rId);

		if(list.itmCd == '') {
			return dhx.alert(fn_alert('선택된 품목이 없습니다.'));
		}
		var url = "/mobile/scm/stockItem/mStockItemDetailR.do?stdDt=" + searchDate($$('stdDt').wg,"-") + "?schItmCd=" + list.itmCd + "?facCd=" + $$('facCd').getValue() + "?itmInfo=" + $$('itmInfo').getValue() + "?urlInfo=/mobile/scm/stockItem/mStockItemByFacR";
		location.assign(url);	//상세내역
	});
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

function fn_moveMain() {
	location.assign("/mobile/scm/main/main.do");
}

function fn_search(){
	var obj = {};
	obj.stdDt = searchDate($$('stdDt').wg,"-");
	obj.facCd = $$('facCd').getValue();
	obj.itmInfo = $$('itmInfo').getValue();
	
	if(obj.facCd == "" ||obj.facCd == null || obj.facCd == undefined){
		dhx.alert(fn_alert('사업장을 선택하세요'));
		return;
	} else {
		var gridMain = $$('gridMain');
		dhx.extend(gridMain, dhx.OverlayBox);
		gridMain.showOverlay();
		
		mobileAjax("/mobile/scm/stockItem/stockItemByFacR/list",obj,function(data){
			search = "";	//조회 후 초기화
			gridMain.clearAll();
			gridMain.define('datatype', 'json');
			gridMain.define('data', data);
			gridMain.adjust();
			//상단에 x,y에 대해 scroll이 지정되어 있으므로 별도로 안줘도 됨
//	 		gridMain.define('scroll', 'y');
//	 		gridMain.define('scroll', 'x');
			fn_searchCB(gridMain);
			gridMain.refresh();
			gridMain.hideOverlay();
		});
	}
}

function fn_searchCB(gridMain) {
	//20180831 ryul 품목코드 빈값 설정 주석처리
// 	var cnt = gridMain.dataCount();
// 	var befItmCd = "";
// 	var itmCd = "";
	
// 	for(var i=0; i < cnt; i++) {
// 		itmCd = "";
		
// 		if(i > 0) {
// 			befItmCd = gridMain.data.getIndexRange()[i-1].itmCd;
// 			itmCd = gridMain.data.getIndexRange()[i].itmCd;	
// 		}
		
// 		if((befItmCd == itmCd) && (befItmCd != "")) {
// 			gridMain.data.getIndexRange()[i].itmCd = "";
// 			gridMain.data.getIndexRange()[i].tot = "";
// 			befItmCd = itmCd;
// 		}
		
// 	}
	
	window.setTimeout(function() {
		$$('facCd').refresh();
// 		$$('facCd').setValue($$('facCd').getValue());
    }, 1000)	//0.1초 [1초:1000]
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
