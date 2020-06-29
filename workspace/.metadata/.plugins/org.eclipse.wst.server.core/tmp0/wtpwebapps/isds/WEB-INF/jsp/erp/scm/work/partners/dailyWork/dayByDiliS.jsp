<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain, combo01;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){
	Ubi.setContainer(3,[1,3,4,5,6,8],"1C"); //일일근태 등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"#master_checkbox", colId:"workYn",    width:"50",  align:"center", type:"ch"});
    gridMain.addHeader({name:"No",               colId:"no",        width:"50",  align:"center", type:"cntr"});
    gridMain.addHeader({name:"근무자번호",          colId:"perNo",     width:"80",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"성명",              colId:"perNm",     width:"70",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"공종대분류",          colId:"title",     width:"70",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"공종코드",           colId:"commgrpsDs", width:"80",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"세부공종",           colId:"descNm",     width:"90",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"근태구분",           colId:"workKn",     width:"60", align:"center",   type:"combo"});
    gridMain.addHeader({name:"출근시간",           colId:"inTime",     width:"70",  align:"right",  type:"ed"});
    gridMain.addHeader({name:"퇴근시간",           colId:"outTime",    width:"70",  align:"right",  type:"ed"});
    gridMain.addHeader({name:"정상",             colId:"normal",     width:"70",  align:"right",  type:"edn"});
    gridMain.addHeader({name:"연장",             colId:"extend",     width:"70",  align:"right",  type:"edn"});
    gridMain.addHeader({name:"야근",             colId:"night",      width:"70",  align:"right",  type:"edn"});
    gridMain.addHeader({name:"특근",             colId:"special",    width:"70",  align:"right",  type:"edn"});
    gridMain.addHeader({name:"외출",             colId:"outside",    width:"70",  align:"right",  type:"edn"});
    gridMain.addHeader({name:"조퇴",             colId:"early",      width:"70",  align:"right",  type:"edn"});
    gridMain.addHeader({name:"지각",             colId:"late",       width:"70",  align:"right",  type:"edn"});
    gridMain.addHeader({name:"총근무",           colId:"total",       width:"70",  align:"right",   type:"ron"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@inTime","format_time");
    gridMain.dxObj.setUserData("","@outTime","format_time");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["siteCd","workDt","custCd","commgrpmCd","commgrpsCd","commgrpdCd","kind"]);
    gridMain.attachEvent("onRowSelect",doOnRowSelect);
	gridMain.attachEvent("onCellChanged",doOnCellChanged);
	gridMain.attachEvent("onKeyPress",doOnKeyPerss);
	gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);
	
	g_dxRules = {
			inTime : [r_notEmpty]
	};
	
    $("#dailyBtn").click(function(e){
        if(e.target.id == 'dailyBtn'){
			diliCreateChk();
		} 
	});
    
    $("#workPerNm").keypress(function(e){
    	if(e.keyCode == 13 && e.target.id == 'workPerNm'){
    		fn_searchPerNm();
    	}
    });
    
    $('#selPerNmBtn').click(function(e){
    	if(e.target.id == 'selPerNmBtn'){
    		fn_searchPerNm();
    	}
    });
    
   combo01 =gridMain.getColumnCombo(gridMain.getColIndexById("workKn"));
    
    gfn_single_comboLoad(combo01,["10","20","30","40"],["정상","휴가","결근","출장"],4);
    
    fn_search();
});
function fn_searchPerNm(){
	var perNm = $('#workPerNm').val();
	if(perNm == ''){
		return true;
	}else{
		var cnt = 0;
		var selectRowIdx = gridMain.getSelectedRowIndex();
		if(selectRowIdx == -1){
			selectRowIdx = 0;
		}
		for(var i=selectRowIdx+1;i<gridMain.getRowsNum();i++){
			var gridPerNm = gridMain.setCells2(i,gridMain.getColIndexById("perNm")).getValue();
			if(gridPerNm.indexOf(perNm) > -1){
				gridMain.selectRow(i,true, true, true);
				cnt++;
				break;
			}
		}
		if(cnt == 0){
			for(var i=0;i<gridMain.getRowsNum();i++){
				var gridPerNm = gridMain.setCells2(i,gridMain.getColIndexById("perNm")).getValue();
				if(gridPerNm.indexOf(perNm) > -1){
					gridMain.selectRow(i,true, true, true);
					break;
				}
			}
		}
	}
};

