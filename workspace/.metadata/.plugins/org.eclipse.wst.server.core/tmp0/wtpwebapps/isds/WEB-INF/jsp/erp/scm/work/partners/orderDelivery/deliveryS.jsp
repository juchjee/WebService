<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain, gridSub;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){
	Ubi.setContainer(2,[1,2,3,4,6,8],"2E"); //납품등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
	subLayout.cells("a").showHeader()
    subLayout.cells("a").setText("발주내역")
    gridMain = new dxGrid(subLayout.cells("a"),false);
	gridMain.addHeader({name:"납품",    colId:"chk",       width:"60",  align:"center", type:"ch"});
    gridMain.addHeader({name:"발주번호", colId:"poNo",      width:"100", align:"left",   type:"ro"});
    gridMain.addHeader({name:"품목구분", colId:"etcKindNm",  width:"60",  align:"center", type:"ro"});
    gridMain.addHeader({name:"품목코드", colId:"itemCd",     width:"70", align:"left",   type:"ro"});
    gridMain.addHeader({name:"품명",    colId:"kitemDs",    width:"150", align:"left",   type:"ed"});
    gridMain.addHeader({name:"규격",    colId:"itemSz",     width:"150", align:"left",   type:"ro"});
    gridMain.addHeader({name:"단위",    colId:"itemUt",     width:"70",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"배정수량", colId:"balAsgnQty",  width:"90",  align:"right",   type:"ron"});
    gridMain.addHeader({name:"미납수량", colId:"miDeliQty",   width:"90",  align:"right",   type:"ron"});
    gridMain.addHeader({name:"납기일자", colId:"deliveryDt", width:"80",  align:"center",  type:"ro"});
    gridMain.addHeader({name:"배정일자",  colId:"balDt",     width:"80",  align:"center", type:"ro"});
    gridMain.addHeader({name:"납품장소", colId:"locationAt", width:"100", align:"left",    type:"ro"});
    gridMain.addHeader({name:"비고",    colId:"rmks",       width:"150", align:"left",    type:"ro"});
    gridMain.addHeader({name:"외주처 비고", colId:"outsRmk",    width:"150",  align:"left",   type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@deliveryDt","format_date");
    gridMain.dxObj.setUserData("","@balDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["mrNo","inqNo","sqNo","custCd","costId","itemUp","itemAm","masterKey","deliSeq","itemQn","siteCd","siteDs",
                                 "etcKind","etcReqNo","etcCd"]);
    gridMain.cs_setNumberFormat(["itemQn","miDeliQty"],"0,000.000"); 
    gridMain.attachEvent("onCheck",doOnCheck);
    
    subLayout.cells("b").showHeader()
    subLayout.cells("b").setText("납품내역")
    gridSub = new dxGrid(subLayout.cells("b"),false);
    gridSub.addHeader({name:"발주번호", colId:"poNo",       width:"100",  align:"left",  type:"ro"});
    gridSub.addHeader({name:"품목구분", colId:"etcKindNm",  width:"60",  align:"center", type:"ro"});
    gridSub.addHeader({name:"품목코드", colId:"itemCd",     width:"70",  align:"left",  type:"ro"});
    gridSub.addHeader({name:"품명",    colId:"kitemDs",    width:"150",  align:"left",  type:"ro"});
    gridSub.addHeader({name:"규격",    colId:"itemSz",     width:"150",  align:"left",  type:"ro"});
    gridSub.addHeader({name:"단위",    colId:"itemUt",     width:"70",   align:"left",  type:"ro"});
    gridSub.addHeader({name:"배정수량", colId:"balAsgnQty", width:"90",   align:"right", type:"ron"});
    gridSub.addHeader({name:"납품수량", colId:"deliQty",    width:"90",   align:"right", type:"edn"});
    gridSub.addHeader({name:"납품단가", colId:"etcUp",    width:"90",   align:"right", type:"edn"});
    gridSub.addHeader({name:"납품금액", colId:"etcAm",    width:"90",   align:"right", type:"ron"});
    gridSub.setUserData("","pk","");
    gridSub.dxObj.enableHeaderMenu("false");
    gridSub.init();
    gridSub.cs_setColumnHidden(["deliNo","deliDt","deliSeq","deliSubSeq","siteCd","mrNo","inqNo","custCd","invoiceQn","itemQn",
                                "costId","itemUp","itemAm","deliveryDt","oldDeliQty","sqNo","masterKey","miDeliQty","deliSeqF","endYn",
                                "etcKind","etcReqNo","etcCd"]);
    gridSub.cs_setNumberFormat(["itemQn","deliQty"],"0,000.000"); 
    gridSub.cs_setNumberFormat(["etcUp","etcAm"]); 
    gridSub.attachEvent("onCellChanged",doOnCellChanged);
	gridSub.attachEvent("onKeyPress",doOnKeyPress);
	gridSub.attachEvent("onRowSelect",doOnSubRowSelect);
 
    getjsonData();
    fn_search();
    
});
function getjsonData(){
 	if(PARAM_INFO.siteCd != undefined){
		$('#siteCd').val(PARAM_INFO.siteCd);
	}
 	if(PARAM_INFO.siteDs != undefined){
		$('#siteNm').val(PARAM_INFO.siteDs);
	}
	if(PARAM_INFO.deliSeq != undefined){
		$('#deliSeq').val(PARAM_INFO.deliSeq);
	}
	if(PARAM_INFO.deliDt != undefined){
		$('#deliDt').val(PARAM_INFO.deliDt);
	}
	if(PARAM_INFO.actTabId != undefined){
		ActTabId = PARAM_INFO.actTabId;
	}
};

