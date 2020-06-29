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
	Ubi.setContainer(3,[1,8],"1C");//발주확인현황
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");

    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"확인",     colId:"outsCon", width:"60",  align:"center", type:"ro"});
    gridMain.addHeader({name:"발주일자",  colId:"poDt",    width:"80", align:"center",   type:"ro"});
    gridMain.addHeader({name:"품목코드",  colId:"itmCd",   width:"70", align:"left",   type:"ro"});
    gridMain.addHeader({name:"품목명",   colId:"itmNm",   width:"150", align:"left",   type:"ro"});
    gridMain.addHeader({name:"규격",    colId:"spec",    width:"200",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"단위",    colId:"umBcNm",  width:"60",  align:"left",  type:"ro"});
    gridMain.addHeader({name:"발주수량", colId:"poQty",   width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"발주단가", colId:"poUp",    width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"발주금액", colId:"poAmt",   width:"80",  align:"right", type:"ron"});
    gridMain.addHeader({name:"납기일자", colId:"dlvDt",   width:"80", align:"center",   type:"ro"});
    gridMain.addHeader({name:"긴급구분", colId:"urgBcNm", width:"60", align:"center",   type:"ro"});
    gridMain.addHeader({name:"입고창고", colId:"whNm",    width:"70", align:"center",   type:"ro"});
    gridMain.addHeader({name:"비고",    colId:"rmks",    width:"150", align:"left",   type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@poDt","format_date");
    gridMain.dxObj.setUserData("","@dlvDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();  
    gridMain.cs_setNumberFormat(["poQty"],"0,000.000");
    gridMain.cs_setNumberFormat(["poUp","poAmt"]);
    gridMain.cs_setColumnHidden(["poNo","poSq","itmId","urgBc","inWh","umBc","custCd","custNm"]);
    
    gfn_facCd_comboLoad("facCd","facCdSearch");
    
    $('input[name="outsCon"]:radio').change(function() { 
       	fn_search();
    });
    
    calMain = new dhtmlXCalendarObject([{input:"stPoDt",button:"calpicker1"},{input:"edPoDt",button:"calpicker2"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var nowDate = dateformat(new Date());
	var legSetDate = new Date();
	legSetDate.setMonth(legSetDate.getMonth() + 1);
	legSetDate.setDate(legSetDate.getDate() - 10);
	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth())+'/'+fn_day(legSetDate.getDate());
	$('#stPoDt').val(legDate);
	$('#edPoDt').val(nowDate);
	
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
	var obj={};
	obj.facCd = $('#facCd').val();
	obj.stPoDt = searchDate($('#stPoDt').val());
	obj.edPoDt = searchDate($('#edPoDt').val());
	obj.outsCon = $('input:radio[name="outsCon"]:checked').val(); 
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"));
};

function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};
</script>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">발주등록기간</label>
				<input name="stPoDt" id="stPoDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'edPoDt', 'max')"> ~ 
				<input name="edPoDt" id="edPoDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'stPoDt', 'min')">
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
					<input type="radio" name="outsCon" id="outsCon" value="all" checked="checked">전체
					<input type="radio" name="outsCon" id="outsCon" value="michk">미확인
					<input type="radio" name="outsCon" id="outsCon" value="okchk">확인
				</div>
			</div>
	</div>
</div>
<div id="container"></div>