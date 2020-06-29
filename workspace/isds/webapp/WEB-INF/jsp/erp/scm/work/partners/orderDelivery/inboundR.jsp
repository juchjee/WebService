<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){//발주입고현황
	Ubi.setContainer(2,[1,8,9],"1C");
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"송장번호",   colId:"invoiceNo", width:"90",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"회계일자",   colId:"accountDt", width:"80",   align:"center", type:"ro"});
    gridMain.addHeader({name:"발행일자",   colId:"invoiceDt", width:"80",   align:"center", type:"ro"});
    gridMain.addHeader({name:"거래처코드", colId:"custCd",     width:"80",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"거래처명",  colId:"custDs",     width:"130",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"현장코드",  colId:"siteCd",     width:"60",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"현장명",   colId:"siteDs",     width:"130",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"발행금액",  colId:"invoiceAm", width:"100",  align:"right",   type:"ron"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@accountDt","format_date");
    gridMain.dxObj.setUserData("","@invoiceDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setNumberFormat(["invoiceAm"]); 
    gridMain.cs_setColumnHidden(["slipYn"]);
    
    calMain = new dhtmlXCalendarObject([{input:"stInvoiceDt",button:"calpicker1"},{input:"edInvoiceDt",button:"calpicker2"}
                                       ,{input:"nowDate",button:"calpicker3"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var nowDate = new Date();
	var t = dateformat(new Date());
	var legSetDate = new Date();
	var lastSetDate = new Date(nowDate.getYear(),nowDate.getMonth()+1,"");
	var lastDay = lastSetDate.getDate();

	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth() + 1)+'/'+"01";
	var lastDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth() + 1)+'/'+lastDay;
	$('#stInvoiceDt').val(legDate);
	$('#edInvoiceDt').val(lastDate);
	$('#nowDate').val(t);
    
    $('#invoiceBtn').click(function(){
 		movePage();
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

function movePage(){
	var rId  = gridMain.getSelectedRowId();
	if(rId == null){
		dhtmlx.alert("송장자료를 선택해주세요");
		return true;
	}else{
		var cFlag = true;
		var preId = "1000000026";
	    var uri = "erp/scm/work/partners/orderDelivery/inboundDetailR";
		var invoiceNo = gridMain.setCells(rId,gridMain.getColIndexById("invoiceNo")).getValue();
		
		var param = "?invoiceNo="+invoiceNo;
		var ids = mainTabbar.getAllTabs();
		
		for(var i=0;i<ids.length;i++){
			if(ids[i] == preId){
				if(MsgManager.confirmMsg("INF006")) { 
					mainTabbar.tabs(preId).detachObject(true);
					mainTabbar.tabs(preId).attachURL("/"+uri+".do"+param);
					mainTabbar.tabs(preId).setActive();
					cFlag = false;
					break;
				}else{
					cFlag = false;
					return;
				}
			}
		}
		
		if(cFlag){
			mainTabbar.addTab(preId, "송장상세내역", null, null, true, true);
			mainTabbar.tabs(preId).attachURL("/"+uri+".do"+param);		
		}
	}
};

function fn_search(){
	var obj = {};
	obj.siteCd = $('#siteCd').val();
	obj.stInvoiceDt = searchDate($('#stInvoiceDt').val());
	obj.edInvoiceDt = searchDate($('#edInvoiceDt').val());
	gfn_callAjaxForGridR(gridMain,obj,"gridMainSearch",subLayout.cells("a"));
};

function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};

function fn_print(){
	var rowsNum = gridMain.getRowsNum();
	if(rowsNum == 0){
		dhtmlx.alert("출력할 내역이 없습니다.");
		return true;
	}else{
		var url = "/erp/scm/work/partners/orderDelivery/inboundR/report/reportSch.do";
		url = url + "?siteCd=" + $('#siteCd').val();
		url = url + "&stInvoiceDt=" + searchDate($('#stInvoiceDt').val());
		url = url + "&edInvoiceDt=" + searchDate($('#edInvoiceDt').val());
		url = url + "&nowDate=" + searchDate($('#nowDate').val());
		window.open(url,'rpt','');
	}
}

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
				<input name="stInvoiceDt" id="stInvoiceDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'edInvoiceDt', 'max')"> ~ 
				<input name="edInvoiceDt" id="edInvoiceDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'stInvoiceDt', 'min')">
			</div>
		</div>
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}" class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}" class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<label class="title1">발행일자</label>
				<input name="nowDate" id="nowDate" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker3" name="calpicker3" class="calicon inputCal">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<button name="invoiceBtn" id="invoiceBtn" value="" class="btn4">송장상세내역</button>
			</div>
		</div>
	</div>
</div>
<div id="container"></div>