<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){//납품현황
	Ubi.setContainer(2,[1,8],"1C");
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"NO",     colId:"no",        width:"60",  align:"center",  type:"cntr"});
    gridMain.addHeader({name:"납품일자",  colId:"deliDate", width:"80",   align:"center",  type:"ro"});
    gridMain.addHeader({name:"발주번호",  colId:"poNo",     width:"120",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"품목코드",  colId:"itmCd",    width:"90",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"품명",     colId:"itmNm",    width:"180",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"규격",     colId:"spec",     width:"180",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"단위",     colId:"umBcNm",   width:"70",   align:"left",    type:"ro"});
    gridMain.addHeader({name:"발주수량",  colId:"poQty",    width:"70",   align:"right",   type:"ron"});
    gridMain.addHeader({name:"납품수량",  colId:"deliQty",  width:"80",   align:"right",   type:"ron"});
    gridMain.addHeader({name:"납기일자",  colId:"dlvDt",    width:"80",   align:"center",  type:"ro"});
    gridMain.addHeader({name:"비고",    colId:"rmks",      width:"200",   align:"left",  type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@deliDate","format_date");
    gridMain.dxObj.setUserData("","@dlvDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["deliKey","deliSeq","deliNo","poFac","itmId","custCd","custNm"]);
    gridMain.cs_setNumberFormat(["poQty","deliQty"],"0,000.000"); 
    gridMain.attachEvent("onRowDblClicked",doOnRowDbClicked);

   gfn_facCd_comboLoad("facCd","facCdSearch");
   
   calMain = new dhtmlXCalendarObject([{input:"stDeliDate",button:"calpicker1"},{input:"edDeliDate",button:"calpicker2"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var nowDate = dateformat(new Date());
	var legSetDate = new Date();
	legSetDate.setMonth(legSetDate.getMonth() + 1);
	legSetDate.setDate(legSetDate.getDate() - 10);
	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth())+'/'+fn_day(legSetDate.getDate());
	$('#stDeliDate').val(legDate);
	$('#edDeliDate').val(nowDate);
	
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
	var toMenucd = "0000000023";
	var idx = ["deliDate","deliSeq","poFac"];
	var param = fn_dbl_params(idx,gridMain,rId,toMenucd);
	gfn_moveMenu(toMenucd, param);
};

function fn_search(){
	var obj = {};
	obj.facCd = $('#facCd').val();
	obj.stDeliDate = searchDate($('#stDeliDate').val());
	obj.edDeliDate = searchDate($('#edDeliDate').val());
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
};

function fn_searchCB(data){
	if(data != ''){
		fn_multiRowMerge2(gridMain, 1,8);
	}
}

function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};
</script>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">납품등록기간</label>
				<input name="stDeliDate" id="stDeliDate" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'edDeliDate', 'max')"> ~ 
				<input name="edDeliDate" id="edDeliDate" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'stDeliDate', 'min')">
			</div>
		</div>
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">공장코드</label>
			</div>
		</div>		
		<div class="left">
			<div class="mlZero">
				<select name="facCd" id="facCd" class="searchBox">
				<option></option>
				</select>
			</div>
		</div>	
	</div>
</div>
<div id="container"></div>