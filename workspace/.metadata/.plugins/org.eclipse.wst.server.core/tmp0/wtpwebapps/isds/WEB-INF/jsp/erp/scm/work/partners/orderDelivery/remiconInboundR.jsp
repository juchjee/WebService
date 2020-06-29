<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){//입고마감현황
	Ubi.setContainer(3,[1,8],"1C");
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
    
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"송장일자",  colId:"invoiceDt",    width:"80",  align:"center",  type:"ro"});
	gridMain.addHeader({name:"현장코드",    colId:"siteCd",   width:"60",     align:"left",   type:"ro"});
    gridMain.addHeader({name:"현장명",      colId:"siteDs",   width:"120",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"발주서번호",   colId:"poNo",     width:"90",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"청구서번호",   colId:"mrNo",     width:"90",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"견적의뢰번호",  colId:"inqNo",    width:"90",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"송장번호",    colId:"invoiceNo", width:"90",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"거래처코드",   colId:"custCd",   width:"80",    align:"left",    type:"ro"});
    gridMain.addHeader({name:"거래처명",    colId:"custDs",    width:"180",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"RFID_NO",   colId:"rfidNo",    width:"100",   align:"left",    type:"ro"});
    gridMain.addHeader({name:"RFID순번",   colId:"rfidsqNo",  width:"70",   align:"center",  type:"ro"});
    gridMain.addHeader({name:"품목코드",    colId:"itemCd",    width:"70",   align:"left",    type:"ro"});
    gridMain.addHeader({name:"품명",       colId:"kitemDs",    width:"80",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"규격",       colId:"itemSz",     width:"80", align:"left",    type:"ro"});
    gridMain.addHeader({name:"배정수량",    colId:"balAsgnQty",   width:"60",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"납품수량",    colId:"itemQn",     width:"60",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"입고수량",    colId:"invoiceQn",  width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"미입고수량",  colId:"miInvoiceQn", width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"배정마감구분", colId:"endYn",      width:"80",  align:"center",  type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@deliDt","format_date");
    gridMain.dxObj.setUserData("","@deliveryDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setNumberFormat(["itemQn","balAsgnQty"]);
    gridMain.cs_setNumberFormat(["invoiceQn","miInvoiceQn"],"0,000.000"); 
    
    $('input[name="gubn"]:radio').change(function() { 
       	fn_search();
    });
    
    calMain = new dhtmlXCalendarObject([{input:"stBalDt",button:"calpicker1"},{input:"edBalDt",button:"calpicker2"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var nowDate = new Date();
	var legSetDate = new Date();
	var lastSetDate = new Date(nowDate.getYear(),nowDate.getMonth()+1,"");
	var lastDay = lastSetDate.getDate();
	
	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth() + 1)+'/'+"01";
	var lastDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth() + 1)+'/'+lastDay;
	$('#stBalDt').val(legDate);
	$('#edBalDt').val(lastDate);
    
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
	obj.stBalDt = searchDate($('#stBalDt').val());
	obj.edBalDt = searchDate($('#edBalDt').val());
	obj.gubn = $('input:radio[name="gubn"]:checked').val(); 
	obj.siteCd = $('#siteCd').val();
	gfn_callAjaxForGridR(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
};

function fn_searchCB(data){
	if(data != ''){
		for(var i=0;i<gridMain.getRowsNum();i++){
			gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("miInvoiceQn")).setBgColor('#FFBB00');  
		}
	}
};

function fn_onClosePop(pName,data){
	   if(pName == "siteCd"){
		   $('#siteCd').val(data[0].siteCd);
		   $('#siteNm').val(data[0].siteNm);
		   $('#siteCd').focus();
		 }
};
	
function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};
</script>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">기간</label>
				<input name="stBalDt" id="stBalDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'edBalDt', 'max')"> ~ 
				<input name="edBalDt" id="edBalDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'stBalDt', 'min')">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">입고구분</label>
				<input type="radio" name="gubn" id="gubn" value="miIn" checked="checked">미입고
				<input type="radio" name="gubn" id="gubn" value="in">입고
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}" class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}" class="inputbox3" onkeydown="event.preventDefault()" readonly="readonly">
			</div>
		</div>
	</div>	
</div>
<div id="container"></div>