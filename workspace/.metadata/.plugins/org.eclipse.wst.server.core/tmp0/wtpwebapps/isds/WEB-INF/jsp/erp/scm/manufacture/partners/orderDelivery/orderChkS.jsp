<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout;
var gridMain;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){
	Ubi.setContainer(3,[1,3,8],"1C");//발주확인등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"확인",       colId:"outsCon",    width:"50",  align:"center", type:"ch"});
    gridMain.addHeader({name:"순번",       colId:"no",         width:"50", align:"center",   type:"cntr"});
    gridMain.addHeader({name:"발주일자",    colId:"poDt",       width:"80", align:"center",   type:"ro"});
    gridMain.addHeader({name:"품목코드",    colId:"itmCd",      width:"70", align:"left",   type:"ro"});
    gridMain.addHeader({name:"품목명",     colId:"itmNm",      width:"150", align:"left",   type:"ro"});
    gridMain.addHeader({name:"규격",       colId:"spec",       width:"200", align:"left",   type:"ro"});
    gridMain.addHeader({name:"단위",       colId:"umBcNm",     width:"60",  align:"left",  type:"ro"});
    gridMain.addHeader({name:"발주수량",    colId:"poQty",      width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"발주단가",    colId:"poUp",       width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"발주금액",    colId:"poAmt",      width:"80",  align:"right", type:"ron"});
    gridMain.addHeader({name:"납기일자",    colId:"dlvDt",      width:"80", align:"center",   type:"ro"});
    gridMain.addHeader({name:"예정납기일자", colId:"outsDeliDt", width:"80", align:"center",   type:"ro"});
    gridMain.addHeader({name:"긴급구분",    colId:"urgBcNm",    width:"60", align:"center",   type:"ro"});
    gridMain.addHeader({name:"납풉수량",    colId:"outsDeliQty", width:"80", align:"right",   type:"ron"});
    gridMain.addHeader({name:"입고창고",    colId:"whNm",        width:"70", align:"center",   type:"ro"});
    gridMain.addHeader({name:"비고",       colId:"rmks",        width:"200", align:"left",   type:"ro"});
    gridMain.addHeader({name:"외주처비고",   colId:"outsRmk",     width:"200", align:"left",   type:"ed"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@poDt","format_date");
    gridMain.dxObj.setUserData("","@dlvDt","format_date");
    gridMain.dxObj.setUserData("","@outsDeliDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();  
    gridMain.cs_setNumberFormat(["poQty","outsDeliQty"],"0,000.000");
    gridMain.cs_setNumberFormat(["poUp","poAmt"]);
    gridMain.cs_setColumnHidden(["poNo","poSq","itmId","urgBc","inWh","umBc","custCd","custNm"]);
    gridMain.attachEvent("onCheck",doOnCheck);
    
    gfn_facCd_comboLoad("facCd","facCdSearch");
    
    $('input[name="outsCon"]:radio').change(function() { 
       	fn_search();
    });
    
    calMain = new dhtmlXCalendarObject([{input:"poStDt",button:"calpicker1"},{input:"poEdDt",button:"calpicker2"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var nowDate = dateformat(new Date());
	var legSetDate = new Date();
	legSetDate.setMonth(legSetDate.getMonth() + 1);
	legSetDate.setDate(legSetDate.getDate() - 10);
	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth())+'/'+fn_day(legSetDate.getDate());
	$('#poStDt').val(legDate);
	$('#poEdDt').val(nowDate);
	
    
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

function doOnCheck(rId,cInd,state){
	var deliQn = gridMain.setCells(rId,gridMain.getColIndexById("outsDeliQty")).getValue()*1;
	if(deliQn>0){
		dhtmlx.alert("납품등록된 내역은 취소할 수 없습니다.");
		if(!state){
			gridMain.setCells(rId,gridMain.getColIndexById("outsCon")).setValue("1");
		}
	}	
};

function fn_search(){
	var obj={};
	obj.facCd = $('#facCd').val();
	obj.poStDt = searchDate($('#poStDt').val());
	obj.poEdDt = searchDate($('#poEdDt').val());
	obj.outsCon = $('input:radio[name="outsCon"]:checked').val(); 
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
};

function fn_searchCB(data){
	if(data != ''){
		for(var i=0;i<gridMain.getRowsNum();i++){
			var qty = gridMain.setCells2(i,gridMain.getColIndexById("outsDeliQty")).getValue()*1;
				if(qty == 0){
					gridMain.setCellExcellType(gridMain.getRowId(i),gridMain.getColIndexById("outsDeliDt"),"dhxCalendarA");
				}
		}
	}
}

function fn_save(){
	//var jsonStr = gridMain.getJsonUpdated_chk(0);
	var jsonStr = gridMain.getJsonUpdated();
	if(jsonStr == null || jsonStr.length <= 0){ return;}  
	 $("#jsonData").val(jsonStr);
	 var params = $("#pForm").serialize();  
	 gfn_callAjaxComm(params,"gridMainSave",fn_search);		
};


function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};
</script>
<form id="pForm" name="pForm">
    <input type="hidden" name="jsonData" id="jsonData">
</form>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">발주등록기간</label>
				<input name="poStDt" id="poStDt" type="text" value="" placeholder="" class="searchDate" >
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'poEdDt', 'max')">~
				<input name="poEdDt" id="poEdDt" type="text" value="" placeholder="" class="searchDate" >
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'poStDt', 'min')">
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
				<select name="facCd" id="facCd" class="searchBox"></select>
			</div>
		</div>	
	</div>	
	<div class="listHeader">
		<div class="left">
				<div class="ml30">
					<label class="title1">구분</label>
					<input type="radio" name="outsCon" id="outsCon" value="all">전체
					<input type="radio" name="outsCon" id="outsCon" value="michk" checked="checked" >미확인
					<input type="radio" name="outsCon" id="outsCon" value="okchk" >확인
				</div>
			</div>
	</div>
</div>
<div id="container"></div>