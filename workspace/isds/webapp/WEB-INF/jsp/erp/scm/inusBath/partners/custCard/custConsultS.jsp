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
    gridMain.addHeader({name:"해피콜"		, colId:"callDt"			, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"callStatNm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"현장실측정보"	, colId:"surveyDt"			, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"surveyTime"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"공사희망일자"	, colId:"sigongDt"			, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"시공유형"	, colId:"typeChk1Nm"		, width:"60"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"typeChk2Nm"		, width:"60"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"typeChk3Nm"		, width:"60"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"typeChk4Nm"		, width:"60"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"typeChk5Nm"		, width:"60"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"현재욕실정보"	, colId:"preBathQtyNm"		, width:"50"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"preBathType1Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"preBathType2Nm"	, width:"70"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"preBathType3Nm"	, width:"60"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"preBathType4Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"preBathType5Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"preBathType6Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"요청욕실정보"	, colId:"reqBathQtyNm"		, width:"50"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"reqBathType1Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"reqBathType2Nm"	, width:"70"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"reqBathType3Nm"	, width:"60"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"reqBathType4Nm"	, width:"50"	, height:"20"	, align:"center"	, type:"ro"});	
    gridMain.addHeader({name:"유입경로"	, colId:"inputRouteNm"		, width:"80"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"관심제품"	, colId:"interestProduct1Nm", width:"60"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"interestProduct2Nm", width:"60"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"interestProduct3Nm", width:"50"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"interestProduct4Nm", width:"50"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"interestProduct5Nm", width:"50"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"방문인원"	, colId:"visitCntNm"		, width:"60"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"가격타입"	, colId:"costType1Nm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"costType2Nm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"욕실스타일"	, colId:"bathStyle1Nm"		, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"bathStyle2Nm"		, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"상품계약"	, colId:"reservYn"			, width:"50"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"saleName"			, width:"120"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"1차상담내용"	, colId:"consultCont1"		, width:"140"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"2차상담내용"	, colId:"consultCont2"		, width:"140"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"상담자"		, colId:"empNm"				, width:"100"	, height:"20"	, align:"left"		, type:"ro"});
    
    gridMain.attachHeader("#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,일자,진행상태,희망일자,희망시간,#rspan,덧방시공,타일철거,부분철거,바닥철거,방수시공,수량,욕조,샤워파티션,샤워부스,UBR,타일,기타,수량,욕조,샤워파티션,샤워부스,기타,#rspan,리모델링,위생도기,타일,비데,기타,#rspan,공용,부부,공용,부부,여부,상품명,#rspan,#rspan,#rspan");
    
    gridMain.setUserData("","pk","ordNo");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["ordNo","empNo","custGubun","sdGubun","siteType","siteTypeEtc","siteElevator","preBathQty","reqBathQty","inputRoute","visitCnt","costType1","costType2","bathStyle1","bathStyle2","surveyHour","surveyMin","callStat","saleCode","typeChk1","typeChk2","typeChk3","typeChk4","typeChk5","preBathType1","preBathType2","preBathType3","preBathType4","preBathType5","preBathType6","reqBathType1","reqBathType2","reqBathType3","reqBathType4","interestProduct1","interestProduct2","interestProduct3","interestProduct4","interestProduct5","reqBathTypeEtc","custCd","custSalNm"]);
    gridMain.attachEvent("onRowSelect",doCopyGridToFreeForm);
    
    subLayout.cells("b").showHeader()
    subLayout.cells("b").setText("고객상담상세내역")
    subLayout.cells("b").attachObject("bootContainer");
    
    calMain = new dhtmlXCalendarObject([{input:"sdDt",button:"calpicker1"},{input:"surveyDt",button:"calpicker2"}
                                       ,{input:"sigongDt",button:"calpicker3"},{input:"callDt",button:"calpicker4"}
                                       ,{input:"schSdDt",button:"calpicker5"},{input:"schCallDt",button:"calpicker6"}
                                       ,{input:"sdFrDt",button:"calpicker7"},{input:"sdToDt",button:"calpicker8"}]);
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

    param.mainCd = "AS501";
    gfn_baseCd_comboLoadOption(param, "sdGubun", "baseCdSearch", "", "선택", fn_returnComboList);

    param.mainCd = "AS502";
    gfn_baseCd_comboLoadOption(param, "siteType", "baseCdSearch", "", "선택", fn_returnComboList);

    param.mainCd = "AS503";
    gfn_baseCd_comboLoadOption(param, "preBathQty", "baseCdSearch", "Y", "", fn_returnComboList);
    
    param.mainCd = "AS503";
    gfn_baseCd_comboLoadOption(param, "reqBathQty", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "AS504";
    gfn_baseCd_comboLoadOption(param, "visitCnt", "baseCdSearch", "Y", "", fn_returnComboList);
    
    param.mainCd = "AS505";
    gfn_baseCd_comboLoadOption(param, "costType1", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "AS505";
    gfn_baseCd_comboLoadOption(param, "costType2", "baseCdSearch", "Y", "", fn_returnComboList);
    
    param.mainCd = "AS506";
    gfn_baseCd_comboLoadOption(param, "inputRoute", "baseCdSearch", "", "선택", fn_returnComboList);

    param.mainCd = "AS507";
    gfn_baseCd_comboLoadOption(param, "schCallStat", "baseCdSearch", "Y", "전체", fn_returnComboList);
    gfn_baseCd_comboLoadOption(param, "callStat", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "AS508";
    gfn_baseCd_comboLoadOption(param, "bathStyle1", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "AS508";
    gfn_baseCd_comboLoadOption(param, "bathStyle2", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "SD613";
    gfn_baseCd_comboLoadOption(param, "surveyHour", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "SD614";
    gfn_baseCd_comboLoadOption(param, "surveyMin", "baseCdSearch", "Y", "", fn_returnComboList);
    
    
    $('#schCustCd').focus();	//판매채널 조회조건 포커싱
    document.getElementById("reqBathType4").onchange();
});

function doSetScmUserInfo() {
	gfn_callAjax("","/erp/scm/inusBath/partners/custCard/loginUserInfoSearch",doSetScmUserInfoCB);
}

function doSetScmUserInfoCB(data) {
	var empNo = data[0].empNo;
	var empNm = data[0].empNm;
// 	var custCd = data[0].custCd;
// 	var custNm = data[0].custNm;
	
	//로그인 제어로 대체
// 	if("1"!=workYn) {	//재직이 아닌 경우 fn_exit() 실행
// 		dhtmlx.alert("재직중인 직원만 이용가능합니다.");
// 		return window.setTimeout(function() {
// 			fn_exit();
// 	    }, 10000)	//0.1초 [1초:1000]
// 	} else {
		$('#schEmpNo').val(empNo);
		$('#schEmpNm').val(empNm);
// 		$('#schUserCustCd').val(custCd);
// 		$('#schUserCustNm').val(custNm);
// 	}
}

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

//조회
function fn_search(div){
	//저장이 아닐 경우, 고객/주문번호 초기화
	if("save"!=div) {
		$('#schOrdNo').val("");
	}
	
	var obj = {};
	obj.sdFrDt = searchDate($('#sdFrDt').val());	//상담기간(시작)
	obj.sdToDt = searchDate($('#sdToDt').val());	//상담기간(종료)
// 	obj.sdDt = searchDate($('#schSdDt').val());	//상담일자
	obj.empNo = $('#schEmpNo').val();			//상담자
	obj.ordNo = $('#schOrdNo').val();			//고객/주문번호
	obj.custNm = $('#schCustNm').val();			//고객명
	obj.callDt = $('#schCallDt').val();			//해피콜일자
	obj.callStat = $('#schCallStat').val();		//진행상태
	obj.custCd = $('#schCustCd').val();			//판매채널[schCustCd]
	
	//S 필수값체크
// 	if(obj.sdDt =="") {
// 		MsgManager.alertMsg("WRN001","상담일자");	//{0}은(는) 필수입력 항목입니다.
// 		return false;
// 	}
	
	if(obj.sdFrDt == "" || obj.sdToDt == "") {
		MsgManager.alertMsg("WRN001","상담기간");	//{0}은(는) 필수입력 항목입니다.
		return false;
	}
	
	if(obj.empNo =="") {
		MsgManager.alertMsg("WRN001","상담자");	//{0}은(는) 필수입력 항목입니다.
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

var colObj = ["ordNo", "sdDt", "empNo", "empNm", "custGubun", "sdGubun", "custNm", "custTel", "custAddr", "siteType", "siteElevator", "typeChk1", "typeChk2", "typeChk3", "typeChk4", "typeChk5"];
//grid의 값을 freeform으로 이동 (rowSelectEvent)
function doCopyGridToFreeForm() {
	fn_new("all");	//초기화
	var cnt = gridMain.getRowsNum();
	var idx = gridMain.getSelectedRowId();
	var rId = idx > 0 ? idx : 1;  
	
	if(cnt > 0) {
		//첫번째 row의 값을 가져온다.
		var obj1 = {};
		obj1.ordNo = gridMain.setCells(rId, gridMain.getColIndexById('ordNo')).getValue();
		obj1.sdDt = gridMain.setCells(rId, gridMain.getColIndexById('sdDt')).getValue();
		obj1.empNo = gridMain.setCells(rId, gridMain.getColIndexById('empNo')).getValue();
		obj1.empNm = gridMain.setCells(rId, gridMain.getColIndexById('empNm')).getValue();
		obj1.custGubun = gridMain.setCells(rId, gridMain.getColIndexById('custGubun')).getValue();
		obj1.sdGubun = gridMain.setCells(rId, gridMain.getColIndexById('sdGubun')).getValue();
		obj1.custNm = gridMain.setCells(rId, gridMain.getColIndexById('custNm')).getValue();
		obj1.custTel = gridMain.setCells(rId, gridMain.getColIndexById('custTel')).getValue();
		obj1.custAddr = gridMain.setCells(rId, gridMain.getColIndexById('custAddr')).getValue();
		obj1.siteType = gridMain.setCells(rId, gridMain.getColIndexById('siteType')).getValue();
		obj1.siteTypeEtc = gridMain.setCells(rId, gridMain.getColIndexById('siteTypeEtc')).getValue();
		obj1.siteElevator = gridMain.setCells(rId, gridMain.getColIndexById('siteElevator')).getValue();
		obj1.typeChk1 = gridMain.setCells(rId, gridMain.getColIndexById('typeChk1')).getValue();
		obj1.typeChk2 = gridMain.setCells(rId, gridMain.getColIndexById('typeChk2')).getValue();
		obj1.typeChk3 = gridMain.setCells(rId, gridMain.getColIndexById('typeChk3')).getValue();
		obj1.typeChk4 = gridMain.setCells(rId, gridMain.getColIndexById('typeChk4')).getValue();
		obj1.typeChk5 = gridMain.setCells(rId, gridMain.getColIndexById('typeChk5')).getValue();
		obj1.preBathQty = gridMain.setCells(rId, gridMain.getColIndexById('preBathQty')).getValue();
		obj1.preBathType1 = gridMain.setCells(rId, gridMain.getColIndexById('preBathType1')).getValue();
		obj1.preBathType2 = gridMain.setCells(rId, gridMain.getColIndexById('preBathType2')).getValue();
		obj1.preBathType3 = gridMain.setCells(rId, gridMain.getColIndexById('preBathType3')).getValue();
		obj1.preBathType4 = gridMain.setCells(rId, gridMain.getColIndexById('preBathType4')).getValue();
		obj1.preBathType5 = gridMain.setCells(rId, gridMain.getColIndexById('preBathType5')).getValue();
		obj1.preBathType6 = gridMain.setCells(rId, gridMain.getColIndexById('preBathType6')).getValue();
		obj1.reqBathQty = gridMain.setCells(rId, gridMain.getColIndexById('reqBathQty')).getValue();
		obj1.reqBathType1 = gridMain.setCells(rId, gridMain.getColIndexById('reqBathType1')).getValue();
		obj1.reqBathType2 = gridMain.setCells(rId, gridMain.getColIndexById('reqBathType2')).getValue();
		obj1.reqBathType3 = gridMain.setCells(rId, gridMain.getColIndexById('reqBathType3')).getValue();
		obj1.reqBathType4 = gridMain.setCells(rId, gridMain.getColIndexById('reqBathType4')).getValue();
		obj1.reqBathTypeEtc = gridMain.setCells(rId, gridMain.getColIndexById('reqBathTypeEtc')).getValue();
		obj1.inputRoute = gridMain.setCells(rId, gridMain.getColIndexById('inputRoute')).getValue();
		obj1.interestProduct1 = gridMain.setCells(rId, gridMain.getColIndexById('interestProduct1')).getValue();
		obj1.interestProduct2 = gridMain.setCells(rId, gridMain.getColIndexById('interestProduct2')).getValue();
		obj1.interestProduct3 = gridMain.setCells(rId, gridMain.getColIndexById('interestProduct3')).getValue();
		obj1.interestProduct4 = gridMain.setCells(rId, gridMain.getColIndexById('interestProduct4')).getValue();
		obj1.interestProduct5 = gridMain.setCells(rId, gridMain.getColIndexById('interestProduct5')).getValue();
		obj1.visitCnt = gridMain.setCells(rId, gridMain.getColIndexById('visitCnt')).getValue();
		obj1.costType1 = gridMain.setCells(rId, gridMain.getColIndexById('costType1')).getValue();
		obj1.costType2 = gridMain.setCells(rId, gridMain.getColIndexById('costType2')).getValue();
		obj1.bathStyle1 = gridMain.setCells(rId, gridMain.getColIndexById('bathStyle1')).getValue();
		obj1.bathStyle2 = gridMain.setCells(rId, gridMain.getColIndexById('bathStyle2')).getValue();
		obj1.surveyDt = gridMain.setCells(rId, gridMain.getColIndexById('surveyDt')).getValue();
		obj1.surveyHour = gridMain.setCells(rId, gridMain.getColIndexById('surveyHour')).getValue();
		obj1.surveyMin = gridMain.setCells(rId, gridMain.getColIndexById('surveyMin')).getValue();
		obj1.sigongDt = gridMain.setCells(rId, gridMain.getColIndexById('sigongDt')).getValue();
		obj1.callDt = gridMain.setCells(rId, gridMain.getColIndexById('callDt')).getValue();
		obj1.callStat = gridMain.setCells(rId, gridMain.getColIndexById('callStat')).getValue();
		obj1.reservYn = gridMain.setCells(rId, gridMain.getColIndexById('reservYn')).getValue();
		obj1.saleCode = gridMain.setCells(rId, gridMain.getColIndexById('saleCode')).getValue();
		obj1.saleName = gridMain.setCells(rId, gridMain.getColIndexById('saleName')).getValue();
		obj1.consultCont1 = gridMain.setCells(rId, gridMain.getColIndexById('consultCont1')).getValue();
		obj1.consultCont2 = gridMain.setCells(rId, gridMain.getColIndexById('consultCont2')).getValue();
		obj1.custCd = gridMain.setCells(rId, gridMain.getColIndexById('custCd')).getValue();
		obj1.custSalNm = gridMain.setCells(rId, gridMain.getColIndexById('custSalNm')).getValue();

		//가져온 값을 freeform으로 복사해준다. - 인덱스 : realIdx
		doCopyVal(obj1);
	} else {
		
	}
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
   if(pName == "saleCode"){
	   $('#saleCode').val(data[0].saleCode);
	   $('#saleName').val(data[0].saleName);
	   $('#saleCode').focus();
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
   
   if(div.id=="saleCode" && saleCode==""){
	   $('#saleCode').val("");
	   $('#saleName').val("");
   }
}


function doEtcEnable(div) {
   var siteType = $('#siteType').val();
   var reqBathType4 = $('input:checkbox[id="reqBathType4"]').is(':checked');
   
   if(div.id=="siteType") {
	   document.getElementById("siteTypeEtc").disabled = siteType=="AS502500" ? false : true;
	   $('#siteTypeEtc').val("");
   } else if(div.id=="reqBathType4") {
	   document.getElementById("reqBathTypeEtc").disabled = reqBathType4== true ? false : true;
	   $('#reqBathTypeEtc').val("");
   }
}

//row별 데이터를 복사
function doCopyVal(obj) {
	$('#ordNo').val(obj.ordNo);
	$('#sdDt').val(obj.sdDt);
	$('#empNo').val(obj.empNo);
	$('#empNm').val(obj.empNm);
	$('#custGubun').val(obj.custGubun);
	$('#sdGubun').val(obj.sdGubun);
	$('#custNm').val(obj.custNm);
	$('#custTel').val(obj.custTel);
	$('#custAddr').val(obj.custAddr);
	$('#siteType').val(obj.siteType);
	document.getElementById("siteType").onchange();
	$('#siteTypeEtc').val(obj.siteTypeEtc);
	$('#siteElevator').val(obj.siteElevator);
// 	obj.typeChk1 = obj.typeChk1 == "true" ? true : false;
// 	obj.typeChk2 = obj.typeChk2 == "true" ? true : false;
// 	obj.typeChk3 = obj.typeChk3 == "true" ? true : false;
// 	obj.typeChk4 = obj.typeChk4 == "true" ? true : false;
// 	obj.typeChk5 = obj.typeChk5 == "true" ? true : false;
	document.getElementById("typeChk1").checked = JSON.parse(obj.typeChk1);
	document.getElementById("typeChk2").checked = JSON.parse(obj.typeChk2);
	document.getElementById("typeChk3").checked = JSON.parse(obj.typeChk3);
	document.getElementById("typeChk4").checked = JSON.parse(obj.typeChk4);
	document.getElementById("typeChk5").checked = JSON.parse(obj.typeChk5);
	$('#preBathQty').val(obj.preBathQty);
// 	obj.preBathType1 = obj.preBathType1 == "true" ? true : false;
// 	obj.preBathType2 = obj.preBathType2 == "true" ? true : false;
// 	obj.preBathType3 = obj.preBathType3 == "true" ? true : false;
// 	obj.preBathType4 = obj.preBathType4 == "true" ? true : false;
// 	obj.preBathType5 = obj.preBathType5 == "true" ? true : false;
// 	obj.preBathType6 = obj.preBathType6 == "true" ? true : false;
	document.getElementById("preBathType1").checked = JSON.parse(obj.preBathType1);
	document.getElementById("preBathType2").checked = JSON.parse(obj.preBathType2);
	document.getElementById("preBathType3").checked = JSON.parse(obj.preBathType3);
	document.getElementById("preBathType4").checked = JSON.parse(obj.preBathType4);
	document.getElementById("preBathType5").checked = JSON.parse(obj.preBathType5);
	document.getElementById("preBathType6").checked = JSON.parse(obj.preBathType6);
	$('#reqBathQty').val(obj.reqBathQty);
// 	obj.reqBathType1 = obj.reqBathType1 == "true" ? true : false;
// 	obj.reqBathType2 = obj.reqBathType2 == "true" ? true : false;
// 	obj.reqBathType3 = obj.reqBathType3 == "true" ? true : false;
// 	obj.reqBathType4 = obj.reqBathType4 == "true" ? true : false;
	document.getElementById("reqBathType1").checked = JSON.parse(obj.reqBathType1);
	document.getElementById("reqBathType2").checked = JSON.parse(obj.reqBathType2);
	document.getElementById("reqBathType3").checked = JSON.parse(obj.reqBathType3);
	document.getElementById("reqBathType4").checked = JSON.parse(obj.reqBathType4);
	document.getElementById("reqBathType4").onchange();
	$('#reqBathTypeEtc').val(obj.reqBathTypeEtc);
	$('#inputRoute').val(obj.inputRoute);
// 	obj.interestProduct1 = obj.interestProduct1 == "true" ? true : false;
// 	obj.interestProduct2 = obj.interestProduct2 == "true" ? true : false;
// 	obj.interestProduct3 = obj.interestProduct3 == "true" ? true : false;
// 	obj.interestProduct4 = obj.interestProduct4 == "true" ? true : false;
// 	obj.interestProduct5 = obj.interestProduct5 == "true" ? true : false;
	document.getElementById("interestProduct1").checked = JSON.parse(obj.interestProduct1);
	document.getElementById("interestProduct2").checked = JSON.parse(obj.interestProduct2);
	document.getElementById("interestProduct3").checked = JSON.parse(obj.interestProduct3);
	document.getElementById("interestProduct4").checked = JSON.parse(obj.interestProduct4);
	document.getElementById("interestProduct5").checked = JSON.parse(obj.interestProduct5);
	$('#visitCnt').val(obj.visitCnt);
	$('#costType1').val(obj.costType1);
	$('#costType2').val(obj.costType2);
	$('#bathStyle1').val(obj.bathStyle1);
	$('#bathStyle2').val(obj.bathStyle2);
	$('#surveyDt').val(obj.surveyDt);
	$('#surveyHour').val(obj.surveyHour);
	$('#surveyMin').val(obj.surveyMin);
	$('#sigongDt').val(obj.sigongDt);
	$('#callDt').val(obj.callDt);
	$('#callStat').val(obj.callStat);
	$('#reservYn').val(obj.reservYn);
	$('#saleCode').val(obj.saleCode);
	$('#saleName').val(obj.saleName);
	$('#consultCont1').val(obj.consultCont1);
	$('#consultCont2').val(obj.consultCont2);
	$('#custCd').val(obj.custCd);
	$('#custSalNm').val(obj.custSalNm);
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
// 		var custCd = $('#schUserCustCd').val();
		
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
	$('#custNm').val("");
	$('#custTel').val("");
	$('#custAddr').val("");
	$('#siteType').val("");
	$('#siteTypeEtc').val("");
	document.getElementById("siteType").onchange();
	$('#siteElevator').val("");
	$("input:checkbox[name='typeChk1']").removeAttr("checked");
	$("input:checkbox[name='typeChk2']").removeAttr("checked");
	$("input:checkbox[name='typeChk3']").removeAttr("checked");
	$("input:checkbox[name='typeChk4']").removeAttr("checked");
	$("input:checkbox[name='typeChk5']").removeAttr("checked");
	$('#preBathQty').val("");
	$("input:checkbox[name='preBathType1']").removeAttr("checked");
	$("input:checkbox[name='preBathType2']").removeAttr("checked");
	$("input:checkbox[name='preBathType3']").removeAttr("checked");
	$("input:checkbox[name='preBathType4']").removeAttr("checked");
	$("input:checkbox[name='preBathType5']").removeAttr("checked");
	$("input:checkbox[name='preBathType6']").removeAttr("checked");
	$('#reqBathQty').val("");
	$("input:checkbox[name='reqBathType1']").removeAttr("checked");
	$("input:checkbox[name='reqBathType2']").removeAttr("checked");
	$("input:checkbox[name='reqBathType3']").removeAttr("checked");
	$("input:checkbox[name='reqBathType4']").removeAttr("checked");
	$('#reqBathTypeEtc').val("");
	document.getElementById("reqBathType4").onchange();
	$('#inputRoute').val("");
	$("input:checkbox[name='interestProduct1']").removeAttr("checked");
	$("input:checkbox[name='interestProduct2']").removeAttr("checked");
	$("input:checkbox[name='interestProduct3']").removeAttr("checked");
	$("input:checkbox[name='interestProduct4']").removeAttr("checked");
	$("input:checkbox[name='interestProduct5']").removeAttr("checked");
	$('#visitCnt').val("");
	$('#costType1').val("");
	$('#costType2').val("");
	$('#bathStyle1').val("");
	$('#bathStyle2').val("");
	$('#surveyDt').val("");
	$('#surveyHour').val("");
	$('#surveyMin').val("");
	$('#sigongDt').val("");
	$('#callDt').val("");
	$('#callStat').val("");
	$('#reservYn').val("");
	$('#saleCode').val("");
	$('#saleName').val("");
	$('#consultCont1').val("");
	$('#consultCont2').val("");
}

function fn_save(div){
	//저장하시겠습니까? 체크
	//상담일자 / 해피콜일자 / 현장실측희망일 / 공사희망일 날짜 맞는지 확인 후 저장 처리
	var msg = "";
	var sdDt = searchDate($('#sdDt').val());
	var callDt = searchDate($('#callDt').val());
	var surveyDt = searchDate($('#surveyDt').val());
	var sigongDt = searchDate($('#sigongDt').val());
	
	if(sdDt!="") {
		msg += "상담날짜 : " + sdDt;
	}
	
	if(callDt!="") {
		msg += "\n해피콜날짜 : " + callDt;
	}
	
	if(surveyDt!="") {
		msg += "\n현장실측희망일 : " + surveyDt;
	}
	
	if(sigongDt!="") {
		msg += "\n공사희망일 : " + sigongDt;
	}
	
	msg += "\n위와 같이 저장하시겠습니까?";
	
	if(MsgManager.confirmMsg("WRN020", msg)){
		var obj = {};
		obj.ordNo = $('#ordNo').val();
		obj.sdDt = searchDate($('#sdDt').val());
		obj.empNo = $('#empNo').val();
		obj.empNm = $('#empNm').val();
		obj.custGubun = $('#custGubun').val();
		obj.sdGubun = $('#sdGubun').val();
		obj.custNm = $('#custNm').val();
		obj.custTel = $('#custTel').val();
		obj.custAddr = $('#custAddr').val();
		obj.siteType = $('#siteType').val();
		obj.siteTypeEtc = $('#siteTypeEtc').val();
		obj.siteElevator = $('#siteElevator').val();
		obj.typeChk1 = $('input:checkbox[id="typeChk1"]').is(':checked');
		obj.typeChk2 = $('input:checkbox[id="typeChk2"]').is(':checked');
		obj.typeChk3 = $('input:checkbox[id="typeChk3"]').is(':checked');
		obj.typeChk4 = $('input:checkbox[id="typeChk4"]').is(':checked');
		obj.typeChk5 = $('input:checkbox[id="typeChk5"]').is(':checked');
		
		obj.preBathQty = $('#preBathQty').val();
		obj.preBathType1 = $('input:checkbox[id="preBathType1"]').is(':checked');
		obj.preBathType2 = $('input:checkbox[id="preBathType2"]').is(':checked');
		obj.preBathType3 = $('input:checkbox[id="preBathType3"]').is(':checked');
		obj.preBathType4 = $('input:checkbox[id="preBathType4"]').is(':checked');
		obj.preBathType5 = $('input:checkbox[id="preBathType5"]').is(':checked');
		obj.preBathType6 = $('input:checkbox[id="preBathType6"]').is(':checked');
		
		obj.reqBathQty = $('#reqBathQty').val();
		obj.reqBathType1 = $('input:checkbox[id="reqBathType1"]').is(':checked'); 
		obj.reqBathType2 = $('input:checkbox[id="reqBathType2"]').is(':checked');  
		obj.reqBathType3 = $('input:checkbox[id="reqBathType3"]').is(':checked');  
		obj.reqBathType4 = $('input:checkbox[id="reqBathType4"]').is(':checked');  
		obj.reqBathTypeEtc = $('#reqBathTypeEtc').val();
		
		obj.inputRoute = $('#inputRoute').val();
		obj.interestProduct1 = $('input:checkbox[id="interestProduct1"]').is(':checked');   
		obj.interestProduct2 = $('input:checkbox[id="interestProduct2"]').is(':checked');   
		obj.interestProduct3 = $('input:checkbox[id="interestProduct3"]').is(':checked');   
		obj.interestProduct4 = $('input:checkbox[id="interestProduct4"]').is(':checked');   
		obj.interestProduct5 = $('input:checkbox[id="interestProduct5"]').is(':checked');   
		
		obj.visitCnt = $('#visitCnt').val();
		obj.costType1 = $('#costType1').val();
		obj.costType2 = $('#costType2').val();
		obj.bathStyle1 = $('#bathStyle1').val();
		obj.bathStyle2 = $('#bathStyle2').val();
		obj.surveyDt = searchDate($('#surveyDt').val());
		obj.surveyHour = $('#surveyHour').val();
		obj.surveyMin = $('#surveyMin').val();
		obj.sigongDt = searchDate($('#sigongDt').val());
		obj.callDt = searchDate($('#callDt').val());
		obj.callStat = $('#callStat').val();
		obj.reservYn = $('#reservYn').val();
		obj.saleCode = $('#saleCode').val();
		obj.saleName = $('#saleName').val();
		obj.consultCont1 = $('#consultCont1').val();
		obj.consultCont2 = $('#consultCont2').val();
		obj.custCd = $('#custCd').val();
		obj.custSalNm = $('#custSalNm').val();
		
		//S 필수값체크[상담일자, 상담자, 고객구분, 상담구분, 고객명, 고객주소지, 연락처, 현장유형, 시공유형1-5, 유입경로]
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
	 	if(obj.siteType =="") {
	 		MsgManager.alertMsg("WRN001","현장유형");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
	 	if(obj.typeChk1 != true && obj.typeChk2 !=true && obj.typeChk3 !=true && obj.typeChk4 !=true && obj.typeChk5 !=true) {
	 		MsgManager.alertMsg("WRN001","시공유형");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
	 	if(obj.inputRoute =="") {
	 		MsgManager.alertMsg("WRN001","유입경로");	//{0}은(는) 필수입력 항목입니다.
			return true;
	 	}
		//E 필수값체크
		
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
//출력물
//인쇄
function fn_print(){
	//출력물 프로시져 파라미터 : 고객/주문번호
	var ordNo = $('#ordNo').val();	//고객/주문번호 - freeform
	
	if(ordNo == null || ordNo == "") {	//공장코드 필수 체크
		dhtmlx.alert("출력할 항목이 없습니다.");
		return true;
	} else{
		var url = "/erp/scm/inusBath/partners/custCard/custConsultS/report/reportSch.do";
		url = url + "?ordNo=" + $('#ordNo').val();
		window.open(url,'rpt', '');
	}
}

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
				<input type="button" id="calpicker7" name="calpicker7" class="calicon inputCal">
				<label class="wordTitle">~</label>
				<input name="sdToDt" id="sdToDt" type="text" value="${sdToDt}" placeholder="" class="searchDate" style="width:75px; height:22px;">
				<input type="button" id="calpicker8" name="calpicker8" class="calicon inputCal">
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
				<input type="button" id="calpicker5" name="calpicker5" class="calicon inputCal">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="cardTitle2">판매채널<font color="red">*</font></label>
					<input name="schCustCd" id="schCustCd" type="text" value="${schCustCd}" class="searchCode" style="width:55px; height:22px;" onchange="doOnValueChangedSearch(schCustCd)">
					<input name="schCustSalNm" id="schCustSalNm" type="text" value="${schCustSalNm}" class="inputbox1" readonly="readonly" style="width:150px; height:22px;" onkeydown="event.preventDefault()">
<%-- 				<input name="schUserCustCd" id="schUserCustCd" type="text" value="${schUserCustCd}" class="searchCode" style="width:55px; height:22px;" hidden="true"> --%>
<%-- 				<input name="schUserCustNm" id="schUserCustNm" type="text" value="${schCusschUserCustNmtNm}" class="inputbox1" readonly="readonly" style="width:300px; height:22px;" onkeydown="event.preventDefault()"> --%>
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="cardTitle2">고객/주문번호</label>
				<input name="schOrdNo" id="schOrdNo" type="text" value="" class="inputbox1" style="height:22px;" disabled>
			</div>
		</div>
		<div class="left" hidden="true">
			<div class="ml20">
				<label class="cardTitle2">해피콜일자</label>
				<input name="schCallDt" id="schCallDt" type="text" value="" placeholder="" class="searchDate" style="width:94px; height:22px;">
				<input type="button" id="calpicker6" name="calpicker6" class="calicon inputCal">
			</div>
		</div>
		<div class="left" hidden="true">
			<div class="ml20">
				<label class="cardTitle2">진행상태</label>
				<select name="schCallStat" id="schCallStat" class="searchBox" style="width:140px; height:22px;"></select>
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
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" disabled>
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">상담자<font color="red">*</font></label>
				<input name="empNo" id="empNo" type="text" value="${empNo}" class="searchCode" style="width:55px; height:22px;" disabled>
				<input name="empNm" id="empNm" type="text" value="${empNm}" class="inputbox1" readonly="readonly" style="width:67px; height:22px;" onkeydown="event.preventDefault()">
<%-- 				<input name="empNo" id="empNo" type="text" value="${empNo}" class="searchCode" style="height:22px;" onchange="doOnValueChangedSearch(empNo)"> --%>
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
				<select name="sdGubun" id="sdGubun" class="searchBox" required style="width:140px; height:22px;"></select>
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
				<label class="wordTitle">■</label><label class="cardTitle">현장유형<font color="red">*</font></label>
				<select name="siteType" id="siteType" class="searchBox" style="width:126px; height:22px;" onchange="doEtcEnable(siteType)"></select>
			</div>
		</div>
		<div class="left">
			<div class="ml10">
				<input name="siteTypeEtc" id="siteTypeEtc" type="text" value="" class="inputbox1" maxlength="23" style="width:220px; height:20px;">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">엘리베이터(유/무)</label>
				<select name="siteElevator" id="siteElevator" class="searchBox" required style="width:126px; height:22px;">
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
				<label class="wordTitle">■</label><label class="cardTitle">시공유형<font color="red">*</font></label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
			    <input type="checkbox" name="typeChk1" id="typeChk1" value="${typeChk1}">&nbsp;덧방시공
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="typeChk2" id="typeChk2" value="${typeChk2}">&nbsp;타일철거
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="typeChk3" id="typeChk3" value="${typeChk3}">&nbsp;부분철거
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="typeChk4" id="typeChk4" value="${typeChk4}">&nbsp;바닥철거
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="typeChk5" id="typeChk5" value="${typeChk5}">&nbsp;방수시공
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
				<label class="wordTitle">■</label><label class="cardTitle">현재욕실타입</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
			    <input type="checkbox" name="preBathType1" id="preBathType1" value="1">&nbsp;욕조
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="preBathType2" id="preBathType2" value="1">&nbsp;샤워파티션
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="preBathType3" id="preBathType3" value="1">&nbsp;샤워부스
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="preBathType4" id="preBathType4" value="1">&nbsp;UBR
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="preBathType5" id="preBathType5" value="1">&nbsp;타일
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="preBathType6" id="preBathType6" value="1">&nbsp;기타
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
				<label class="wordTitle">■</label><label class="cardTitle">요청욕실타입</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
			    <input type="checkbox" name="reqBathType1" id="reqBathType1" value="1">&nbsp;욕조
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="reqBathType2" id="reqBathType2" value="1">&nbsp;샤워파티션
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="reqBathType3" id="reqBathType3" value="1">&nbsp;샤워부스
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="reqBathType4" id="reqBathType4" value="1" onchange="doEtcEnable(reqBathType4)">&nbsp;기타
			</div>
		</div>
		<div class="left">
			<div class="ml10">
			    <input name="reqBathTypeEtc" id="reqBathTypeEtc" type="text" value="" class="inputbox1" maxlength="23" style="width:220px; height:20px;"/>
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
				<label class="wordTitle">■</label><label class="cardTitle">관심제품</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
			    <input type="checkbox" name="interestProduct1" id="interestProduct1" value="1">&nbsp;리모델링
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="interestProduct2" id="interestProduct2" value="1">&nbsp;위생도기
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="interestProduct3" id="interestProduct3" value="1">&nbsp;타일
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="interestProduct4" id="interestProduct4" value="1">&nbsp;비데
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <input type="checkbox" name="interestProduct5" id="interestProduct5" value="1">&nbsp;기타
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">방문인원</label>
				<select name="visitCnt" id="visitCnt" class="searchBox" style="width:126px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">가격타입(공용)</label>
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
				<label class="wordTitle">■</label><label class="cardTitle">욕실스타일(공용)</label>
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
				<label class="wordTitle">■</label><label for="surveyDt" class="cardTitle">현장실측희망일</label>
				<input name="surveyDt" id="surveyDt" type="text" value="" placeholder="" class="searchDate" style="width:94px; height:22px;">
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">실측희망시간</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<select name="surveyHour" id="surveyHour" class="searchBox" style="width:65px; height:22px;"></select>
			</div>
		</div>
		<div class="left">
			<div class="ml10">
				<select name="surveyMin" id="surveyMin" class="searchBox" style="width:65px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label for="sigongDt" class="cardTitle">공사희망일</label>
				<input name="sigongDt" id="sigongDt" type="text" value="" placeholder="" class="searchDate" style="width:94px; height:22px;">
				<input type="button" id="calpicker3" name="calpicker3" class="calicon inputCal">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label for="callDt" class="cardTitle">해피콜일자</label>
				<input name="callDt" id="callDt" type="text" value="" placeholder="" class="searchDate" style="width:94px; height:22px;">
				<input type="button" id="calpicker4" name="calpicker4" class="calicon inputCal">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">진행상태</label>
				<select name="callStat" id="callStat" class="searchBox" style="width:140px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">상품계약여부</label>
				<select name="reservYn" id="reservYn" class="searchBox" required style="width:126px; height:22px;">
					<option value="" selected></option>
					<option value="1">계약</option>
					<option value="0">미계약</option>
				</select>
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">계약상품코드</label>
				<input name="saleCode" id="saleCode" type="text" value="${saleCode}" class="searchCode" style="width:100px; height:22px;" onchange="doOnValueChangedSearch(saleCode)">
				<input name="saleName" id="saleName" type="text" value="${saleName}" class="inputbox1" readonly="readonly" style="width:250px; height:22px;" onkeydown="event.preventDefault()">
			</div>
		</div>
<!-- 		<div class="left" hidden="true"> -->
<!-- 			<div class="ml20"> -->
<%-- 				<input name="custCd" id="custCd" type="text" value="${custCd}" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()"> --%>
<!-- 			</div> -->
<!-- 		</div> -->
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">1차 상담내용</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<textarea name="consultCont1" id="consultCont1" class="inputbox1" rows="5" cols="80" style="width: 635px; font-size:12px; color:#555555; font-family: 돋움,Dotum, AppleGothic, sans-serif;" maxlength="528"></textarea>
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
				<label class="wordTitle">■</label><label class="cardTitle">2차 상담내용</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<textarea name="consultCont2" id="consultCont2" class="inputbox1" rows="5" cols="80" style="width: 635px; font-size:12px; color:#555555; font-family: 돋움,Dotum, AppleGothic, sans-serif;" maxlength="528"></textarea>
			</div>
		</div>
	</div>
</div>
<div id="container"></div>