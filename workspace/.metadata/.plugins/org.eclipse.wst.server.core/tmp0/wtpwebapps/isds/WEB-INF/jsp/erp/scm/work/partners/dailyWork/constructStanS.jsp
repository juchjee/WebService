<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<style>
div.gridbox_dhx_skyblue.gridbox table.obj tr td{
  padding-left: 2px;
  padding-right: 2px;
}
</style>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain,gridSub,gridSub01;
var calMain;
var toolbar01,toolbar02;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId; 
$(document).ready(function(){
	Ubi.setContainer(1,[1,2,3],"1C"); //공사일보 누계 등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
    
    gridTabbar = subLayout.cells("a").attachTabbar({
        tabs: [{id: "a1",text: "출력인원등록",active: true}, 
               {id: "a2",text: "사용장비등록"}]});
	
    gridMain = new dxGrid(gridTabbar.tabs("a1"),false);
    gridMain.addHeader({name:"No",      colId:"no",         width:"50",  align:"center", type:"cntr"});
    gridMain.addHeader({name:"공종대분류", colId:"title",      width:"90",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"공종코드",  colId:"commgrpsDs", width:"90",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"세부공정",  colId:"descNm",     width:"90",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"작업인원",  colId:"perNum",     width:"60",  align:"right",  type:"edn"});
    gridMain.addHeader({name:"작업내용",  colId:"workCon",    width:"300", align:"left",   type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["custCd","siteCd","commgrpmCd","stndDt","commgrpsCd","cnt","commgrpdCd"]);
    gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);
    
    var tbrlayout01 = gridTabbar.tabs("a1");
	toolbar01 = subToolbar(toolbar01,tbrlayout01,[5,6]);
	toolbar01.attachEvent("onClick",gridMainOnClick);
    
    gridSub = new dxGrid(gridTabbar.tabs("a2"),false);
    gridSub.addHeader({name:"No",      colId:"no",        width:"50",   align:"center", type:"cntr"});
    gridSub.addHeader({name:"장비코드",  colId:"itemCd",     width:"100",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"장비명",    colId:"itemName",    width:"150",  align:"left",  type:"ro"});
    gridSub.addHeader({name:"규격",     colId:"itemSpec",   width:"150", align:"left",   type:"ro"});
    gridSub.addHeader({name:"단위",     colId:"itemUnit",   width:"90",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"수량",     colId:"qty",        width:"60",  align:"right",  type:"edn"});
    gridSub.addHeader({name:"작업내용",  colId:"workCon",   width:"300", align:"left",   type:"ed"});
    gridSub.setUserData("","pk","");
    gridSub.dxObj.enableHeaderMenu("false");
    gridSub.init();
    gridSub.cs_setColumnHidden(["custCd","siteCd","workSeq","stndDt"]);
    gridSub.attachEvent("onRowDblClicked",doOnSubRowDblClicked);
    
    g_dxRules = {
			title      : [r_notEmpty],
			commgrpsDs : [r_notEmpty],
			descNm     : [r_notEmpty],
			perNum     : [r_notEmpty],
			itemCd     : [r_notEmpty],
			qty        : [r_notEmpty]
    };
    
    
    var tbrlayout02 = gridTabbar.tabs("a2");
	toolbar02 = subToolbar(toolbar02,tbrlayout02,[5,6]);
	toolbar02.attachEvent("onClick",gridSubOnClick);
 
    fn_search();
    
});
function gridMainOnClick(id){
	if(id == "btn5"){
		fn_grid_add('main'); 
	}
	if(id == "btn6"){
		fn_grid_delete('main'); 
	}
};

function gridSubOnClick(id){
	if(id == "btn5"){
		fn_grid_add('sub'); 
	}
	if(id == "btn6"){
		fn_grid_delete('sub'); 
	}	
};