function doOnRowDblClicked(rId,cInd){
	var kind = gridMain.setCells(rId,gridMain.getColIndexById("kind")).getValue();
	if(cInd == 2 || cInd == 3){
		if(kind == "old"){
			return true;
		}else{
			gfn_load_pop('w1','comm/perNmPOP',[$('#siteCd').val(),'',"perNm"]);
		}
	}
	
};

function diliCreateChk(){
	var siteCd = $('#siteCd').val();
	if(siteCd == '' || siteCd == null){
		dhtmlx.alert("현장코드를 입력하세요.");
		return;
	}else{
		var obj = {};
		obj.workDt = searchDate($('#workDt').val());
		obj.siteCd = $('#siteCd').val();
		gfn_callAjaxComm(obj,"diliChk",diliCreateChkCB,"");	
	}
};
function diliCreateChkCB(data){
	if(data > 0){
		if(MsgManager.confirmMsg("INF009")){
			diliCreate('Y');
		}else{
			return true;
		}
	}else{
		diliCreate('N');
	}
};
function diliCreate(flag){
		var obj = {};
		obj.workDt = searchDate($('#workDt').val());
		obj.siteCd = $('#siteCd').val();
		obj.flag = flag;
		gfn_callAjaxComm(obj,"diliCreate",fn_search);
};

function doOnCellChanged(rId,cInd,nValue){
	if(cInd==10){
		doOnRowSelect(rId,cInd);
	  }
	if(cInd==11){
	    doOnRowSelect(rId,cInd);
	  }
	 if(cInd==12){
		doOnRowSelect(rId,cInd);
	  }
	 if(cInd==13){
		doOnRowSelect(rId,cInd);
	  }
	 if(cInd==14){
		 doOnRowSelect(rId,cInd);
	  }
	 if(cInd==15){
		 doOnRowSelect(rId,cInd);
	  }
	 if(cInd==16){
		 doOnRowSelect(rId,cInd);
	  }
};

function doOnRowSelect(id,ind){
		totalTimeCalcul(id);
};

function doOnKeyPerss(code,cFlag,sFlag){
	gridMain.dxObj.editCell();
	var cellIdx = gridMain.getSelectedCellIndex();
	var rowIdx = gridMain.getSelectedRowIndex();
	var timeValue = gridMain.setCells2(rowIdx,cellIdx).getValue();
	if(cellIdx == 8 || cellIdx ==9){
		timeCheck(timeValue,rowIdx,cellIdx);
	}
};
function timeCheck(value,rowIdx,cellIdx){
	var flag = false;
	var timeLen = value.length;
	if(timeLen == 2){
		value = value*1;
		if(value <1 || value > 24){
			dhtmlx.alert("시간을 잘못 입력하였습니다. 다시입력하세요.");
			gridMain.dxObj.editStop();
			flag = true;
		}
	}
	if(timeLen == 4){
	   value = value.substring(3,5);
	   if(value<0 || value >5){ 
		   dhtmlx.alert("시간을 잘못 입력하였습니다. 다시입력하세요.");
			gridMain.dxObj.editStop();
			flag = true;  
	   }
	}
	if(flag){
		gridMain.setCells2(rowIdx,cellIdx).setValue("");
	}
};

function totalTimeCalcul(id){
	 sum = gridMain.setCells(id,17).getValue()*1;
	var workVal = cell_calculator(gridMain,id,10,14);
	var lossWorkVal = cell_calculator(gridMain,id,14,17);
	sum = workVal - lossWorkVal;
	gridMain.setCells(id,17).setValue(sum); 
}

function fn_search(){
	var obj={};
	obj.siteCd = $('#siteCd').val();
	obj.workDt = searchDate($('#workDt').val());
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
};

function fn_searchCB(data){
	if(data != ''){
		for(var i=0;i<gridMain.getRowsNum();i++){
			gridMain.setCells2(i,gridMain.getColIndexById("kind")).setValue("old");
			gridMain.setCells2(i,gridMain.getColIndexById("cudKey")).setValue("UPDATE");
		}
	}
};

function fn_save(){
	var jsonStr = gridMain.getJsonUpdated();
	  if (jsonStr == null || jsonStr.length <= 0) return; 
	    $("#jsonData").val(jsonStr);
	  var params = $("#pform").serialize();  
	  gfn_callAjaxComm(params,"mainSave",fn_saveCB);	
};

