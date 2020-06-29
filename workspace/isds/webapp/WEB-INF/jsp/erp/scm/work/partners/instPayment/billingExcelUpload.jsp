<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@page  import="org.apache.commons.lang.StringUtils,java.io.*"%>
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
$(document).ready(function(){
	Ubi.setContainer(3,[1],"1C"); //엑셀자료 관리
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"No",     colId:"no",          width:"50",  align:"center", type:"cntr"});
    gridMain.addHeader({name:"공종코드", colId:"costCd",       width:"130", align:"left",   type:"ro"});
    gridMain.addHeader({name:"명칭",    colId:"itemDs",       width:"150", align:"left",   type:"ro"});
    gridMain.addHeader({name:"규격",    colId:"sizeSz",       width:"100", align:"left",   type:"ro"});
    gridMain.addHeader({name:"단위",    colId:"unitDs",       width:"60", align:"center",  type:"ro"});
    gridMain.addHeader({name:"계약내역", colId:"hadoQn",       width:"90",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"hadoUp",       width:"90",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"hadoAm",       width:"110",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"전월누계기성", colId:"hadogspQn",  width:"90",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"hadogspAm",    width:"110",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"금회기성", colId:"hadogsQn",      width:"90",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"hadogsAm",     width:"110",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"누계기성", colId:"hadogstQn",     width:"90",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"hadogstAm",    width:"110",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"잔여기성", colId:"hadogsmQn",     width:"90",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"#cspan", colId:"hadogsmAm",    width:"110",  align:"right",  type:"ron"});
    gridMain.attachHeader("#rspan,#rspan,#rspan,#rspan,#rspan,수량,단가,금액,수량,금액,수량,금액,수량,금액,수량,금액");
    gridMain.setUserData("","pk","");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setNumberFormat(["hadoQn","hadogspQn","hadogsQn","hadogstQn","hadogsmQn"],"0,000.000");
    gridMain.cs_setNumberFormat(["hadoUp","hadoAm","hadogspAm","hadogsAm","hadogstAm","hadogsmAm"]);
    gridMain.cs_setColumnHidden(["siteCd","hadocontNo","costId","costGr","upcostId","costYn","workYm"]);
	
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
     	
     	$('#downBtn').click(function(){
     	  downFile();
     	  return false;
     	});
     	$('#uploadBtn').click(function(){
     		var controlSdt = $('#controlSdt').val();
     		var controlEdt = $('#controlEdt').val();
     		var nowDate = $('#nowDate').val();
     		if(controlSdt == '' || controlSdt== null || controlEdt == '' || controlEdt == null){
     			dhtmlx.alert("통제일자 기간에만 신규, 수정, 삭제가 가능합니다.");
     			return false;
     		} else if((nowDate - controlSdt < 0) || (nowDate - controlEdt > 0)){
     			dhtmlx.alert("통제일자 기간에만 신규, 수정, 삭제가 가능합니다.");
     			return false;
     		} else{
     			fileClick();
     			return false;
     		}
       	});  
     	
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


function downFile(){
	var getRowsNum = gridMain.getRowsNum();
	if(getRowsNum == 0){
		dhtmlx.alert("저장될 내역이 없습니다. 다시 확인해주세요");
		return true;
	}else{
		fn_downFileAction();
	}
};

function fn_downFileAction(){
	var obj = {};
	obj.siteCd = $('#siteCd').val();
	obj.hadocontNo = $('#hadocontNo').val();
	obj.sqSn = $('#sqSn').val();
	obj.workYm = searchDate($('#workYm').val());
	gfn_callAjax(obj, "/erp/scm/work/partners/instPayment/billingS/gridMainSearch", fn_downFileActionCB);
};

function fn_downFileActionCB(data){
	var downFlag = true;
	if(data != ''){
		for(var i=0;i<data.length;i++){
			if(data[i].conKind != '10'){
				downFlag = false;
				break;
			}
		}
	}
	if(downFlag){
		var obj={};
		obj.hadocontNo = $('#hadocontNo').val();
		obj.hadocontDs = $('#hadocontDs').val();
		obj.siteCd = $('#siteCd').val();
		obj.siteDs = $('#siteNm').val();
		obj.sqSn = $('#sqSn').val();
		obj.workYm = searchDate($('#workYm').val());
		gfn_callAjaxComm(obj,"/erp/scm/work/partners/instPayment/billingExcelUpload/excelDown",fn_downFileCB,"");
	}else{
		dhtmlx.alert("진행중인 내역이 존재함으로 다운로드가 불가능합니다.");
		return true;
	}
};

function fn_downFileCB(data){
	var fileName = $('#siteCd').val()+"_"+$('#hadocontDs').val();
	var rfileId = fileName+".xls";
	var ofileId = fileName+".xls";
	var url = "/file/download?rFileId="+rfileId+"&oFileId="+ofileId+"&location=basedir";
	$('#downUrl').attr("href", url);
	downUrl.click();
};

function fileClick(){
	var siteCd = $('#siteCd').val();
	var hadocontNo = $('#hadocontNo').val();
	if(siteCd == '' || siteCd == null){
		dhtmlx.alert("현장코드를 선택해 주세요.");
		return true;
	}else if(hadocontNo == '' || hadocontNo == null){
		dhtmlx.alert("계약번호를 선택해 주세요.");
		return true;
	}else{
		fn_fileUploadAction();
	}
};