function doOnCheck(rId,cInd,state){
   if($('#siteCd').val() == ''){
	  dhtmlx.alert("현장코드는 필수 항목입니다.");
	  if(state){
		  gridMain.setCells(rId,0).setValue(0);
	  }else{
		  gridMain.setCells(rId,0).setValue(1);
	  }
	  return;
   }else{
	   gridMain.selectRow(gridMain.dxObj.getRowIndex(rId));
	  if(state){
		 fn_gridSubAdd(rId);
	  }else{
		fn_gridSubDelete(rId);
	  }
  }
};

function doOnSubRowSelect(id,ind){
	 var deliNoIdx = gridSub.getColIndexById("deliNo");
	 var deliNoVal = gridSub.setCells(id,gridSub.getColIndexById("deliNo")).getValue();1
	 if(deliNoVal != ''){
		var endYnVal = gridSub.setCells(id,gridSub.getColIndexById("endYn")).getValue();
		var invoiceQnVal  = gridSub.setCells(id,gridSub.getColIndexById("invoiceQn")).getValue();
		if(endYnVal != 0){
			 dhtmlx.alert("마감된내역은 수정이나 삭제가 불가능 합니다.");
			 var selectIdx = gridSub.getSelectedRowIndex();
			 gridSub.dxObj.selectCell(selectIdx,0,false,false,false);
			 return true;
		 }else if(invoiceQnVal > 0){
			 dhtmlx.alert("입고내역은 수정이나 삭제가 불가능 합니다.");
			 var selectIdx = gridSub.getSelectedRowIndex();
			 gridSub.dxObj.selectCell(selectIdx,0,false,false,false);
			 return true;
		 }
	 }	
};

function doOnCellChanged(rId,cInd,nValue){
	var nValue1 = 0;
	var etcUpIdx   = gridSub.getColIndexById("etcUp");
	var deliQtyidx = gridSub.getColIndexById("deliQty");
	var deliQtyVal = gridSub.setCells(rId,deliQtyidx).getValue()*1;
	var etcUpVal = gridSub.setCells(rId,etcUpIdx).getValue()*1;
	var selectIdx  = gridSub.getSelectedCellIndex();
	if(cInd  == etcUpIdx && selectIdx == etcUpIdx){
		setTimeout(function(){
			nValue1 = $('.dhx_combo_edit').val();
			if(nValue1 == undefined){
				return true;	
			}else if(nValue1 == deliQtyVal){
				return true;
			}else{
				etcUpCul(rId,cInd,nValue1);	
			}
		}, 50);
	}else if(cInd == deliQtyidx && selectIdx == deliQtyidx){
		setTimeout(function(){
			nValue1 = $('.dhx_combo_edit').val();
			if(nValue1 == undefined){
				return true;
			}else if(nValue1 == etcUpVal){	
				return true;
			}else{
				deliQtyCul(rId,cInd,nValue1);	
			}
		}, 50);
	}
};

