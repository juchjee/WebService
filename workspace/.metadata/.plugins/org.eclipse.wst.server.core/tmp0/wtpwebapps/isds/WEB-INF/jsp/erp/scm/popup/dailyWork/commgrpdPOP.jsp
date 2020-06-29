<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"세부공종코드검색",
		id:"siteCd",
		width:"300",
		height:"500"
	}
$(document).ready(function(){
	Ubi.setContainer(0,[1],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"No",        colId:"no",   width:"60", align:"center", type:"cntr"});
    gridMain.addHeader({name:"세부공종코드", colId:"descCd", width:"80", align:"center", type:"ro"});
	gridMain.addHeader({name:"공종명",     colId:"descNm", width:"140", align:"center", type:"ro"});
	gridMain.setUserData("","pk","");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();

	$('#siteCd').val(PARAM_INFO.innerName);
	
	fn_search();
});
 function fn_search(){
	 var obj = {}; 
	 obj.siteCd =  $('#siteCd').val();
	 gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/work/partners/dailyWork/commgrpdS/popSearch",subLayout.cells("a"),fn_loadGridListCodeCB);
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
	  var descCd = gridMain.setCells(rId,1).getValue();
	  var descNm = gridMain.setCells(rId,2).getValue();
	  var arr = [{"descCd":descCd,"descNm":descNm}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
}
</script>
<input name="siteCd" id="siteCd" type="hidden" >
<div id="container"></div>