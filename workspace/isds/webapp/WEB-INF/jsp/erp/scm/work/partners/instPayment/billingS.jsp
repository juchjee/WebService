<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain;
var fileCnt = 0;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
var fileDivision;
$(document).ready(function(){
	Ubi.setContainer(3,[1,2,3,4],"1C"); //기성청구등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"No",     colId:"no",          width:"50",  align:"center", type:"cntr"});
    gridMain.addHeader({name:"공종코드", colId:"costCd",       width:"130", align:"left",   type:"ro"});
    gridMain.addHeader({name:"명칭",    colId:"itemDs",       width:"80", align:"left",   type:"ro"});
    gridMain.addHeader({name:"규격",    colId:"sizeSz",       width:"100", align:"left",   type:"ro"});
    gridMain.addHeader({name:"단위",    colId:"unitDs",       width:"60", align:"center",  type:"ro"});
    gridMain.addHeader({name:"구분",    colId:"hdFd",         width:"60", align:"center",  type:"ro"});
    gridMain.addHeader({name:"계약내역", colId:"hadoQn",       width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"hadoUp",       width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"hadoAm",       width:"110",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"전월누계", colId:"hadogspQn",    width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"hadogspAm",    width:"110",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"당월청구", colId:"scmHadogsQn",  width:"80",  align:"right",  type:"edn"});
    gridMain.addHeader({name:"#cspan", colId:"hadogsQn",     width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"hadogsAm",     width:"80",  align:"right",  type:"edn"});
    gridMain.addHeader({name:"누계기성", colId:"hadogstQn",     width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"hadogstAm",    width:"110",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"잔여금액", colId:"janQn",        width:"80",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"janAm",        width:"110",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"확정구분", colId:"conKindNm",     width:"80",  align:"center",  type:"ro"});
    gridMain.addHeader({name:"비고",    colId:"conRmk",       width:"200",  align:"left",  type:"ro"});
    gridMain.attachHeader("#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,수량,단가,금액,수량,금액,청구수량,확정수량,금액,수량,금액,수량,금액,#rspan,#rspan");
    gridMain.attachFooter("&nbsp;,합계,,,,,,,#stat_total,,#stat_total,,,#stat_total,,#stat_total,,#stat_total,,");
    gridMain.setUserData("","pk","");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setNumberFormat(["hadoQn","hadogspQn","hadogsQn","hadogstQn","scmHadogsQn","janQn"],"0,000.000");
    gridMain.cs_setNumberFormat(["hadoUp","hadoAm","hadogspAm","hadogsAm","hadogstAm","janAm"]);
    gridMain.cs_setColumnHidden(["siteCd","hadocontNo","workYm","costId","reqCon","conKind"]);
	gridMain.attachEvent("onCellChanged",doOnCellChanged);
	gridMain.attachEvent("onKeyPress",doOnKeyPress);
	gridMain.attachEvent("onRowSelect",doOnRowSelect);
	
	gridMain.dxObj.enableBlockSelection(false);
	
    calMain = new dhtmlXCalendarObject([{input:"workYm",button:"calpicker"}]); 
    calMain.loadUserLanguage("ko");
    calMain.setDateFormat("%Y/%m");
    calMain.hideTime();	   
    var t = new Date().getFullYear();
    var m = +new Date().getMonth()+1;
    m = fn_monthLen(m);
     byId("workYm").value = t+"/"+m;
     
     	$("#hadocontNo").dblclick(function(){
     		gfn_load_pop('w1','instPayment/hadocontNoPOP',[$('#siteCd').val(),"계약번호","hadocontNo"]);
     	});
     	$("#hadocontNo").keypress(function(e){
     		if(e.which == 13){
     			gfn_load_pop('w1','instPayment/hadocontNoPOP',[$('#siteCd').val(),"계약번호","hadocontNo"]);
     			return false;
     		}
     	});
     	
     	$('#fileBtn').click(function(){
     		moveFilePage("file");
     	});
     	
     	$('#excelBtn').click(function(){
     		moveFilePage("excel");
     	});
	
});
function moveFilePage(gubn){
	var cFlag = true;
	var preId = null;
    var uri = null;
    var tabName = null;
    if(gubn == 'file'){
    	preId = "9000000003";
    	uri = "erp/scm/work/partners/instPayment/billingFileSave";
    	tabName = "첨부파일관리";
    }else{
    	preId = "9000000020";
    	uri = "erp/scm/work/partners/instPayment/billingExcelUpload";
    	tabName = "Excel자료Upload";
    }
 
	var workYm = $('#workYm').val();
	var siteCd = $('#siteCd').val();
	var siteNm = $('#siteNm').val();
	var hadocontNo = $('#hadocontNo').val();
	var hadocontDs = $('#hadocontDs').val();
	if((siteCd == '' || siteCd == null) && gubn == 'file'){
		dhtmlx.alert("현장코드는 필수 입니다.");
		return true;
	}else if((hadocontNo == '' || hadocontNo == null) && gubn == 'file'){
		dhtmlx.alert("계약번호는 필수 입니다.");
		return true;
	}else{
		var param = "?workYm="+workYm+"&siteCd="+siteCd+"&hadocontNo="+hadocontNo+"&siteNm="+siteNm+"&hadocontDs="+hadocontDs;
		var ids = mainTabbar.getAllTabs();
		for(var i=0;i<ids.length;i++){
			if(ids[i] == preId){
				if(MsgManager.confirmMsg("INF006")) { 
					mainTabbar.tabs(preId).detachObject(true);
					mainTabbar.tabs(preId).attachURL("/"+uri+".do"+param);
					mainTabbar.tabs(preId).setActive();
					cFlag = false;
					break;
				}else{
					cFlag = false;
					return;
				}
			}
		}
		if(cFlag){				
			mainTabbar.addTab(preId, tabName, null, null, true, true);
		    mainTabbar.tabs(preId).attachURL("/"+uri+".do"+param);
		}
	}
};