function fn_saveCB(data){
   fn_search();	
};

function fn_remove(){
	for(var i=gridMain.getRowsNum()-1;i>=0;i--){
		gridMain.cs_deleteRow(gridMain.getRowId(i));	 
	 }
};

function fn_add(){
	var siteCd = $('#siteCd').val();
	if(siteCd == '' || siteCd == null){
		dhtmlx.alert("현장코드를 입력하세요.");
		return true;
	}else{
		var totalColNum = gridMain.getColumnCount();
		   var data = new Array(totalColNum);
		   var siteCdColIdx   = gridMain.getColIndexById('siteCd');
		   var workDtColIdx   = gridMain.getColIndexById('workDt');
		   var kindColIdx   = gridMain.getColIndexById('kind');
		   var workYnColIdx   = gridMain.getColIndexById('workYn');
		   var workKnColIdx   = gridMain.getColIndexById('workKn');
		   var intTimeColIdx   = gridMain.getColIndexById('inTime');
		   var outTimeColIdx   = gridMain.getColIndexById('outTime');
		   var normalColIdx   = gridMain.getColIndexById('normal');
		   var totalColIdx   = gridMain.getColIndexById('total');
		   data[siteCdColIdx]   = $('#siteCd').val();
		   data[workDtColIdx]   = searchDate($('#workDt').val());
		   data[kindColIdx]    = 'new';
		   data[workYnColIdx]    = '1';
		   data[workKnColIdx]    = '10';
		   data[intTimeColIdx]    = '08:00';
		   data[outTimeColIdx]    = '18:00';
		   data[normalColIdx]    = '9';
		   data[totalColIdx]    = '9';
		  gridMain.addRow(data);

	}
};

function fn_delete(){
	var rowId = gridMain.getSelectedRowId();
	gridMain.cs_deleteRow(rowId);	
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
		 fn_search();
	 }
	 if(pName == "perNm"){
		 var perNoChk = true;
		 var rowIdx = gridMain.getSelectedRowIndex();
		 for(var i=0;i<gridMain.getRowsNum();i++){
			 var perNo = gridMain.setCells2(i,gridMain.getColIndexById("perNo")).getValue();
			 if(i != rowIdx && data[0].perNo == perNo){
				 perNoChk = false;
				 break;
			 }
		 }
		 if(perNoChk){
			 gridMain.setCells2(rowIdx,gridMain.getColIndexById("perNo")).setValue(data[0].perNo);
			 gridMain.setCells2(rowIdx,gridMain.getColIndexById("perNm")).setValue(data[0].perNm); 
			 fn_selCommgrpm(data[0].perNo);
		 }else{
			dhtmlx.alert("해당 근무자는 이미 등록되어있습니다.");
			return true;
		 }
	 }
};

function fn_selCommgrpm(perNo){
	var obj = {};
	obj.siteCd = $('#siteCd').val();
	obj.perNo = perNo;
	gfn_callAjax(obj,"selCommgrpm", fn_selCommgrpmCB);
}

function fn_selCommgrpmCB(data){
	if(data != ''){
		 var rowIdx = gridMain.getSelectedRowIndex();
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("title")).setValue(data.title);
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpsDs")).setValue(data.commgrpsDs); 
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("descNm")).setValue(data.descNm); 
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpmCd")).setValue(data.commgrpmCd); 
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpsCd")).setValue(data.commgrpsCd); 
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpdCd")).setValue(data.commgrpdCd); 
	}
}
</script>
<form id="pform" name="pform" method="post">
    <input type="hidden" id="jsonData" name="jsonData" />
</form>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">일자</label>
				<input name="workDt" id="workDt" type="text" value="" class="searchDate format_date">
				<input type="button" id="calpicker" name="calpicker" class="calicon inputCal">
			</div>
		</div>	
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}"  class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}"  class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml20">
			    <button name="dailyBtn" id="dailyBtn" value="" class="btn3">근태자료생성</button>
			</div>
		</div>		
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">근무자</label>
				<input name="workPerNm" id="workPerNm" type="text" value=""  class="searchCode">
			</div>
		</div>
		<div class="left">
			<div class="ml10">
			    <button name="selPerNmBtn" id="selPerNmBtn" value="" class="btn3">근무자찾기</button>
			</div>
		</div>		
	</div>
</div>
<div id="container"></div>