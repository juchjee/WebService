<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var calMain;
var config={
		title:"공사일보등록 검색", 
		id:"construnction",
		width:"650",
		height:"500"
	}
$(document).ready(function(){
	Ubi.setContainer(1,[1],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"일자",   colId:"workDt", width:"100", align:"center", type:"ro"});
	gridMain.addHeader({name:"현장코드",  colId:"siteCd", width:"80", align:"left", type:"ro"});
	gridMain.addHeader({name:"현장명",  colId:"siteDs", width:"240", align:"left", type:"ro"});
	gridMain.addHeader({name:"공사구간",  colId:"conSec", width:"200", align:"left", type:"ro"});
	gridMain.setUserData("","pk","");
	gridMain.dxObj.setUserData("","@workDt","format_date");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	
	calMain = new dhtmlXCalendarObject([{input:"sdate",button:"calpicker1"},{input:"edate",button:"calpicker2"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var nowDate = dateformat(new Date());
	var legSetDate = new Date();
	legSetDate.setMonth(legSetDate.getMonth() + 1);
	legSetDate.setDate(legSetDate.getDate() - 5);
	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth())+'/'+fn_day(legSetDate.getDate());
	$('#edate').val(nowDate);
	$('#sdate').val(legDate);
	
	 $('#siteCd').val(PARAM_INFO.innerName);

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
	 obj.sdate =  searchDate($('#sdate').val());
	 obj.edate =  searchDate($('#edate').val());
	 obj.siteCd = $('#siteCd').val();
	 loadGridMain(obj); 
}
 function loadGridMain(params){
	 gfn_callAjaxForGrid(gridMain,params,"/erp/scm/work/partners/dailyWork/constructionPopSearch",subLayout.cells("a"),fn_loadGridListCodeCB);
 }
 
function fn_loadGridListCodeCB(data) {
	if(data != ''){
	   gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);
	}
};

function doOnRowDblClicked(rId,cInd){
	  var workDt = gridMain.setCells(rId,0).getValue();
	  var siteCd = gridMain.setCells(rId,1).getValue();
	  var siteDs = gridMain.setCells(rId,2).getValue();
	  var arr = [{"workDt":workDt,"siteCd":siteCd,"siteDs":siteDs}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
}
</script>
<div id="bootContainer">
 <form id="frmMain" name="frmMain">
   <input type="hidden" id="siteCd" name="siteCd">
	<div class="listHeader">
		<div class="left">
			<div class="ml10">
				<label class="title0">일자</label>
				<input name="sdate" id="sdate" type="text" value="" placeholder="" class="searchDate" >
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'edate', 'max')">~
				<input name="edate" id="edate" type="text" value="" placeholder="" class="searchDate" >
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'sdate', 'min')">
			</div>
		</div>
	</div>
  </form>			
</div>
<div id="container"></div>
