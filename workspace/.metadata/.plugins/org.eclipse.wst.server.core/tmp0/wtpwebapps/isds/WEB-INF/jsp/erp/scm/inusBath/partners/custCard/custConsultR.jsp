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
	//조회, 삭제, 엑셀, 인쇄, 종료
	Ubi.setContainer(1,[1,8,9],"1C");
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
    layout.cells("b").attachObject("schContainer");
    
	subLayout.cells("a").showHeader();
    subLayout.cells("a").setText("고객상담내역");
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
    gridMain.addHeader({name:"공사유형"	, colId:"constructTypeNm"	, width:"180"	, height:"20"	, align:"left"		, type:"ro"});
    gridMain.addHeader({name:"해피콜확인"	, colId:"callStatNm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"고객진행상태"	, colId:"custStatNm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
    gridMain.addHeader({name:"실측요청일자"	, colId:"requestDt"			, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
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
    
    calMain = new dhtmlXCalendarObject([{input:"sdFrDt",button:"calpicker1"},{input:"sdToDt",button:"calpicker2"},{input:"schSdDt",button:"calpicker3"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	
	var nowDate = new Date();
	var BefDate = nowDate.setDate(nowDate.getDate()-30);	//30일 전
	var t = dateformat(new Date());
	var legSetDate = new Date();
	
	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth() + 1)+'/'+fn_day(legSetDate.getDate());	//오늘
	var befMonth = nowDate.getFullYear() + '/' + fn_month(nowDate.getMonth() + 1)+'/'+fn_day(nowDate.getDate());	//30일 전
	
	$('#sdFrDt').val(befMonth);
	$('#sdToDt').val(legDate);
	
	//콤보박스 설정
	var param = {};
	param.mainCd = "AS519";
    gfn_baseCd_comboLoadOption(param, "schGubun", "baseCdSearch", "", "선택", fn_returnComboList);
    
    param.mainCd = "AS500";
    gfn_baseCd_comboLoadOption(param, "schCustGubun", "baseCdSearch", "Y", "", fn_returnComboList);

	param.mainCd = "AS518";	//세트/구매별 상담구분
    gfn_baseCd_comboLoadOption(param, "schSdGubun", "baseCdSearch", "Y", "", fn_returnComboList);
	
	$('#schGubun').val("AS519100");	//세트로 셋팅
	$('#schGubun').focus();
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

//조회
function fn_search(div){
	var obj = {};
	obj.gubun = $('#schGubun').val();
	obj.sdFrDt = searchDate($('#sdFrDt').val());	//상담기간(시작)
	obj.sdToDt = searchDate($('#sdToDt').val());	//상담기간(종료)
	obj.custNm = $('#schCustNm').val();
	
	//S 필수값체크
	if(obj.gubun == "") {
		MsgManager.alertMsg("WRN001","구분");	//{0}은(는) 필수입력 항목입니다.
		return false;
	}
	
	if(obj.sdFrDt == "" || obj.sdToDt == "") {
		MsgManager.alertMsg("WRN001","상담기간");	//{0}은(는) 필수입력 항목입니다.
		return false;
	}
	//E 필수값체크
	
	doSetGrid(obj.gubun);
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"), null);
};

function doSetGrid(gubun) {
	subLayout.cells("a").showHeader();
    subLayout.cells("a").setText("고객상담내역");
    gridMain = new dxGrid(subLayout.cells("a"),false);
    
	if("AS519100"==gubun) {
		gridMain.addHeader({name:"No"		, colId:"seq"				, width:"40"	, height:"20"	, align:"center"	, type:"ron"});
		gridMain.addHeader({name:"상담일자"	, colId:"sdDt"				, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
	    gridMain.addHeader({name:"고객명"		, colId:"custNm"			, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
	    gridMain.addHeader({name:"연락처"		, colId:"custTel"			, width:"100"	, height:"20"	, align:"left"		, type:"ro"});
	    gridMain.addHeader({name:"주소지"		, colId:"custAddr"			, width:"200"	, height:"20"	, align:"left"		, type:"ro"});
	    gridMain.addHeader({name:"고객구분"	, colId:"custGubunNm"		, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
	    gridMain.addHeader({name:"상담구분"	, colId:"sdGubunNm"			, width:"120"	, height:"20"	, align:"left"		, type:"ro"});
	    gridMain.addHeader({name:"현장유형"	, colId:"siteTypeNm"		, width:"90"	, height:"20"	, align:"left"		, type:"ro"});
	    gridMain.addHeader({name:"엘리베이터"	, colId:"siteElevatorNm"	, width:"70"	, height:"20"	, align:"center"	, type:"ro"});
	    gridMain.addHeader({name:"공사유형"	, colId:"constructTypeNm"	, width:"180"	, height:"20"	, align:"left"		, type:"ro"});
	    gridMain.addHeader({name:"해피콜확인"	, colId:"callStatNm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
	    gridMain.addHeader({name:"고객진행상태"	, colId:"custStatNm"		, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
	    gridMain.addHeader({name:"실측요청일자"	, colId:"requestDt"			, width:"90"	, height:"20"	, align:"center"	, type:"ro"});
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
	} else if("AS519200"==gubun) {
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
	}
	
	gridMain.setUserData("","pk","ordNo");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
	gridMain.cs_setColumnHidden(["ordNo"]);
}

//인쇄
function fn_print(){
	var gubun = $('#schGubun').val();
	var rId  = gridMain.getSelectedRowId();
	var ordNo = null;
	var url = null;
	
	if(rId != null) {
		ordNo = gridMain.setCells(rId, gridMain.getColIndexById('ordNo')).getValue();	//고객/주문번호
	}
	
	if(ordNo == null || ordNo == "") {	//공장코드 필수 체크
		dhtmlx.alert("출력할 항목이 없습니다.");
		return true;
	} else{
		if("AS519100"==gubun) {
			url = "/erp/scm/inusBath/partners/custCard/custSetCardS/report/reportSch.do";
		} else if("AS519200"==gubun) {
			url = "/erp/scm/inusBath/partners/custCard/custPrdCardS/report/reportSch.do";
		}
		
		url = url + "?ordNo=" + ordNo;
		window.open(url,'rpt', '');
	}
};

//종료
function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};
</script>
<div id="schContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml20">
				<label for="schGubun" class="cardTitle2">구분<font color="red">*</font></label>
				<select name="schGubun" id="schGubun" class="searchBox" required style="width:120px; height:22px;"></select>
			</div>
		</div>
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
<!-- 		<div class="left"> -->
<!-- 			<div class="ml20"> -->
<!-- 				<label for="sdFrDt" class="cardTitle2">고객구분</label> -->
<!-- 				<select name="custGubun" id="schCustGubun" class="searchBox" required style="width:120px; height:22px;"></select> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="left"> -->
<!-- 			<div class="ml20"> -->
<!-- 				<label for="sdFrDt" class="cardTitle2">상담구분</label> -->
<!-- 				<select name="sdGubun" id="schSdGubun" class="searchBox" required style="width:120px; height:22px;"></select> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<div class="left"> -->
<!-- 			<div class="ml20"> -->
<!-- 				<label class="cardTitle2">상담자<font color="red">*</font></label> -->
<%-- 				<input name="schEmpNo" id="schEmpNo" type="text" value="${schEmpNo}" class="searchCode" style="width:55px; height:22px;" onchange="doOnValueChangedSearch(schEmpNo)"> --%>
<%-- 				<input name="schEmpNm" id="schEmpNm" type="text" value="${schEmpNm}" class="inputbox1" readonly="readonly" style="width:150px; height:22px;" onkeydown="event.preventDefault()"> --%>
<!-- 			</div> -->
<!-- 		</div> -->
		<div class="left">
			<div class="ml20">
				<label class="cardTitle2">고객명</label>
				<input name="schCustNm" id="schCustNm" type="text" value="" class="inputbox1" maxlength="100">
			</div>
		</div>
	</div>
</div>
<div id="container"></div>