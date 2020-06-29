<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain, gridSub;
var calMain; 
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;
var custCd = null, invoiceNo = null, scmYn = null;
var rfidSqNoVal = null;
$(document).ready(function(){
	Ubi.setContainer(1,[1,3,4,6],"3E"); //납품등록RFID
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
	subLayout.cells("a").attachObject("bootContainer2");
	subLayout.cells("a").showHeader();
    subLayout.cells("a").setText("의뢰정보");
    subLayout.cells("a").setHeight(240);
    
    subLayout.cells("b").attachObject("bootContainer3");
	subLayout.cells("b").showHeader();
    subLayout.cells("b").setText("등록정보");
    subLayout.cells("b").setHeight(180);
	
	subLayout.cells("c").showHeader()
    subLayout.cells("c").setText("RFID정보")
    gridMain = new dxGrid(subLayout.cells("c"),false);
	gridMain.addHeader({name:"현장코드",    colId:"siteCd",   width:"60",     align:"left",   type:"ro"});
    gridMain.addHeader({name:"현장명",      colId:"siteDs",   width:"120",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"발주서번호",   colId:"poNo",     width:"90",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"청구서번호",   colId:"mrNo",     width:"90",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"견적의뢰번호",  colId:"inqNo",    width:"90",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"송장번호",    colId:"invoiceNo", width:"90",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"거래처코드",   colId:"custCd",   width:"80",    align:"left",    type:"ro"});
    gridMain.addHeader({name:"거래처명",    colId:"custDs",    width:"100",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"RFID_NO",   colId:"rfidNo",    width:"150",   align:"left",    type:"ro"});
    gridMain.addHeader({name:"RFID순번",   colId:"rfidsqNo",  width:"70",   align:"center",  type:"ro"});
    gridMain.addHeader({name:"품목코드",    colId:"itemCd",    width:"70",   align:"left",    type:"ro"});
    gridMain.addHeader({name:"접수수량",    colId:"itemQn",     width:"60",   align:"right",  type:"ron"});
    gridMain.addHeader({name:"차량번호",    colId:"carNo",      width:"80",   align:"left",   type:"ed"});
    gridMain.addHeader({name:"비고",       colId:"rmks",       width:"100",  align:"left",   type:"ed"});
    gridMain.addHeader({name:"입/출예정일자", colId:"outputDt",  width:"80",   align:"center", type:"ro"});
    gridMain.addHeader({name:"입고시간",    colId:"inputcDt",   width:"90",   align:"center", type:"ro"});
    gridMain.addHeader({name:"출고시간",    colId:"outputcDt",  width:"90",   align:"center", type:"ro"});
    gridMain.addHeader({name:"발행일자",    colId:"invoiceDt",  width:"80",   align:"center", type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@outputDt","format_date");
    gridMain.dxObj.setUserData("","@invoiceDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["sqNo","costId","scmYn","orderQn","deliSeq","jungsanYn"]);
    gridMain.cs_setNumberFormat(["itemQn"],"0,000.000");

    getjsonData();

    fn_search();
    
	$('#rfidNo').keypress(function(e){
 		if(e.which == '13'){
 			gridMainAddRow();
 		}
 	});
    
});
function getjsonData(){
 	if(PARAM_INFO.custCd != undefined){
 		custCd = PARAM_INFO.custCd;
 		$('#custCd2').val(PARAM_INFO.custCd);
 		$('#paramCustCd').val(PARAM_INFO.custCd);
	}
 	if(PARAM_INFO.custDs != undefined){
 		$('#custDs2').val(PARAM_INFO.custDs);
	}
 	if(PARAM_INFO.invoiceNo != undefined){
 		invoiceNo = PARAM_INFO.invoiceNo;
 		$('#paramInvoiceNo').val(PARAM_INFO.invoiceNo);
	}
 	if(PARAM_INFO.scmYn != undefined){
 		scmYn = PARAM_INFO.scmYn;
 		$('#paramScmYn').val(PARAM_INFO.scmYn);
	}
 	if(PARAM_INFO.siteCd != undefined){
 		siteCd = PARAM_INFO.siteCd;
 		$('#paramSiteCd').val(PARAM_INFO.siteCd);
	}
 	if(PARAM_INFO.mrNo != undefined){
 		mrNo = PARAM_INFO.mrNo;
 		$('#paramMrNo').val(PARAM_INFO.mrNo);
	}
 	if(PARAM_INFO.inqNo != undefined){
 		inqNo = PARAM_INFO.inqNo;
 		$('#paramInqNo').val(PARAM_INFO.inqNo);
	}
 	if(PARAM_INFO.poNo != undefined){
 		poNo = PARAM_INFO.poNo;
 		$('#paramPoNo').val(PARAM_INFO.poNo);
	}
 	if(PARAM_INFO.sqNo != undefined){
 		sqNo = PARAM_INFO.sqNo;
 		$('#paramSqNo').val(PARAM_INFO.sqNo);
	}
 	if(PARAM_INFO.costId != undefined){
 		costId = PARAM_INFO.costId;
 		$('#paramCostId').val(PARAM_INFO.costId);
	}
 	if(PARAM_INFO.deliSeq != undefined){
 		deliSeq = PARAM_INFO.deliSeq;
 		$('#paramDeliSeq').val(PARAM_INFO.deliSeq);
	}
 	if(PARAM_INFO.outputDt != undefined){
 		outputDt = PARAM_INFO.outputDt;
 		$('#outputDt').val(PARAM_INFO.outputDt);
	}
};

function fn_search(){
	var obj = {};
	obj.custCd = $('#paramCustCd').val();
	obj.invoiceNo = $('#paramInvoiceNo').val();
	obj.scmYn = $('#paramScmYn').val();
	obj.siteCd = $('#paramSiteCd').val();
	obj.mrNo = $('#paramMrNo').val();
	obj.inqNo = $('#paramInqNo').val();
	obj.poNo = $('#paramPoNo').val();
	obj.sqNo = $('#paramSqNo').val();
	obj.costId = $('#paramCostId').val();
	obj.deliSeq = $('#paramDeliSeq').val();
	if(obj.scmYn == ''){
		obj.scmYn = 1;
	}
	gfn_callAjaxForForm("frmMain",obj,"/erp/scm/work/partners/remicon/remiconS/formSearch",fn_searchCB);
};

function fn_searchCB(data){
	if(data != ''){
		var itemQn = data[0].itemQn;
		var orderQn = 0;
		var getRowsNum = gridMain.getRowsNum();
		if(getRowsNum != 0){
			for(var i=0;i<getRowsNum;i++){
				var orderQn = orderQn + gridMain.setCells2(i,gridMain.getColIndexById("itemQn")).getValue()*1;
			}
			orderQn = itemQn - orderQn;
			if(orderQn > 5){
				$('#orderQn').val('6');
			}else{
				$('#orderQn').val(orderQn);
			}
		}else{
			orderQn = itemQn;
			if(orderQn > 5){
				$('#orderQn').val('6');
			}else{
				$('#orderQn').val(orderQn);
			}
		}
		var obj = {};
		obj.scmYn = $('#paramScmYn').val();
		obj.poNo = data[0].poNo;
		obj.mrNo= data[0].mrNo;
		obj.inqNo = data[0].inqNo;
		obj.invoiceNo = data[0].invoiceNo;
		obj.siteCd = data[0].siteCd;
		obj.custCd = data[0].custCd;
		obj.costId = data[0].costId;
		obj.deliSeq = data[0].deliSeq;
		obj.sqNo = $('#paramSqNo').val();
		gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/work/partners/remicon/remiconS/gridMainSearch",subLayout.cells("c"),fn_sub01SearchCB);
	}
};

function fn_sub01SearchCB(data){
	if(data != ''){
		for(var i=0;i<gridMain.getRowsNum();i++){
			var inputcDt = gridMain.setCells2(i,gridMain.getColIndexById("inputcDt")).getValue();
			var outputcDt = gridMain.setCells2(i,gridMain.getColIndexById("outputcDt")).getValue();
			if(inputcDt != '' || outputcDt != ''){
				gridMain.setCellExcellType(gridMain.getRowId(i),gridMain.getColIndexById("carNo"),"ro");
			}
		}
	}
}

function gridMainAddRow(){
	var rfidFlag = true;
	var insertRfidNo = $('#rfidNo').val();
	var orderQn = $('#itemQn').val().split(",").join("");
	var itemQn = 0;
	var insertItemQn = $('#orderQn').val()*1;
	var getRowsNum = gridMain.getRowsNum();
	if(getRowsNum != 0){
		for(var i=0;i<getRowsNum;i++){
			 itemQn = itemQn + gridMain.setCells2(i,gridMain.getColIndexById("itemQn")).getValue()*1;
		}
	}
	if(insertItemQn == 0){
		rfidFlag =  false;
	}else if(itemQn > orderQn){
		rfidFlag =  false;
	}else if((itemQn+insertItemQn)>orderQn){
		dhtmlx.alert("청구수량을 초과하였습니다.");
		 $('#orderQn').val(orderQn-itemQn);
		 var orderQnFlag = orderQn-itemQn;
		if(orderQnFlag > 0){
			rfidFlag = true;
		}else{
			rfidFlag = false;
		}
	}
	var rfidNo = $('#rfidNo').val();
	var korCheck = /[ㄱ-ㅎ|ㅏ-ㅣ|가-힣]/;
	var engCheck = /[a-z|A-Z]/;
	if(rfidNo == ''){
		dhtmlx.alert("숫자만 입력가능합니다.");
		rfidFlag = false;
	}else if(rfidNo.match(korCheck)){
		dhtmlx.alert("숫자만 입력가능합니다.");
		rfidFlag = false;
	}else if(rfidNo.match(engCheck)){
		dhtmlx.alert("숫자만 입력가능합니다.");
		rfidFlag = false;
	}
	if(rfidFlag){
		var totalColNum = gridMain.getColumnCount();
		 var cnt = 1;
	  	  var data = new Array(totalColNum);
	  	  var siteCdColIdx    = gridMain.getColIndexById('siteCd');     
	      var siteDsColIdx    = gridMain.getColIndexById('siteDs');
	      var poNoColIdx      = gridMain.getColIndexById('poNo');
	      var mrNoColIdx      = gridMain.getColIndexById('mrNo');
	      var inqNoColIdx     = gridMain.getColIndexById('inqNo');
	      var invoiceNoColIdx = gridMain.getColIndexById('invoiceNo');
	      var custCdColIdx    = gridMain.getColIndexById('custCd');
	      var custDsColIdx    = gridMain.getColIndexById('custDs');
	      var rfidNoColIdx    = gridMain.getColIndexById('rfidNo');
	      var itemCdColIdx    = gridMain.getColIndexById('itemCd');
	      var orderQnColIdx   = gridMain.getColIndexById('orderQn');
	      var rmksColIdx      = gridMain.getColIndexById('rmks');
	      var outputDtColIdx  = gridMain.getColIndexById('outputDt');
	      var sqNoColIdx      = gridMain.getColIndexById('sqNo');
	      var costIdColIdx    = gridMain.getColIndexById('costId');
	      var scmYnColIdx     = gridMain.getColIndexById('scmYn');
	      var itemQnColIdx    = gridMain.getColIndexById('itemQn');
	      var invoiceDtColIdx = gridMain.getColIndexById('invoiceDt');
	      var deliSeqColIdx   = gridMain.getColIndexById('deliSeq');
	      var rfidsqNoColIdx  = gridMain.getColIndexById('rfidsqNo');
	      
	      data[siteCdColIdx]    = $('#siteCd').val(); 
		  data[siteDsColIdx]    = $('#siteDs').val(); 
		  data[poNoColIdx]      = $('#poNo').val(); 
		  data[mrNoColIdx]      = $('#mrNo').val(); 
		  data[inqNoColIdx]     = $('#inqNo').val(); 
		  data[invoiceNoColIdx] = $('#invoiceNo').val(); 
		  data[custCdColIdx]    = $('#custCd').val(); 
		  data[custDsColIdx]    = $('#custDs').val(); 
		  data[itemCdColIdx]    = $('#itemCd').val(); 
		  data[orderQnColIdx]   = $('#itemQn').val().split(",").join(""); 
		  data[rmksColIdx]      = $('#rmks').val(); 
		  data[outputDtColIdx]  = $('#outputDt').val(); 
		  data[sqNoColIdx]      = $('#sqNo').val(); 
		  data[costIdColIdx]    = $('#costId').val(); 
		  data[scmYnColIdx]     = $('#paramScmYn').val(); 
		  data[itemQnColIdx]    = $('#orderQn').val(); 
		  data[invoiceDtColIdx] = $('#outputDt').val();
		  data[deliSeqColIdx]   = $('#deliSeq').val();
		  
		  if(data[scmYnColIdx] == ''){
			  data[scmYnColIdx] = 1;
		  }

		if(data[invoiceNoColIdx] == ''){
			data[invoiceNoColIdx] = data[siteCdColIdx]+searchDate($('#outputDt').val());
		}
		
		for(var i=0;i<gridMain.getRowsNum();i++){
			var gridRfidNo = gridMain.setCells2(i,gridMain.getColIndexById("rfidNo")).getValue();
			if(gridRfidNo == ($('#rfidNo').val()*1)){
				cnt++;
			}
		}
		
		data[rfidNoColIdx]    = $('#rfidNo').val()*1; 
		if(cnt == 1){
			var rfidNo = $('#rfidNo').val()*1;
			fn_rfidSqNoChk(rfidNo);
			data[rfidsqNoColIdx] = rfidSqNoVal;
		}else{
			var rfidNoSqFlag = true;
			var subRfidNoSqFlag = true;
			var gridRfidSqNoVal = 0;
			var rfidNo = $('#rfidNo').val()*1;
			fn_rfidSqNoChk(rfidNo);
			if(rfidSqNoVal > 1){
				for(var i=0;i<gridMain.getRowsNum();i++){
					var gridRfidSqNoVal = gridMain.setCells2(i,gridMain.getColIndexById("rfidsqNo")).getValue();
					if(rfidSqNoVal == gridRfidSqNoVal){
						rfidNoSqFlag = false;
						break;
					}
				}
				if(rfidNoSqFlag){
					data[rfidsqNoColIdx] = rfidSqNoVal;
				}else{
					var subRfidSqNo = 0;
					var subRfidNoVal = $('#rfidNo').val()*1;
					for(var j=0;j<gridMain.getRowsNum();j++){
						var subRfidNo = gridMain.setCells2(j,gridMain.getColIndexById("rfidNo")).getValue();
						if(subRfidNo == subRfidNoVal){
							subRfidSqNo = gridMain.setCells2(j,gridMain.getColIndexById("rfidsqNo")).getValue()*1;
						}
					}
					data[rfidsqNoColIdx] = subRfidSqNo+1;
				}
			}else{
				data[rfidsqNoColIdx] = cnt;	
			}
		}
	

	  	gridMain.addRow(data);
	}
	$('#rfidNo').val('');
	rfidSqNoVal = null;
};

function fn_rfidSqNoChk(rfidNo){
	var obj = {};
	obj.siteCd = $('#siteCd').val();
	obj.invoiceDt = searchDate($('#outputDt').val());
	obj.rfidNo = rfidNo;
	gfn_callAjax(obj,"/erp/scm/work/partners/remicon/remiconS/selRfidSqNo", fn_rfidSqNoChkCB);
};

function fn_rfidSqNoChkCB(data){
	if(data != ''){
		rfidSqNoVal = data[0].rfidsqNo;
	}
}

function fn_save(){
    var obj={};
    obj.siteCd = $('#siteCd').val();
    obj.poNo = $('#poNo').val();
    obj.mrNo = $('#mrNo').val();
    obj.inqNo = $('#inqNo').val();
    obj.invoiceNo = $('#invoiceNo').val();
    gfn_callAjaxComm(obj,"/erp/scm/work/partners/remicon/remiconS/remiconSExists",fn_saveCB,'');
}

function fn_saveCB(data){
	var cnt = data[0].cnt;
	var jungsanFlag = false;
	for(var i=gridMain.getRowsNum()-1;i>=0;i--){
		var jungsan = gridMain.setCells2(i,gridMain.getColIndexById("jungsanYn")).getValue();
		if(jungsan == 0){
			jungsanFlag = false;
		}else{
			jungsanFlag = true;
			break;
		}
	 }
	if(cnt != 0){
		dhtmlx.alert("입고된 내역이 존재 하므로 입력,수정,삭제를 하실수 없습니다.");
		return true;
	}else if(jungsanFlag){
		dhtmlx.alert("정산된 내역은 수정,삭제를 하실수 없습니다.");
		return true;
	}else{
		var scmYn = $('#paramScmYn').val();
		if(scmYn == 1){
			var jsonStr = gridMain.getJsonUpdated();
		    if (jsonStr == null || jsonStr.length <= 0) return; 
			  $("#jsonData").val(jsonStr);
		   var params = $("#pForm").serialize();  
		   gfn_callAjaxComm(params,"/erp/scm/work/partners/remicon/remiconS/gridMainSaveScm",fn_search);	
		}else{
			var jsonStr = gridMain.getJsonUpdated();
		    if (jsonStr == null || jsonStr.length <= 0) return; 
			  $("#jsonData").val(jsonStr);
		   var params = $("#pForm").serialize();  
		  gfn_callAjaxComm(params,"/erp/scm/work/partners/remicon/remiconS/gridMainSave",fn_search);		
		}
	}
};

function fn_remove(){
	for(var i=gridMain.getRowsNum()-1;i>=0;i--){
		var jungsan = gridMain.setCells2(i,gridMain.getColIndexById("jungsanYn")).getValue();
		var inputcDt = gridMain.setCells2(i,gridMain.getColIndexById("inputcDt")).getValue();
		var outputcDt = gridMain.setCells2(i,gridMain.getColIndexById("outputcDt")).getValue();
		if(inputcDt != '' || outputcDt != ''){
			dhtmlx.alert("입고나 출고된 내역은 삭제하실수 없습니다.");
			return true;
		}else if(jungsan == 0){
			gridMain.cs_deleteRow(gridMain.getRowId(i));	
		}else{
			dhtmlx.alert("정산된 내역은 수정,삭제가 불가능합니다.");
			return true;
		}
	 }
};

function fn_delete(){
	var rodid = gridMain.getSelectedRowId();
	var jungsan = gridMain.setCells(rodid,gridMain.getColIndexById("jungsanYn")).getValue();
	var inputcDt = gridMain.setCells(rodid,gridMain.getColIndexById("inputcDt")).getValue();
	var outputcDt = gridMain.setCells(rodid,gridMain.getColIndexById("outputcDt")).getValue();
	if(inputcDt != '' || outputcDt != ''){
		dhtmlx.alert("입고나 출고된 내역은 삭제하실수 없습니다.");
		return true;
	}else if(jungsan == 0){
		gridMain.cs_deleteRow(rodid); 
	}else{
		dhtmlx.alert("정산된 내역은 수정,삭제가 불가능합니다.");
		return true;
	}
	
};

function fn_exit(){
	var TabId = "8000000011";
	var exitVal = cs_close_event([gridMain]);
	if(exitVal){
		mainTabbar.tabs(TabId).close();	
	}else{
		if(MsgManager.confirmMsg("WRN012")){
			mainTabbar.tabs(TabId).close();	
		}else{
			return true;
		}
	} 
	
};

</script>
<form id="pForm" name="pForm">
    <input type="hidden" name="jsonData" id="jsonData">
    <input type="hidden" name="paramCustCd" id="paramCustCd">
    <input type="hidden" name="paramInvoiceNo" id="paramInvoiceNo">
    <input type="hidden" name="paramScmYn" id="paramScmYn">
    <input type="hidden" name="paramSiteCd" id="paramSiteCd">
    <input type="hidden" name="paramMrNo" id="paramMrNo">
    <input type="hidden" name="paramInqNo" id="paramInqNo">
    <input type="hidden" name="paramPoNo" id="paramPoNo">
    <input type="hidden" name="paramSqNo" id="paramSqNo">
    <input type="hidden" name="paramCostId" id="paramCostId">
    <input type="hidden" name="paramDeliSeq" id="paramDeliSeq">
</form>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">의뢰처</label>
				<input name="custCd2" id="custCd2" type="text" value="" class="searchCode" readonly="readonly" onkeydown="event.preventDefault()">
				<input name="custDs2" id="custDs2" type="text" value="" class="searchName" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
</div>
<div id="bootContainer2">
  <form name="frmMain" id="frmMain">
    <input name="siteCd"     id="siteCd"     type="hidden" value="" >
    <input name="siteDs"     id="siteDs"     type="hidden" value="" >
    <input name="poNo"       id="poNo"       type="hidden" value="" >
    <input name="mrNo"       id="mrNo"       type="hidden" value="" >
    <input name="inqNo"      id="inqNo"      type="hidden" value="" >
    <input name="invoiceNo"  id="invoiceNo"  type="hidden" value="" >
    <input name="custCd"     id="custCd"     type="hidden" value="" >
    <input name="sqNo"       id="sqNo"       type="hidden" value="" >
    <input name="inputBc"    id="inputBc"    type="hidden" value="" >
    <input name="invoiceDt"  id="invoiceDt"  type="hidden" value="" >
    <input name="locationAt" id="locationAt" type="hidden" value="" >
     <input name="costId"    id="costId"     type="hidden" value="" >
     <input name="deliSeq"    id="deliSeq"   type="hidden" value="" >
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">거래처명</label>
				<input name="custDs" id="custDs" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">담당자 이름</label>
				<input name="chargeNm" id="chargeNm" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">담당자 전화번호</label>
				<input name="chargetelNo" id="chargetelNo" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">전화번호</label>
				<input name="telNo" id="telNo" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">의뢰일자</label>
				<input name="invoiceDt" id="invoiceDt" type="text" value="" class="inputbox1 format_date" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">입고장소</label>
				<input name="locationAt" id="locationAt" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">품목코드</label>
				<input name="itemCd" id="itemCd" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">품목명(한글)</label>
				<input name="kitemDs" id="kitemDs" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">규격</label>
				<input name="itemSz" id="itemSz" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">비목</label>
				<input name="itemUc" id="itemUc" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">단위</label>
				<input name="itemUt" id="itemUt" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">청구수량</label>
				<input name="itemQn" id="itemQn" type="text" value="" class="inputbox1 format_int" readonly="readonly" style="text-align: right;" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">청구단가</label>
				<input name="itemUp" id="itemUp" type="text" value="" class="inputbox1 format_int" readonly="readonly" style="text-align: right;" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">부가세</label>
				<input name="itemVat" id="itemVat" type="text" value="" class="inputbox1 format_int" readonly="readonly" style="text-align: right;" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div> 
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">합계</label>
				<input name="itemSum" id="itemSum" type="text" value="" class="inputbox1 format_int" readonly="readonly" style="text-align: right;">
			</div>
		</div>
	</div>
  </form>	
</div>
<div id="bootContainer3">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">입고예정일자</label>
				<input name="outputDt" id="outputDt" type="text" value="" class="searchDate format_date" disabled="disabled">
				<input type="button" id="calpicker" name="calpicker" class="calicon inputCal" disabled="disabled"> 
			</div>
		</div>
		<div class="left">
			<div class="ml30">
				<label class="title2">기본수량</label>
				<input name="orderQn" id="orderQn" type="text" value="" class="searchCode">
			</div> 
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">RFID No</label>
				<input name="rfidNo" id="rfidNo" type="number" value="" class="searchName">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">기타사항</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<textarea rows="4" cols="51" name="rmks" id="rmks" ></textarea>
			</div>
		</div>
	</div>
</div>
<div id="container"></div>