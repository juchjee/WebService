<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"상품정보",
		id:"saleCode",
		width:"500",
		height:"700"
	}
$(document).ready(function(){
	Ubi.setContainer(1,[1],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"순번"		, colId:"seq"		, width:"40"	, align:"center", type:"ro"});
	gridMain.addHeader({name:"상품코드"	, colId:"saleCode"	, width:"100"	, align:"center"	, type:"ro"});
	gridMain.addHeader({name:"상품명"		, colId:"saleName"	, width:"260"	, align:"left"	, type:"ro"});
	
	gridMain.setUserData("","pk","saleCode");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	init_search();
});
function init_search(){
	$('#saleCode').val(PARAM_INFO.innerName);
	 var obj = {}; 
	 obj.saleCode =  $('#saleCode').val();
	loadGridMain(obj); 
};

 function fn_search(){
	 var obj = {}; 
	 obj.saleCode =  $('#saleCode').val();
	loadGridMain(obj);
};
 
 function loadGridMain(obj){
	 gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/inusBath/partners/custCard/saleCodePOP",subLayout.cells("a"),fn_loadGridListCodeCB);
 };
 
function fn_loadGridListCodeCB(data) {
	if(data.length<1){
		parent.MsgManager.alertMsg("WRN011");
		parent.dhxWins.window("w1").close();
	}else{
	   gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);	
	}
};

//부모창에 return되는 값 설정
function doOnRowDblClicked(rId,cInd){
	  var seq = gridMain.setCells(rId,0).getValue();		//순번
	  var saleCode = gridMain.setCells(rId,1).getValue();	//상품코드
	  var saleName = gridMain.setCells(rId,2).getValue();	//상품명
	  var arr = [{"seq":seq,"saleCode":saleCode,"saleName":saleName}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
};
</script>
<div id="container"></div>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="mlZero">
				<label class="title1">상품코드/명</label>
				<input name="saleCode" id="saleCode" type="text" value=""  class="searchCode">
			</div>
		</div>
	</div>	
</div>