<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain, combo01, combo02;
var fileCnt = 0;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;  
var fileDivision;
var jRowIdx = 0;
var fRowIdx = 0;
$(document).ready(function(){
	Ubi.setContainer(1,[1,2,3,5,6],"1C"); //근무자 등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"근태유무",      colId:"workYn",     width:"50",   align:"center", type:"ch"});
    gridMain.addHeader({name:"No",         colId:"no",         width:"50",   align:"center", type:"cntr"});
    gridMain.addHeader({name:"근무자구분",    colId:"perKind",    width:"80",   align:"center", type:"combo"});
    gridMain.addHeader({name:"근무자번호",    colId:"perNo",      width:"80",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"비밀번호",     colId:"password",   width:"60",  align:"left",   type:"ed"});
    gridMain.addHeader({name:"성명",       colId:"perNm",      width:"80",   align:"left",   type:"ed"});
    gridMain.addHeader({name:"공종대분류",   colId:"title",      width:"70", align:"left",    type:"ro"});
    gridMain.addHeader({name:"공종코드",    colId:"commgrpsDs", width:"80", align:"left",    type:"ro"});
    gridMain.addHeader({name:"세부공종",     colId:"descNm",     width:"90", align:"left",   type:"ro"});
    gridMain.addHeader({name:"주민등록번호",   colId:"regiNo",     width:"140", align:"left",   type:"ed"});
    gridMain.addHeader({name:"외국인등록번호", colId:"foreNo",     width:"140",  align:"left",   type:"ed"});
    gridMain.addHeader({name:"퇴직공제구분",   colId:"retireDiv",  width:"80",  align:"center", type:"combo"});
    gridMain.addHeader({name:"급여이체은행",   colId:"bank",       width:"80",  align:"left",   type:"ed"});
    gridMain.addHeader({name:"급여이체계좌",   colId:"account",    width:"120", align:"left",   type:"ed"});
    gridMain.addHeader({name:"입사일자",      colId:"enterDt",    width:"80",  align:"center", type:"dhxCalendarA"});
    gridMain.addHeader({name:"퇴사일자",      colId:"retireDt",   width:"80",  align:"center", type:"dhxCalendarA"});
    gridMain.addHeader({name:"핸드폰번호",     colId:"hpNo",       width:"100",  align:"left", type:"ed"});
    gridMain.addHeader({name:"사인이미지",     colId:"signImage",  width:"80",  align:"center", type:"ro"});
    gridMain.addHeader({name:"이미지업로드",   colId:"uploadFile",  width:"170", align:"left",   type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@enterDt","format_date");
    gridMain.dxObj.setUserData("","@retireDt","format_date");
    gridMain.dxObj.setUserData("","@regiNo","format_jumin");
    gridMain.dxObj.setUserData("","@foreNo","format_foreNo");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["custCd","siteCd","regBirth","fileSaveNm","fileNm","commgrpmCd","commgrpsCd","commgrpdCd","perKind2"]);
    gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);
    
    g_dxRules = { perKind : [r_notEmpty],  perNm : [r_notEmpty]};
    
    combo01 =gridMain.getColumnCombo(gridMain.getColIndexById("retireDiv"));
    combo02 =gridMain.getColumnCombo(gridMain.getColIndexById("perKind"));
    
    gfn_single_comboLoad(combo01,["Y","N"],["공제","비공제"],2);
    gfn_single_comboLoad(combo02,["10","20","30","40"],["직원","작업자","용역","직영"],4);
    
    fn_search();    
});
function doOnRowDblClicked(rId,cInd){
	var titleIdx = gridMain.getColIndexById("title");
	var commgrpsDsIdx = gridMain.getColIndexById("commgrpsDs");
	var descNmIdx = gridMain.getColIndexById("descNm");
	
    if(cInd == titleIdx){
    	gfn_load_pop('w1','dailyWork/commgrpmPOP',[$('#siteCd').val(),"공종대분류","commgrpm"]);
    };
    if(cInd == commgrpsDsIdx){
    	var title =  gridMain.setCells(rId,titleIdx).getValue();
		var commgrpm = gridMain.setCells(rId,gridMain.getColIndexById("commgrpmCd")).getValue();
		if(title == '' || title == null){
			return;
		}else{
			gfn_load_pop('w1','dailyWork/commgrpsPOP',[$('#siteCd').val(),commgrpm,"commgrps"]);
		}
    };
    if(cInd == descNmIdx){
    	gfn_load_pop('w1','dailyWork/commgrpdPOP',[$('#siteCd').val(),'',"commgrpd"]);
    };
};

