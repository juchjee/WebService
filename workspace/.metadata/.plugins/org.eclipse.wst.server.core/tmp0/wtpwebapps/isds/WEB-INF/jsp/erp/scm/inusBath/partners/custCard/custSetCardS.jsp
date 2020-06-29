<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout;
var gridMain, gridSub;
var frfSub;
var selectList;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
var qtyFlag = 0;
$(document).ready(function(){
	//단품 고객 상담 카드 
	//조회, 신규, 한줄삭제, 저장, 엑셀, 인쇄, 종료
	Ubi.setContainer(2,[1,2,3,4,8,9],"2U"); //고객상담카드등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
    layout.cells("b").attachObject("schContainer");
    
	subLayout.cells("a").showHeader()
    subLayout.cells("a").setText("고객상담내역")
    subLayout.cells("a").setWidth(500);	//주소지까지만 보이도록 조정
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"No"		, colId:"seq"				, width:"40"	, height:"20"	, align:"center"	, type:"ron"});
    gridMain.addHeader({name:"상담일자"	, colId:"sdDt"				, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"고객명"		, colId:"custNm"			, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"연락처"		, colId:"custTel"			, width:"100"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"주소지"		, colId:"custAddr"			, width:"200"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"고객구분"	, colId:"custGubunNm"		, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"상담구분"	, colId:"sdGubunNm"			, width:"120"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"현장유형"	, colId:"siteTypeNm"		, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"엘리베이터"	, colId:"siteElevatorNm"	, width:"70"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"공사유형"	, colId:"constructTypeNm"	, width:"100"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"해피콜확인"	, colId:"callStatNm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"고객진행상태"	, colId:"custStatNm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"실측요청일자"	, colId:"requestDt"			, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
//     gridMain.addHeader({name:"#cspan"	, colId:"requestTimeDivNm"	, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"시공희망일자"	, colId:"sigongDt"			, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"시공유형"	, colId:"typeChkNm"			, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"주거유형"	, colId:"lifeTypeNm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"현재욕실정보"	, colId:"preBathQtyNm"		, width:"50"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"preBathType1Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"preBathType2Nm"	, width:"70"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"preBathType3Nm"	, width:"60"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"preBathType4Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"preBathType5Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"요청욕실정보"	, colId:"reqBathQtyNm"		, width:"50"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"reqBathType1Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"reqBathType2Nm"	, width:"70"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"reqBathType3Nm"	, width:"60"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"reqBathType4Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"reqBathType5Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"유입경로"	, colId:"inputRouteNm"		, width:"80"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"가격타입"	, colId:"costType1Nm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"costType2Nm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"욕실스타일"	, colId:"bathStyle1Nm"		, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"bathStyle2Nm"		, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"상담내용"	, colId:"consultCont"		, width:"140"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"상담자"		, colId:"empNm"				, width:"100"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"정보활용동의"	, colId:"infoAgreYnNm"		, width:"75"	, height:"20"	, align:"center"	, type:"ro"});
    
    gridMain.attachHeader("#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,수량,욕조,파티션,샤워부스,없음,기타,수량,욕조,파티션,샤워부스,없음,기타,#rspan,거실,부부,거실,부부,#rspan,#rspan,#rspan");
    
    gridMain.setUserData("","pk","ordNo");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["ordNo","empNo","custGubun","sdGubun","siteType","siteTypeEtc","siteElevator","preBathQty","reqBathQty","inputRoute","costType1","costType2","bathStyle1","bathStyle2","requestTimeDiv","requestHour","requestMin","custStat", "callStat","saleCode", "preBathType1","preBathType2","preBathType3","preBathType4","preBathType5","preBathTypeEtc","reqBathType1","reqBathType2","reqBathType3","reqBathType4","reqBathType5","reqBathTypeEtc","custCd","custSalNm","lifeType","infoAgreYn","callStat","constructType","typeChk","lifeTypeEtc","sdGubunEtc","requestTimeDiv"]);
    gridMain.attachEvent("onRowSelect",doCopyGridToFreeForm);
    
    subLayout.cells("b").showHeader()
    subLayout.cells("b").setText("고객상담상세내역")
    subLayout.cells("b").attachObject("bootContainer");
    
    calMain = new dhtmlXCalendarObject([{input:"sdFrDt",button:"calpicker1"},{input:"sdToDt",button:"calpicker2"},{input:"schSdDt",button:"calpicker3"}
                                       ,{input:"sdDt",button:"calpicker4"},{input:"requestDt",button:"calpicker5"},{input:"sigongDt",button:"calpicker6"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	
	var nowDate = new Date();
	var BefDate = nowDate.setDate(nowDate.getDate()-30);	//30일 전
	var t = dateformat(new Date());
	var legSetDate = new Date();
	
	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth() + 1)+'/'+fn_day(legSetDate.getDate());	//오늘
	var befMonth = nowDate.getFullYear() + '/' + fn_month(nowDate.getMonth() + 1)+'/'+fn_day(nowDate.getDate());	//30일 전
	
	$('#schSdDt').val(t);
	$('#sdFrDt').val(befMonth);
	$('#sdToDt').val(legDate);
	
	//사용자 정보 get 해와서 재직여부가 N일 경우, 메뉴 닫기 실행
	//재직중일 경우, id와 nm을 상담자에 셋팅
	doSetScmUserInfo();
	
	//콤보박스 설정
	var param = {};
    param.mainCd = "AS500";
    gfn_baseCd_comboLoadOption(param, "custGubun", "baseCdSearch", "", "선택", fn_returnComboList);

//     param.mainCd = "AS501";
	param.mainCd = "AS518";	//세트/구매별 상담구분
    gfn_baseCd_comboLoadOption(param, "sdGubun", "baseCdSearch", "", "선택", fn_returnComboList);

    param.mainCd = "AS502";
    gfn_baseCd_comboLoadOption(param, "siteType", "baseCdSearch", "", "선택", fn_returnComboList);

    param.mainCd = "AS503";
    gfn_baseCd_comboLoadOption(param, "preBathQty", "baseCdSearch", "Y", "", fn_returnComboList);
    gfn_baseCd_comboLoadOption(param, "reqBathQty", "baseCdSearch", "Y", "", fn_returnComboList);
    
    param.mainCd = "AS505";
    gfn_baseCd_comboLoadOption(param, "costType1", "baseCdSearch", "Y", "", fn_returnComboList);
    gfn_baseCd_comboLoadOption(param, "costType2", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "AS506";
    gfn_baseCd_comboLoadOption(param, "inputRoute", "baseCdSearch", "", "선택", fn_returnComboList);

    param.mainCd = "AS507";
    gfn_baseCd_comboLoadOption(param, "callStat", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "AS508";
    gfn_baseCd_comboLoadOption(param, "bathStyle1", "baseCdSearch", "Y", "", fn_returnComboList);
    gfn_baseCd_comboLoadOption(param, "bathStyle2", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "SD613";
    gfn_baseCd_comboLoadOption(param, "requestHour", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "SD614";
    gfn_baseCd_comboLoadOption(param, "requestMin", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "AS509";
    gfn_baseCd_comboLoadOption(param, "constructType", "baseCdSearch", "Y", "선택", fn_returnComboList);
    
    param.mainCd = "AS510";
    gfn_baseCd_comboLoadOption(param, "typeChk", "baseCdSearch", "Y", "선택", fn_returnComboList);
    
    param.mainCd = "AS511";
    gfn_baseCd_comboLoadOption(param, "custStat", "baseCdSearch", "Y", "선택", fn_returnComboList);
    
    param.mainCd = "AS513";
    gfn_baseCd_comboLoadOption(param, "requestTimeDiv", "baseCdSearch", "Y", "", fn_returnComboList);
    
    param.mainCd = "AS514";
    gfn_baseCd_comboLoadOption(param, "lifeType", "baseCdSearch", "Y", "선택", fn_returnComboList);

    param.mainCd = "AS515";
    gfn_baseCd_comboLoadOption(param, "infoAgreYn", "baseCdSearch", "Y", "선택", fn_returnComboList);
    
    $('#schCustCd').focus();	//판매채널 조회조건 포커싱
    document.getElementById("preBathType5").onchange();
    document.getElementById("reqBathType5").onchange();
    document.getElementById("lifeType").onchange();
});

function fn_month(month){
	if(month == 0){
		month = 12;
	}
	if(month < 10){
		month = '0'+month;
     }
	return month;
};

function fn_day(day){
	if(day < 10){
		day = '0'+day;
     }
	return day;
};

function fn_returnComboList(data){
	selectList=data;
};

function doSetScmUserInfo() {
	gfn_callAjax("","/erp/scm/inusBath/partners/custCard/loginUserInfoSearch",doSetScmUserInfoCB);
}

function doSetScmUserInfoCB(data) {
	var empNo = data[0].empNo;
	var empNm = data[0].empNm;
	$('#schEmpNo').val(empNo);
	$('#schEmpNm').val(empNm);
}

//팝업 반환 데이터
function fn_onClosePop(pName,data){
   if(pName == "schEmpNo"){
	   $('#schEmpNo').val(data[0].empNo);
	   $('#schEmpNm').val(data[0].empNm);
	   $('#schEmpNo').focus();
	} 
   if(pName == "schCustCd"){
	   $('#schCustCd').val(data[0].custCd);
	   $('#schCustSalNm').val(data[0].custNm);
	   $('#schCustCd').focus();
	} 
   if(pName == "empNo"){
	   $('#empNo').val(data[0].empNo);
	   $('#empNm').val(data[0].empNm);
	   $('#empNo').focus();
	} 
};

//빈값일 경우, 초기화
function doOnValueChangedSearch(div) {
   var schEmpNo = $('#schEmpNo').val();
   var schCustCd = $('#schCustCd').val();
   var empNo = $('#empNo').val();
   var saleCode = $('#saleCode').val();

   if(div.id=="schEmpNo" && schEmpNo=="") {
	   $('#schEmpNo').val("");
	   $('#schEmpNm').val("");   
   }

   if(div.id=="schCustCd" && schCustCd=="") {
	   $('#schCustCd').val("");
	   $('#schCustSalNm').val("");   
   }
   
   if(div.id=="empNo" && empNo=="") {
	   $('#empNo').val("");
	   $('#empNm').val("");
   }
}

function doEtcEnable(div) {
   var preBathType5 = $('input:checkbox[id="preBathType5"]').is(':checked');
   var reqBathType5 = $('input:checkbox[id="reqBathType5"]').is(':checked');
   var lifeType = $('#lifeType').val();
   var sdGubun = $('#sdGubun').val();
   
   if(div.id=="preBathType5") {
	   document.getElementById("preBathTypeEtc").disabled = preBathType5 == true ? false : true;
	   $('#preBathTypeEtc').val("");
   } else if(div.id=="reqBathType5") {
	   document.getElementById("reqBathTypeEtc").disabled = reqBathType5 == true ? false : true;
	   $('#reqBathTypeEtc').val("");
   } else if(div.id=="lifeType") {
	   document.getElementById("lifeTypeEtc").disabled = lifeType == "AS514500" ? false : true;
	   $('#lifeTypeEtc').val("");
   } else if(div.id == "sdGubun") {
	   document.getElementById("sdGubunEtc").disabled = sdGubun == "AS518200" ? false : true;
	   $('#sdGubunEtc').val("");
   }
}

//조회
function fn_search(div){
	//저장이 아닐 경우, 고객/주문번호 초기화
	if("save"!=div) {
		$('#schOrdNo').val("");
	}
	
	var obj = {};
	obj.sdFrDt = searchDate($('#sdFrDt').val());	//상담기간(시작)
	obj.sdToDt = searchDate($('#sdToDt').val());	//상담기간(종료)
	obj.empNo = $('#schEmpNo').val();			//상담자
	obj.ordNo = $('#schOrdNo').val();			//고객/주문번호
	obj.custNm = $('#schCustNm').val();			//고객명
	obj.schSdDt = searchDate($('#schSdDt').val());	//상담일자
	obj.custCd = $('#schCustCd').val();			//판매채널[schCustCd]
	
	//S 필수값체크
	if(obj.sdFrDt == "" || obj.sdToDt == "") {
		MsgManager.alertMsg("WRN001","상담기간");	//{0}은(는) 필수입력 항목입니다.
		return false;
	}
	
	if(obj.empNo =="") {
		MsgManager.alertMsg("WRN001","상담자");	//{0}은(는) 필수입력 항목입니다.
		return false;
	}
	
	if(obj.schSdDt =="") {
		MsgManager.alertMsg("WRN001","상담일자");	//{0}은(는) 필수입력 항목입니다.
		return false;
	}

	if(obj.custCd =="") {
		MsgManager.alertMsg("WRN001","판매채널");	//{0}은(는) 필수입력 항목입니다.
		return false;
	}
	//E 필수값체크
	fn_new("all");	//프리폼 초기화
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"), doCopyGridToFreeForm);
};

//grid의 값을 freeform으로 이동 (rowSelectEvent)
function doCopyGridToFreeForm() {
	fn_new("all");	//초기화
	var cnt = gridMain.getRowsNum();
	var idx = gridMain.getSelectedRowId();
	var rId = idx > 0 ? idx : 1;  
	
	if(cnt > 0) {
		//첫번째 row의 값을 가져온다.
		var obj1 = {};
		obj1.sdDt = gridMain.setCells(rId, gridMain.getColIndexById('sdDt')).getValue();
		obj1.empNo = gridMain.setCells(rId, gridMain.getColIndexById('empNo')).getValue();
		obj1.empNm = gridMain.setCells(rId, gridMain.getColIndexById('empNm')).getValue();
		obj1.ordNo = gridMain.setCells(rId, gridMain.getColIndexById('ordNo')).getValue();
		obj1.custCd = gridMain.setCells(rId, gridMain.getColIndexById('custCd')).getValue();
		obj1.custSalNm = gridMain.setCells(rId, gridMain.getColIndexById('custSalNm')).getValue();
		obj1.custGubun = gridMain.setCells(rId, gridMain.getColIndexById('custGubun')).getValue();
		obj1.sdGubunEtc = gridMain.setCells(rId, gridMain.getColIndexById('sdGubunEtc')).getValue();
		obj1.sdGubun = gridMain.setCells(rId, gridMain.getColIndexById('sdGubun')).getValue();
		obj1.custNm = gridMain.setCells(rId, gridMain.getColIndexById('custNm')).getValue();
		obj1.custTel = gridMain.setCells(rId, gridMain.getColIndexById('custTel')).getValue();
		obj1.custAddr = gridMain.setCells(rId, gridMain.getColIndexById('custAddr')).getValue();
		obj1.inputRoute = gridMain.setCells(rId, gridMain.getColIndexById('inputRoute')).getValue();
		obj1.siteType = gridMain.setCells(rId, gridMain.getColIndexById('siteType')).getValue();
		obj1.siteElevator = gridMain.setCells(rId, gridMain.getColIndexById('siteElevator')).getValue();
		obj1.constructType = gridMain.setCells(rId, gridMain.getColIndexById('constructType')).getValue();
		obj1.typeChk = gridMain.setCells(rId, gridMain.getColIndexById('typeChk')).getValue();
		obj1.preBathQty = gridMain.setCells(rId, gridMain.getColIndexById('preBathQty')).getValue();
		obj1.preBathType1 = gridMain.setCells(rId, gridMain.getColIndexById('preBathType1')).getValue();
		obj1.preBathType2 = gridMain.setCells(rId, gridMain.getColIndexById('preBathType2')).getValue();
		obj1.preBathType3 = gridMain.setCells(rId, gridMain.getColIndexById('preBathType3')).getValue();
		obj1.preBathType4 = gridMain.setCells(rId, gridMain.getColIndexById('preBathType4')).getValue();
		obj1.preBathType5 = gridMain.setCells(rId, gridMain.getColIndexById('preBathType5')).getValue();
		obj1.preBathTypeEtc = gridMain.setCells(rId, gridMain.getColIndexById('preBathTypeEtc')).getValue();
		obj1.reqBathQty = gridMain.setCells(rId, gridMain.getColIndexById('reqBathQty')).getValue();
		obj1.reqBathType1 = gridMain.setCells(rId, gridMain.getColIndexById('reqBathType1')).getValue();
		obj1.reqBathType2 = gridMain.setCells(rId, gridMain.getColIndexById('reqBathType2')).getValue();
		obj1.reqBathType3 = gridMain.setCells(rId, gridMain.getColIndexById('reqBathType3')).getValue();
		obj1.reqBathType4 = gridMain.setCells(rId, gridMain.getColIndexById('reqBathType4')).getValue();
		obj1.reqBathType5 = gridMain.setCells(rId, gridMain.getColIndexById('reqBathType5')).getValue();
		obj1.reqBathTypeEtc = gridMain.setCells(rId, gridMain.getColIndexById('reqBathTypeEtc')).getValue();
		obj1.custStat = gridMain.setCells(rId, gridMain.getColIndexById('custStat')).getValue();
		obj1.requestDt = gridMain.setCells(rId, gridMain.getColIndexById('requestDt')).getValue();
		obj1.requestTimeDiv = gridMain.setCells(rId, gridMain.getColIndexById('requestTimeDiv')).getValue();
		obj1.requestHour = gridMain.setCells(rId, gridMain.getColIndexById('requestHour')).getValue();
		obj1.requestMin = gridMain.setCells(rId, gridMain.getColIndexById('requestMin')).getValue();
		obj1.sigongDt = gridMain.setCells(rId, gridMain.getColIndexById('sigongDt')).getValue();
		obj1.costType1 = gridMain.setCells(rId, gridMain.getColIndexById('costType1')).getValue();
		obj1.costType2 = gridMain.setCells(rId, gridMain.getColIndexById('costType2')).getValue();
		obj1.bathStyle1 = gridMain.setCells(rId, gridMain.getColIndexById('bathStyle1')).getValue();
		obj1.bathStyle2 = gridMain.setCells(rId, gridMain.getColIndexById('bathStyle2')).getValue();
		obj1.callStat = gridMain.setCells(rId, gridMain.getColIndexById('callStat')).getValue();
		obj1.infoAgreYn = gridMain.setCells(rId, gridMain.getColIndexById('infoAgreYn')).getValue();
		obj1.lifeType = gridMain.setCells(rId, gridMain.getColIndexById('lifeType')).getValue();
		obj1.lifeTypeEtc = gridMain.setCells(rId, gridMain.getColIndexById('lifeTypeEtc')).getValue();
		obj1.consultCont = gridMain.setCells(rId, gridMain.getColIndexById('consultCont')).getValue();

		//가져온 값을 freeform으로 복사해준다. - 인덱스 : realIdx
		doCopyVal(obj1);
	}
}


//row별 데이터를 복사
function doCopyVal(obj) {
	$('#ordNo').val(obj.ordNo);
	$('#sdDt').val(obj.sdDt);
	$('#empNo').val(obj.empNo);
	$('#empNm').val(obj.empNm);
	$('#custCd').val(obj.custCd);
	$('#custSalNm').val(obj.custSalNm);
	$('#custGubun').val(obj.custGubun);
	$('#sdGubun').val(obj.sdGubun);
	document.getElementById("sdGubun").onchange();
	$('#sdGubunEtc').val(obj.sdGubunEtc);
	$('#custNm').val(obj.custNm);
	$('#custTel').val(obj.custTel);
	$('#custAddr').val(obj.custAddr);
	$('#inputRoute').val(obj.inputRoute);
	$('#siteType').val(obj.siteType);
	$('#siteElevator').val(obj.siteElevator);
	$('#constructType').val(obj.constructType);
	$('#typeChk').val(obj.typeChk);
	$('#preBathQty').val(obj.preBathQty);
	document.getElementById("preBathType1").checked = JSON.parse(obj.preBathType1);
	document.getElementById("preBathType2").checked = JSON.parse(obj.preBathType2);
	document.getElementById("preBathType3").checked = JSON.parse(obj.preBathType3);
	document.getElementById("preBathType4").checked = JSON.parse(obj.preBathType4);
	document.getElementById("preBathType5").checked = JSON.parse(obj.preBathType5);
	document.getElementById("preBathType5").onchange();
	$('#preBathTypeEtc').val(obj.preBathTypeEtc);
	$('#reqBathQty').val(obj.reqBathQty);
	document.getElementById("reqBathType1").checked = JSON.parse(obj.reqBathType1); 
	document.getElementById("reqBathType2").checked = JSON.parse(obj.reqBathType2);
	document.getElementById("reqBathType3").checked = JSON.parse(obj.reqBathType3);
	document.getElementById("reqBathType4").checked = JSON.parse(obj.reqBathType4);
	document.getElementById("reqBathType5").checked = JSON.parse(obj.reqBathType5);
	document.getElementById("reqBathType5").onchange();
	$('#reqBathTypeEtc').val(obj.reqBathTypeEtc);
	$('#custStat').val(obj.custStat);
	$('#requestDt').val(obj.requestDt);
	$('#requestTimeDiv').val(obj.requestTimeDiv);
	$('#requestHour').val(obj.requestHour);
	$('#requestMin').val(obj.requestMin);
	$('#sigongDt').val(obj.sigongDt);
	$('#costType1').val(obj.costType1);
	$('#costType2').val(obj.costType2);
	$('#bathStyle1').val(obj.bathStyle1);
	$('#bathStyle2').val(obj.bathStyle2);
	$('#callStat').val(obj.callStat);
	$('#infoAgreYn').val(obj.infoAgreYn);
	$('#lifeType').val(obj.lifeType);
	document.getElementById("lifeType").onchange();
	$('#lifeTypeEtc').val(obj.lifeTypeEtc);
	$('#consultCont').val(obj.consultCont);
}


//신규 (프리폼 초기화)
function fn_new(div){
	//all은 전체 초기화
	if("all"==div) {
		$('#sdDt').val("");
		$('#empNo').val("");
		$('#empNm').val("");
		$('#custCd').val("");
		$('#custSalNm').val("");
	} else {
		var schSdDt = searchDate($('#schSdDt').val());
		var schEmpNo = $('#schEmpNo').val();
		var custCd = $('#schCustCd').val();
		
		if((schSdDt == null || schSdDt == "") || (schEmpNo == null || schEmpNo == "")) {
			dhtmlx.alert("조회조건에 상담일과 상담자를 입력 후\n진행해주시기 바랍니다.");
			return true;
		}
		
		$('#sdDt').val(schSdDt);
		$('#empNo').val(schEmpNo);
		$('#empNm').val($('#schEmpNm').val());
		$('#custCd').val(custCd);
		$('#custSalNm').val($('#schCustSalNm').val());
	}
	
	$('#ordNo').val("");
	$('#custGubun').val("");
	$('#sdGubun').val("");
	$('#sdGubunEtc').val("");
	document.getElementById("sdGubun").onchange();
	$('#custNm').val("");
	$('#custTel').val("");
	$('#custAddr').val("");
	$('#inputRoute').val("");
	$('#siteType').val("");
	$('#siteElevator').val("");
	$('#constructType').val("");
	$('#typeChk').val("");
	$('#preBathQty').val("");
	$("input:checkbox[name='preBathType1']").removeAttr("checked");
	$("input:checkbox[name='preBathType2']").removeAttr("checked");
	$("input:checkbox[name='preBathType3']").removeAttr("checked");
	$("input:checkbox[name='preBathType4']").removeAttr("checked");
	$("input:checkbox[name='preBathType5']").removeAttr("checked");
	$('#preBathTypeEtc').val("");
	document.getElementById("preBathType5").onchange();
	$('#reqBathQty').val("");
	$("input:checkbox[name='reqBathType1']").removeAttr("checked");
	$("input:checkbox[name='reqBathType2']").removeAttr("checked");
	$("input:checkbox[name='reqBathType3']").removeAttr("checked");
	$("input:checkbox[name='reqBathType4']").removeAttr("checked");
	$("input:checkbox[name='reqBathType5']").removeAttr("checked");
	$('#reqBathTypeEtc').val("");
	document.getElementById("reqBathType5").onchange();
	$('#custStat').val("");
	$('#requestDt').val("");
	$('#requestTimeDiv').val("");
	$('#requestHour').val("");
	$('#requestMin').val("");
	$('#sigongDt').val("");
	$('#costType1').val("");
	$('#costType2').val("");
	$('#bathStyle1').val("");
	$('#bathStyle2').val("");
	$('#callStat').val("");
	$('#infoAgreYn').val("");
	$('#lifeType').val("");
	$('#lifeTypeEtc').val("");
	document.getElementById("lifeType").onchange();
	$('#consultCont').val("");
}

//저장
function fn_save(div){
	//저장하시겠습니까? 체크
	//상담일자 / 실측요청일자 / 시공희망일자 날짜 맞는지 확인 후 저장 처리
	var msg = "";
	var sdDt = searchDate($('#sdDt').val());
	var requestDt = searchDate($('#requestDt').val());
	var sigongDt = searchDate($('#sigongDt').val());
	
	if(sdDt!="") {
		msg += "상담날짜 : " + sdDt;
	}
	
	if(requestDt!="") {
		msg += "\n실측요청일자 : " + requestDt;
	}
	
	if(sigongDt!="") {
		msg += "\n시공희망일자 : " + sigongDt;
	}
	
	msg += "\n위와 같이 저장하시겠습니까?";
	
	if(MsgManager.confirmMsg("WRN020", msg)){
		var obj = {};
		obj.sdDt = $('#sdDt').val();
		obj.empNo = $('#empNo').val();
		obj.empNm = $('#empNm').val();
		obj.ordNo = $('#ordNo').val();
		obj.custCd = $('#custCd').val();
		obj.custSalNm = $('#custSalNm').val();
		obj.custGubun = $('#custGubun').val();
		obj.sdGubun = $('#sdGubun').val();
		obj.sdGubunEtc = $('#sdGubunEtc').val();
		obj.custNm = $('#custNm').val();
		obj.custTel = $('#custTel').val();
		obj.custAddr = $('#custAddr').val();
		obj.inputRoute = $('#inputRoute').val();
		obj.siteType = $('#siteType').val();
		obj.siteElevator = $('#siteElevator').val();
		obj.constructType = $('#constructType').val();
		obj.typeChk = $('#typeChk').val();
		obj.custStat = $('#custStat').val();
		obj.requestDt = $('#requestDt').val();
		obj.requestTimeDiv = $('#requestTimeDiv').val();
		obj.requestHour = $('#requestHour').val();
		obj.requestMin = $('#requestMin').val();
		obj.sigongDt = $('#sigongDt').val();
		obj.costType1 = $('#costType1').val();
		obj.costType2 = $('#costType2').val();
		obj.bathStyle1 = $('#bathStyle1').val();
		obj.bathStyle2 = $('#bathStyle2').val();
		obj.callStat = $('#callStat').val();
		obj.infoAgreYn = $('#infoAgreYn').val();
		obj.lifeType = $('#lifeType').val();
		obj.lifeTypeEtc = $('#lifeTypeEtc').val();
		obj.consultCont = $('#consultCont').val();

		obj.preBathQty = $('#preBathQty').val();
		obj.preBathType1 = $('input:checkbox[id="preBathType1"]').is(':checked');
		obj.preBathType2 = $('input:checkbox[id="preBathType2"]').is(':checked');
		obj.preBathType3 = $('input:checkbox[id="preBathType3"]').is(':checked');
		obj.preBathType4 = $('input:checkbox[id="preBathType4"]').is(':checked');
		obj.preBathType5 = $('input:checkbox[id="preBathType5"]').is(':checked');
		obj.preBathTypeEtc = $('#preBathTypeEtc').val();
		
		obj.reqBathQty = $('#reqBathQty').val();
		obj.reqBathType1 = $('input:checkbox[id="reqBathType1"]').is(':checked'); 
		obj.reqBathType2 = $('input:checkbox[id="reqBathType2"]').is(':checked');  
		obj.reqBathType3 = $('input:checkbox[id="reqBathType3"]').is(':checked');  
		obj.reqBathType4 = $('input:checkbox[id="reqBathType4"]').is(':checked');  
		obj.reqBathType5 = $('input:checkbox[id="reqBathType5"]').is(':checked');  
		obj.reqBathTypeEtc = $('#reqBathTypeEtc').val();
		
		//S 필수값체크[상담일자, 상담자, 판매채널, 고객구분, 상담구분, 고객명, 주소지, 연락처, 유입경로, 현장유형, 공사유형, 시공유형, 고객진행상태, 주거유형, 고객정보활용동의여부]
		if(obj.sdDt =="") {
			MsgManager.alertMsg("WRN001","상담일자");	//{0}은(는) 필수입력 항목입니다.
			return true;
		}
		if(obj.empNo =="") {
			MsgManager.alertMsg("WRN001","상담자");	//{0}은(는) 필수입력 항목입니다.
			return true;
		}
		if(obj.custCd =="") {
			MsgManager.alertMsg("WRN001","판매채널");	//{0}은(는) 필수입력 항목입니다.
			return true;
		}
	 	if(obj.custGubun =="") {
	 		MsgManager.alertMsg("WRN001","고객구분");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
	 	if(obj.sdGubun =="") {
			MsgManager.alertMsg("WRN001","상담구분");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
		if(obj.custNm =="") {
			MsgManager.alertMsg("WRN001","고객명");	//{0}은(는) 필수입력 항목입니다.
			return true;
		}
	 	if(obj.custTel =="") {
	 		MsgManager.alertMsg("WRN001","연락처");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
	 	if(obj.custAddr =="") {
	 		MsgManager.alertMsg("WRN001","주소지");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
	 	if(obj.inputRoute =="") {
	 		MsgManager.alertMsg("WRN001","유입경로");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
	 	if(obj.siteType =="") {
	 		MsgManager.alertMsg("WRN001","현장유형");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
	 	if(obj.constructType =="") {
	 		MsgManager.alertMsg("WRN001","공사유형");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
	 	if(obj.typeChk =="") {
	 		MsgManager.alertMsg("WRN001","시공유형");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
	 	if(obj.custStat =="") {
	 		MsgManager.alertMsg("WRN001","고객진행상태");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
	 	if(obj.lifeType =="") {
	 		MsgManager.alertMsg("WRN001","주거유형");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
	 	if(obj.infoAgreYn =="") {
	 		MsgManager.alertMsg("WRN001","고객정보활용동의여부");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
		//E 필수값체크
		
		//S - null 처리
		obj.site_elevator = obj.site_elevator == "" ? null : obj.site_elevator;
		obj.request_dt = obj.request_dt == "" ? null : obj.request_dt;
		obj.request_time_div = obj.request_time_div == "" ? null : obj.request_time_div;
		obj.request_hour = obj.request_hour == "" ? null : obj.request_hour;
		obj.request_min = obj.request_min == "" ? null : obj.request_min;
		obj.sigong_dt = obj.sigong_dt == "" ? null : obj.sigong_dt;
		obj.cost_type1 = obj.cost_type1 == "" ? null : obj.cost_type1;
		obj.cost_type2 = obj.cost_type2 == "" ? null : obj.cost_type2;
		obj.bath_style1 = obj.bath_style1 == "" ? null : obj.bath_style1;
		obj.bath_style2 = obj.bath_style2 == "" ? null : obj.bath_style2;
		obj.call_stat = obj.call_stat == "" ? null : obj.call_stat;
		obj.pre_bath_qty = obj.pre_bath_qty == "" ? null : obj.pre_bath_qty;
		obj.pre_bath_type_etc = obj.pre_bath_type_etc == "" ? null : obj.pre_bath_type_etc;
		obj.req_bath_qty = obj.req_bath_qty == "" ? null : obj.req_bath_qty;
		obj.req_bath_type_etc = obj.req_bath_type_etc == "" ? null : obj.req_bath_type_etc;
		obj.life_type_etc = obj.life_type_etc == "" ? null : obj.life_type_etc;
		obj.consult_cont = obj.consult_cont == "" ? null : obj.consult_cont;
		//E - null 처리
		
		//저장 서브미션 호출
	 	gfn_callAjaxForGridR(gridMain,obj,"gridMainSave",subLayout.cells("a"), fn_saveCB);
	}else{
		return false;
	}
};


function fn_saveCB(data){
	var rtnCode = data.rtnCode;
	var ordNo = data.ordNo;
	
	if(rtnCode!="1") {
		MsgManager.alertMsg("WRN021");	//오류가 발생했습니다.\n전산팀에 문의 바랍니다.
		return;
	} else {
		$('#schOrdNo').val(ordNo);
// 		dhtmlx.alert("저장 되었습니다.");
		fn_search("save");
	}
};

//삭제[fn_remove], 한줄삭제[fn_delete]
function fn_remove() {
	if(MsgManager.confirmMsg("INF002")){
		//1. 선택된 고객/주문번호가 있는지 확인
		//2. 삭제 서브미션 호출
		var ordNo = $('#ordNo').val();
		
		if(ordNo == null || ordNo == ""){
			dhtmlx.alert("삭제할 항목이 없습니다.");
			return true;
		} else {
			var obj = {};
			obj.ordNo = ordNo;
			
			gfn_callAjaxComm(obj,"delGridMain",fn_removeCB);
		}	
	}else{
		return true;
	}
};

//삭제함수
function fn_removeCB(data){
	var rtnCode = data.rtnCode;	//0 : 삭제 시에 SDH100 테이블에 동일한 고객/주문번호가 있는 데이터, 1 : 성공, -1: 실패
	
	if(rtnCode=="-1") {
		MsgManager.alertMsg("WRN021");	//오류가 발생했습니다.\n전산팀에 문의 바랍니다.
		return;
	} else if(rtnCode=="0") {
		MsgManager.alertMsg("INF011","삭제");	//실측진행건이 존재하므로 {0}할 수 없습니다.
		return;
	} else {
		fn_search();
	}
};


//인쇄
function fn_print(){
	//출력물 프로시져 파라미터 : 고객/주문번호
	var ordNo = $('#ordNo').val();	//고객/주문번호 - freeform
	
	if(ordNo == null || ordNo == "") {	//공장코드 필수 체크
		dhtmlx.alert("출력할 항목이 없습니다.");
		return true;
	} else{
		var url = "/erp/scm/inusBath/partners/custCard/custSetCardS/report/reportSch.do";
		url = url + "?ordNo=" + $('#ordNo').val();
		window.open(url,'rpt', '');
	}
};

//종료
function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};


//연락처 입력 시, 숫자만 남도록
function doChkNum() {
	var custTel = $('#custTel').val();
	custTel = custTel.replace(/[^0-9]/g,"");	//숫자만 남도록 replace
	
	$('#custTel').val(custTel);
}
</script>
<div id="schContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label for="sdFrDt" class="cardTitle2">상담기간<font color="red">*</font></label>
				<input name="sdFrDt" id="sdFrDt" type="text" value="${sdFrDt}" placeholder="" class="searchDate" style="width:75px; height:22px;">
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal">
				<label class="wordTitle">~</label>
				<input name="sdToDt" id="sdToDt" type="text" value="${sdToDt}" placeholder="" class="searchDate" style="width:75px; height:22px;">
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="cardTitle2">상담자<font color="red">*</font></label>
				<input name="schEmpNo" id="schEmpNo" type="text" value="${schEmpNo}" class="searchCode" style="width:55px; height:22px;" onchange="doOnValueChangedSearch(schEmpNo)">
				<input name="schEmpNm" id="schEmpNm" type="text" value="${schEmpNm}" class="inputbox1" readonly="readonly" style="width:150px; height:22px;" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="cardTitle2">고객명</label>
				<input name="schCustNm" id="schCustNm" type="text" value="" class="inputbox1" maxlength="100">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label for="sdDt" class="cardTitle" style="width:95px; hegiht:22px; vertical-align:middle;">[ 입력기준정보 ]</label>
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label for="schSdDt" class="cardTitle2">상담일자<font color="red">*</font></label>
				<input name="schSdDt" id="schSdDt" type="text" value="${schSdDt}" placeholder="" class="searchDate" style="width:75px; height:22px;">
				<input type="button" id="calpicker3" name="calpicker3" class="calicon inputCal">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="cardTitle2">판매채널<font color="red">*</font></label>
					<input name="schCustCd" id="schCustCd" type="text" value="${schCustCd}" class="searchCode" style="width:55px; height:22px;" onchange="doOnValueChangedSearch(schCustCd)">
					<input name="schCustSalNm" id="schCustSalNm" type="text" value="${schCustSalNm}" class="inputbox1" readonly="readonly" style="width:150px; height:22px;" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="cardTitle2">고객/주문번호</label>
				<input name="schOrdNo" id="schOrdNo" type="text" value="" class="inputbox1" style="height:22px;" disabled>
			</div>
		</div>
	</div>
</div>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label for="sdDt" class="cardTitle">상담일자<font color="red">*</font></label>
				<input name="sdDt" id="sdDt" type="text" value="${sdDt}" placeholder="" class="searchDate" style="width:94px; height:22px;" disabled>
				<input type="button" id="calpicker4" name="calpicker4" class="calicon inputCal" disabled>
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">상담자<font color="red">*</font></label>
				<input name="empNo" id="empNo" type="text" value="${empNo}" class="searchCode" style="width:55px; height:22px;" disabled>
				<input name="empNm" id="empNm" type="text" value="${empNm}" class="inputbox1" readonly="readonly" style="width:67px; height:22px;" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left" hidden="true">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">고객/주문번호</label>
				<input name="ordNo" id="ordNo" type="text" value="" class="searchCode" style="height:22px;">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">판매채널<font color="red">*</font></label>
				<input name="custCd" id="custCd" type="text" value="" class="searchCode" style="width:95px; height:22px;" disabled>
				<input name="custSalNm" id="custSalNm" type="text" value="" class="inputbox1" readonly="readonly" style="width:297px; height:22px;" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">고객구분<font color="red">*</font></label>
				<select name="custGubun" id="custGubun" class="searchBox" required style="width:126px; height:22px;"></select>
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">상담구분<font color="red">*</font></label>
				<select name="sdGubun" id="sdGubun" class="searchBox" required style="width:140px; height:22px;" onchange="doEtcEnable(sdGubun)"></select>
			</div>
		</div>
		<div class="left">
			<div class="ml10">
				<input name="sdGubunEtc" id="sdGubunEtc" type="text" value="" class="inputbox1" maxlength="50" style="width:220px; height:22px;">
			</div>
		</div>
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">고객명<font color="red">*</font></label>
				<input name="custNm" id="custNm" type="text" value="" class="inputbox1" maxlength="100">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">연락처<font color="red">*</font></label>
				<input name="custTel" id="custTel" type="text" value="" class="inputbox1" maxlength="11" style="width:132px; height:22px;" onchange="doChkNum()">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">주소지<font color="red">*</font></label>
				<input name="custAddr" id="custAddr" type="text" value="" class="inputbox1" maxlength="220" style="width:404px; height:22px;">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">유입경로<font color="red">*</font></label>
				<select name="inputRoute" id="inputRoute" class="searchBox" style="width:126px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">현장유형<font color="red">*</font></label>
				<select name="siteType" id="siteType" class="searchBox" style="width:126px; height:22px;"></select>
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">엘리베이터(유/무)</label>
				<select name="siteElevator" id="siteElevator" class="searchBox" required style="width:140px; height:22px;">
					<option value="" selected></option>
					<option value="1">있음</option>
					<option value="0">없음</option>
				</select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">공사유형<font color="red">*</font></label>
				<select name="constructType" id="constructType" class="searchBox" style="width:126px; height:22px;"></select>
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">시공유형<font color="red">*</font></label>
				<select name="typeChk" id="typeChk" class="searchBox" style="width:140px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">현재욕실수량</label>
				<select name="preBathQty" id="preBathQty" class="searchBox" style="width:126px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">현재욕실유형</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
			    <input type="checkbox" name="preBathType1" id="preBathType1" value="1">&nbsp;욕조
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="preBathType2" id="preBathType2" value="1">&nbsp;파티션
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="preBathType3" id="preBathType3" value="1">&nbsp;샤워부스
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="preBathType4" id="preBathType4" value="1">&nbsp;없음
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="preBathType5" id="preBathType5" value="1" onchange="doEtcEnable(preBathType5)">&nbsp;기타
			</div>
		</div>
		<div class="left">
			<div class="ml10">
			    <input name="preBathTypeEtc" id="preBathTypeEtc" type="text" value="" class="inputbox1" maxlength="25" style="width:220px; height:22px;"/>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">요청욕실수량</label>
				<select name="reqBathQty" id="reqBathQty" class="searchBox" style="width:126px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">요청욕실유형</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
			    <input type="checkbox" name="reqBathType1" id="reqBathType1" value="1">&nbsp;욕조
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="reqBathType2" id="reqBathType2" value="1">&nbsp;파티션
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="reqBathType3" id="reqBathType3" value="1">&nbsp;샤워부스
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="reqBathType4" id="reqBathType4" value="1">&nbsp;없음
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="reqBathType5" id="reqBathType5" value="1" onchange="doEtcEnable(reqBathType5)">&nbsp;기타
			</div>
		</div>
		<div class="left">
			<div class="ml10">
			    <input name="reqBathTypeEtc" id="reqBathTypeEtc" type="text" value="" class="inputbox1" maxlength="25" style="width:220px; height:22px;"/>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">고객진행상태<font color="red">*</font></label>
				<select name="custStat" id="custStat" class="searchBox" style="width:126px; height:22px;"></select>
			</div>
		</div>
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label for="requestDt" class="cardTitle">실측요청일자</label>
				<input name="requestDt" id="requestDt" type="text" value="" placeholder="" class="searchDate" style="width:94px; height:22px;">
				<input type="button" id="calpicker5" name="calpicker5" class="calicon inputCal">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">실측희망시간</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
		   <!-- <select name="requestTimeDiv" id="requestTimeDiv" class="searchBox" style="width:65px; height:22px;"></select>  -->
				<select name="requestTimeDiv" id="requestTimeDiv" class="searchBox" style="width:140px; height:22px;"></select>
			</div>
		</div>
		<!-- 20181005 ryul 시간이랑 분은 나중에 요청이 들어왔을 경우 hidden 없앨 것 -->
		<div class="left" hidden="true">
			<div class="mlZero">
				<select name="requestHour" id="requestHour" class="searchBox" style="width:65px; height:22px;"></select>
			</div>
		</div>
		<div class="left" hidden="true">
			<div class="mlZero">
				<select name="requestMin" id="requestMin" class="searchBox" style="width:65px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label for="sigongDt" class="cardTitle">시공희망일자</label>
				<input name="sigongDt" id="sigongDt" type="text" value="" placeholder="" class="searchDate" style="width:94px; height:22px;">
				<input type="button" id="calpicker6" name="calpicker6" class="calicon inputCal">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">해피콜확인</label>
				<select name="callStat" id="callStat" class="searchBox" style="width:140px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">가격타입(거실)</label>
				<select name="costType1" id="costType1" class="searchBox" style="width:126px; height:22px;"></select>
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">가격타입(부부)</label>
				<select name="costType2" id="costType2" class="searchBox" style="width:140px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">욕실스타일(거실)</label>
				<select name="bathStyle1" id="bathStyle1" class="searchBox" style="width:126px; height:22px;"></select>
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">욕실스타일(부부)</label>
				<select name="bathStyle2" id="bathStyle2" class="searchBox" style="width:140px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">주거유형<font color="red">*</font></label>
				<select name="lifeType" id="lifeType" class="searchBox" style="width:126px; height:22px;" onchange="doEtcEnable(lifeType)"></select>
			</div>
		</div>
		<div class="left">
			<div class="ml10">
				<input name="lifeTypeEtc" id="lifeTypeEtc" type="text" value="" class="inputbox1" maxlength="25" style="width:268px; height:22px;">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">상담내용</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<textarea name="consultCont" id="consultCont" class="inputbox1" rows="5" cols="80" style="width: 635px; font-size:12px; color:#555555; font-family: 돋움,Dotum, AppleGothic, sans-serif;" maxlength="528"></textarea>
			</div>
		</div>
	</div>
	<div class="listHeader"></div>
	<div class="listHeader"></div>
	<div class="listHeader"></div>
	<div class="listHeader"></div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle"  style="width:150px;">고객 정보 활용 동의 여부<font color="red">*</font></label>
				<select name="infoAgreYn" id="infoAgreYn" class="searchBox" style="width:70px; height:22px;"></select>
			</div>
		</div>
	</div>
</div>
<div id="container"></div>