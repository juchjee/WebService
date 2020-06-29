<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"대분류코드",
		id:"commgrpm",
		width:"300",
		height:"500"
	}
$(document).ready(function(){
	Ubi.setContainer(0,[1],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"코드명", colId:"title", width:"140", align:"center", type:"ro"});
	gridMain.addHeader({name:"비고",  colId:"rmks", width:"140",  align:"center", type:"ro"});
	gridMain.setUserData("","pk","");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	gridMain.cs_setColumnHidden(["commgrpmCd"]);
	init_search();
});
function init_search(){
	$('#siteCd').val(PARAM_INFO.innerName);
	 var obj = {}; 
	 obj.siteCd =  $('#siteCd').val();
	loadGridMain(obj); 
}
 function fn_search(){
	 var obj = {}; 
	 obj.siteCd =  $('#siteCd').val();
	loadGridMain(obj); 
}
 function loadGridMain(params){
	 gfn_callAjaxForGrid(gridMain,params,"/erp/scm/work/partners/dailyWork/commgrpmCdSearch",subLayout.cells("a"),fn_loadGridListCodeCB);
 }
 
function fn_loadGridListCodeCB(data) {
	if(data.length<1){
		parent.MsgManager.alertMsg("WRN011");
		parent.dhxWins.window("w1").close();
	}else{
	   gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);	
	}
	
};

function doOnRowDblClicked(rId,cInd){
	  var title      = gridMain.setCells(rId,0).getValue();
	  var commgrpmCd = gridMain.setCells(rId,2).getValue();
	  var arr = [{"title":title,"commgrpmCd":commgrpmCd}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
}
</script>
<input name="siteCd" id="siteCd" type="hidden" >
<div id="container"></div>