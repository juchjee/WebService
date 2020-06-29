<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"현장코드검색",
		id:"siteCd",
		width:"540",
		height:"500"
	}
$(document).ready(function(){
	Ubi.setContainer(1,[1],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"현장코드", colId:"siteCd", width:"80", align:"center", type:"ro"});
	gridMain.addHeader({name:"현장명",  colId:"siteDs", width:"240", align:"left", type:"ro"});
	gridMain.addHeader({name:"공사명",  colId:"constructDs", width:"200", align:"left", type:"ro"});
	gridMain.setUserData("","pk","");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	init_search();
	
	$('#siteNm').keypress(function(e){
		if(e.which == 13){
			return false;
		}
	})
});
function init_search(){
	$('#siteNm').val(PARAM_INFO.innerName);
	 var obj = {}; 
	 obj.siteCd =  $('#siteNm').val();
	loadGridMain(obj); 
};

 function fn_search(){
	 var obj = {}; 
	 obj.siteCd =  $('#siteNm').val();
	loadGridMain(obj);  
};
 
 function loadGridMain(obj){
	 gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/work/partners/dailyWork/siteCdSearch",subLayout.cells("a"),fn_loadGridListCodeCB);
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
	  var siteCd = gridMain.setCells(rId,0).getValue();
	  var siteNm = gridMain.setCells(rId,1).getValue();
	  var arr = [{"siteCd":siteCd,"siteNm":siteNm}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
};
</script>
<div id="container"></div>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="mlZero">
				<label class="title1" style="width: 50px;">검색</label>
				<input name="siteNm" id="siteNm" type="text"  class="inputbox2" >
			</div>
		</div>
	</div>	
</div>