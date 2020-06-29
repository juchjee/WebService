<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"출하상세내역",
		id:"outDt",
		width:"300",
		height:"550"
	}
$(document).ready(function(){
	Ubi.setContainer(0,[1],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"순번"		, colId:"carSeq"	, width:"50"	, align:"center"	, type:"ro"});
	gridMain.addHeader({name:"차량번호"	, colId:"rcarNo"	, width:"70"	, align:"center"	, type:"ro"});
	gridMain.addHeader({name:"운전자"		, colId:"drvNm"		, width:"70"	, align:"center"	, type:"ro"});
	gridMain.addHeader({name:"건수"		, colId:"cnt"		, width:"70"	, align:"center"	, type:"ron"});
	
	gridMain.setUserData("","pk","");
	gridMain.attachFooter("&nbsp;,&nbsp;,&nbsp;,#stat_total");	//footer sum
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	init_search();
});
function init_search(){
	$('#outDt').val(PARAM_INFO.innerName);
	 var obj = {}; 
	 obj.outDt =  $('#outDt').val();
	loadGridMain(obj); 
};

 function fn_search(){
	 var obj = {}; 
	 obj.outDt =  $('#outDt').val();
	loadGridMain(obj);  
};
 
 function loadGridMain(obj){
	 gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/remiconAdmin/partners/shipment/dailyRevCntPop",subLayout.cells("a"),fn_loadGridListCodeCB);
 };
 
function fn_loadGridListCodeCB(data) {
	if(data.length<1){
		parent.MsgManager.alertMsg("WRN011");
		parent.dhxWins.window("w1").close();
	}else{
	   gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);	
	}
};

function doOnRowDblClicked(rId,cInd){
	//반환값 없으므로 별도 구현내용 없음
};
</script>
<input name="outDt" id="outDt" type="hidden">
<div id="container"></div>