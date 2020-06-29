<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"장비코드",
		id:"equiCode",
		width:"820",
		height:"500"
	}
$(document).ready(function(){
	Ubi.setContainer(0,[],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"No",   colId:"no", width:"50", align:"center", type:"cntr"});
	gridMain.addHeader({name:"대분류",  colId:"kbigDs", width:"80", align:"center", type:"ro"});
	gridMain.addHeader({name:"중분류",  colId:"kmidDs", width:"80", align:"center", type:"ro"});
	gridMain.addHeader({name:"소분류",  colId:"ksmallDs", width:"80", align:"center", type:"ro"});
	gridMain.addHeader({name:"품목코드", colId:"itemCd", width:"90", align:"center", type:"ro"});
	gridMain.addHeader({name:"품목명",  colId:"kitemDs", width:"140", align:"center", type:"ro"});
	gridMain.addHeader({name:"규격",  colId:"itemSz", width:"100", align:"center", type:"ro"});
	gridMain.addHeader({name:"단위",  colId:"itemUt", width:"100", align:"center", type:"ro"});
	gridMain.addHeader({name:"단위명",  colId:"title", width:"60", align:"center", type:"ro"});
	gridMain.setUserData("","pk","");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	
	fn_search();
});
 function fn_search(){
	 gfn_callAjaxForGrid(gridMain,{},"/erp/scm/work/partners/dailyWork/constructionS/equiCodePop",subLayout.cells("a"),fn_loadGridListCodeCB);
 }
 
function fn_loadGridListCodeCB(data) {
	gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);	
};

function doOnRowDblClicked(rId,cInd){
	  var itemCd  = gridMain.setCells(rId,gridMain.getColIndexById("itemCd")).getValue();
	  var kitemDs = gridMain.setCells(rId,gridMain.getColIndexById("kitemDs")).getValue();
	  var itemSz  = gridMain.setCells(rId,gridMain.getColIndexById("itemSz")).getValue();
	  var itemUt  = gridMain.setCells(rId,gridMain.getColIndexById("itemUt")).getValue();
	  var title  = gridMain.setCells(rId,gridMain.getColIndexById("title")).getValue();
	  var arr = [{"itemCd":itemCd,"kitemDs":kitemDs,"itemSz":itemSz,"itemUt":itemUt,"title":title}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
}
</script>
<div id="container"></div>