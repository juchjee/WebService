<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"차량정보",
		id:"carNo",
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
	gridMain.addHeader({name:"차량정보"	, colId:"carNo"		, width:"80"	, align:"left"	, type:"ro"});
	gridMain.addHeader({name:"운전자명"	, colId:"drvNm"		, width:"80"	, align:"left"	, type:"ro"});
	gridMain.addHeader({name:"운전자핸드폰"	, colId:"drvHp"		, width:"100"	, align:"left"	, type:"ro"});
	gridMain.addHeader({name:"차량종류"	, colId:"carKd"		, width:"100"	, align:"left"	, type:"ro"});
	
	gridMain.setUserData("","pk","");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	init_search();
});
function init_search(){
	$('#carNo').val(PARAM_INFO.innerName);
	 var obj = {}; 
	 obj.carNo =  $('#carNo').val();
	loadGridMain(obj); 
};

 function fn_search(){
	 var obj = {}; 
	 obj.carNo =  $('#carNo').val();
	loadGridMain(obj);  
};
 
 function loadGridMain(obj){
	 gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/remiconAdmin/partners/shipment/carInfoPop",subLayout.cells("a"),fn_loadGridListCodeCB);
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
	  var carNo = gridMain.setCells(rId,1).getValue();		//차량번호
	  var drvNm = gridMain.setCells(rId,2).getValue();		//운전자
	  var drvHp = gridMain.setCells(rId,3).getValue();		//운전자 연락처
	  var carKd = gridMain.setCells(rId,4).getValue();		//차량종류
	  var arr = [{"seq":seq,"carNo":carNo,"drvNm":drvNm,"drvHp":drvHp,"carKd":carKd}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
};
</script>
<div id="container"></div>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="mlZero">
				<label class="title1" style="width: 50px;">차량번호</label>
				<input name="carNo" id="carNo" type="text" value=""  class="searchCode">
			</div>
		</div>
	</div>	
</div>