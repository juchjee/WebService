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
var initData;
var conKindFlag = true;
$(document).ready(function(){
	Ubi.setContainer(3,[1,3,4,5,6],"1C"); //기성청구등록
	 
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"No",       colId:"no",          width:"50",   align:"center", type:"cntr"});
    gridMain.addHeader({name:"File명",    colId:"fileNm",     width:"250",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"size(Kb)", colId:"fileSize",   width:"100",   align:"right",  type:"ron"});
    gridMain.addHeader({name:"첨부",      colId:"uploadFile", width:"68",    align:"left",   type:"ro"});
    gridMain.addHeader({name:"다운",      colId:"fileDown",   width:"60",    align:"center", type:"ro"});
    gridMain.addHeader({name:"비고",      colId:"rmks",       width:"300",   align:"left",   type:"ed"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["siteCd","hadocontNo","workYm","sqSn","filePath"]); 
    gridMain.cs_setNumberFormat(["fileSize"]);
     getjsonData();
     fn_search();
     
});
function getjsonData(){
 	if(PARAM_INFO.workYm != undefined){
		$('#workYm').val(PARAM_INFO.workYm);
	}
	if(PARAM_INFO.siteCd != undefined){
		$('#siteCd').val(PARAM_INFO.siteCd);
	}
	if(PARAM_INFO.siteNm != undefined){
		$('#siteNm').val(PARAM_INFO.siteNm);
	}
	if(PARAM_INFO.hadocontNo != undefined){
		$('#hadocontNo').val(PARAM_INFO.hadocontNo);
	}
	if(PARAM_INFO.hadocontDs != undefined){
		$('#hadocontDs').val(PARAM_INFO.hadocontDs);
	}
};

function fn_search(){
	var obj={};
	obj.hadocontNo = $('#hadocontNo').val();
	obj.siteCd = $('#siteCd').val();
	obj.workYm = searchDate($('#workYm').val());
	gfn_callAjaxForGridR(gridMain,obj,"/erp/scm/work/partners/instPayment/billingFileSave/gridMainSearch",subLayout.cells("a"),fn_searchCB);
	gfn_callAjax(obj, "/erp/scm//work/partners/instPayment/billingS/gridMainSearch", fn_conKindChk);
};

function fn_searchCB(data){
	var totalRowNum = gridMain.getRowsNum();
	fileCnt = totalRowNum;
	var fileIdx = gridMain.getColIndexById('uploadFile');
	var realFileNameIdx = gridMain.getColIndexById('filePath');
	var fileDownIdx = gridMain.getColIndexById('fileDown');
	
	for(var i = 0 ;i<totalRowNum;i++){
		var realFileName = gridMain.setCells2(i, realFileNameIdx).getValue();
		var fileTag = "<input type='file' name='attachFile' id='attachFile"+(i)+"' value='' style='display:none;' onchange='fileSetting("+(i)+", this.value)'>";
		var btnTag = "<button id='btnFile"+(i)+"' style='width:60px; height:29px;' onclick='fileClick("+i+")'>파일찾기</button>"; 
		 var downTag = "<img src='/images/button/down.png' id='btnDown"+(i)+"' onclick='downClick("+i+")' />";
		gridMain.setCells2(i, fileIdx).setValue(btnTag);
		gridMain.setCells2(i, fileDownIdx).setValue(downTag);
		$("#frmMain").append(fileTag);
	}        
};

function fn_conKindChk(data){
	if(data != ''){
		for(var i=0;i<data.length;i++){
			if(data[i].conKind=='50'){
				conKindFlag = false;
				break;
			}
		}
	}
}

function fn_save(){
	if(!conKindFlag){
		dhtmlx.alert("확정처리된 내역은 신규, 수정, 삭제가 불가능합니다.");
		return true;
	}else{
		var jsonStr = gridMain.getJsonUpdated();
		   if(jsonStr == null || jsonStr.length <= 0) return; 
		   
		   $("#jsonDataDummy").val(jsonStr);
		   $("#jsonData").val($("#jsonDataDummy").val());
		    var formData = new FormData();
			
		    $("input[name=attachFile]").each(function(index){
			formData.append("attachFile",$("input[name=attachFile]")[index].files[0]);	
		   });
			
		    formData.append("jsonData",$("#jsonData").val());

			$.ajax({
			    url: "/erp/scm/work/partners/instPayment/billingFileSave/gridMainSave",
			    type: "POST",
			    data: formData,
			    dataType: "text",
			    beforeSend: function() {
			    	subLayout.cells("a").progressOn();
		        },
			    processData: false,
			    contentType: false,
			    success: function(data) {
			        fn_saveCB(data);
			    },
			    complete: function() {
			    	subLayout.cells("a").progressOff();
		        }
		});		
	}
};