function doOnCellChanged(rId,cInd,nValue){
	var nValue1 = 0;
	var hadogsQnIdx = gridMain.getColIndexById("scmHadogsQn");
	var hadogsAmIdx = gridMain.getColIndexById("hadogsAm");
	var selectIdx = gridMain.getSelectedCellIndex();
	var hadogsQn = gridMain.setCells(rId,hadogsQnIdx).getValue()*1;
	var hadogsAm = gridMain.setCells(rId,hadogsAmIdx).getValue()*1;
	if(cInd  == hadogsQnIdx && selectIdx == hadogsQnIdx){
		setTimeout(function(){
			nValue1 = $('.dhx_combo_edit').val();
			if(nValue1 == undefined){
				return true;	
			}else if(nValue1 == hadogsAm){
				return true;
			}else{
				hadoQnCalCul(rId,cInd,nValue1);	
			}
		}, 50);
	}else if(cInd == hadogsAmIdx && selectIdx == hadogsAmIdx){
		setTimeout(function(){
			nValue1 = $('.dhx_combo_edit').val();
			if(nValue1 == undefined){
				return true;
			}else if(nValue1 == hadogsQn){	
				return true;
			}else{
				hadoAmCalCul(rId,cInd,nValue1);	
			}
		}, 50);
	}
};

