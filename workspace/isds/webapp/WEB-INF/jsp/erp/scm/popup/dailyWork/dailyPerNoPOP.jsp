<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"출근자",
		id:"perNum",
		width:"630",
		height:"500"
	}
$(document).ready(function(){
	Ubi.setContainer(0,[],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"No",         colId:"no",     width:"50",  align:"center", type:"cntr"});
    gridMain.addHeader({name:"근무자번호",    colId:"perNo",  width:"140", align:"center", type:"ro"});
	gridMain.addHeader({name:"성명",        colId:"perNm",  width:"140", align:"center", type:"ro"});
	gridMain.addHeader({name:"주민번호",     colId:"regiNo", width:"140", align:"center", type:"ro"});
	gridMain.addHeader({name:"외국인등록번호", colId:"foreNo", width:"140", align:"center", type:"ro"});
	gridMain.setUserData("","pk","");
	gridMain.dxObj.setUserData("","@regiNo","format_jumin");
    gridMain.dxObj.setUserData("","@foreNo","format_foreNo");
    gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	gridMain.cs_setColumnHidden(["perKind","perKindNm"]);
	

	fn_search();
});
function fn_search(){
	 $('#siteCd').val(PARAM_INFO.innerName);
	 $('#workDt').val(PARAM_INFO.kind);
		
	 var obj = {}; 
	 obj.siteCd =  $('#siteCd').val();
	 obj.workDt =  $('#workDt').val();
	 gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/work/partners/dailyWork/perNumSearch",subLayout.cells("a"),fn_searchCB);
}

function fn_searchCB(data) {
	if(data.length<1){
		parent.MsgManager.alertMsg("WRN011");
		parent.dhxWins.window("w1").close();
	}else{
	   gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);	
	}
	
};

function doOnRowDblClicked(rId,cInd){
	  var perNo = gridMain.setCells(rId,1).getValue();
	  var perNm = gridMain.setCells(rId,2).getValue();
	  var perKind = gridMain.setCells(rId,gridMain.getColIndexById("perKind")).getValue();
	  var perKindNm = gridMain.setCells(rId,gridMain.getColIndexById("perKindNm")).getValue();
	  var arr = [{"perNo":perNo,"perNm":perNm,"perKind":perKind,"perKindNm":perKindNm}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
}
</script>
<form>
<input name="siteCd" id="siteCd" type="hidden" >
<input name="workDt" id="workDt" type="hidden" >
</form>
<div id="container"></div>