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
	Ubi.setContainer(2,[1,8,9],"1C"); //납품현황
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"납품일자",  colId:"deliDt",    width:"80",  align:"center",  type:"ro"});
    gridMain.addHeader({name:"순번",     colId:"deliSeq",   width:"60",  align:"center",  type:"ro"});
    gridMain.addHeader({name:"발주번호",  colId:"poNo",    width:"110", align:"left",    type:"ro"});
    gridMain.addHeader({name:"품목구분",   colId:"etcKindNm", width:"60", align:"center",   type:"ro"});
    gridMain.addHeader({name:"품목코드", colId:"itemCd",     width:"70",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"품명",    colId:"kitemDs",    width:"150",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"규격",    colId:"itemSz",     width:"150", align:"left",    type:"ro"});
    gridMain.addHeader({name:"단위",    colId:"itemUt",     width:"70",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"배정수량", colId:"balAsgnQty", width:"90",  align:"right",   type:"ron"});
    gridMain.addHeader({name:"납품수량", colId:"deliQty",    width:"90",  align:"right",   type:"ron"});
    gridMain.addHeader({name:"납품단가", colId:"etcUp",     width:"90",  align:"right",   type:"ron"});
    gridMain.addHeader({name:"납품금액", colId:"etcAm",     width:"90",  align:"right",   type:"ron"});
    gridMain.addHeader({name:"납기일자", colId:"deliveryDt", width:"80",  align:"center",  type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@deliDt","format_date");
    gridMain.dxObj.setUserData("","@deliveryDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["deliSubSeq","miDeliQty","deliSeqF","itemQn","deliNo","siteCd","siteDs","etcKind","etcReqNo","etcCd"]);
    gridMain.cs_setNumberFormat(["itemQn","miDeliQty","deliQty"],"0,000.000"); 
    gridMain.cs_setNumberFormat(["etcUp","etcAm"]); 
    gridMain.attachEvent("onRowDblClicked",doOnRowDbClicked);
    
    calMain = new dhtmlXCalendarObject([{input:"stBalDt",button:"calpicker1"},{input:"edBalDt",button:"calpicker2"}
                                        ,{input:"nowDate",button:"calpicker3"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var nowDate = new Date();
	var t = dateformat(new Date());
	var legSetDate = new Date();
	var lastSetDate = new Date(nowDate.getYear(),nowDate.getMonth()+1,"");
	var lastDay = lastSetDate.getDate();

	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth()+1)+'/'+"01";
	var lastDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth()+1)+'/'+lastDay;
	$('#stBalDt').val(legDate);
	$('#edBalDt').val(lastDate);
	$('#nowDate').val(t);
	
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

function doOnRowDbClicked(rId,cInd){
	var toMenucd = "0000000013";
	var idx = ["siteCd","deliSeq","deliDt","siteDs"];
	var param = fn_dbl_params(idx,gridMain,rId,toMenucd);
	gfn_moveMenu(toMenucd, param);
};

function fn_search(){
	var obj = {};
	obj.siteCd = $('#siteCd').val();
	obj.stBalDt = searchDate($('#stBalDt').val());
	obj.edBalDt = searchDate($('#edBalDt').val());
	gfn_callAjaxForGridR(gridMain,obj,"gridMainSearch",subLayout.cells("a"));
};

function fn_print(){
	var rowsNum = gridMain.getRowsNum();
	if(rowsNum == 0){
		dhtmlx.alert("출력할 내역이 없습니다.");
		return true;
	}else{
		var url = "/erp/scm/work/partners/orderDelivery/deliveryR/report/reportSch.do";
		url = url + "?siteCd=" + $('#siteCd').val();
		url = url + "&stBalDt=" + searchDate($('#stBalDt').val());
		url = url + "&edBalDt=" + searchDate($('#edBalDt').val());
		url = url + "&nowDate=" + searchDate($('#nowDate').val());
		window.open(url,'rpt','');
	}
}

function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};

function fn_onClosePop(pName,data){
	 if(pName == "siteCd"){
		 $('#siteCd').val(data[0].siteCd);
		 $('#siteNm').val(data[0].siteNm);
		 $('#siteCd').focus();
	 }
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
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}" class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}" class="inputbox3" onkeydown="event.preventDefault()" readonly="readonly">
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<label class="title1">발행일자</label>
				<input name="nowDate" id="nowDate" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker3" name="calpicker3" class="calicon inputCal">
			</div>
		</div>
	</div>
</div>
<div id="container"></div>