function doOnKeyPress(code,cFlag,sFlag){
	var id = gridSub.getSelectedRowId();
	var ind = gridSub.getSelectedCellIndex();
	var deliQtyIdx = gridSub.getColIndexById("deliQty");
	var etcUpIdx = gridSub.getColIndexById("etcUp");
	var etcAmIdx = gridSub.getColIndexById("etcAm");
	if(ind == etcUpIdx){
		if((code > 47 && code < 58) || code == 8 || (code>95 && code < 106)){
			gridSub.editCell();
			nValue = $('.dhx_combo_edit').val();
			doOnCellChanged(id,ind,nValue);
		}else if(code == 13 || code == 9){
			var selectIdx = gridSub.getSelectedRowIndex();
			gridSub.dxObj.selectCell(selectIdx,0,true,true,true);
		}else{
			gridSub.editStop();
			dhtmlx.alert("문자를 입력하실수 없습니다.");
			gridSub.setCells(id,etcUpIdx).setValue('');
			gridSub.setCells(id,etcAmIdx).setValue('');
			return true;
		}
	}else if(ind == deliQtyIdx){
		if((code > 47 && code < 58) || code == 8 || code == 190 ||  code == 110 || (code>95 && code < 106)){
			gridSub.editCell();
			nValue = $('.dhx_combo_edit').val();
			doOnCellChanged(id,ind,nValue);
		}else if(code == 13 || code == 9){
			var selectIdx = gridSub.getSelectedRowIndex();
			gridSub.dxObj.selectCell(selectIdx,gridSub.getColIndexById("etcUp"),true,true,true);
		}else{
			gridSub.editStop();
			dhtmlx.alert("문자를 입력하실수 없습니다.");
			gridSub.setCells(id,etcUpIdx).setValue('');
			gridSub.setCells(id,etcAmIdx).setValue('');
			gridSub.setCells(id,deliQtyIdx).setValue('0');
			return true;
		}
	}
};

function etcUpCul(id,cInd,initUp){
	var selectId = gridSub.getSelectedRowId();
	if(id == selectId){
		initUp = initUp*1;
		var deliQty = gridSub.setCells(id,gridSub.getColIndexById("deliQty")).getValue()*1;
		if(initUp>0){
			var etcAm = deliQty*initUp;
			etcAm = etcAm.toFixed(0);
			 gridSub.setCells(id,gridSub.getColIndexById("etcAm")).setValue(etcAm);
		}else if(initUp == 0){
			 gridSub.setCells(id,gridSub.getColIndexById("etcAm")).setValue("0");
		}
	}	
};

