<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"날씨검색",
		id:"weather",
		width:"300",
		height:"500"
	}
$(document).ready(function(){
	Ubi.setContainer(0,[1],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"날씨코드", colId:"weatherBc", width:"140", align:"center", type:"ro"});
	gridMain.addHeader({name:"날씨",  colId:"title",       width:"140", align:"center", type:"ro"});
	gridMain.setUserData("","pk","");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	fn_search();
});
 function fn_search(){
	 gfn_callAjaxForGrid(gridMain,{},"/erp/scm/work/partners/dailyWork/weatherSearch",subLayout.cells("a"),fn_loadGridListCodeCB);
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
	  var row = rId-1;
	  var cell = cInd;
	  var weatherBc = gridMain.setCells2(row,0).getValue();
	  var title = gridMain.setCells2(row,1).getValue();
	  var arr = [{"weatherBc":weatherBc,"title":title}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
}
</script>
<div id="container"></div>