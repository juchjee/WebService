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
								{ view: 'text', label: '공사일자' , type:'date', id: 'frDt' , value:date},
								{ view: 'text', label: '&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;~' , type:'date', id: 'toDt' , value:date},
								{ view: "combo", label: '시공점', id: "custCd", select:true, datatype:'json', url:'/mobile/scm/inusBath/mSigongFinishR/combo'},
// 								{ view: "text", label: '시공점'  , id: "custInfo", readonly:true},
// 								{ view: "text", label: '시공점코드'	, id: "custCd", readonly:true},
// 								{ view: "text", label: '시공점명' 	, id: "custNm", readonly:true},
							], id: 'frmMain'
						},
						
						{ view: 'grid', datatype: 'json', id:'gridMain', select: true, scroll: "xy", height : h, 
							fields: [
								{ width: 80, label: '시공여부'	, template: function(obj) {
									var endChk = obj.endChk;
									var endChkNm = obj.endChkNm == null ? "" : obj.endChkNm;
									var tag = endChkNm;
									
									if("SDH4110"==endChk) {
										tag = "<div style='background-color:#ffffc0;'>"+ endChkNm + "</div>";
									} else if("SDH4120"==endChk){
										tag = "<div style='background-color:#c0ffc0;'>"+ endChkNm + "</div>";
									} else if("SDH4130"==endChk){
										tag = "<div style='background-color:#c0c0ff;'>"+ endChkNm + "</div>";
									}
									
									return tag;
								} , type: 'custom', align: 'center', id:'endChkNm'},
								{ width: 110, label: '고객명' , template: '#cusName#'  , type: 'custom', align: 'left'},
								{ width: 80	, label: '시공비매입' , template: function(obj){
									var buyAmt = addComma(obj.buyAmt);
									return buyAmt;
								}, type: 'custom', align: 'right'},
								{ width: 400, label: '주소'		, template: '#fldAddr#'	, type: 'custom', align: 'left'},
								{ width: 90, label: '견적번호'		, template: '#estNo#'		, type: 'custom', align: 'center'},
							], header: true,
						},
					], id: 'sigongFinish'
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
	} else {
		fn_setCustCd();
// 		fn_setCustInfo();
	}
    
    //일자 시작일자는 해당 일의 1일로 설정
    var frDt = $$('frDt').getValue();
    $$('frDt').setValue(frDt.substring(0,8) + "01");
    
    
    $$("gridMain").attachEvent("onItemClick",function(id,ev,trg){
    	var id = $('#gridId').val(id);
    	var rId = $('#gridId').val();
    	var list = $$('gridMain').item(rId);

		if(list.cusName == '') {
			return dhx.alert(fn_alert('선택된 고객이 없습니다.'));
		}
		var url = "/mobile/scm/inusBath/mSigongFinishGrdDtlS.do?frDt=" + $$('frDt').getValue() + "?toDt=" + $$('toDt').getValue() + "?custCd=" + $$('custCd').getValue() + "?estNo=" + list.estNo;
// 		var url = "/mobile/scm/inusBath/mSigongFinishGrdDtlS.do?frDt=" + $$('frDt').getValue() + "?toDt=" + $$('toDt').getValue() + "?custInfo=" + $$('custInfo').getValue() + "?custCd=" + $$('custCd').getValue() + "?custNm=" + $$('custNm').getValue() + "?estNo=" + list.estNo;
		location.assign(url);	//상세내역
	});
    
//     $$("frDt").attachEvent("onChange", function(id, ev, trg) {
//     	//20180921
//     	debugger;
//     });
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


//거래처코드 기준이 바뀌면서 미사용 (20180917)
function fn_setCustInfo() {
	mobileAjax("/mobile/scm/inusBath/mSigonFinishR/getUserInfo",null,function(data){
		var custCd = data.custCd;
		var custNm = data.custNm;
		
		$$('custInfo').setValue(custCd + " : " + custNm);
		$$('custCd').setValue(custCd);
		$$('custNm').setValue(custNm);
	});
}


function fn_setCustCd(){
	var obj = {};
	obj.frDt = searchDate($$('frDt').getValue(),"-");
	obj.toDt = searchDate($$('toDt').getValue(),"-");
	
	mobileAjax("/mobile/scm/inusBath/mSigongFinishR/combo",obj,function(data){
		var custCd = $$('custCd');
		custCd.define('datatype', 'json');
		custCd.define('data', data);
		custCd.adjust();
		custCd.refresh();
	});
}

function fn_search(){
	var obj = {};
	obj.frDt = searchDate($$('frDt').getValue(),"-");
	obj.toDt = searchDate($$('toDt').getValue(),"-");
	obj.custCd = $$('custCd').getValue();
	
	if((obj.frDt == "" ||obj.frDt == null || obj.frDt == undefined) || (obj.toDt == "" || obj.toDt == null || obj.toDt == undefined)){
		dhx.alert(fn_alert('공사일자를 입력하세요'));
		return;
	} else if(obj.custCd == "" ||obj.custCd == null || obj.custCd == undefined){
		dhx.alert(fn_alert('시공점코드는 필수입니다'));
		return;
	} else {
		var gridMain = $$('gridMain');
		dhx.extend(gridMain, dhx.OverlayBox);
		gridMain.showOverlay();
		
		mobileAjax("/mobile/scm/inusBath/mSigongFinishR/list",obj,function(data){
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
    }, 1000)	//0.1초 [1초:1000]
}

function addComma(num) {
  var regexp = /\B(?=(\d{3})+(?!\d))/g;
  return num.toString().replace(regexp, ',');
}
</script>
<form id="pForm" name="pForm">
<input type="hidden" id="gridId" name="gridId">
</form>