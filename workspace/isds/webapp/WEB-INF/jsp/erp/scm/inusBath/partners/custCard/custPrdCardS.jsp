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
	//세트 고객 상담 카드 
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
    gridMain.addHeader({name:"시공여부"	, colId:"sigongYnNm"		, width:"70"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"sigongPayYnNm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"해피콜확인"	, colId:"callStatNm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"고객진행상태"	, colId:"custStatNm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"상담제품"	, colId:"consultProduct1Nm"	, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"consultProduct2Nm"	, width:"90"	, height:"20"	, align:"left"		, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"consultProduct3Nm"	, width:"90"	, height:"20"	, align:"left"		, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"consultProduct4Nm"	, width:"90"	, height:"20"	, align:"left"		, type:"ro"});	
    gridMain.addHeader({name:"#cspan"	, colId:"consultProductEtc"	, width:"90"	, height:"20"	, align:"left"		, type:"ro"});	
    gridMain.addHeader({name:"제품배송일자"	, colId:"deliveryDt"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"시공진행일자"	, colId:"sigongDt"			, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"주거유형"	, colId:"lifeTypeNm"		, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"상담내용"	, colId:"consultCont"		, width:"140"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"상담자"		, colId:"empNm"				, width:"100"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"정보활용동의"	, colId:"infoAgreYnNm"		, width:"75"	, height:"20"	, align:"center"	, type:"ro"});
    
    gridMain.attachHeader("#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,진행여부,결재여부,#rspan,#rspan,제품1,제품2,제품3,제품4,기타,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan");
    
    gridMain.setUserData("","pk","ordNo");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    
    gridMain.cs_setColumnHidden(["ordNo","empNo","custGubun","sdGubun","siteType","siteTypeEtc","siteElevator","inputRoute","custStat", "callStat","saleCode","custCd","custSalNm","lifeType","infoAgreYn","callStat","lifeTypeEtc","consultProduct1","consultProduct2","consultProduct3","consultProduct4","sigongYn","sigongPayYn","sdGubunEtc"]);
    gridMain.attachEvent("onRowSelect",doCopyGridToFreeForm);
    
    subLayout.cells("b").showHeader()
    subLayout.cells("b").setText("고객상담상세내역")
    subLayout.cells("b").attachObject("bootContainer");
    
    calMain = new dhtmlXCalendarObject([{input:"sdFrDt",button:"calpicker1"},{input:"sdToDt",button:"calpicker2"},{input:"schSdDt",button:"calpicker3"}
                                       ,{input:"sdDt",button:"calpicker4"},{input:"deliveryDt",button:"calpicker5"},{input:"sigongDt",button:"calpicker6"}]);
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

    param.mainCd = "AS506";
    gfn_baseCd_comboLoadOption(param, "inputRoute", "baseCdSearch", "", "선택", fn_returnComboList);

    param.mainCd = "AS507";
    gfn_baseCd_comboLoadOption(param, "callStat", "baseCdSearch", "Y", "", fn_returnComboList);

    param.mainCd = "AS512";
    gfn_baseCd_comboLoadOption(param, "custStat", "baseCdSearch", "Y", "선택", fn_returnComboList);
    
    param.mainCd = "AS514";
    gfn_baseCd_comboLoadOption(param, "lifeType", "baseCdSearch", "Y", "선택", fn_returnComboList);

    param.mainCd = "AS515";
    gfn_baseCd_comboLoadOption(param, "sigongYn", "baseCdSearch", "Y", "", fn_returnComboList);
    gfn_baseCd_comboLoadOption(param, "infoAgreYn", "baseCdSearch", "Y", "선택", fn_returnComboList);
    
    param.mainCd = "AS516";
    gfn_baseCd_comboLoadOption(param, "consultProduct1", "baseCdSearch", "Y", "선택", fn_returnComboList);
    gfn_baseCd_comboLoadOption(param, "consultProduct2", "baseCdSearch", "Y", "", fn_returnComboList);
    gfn_baseCd_comboLoadOption(param, "consultProduct3", "baseCdSearch", "Y", "", fn_returnComboList);
    gfn_baseCd_comboLoadOption(param, "consultProduct4", "baseCdSearch", "Y", "", fn_returnComboList);
    
    param.mainCd = "AS517";
    gfn_baseCd_comboLoadOption(param, "sigongPayYn", "baseCdSearch", "Y", "", fn_returnComboList);
    
    $('#schCustCd').focus();	//판매채널 조회조건 포커싱
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
	//상담제품은 어떻게 처리할지 고민해볼 것
   var lifeType = $('#lifeType').val();
   var sdGubun = $('#sdGubun').val();
   
   if(div.id=="lifeType") {
	   document.getElementById("lifeTypeEtc").disabled = lifeType == "AS514500" ? false : true;
	   $('#lifeTypeEtc').val("");
   } else if(div.id == "sdGubun") {
	   document.getElementById("sdGubunEtc").disabled = sdGubun == "AS518200" ? false : true;
	   $('#sdGubunEtc').val("");
   }
}


//상담제품 onchange 처리 
function doPrdEtcEnable(div) {
	//1. 빈값체크
	//2. 중복값 체크
	//2-1. 중복된 값이 있을 경우, '중복된 값이 있습니다.' 메시지 처리
	//3. 해당 값이 기타인지 체크
	//3-1. 기타라면, enable 처리
	//3-2. 기타가 아니라면 disable 처리
	var consultProduct1 = $('#consultProduct1').val();
    var consultProduct2 = $('#consultProduct2').val();
    var consultProduct3 = $('#consultProduct3').val();
    var consultProduct4 = $('#consultProduct4').val();
    
    if(div.value != "") {
    	if((div.id == "consultProduct1" && (consultProduct1 == consultProduct2 || consultProduct1 == consultProduct3 || consultProduct1 == consultProduct4))
    	  || (div.id == "consultProduct2" && (consultProduct2 == consultProduct1 || consultProduct2 == consultProduct3 || consultProduct2 == consultProduct4))
    	  || (div.id == "consultProduct3" && (consultProduct3 == consultProduct1 || consultProduct3 == consultProduct2 || consultProduct3 == consultProduct4))
    	  || (div.id == "consultProduct4" && (consultProduct4 == consultProduct1 || consultProduct4 == consultProduct2 || consultProduct4 == consultProduct3))) {
    		$('#' + div.id).val("");
    		dhtmlx.alert("제품이 중복됩니다.");
			return true;
    	}
    }
    
    document.getElementById("consultProductEtc").disabled = (consultProduct1 == "AS516900" || consultProduct2 == "AS516900" || consultProduct3 == "AS516900" || consultProduct4 == "AS516900") ? false : true;
	$('#consultProductEtc').val("");
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
		obj1.ordNo = gridMain.setCells(rId, gridMain.getColIndexById('ordNo')).getValue();
		obj1.sdDt = gridMain.setCells(rId, gridMain.getColIndexById('sdDt')).getValue();
		obj1.empNo = gridMain.setCells(rId, gridMain.getColIndexById('empNo')).getValue();
		obj1.empNm = gridMain.setCells(rId, gridMain.getColIndexById('empNm')).getValue();
		obj1.custGubun = gridMain.setCells(rId, gridMain.getColIndexById('custGubun')).getValue();
		obj1.sdGubun = gridMain.setCells(rId, gridMain.getColIndexById('sdGubun')).getValue();
		obj1.sdGubunEtc = gridMain.setCells(rId, gridMain.getColIndexById('sdGubunEtc')).getValue();
		obj1.custNm = gridMain.setCells(rId, gridMain.getColIndexById('custNm')).getValue();
		obj1.custAddr = gridMain.setCells(rId, gridMain.getColIndexById('custAddr')).getValue();
		obj1.custTel = gridMain.setCells(rId, gridMain.getColIndexById('custTel')).getValue();
		obj1.inputRoute = gridMain.setCells(rId, gridMain.getColIndexById('inputRoute')).getValue();
		obj1.siteType = gridMain.setCells(rId, gridMain.getColIndexById('siteType')).getValue();
		obj1.siteElevator = gridMain.setCells(rId, gridMain.getColIndexById('siteElevator')).getValue();
		obj1.consultProduct1 = gridMain.setCells(rId, gridMain.getColIndexById('consultProduct1')).getValue();
		obj1.consultProduct2 = gridMain.setCells(rId, gridMain.getColIndexById('consultProduct2')).getValue();
		obj1.consultProduct3 = gridMain.setCells(rId, gridMain.getColIndexById('consultProduct3')).getValue();
		obj1.consultProduct4 = gridMain.setCells(rId, gridMain.getColIndexById('consultProduct4')).getValue();
		obj1.consultProductEtc = gridMain.setCells(rId, gridMain.getColIndexById('consultProductEtc')).getValue();
		obj1.custStat = gridMain.setCells(rId, gridMain.getColIndexById('custStat')).getValue();
		obj1.custStatNm = gridMain.setCells(rId, gridMain.getColIndexById('custStatNm')).getValue();
		obj1.deliveryDt = gridMain.setCells(rId, gridMain.getColIndexById('deliveryDt')).getValue();
		obj1.sigongYn = gridMain.setCells(rId, gridMain.getColIndexById('sigongYn')).getValue();
		obj1.sigongPayYn = gridMain.setCells(rId, gridMain.getColIndexById('sigongPayYn')).getValue();
		obj1.sigongDt = gridMain.setCells(rId, gridMain.getColIndexById('sigongDt')).getValue();
		obj1.callStat = gridMain.setCells(rId, gridMain.getColIndexById('callStat')).getValue();
		obj1.lifeType = gridMain.setCells(rId, gridMain.getColIndexById('lifeType')).getValue();
		obj1.lifeTypeEtc = gridMain.setCells(rId, gridMain.getColIndexById('lifeTypeEtc')).getValue();
		obj1.infoAgreYn = gridMain.setCells(rId, gridMain.getColIndexById('infoAgreYn')).getValue();
		obj1.consultCont = gridMain.setCells(rId, gridMain.getColIndexById('consultCont')).getValue();
		obj1.saleCode = gridMain.setCells(rId, gridMain.getColIndexById('saleCode')).getValue();
		obj1.custCd = gridMain.setCells(rId, gridMain.getColIndexById('custCd')).getValue();
		obj1.custSalNm = gridMain.setCells(rId, gridMain.getColIndexById('custSalNm')).getValue();

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
	$('#custGubun').val(obj.custGubun);
	$('#sdGubun').val(obj.sdGubun);
	document.getElementById("sdGubun").onchange();
	$('#sdGubunEtc').val(obj.sdGubunEtc);
	$('#custNm').val(obj.custNm);
	$('#custAddr').val(obj.custAddr);
	$('#custTel').val(obj.custTel);
	$('#inputRoute').val(obj.inputRoute);
	$('#siteType').val(obj.siteType);
	$('#siteElevator').val(obj.siteElevator);
	$('#consultProduct1').val(obj.consultProduct1);
	$('#consultProduct2').val(obj.consultProduct2);
	$('#consultProduct3').val(obj.consultProduct3);
	$('#consultProduct4').val(obj.consultProduct4);
	document.getElementById("consultProduct1").onchange();
	document.getElementById("consultProduct2").onchange();
	document.getElementById("consultProduct3").onchange();
	document.getElementById("consultProduct4").onchange();
	$('#consultProductEtc').val(obj.consultProductEtc);
	$('#custStat').val(obj.custStat);
	$('#deliveryDt').val(obj.deliveryDt);
	$('#sigongYn').val(obj.sigongYn);
	$('#sigongPayYn').val(obj.sigongPayYn);
	$('#sigongDt').val(obj.sigongDt);
	$('#callStat').val(obj.callStat);
	$('#lifeType').val(obj.lifeType);
	document.getElementById("lifeType").onchange();
	$('#lifeTypeEtc').val(obj.lifeTypeEtc);
	$('#infoAgreYn').val(obj.infoAgreYn);
	$('#consultCont').val(obj.consultCont);
	$('#saleCode').val(obj.saleCode);
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
	$('#custAddr').val("");
	$('#custTel').val("");
	$('#inputRoute').val("");
	$('#siteType').val("");
	$('#siteElevator').val("");
	$('#consultProduct1').val("");
	$('#consultProduct2').val("");
	$('#consultProduct3').val("");
	$('#consultProduct4').val("");
	$('#consultProductEtc').val("");
	$('#custStat').val("");
	$('#deliveryDt').val("");
	$('#sigongYn').val("");
	$('#sigongPayYn').val("");
	$('#sigongDt').val("");
	$('#callStat').val("");
	$('#lifeType').val("");
	document.getElementById("lifeType").onchange();
	$('#lifeTypeEtc').val("");
	$('#infoAgreYn').val("");
	$('#consultCont').val("");
	$('#saleCode').val("");
}

//저장
function fn_save(div){
	//저장하시겠습니까? 체크
	//상담일자 / 실측요청일자 / 시공희망일자 날짜 맞는지 확인 후 저장 처리
	var msg = "";
	var sdDt = searchDate($('#sdDt').val());
	var deliveryDt = searchDate($('#deliveryDt').val());
	var sigongDt = searchDate($('#sigongDt').val());
	
	if(sdDt!="") {
		msg += "상담날짜 : " + sdDt;
	}
	
	if(deliveryDt!="") {
		msg += "\n제품배송일자 : " + deliveryDt;
	}
	
	if(sigongDt!="") {
		msg += "\n시공희망일자 : " + sigongDt;
	}
	
	msg += "\n위와 같이 저장하시겠습니까?";
	
	if(MsgManager.confirmMsg("WRN020", msg)){
		var obj = {};
		obj.ordNo = $('#ordNo').val();
		obj.sdDt = $('#sdDt').val();
		obj.empNo = $('#empNo').val();
		obj.empNm = $('#empNm').val();
		obj.custGubun = $('#custGubun').val();
		obj.custGubunNm = $('#custGubunNm').val();
		obj.sdGubun = $('#sdGubun').val();
		obj.sdGubunEtc = $('#sdGubunEtc').val();
		obj.sdGubunNm = $('#sdGubunNm').val();
		obj.custNm = $('#custNm').val();
		obj.custAddr = $('#custAddr').val();
		obj.custTel = $('#custTel').val();
		obj.inputRoute = $('#inputRoute').val();
		obj.inputRouteNm = $('#inputRouteNm').val();
		obj.siteType = $('#siteType').val();
		obj.siteTypeNm = $('#siteTypeNm').val();
		obj.siteElevator = $('#siteElevator').val();
		obj.consultProduct1 = $('#consultProduct1').val();
		obj.consultProduct2 = $('#consultProduct2').val();
		obj.consultProduct3 = $('#consultProduct3').val();
		obj.consultProduct4 = $('#consultProduct4').val();
		obj.consultProductEtc = $('#consultProductEtc').val();
		obj.custStat = $('#custStat').val();
		obj.custStatNm = $('#custStatNm').val();
		obj.deliveryDt = $('#deliveryDt').val();
		obj.sigongYn = $('#sigongYn').val();
		obj.sigongYnNm = $('#sigongYnNm').val();
		obj.sigongPayYn = $('#sigongPayYn').val();
		obj.sigongPayYnNm = $('#sigongPayYnNm').val();
		obj.sigongDt = $('#sigongDt').val();
		obj.callStat = $('#callStat').val();
		obj.callStatNm = $('#callStatNm').val();
		obj.lifeType = $('#lifeType').val();
		obj.lifeTypeNm = $('#lifeTypeNm').val();
		obj.lifeTypeEtc = $('#lifeTypeEtc').val();
		obj.infoAgreYn = $('#infoAgreYn').val();
		obj.infoAgreYnNm = $('#infoAgreYnNm').val();
		obj.consultCont = $('#consultCont').val();
		obj.saleCode = $('#saleCode').val();
		obj.cid = $('#cid').val();
		obj.cdt = $('#cdt').val();
		obj.mid = $('#mid').val();
		obj.mdt = $('#mdt').val();
		obj.custCd = $('#custCd').val();
		obj.custSalNm = $('#custSalNm').val();
		
		//S 필수값체크[상담일자, 상담자, 판매채널, 고객구분, 상담구분, 고객명, 주소지, 연락처, 유입경로, 현장유형, 상담제품1~4 중 아무거나, 고객진행상태, 주거유형, 고객정보활용동의여부]
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
	 	//상담제품 1~4 필수값 체크
	 	if(obj.consultProduct1 == "" && obj.consultProduct2 == "" && obj.consultProduct3 == "" && obj.consultProduct4 == "") {
	 		MsgManager.alertMsg("WRN001","상담제품");	//{0}은(는) 필수입력 항목입니다.
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
		var url = "/erp/scm/inusBath/partners/custCard/custPrdCardS/report/reportSch.do";
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
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">상담구분<font color="red">*</font></label>
				<select name="sdGubun" id="sdGubun" class="searchBox" required style="width:126px; height:22px;" onchange="doEtcEnable(sdGubun)"></select>
			</div>
		</div>
		<div class="left">
			<div class="ml10">
				<input name="sdGubunEtc" id="sdGubunEtc" type="text" value="" class="inputbox1" maxlength="50" style="width:268px; height:22px;">
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
	</div>
	<div class="listHeader">
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
				<label class="wordTitle">■</label><label class="cardTitle">상담제품<font color="red">*</font></label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<select name="consultProduct1" id="consultProduct1" class="searchBox" style="width:100px; height:22px;" onchange="doPrdEtcEnable(consultProduct1);"></select>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<select name="consultProduct2" id="consultProduct2" class="searchBox" style="width:100px; height:22px;" onchange="doPrdEtcEnable(consultProduct2);"></select>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<select name="consultProduct3" id="consultProduct3" class="searchBox" style="width:100px; height:22px;" onchange="doPrdEtcEnable(consultProduct3);"></select>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<select name="consultProduct4" id="consultProduct4" class="searchBox" style="width:100px; height:22px;" onchange="doPrdEtcEnable(consultProduct4);"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">상담제품(기타)</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
			    <input name="consultProductEtc" id="consultProductEtc" type="text" value="" class="inputbox1" maxlength="50" style="width:404px; height:22px;"/>
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
				<label class="wordTitle">■</label><label for="deliveryDt" class="cardTitle">제품배송일자</label>
				<input name="deliveryDt" id="deliveryDt" type="text" value="" placeholder="" class="searchDate" style="width:94px; height:22px;">
				<input type="button" id="calpicker5" name="calpicker5" class="calicon inputCal">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label for="sigongYn" class="cardTitle">시공진행여부</label>
				<select name="sigongYn" id="sigongYn" class="searchBox" style="width:126px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label for="sigongPayYn" class="cardTitle">시공비결재여부</label>
				<select name="sigongPayYn" id="sigongPayYn" class="searchBox" style="width:126px; height:22px;"></select>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label for="sigongDt" class="cardTitle">시공진행일자</label>
				<input name="sigongDt" id="sigongDt" type="text" value="" placeholder="" class="searchDate" style="width:94px; height:22px;">
				<input type="button" id="calpicker6" name="calpicker6" class="calicon inputCal">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label class="wordTitle">■</label><label class="cardTitle">해피콜확인</label>
				<select name="callStat" id="callStat" class="searchBox" style="width:126px; height:22px;"></select>
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