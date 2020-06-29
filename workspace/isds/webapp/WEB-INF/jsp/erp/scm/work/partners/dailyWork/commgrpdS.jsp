<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;  
$(document).ready(function(){
	Ubi.setContainer(1,[1,2,3,5,6],"1C"); //세부 공종코드 등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"No",        colId:"no",       width:"50",   align:"center", type:"cntr"});
    gridMain.addHeader({name:"세부공종코드",  colId:"descCd",   width:"80",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"공종명",      colId:"descNm",   width:"120",   align:"left",   type:"ed"});
    gridMain.addHeader({name:"사용여부",    colId:"useYn",     width:"60",  align:"center",  type:"ch"});
    gridMain.addHeader({name:"비고",       colId:"rmks",      width:"200", align:"left",    type:"ed"});
    gridMain.setUserData("","pk","descCd");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["custCd","siteCd"]);

    g_dxRules = {descNm : [r_notEmpty]};

    fn_search();    
});
function fn_search(){
	var obj={};
	obj.siteCd = $('#siteCd').val();
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"));
};

function fn_new(){
	location.replace(location.pathname);
};

function fn_save(){
	var jsonStr = gridMain.getJsonUpdated();
	 if (jsonStr == null || jsonStr.length <= 0) return; 	
	$("#jsonData").val(jsonStr);
	var params = $("#pForm").serialize();  
	gfn_callAjaxComm(params,"gridMainSave",fn_search);	
};


function fn_add(){
	var siteCd = $('#siteCd').val();
	if(siteCd == '' || siteCd == null){
		dhtmlx.alert("현장코드를 입력하세요.");
		return;
	}else{
		var totalColNum = gridMain.getColumnCount();
        var data = new Array(totalColNum);      
	    var siteCdColIdx   = gridMain.getColIndexById('siteCd');
	    var useYnColIdx    = gridMain.getColIndexById('useYn');
		data[siteCdColIdx]   = $('#siteCd').val();
		data[useYnColIdx] = '1';
		gridMain.addRow(data);
	}		
};

function fn_delete(){
	var rodid = gridMain.getSelectedRowId();
	gridMain.cs_deleteRow(rodid);
};

function fn_exit(){
	var exitVal = cs_close_event([gridMain]);
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
		 $('#siteCd').focus();
	 }
};
</script>
<form id="pForm" name="pForm" method="post">
    <input type="hidden" id="jsonData" name="jsonData" />
</form>
<div id="bootContainer">
  <form  id="frmMain" name="frmMain">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}"  class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}"  class="inputbox3" onkeydown="event.preventDefault()" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>		
	</div>
</form>			
</div>
<div id="container"></div>