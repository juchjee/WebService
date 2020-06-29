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
					          { view: "button", type: "round", label: "메뉴목록", click: "fn_moveMain();" }, 
					          { view: "button", type: "round", label: "조회", click: "fn_search();" }, 
						    ]
					    },
						{ view: 'form', scroll: false, height : 130,
							elements: [
								{ view: "combo", label: '거래처', id: "custCd", select:true, datatype:'json', url:"/mobile/scm/orderDelivery/mAgencyShipR/custCombo"},
// 								{ view: "combo", label: '사업장', id: "facCd", select:true, datatype:'json', url:'/mobile/scm/orderDelivery/mAgencyShipR/facCombo'},
								{ view: 'text', label: '주문일자' , type:'date', id: 'frDt' , value:date},
								{ view: 'text', label: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~' , type:'date', id: 'toDt' , value:date}
							], id: 'frmMain'
						},
						
						{ view: 'grid', datatype: 'json', id:'gridMain', select: true, scroll: "xy", height : h,
							fields: [
								{ width: 80 , label: '출하일자' 	, template: '#outDt#'  	, type: 'custom', align: 'center'},
								{ width: 110, label: '출고사업장'	, template: '#facNm#'	, type: 'custom', align: 'left'},
								{ width: 80 , label: '품목코드'	, template: '#itmCd#'	, type: 'custom', align: 'left'},
// 								{ width: 100, label: '품목명'		, template: '#itmNm#'	, type: 'custom', align: 'left'},
								{ width: 120, label: '현장명'		, template: '#fldNm#'	, type: 'custom', align: 'left'},
								{ width: 60	, label: '수량' , template: function(obj){
									var outQty = addComma(obj.outQty);
									return outQty;
								}, type: 'custom', align: 'right'},
							], header: true, keys : "outNo,outSq" //숨길 경우, keys에 등록
						},
					], id: 'agencyShip'
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
    
    //일자 시작일자는 해당 일의 1일로 설정
    var frDt = $$('frDt').getValue();
    $$('frDt').setValue(frDt.substring(0,8) + "01");
    
    $$("gridMain").attachEvent("onItemClick",function(id,ev,trg){
    	var id = $('#gridId').val(id);
    	var rId = $('#gridId').val();
    	var list = $$('gridMain').item(rId);

		if(list.itmCd == '') {
			return dhx.alert(fn_alert('선택된 품목이 없습니다.'));
		}
		var url = "/mobile/scm/orderDelivery/mAgencyShipDtlR.do?outNo=" + list.outNo + "?outSq=" + list.outSq 
// 				+ "?custCd=" + $$('custCd').getValue() + "?facCd=" + $$('facCd').getValue() + "?frDt=" + searchDate($$('frDt').getValue()) + "?toDt=" + searchDate($$('toDt').getValue());
				+ "?custCd=" + $$('custCd').getValue() + "?frDt=" + searchDate($$('frDt').getValue()) + "?toDt=" + searchDate($$('toDt').getValue());
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

function fn_setCustCd(){
	var obj = {};
	
	mobileAjax("/mobile/scm/orderDelivery/mAgencyShipR/custCombo",obj,function(data){
		var custCd = $$('custCd');
		custCd.define('datatype', 'json');
		custCd.define('data', data);
		custCd.adjust();
		custCd.refresh();
	});
}

function fn_moveMain() {
	location.assign("/mobile/scm/main/main.do");
}

function fn_search(){
	var obj = {};
	obj.frDt = searchDate($$('frDt').getValue(),"-");
	obj.toDt = searchDate($$('toDt').getValue(),"-");
	obj.custCd = $$('custCd').getValue();
// 	obj.facCd = $$('facCd').getValue();
	
	if((obj.frDt == "" ||obj.frDt == null || obj.frDt == undefined) || (obj.toDt == "" || obj.toDt == null || obj.toDt == undefined)){
		dhx.alert(fn_alert('주문일자를 입력하세요'));
		return;
	} else if(obj.custCd == "" ||obj.custCd == null || obj.custCd == undefined){
		dhx.alert(fn_alert('거래처코드는 필수입니다'));
		return;
	} 
// 	else if(obj.facCd == "" ||obj.facCd == null || obj.facCd == undefined){
// 		dhx.alert(fn_alert('사업장코드는 필수입니다'));
// 		return;
// 	} 
	else {
		var gridMain = $$('gridMain');
		dhx.extend(gridMain, dhx.OverlayBox);
		gridMain.showOverlay();
		
		mobileAjax("/mobile/scm/orderDelivery/mAgencyShipR/list",obj,function(data){
			search = "";	//조회 후 초기화
			gridMain.clearAll();
			gridMain.define('datatype', 'json');
			gridMain.define('data', data);
			gridMain.adjust();
			fn_searchCB(data);
			gridMain.refresh();
			gridMain.hideOverlay();
		});
	}
}

function fn_searchCB(data) {
	window.setTimeout(function() {
		$$('custCd').refresh();
// 		$$('facCd').refresh();
    }, 100)	//0.1초 [1초:1000]
}

function addComma(num) {
  var regexp = /\B(?=(\d{3})+(?!\d))/g;
  return parseInt(num).toString().replace(regexp,',');
}
</script>
<form id="pForm" name="pForm">
<input type="hidden" id="gridId" name="gridId">
</form>