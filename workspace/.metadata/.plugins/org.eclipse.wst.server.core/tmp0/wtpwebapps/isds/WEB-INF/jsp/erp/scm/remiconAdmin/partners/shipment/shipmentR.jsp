<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){
	//출하현황-송장출력
	//조회, 삭제, 엑셀, 인쇄, 종료
	Ubi.setContainer(2,[1,4,8,9],"1C");
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"NO"		, colId:"no"		, width:"40"	, height:"20"	, align:"center", type:"cntr"});
    gridMain.addHeader({name:"거래처코드"	, colId:"custCd"	, width:"70"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"매출거래처명"	, colId:"custNm"	, width:"100"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"현장명"		, colId:"fldNm"		, width:"100"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"운송번호"	, colId:"transNo"	, width:"120"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"운송사_거래처", colId:"tcustCd"	, width:"100"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"운송사명"	, colId:"tcustNm"	, width:"120"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"차량번호"	, colId:"carNo"		, width:"90"	, height:"20"	, align:"center", type:"ro"});
    gridMain.addHeader({name:"운전기사"	, colId:"drvNm"		, width:"70"	, height:"20"	, align:"center", type:"ro"});
    gridMain.addHeader({name:"수량"		, colId:"outQty"	, width:"60"	, height:"20"	, align:"right"	, type:"ron"});
    gridMain.addHeader({name:"중량"		, colId:"weightTot"	, width:"70"	, height:"20"	, align:"right"	, type:"ron"});
    gridMain.addHeader({name:"출하일자"	, colId:"outDt"		, width:"90"	, height:"20"	, align:"center", type:"ro"});
    gridMain.addHeader({name:"구분"		, colId:"salBcNm"	, width:"60"	, height:"20"	, align:"center", type:"ro"});
    gridMain.addHeader({name:"코드"		, colId:"itmCd"		, width:"80"	, height:"20"	, align:"center", type:"ro"});
    gridMain.addHeader({name:"명"		, colId:"itmNm"		, width:"120"	, height:"20"	, align:"center", type:"ro"});
    gridMain.addHeader({name:"품목"		, colId:"spec"		, width:"80"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"단가"		, colId:"outUp"		, width:"100"	, height:"20"	, align:"right"	, type:"ron"});
    gridMain.addHeader({name:"출고"		, colId:"outAmt"	, width:"80"	, height:"20"	, align:"right"	, type:"ron"});
    gridMain.addHeader({name:"#cspan"	, colId:"weightUp"	, width:"80"	, height:"20"	, align:"right"	, type:"ron"});
    gridMain.addHeader({name:"#cspan"	, colId:"mUp"		, width:"80"	, height:"20"	, align:"right"	, type:"ron"});
    gridMain.addHeader({name:"#cspan"	, colId:"jointUp"	, width:"80"	, height:"20"	, align:"right"	, type:"ron"});
    gridMain.addHeader({name:"#cspan"	, colId:"plateUp"	, width:"80"	, height:"20"	, align:"right"	, type:"ron"});
    gridMain.addHeader({name:"담당자"		, colId:"nm"		, width:"60"	, height:"20"	, align:"center", type:"ro"});
    gridMain.addHeader({name:"분류"		, colId:"grp1Nm"	, width:"70"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"grp2Nm"	, width:"70"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"타일"		, colId:"tcolorNm"	, width:"60"	, height:"20"	, align:"center", type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"tsizeNm"	, width:"60"	, height:"20"	, align:"center", type:"ro"});
    gridMain.addHeader({name:"#cspan"	, colId:"tgradeNm"	, width:"60"	, height:"20"	, align:"center", type:"ro"});
    gridMain.addHeader({name:"출발시간"	, colId:"mTime"		, width:"80"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"출고유형"	, colId:"outBcNm"	, width:"80"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"출고번호"	, colId:"outNo"		, width:"100"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"현장코드"	, colId:"fldCd"		, width:"80"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"구분"		, colId:"itmBcNm"	, width:"60"	, height:"20"	, align:"left"	, type:"ro"});
    gridMain.addHeader({name:"등록자"		, colId:"mnm"		, width:"70"	, height:"20"	, align:"left"	, type:"ro"});
    
    gridMain.attachHeader
    ("#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,규격,#rspan,금액,단가(톤당),M당단가,joint단가,보강판단가,#rspan,대분류,중분류,색상,사이즈,등급,#rspan,#rspan,#rspan,#rspan,#rspan,#rspan");
    
    
    gridMain.setUserData("","pk","");
    gridMain.cs_setNumberFormat(["outQty","weightTot"],"0,000.00");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setNumberFormat(["outUp","outAmt","weightUp","mUp","jointUp","plateUp"]); 
    gridMain.cs_setColumnHidden(["movNo"]);	//그리드에는 표시될 수 없지만 해당 그리드에서 갖고 있는 값을 표현해주는 곳
    
    gfn_facCd_comboLoad("facCd","facCdSearch");	//gfn_facCd_comboLoadAllOption는 전체 / gfn_facCd_comboLoad 본인이 해당하는 공장만
    
    calMain = new dhtmlXCalendarObject([{input:"outDtFr",button:"calpicker1"},{input:"outDtTo",button:"calpicker2"}
                                       ,{input:"nowDate",button:"calpicker3"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var nowDate = new Date();
	var t = dateformat(new Date());
	var legSetDate = new Date();
	var lastSetDate = new Date(nowDate.getYear(),nowDate.getMonth()+1,"");
	var lastDay = lastSetDate.getDate();
	
	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth() + 1)+'/'+fn_day(nowDate.getDate());
	var lastDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth() + 1)+'/'+lastDay;
	$('#outDtFr').val(legDate);
	$('#outDtTo').val(legDate);
	$('#nowDate').val(t);
    
// 	$('#certifiBtn').click(function(){
// 		certifiPrint();	//출고증 출력
//  	});
	
    fn_search();
    
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


function fn_search(){
	var obj = {};
	obj.facCd = $('#facCd').val();
	obj.outDtFr = searchDate($('#outDtFr').val());
	obj.outDtTo = searchDate($('#outDtTo').val());
	
	//S 필수값체크
	if(obj.facCd =="") {
		MsgManager.alertMsg("WRN001","출하공장");	//{0}은(는) 필수입력 항목입니다.
// 		dhtmlx.alert("공장선택은 필수입니다.");
		return false;
	}
	
	if(obj.facCd !="750") {
		dhtmlx.alert("중앙레미콘만 조회가  가능합니다.");
		return false;
	}
	
	if(obj.outDtFr =="" || obj.outDtTo =="") {
		MsgManager.alertMsg("WRN001","출하기간");	//{0}은(는) 필수입력 항목입니다.
// 		dhtmlx.alert("출하기간은 필수값입니다.");
		return false;
	}
	//E 필수값체크
	
	gfn_callAjaxForGridR(gridMain,obj,"gridMainSearch",subLayout.cells("a"), null);	// 마지막 null은 조회 콜백함수 위치
};

//삭제[fn_remove], 한줄삭제[fn_delete]
function fn_remove() {
	if(MsgManager.confirmMsg("INF002")){
		fn_removeCB();
	}else{
		return true;
	}
};

//삭제함수
function fn_removeCB(){
	//1. 선택된 row가 있는지 확인
	//2. 해당 row의 movNo와 transNo 두개 가져와서 테이블 순차적으로 삭제 [LEM150 > LEB200 > LEM100]
	//이때, LEB200은 transNo로, LEM150과 LEM100은 movNo로 삭제 [각 PK]
	var rId  = gridMain.getSelectedRowId();
	var movNo = "";
	var transNo = "";
	
	if(rId != null) {
		movNo = gridMain.setCells(rId, gridMain.getColIndexById('movNo')).getValue();		//이동번호
		transNo = gridMain.setCells(rId, gridMain.getColIndexById('transNo')).getValue();	//운송번호
	}
	
	if(rId == null){
		MsgManager.alertMsg("WRN002");	//선택된 항목이 없습니다.
		return true;
	} else {
		var obj = {};
		obj.movNo = movNo;
		obj.transNo = transNo;
		
		gfn_callAjaxComm(obj,"delGridMain",fn_search);
	}	
};

//인쇄
function fn_print(){
	//출력물 프로시져 파라미터 : 운송번호, 공장코드, 현장코드, 차량번호
	var rId  = gridMain.getSelectedRowId();
	var facCd = $('#facCd').val();	//공장코드
	var transNo = null;	//운송번호
	var fldCd = null;	//현장코드
	var carNo = null;	//차량번호
	
	if(rId != null) {
		transNo = gridMain.setCells(rId, gridMain.getColIndexById('transNo')).getValue();	//운송번호
		fldCd = gridMain.setCells(rId, gridMain.getColIndexById('fldCd')).getValue();		//현장코드
		carNo = gridMain.setCells(rId, gridMain.getColIndexById('carNo')).getValue();		//차량번호
	}
	
	if(facCd == null) {	//공장코드 필수 체크
		MsgManager.alertMsg("WRN001","출하공장");	//{0}은(는) 필수입력 항목입니다.
// 		dhtmlx.alert("공장선택은 필수입니다.");
		return true;
	} else if("750"!=facCd){	//공장코드가 중앙레미콘이 아닐 경우
		dhtmlx.alert("중앙레미콘만 출고증출력이  가능합니다.");
		return true;
	} else if(rId == null){	//Data 건수 체크
		dhtmlx.alert("출력할 항목이 없습니다.");
		return true;
	} else if(transNo == null){	//선택된 Data 운송번호 체크
		dhtmlx.alert("선택된 행에 운송번호가 없습니다.");
		return true;
	} else{
		$('#transNo').val(transNo);
		$('#fldCd').val(fldCd);
		$('#carNo').val(carNo);
		
		var url = "/erp/scm/remiconAdmin/partners/shipment/shipmentR/report/reportSch.do";
		url = url + "?transNo=" + $('#transNo').val();
		url = url + "&facCd=" + $('#facCd').val();
		url = url + "&fldCd=" + $('#fldCd').val();
		url = url + "&carNo=" + $('#carNo').val();
		url = url + "&nowDate=" + searchDate($('#nowDate').val());
		var agent = navigator.userAgent.toLowerCase();
		var divToPrint = "";
		var newWin = "";
		
		//20180705 ryul 크롬에서는 인쇄 팝업까지 바로 출력이 되는데 IE에서는 해당 내용이 실행이 안됨
		//우선 크롬에서는 인쇄팝업까지, IE에서는 출력물만 나오도록 함
		if ( (navigator.appName == 'Netscape' && navigator.userAgent.search('Trident') != -1) || (agent.indexOf("msie") != -1) ) {
			window.open(url,'rpt', '');
// 			divToPrint = document.getElementById('printArea');
// 			newWin = window.open(url,'rpt', '');
// 			newWin.document.write(divToPrint.innerHTML);
// 			newWin.document.close();
// 			newWin.focus();
// 			newWin.print();
// 			newWin.close();
		} else {
			newWin = window.open(url,'rpt', '');
			newWin.window.print();
		}
	}
}

//출고증 출력
function certifiPrint(){
	//출력물 프로시져 파라미터 : 운송번호, 공장코드, 현장코드, 차량번호
	var rId  = gridMain.getSelectedRowId();
	var facCd = $('#facCd').val();	//공장코드
	var transNo = null;	//운송번호
	var fldCd = null;	//현장코드
	var carNo = null;	//차량번호
	
	if(rId != null) {
		transNo = gridMain.setCells(rId, gridMain.getColIndexById('transNo')).getValue();	//운송번호
		fldCd = gridMain.setCells(rId, gridMain.getColIndexById('fldCd')).getValue();		//현장코드
		carNo = gridMain.setCells(rId, gridMain.getColIndexById('carNo')).getValue();		//차량번호
	}
	
	if(facCd == null) {	//공장코드 필수 체크
		MsgManager.alertMsg("WRN001","출하공장");	//{0}은(는) 필수입력 항목입니다.
// 		dhtmlx.alert("공장선택은 필수입니다.");
		return true;
	} else if("750"!=facCd){	//공장코드가 중앙레미콘이 아닐 경우
		dhtmlx.alert("중앙레미콘만 출고증출력이  가능합니다.");
		return true;
	} else if(rId == null){	//Data 건수 체크
		dhtmlx.alert("출력할 항목이 없습니다.");
		return true;
	} else if(transNo == null){	//선택된 Data 운송번호 체크
		dhtmlx.alert("선택된 행에 운송번호가 없습니다.");
		return true;
	} else{
		$('#transNo').val(transNo);
		$('#fldCd').val(fldCd);
		$('#carNo').val(carNo);
		
		var url = "/erp/scm/remiconAdmin/partners/shipment/shipmentR/report/reportSch.do";
		url = url + "?transNo=" + $('#transNo').val();
		url = url + "&facCd=" + $('#facCd').val();
		url = url + "&fldCd=" + $('#fldCd').val();
		url = url + "&carNo=" + $('#carNo').val();
		url = url + "&nowDate=" + searchDate($('#nowDate').val());
		
		window.open(url,'rpt', '');
	}
}


//종료
function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};
</script>
<div id="printArea"></div>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">출하기간</label>
				<input name="outDtFr" id="outDtFr" type="text" value="" placeholder="" class="searchDate" required>
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'outDtTo', 'max')"> ~ 
				<input name="outDtTo" id="outDtTo" type="text" value="" placeholder="" class="searchDate" required>
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'outDtFr', 'min')">
			</div>
		</div>
		<div class="left" hidden="true">
			<div class="mlZero">
				<label class="title1">발행일자</label>
				<input name="nowDate" id="nowDate" type="text" value="" placeholder="" class="searchDate" disabled onkeydown="event.preventDefault()">
				<label class="title1">운송번호</label>
				<input name="transNo" id="transNo" type="text" value="" placeholder="" disabled onkeydown="event.preventDefault()">
				<label class="title1">현장코드</label>
				<input name="fldCd" id="fldCd" type="text" value="" placeholder="" disabled onkeydown="event.preventDefault()">
				<label class="title1">차량번호</label>
				<input name="carNo" id="carNo" type="text" value="" placeholder="" disabled onkeydown="event.preventDefault()">
<!-- 				<input name="nowDate" id="nowDate" type="text" value="" placeholder="" class="searchDate"> -->
<!-- 				<input type="button" id="calpicker3" name="calpicker3" class="calicon inputCal"> -->
			</div>
		</div>
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">출하공장</label>
				<select name="facCd" id="facCd" class="searchBox" required></select>
			</div>
		</div>	
<!-- 		<div class="left"> -->
<!-- 			<div class="ml30"> -->
<!-- 				<button name="certifiBtn" id="certifiBtn" value="" class="btn4">출고증출력</button> -->
<!-- 			</div> -->
<!-- 		</div> -->
	</div>
</div>
<div id="container"></div>