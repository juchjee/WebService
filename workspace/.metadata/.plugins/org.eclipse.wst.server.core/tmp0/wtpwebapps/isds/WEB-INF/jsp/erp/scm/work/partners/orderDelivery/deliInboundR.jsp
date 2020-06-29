<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){//납품대비 입고현황(일반)
	Ubi.setContainer(3,[1,8],"1C");
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
	gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"납품일자",  colId:"deliDt",    width:"80",  align:"center",  type:"ro"});
    gridMain.addHeader({name:"순번",     colId:"deliSeq",   width:"60",  align:"center",  type:"ro"});
    gridMain.addHeader({name:"발주번호",  colId:"deliNo",    width:"110", align:"left",    type:"ro"});
    gridMain.addHeader({name:"품목구분",  colId:"etcKindNm",  width:"70",  align:"center",  type:"ro"});
    gridMain.addHeader({name:"품목코드",  colId:"itemCd",     width:"70",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"품명",     colId:"kitemDs",    width:"150",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"규격",     colId:"itemSz",     width:"150", align:"left",    type:"ro"});
    gridMain.addHeader({name:"단위",     colId:"itemUt",     width:"70",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"배정수량",  colId:"balAsgnQty", width:"90",  align:"right",   type:"ron"});
    gridMain.addHeader({name:"납품수량",  colId:"deliQty",    width:"90",  align:"right",   type:"ron"});
    gridMain.addHeader({name:"납기일자",  colId:"deliveryDt", width:"80",  align:"center",  type:"ro"});
    gridMain.addHeader({name:"입고수량",  colId:"invoiceQn",  width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"미입고수량", colId:"miInvoiceQn", width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"배정마감구분", colId:"endYn",      width:"80",  align:"center",  type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@deliDt","format_date");
    gridMain.dxObj.setUserData("","@deliveryDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["deliSubSeq","miDeliQty","deliSeqF","itemQn","siteCd","siteDs","etcKind"]);
    gridMain.cs_setNumberFormat(["itemQn","miDeliQty","deliQty","invoiceQn","miInvoiceQn"],"0,000.000"); 
    

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
	
    $('input[name="gubn"]:radio').change(function() { 
       	fn_search();
    });
    
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