function fn_search(){
	var obj={};
	obj.siteCd = $('#siteCd').val();
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
};

function fn_searchCB(data){
	if(data != ''){
	for(var i=0;i<gridMain.getRowsNum();i++){
		var password = gridMain.setCells2(i,gridMain.getColIndexById("password")).getValue();
		if(password != ''){
			gridMain.setCells2(i,gridMain.getColIndexById("password")).setValue("*****");
		};
		var regiNo = gridMain.setCells2(i,gridMain.getColIndexById("regiNo")).getValue();
		if(regiNo != ''){
			gridMain.setCells2(i,gridMain.getColIndexById("regiNo")).setValue(regiNo.substring(0,8) + "******");
			gridMain.setCells2(i,gridMain.getColIndexById("regiNo")).setDisabled('true');	//이미 입력된 주민등록번호가 있을 경우, disabled 처리
		}
		var foreNo = gridMain.setCells2(i,gridMain.getColIndexById("foreNo")).getValue();
		if(foreNo != ''){
			gridMain.setCells2(i,gridMain.getColIndexById("foreNo")).setValue(foreNo.substring(0,8) + "******");
			gridMain.setCells2(i,gridMain.getColIndexById("foreNo")).setDisabled('true');	//이미 입력된 외국인등록번호가 있을 경우, disabled 처리
		}
		var totalRowNum = gridMain.getRowsNum();
        fileCnt = totalRowNum;
        var imgIdx = gridMain.getColIndexById('signImage');
		var fileIdx = gridMain.getColIndexById('uploadFile');
		var fileNmIdx = gridMain.getColIndexById("fileNm");
		var fileSaveNmIdx = gridMain.getColIndexById("fileSaveNm");
		var fileName = gridMain.setCells2(i, fileNmIdx).getValue();
    	var realFileName = gridMain.setCells2(i, fileSaveNmIdx).getValue();
        var fileTag = "<input type='file' name='attachFile' id='attachFile"+(i)+"' value='' style='display:none;' accept='image/*' onchange='fileSetting("+(i)+", this.value)'>";
        var inputTag = "<input type='text' style='width:60%;' id='tempFile"+(i)+"' name='tempFile' value='"+fileName+"' disabled='disabled'>"
        var btnTag = "<button id='btnFile"+(i)+"' style='width:60px; height:29px;' onclick='fileClick("+i+")'>파일찾기</button>"; 
	    var imgTag = "<img src=''  height=30px; width=80px; id='target"+(i)+"' name='target'>";
		
	    if(realFileName != ''){
	    	gridMain.setCells2(i, imgIdx).setValue(imgTag);
	    }
    	
        gridMain.setCells2(i, fileIdx).setValue(inputTag+btnTag);
        
        $("#frmMain").append(fileTag);
    }  
	fn_setImage();
  };	
};

function fn_setImage(){
	var fileSaveNmIdx = gridMain.getColIndexById("fileSaveNm");
	for(var i=0;i<gridMain.getRowsNum();i++){
    	var realFileName = gridMain.setCells2(i, fileSaveNmIdx).getValue();
    	if(realFileName != ''){
    		//20180822 ryul 서버에 올라간 사진으로 보이도록 수정
//     		$("#target"+i).attr("src", "/erp/scm/work/partners/dailyWork/workerS/getSignImg?fileNm=" + realFileName);
    		$("#target"+i).attr("src", "http://scm.isdongseo.co.kr/erp/scm/work/partners/dailyWork/workerS/getSignImg?fileNm=" + realFileName);
    	}
    } 
	
};

function fn_new(){
	location.replace(location.pathname);
};