function doOnRowDblClicked(rId,cInd){
	var cnt = gridMain.setCells(rId,gridMain.getColIndexById("cnt")).getValue();
	if(cInd == 1 && cnt == '0'){
		gfn_load_pop('w1','dailyWork/commgrpmPOP',[$('#siteCd').val(),"공종대분류","commgrpm"]);
	}else if(cInd == 2 && cnt == '0'){
		var title =  gridMain.setCells(rId,1).getValue();
		var commgrpm = gridMain.setCells(rId,gridMain.getColIndexById("commgrpmCd")).getValue();
		if(title == '' || title == null){
			dhtmlx.alert("대분류를 선택해 주세요.");
			return;
		}else{
			gfn_load_pop('w1','dailyWork/commgrpsPOP',[$('#siteCd').val(),commgrpm,"commgrps"]);
		}
	}else if(cInd == 3 && cnt == '0'){
		var commgrps = gridMain.setCells(rId,gridMain.getColIndexById("commgrpsDs")).getValue();
		if(commgrps == '' || commgrps == null){
			dhtmlx.alert("공종코드를 선택해 주세요.");
			return;
		}else{
		  gfn_load_pop('w1','dailyWork/commgrpdPOP',[$('#siteCd').val(),'',"commgrpd"]);
		}
	}
};

function doOnSubRowDblClicked(rId,cInd){
	if(cInd == 1){
		gfn_load_pop('w1','dailyWork/equiCodePOP',['','',"equiCode"]);
	}
};

function fn_search(){
		var obj={};
		obj.siteCd = $('#siteCd').val();
		gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",gridTabbar.tabs("a1"),fn_mainSearchCB);
		gfn_callAjaxForGrid(gridSub,obj,"gridSubSearch",gridTabbar.tabs("a2"));
};

function fn_mainSearchCB(data){
	if(data != ''){
		for(var i=0;i<gridMain.getRowsNum();i++){
			gridMain.setCells2(i,gridMain.getColIndexById("cnt")).setValue('1');
			var workConIdx = gridMain.getColIndexById("workCon");
			var workConVal = gridMain.setCells2(i,workConIdx).getValue();
			var textAreaTag = "<textarea  style='width:100%; height:55px; margin-top :3px;' id='workCon"+(i)+"' name='workCon'>"+workConVal+"</textarea>";
			gridMain.setCells2(i, workConIdx).setValue(textAreaTag);
		}
	}
}

function fn_new(){
	location.replace(location.pathname);
};

function fn_save(){
	var siteCd = $('#siteCd').val();
	if(siteCd == '' || siteCd == null){
		dhtmlx.alert("현장코드를 입력하세요.");
		return true;
	}else{
		fn_saveWorkCon();
		var jsonStr = gridMain.getJsonUpdated();
		var jsonStr2 = gridSub.getJsonUpdated();
		
		if(jsonStr != null || jsonStr.length > 0){
			$("#jsonData").val(jsonStr);
		}
		if(jsonStr2 != null || jsonStr2.length > 0){
			$("#jsonData2").val(jsonStr2);
		}

		var params = $("#pForm").serialize();  
		gfn_callAjaxComm(params,"gridSave",fn_search);	
	}
};

function fn_saveWorkCon(){
	for(var i=0;i<gridMain.getRowsNum();i++){
		var cudKey = gridMain.setCells2(i,gridMain.getColIndexById("cudKey")).getValue();
		if(cudKey == ''){
			gridMain.setCells2(i,gridMain.getColIndexById("cudKey")).setValue("UPDATE");
		}
		var workConVal = $("#workCon"+i).val();
		gridMain.setCells2(i,gridMain.getColIndexById("workCon")).setValue(workConVal);
	}
};

function fn_grid_add(flag){
	var siteCd = $('#siteCd').val();
	if(siteCd == '' || siteCd == null){
		dhtmlx.alert("현장코드를 입력하세요.");
		return true;
	}else{
		if(flag == 'main'){
		  var totalRowNum = gridMain.getRowsNum();
		  var totalColNum = gridMain.getColumnCount();
	   	  var data = new Array(totalColNum);
	   	  var stndDtColIdx  = gridMain.getColIndexById('stndDt');     
	      var siteCdColIdx   = gridMain.getColIndexById('siteCd');
	      var workConIdx = gridMain.getColIndexById("workCon");
	      var cntIdx = gridMain.getColIndexById("cnt");
	        data[cntIdx]   = '0';
	        data[stndDtColIdx]  = searchDate(dateformat(new Date()));
			data[siteCdColIdx]   = $('#siteCd').val();
			data[workConIdx] = "<textarea  style='width:100%; height:55px; margin-top :3px;' id='workCon"+(totalRowNum)+"' name='workCon'></textarea>";
	   	  gridMain.addRow(data);
		}else if(flag == 'sub'){
		  var totalColNum = gridSub.getColumnCount();
		  var data = new Array(totalColNum);
		  var stndDtColIdx  = gridSub.getColIndexById('stndDt');     
	      var siteCdColIdx   = gridSub.getColIndexById('siteCd');
	        data[stndDtColIdx]  = searchDate(dateformat(new Date()));
			data[siteCdColIdx]   = $('#siteCd').val();
		  gridSub.addRow(data);
		}
	}	
};