function hadoQnCalCul(id,cInd,initQty){
	var selectId = gridMain.getSelectedRowId();
	if(id == selectId){
	   initQty = initQty*1;
		var contractQty = gridMain.setCells(id,gridMain.getColIndexById("hadoQn")).getValue()*1;
		var contractPrc = gridMain.setCells(id,gridMain.getColIndexById("hadoUp")).getValue()*1;
	    var legMonthQty = gridMain.setCells(id,gridMain.getColIndexById("hadogspQn")).getValue()*1;
		contractQty = contractQty-legMonthQty;
		if(contractQty<initQty && initQty>0){ 
			dhtmlx.alert("당월청구수량이 계약수량을 넘을수 없습니다.");
			gridMain.setCells(id,gridMain.getColIndexById("scmHadogsQn")).setValue("0");
			var contractHadoAm = contractQty * contractPrc;
			
			//누계
			 var hadogspQn = gridMain.setCells(id,gridMain.getColIndexById("hadogspQn")).getValue()*1;//전월수량
			 var hadogspAm = gridMain.setCells(id,gridMain.getColIndexById("hadogspAm")).getValue()*1;//전월금액
			 gridMain.setCells(id,gridMain.getColIndexById("hadogstQn")).setValue(hadogspQn);
			 gridMain.setCells(id,gridMain.getColIndexById("hadogstAm")).setValue(hadogspAm); 
			 
			//실제 값 edit 
			 gridMain.editStop();
			 gridMain.setCells(id,gridMain.getColIndexById("hadogsAm")).setValue("0");
			 gridMain.setCells(id,gridMain.getColIndexById("scmHadogsQn")).setValue("0");
		}else if(initQty>0){
			var scmHadogsQn = initQty;
			 var hadoUp = gridMain.setCells(id,gridMain.getColIndexById("hadoUp")).getValue()*1;
			 var hadogsAm = scmHadogsQn*hadoUp;
			 hadogsAm = Math.round(hadogsAm);
			
			 //누계
			 var hadogspQn = gridMain.setCells(id,gridMain.getColIndexById("hadogspQn")).getValue()*1;//전월수량
			 var hadogspAm = gridMain.setCells(id,gridMain.getColIndexById("hadogspAm")).getValue()*1;//전월금액
			 var hadogstQn = scmHadogsQn+hadogspQn;
			 var hadogstAm = hadogsAm+hadogspAm;
			 gridMain.setCells(id,gridMain.getColIndexById("hadogstQn")).setValue(hadogstQn);
			 gridMain.setCells(id,gridMain.getColIndexById("hadogstAm")).setValue(hadogstAm);
			 
			 gridMain.setCells(id,gridMain.getColIndexById("hadogsAm")).setValue(hadogsAm);
		}else if(initQty == 0){
			var scmHadogsQn = initQty;
			 var hadoUp = gridMain.setCells(id,gridMain.getColIndexById("hadoUp")).getValue()*1;
			 var hadogsAm = "0";
			 hadogsAm = hadogsAm*1;
			
			 //누계
			 var hadogspQn = gridMain.setCells(id,gridMain.getColIndexById("hadogspQn")).getValue()*1;//전월수량
			 var hadogspAm = gridMain.setCells(id,gridMain.getColIndexById("hadogspAm")).getValue()*1;//전월금액
			 var hadogstQn = scmHadogsQn+hadogspQn;
			 var hadogstAm = hadogsAm+hadogspAm;
			 gridMain.setCells(id,gridMain.getColIndexById("hadogstQn")).setValue(hadogstQn);
			 gridMain.setCells(id,gridMain.getColIndexById("hadogstAm")).setValue(hadogstAm);
			 
			 gridMain.setCells(id,gridMain.getColIndexById("hadogsAm")).setValue("0");
		}
	}	
};

function hadoAmCalCul(id,cInd,initAm){
	var selectId = gridMain.getSelectedRowId();
	if(id == selectId){
		initAm = initAm*1;
		var contractQty = gridMain.setCells(id,gridMain.getColIndexById("hadoQn")).getValue()*1;
		var contractPrc = gridMain.setCells(id,gridMain.getColIndexById("hadoUp")).getValue()*1;
	    var legMonthQty = gridMain.setCells(id,gridMain.getColIndexById("hadogspQn")).getValue()*1;
	    var nowMonthQty = initAm/contractPrc;
		contractQty = contractQty-legMonthQty;
		if(contractQty<nowMonthQty){ 
			dhtmlx.alert("당월청구수량이 계약수량을 넘을수 없습니다.");
			gridMain.setCells(id,gridMain.getColIndexById("scmHadogsQn")).setValue("0");

			//누계
			 var hadogspQn = gridMain.setCells(id,gridMain.getColIndexById("hadogspQn")).getValue()*1;//전월수량
			 var hadogspAm = gridMain.setCells(id,gridMain.getColIndexById("hadogspAm")).getValue()*1;//전월금액
			 gridMain.setCells(id,gridMain.getColIndexById("hadogstQn")).setValue(hadogspQn);
			 gridMain.setCells(id,gridMain.getColIndexById("hadogstAm")).setValue(hadogspAm);
			 //실제 값 edit 
			 gridMain.editStop();
			 gridMain.setCells(id,gridMain.getColIndexById("scmHadogsQn")).setValue("0");
			 gridMain.setCells(id,gridMain.getColIndexById("hadogsAm")).setValue("0");
		}else if(initAm>0){
			var scmHadogsQn = initAm/contractPrc;
			scmHadogsQn = scmHadogsQn.toFixed(3);

			 //누계
			 var hadogspQn = gridMain.setCells(id,gridMain.getColIndexById("hadogspQn")).getValue()*1;//전월수량
			 var hadogspAm = gridMain.setCells(id,gridMain.getColIndexById("hadogspAm")).getValue()*1;//전월금액
			 var hadogstQn = (scmHadogsQn*1)+(hadogspQn*1);
			 var hadogstAm = initAm+hadogspAm;

			 gridMain.setCells(id,gridMain.getColIndexById("hadogstQn")).setValue(hadogstQn);
			 gridMain.setCells(id,gridMain.getColIndexById("hadogstAm")).setValue(hadogstAm);
	
			 gridMain.setCells(id,gridMain.getColIndexById("scmHadogsQn")).setValue(scmHadogsQn);
		}else if(initAm == 0){
			var scmHadogsQn = "0.000";
			scmHadogsQn = scmHadogsQn*1;
			 //누계
			 var hadogspQn = gridMain.setCells(id,gridMain.getColIndexById("hadogspQn")).getValue()*1;//전월수량
			 var hadogspAm = gridMain.setCells(id,gridMain.getColIndexById("hadogspAm")).getValue()*1;//전월금액
			 var hadogstQn = scmHadogsQn+hadogspQn;
			 var hadogstAm = initAm+hadogspAm;

			 gridMain.setCells(id,gridMain.getColIndexById("hadogstQn")).setValue(hadogstQn);
			 gridMain.setCells(id,gridMain.getColIndexById("hadogstAm")).setValue(hadogstAm);
			 
			 gridMain.setCells(id,gridMain.getColIndexById("scmHadogsQn")).setValue("0");
		}
	}	
};