function fn_saveCB(data) {
	MsgManager.alertMsg("INF001")
    $("input[name=attachFile]").remove();
    fn_search();
};

function fn_remove(){
	if(!conKindFlag){
		dhtmlx.alert("확정처리된 내역은 신규, 수정, 삭제가 불가능합니다.");
		return true;
	}else{
	   var totalRowNum = gridMain.getRowsNum();
	   for(var i=1; i<=totalRowNum; i++){
		   gridMain.cs_deleteRow(i);
	   }	
	}
};

function fn_add(){
	if(!conKindFlag){
		dhtmlx.alert("확정처리된 내역은 신규, 수정, 삭제가 불가능합니다.");
		return true;
	}else{
		var totalRowNum = gridMain.getRowsNum();
		var totalColNum = gridMain.getColumnCount();
		var data = new Array(totalColNum);
		var siteCdColIdx = gridMain.getColIndexById('siteCd');
		var hadocontNoColIdx = gridMain.getColIndexById('hadocontNo');
		var workYmColIdx = gridMain.getColIndexById('workYm');
		var fileIdx = gridMain.getColIndexById('uploadFile');

		data[siteCdColIdx] = $('#siteCd').val();
		data[hadocontNoColIdx] = $('#hadocontNo').val();
		data[workYmColIdx] = searchDate($('#workYm').val());
		
		fileCnt = totalRowNum;
		var fileTag = "<input type='file' name='attachFile' id='attachFile"+fileCnt+"' value='' style='display:none;' onchange='fileSetting("+fileCnt+", this.value)'>";
		var btnTag = "<button id='btnFile"+fileCnt+"' style='width:60px; height:29px;' onclick='fileClick("+fileCnt+")'>파일찾기</button>";
		data[fileIdx] = btnTag;
		gridMain.addRow(data);
		gridMain.selectRow(totalRowNum);
		$("#frmMain").append(fileTag);
		fileDivision = "INSERT";		
	}
};

function fn_delete(){
	if(!conKindFlag){
		dhtmlx.alert("확정처리된 내역은 신규, 수정, 삭제가 불가능합니다.");
		return true;
	}else{
		var selectedId = gridMain.getSelectedRowId();
		 gridMain.cs_deleteRow(selectedId);
		 fileCnt = fileCnt - 1;	
	}
};

function fileClick(cnt){
	$("input[name=attachFile]").eq(cnt).click();
};

function fileSetting(cnt, val){
	var cudIdx = gridMain.getColIndexById('cudKey');
		cudCell = gridMain.setCells2(cnt, cudIdx);
		obj = gfn_getFileFormat(val)
	if( obj.flag ){
		if(fileDivision == "INSERT"){
			cudCell.setValue('INSERT');
		}else{
			cudCell.setValue('UPDATE');
		}
		   var size = document.getElementById("attachFile"+cnt).files[0].size;
		   if(size>=1024){
			   size = Math.ceil((size/1024).toFixed(2));
		   }else{
			   size = 1;
		   }
		   
		   gridMain.setCells2(cnt,gridMain.getColIndexById('fileSize')).setValue(size);
		   gridMain.setCells2(cnt,gridMain.getColIndexById('fileNm')).setValue(val);
	}else{
		$("input[name=attachFile]").eq(cnt).val('');
		MsgManager.alertMsg("WRN016", obj.format)
		return false;
	}
};

function downClick(cnt){
	var rfileIdx = gridMain.getColIndexById("filePath");
	var rfileId = gridMain.setCells2(cnt, rfileIdx).getValue();
	var ofileIdx = gridMain.getColIndexById("fileNm");
	var ofileId = gridMain.setCells2(cnt, ofileIdx).getValue();	
	var url = "/file/download?rFileId="+rfileId+"&oFileId="+ofileId+"&location=billing.savedir";
	location.href = url;
};

function fn_exit(){
	var exitVal = cs_close_event([gridMain]);
	if(exitVal){
		mainTabbar.tabs("9000000003").close();	
	}else{
		if(MsgManager.confirmMsg("WRN012")){
			mainTabbar.tabs("9000000003").close();	
		}else{
			return true;
		}
	} 
};
</script>
<form id="pForm" name="pForm">
   <input type="hidden" id="jsonDataDummy" name="jsonDataDummy">
</form>
<div id="bootContainer">
   <form class="form-horizontal" id="frmMain" enctype="multipart/form-data">
    <input type="hidden" id="jsonData" name="jsonData">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">청구년월</label>
				<input name="workYm" id="workYm" type="text" value="" class="searchCode" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="" placeholder="" class="searchCode" readonly="readonly" onkeydown="event.preventDefault()">
				<input name="siteNm" id="siteNm" type="text" value="" placeholder="" class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
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
	</div>
  </form>		
</div>
<div id="container"></div>