function deliQtyCul(id,cInd,initDeliQty){
	var selectId = gridSub.getSelectedRowId();
	if(id == selectId){
		initDeliQty = initDeliQty*1;
		initDeliQty = initDeliQty.toFixed(3);
		var etcUp = gridSub.setCells(id,gridSub.getColIndexById("etcUp")).getValue()*1;
		var deliQtyIdx = gridSub.getColIndexById("deliQty");
		var balAsgnQtyIdx = gridSub.getColIndexById("balAsgnQty");
		var deliNoIdx = gridSub.getColIndexById("deliNo");
		var deliNoVal = gridSub.setCells(id,gridSub.getColIndexById("deliNo")).getValue();
		var balAsgnQty = gridSub.setCells(id,balAsgnQtyIdx).getValue()*1;

			 if(initDeliQty>0){
				 if(initDeliQty > balAsgnQty){
					 gridSub.editStop();
					 dhtmlx.alert("납품수량이 배정량보다 큽니다.");
					 gridSub.setCells(id,deliQtyIdx).setValue(balAsgnQty);
						if(etcUp != '' || etcUp != null){
							var etcAm = balAsgnQty * etcUp;
							etcAm = etcAm.toFixed(0);
							gridSub.setCells(id,gridSub.getColIndexById("etcAm")).setValue(etcAm);
						}
					}else{
						var etcAm = initDeliQty * etcUp;
						etcAm = etcAm.toFixed(0);
						gridSub.setCells(id,gridSub.getColIndexById("etcAm")).setValue(etcAm);
					}
				}else if(initDeliQty == 0){
					 var etcUp = gridSub.setCells(id,gridSub.getColIndexById("etcUp")).getValue()*1;
					 if(etcUp != '' || etcUp == null){
						 gridSub.setCells(id,gridSub.getColIndexById("etcUp")).setValue("0");
						 gridSub.setCells(id,gridSub.getColIndexById("etcAm")).setValue("0");
					 }else{
						 gridSub.setCells(id,gridSub.getColIndexById("etcUp")).setValue("");
						 gridSub.setCells(id,gridSub.getColIndexById("etcAm")).setValue("");
					 }
				} 
	}	
};

