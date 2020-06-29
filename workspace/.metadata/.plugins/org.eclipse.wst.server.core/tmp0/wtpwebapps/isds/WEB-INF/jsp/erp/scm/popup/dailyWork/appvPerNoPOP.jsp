<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"사용자확인",
		id:"appvPerNo",
		width:"270",
		height:"500"
	}
$(document).ready(function(){
	Ubi.setContainer(0,[],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"No",   colId:"no", width:"50", align:"center", type:"cntr"});
	gridMain.addHeader({name:"사번",  colId:"perNo", width:"100", align:"left", type:"ro"});
	gridMain.addHeader({name:"성명",  colId:"perNm", width:"100", align:"left", type:"ro"});
	gridMain.setUserData("","pk","");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	
	fn_search();
});
 function fn_search(){
	 $('#siteCd').val(PARAM_INFO.innerName);
	 var obj = {}; 
	 obj.siteCd =  $('#siteCd').val();
	 gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/work/partners/dailyWork/dailyAttendS/perNoPop",subLayout.cells("a"),fn_loadGridListCodeCB);
 }
 
function fn_loadGridListCodeCB(data) {
	if(data.length<1){
		parent.MsgManager.alertMsg("WRN011");
		parent.dhxWins.window("w1").close();
	}else if(data.length==1){
		  var perNo = data[0].perNo;
		  var perNm = data[0].perNm;
		  var arr = [{"perNo":perNo,"perNm":perNm}];
		  parent.fn_onClosePop(PARAM_INFO.gubn,arr);
		  parent.dhxWins.window("w1").close();
	}else{
	   gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);	
	}
	
};

function doOnRowDblClicked(rId,cInd){
	  var perNo = gridMain.setCells(rId,1).getValue();
	  var perNm = gridMain.setCells(rId,2).getValue();
	  var arr = [{"perNo":perNo,"perNm":perNm}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
}
</script>
<input name="siteCd" id="siteCd" type="hidden" >
<div id="container"></div>