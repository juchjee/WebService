<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"사원정보",
		id:"empNo",
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
	gridMain.addHeader({name:"사번"		, colId:"empNo"		, width:"80"	, align:"left"	, type:"ro"});
	gridMain.addHeader({name:"사원명"		, colId:"empNm"		, width:"80"	, align:"left"	, type:"ro"});
	gridMain.addHeader({name:"부서코드"	, colId:"deptCd"	, width:"100"	, align:"left"	, type:"ro"});
	gridMain.addHeader({name:"부서명"		, colId:"deptNm"	, width:"100"	, align:"left"	, type:"ro"});
	
	gridMain.setUserData("","pk","empNo");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	init_search();
});
function init_search(){
	$('#empNo').val(PARAM_INFO.innerName);
	$('#menucd').val(parent.ActTabId);	//메뉴아이디
	 var obj = {}; 
	 obj.empNo =  $('#empNo').val();
	 obj.menucd =  $('#menucd').val();
	loadGridMain(obj); 
};

 function fn_search(){
	 var obj = {}; 
	 obj.empNo =  $('#empNo').val();
	loadGridMain(obj);
};
 
 function loadGridMain(obj){
	 gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/inusBath/partners/custCard/empInfoPOP",subLayout.cells("a"),fn_loadGridListCodeCB);
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
	  var empNo = gridMain.setCells(rId,1).getValue();		//사원번호
	  var empNm = gridMain.setCells(rId,2).getValue();		//사원명
	  var deptCd = gridMain.setCells(rId,3).getValue();		//부서코드
	  var detpNm = gridMain.setCells(rId,4).getValue();		//부서명
	  var arr = [{"seq":seq,"empNo":empNo,"empNm":empNm,"deptCd":deptCd,"detpNm":detpNm}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
};
</script>
<div id="container"></div>
<input name="menucd" id="menucd" type="hidden" >
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="mlZero">
				<label class="title1">사원번호/명</label>
				<input name="empNo" id="empNo" type="text" value=""  class="searchCode">
			</div>
		</div>
	</div>	
</div>