function fn_gridSubAdd(rId){	
    var poNoIdx       =  gridMain.getColIndexById('poNo');
    var siteCdIdx     =  gridMain.getColIndexById('siteCd');
    var itemCdIdx     =  gridMain.getColIndexById('itemCd');
    var kitemDsIdx    =  gridMain.getColIndexById('kitemDs');
    var itemSzIdx     =  gridMain.getColIndexById('itemSz');
    var itemUtIdx     =  gridMain.getColIndexById('itemUt');
    var itemQnIdx     =  gridMain.getColIndexById('itemQn');
    var miDeliQtyIdx  =  gridMain.getColIndexById('miDeliQty');
    var deliveryDtIdx =  gridMain.getColIndexById('deliveryDt');
    var mrNoIdx       =  gridMain.getColIndexById('mrNo');
	var inqNoIdx      =  gridMain.getColIndexById('inqNo');
	var sqNoIdx       =  gridMain.getColIndexById('sqNo');
	var custCdIdx     =  gridMain.getColIndexById('custCd');
	var costIdIdx     =  gridMain.getColIndexById('costId');
	var itemUpIdx     =  gridMain.getColIndexById('itemUp');
	var itemAmIdx     =  gridMain.getColIndexById('itemAm');
	var masterKeyIdx  =  gridMain.getColIndexById('masterKey');
	var deliSeqIdx    =  gridMain.getColIndexById('deliSeq');
	var balAsgnQtyIdx =  gridMain.getColIndexById('balAsgnQty');
	var etcKindIdx    =  gridMain.getColIndexById('etcKind');
	var etcKindNmIdx  =  gridMain.getColIndexById('etcKindNm');
	var etcReqNoIdx   =  gridMain.getColIndexById('etcReqNo');
	var etcCdIdx      =  gridMain.getColIndexById('etcCd');
		
		var totalColNum = gridSub.getColumnCount();
	    var data = new Array(totalColNum);
		var itemCdColIdx      = gridSub.getColIndexById('itemCd');  
		var kitemDsColIdx     = gridSub.getColIndexById('kitemDs');   
		var itemSzColIdx      = gridSub.getColIndexById('itemSz');   
		var itemUtColIdx      = gridSub.getColIndexById('itemUt');   
		var itemQnColIdx      = gridSub.getColIndexById('itemQn');   
		var miDeliQtyColIdx   = gridSub.getColIndexById('miDeliQty');   
		var deliQtyColIdx     = gridSub.getColIndexById('deliQty');     
		var siteCdColIdx      = gridSub.getColIndexById('siteCd');   
		var mrNoColIdx        = gridSub.getColIndexById('mrNo');   
		var inqNoColIdx       = gridSub.getColIndexById('inqNo');   
		var poNoColIdx        = gridSub.getColIndexById('poNo');   
		var custCdColIdx      = gridSub.getColIndexById('custCd');  
		var costIdColIdx      = gridSub.getColIndexById('costId');
		var itemUpColIdx      = gridSub.getColIndexById('itemUp');
		var itemAmColIdx      = gridSub.getColIndexById('itemAm');
		var deliveryDtColIdx  = gridSub.getColIndexById('deliveryDt');
		var deliDtColIdx      = gridSub.getColIndexById('deliDt');
		var sqNoColIdx        = gridSub.getColIndexById('sqNo');
		var masterKeyColIdx   = gridSub.getColIndexById('masterKey');
		var cudKeyColIdx      = gridSub.getColIndexById('cudKey');
		var deliSeqFColIdx    = gridSub.getColIndexById('deliSeqF');
		var balAsgnQtyColIdx  = gridSub.getColIndexById('balAsgnQty');
		var etcKindColIdx     = gridSub.getColIndexById('etcKind');
		var etcKindNmColIdx   = gridSub.getColIndexById('etcKindNm');
		var etcReqNoColIdx    = gridSub.getColIndexById('etcReqNo');
		var etcCdColIdx       = gridSub.getColIndexById('etcCd');

		  data[itemCdColIdx]      = gridMain.setCells(rId,itemCdIdx).getValue();
		  data[kitemDsColIdx]     = gridMain.setCells(rId,kitemDsIdx).getValue();
		  data[itemSzColIdx]      = gridMain.setCells(rId,itemSzIdx).getValue();
		  data[itemUtColIdx]      = gridMain.setCells(rId,itemUtIdx).getValue();
		  data[itemQnColIdx]      = gridMain.setCells(rId,itemQnIdx).getValue();
		  data[miDeliQtyColIdx]   = gridMain.setCells(rId,miDeliQtyIdx).getValue();
		  data[deliQtyColIdx]     = gridMain.setCells(rId,miDeliQtyIdx).getValue();
		  data[siteCdColIdx]      = gridMain.setCells(rId,siteCdIdx).getValue();
		  data[mrNoColIdx]        = gridMain.setCells(rId,mrNoIdx).getValue();
		  data[inqNoColIdx]       = gridMain.setCells(rId,inqNoIdx).getValue();
		  data[poNoColIdx]        = gridMain.setCells(rId,poNoIdx).getValue();
		  data[custCdColIdx]      = gridMain.setCells(rId,custCdIdx).getValue();
		  data[costIdColIdx]      = gridMain.setCells(rId,costIdIdx).getValue();
		  data[itemUpColIdx]      = gridMain.setCells(rId,itemUpIdx).getValue();
		  data[itemAmColIdx]      = gridMain.setCells(rId,itemAmIdx).getValue();
		  data[deliveryDtColIdx]  = searchDate(gridMain.setCells(rId,deliveryDtIdx).getValue());
		  data[deliDtColIdx]      = searchDate($('#deliDt').val());
		  data[sqNoColIdx]        = gridMain.setCells(rId,sqNoIdx).getValue();
		  data[masterKeyColIdx]   = gridMain.setCells(rId,masterKeyIdx).getValue();
		  data[cudKeyColIdx]      = 'INSERT';
		  data[deliSeqFColIdx]    = gridMain.setCells(rId,deliSeqIdx).getValue();
		  data[balAsgnQtyColIdx]  = gridMain.setCells(rId,balAsgnQtyIdx).getValue();
		  data[etcKindColIdx]     = gridMain.setCells(rId,etcKindIdx).getValue();
		  data[etcKindNmColIdx]   = gridMain.setCells(rId,etcKindNmIdx).getValue();
		  data[etcReqNoColIdx]    = gridMain.setCells(rId,etcReqNoIdx).getValue();
		  data[etcCdColIdx]       = gridMain.setCells(rId,etcCdIdx).getValue();
		  
		  gridSub.addRow(data);
		  gridMain.cs_deleteRow(rId);
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
	gridMain.cs_addRow(rId);
};