function doOnKeyPress(code,cFlag,sFlag){
	var id = gridMain.getSelectedRowId();
	var ind = gridMain.getSelectedCellIndex();
	var hadogsQnIdx = gridMain.getColIndexById("scmHadogsQn");
	var hadogsAmIdx = gridMain.getColIndexById("hadogsAm");
	var dotValue = 0;
	if(ind == hadogsQnIdx){
		if((code > 47 && code < 58) || code == 8 || code == 190 || code == 110 || (code>95 && code < 106)){
			gridMain.editCell();
			nValue = $('.dhx_combo_edit').val();
			var valueLen = 0;
			var dotIndex = nValue.indexOf(".");
			if(dotIndex != -1){
				valueLen = nValue.substring(dotIndex+1,nValue.length);
			}
			if(valueLen.length <= 3 || valueLen.length == undefined){
				dotValue = nValue;
				doOnCellChanged(id,ind,nValue);
			}else{
				return true;
			}
		}else if(code == 13 || code == 9){
			var selectIdx = gridMain.getSelectedRowIndex();
			gridMain.dxObj.selectCell(gridMain.getRowId(selectIdx-1),ind+1,true,true,true);
		}else{
			gridMain.editStop();
			dhtmlx.alert("문자를 입력하실수 없습니다.");
			gridMain.setCells(id,hadogsQnIdx).setValue('');
			gridMain.setCells(id,hadogsAmIdx).setValue('');
			return true;
		}
	}else if(ind == hadogsAmIdx){
		if((code > 47 && code < 58) || code == 8 || code == 190 ||  code == 110 || (code>95 && code < 106)){
			nValue = $('.dhx_combo_edit').val();
			doOnCellChanged(id,ind,nValue);
		}else if(code == 13 || code == 9){
			var selectIdx = gridMain.getSelectedRowIndex();
			gridMain.dxObj.selectCell(gridMain.getRowId(selectIdx-1),ind-1,true,true,true);
		}else{
			gridMain.editStop();
			dhtmlx.alert("문자를 입력하실수 없습니다.");
			gridMain.setCells(id,hadogsQnIdx).setValue('');
			gridMain.setCells(id,hadogsAmIdx).setValue('');
			return true;
		}
	}
};

function doOnRowSelect(id,ind){
	for(var i=0;i<gridMain.getRowsNum();i++){
		var hadoQn = gridMain.setCells2(i,gridMain.getColIndexById("hadoQn")).getValue()*1;
		var hadoAm = gridMain.setCells2(i,gridMain.getColIndexById("hadoAm")).getValue()*1;
		var hadogstQn = gridMain.setCells2(i,gridMain.getColIndexById("hadogstQn")).getValue()*1;
		var hadogstAm = gridMain.setCells2(i,gridMain.getColIndexById("hadogstAm")).getValue()*1;
		var janQn = hadoQn-hadogstQn;
		var janAm = hadoAm-hadogstAm;
		gridMain.setCells2(i,gridMain.getColIndexById("janQn")).setValue(janQn);
		gridMain.setCells2(i,gridMain.getColIndexById("janAm")).setValue(janAm);
	}
};