function fn_save(){
	var saveFlag = false;
	var juminCheck = false;
	var foreCheck = false;
	var uniqueJumin = false;
	var uniqueFore = false;
	 for(var i=0;i<gridMain.getRowsNum();i++){
		 var regiNo = gridMain.setCells2(i,gridMain.getColIndexById("regiNo")).getValue();
		 var foreNo = gridMain.setCells2(i,gridMain.getColIndexById("foreNo")).getValue();
	 	if(regiNo == "" && foreNo == ""){
	 		dhtmlx.alert("주민등록이나 외국인등록번호는 필수입니다.");
	 		saveFlag = false;
	 		break;
	 		return true;
	 	}else{
	 		saveFlag = true;
	 	}
	 }
	 if(saveFlag){
	  	juminCheck = gfn_check_jumin(gridMain,"regiNo");
	  	foreCheck = gfn_check_fore(gridMain,"foreNo");
	  	//uniqueJumin = gfn_check_uniqueJumin();
	  	//uniqueFore = gfn_check_uniqueFore();
	  	
	 }else{
		 return true;
	 }
	 if(!juminCheck){
		 dhtmlx.alert("주민번호가 올바르지않습니다.");
		 return true;
	 }else if(!foreCheck){
		 dhtmlx.alert("외국인번호가 올바르지않습니다.");
		 return true;
	 }else{
		 setBirth();
		 var jsonStr = gridMain.getJsonUpdated();
		   if (jsonStr == null || jsonStr.length <= 0) return; 
		   
		   $("#jsonDataDummy").val(jsonStr);
		   $("#jsonData").val($("#jsonDataDummy").val());
		   
		   var formData = new FormData();
			
			$("input[name=attachFile]").each(function(index){
				formData.append("attachFile",$("input[name=attachFile]")[index].files[0]);	
			});
				
			formData.append("jsonData",$("#jsonData").val());
			
			$.ajax({
		        url: "/erp/scm/work/partners/dailyWork/workerS/mainSave",
		        type: "POST",
		        data: formData,
		        dataType: "text",
		        processData: false,
		        contentType: false,
		        success: function(data) {
		            fn_saveCB(data);
		        }
		    }); 
	 }
};

function gfn_check_uniqueJumin(){
	var flag = true;
	for(var i=0;i<gridMain.getRowsNum();i++){
		var cudKey = gridMain.setCells2(i,gridMain.getColIndexById("cudKey")).getValue();
		var juminVal = gridMain.setCells2(i,gridMain.getColIndexById("regiNo")).getValue();
		if(juminVal != '' && (cudKey == 'INSERT' || cudKey == 'UPDATE')){
			for(var j=0;j<gridMain.getRowsNum();j++){
				var juminVal2 = gridMain.setCells2(j,gridMain.getColIndexById("regiNo")).getValue();
				if(i != j && (juminVal == juminVal2)){
					flag = false;
					jRowIdx = i;
					break;
				}
			};
		}
	};
	return flag;
}

function gfn_check_uniqueFore(){
	var flag = true;
	for(var i=0;i<gridMain.getRowsNum();i++){
		var cudKey = gridMain.setCells2(i,gridMain.getColIndexById("cudKey")).getValue();
		var foreVal = gridMain.setCells2(i,gridMain.getColIndexById("foreNo")).getValue();
		if(foreVal != '' && (cudKey == 'INSERT' || cudKey == 'UPDATE')){
			for(var j=0;j<gridMain.getRowsNum();j++){
				var foreVal2 = gridMain.setCells2(j,gridMain.getColIndexById("foreNo")).getValue();
				if(i != j && (foreVal == foreVal2)){
					flag = false;
					fRowIdx = i;
					break;
				}
			};
		}
	};
	return flag;
};

function fn_saveCB(data) {
	MsgManager.alertMsg("INF001")
    $("input[name=attachFile]").remove();
    fn_new();
};

function setBirth(){
	for(var i=0;i<gridMain.getRowsNum();i++){
		var birth = '';
		var jumin = gridMain.setCells2(i,gridMain.getColIndexById("regiNo")).getValue();
		var fore =  gridMain.setCells2(i,gridMain.getColIndexById("foreNo")).getValue();
		if(jumin == ''){
			birth = fore.substring(0,6);
		}else{
			birth = jumin.substring(0,6);
		}
		gridMain.setCells2(i,gridMain.getColIndexById("regBirth")).setValue(birth);
	}
}

function fn_add(){
	var siteCd = $('#siteCd').val();
	if(siteCd == '' || siteCd == null){
		dhtmlx.alert("현장코드를 입력하세요.");
		return;
	}else{
		var totalRowNum = gridMain.getRowsNum();
		var totalColNum = gridMain.getColumnCount();
        var data = new Array(totalColNum);      
	    var enterDtColIdx  = gridMain.getColIndexById('enterDt');     
	    var siteCdColIdx   = gridMain.getColIndexById('siteCd');
	    var fileIdx = gridMain.getColIndexById('uploadFile');
	    var perKindIdx = gridMain.getColIndexById('perKind');
	    var workYnIdx = gridMain.getColIndexById('workYn');
	    
		data[enterDtColIdx]  = dateformat(new Date());
		data[siteCdColIdx]   = $('#siteCd').val();
		data[perKindIdx]   = '10';
		data[workYnIdx]   = '1';
		
		var year = new Date().getFullYear();

		fileCnt = totalRowNum;
		var fileTag = "<input type='file' name='attachFile' id='attachFile"+fileCnt+"' value='' style='display:none;' accept='image/*' onchange='fileSetting("+fileCnt+", this.value)'>";
	    var inputTag = "<input type='text' style='width:60%;' id='tempFile"+fileCnt+"' name='tempFile' value='' disabled='disabled'/>"
	    var btnTag = "<button id='btnFile"+fileCnt+"' style='width:60px; height:29px;' onclick='fileClick("+fileCnt+")'>파일찾기</button>";
	    data[fileIdx] = inputTag+btnTag;
	    $("#frmMain").append(fileTag);
		gridMain.addRow(data);
		fileDivision = "INSERT";
	}		
};