function fn_search(){
	var obj = {};
	obj.siteCd = $('#siteCd').val();
	obj.deliDt = searchDate($('#deliDt').val());
	obj.deliSeq = $('#deliSeq').val();
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"));
	gfn_callAjaxForGrid(gridSub,obj,"gridSubSearch",subLayout.cells("b"),fn_searchCB);
};

function fn_searchCB(data){
	if(data != ''){
	  $("input[name=deliDt]").attr("disabled",true);
	  $("input[name=calpicker]").attr("disabled",true);
	}
}


function fn_new(){
	location.replace(location.pathname);
}

function fn_save(){
	var upFlag = true;
	var seq = $('#deliSeq').val();
	for(var i=0;i<gridSub.getRowsNum();i++){
		var etcKind = gridSub.setCells2(i,gridSub.getColIndexById("etcKind")).getValue();
		var etcUp = gridSub.setCells2(i,gridSub.getColIndexById("etcUp")).getValue();
		if(etcKind == 'ETC' && etcUp == ''){
			upFlag = false;
			break;
		}
	}
	if(upFlag){
		if(seq == '' || seq == null){
			fn_seqReturn();
		}else{
			insertSeq(seq);
		}
		var jsonStr = gridSub.getJsonUpdated();
		if(jsonStr == null || jsonStr.length <= 0){ return;}  
		  $("#jsonData").val(jsonStr);
		  var params = $("#pForm").serialize();  
		 gfn_callAjaxComm(params,"gridSubSave",fn_search);
	}else{
		dhtmlx.alert("납품단가를 등록해주세요.");
		return true;
	}
	  	
};

function fn_seqReturn(){
	var obj = {};
	obj.deliDt = searchDate($('#deliDt').val());
	obj.siteCd = $('#siteCd').val();
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
			var endYnVal = gridSub.setCells2(i,gridSub.getColIndexById("endYn")).getValue();
			 var invoiceQnVal  = gridSub.setCells2(i,gridSub.getColIndexById("invoiceQn")).getValue()*1;
			 if(endYnVal == '1'){
				 
			 }else if(invoiceQnVal > 0){
				 
			 }else{
				 gridSub.cs_deleteRow(gridSub.getRowId(i));
			 }
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

function fn_delete(){	
	var rowIdx = gridSub.getSelectedRowIndex();
	var gridMainId = null;
	var masterKey = gridSub.setCells2(rowIdx,gridSub.getColIndexById('masterKey')).getValue();
	if(masterKey == ''){
		 var endYnVal = gridSub.setCells2(rowIdx,gridSub.getColIndexById("endYn")).getValue();
		   var invoiceQnVal  = gridSub.setCells2(rowIdx,gridSub.getColIndexById("invoiceQn")).getValue()*1;
		   if(endYnVal == '1'){
				 
			}else if(invoiceQnVal > 0){
				 
			}else{
			  gridSub.cs_deleteRow(gridSub.getRowId(rowIdx));
			}
	}else{
		for(var i=0;i<gridMain.getRowsNum();i++){
			var mstMasterKey = gridMain.setCells2(i,gridMain.getColIndexById("masterKey")).getValue();
			if(masterKey == mstMasterKey){
				gridMainId = gridMain.getRowId(i);
			}
		}
		gridMain.setCells(gridMainId,0).setValue('0');
		gridMain.setCells(gridMainId,gridMain.getColIndexById('cudKey')).setValue('UPDATE');
		gridMain.cs_addRow(gridMainId);	  
		gridSub.cs_deleteRow(gridSub.getRowId(rowIdx));
	}
}

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
				<input name="deliDt" id="deliDt" type="text" value="" placeholder="" class="searchDate format_date" >
				<input type="button" id="calpicker" name="calpicker" class="calicon inputCal">
			</div>
		</div>
		<div class="left">
			<div class="ml10">
				<input name="deliSeq" id="deliSeq" type="text" value="" class="inputSeq" onkeydown="event.preventDefault()" readonly="readonly">
			</div>
		</div>
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}" class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}" class="inputbox3" onkeydown="event.preventDefault()" readonly="readonly">
			</div>
		</div>
	</div>
</div>
<div id="container"></div>