function fn_search(){
	var obj={};
	obj.hadocontNo = $('#hadocontNo').val();
	obj.siteCd = $('#siteCd').val();
	obj.sqSn = $('#sqSn').val();
	obj.workYm = searchDate($('#workYm').val());
	gfn_callAjaxForGridR(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
	fn_searchControlDate();
};

function fn_searchCB(data){
    if(data != ''){
    	var workYmVal = searchDate($('#workYm').val());
    	var siteCdVal = $('#siteCd').val();
    	var hadocontNoVal = $('#hadocontNo').val();
    	initData = data;
    	var totalRowNum = gridMain.getRowsNum();
    	for(var i = 0 ;i<totalRowNum;i++){	
    		gridMain.setCells2(i,gridMain.getColIndexById("workYm")).setValue(workYmVal);
    		gridMain.setCells2(i,gridMain.getColIndexById("siteCd")).setValue(siteCdVal);
    		gridMain.setCells2(i,gridMain.getColIndexById("hadocontNo")).setValue(hadocontNoVal);
    		
    		var hadoQn = gridMain.setCells2(i,gridMain.getColIndexById("hadoQn")).getValue()*1;
    		var hadoAm = gridMain.setCells2(i,gridMain.getColIndexById("hadoAm")).getValue()*1;
    		var hadogstQn = gridMain.setCells2(i,gridMain.getColIndexById("hadogstQn")).getValue()*1;
    		var hadogstAm = gridMain.setCells2(i,gridMain.getColIndexById("hadogstAm")).getValue()*1;
    		var janQn = hadoQn-hadogstQn;
    		var janAm = hadoAm-hadogstAm;
    		gridMain.setCells2(i,gridMain.getColIndexById("janQn")).setValue(janQn);
    		gridMain.setCells2(i,gridMain.getColIndexById("janAm")).setValue(janAm);
    	    
    		var conKindVal = gridMain.setCells2(i,gridMain.getColIndexById("conKind")).getValue();
    		if(conKindVal == '10'){
    			gridMain.setCells2(i,gridMain.getColIndexById("conKindNm")).setValue('등록');
    			gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("conKindNm")).setTextColor('#000000');  
    		}else if(conKindVal == '20'){
    			gridMain.setCells2(i,gridMain.getColIndexById("conKindNm")).setValue('반려');
    			gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("conKindNm")).setTextColor('#ffbb00');  
    		}else if(conKindVal == '30'){
    			gridMain.setCells2(i,gridMain.getColIndexById("conKindNm")).setValue('수정');
    			gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("conKindNm")).setTextColor('#abf200');  
    		}else if(conKindVal == '50'){
    			gridMain.setCells2(i,gridMain.getColIndexById("conKindNm")).setValue('확정');
    			gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("conKindNm")).setTextColor('#ff0000');  
    			gridMain.setCellExcellType(gridMain.getRowId(i),11,"ron");
    			gridMain.setCellExcellType(gridMain.getRowId(i),13,"ron");
    		}
    	} 
    }  
};

function fn_new(){
	location.replace(location.pathname);
};

function fn_save(){
	var controlSdt = $('#controlSdt').val();
	var controlEdt = $('#controlEdt').val();
	var nowDate = $('#nowDate').val();
	if(controlSdt == '' || controlSdt== null || controlEdt == '' || controlEdt == null){
		dhtmlx.alert("통제일자 기간에만 신규, 수정, 삭제가 가능합니다.");
		return true;
	} else if((nowDate - controlSdt < 0) || (nowDate - controlEdt > 0)){
		dhtmlx.alert("통제일자 기간에만 신규, 수정, 삭제가 가능합니다.");
		return true;
	} else{
		var totalRowNum = gridMain.getRowsNum();
		fn_gridInitSave();
		var jsonStr = gridMain.getJsonUpdated();
		
		$("#jsonData").val(jsonStr);
		 var params = $("#pForm").serialize();  
		gfn_callAjaxComm(params,"gridMainSave",fn_search);	
	}
};

function fn_gridInitSave(){
	for(var i=0;i<gridMain.getRowsNum();i++){
		var conKindNm = gridMain.setCells2(i,gridMain.getColIndexById("conKindNm")).getValue();
		var scmHadogsQn = gridMain.setCells2(i, gridMain.getColIndexById("scmHadogsQn")).getValue()*1;
		if(conKindNm == '등록' && scmHadogsQn == 0){
			gridMain.setCells2(i,gridMain.getColIndexById("scmHadogsQn")).setValue('0');
			gridMain.setCells2(i,gridMain.getColIndexById("cudKey")).setValue('INSERT');	
		}
	}
};

function fn_remove(){
	if(MsgManager.confirmMsg("INF002")){
		fn_removeCB();
	}else{
		return true;
	}
};