function fn_fileUploadAction(){
	var obj = {};
	obj.siteCd = $('#siteCd').val();
	obj.hadocontNo = $('#hadocontNo').val();
	obj.sqSn = $('#sqSn').val();
	obj.workYm = searchDate($('#workYm').val());
	gfn_callAjax(obj, "/erp/scm/work/partners/instPayment/billingS/gridMainSearch", fn_fileUploadActionCB);
};

function fn_fileUploadActionCB(data){
	var uploadFlag = true;
	if(data != ''){
		for(var i=0;i<data.length;i++){
			if(data[i].conKind != '10'){
				uploadFlag = false;
				break;
			}
		}
	}
	if(uploadFlag){
		$("input[name=attachFile]").click();
	}else{
		dhtmlx.alert("진행중인 내역이 존재함으로업로드가 불가능합니다.");
		return true;
	}
};

function fileSetting(val){
	var IMG_FORMAT = "\.(xlsx|xls)$";

	if((new RegExp(IMG_FORMAT, "i")).test(val)){
		excelUploadCheck();
	}else{
		alert("엑셀파일만 업로드 가능합니다.(.xlsx, .xls)");
		return false;
	}
}

function excelUploadCheck(){
	var obj = {};
	obj.siteCd = $('#siteCd').val();
	obj.hadocontNo = $('#hadocontNo').val();
	var jsonData = JSON.stringify(obj);
	$("#jsonData").val(jsonData);
	
	var formData = new FormData();
	formData.append("attachFile",$("input[name=attachFile]")[0].files[0]);
	formData.append("jsonData",$("#jsonData").val());
	
	$.ajax({
	    url: "/erp/scm/work/partners/instPayment/billingExcelUpload/excelUploadCheck.sc",
	    type: "POST",
	    data: formData,
	    dataType: "text",
	    beforeSend: function() {
	    	subLayout.cells("a").progressOn();
        },
	    processData: false,
	    contentType: false,
	    success: function(data) {
	    	if(data == "success"){
	    		excelUpload();
	    	}else if(data == 'siteCdFail'){
	    		alert("업로드파일과 현장코드가 일치하지 않습니다.");
				location.reload();
	    	}else if(data == 'hadoFail'){
	    		alert("업로드파일과 계약번호가 일치하지 않습니다.");
				location.reload();
	    	}else if(data == 'qtyFail'){
	    		alert("전체수량이 계약수량을 초과하였습니다. 파일을 다시확인해 주세요.");
				location.reload();
	    	}
	    },
	    complete: function() {
	    	subLayout.cells("a").progressOff();
        }
	});
	return false;
};

function excelUpload(){
	var formData = new FormData();
	formData.append("attachFile",$("input[name=attachFile]")[0].files[0]);
	$.ajax({
	    url: "/erp/scm/work/partners/instPayment/billingExcelUpload/excelUpload.sc",
	    type: "POST",
	    data: formData,
	    dataType: "text",
	    beforeSend: function() {
	    	subLayout.cells("a").progressOn();
        },
	    processData: false,
	    contentType: false,
	    success: function(data) {
	    	alert("저장되었습니다.");
	    	location.reload();
	    },
	    complete: function() {
	    	subLayout.cells("a").progressOff();
        }
	});
	return false;
};

function fn_search(){
	var obj={};
	obj.hadocontNo = $('#hadocontNo').val();
	obj.siteCd = $('#siteCd').val();
	obj.sqSn = $('#sqSn').val();
	obj.workYm = searchDate($('#workYm').val());
	fn_searchControlDate();
	gfn_callAjaxForGridR(gridMain,obj,"/erp/scm/work/partners/instPayment/billingExcelUpload/excelSearch",subLayout.cells("a"));
};

function fn_exit(){
	mainTabbar.tabs("9000000020").close();	
};

function fn_onClosePop(pName,data){
	 if(pName == "siteCd"){
		 $('#siteCd').val(data[0].siteCd);
		 $('#siteNm').val(data[0].siteNm);
		 $('#siteCd').focus();
		 $('#hadocontNo').val('');
		 $('#hadocontDs').val('');
		 
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
	gfn_callAjax(obj, "/erp/scm/work/partners/instPayment/billingS/controlDateSearch", fn_searchControlDateCB);
	gfn_callAjax({}, "/erp/scm/work/partners/instPayment/billingS/currentNowDate", fn_currentDateCB);
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
<form id="pform" name="pform" method="post">
    <input type="hidden" id="jsonData" name="jsonData" />
    <a href="#"  onclick="javascript:document.execCommand('SaveAs','1')" id="downUrl"></a>
</form>
<div id="bootContainer">
  <form id="excelForm" name="excelForm" method="post" enctype="multipart/form-data" action="/erp/scm/work/partners/instPayment/billingExcelUpload/excelUpload">
   <input type="file" name="attachFile" id="attachFile" accept=".xls*" value="" style="display: none;" onchange="fileSetting(this.value);">
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
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}" class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
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
			    <button name="downBtn" id="downBtn" value="" class="btn4">엑셀양식다운(기성)</button>
			</div>
		</div>	
		<div class="left">
			<div class="mlZero">
			    <button name="uploadBtn" id="uploadBtn" value="" class="btn3">내역서업로드</button>
			</div>
		</div>	
	</div>
  </form>		
</div>
<div id="container"></div>