function fn_delete(){
	var rodid = gridMain.getSelectedRowId();
	var obj = {};
	obj.siteCd = $('#siteCd').val();
	obj.perNo = gridMain.setCells(rodid,gridMain.getColIndexById("perNo")).getValue();
	if(obj.perNo == ''){
		gridMain.cs_deleteRow(rodid);
	}else{
		gfn_callAjax(obj,"perNoDelCheck", delCheckCB);	
	}
	
};

function delCheckCB(data){
	if(data[0].cnt > 0 || data[1].cnt > 0 || data[2].cnt > 0 || data[3].cnt > 0){
		dhtmlx.alert("등록된 내역은 삭제가 불가능합니다.");
		return true;
	}else{
		var rodid = gridMain.getSelectedRowId();
		gridMain.cs_deleteRow(rodid);
		fileCnt = fileCnt - 1;
	}
};

function fileClick(cnt){
	var perNo = gridMain.setCells2(cnt,gridMain.getColIndexById("perNo")).getValue();
	if(perNo == ''){
		dhtmlx.alert("저장후 이미지를 업로드 하세요");
		return true;
	}else{
		$("input[name=attachFile]").eq(cnt).click();
	}
};

function fileSetting(cnt, val){
		obj = gfn_getImageFormat(val);
		cudKey = gridMain.setCells2(cnt,gridMain.getColIndexById("cudKey")).getValue();
		if(cudKey == ''){
			gridMain.setCells2(cnt,gridMain.getColIndexById("cudKey")).setValue("UPDATE");
		}
	if( obj.flag ){
		$("input[name=tempFile]").eq(cnt).val(val);
	}else{
		$("input[name=attachFile]").eq(cnt).val('');
		$("input[name=tempFile]").eq(cnt).val('');
		MsgManager.alertMsg("WRN016", obj.format)
		return false;
	}
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
		 $('#siteCd').focus();
	 }
	 if(pName == "commgrpm"){
		 var rowIdx = gridMain.getSelectedRowIndex();
		 var title = data[0].title;
		 var commgrpmCd = data[0].commgrpmCd;
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("title")).setValue(title);
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpmCd")).setValue(commgrpmCd);
		 var cudKey = gridMain.setCells2(rowIdx,gridMain.getColIndexById("cudKey")).getValue();
		 if(cudKey == ''){
			 gridMain.setCells2(rowIdx,gridMain.getColIndexById("cudKey")).setValue("UPDATE");
		 }
	 };
	 if(pName == "commgrps"){
		 var rowIdx = gridMain.getSelectedRowIndex();
		 var commgrpsDs = data[0].commgrpsDs;
		 var commgrpsCd = data[0].commgrpsCd;
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpsDs")).setValue(commgrpsDs);
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpsCd")).setValue(commgrpsCd);
	 };
	 if(pName == "commgrpd"){
		 var rowIdx = gridMain.getSelectedRowIndex();
		 var descNm = data[0].descNm;
		 var commgrpdCd = data[0].descCd;
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("descNm")).setValue(descNm);
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("commgrpdCd")).setValue(commgrpdCd);
		 var cudKey = gridMain.setCells2(rowIdx,gridMain.getColIndexById("cudKey")).getValue();
		 if(cudKey == ''){
			 gridMain.setCells2(rowIdx,gridMain.getColIndexById("cudKey")).setValue("UPDATE");
		 }
	 };
};
</script>
<form id="pform" name="pform" method="post">
    <input type="hidden" id="jsonDataDummy" name="jsonDataDummy">
    <input type="hidden" id="jsonData" name="jsonData" />
</form>
<div id="bootContainer">
  <form  id="frmMain" name="frmMain" enctype="multipart/form-data">
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