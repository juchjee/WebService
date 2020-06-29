<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"판매채널",
		id:"custCd",
		width:"450",
		height:"700"
	}
$(document).ready(function(){
	Ubi.setContainer(1,[1],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"거래처코드"		, colId:"custCd"	, width:"70"	, align:"center", type:"ro"});
	gridMain.addHeader({name:"거래처명"		, colId:"custNm"	, width:"170"	, align:"left"	, type:"ro"});
	gridMain.addHeader({name:"사업자등록번호"	, colId:"bizNo"		, width:"100"	, align:"center", type:"ro"});
	gridMain.addHeader({name:"대표자명"		, colId:"ceoNm"		, width:"70"	, align:"left"	, type:"ro"});
	
	gridMain.setUserData("","pk","");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	init_search();
});
function init_search(){
	$('#custCd').val(PARAM_INFO.innerName);
	 var obj = {}; 
	 obj.custCd =  $('#custCd').val();
	loadGridMain(obj); 
};

 function fn_search(){
	 var obj = {}; 
	 obj.custCd =  $('#custCd').val();
	loadGridMain(obj);  
};
 
 function loadGridMain(obj){
	 gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/inusBath/partners/custCard/custInfoPOP",subLayout.cells("a"),fn_loadGridListCodeCB);
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
	  var custCd = gridMain.setCells(rId,0).getValue();		//거래처코드
	  var custNm = gridMain.setCells(rId,1).getValue();		//거래처명
	  var bizNo = gridMain.setCells(rId,2).getValue();		//사업자번호
	  var ceoNm = gridMain.setCells(rId,3).getValue();		//대표자명
	  var arr = [{"custCd":custCd,"custNm":custNm,"bizNo":bizNo,"ceoNm":ceoNm}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
};
</script>
<div id="container"></div>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="mlZero">
				<label class="title1" style="width: 50px;">코드/명</label>
				<input name="custCd" id="custCd" type="text" value=""  class="searchCode">
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<b><font size="2px;" class="wordTitle">※ 찾고자하는 코드/명 입력 후 조회해주세요.</font></b>
			</div>
		</div>
	</div>	
</div>