function fn_grid_delete(flag){
	if(flag == 'main'){
		var rodid = gridMain.getSelectedRowId();
		gridMain.cs_deleteRow(rodid); 
	}else if(flag == 'sub'){
		var rodid = gridSub.getSelectedRowId();
		gridSub.cs_deleteRow(rodid); 
	}
};

function fn_exit(){
	var exitVal = cs_close_event([gridMain,gridSub]);
	if(exitVal){
		mainTabbar.tabs(ActTabId).close();	
	}else{
		if(MsgManager.confirmMsg("WRN012")){
			mainTabbar.tabs(ActTabId).close();	
		}else{
			return true;
		}
	} 
};

function fn_onClosePop(pName,data){
	 if(pName == "siteCd"){
		$('#siteCd').val(data[0].siteCd);
		$('#siteNm').val(data[0].siteNm);
		fn_search();
		 $("#password").focus();
	 };
	 if(pName == "commgrpm"){
		 var rowIdx = gridMain.getSelectedRowIndex();
		 var title = data[0].title;
		 var commgrpmCd = data[0].commgrpmCd;
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("title")).setValue(title);
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpmCd")).setValue(commgrpmCd);
	 };
	 if(pName == "commgrps"){
		 var rowIdx = gridMain.getSelectedRowIndex();
		 var commgrpsDs = data[0].commgrpsDs;
		 var commgrpsCd = data[0].commgrpsCd;
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpsDs")).setValue(commgrpsDs);
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpsCd")).setValue(commgrpsCd); 
	 };
	 if(pName == "commgrpd"){
		 var commFlag = true;
		 var rowIdx = gridMain.getSelectedRowIndex();
		 var descNm = data[0].descNm;
		 var commgrpdCd = data[0].descCd;
		 var commgrpsDs = gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpsDs")).getValue();
		 for(var i=0;i<gridMain.getRowsNum();i++){
			var commgrpsDsMst = gridMain.setCells2(i,gridMain.getColIndexById("commgrpsDs")).getValue();
			var descNmMst = gridMain.setCells2(i,gridMain.getColIndexById("descNm")).getValue();
			if(i != rowIdx && commgrpsDs == commgrpsDsMst && descNmMst == descNm){
				commFlag = false;
				break;
			}
		 };
		 if(commFlag){
			 gridMain.setCells2(rowIdx,gridMain.getColIndexById("descNm")).setValue(descNm);
			 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpdCd")).setValue(commgrpdCd);
		 }else{
			 dhtmlx.alert("중복된 데이터가 존재합니다.");
			 return true;
		 }
	 };
	 if(pName == "equiCode"){
		 var equiFlag = true;
		 for(var i=0;i<gridSub.getRowsNum();i++){
			 var itemCd = gridSub.setCells2(i,gridSub.getColIndexById("itemCd")).getValue();
			 if(itemCd == data[0].itemCd){
				 equiFlag = false;
				 break;
			 }
		 }
		 if(equiFlag){
			 var rowIdx = gridSub.getSelectedRowIndex();
			 gridSub.setCells2(rowIdx,gridSub.getColIndexById("itemCd")).setValue(data[0].itemCd);
			 gridSub.setCells2(rowIdx,gridSub.getColIndexById("itemName")).setValue(data[0].kitemDs);
			 gridSub.setCells2(rowIdx,gridSub.getColIndexById("itemSpec")).setValue(data[0].itemSz);
			 gridSub.setCells2(rowIdx,gridSub.getColIndexById("itemUnit")).setValue(data[0].itemUt); 
		 }else{
			 dhtmlx.alert("중복된 사용장비가 존재합니다. 확인해주세요.");
			 return true;
		 }
	 }
};
</script>
<form id="pForm" name="pForm">
    <input type="hidden" name="jsonData" id="jsonData">
    <input type="hidden" name="jsonData2" id="jsonData2">
</form>
<div id="bootContainer">
 <form id="frmMain" name="frmMain">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}" class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}"  class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
  </form>			
</div>
<div id="container"></div>