<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout;
var gridMain, gridSub;
var selectList;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
var qtyFlag = 0;
$(document).ready(function(){
	Ubi.setContainer(2,[1,2,3,4,8],"2E"); //납품등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
	subLayout.cells("a").showHeader()
    subLayout.cells("a").setText("발주내역")
    gridMain = new dxGrid(subLayout.cells("a"),false);
	gridMain.addHeader({name:"납품",    colId:"chk",       width:"60",   align:"center", type:"ch"});
    gridMain.addHeader({name:"발주번호",  colId:"poNo",     width:"120",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"발주일자",  colId:"poDt",     width:"80",  align:"center",   type:"ro"});
    gridMain.addHeader({name:"품목코드",  colId:"itmCd",    width:"90", align:"left",   type:"ro"});
    gridMain.addHeader({name:"품목명",   colId:"itmNm",     width:"180", align:"left",   type:"ro"});
    gridMain.addHeader({name:"규격",    colId:"spec",      width:"180",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"단위",    colId:"umBcNm",    width:"60",  align:"left",  type:"ro"});
    gridMain.addHeader({name:"발주수량", colId:"poQty",     width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"미납수량", colId:"miDeliQty", width:"80",  align:"right",   type:"ron"});
    gridMain.addHeader({name:"납기일자", colId:"dlvDt",     width:"80",  align:"center",  type:"ro"});
    gridMain.addHeader({name:"긴급구분", colId:"urgBcNm",   width:"60", align:"center",   type:"ro"});
    gridMain.addHeader({name:"입고창고", colId:"whNm",      width:"70", align:"center",   type:"ro"});
    gridMain.addHeader({name:"비고",    colId:"rmks",      width:"200", align:"left",   type:"ro"});
    gridMain.addHeader({name:"마감완료", colId:"statBcNm",  width:"80", align:"center",   type:"ro"});
    gridMain.addHeader({name:"마감",    colId:"outsEndYn", width:"60", align:"center",   type:"ch"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@poDt","format_date");
    gridMain.dxObj.setUserData("","@dlvDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["poSq","itmId","urgBc","inWh","umBc","poFac","masterKey","custCd","custNm","statBc"]);
    gridMain.cs_setNumberFormat(["poQty","miDeliQty"],"0,000.000"); 
    gridMain.attachEvent("onCheck",doOnCheck);

    subLayout.cells("b").showHeader()
    subLayout.cells("b").setText("납품내역")
    gridSub = new dxGrid(subLayout.cells("b"),false);
    gridSub.addHeader({name:"발주번호",  colId:"poNo",      width:"120", align:"left",   type:"ro"});
    gridSub.addHeader({name:"발주일자",  colId:"poDt",      width:"80",  align:"center", type:"ro"});
    gridSub.addHeader({name:"품목코드",  colId:"itmCd",     width:"90",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"품목명",   colId:"itmNm",     width:"180",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"규격",     colId:"spec",      width:"180", align:"left",   type:"ro"});
    gridSub.addHeader({name:"단위",     colId:"umBcNm",    width:"60",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"발주수량",  colId:"poQty",     width:"70",  align:"right",  type:"ron"});
    gridSub.addHeader({name:"납품수량",  colId:"deliQty",   width:"80",  align:"right",  type:"edn"});
    gridSub.addHeader({name:"비고",     colId:"rmks",      width:"200", align:"left",   type:"ed"});
    gridSub.setUserData("","pk","");
    gridSub.dxObj.setUserData("","@poDt","format_date");
    gridSub.dxObj.enableHeaderMenu("false");
    gridSub.init();
    gridSub.cs_setNumberFormat(["poQty","miDeliQty","deliQty"],"0,000.000"); 
    gridSub.cs_setColumnHidden(["deliKey","deliDate","deliSeq","deliNo","poFac","itmId","custCd","custNm",
                                "oldDeliQty","poSq","masterKey","inWh","miDeliQty","inQty"]);
    gridSub.attachEvent("onRowSelect",doOnRowSubSelect);
    
    gfn_facCd_comboLoad("facCd","facCdSearch",fn_returnComboList);
    
    getjsonData();
    fn_search();
    
});
function fn_returnComboList(data){
	selectList=data;
};

function getjsonData(){
 	if(PARAM_INFO.deliDate != undefined){
		$('#deliDate').val(PARAM_INFO.deliDate);
	}
	if(PARAM_INFO.deliSeq != undefined){
		$('#deliSeq').val(PARAM_INFO.deliSeq);
	}
	if(PARAM_INFO.poFac != undefined){
		for(var i = 0;i<selectList.length;i++){
			if(selectList[i].facCd == PARAM_INFO.poFac){
				$('#facCd option:eq('+i+')').attr("selected","selected");
				$('#facCd').trigger('change');
				break;
			}	
		} 
	}
	if(PARAM_INFO.actTabId != undefined){
		ActTabId = PARAM_INFO.actTabId;
	}
};

function doOnCheck(rId,cInd,state){
	gridMain.selectRow(gridMain.dxObj.getRowIndex(rId));
	if(cInd==0){
		if(state){
		  fn_gridSubAdd(rId);
		}else{
		  fn_gridSubDelete(rId);
	    }	
	}else{
		var statBcVal = gridMain.setCells(rId,gridMain.getColIndexById('statBc')).getValue();
		if(statBcVal != 'MM110700'){
			if(state){
				gridMain.setCells(rId,gridMain.getColIndexById('outsEndYn')).setValue('0');
			}else{
				gridMain.setCells(rId,gridMain.getColIndexById('outsEndYn')).setValue('1');
			}
		}else{
			if(state){
				confrimOutYn(rId);
			}
		}
	}
	
};
function confrimOutYn(rId){
	if(MsgManager.confirmMsg("WRN018")){
		var jsonStr = returnJsonData(rId);
		if(jsonStr == null || jsonStr.length <= 0){ return;}  
		 $("#jsonData2").val(jsonStr);
		 var params = $("#pForm").serialize();  
		 gfn_callAjaxComm(params,"outsEndYnChk",fn_search);	
	}else{
		gridMain.setCells(rId,gridMain.getColIndexById('outsEndYn')).setValue('0');
		return true;
	}
};

function returnJsonData(rId){
	var jsonStr = "";
	var colId = "";
	var colNm = "";
	var colVal = "";
	var colType = "";
	var arr = [];
	var row={};
	for(var j = 0; j < gridMain.getColumnsNum(); j++){
		 colId = gridMain.dxObj.getColumnId(j);
		 colNm = gridMain.dxObj.getColLabel(j);
		 colVal = gridMain.setCells(rId,j).getValue();
		 colType = gridMain.dxObj.getColType(j);
		var classNm = gridMain.dxObj.getUserData("","@"+colId);

		 if(classNm != null){
		       var regExp = /[\{\}\[\]\/?;:|\)*`!^\+<>@\#$%&\\\=\(\'\"]/gi;
				colVal = colVal.replace(regExp, "");
		  }
			row[colId]=colVal;
	 }
		arr.push(row);
		
		jsonStr = JSON.stringify(arr);

		return jsonStr;
};


function doOnRowSubSelect(id,ind){
	var inQtyIdx = gridSub.getColIndexById("inQty");
	var inQtyVal = gridSub.setCells(id,gridSub.getColIndexById("inQty")).getValue()*1;
		if(inQtyVal > 0){
		   dhtmlx.alert("입고내역은 수정이나 삭제가 불가능 합니다.");
		   return true;
		 }
};

function fn_gridSubAdd(rId){	
	var statBcVal = gridMain.setCells(rId,gridMain.getColIndexById('statBc')).getValue();
	if(statBcVal == 'MM110700'){
		return true;
	}else{
    var poNoIdx       =  gridMain.getColIndexById('poNo');
    var poDtIdx       =  gridMain.getColIndexById('poDt');
    var custCdIdx     =  gridMain.getColIndexById('custCd');
    var custNmIdx     =  gridMain.getColIndexById('custNm');
    var itmCdIdx      =  gridMain.getColIndexById('itmCd');
    var itmNmIdx      =  gridMain.getColIndexById('itmNm');
    var specIdx       =  gridMain.getColIndexById('spec');
    var umBcNmIdx     =  gridMain.getColIndexById('umBcNm');
    var poQtyIdx      =  gridMain.getColIndexById('poQty');
    var miDeliQtyIdx  =  gridMain.getColIndexById('miDeliQty');
	var poSqIdx       =  gridMain.getColIndexById('poSq');
	var itmIdIdx      =  gridMain.getColIndexById('itmId');
	var poFacIdx      =  gridMain.getColIndexById('poFac');
	var masterKeyIdx  =  gridMain.getColIndexById('masterKey');
	var inWhIdx       =  gridMain.getColIndexById('inWh');

		var totalColNum = gridSub.getColumnCount();
	    var data = new Array(totalColNum);
		var poNoColIdx      = gridSub.getColIndexById('poNo');  
		var poDtColIdx      = gridSub.getColIndexById('poDt');   
		var custCdColIdx    = gridSub.getColIndexById('custCd');   
		var custNmColIdx    = gridSub.getColIndexById('custNm');   
		var itmCdColIdx     = gridSub.getColIndexById('itmCd');   
		var itmNmColIdx     = gridSub.getColIndexById('itmNm');   
		var specColIdx      = gridSub.getColIndexById('spec');     
		var umBcNmColIdx    = gridSub.getColIndexById('umBcNm');   
		var poQtyColIdx     = gridSub.getColIndexById('poQty');   
		var miDeliQtyColIdx = gridSub.getColIndexById('miDeliQty');   
		var deliQtyColIdx   = gridSub.getColIndexById('deliQty');  
		var deliDateColIdx  = gridSub.getColIndexById('deliDate');  
		var poFacColIdx     = gridSub.getColIndexById('poFac');
		var itmIdColIdx     = gridSub.getColIndexById('itmId');
		var poSqColIdx      = gridSub.getColIndexById('poSq');
		var masterKeyColIdx = gridSub.getColIndexById('masterKey');
		var cudKeyColIdx    = gridSub.getColIndexById('cudKey');
		var inWhColIdx      = gridSub.getColIndexById('inWh');
	
		  data[poNoColIdx]       = gridMain.setCells(rId,poNoIdx).getValue();
		  data[poDtColIdx]       = gridMain.setCells(rId,poDtIdx).getValue();
		  data[custCdColIdx]     = gridMain.setCells(rId,custCdIdx).getValue();
		  data[custNmColIdx]     = gridMain.setCells(rId,custNmIdx).getValue();
		  data[itmCdColIdx]      = gridMain.setCells(rId,itmCdIdx).getValue();
		  data[itmNmColIdx]      = gridMain.setCells(rId,itmNmIdx).getValue();
		  data[specColIdx]       = gridMain.setCells(rId,specIdx).getValue();
		  data[umBcNmColIdx]     = gridMain.setCells(rId,umBcNmIdx).getValue();
		  data[poQtyColIdx]      = gridMain.setCells(rId,poQtyIdx).getValue();
		  data[miDeliQtyColIdx]  = gridMain.setCells(rId,miDeliQtyIdx).getValue();
		  data[deliQtyColIdx]    = gridMain.setCells(rId,miDeliQtyIdx).getValue();
		  data[deliDateColIdx]   = searchDate($('#deliDate').val());
		  data[poFacColIdx]      = gridMain.setCells(rId,poFacIdx).getValue();
		  data[itmIdColIdx]      = gridMain.setCells(rId,itmIdIdx).getValue();
		  data[poSqColIdx]       = gridMain.setCells(rId,poSqIdx).getValue();
		  data[masterKeyColIdx]  = gridMain.setCells(rId,masterKeyIdx).getValue();
		  data[cudKeyColIdx]     = 'INSERT';
		  data[inWhColIdx]       = gridMain.setCells(rId,inWhIdx).getValue();

		  gridSub.addRow(data);
		  
		  gridMain.setCells(rId,gridMain.getColIndexById("cudKey")).setValue("DELETE");
		  gridMain.dxObj.setRowTextStyle(rId, "font-family:arial;font-style: italic;color:#C0C0C0;");
		  var color = fn_gridCellColor(rId);
		  gridMain.dxObj.cells(rId,gridMain.getColIndexById("statBcNm")).setTextColor(color);  
	}
};

function fn_gridSubDelete(rId){
	var gridSubId = null;
	var gridMainInqNo = gridMain.setCells(rId,gridMain.getColIndexById('masterKey')).getValue();
	for(var i=0;i<gridSub.getRowsNum();i++){
		var gridSubInqNo = gridSub.setCells2(i,gridSub.getColIndexById('masterKey')).getValue();
		if(gridMainInqNo == gridSubInqNo){
			gridSubId = gridSub.getRowId(i);
		}
	}
	gridSub.deleteRow(gridSubId);
	gridMain.setCells(rId,gridMain.getColIndexById('cudKey')).setValue('UPDATE');
	
	gridMain.dxObj.setRowTextStyle(rId, "font-family:arial;font-style:color:#000000;");
	var color = fn_gridCellColor(rId);
	gridMain.dxObj.cells(rId,gridMain.getColIndexById("statBcNm")).setTextColor(color); 
	
};

function fn_gridCellColor(rId){
	var rowIdx = rId%2;
	var color = null;
	if(rowIdx == 0){
		color = "#e8e8e8";
	}else{
		color = "#000000";
	}
	var statBc = gridMain.setCells(rId,gridMain.getColIndexById("statBc")).getValue();
	if(statBc == "MM110100"){
		color = "#000000";
	}else if(statBc == "MM110300"){
		color = "#FFE400";
	}else if(statBc == "MM110500"){
		color = "#ABF200"; 
	}else if(statBc == "MM110700"){
		color = "#ff0000";
	}else if(statBc == "MM110900"){
		color = "#FF5E00";
	}
	
	return color;
}

function fn_search(){
	var obj = {};
	obj.facCd = $('#facCd').val();
	obj.deliDate = searchDate($('#deliDate').val());
	obj.deliSeq = $('#deliSeq').val();
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_mainSearchCB);
	gfn_callAjaxForGrid(gridSub,obj,"gridSubSearch",subLayout.cells("b"));
};

function fn_mainSearchCB(data){
	if(data != ''){		
		for(var i=0;i<gridMain.getRowsNum();i++){
			var statBc = gridMain.setCells2(i,gridMain.getColIndexById("statBc")).getValue();
			if(statBc == "MM110100"){
				gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("statBcNm")).setTextColor('#000000');  
			}else if(statBc == "MM110300"){
				gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("statBcNm")).setTextColor('#FFE400'); 
			}else if(statBc == "MM110500"){
				gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("statBcNm")).setTextColor('#ABF200'); 
			}else if(statBc == "MM110700"){
				gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("statBcNm")).setTextColor('#ff0000'); 
			}else if(statBc == "MM110900"){
				gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("statBcNm")).setTextColor('#FF5E00'); 
			}
		}
	}
};

function fn_new(){
	location.replace(location.pathname);
}

function fn_save(){
	var seq = $('#deliSeq').val();
	if(seq == '' || seq == null){
		fn_seqReturn();
	}else{
		insertSeq(seq);
	}
	fn_deliQtyCheck();
	if(qtyFlag  == 0){
		var jsonStr = gridSub.getJsonUpdated();
		  if(jsonStr == null || jsonStr.length <= 0){ return;}  
		    $("#jsonData").val(jsonStr);
		    var params = $("#pForm").serialize();  
		   gfn_callAjaxComm(params,"gridSubSave",fn_search);
	}else{
		qtyFlag = 0;
	}  	
};

function fn_deliQtyCheck(){
	for(var i=0;i<gridSub.getRowsNum();i++){
		if(qtyFlag == 0){
			var obj = {};
			obj.poNo = gridSub.setCells2(i,gridSub.getColIndexById("poNo")).getValue();
			obj.poSq = gridSub.setCells2(i,gridSub.getColIndexById("poSq")).getValue();
			obj.deliQty = gridSub.setCells2(i,gridSub.getColIndexById("deliQty")).getValue()*1;
			obj.oldDeliQty = gridSub.setCells2(i,gridSub.getColIndexById("oldDeliQty")).getValue()*1;
			console.log(obj);
			gfn_callAjaxComm(obj, "selQtyCheck", fn_deliQtyCheckCB, '');
		}else{
			break;
		}
	}
};

function fn_deliQtyCheckCB(data){
	if(data != ''){
		qtyFlag = 1;
		dhtmlx.alert("납품수량이 발주수량을 초과하였습니다.");
		return true;
	}
};

function fn_seqReturn(){
	var obj = {};
	obj.deliDate = searchDate($('#deliDate').val());
	gfn_callAjax(obj,"deliverySeq",fn_seqReturnCB);
};

function fn_seqReturnCB(data){
	 $('#deliSeq').val(data.deliSeq);
	 var seq = $('#deliSeq').val();
	insertSeq(seq);
}

function insertSeq(seq){
	for(var i=0;i<gridSub.getRowsNum();i++){
		gridSub.setCells2(i,gridSub.getColIndexById("deliSeq")).setValue(seq);
	}	
}

function fn_remove(){
	if(MsgManager.confirmMsg("WRN017")){
		for(var i=gridSub.getRowsNum()-1;i>=0;i--){
			gridSub.cs_deleteRow(gridSub.getRowId(i));
		 }
		fn_removeCB();
	}else{
		return true;
	}	
};

function fn_removeCB(){
	var jsonStr = gridSub.getJsonUpdated();
	  if(jsonStr == null || jsonStr.length <= 0){ return;}  
	    $("#jsonData").val(jsonStr);
	    var params = $("#pForm").serialize();  
	    gfn_callAjaxComm(params,"gridSubSave",fn_search);		
};

function fn_exit(){
	var exitVal = cs_close_event([gridSub]);
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
</script>
<form id="pForm" name="pForm">
    <input type="hidden" name="jsonData" id="jsonData">
     <input type="hidden" name="jsonData2" id="jsonData2">
</form>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">납품등록일자</label>
				<input name="deliDate" id="deliDate" type="text" value="" placeholder="" class="searchDate format_date">
				<input type="button" id="calpicker" name="calpicker" class="calicon inputCal">
			</div>
		</div>
		<div class="left">
			<div class="ml10">
				<input name="deliSeq" id="deliSeq" type="text" value="" class="inputSeq" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">	
			<div class="ml30">
				<font size="2px;" style="color: red;">* 마감완료 내역이 강제완료인 내역은 마감 항목을 체크하면 해당 발주내역이 마감되고 납품대기내역에서 사라집니다.</font>
			</div>
		</div>
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">공장코드</label>
			</div>
		</div>	
		<div class="left">	
			<div class="mlZero">
				<select name="facCd" id="facCd" class="searchBox"></select>
			</div>
		</div>	
		
	</div>	
</div>
<div id="container"></div>