function fn_removeCB(){
	var conKindFlag = false;
	for(var i=0;i<gridMain.getRowsNum();i++){
		var conKind = gridMain.setCells2(i,gridMain.getColIndexById("conKind")).getValue();
		if(conKind == '50'){
			conKindFlag = true;
			break;
		}
	}
	var controlSdt = $('#controlSdt').val();
	var controlEdt = $('#controlEdt').val();
	var nowDate = $('#nowDate').val();
	if(controlSdt == '' || controlSdt== null || controlEdt == '' || controlEdt == null){
		dhtmlx.alert("통제일자 기간에만 신규, 수정, 삭제가 가능합니다.");
		return true;
	} else if((nowDate - controlSdt < 0) || (nowDate - controlEdt > 0)){
		dhtmlx.alert("통제일자 기간에만 신규, 수정, 삭제가 가능합니다.");
		return true;
	} else if(conKindFlag){
		dhtmlx.alert("확정처리된 내역은 삭제하실수 없습니다.");
		return true;
	}else{
		var obj = {};
		obj.workYm = searchDate($('#workYm').val());
		obj.siteCd = $('#siteCd').val();
		obj.hadocontNo = $('#hadocontNo').val();
		gfn_callAjaxComm(obj,"delGridMain",fn_search);	
	}
}

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
		 $('#siteCd').focus();
	 }
	 if(pName == "hadocontNo"){
		 $('#hadocontNo').val(data[0].hadocontNo);
		 $('#hadocontDs').val(data[0].hadocontDs);
		 fn_searchControlDate();
		 $('#hadocontNo').focus();
	 }
};

function fn_searchControlDate(){
	$('#controlSdt').val('');
	$('#controlEdt').val('');
	$('#controlSdtNm').val('');
	$('#controlEdtNm').val('');
	var obj={};
	obj.hadocontNo = $('#hadocontNo').val();
	obj.siteCd = $('#siteCd').val();
	obj.workYm = searchDate($('#workYm').val());
	gfn_callAjax(obj, "controlDateSearch", fn_searchControlDateCB);
	gfn_callAjax({}, "currentNowDate", fn_currentDateCB);
};

function fn_searchControlDateCB(data){
	if(data != ''){
		$('#controlSdt').val(data.controlSdt);
		$('#controlEdt').val(data.controlEdt);
		$('#controlSdtNm').val(data.controlSdt.substring(0,4)+"/"+data.controlSdt.substring(4,6)+"/"+data.controlSdt.substring(6,8));
		$('#controlEdtNm').val(data.controlEdt.substring(0,4)+"/"+data.controlEdt.substring(4,6)+"/"+data.controlEdt.substring(6,8));
	}
};

function fn_currentDateCB(data){
	$('#nowDate').val(data.nowDate);
};
</script>
<form id="pForm" name="pForm">
   <input type="hidden" id="jsonData" name="jsonData">
</form>
<div id="bootContainer">
	<div class="listHeader">
	  <input name="nowDate" id="nowDate" type="hidden" value="" > 
		<div class="left">
			<div class="ml30">
				<label class="title1">청구년월</label>
				<input name="workYm" id="workYm" type="text" value="" class="searchDate format_month">
				<input type="button" id="calpicker" name="calpicker" class="calicon inputCal">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
				<label class="title0">통제일자</label>
				<input name="controlSdtNm" id="controlSdtNm" type="text" value="" class="searchDate" readonly="readonly" onkeydown="event.preventDefault()"> ~
				<input name="controlEdtNm" id="controlEdtNm" type="text" value=""  class="searchDate" readonly="readonly" onkeydown="event.preventDefault()">
				<input name="controlSdt" id="controlSdt" type="hidden" value="" >
				<input name="controlEdt" id="controlEdt" type="hidden" value="" >
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input type="hidden" id="sqSn" name="sqSn" value="0">
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}" placeholder="" class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}"  class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>		
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">계약번호</label>
				<input name="hadocontNo" id="hadocontNo" type="text" value="" class="searchCode" readonly="readonly" onkeydown="event.preventDefault()">
				<input name="hadocontDs" id="hadocontDs" type="text" value="" class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
			    <button name="fileBtn" id="fileBtn" value="" class="btn3">첨부파일관리</button>
			</div>
		</div>		
		<div class="left">
			<div class="mlZero">
			    <button name="excelBtn" id="excelBtn" value="" class="btn4">Excel자료 Upload</button>
			</div>
		</div>
	</div>	
</div>
<div id="container"></div>