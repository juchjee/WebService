<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){//발주확인등록
	Ubi.setContainer(3,[1,3,8],"1C");
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"확인",     colId:"outsCon",   width:"50",   align:"center", type:"ch"});
    gridMain.addHeader({name:"발주번호",  colId:"poNo",      width:"100",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"품목구분",  colId:"etcKindNm", width:"60",   align:"center",  type:"ro"});
    gridMain.addHeader({name:"품목코드", colId:"itemCd",     width:"70",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"품명",    colId:"kitemDs",    width:"150",   align:"left",  type:"ro"});
    gridMain.addHeader({name:"규격",    colId:"itemSz",     width:"200",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"단위",    colId:"itemUt",     width:"70",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"수량",    colId:"balAsgnQty", width:"90",   align:"right",  type:"ron"});
    gridMain.addHeader({name:"단가",    colId:"itemUp",     width:"90",   align:"right",  type:"ron"});
    gridMain.addHeader({name:"금액",    colId:"itemAm",     width:"100",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"납기일자", colId:"deliveryDt", width:"80",   align:"center", type:"ro"});
    gridMain.addHeader({name:"납품장소", colId:"locationAt", width:"100",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"비고",    colId:"rmks",       width:"150",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"외주처 비고", colId:"outsRmk",  width:"150",  align:"left",   type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@deliveryDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setNumberFormat(["itemQn"],"0,000.00");
    gridMain.cs_setNumberFormat(["itemUp","itemAm"]);
    gridMain.cs_setColumnHidden(["mrNo","inqNo","sqNo","custCd","costId","balDt","deliSeq","deliQn","itemQn","siteCd","siteDs","etcReqNo"]);
    gridMain.attachEvent("onCheck",doOnCheck);
    
    $('input[name="outsCon"]:radio').change(function() { 
       	fn_search();
    });
    
    fn_search();
});
function doOnCheck(rId,cInd,state){
	var deliQn = gridMain.setCells(rId,gridMain.getColIndexById("deliQn")).getValue()*1;
	if(deliQn>0){
		dhtmlx.alert("납품등록된 내역은 취소할 수 없습니다.");
		if(!state){
			gridMain.setCells(rId,gridMain.getColIndexById("outsCon")).setValue("1");
		}
	}
};

function fn_search(){
	var obj={};
	obj.siteCd = $('#siteCd').val();
	obj.balDt = searchDate($('#balDt').val());
	obj.outsCon = $('input:radio[name="outsCon"]:checked').val(); 
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
};

function fn_searchCB(data){
	var gubnVal = $(':radio[name="outsCon"]:checked').val();
	if(gubnVal == 'michk' && data != ''){
		for(var i=0;i<gridMain.getRowsNum();i++){
			gridMain.dxObj.setCellExcellType(gridMain.getRowId(i),gridMain.getColIndexById("outsRmk"),"ed");
		}
	}
};

function fn_save(){
	//var jsonStr = gridMain.getJsonUpdated_chk(0);
	var jsonStr = gridMain.getJsonUpdated();
	  if(jsonStr == null || jsonStr.length <= 0){ return;}  
	    $("#jsonData").val(jsonStr);
	    var params = $("#pForm").serialize();  
	   gfn_callAjaxComm(params,"gridMainSave",fn_search);		
};

function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};

function fn_onClosePop(pName,data){
	 if(pName == "siteCd"){
		 $('#siteCd').val(data[0].siteCd);
		 $('#siteNm').val(data[0].siteNm);
		 $('#siteCd').focus();
	 }
};
</script>
<form id="pForm" name="pForm">
    <input type="hidden" name="jsonData" id="jsonData">
</form>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">일자</label>
				<input name="balDt" id="balDt" type="text" value="" placeholder="" class="searchDate format_date">
				<input type="button" id="calpicker" name="calpicker" class="calicon inputCal">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}" class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}"  class="inputbox3" onkeydown="event.preventDefault()" readonly="readonly">
			</div>
		</div>
	</div>	
	<div class="listHeader">
		<div class="left">
				<div class="ml30">
					<label class="title1">구분</label>
					<input type="radio" name="outsCon" id="outsCon" value="all" >전체
					<input type="radio" name="outsCon" id="outsCon" value="michk" checked="checked">미확인
					<input type="radio" name="outsCon" id="outsCon" value="okchk" >확인
				</div>
			</div>
	</div>
</div>
<div id="container"></div>