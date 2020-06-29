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
var h = h-425;
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
					          { view: "button", type: "round", label: "마감진행", click: "fn_save();" }, 
						    ]
					    },
						{ view: 'form', scroll: false, height : 380,
							elements: [
								{ view: 'text', label: '구분'		, id: 'saleGubunNm'	, readonly:true},
								{ view: "text", label: '시공단계'	, id: "endChkNm"	, readonly:true},
								{ view: "text", label: '진행단계'  , id: "saleLevelNm"	, readonly:true},
								{ view: "text", label: '시공기간'	, id: "workDt"	, readonly:true},
// 								{ view: "text", label: '완료일자'	, id: "workTodt"	, readonly:true},
								{ view: 'text', label: '고객명'	, id: 'cusName'	, readonly:true},
								{ view: "text", label: '주소'		, id: "fldAddr"	, readonly:true},
								{ view: "text", label: '시공비매입', id: "buyAmt"	, readonly:true},
								{ view: "text", label: '추가내용'	, id: "expBcText"	, readonly:true},
								{ view: "text", label: '시공점의견'	, id: "siEndText"	, readonly:true},
								
								{ view: "text", label: '견적번호'	, id: "estNo"	, readonly:true},
								{ view: "text", label: '구분코드'	, id: "saleGubun"	, readonly:true},
								{ view: "text", label: '시작일자'	, id: "frDt"	, readonly:true},
								{ view: "text", label: '종료일자'	, id: "toDt"	, readonly:true},
								{ view: "text", label: '시공사'	, id: "custInfo", readonly:true},
								{ view: "text", label: '시공사'	, id: "custCd"	, readonly:true},
								{ view: "text", label: '시공사'	, id: "custNm"	, readonly:true},
								{ view: "text", label: '시공마감확인'	, id: "saleEndChk"	, readonly:true},
								{ view: "text", label: '시공비마감'	, id: "endChk"	, readonly:true},
							], id: 'frmMain'
						},
						{ view: 'grid', datatype: 'json', id:'gridMain', select: true, scroll: "xy", height : h,
							fields: [
								{ width: 70	, label: '구분'	, template: '#mainNm#', type: 'custom', align: 'left'},
								{ width: 90	, label: '공종'	, template: '#clhNm#' , type: 'custom', align: 'left'},
								{ width: 80, label: '시공비'	, template: function(obj){
									var basicAmt = addComma(obj.basicAmt);
									return basicAmt;
								}, type: 'custom', align: 'right'},
								{ width: 300, label: '내용'	, template: '#prcNm#' , type: 'custom', align: 'left'},
								{ width: 100, label: '비고'	, template: '#bigo#', type: 'custom', align: 'left'},
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
	location.assign("/mobile/scm/inusBath/mSigongFinishR.do" + "?frDt=" + $$('frDt').getValue() + "?toDt=" + $$('toDt').getValue() +"?custCd=" + $$('custCd').getValue());	
// 	location.assign("/mobile/scm/inusBath/mSigongFinishR.do" + "?frDt=" + $$('frDt').getValue() + "?toDt=" + $$('toDt').getValue() + "?custInfo=" + $$('custInfo').getValue() + "?custCd=" + $$('custCd').getValue() + "?custNm=" + $$('custNm').getValue());	
}


function fn_search(){
	var obj = {};
	obj.frDt =  $$('frDt').getValue();
	obj.toDt =  $$('toDt').getValue();
	obj.custCd =  $$('custCd').getValue();
	obj.estNo = $$('estNo').getValue();
	
	mobileAjax("/mobile/scm/inusBath/mSigongFinishR/list",obj,function(data){
		search = "";
		$$('custNm').setValue(data[0].custNm);
		$$('saleGubun').setValue(data[0].saleGubun);
		$$('saleGubunNm').setValue(data[0].saleGubunNm);
		$$('endChkNm').setValue(data[0].endChkNm);
		$$('saleLevelNm').setValue(data[0].saleLevelNm);
		var workDt = data[0].workFrdt.toString().substring(0,11) + " ~ " + data[0].workTodt.toString().substring(0,11);
		$$('workDt').setValue(workDt);
// 		$$('workFrdt').setValue(data[0].workFrdt.toString().substring(0,11));
// 		$$('workTodt').setValue(data[0].workTodt.toString().substring(0,11));
		$$('cusName').setValue(data[0].cusName);
		$$('fldAddr').setValue(data[0].fldAddr);
		$$('buyAmt').setValue(addComma(data[0].buyAmt));
		$$('expBcText').setValue(data[0].expBcText);
		$$('siEndText').setValue(data[0].siEndText);
		$$('saleEndChk').setValue(data[0].saleEndChk);
		$$('endChk').setValue(data[0].endChk);

		fn_searchCB(data[0].estNo);
	});
}


function fn_searchCB(estNo) {
	var gridMain = $$('gridMain');
	dhx.extend(gridMain, dhx.OverlayBox);
	gridMain.showOverlay();
	
	var obj = {};
	obj.estNo = estNo;
	
	if(estNo!=undefined) {
		mobileAjax("/mobile/scm/inusBath/mSigongFinishGrdDtlS/list",obj,function(data){
			gridMain.clearAll();
			gridMain.define('datatype', 'json');
			gridMain.define('data', data);
			gridMain.adjust();
			gridMain.refresh();
			gridMain.hideOverlay();
		});
	}
}

function addComma(num) {
  var regexp = /\B(?=(\d{3})+(?!\d))/g;
  return num.toString().replace(regexp, ',');
}

function fn_save(){
	//1) 시공비마감여부에 값이 있을 경우, 이미 진행중으로 여겨서 빈값만 UPDATE 처리되도록 메시지 처리
	//2) 구분[sale_gubun]이 오프라인[SDH42300]일 경우, 시공마감확인[sale_end_chk]이 '1'이어야만 SDA180 update 처리 (시공마감 확인이 체크되어 있다면)
	//3) 2번의 경우에 충족하지 않을 경우, [오프라인 구분의 자료는 시공마감에 체크되어야 마감 진행이 가능합니다] 메시지 처리
	//4) 애초에 오프라인이 아니면 바로 update 처리
	var obj = {};
	obj.estNo = $$('estNo').getValue();				//견적번호
	obj.saleGubun = $$('saleGubun').getValue();		//구분[SDH42]
	obj.saleEndChk = $$('saleEndChk').getValue();	//시공마감확인 [checkbox]
	obj.endChk = $$('endChk').getValue();			//시공비마감여부 [SDH41]
	if(obj.estNo == null || obj.estNo == undefined || obj.estNo == ""){
		dhx.alert(fn_alert('저장할 데이터가 없습니다.'));
		return;
	} else if(""!=obj.endChk) {	//시공비마감여부에 값이 있을 경우, 이미 진행중으로 여겨서 빈값만 update 처리되도록 메시지 처리
		dhx.alert(fn_alert('마감진행중입니다.'));
		return;
	} else if("SDH42300"==obj.saleGubun) {
		if("1"==obj.saleEndChk) {
			mobileAjax("/mobile/scm/inusBath/mSigonFinishDetailS/save",obj,fn_saveCB);	//마감진행
		} else {
			dhx.alert(fn_alert('오프라인 구분의 자료는 시공마감에 체크되어야 마감 진행이 가능합니다.'));
			return;
		}
	} else{
		mobileAjax("/mobile/scm/inusBath/mSigonFinishDetailS/save",obj,fn_saveCB);	//마감진행
	}
};

function fn_saveCB(data){
	var rtnCode = data.rtnCode;
	if(rtnCode!="1") {
		dhx.alert(fn_alert('오류가 발생했습니다.\n전산팀에 문의 바랍니다.'));
		return;
	} else {
		dhx.alert(fn_alert('저장되었습니다.'));
		fn_search();
	}
}
</script>
<form id="pForm" name="pForm">
<input type="hidden" id="gridId" name="gridId">
</form>