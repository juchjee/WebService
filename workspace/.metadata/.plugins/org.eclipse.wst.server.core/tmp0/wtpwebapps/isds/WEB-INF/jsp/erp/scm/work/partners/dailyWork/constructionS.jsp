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
var toolbar01,toolbar02, toolbar03;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId; 
var useFlag = false;
var printFlag = false;
var appvFlag = false;
var dailyAppvFlag = false;
var dataFlag = false;
$(document).ready(function(){
	Ubi.setContainer(4,[1,2,3,4],"1C"); //공사일보 등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
    layout.cells("b").setHeight(330);
    
    gridTabbar = subLayout.cells("a").attachTabbar({
        tabs: [{id: "a1",text: "출력인원등록",active: true}, 
               {id: "a2",text: "사용장비등록"},
               {id: "a3",text: "자재수불현황"}]});
	
    gridMain = new dxGrid(gridTabbar.tabs("a1"),false);
    gridMain.addHeader({name:"No",      colId:"no",         width:"50",  align:"center", type:"cntr"});
    gridMain.addHeader({name:"공종대분류", colId:"title",      width:"90",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"공종코드",  colId:"commgrpsDs", width:"90",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"세부공정",  colId:"descNm",     width:"90",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"전일누계",  colId:"preQty",     width:"60",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"작업인원",  colId:"perNum",     width:"60",  align:"right",  type:"edn"});
    gridMain.addHeader({name:"작업내용",  colId:"workCon",    width:"300", align:"left",   type:"ro"});
    gridMain.addHeader({name:"출력여부",  colId:"printYn",    width:"60", align:"center",   type:"ch"});
    gridMain.setUserData("","pk","");
    gridMain.attachFooter("&nbsp;,합계,,,#stat_total,#stat_total,,");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["custCd","siteCd","commgrpmCd","workDt","commgrpsCd","cnt","workSeq","commgrpdCd"]);
    
    
    gridSub = new dxGrid(gridTabbar.tabs("a2"),false);
    gridSub.addHeader({name:"No",      colId:"no",        width:"50",   align:"center", type:"cntr"});
    gridSub.addHeader({name:"장비코드",  colId:"itemCd",     width:"100",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"장비명",    colId:"itemNm",    width:"150",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"규격",     colId:"itemSpec",   width:"150", align:"left",   type:"ro"});
    gridSub.addHeader({name:"단위",     colId:"itemUnit",   width:"90",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"전일수량",   colId:"preQty",     width:"60",  align:"right",  type:"ron"});
    gridSub.addHeader({name:"수량",     colId:"qty",        width:"60",  align:"right",  type:"edn"});
    gridSub.addHeader({name:"작업내용",  colId:"workConScm", width:"300", align:"left",   type:"ed"});
    gridSub.addHeader({name:"출력여부",  colId:"printYn",   width:"60", align:"center",   type:"ch"});
    gridSub.setUserData("","pk","");
    gridSub.attachFooter("&nbsp;,합계,,,,#stat_total,#stat_total,,,");
    gridSub.dxObj.enableHeaderMenu("false");
    gridSub.init();
    gridSub.cs_setColumnHidden(["custCd","siteCd","workSeq","workDt","equipBc"]);
    gridSub.attachEvent("onRowDblClicked",doOnSubRowDblClicked);
    
    var tbrlayout02 = gridTabbar.tabs("a2");
	toolbar02 = subToolbar(toolbar02,tbrlayout02,[5,6]);
	toolbar02.attachEvent("onClick",gridSubOnClick);
	
	gridSub01 = new dxGrid(gridTabbar.tabs("a3"),false);
    gridSub01.addHeader({name:"No",    colId:"no",  width:"50",        align:"center", type:"cntr"});
    gridSub01.addHeader({name:"품목코드",   colId:"itemCd",  width:"150",  align:"left",   type:"ro"});
    gridSub01.addHeader({name:"품명",   colId:"itemName",  width:"150",  align:"left",   type:"ed"});
    gridSub01.addHeader({name:"규격",   colId:"itemSpec",   width:"150", align:"left",   type:"ed"});
    gridSub01.addHeader({name:"입고량",  colId:"inQty",  width:"80",    align:"right",  type:"edn"});
    gridSub01.addHeader({name:"시공량",  colId:"buildQty", width:"80", align:"right",   type:"ed"});
    gridSub01.addHeader({name:"반출량",  colId:"outQty", width:"80",    align:"right",   type:"ed"});
    gridSub01.setUserData("","pk","");
    gridSub01.attachFooter("&nbsp;,합계,,,#stat_total,#stat_total,#stat_total");
    gridSub01.dxObj.enableHeaderMenu("false");
    gridSub01.init();
    gridSub01.cs_setColumnHidden(["custCd","siteCd","workSeq","workDt"]);
    gridSub01.attachEvent("onRowDblClicked",doOnSub01RowDblClicked);
    
    var tbrlayout03 = gridTabbar.tabs("a3");
	toolbar03 = subToolbar(toolbar03,tbrlayout03,[5,6]);
	toolbar03.attachEvent("onClick",gridSub01OnClick);
	
	 g_dxRules = {inQty : [r_notEmpty]};
    
    gfn_weather_comboLoad("weatherBc");
    
    $('#password').keydown(function(e){
        if(e.keyCode == 13){
        	return false;
        }
    });
    
    $("#searchBtn").click(function(){
    	var siteCd = $('#siteCd').val();
    	if(siteCd == '' || siteCd == null){
    		dhtmlx.alert("현장코드를 선택해주세요.");
    		return true;
    	}else{
    		gfn_load_pop('w1','dailyWork/selConstructionPOP',[$('#siteCd').val(),"공사검색","selConstruction"]);
    	}
		return false;
	});
    
    $("#consEmptyBtn").click(function(){
    	var url = "/erp/scm/work/partners/dailyWork/constructionS/report/consEmptySearch.do";
		window.open(url,'rpt',''); 
		return false;
	});
    
    
    $( "#perNo" ).dblclick(function() {
    	var siteCd = $('#siteNm').val();
    	if(siteCd == '' || siteCd == null){
    		dhtmlx.alert("현장명을 선택해 주세요.");
    		return true;
    	}else{
    		if(!dataFlag){
    			gfn_load_pop('w1','dailyWork/consAppvPerNoPOP',[$('#siteCd').val(),'',"appvPerNo"]);
    		}
    	}
     });
    
    $("#consBtn").click(function(){
    	if(printFlag){
    		fn_report(1);	
    		return false;
    	}else{
    	   return false;	
    	}
	});
    
    $("#perNoBtn").click(function(){
    	if(printFlag){
    		fn_report(2);	
    		return false;
    	}else{
    	   return false;	
    	}
	});
    
    $("#dailyAppvBtn").click(function(){
    	if(useFlag){
    		fn_dailyAppvSearch();
    		return false;
    	}else{
    		return false;
    	}
	});
    
    $( "#confirmBtn" ).click(function() {
    	var btnVal = $('#confirmBtn').val();
    	if(btnVal == '확인'){
    		fn_confirmRegEmp();
    	}else{
    		return true;
    	}
     });
    
    $( "#passBtn" ).click(function() {
    	siteCd = $('#siteNm').val();
    	if(siteCd == '' || siteCd == null){
    		dhtmlx.alert("현장명을 선택해 주세요.");
    		return true;
    	}else{
    		gfn_load_pop('w1','dailyWork/changePassPOP',[$('#siteCd').val(),'',"changePass"]);
    	}
     });
    
    $('#workDt').change(function(){
    	formAppvReset();
    	$('#siteCd').val('');
    	$('#siteNm').val('');
    });
    
    $('#workDt').change(function(){
    	formAppvReset();
    	gridMain.clearAll();
    	gridMain.parse("","json");
    	gridSub.clearAll();
    	gridSub.parse("","json");
    	gridSub01.clearAll();
    	gridSub01.parse("","json");
    	useFlag = false;
    	$('#siteCd').val('');
    	$('#siteNm').val('');
    	$('#password').val('');
    	$('#confirmBtn').val('확인');
    	$('#'+'appvKind'+'option:eq(0)').attr("selected","selected");
    	fn_dateSetting();
    });
    
    $('#calpicker').click(function(){
    	formAppvReset();
    	gridMain.clearAll();
    	gridMain.parse("","json");
    	gridSub.clearAll();
    	gridSub.parse("","json");
    	gridSub01.clearAll();
    	gridSub01.parse("","json");
    	useFlag = false;
    	$('#siteCd').val('');
    	$('#siteNm').val('');
    	$('#password').val('');
    	$('#confirmBtn').val('확인');
    	$('#'+'appvKind'+'option:eq(0)').attr("selected","selected");
    	$('#workDt').focus();
    	fn_dateSetting();
    });

    gfn_sett_comboLoad("reviewSett","1");
    gfn_sett_comboLoad("review2Sett","1");
    gfn_sett_comboLoad("confirmSett","1");
    
    fn_searchWorkNm();
    
    fn_initAppvCheck();

    fn_search();
});
function fn_dateSetting(){
	$('#siteCd').val('${siteCd}');
	$('#siteNm').val('${siteNm}');
	fn_appvSearch($('#siteCd').val()); 
};

function fn_initAppvCheck(){
	var siteCd = $('#siteCd').val();
	if(siteCd != ''){
		fn_appvSearch(siteCd);	
	}
};

function fn_searchWorkNm(){
	var obj = {};
	obj.siteCd = $('#siteCd').val();
	obj.workDt = searchDate($('#workDt').val());
	gfn_callAjax(obj, "selConsWorkNm", fn_searchWorkNmCB);
};

function fn_searchWorkNmCB(data){
	if(data != ''){
	 $('#workNm').val(data[0].workNm);	
	}
}

function gfn_sett_comboLoad(eleId,gubn) {
	$("#"+eleId+" option").remove();
	if(gubn == '1'){
		$('#'+eleId).append("<option value='N'>미결</option>");
		$('#'+eleId).append("<option value='P'>전결</option>");
    	$('#'+eleId+'option:eq(0)').attr("selected","selected");
    	$('#'+eleId).trigger('change');
	}else{
		$('#'+eleId).append("<option value='N'>미결</option>");
		$('#'+eleId).append("<option value='P'>전결</option>");
		$('#'+eleId).append("<option value='Y'>결재</option>");
    	$('#'+eleId).trigger('change');
	}
};

function fn_confirmRegEmp(){
	var obj = {};
	 obj.siteCd = $('#siteCd').val();
	 obj.perNo = $('#perNo').val();
	 obj.password = $('#password').val();
	gfn_callAjax(obj, "/erp/scm/work/partners/dailyWork/dailyAttendS/confirmRegEmp", fn_confirmRegEmpCB);
};

function fn_confirmRegEmpCB(data){
	if(data[0].cnt>0){
		useFlag = true;
		$('#confirmBtn').val("확인완료");
		fn_search();
	}else{
		dhtmlx.alert("비밀번호가 일치 하지 않습니다.");
		return true;
	}
};

function fn_dailyAppvSearch(){
	if(dailyAppvFlag){
		var obj = {};
		obj.siteCd = $('#siteCd').val();
		obj.workDt = searchDate($('#workDt').val());
		gfn_callAjax(obj,"appvSearchChk", fn_dailyAppvSearchChkCB);
	}else{
		dhtmlx.alert("등록된 데이터가 존재합니다.");
		return true;
	}
};

function fn_dailyAppvSearchChkCB(data){
	if(data[0].cnt > 0){
		var obj = {};
		obj.siteCd = $('#siteCd').val();
		obj.workDt = searchDate($('#workDt').val());
		gfn_callAjaxForGrid(gridMain, obj,"appvSearch",gridTabbar.tabs("a1"), fn_dailyAppvSearchCB);
		gfn_callAjaxForGrid(gridSub, obj,"gridSubSearch",gridTabbar.tabs("a2"), fn_dailyAppvSubSearchCB);
	}else{
		dhtmlx.alert("일일출역표에 결제된 내역이 없습니다.");
		return true;
	}
}

function fn_dailyAppvSearchCB(data){
	if(data != ''){
		$('#appvNextYn').val('1');
		for(var i=0;i<gridMain.getRowsNum();i++){
			gridMain.setCells2(i,gridMain.getColIndexById("cudKey")).setValue('INSERT');
			gridMain.setCells2(i,gridMain.getColIndexById("cnt")).setValue('1');
			gridMain.setCells2(i,gridMain.getColIndexById("printYn")).setValue('1');
			gridMain.setCells2(i,gridMain.getColIndexById("workDt")).setValue(searchDate($('#workDt').val()));
			var workConIdx = gridMain.getColIndexById("workCon");
			var workConVal = gridMain.setCells2(i,workConIdx).getValue();
			var textAreaTag = "<textarea  style='width:100%; height:50px; margin-top :3px;' id='workCon"+(i)+"' name='workCon'>"+workConVal+"</textarea>";
			gridMain.setCells2(i, workConIdx).setValue(textAreaTag);
		}
	}else{
		dhtmlx.alert("조회된 데이터가 없습니다.");
		$('#appvNextYn').val('0');
		return true;
	}
};

function fn_dailyAppvSubSearchCB(data){
	if(data == ''){
		var obj = {};
		obj.siteCd = $('#siteCd').val();
		obj.workDt = searchDate($('#workDt').val());
		gfn_callAjaxForGrid(gridSub, obj,"itemAppvSearch",gridTabbar.tabs("a2"),fn_subAppvSearchCB);
	}	
};

function fn_subAppvSearchCB(data){
	if(data != ''){
		for(var i=0;i<gridSub.getRowsNum();i++){
			gridSub.setCells2(i,gridSub.getColIndexById("cudKey")).setValue('INSERT');
			gridSub.setCells2(i,gridSub.getColIndexById("printYn")).setValue('1');
			gridSub.setCells2(i,gridSub.getColIndexById("workDt")).setValue(searchDate($('#workDt').val()));
		}
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

function gridSub01OnClick(id){
	if(id == "btn5"){
		fn_grid_add('sub01'); 
	}
	if(id == "btn6"){
		fn_grid_delete('sub01'); 
	}	
};


function doOnSubRowDblClicked(rId,cInd){
	if(cInd == 2){
		gfn_load_pop('w1','dailyWork/equiCodePOP',['','',"equiCode"]);
	}
};

function doOnSub01RowDblClicked(rId,cInd){
   if(cInd == 1){
	   gfn_load_pop('w1','dailyWork/itemCodePOP',['','',"itemCode"]);
	}
};

function fn_search(){
	if(useFlag){
		var obj={};
		obj.siteCd = $('#siteCd').val();
		obj.workDt = searchDate($('#workDt').val());
		gfn_callAjaxForForm("frmMain", obj, "formSearch", fn_searchCB);
	}else{
		return true;
	}
};

function fn_searchCB(data){
  if(data != '')	{
	  gfn_sett_comboLoad("reviewSett","2");
	  gfn_sett_comboLoad("review2Sett","2");
	  gfn_sett_comboLoad("confirmSett","2");
	 $('#cudKey').val("UPDATE");
	  printFlag = true;
	  if(data[0].nextYn == '1'){
		 $('#regSett').attr("disabled",true);	
	   }
	   if(data[0].regSett == 'N'){
		     gfn_sett_comboLoad("reviewSett","1");
		     gfn_sett_comboLoad("review2Sett","1");
			 gfn_sett_comboLoad("confirmSett","1");
		   $('#reviewSett').attr("disabled",false);
		   $('#review2Sett').attr("disabled",false);
		   $('#confirmSett').attr("disabled",false);
	   }else{
		  $('#reviewSett').attr("disabled",true);
		  $('#review2Sett').attr("disabled",true);
		  $('#confirmSett').attr("disabled",true);  
	   }
	 if(data[0].regSett == 'Y' || data[0].reviewSett == 'Y' || data[0].review2Sett == 'Y' || data[0].confirmSett == 'Y'){
			appvFlag = false;
		}else{
			appvFlag = true;
	   }
	 var perNo = $('#perNo').val();
		if(perNo != data[0].regEmp){
			$('#regSett').attr("disabled",true);	
			useFlag = false;
		}else{
			useFlag = true;
		}
	 var obj={};
		obj.siteCd = data[0].siteCd;
		obj.workDt = data[0].workDt;
	 gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",gridTabbar.tabs("a1"),fn_mainSearchCB);
	 gfn_callAjaxForGrid(gridSub,obj,"gridSubSearch",gridTabbar.tabs("a2"));
	 gfn_callAjaxForGrid(gridSub01,obj,"gridSub01Search",gridTabbar.tabs("a3"),fn_sub01SearchCB);
	   $('#siteCd').attr("disabled",true);
		$('#workDt').attr("disabled",true);
		$('#calpicker').attr("disabled",true);
		fn_emptyAppvPer();
  }else{
	    gfn_sett_comboLoad("reviewSett","1");
	    gfn_sett_comboLoad("review2Sett","1");
		 gfn_sett_comboLoad("confirmSett","1");
	  $('#cudKey').val("INSERT");
		printFlag = false;  
		appvFlag = true;
		dailyAppvFlag = true;
		 var perNo = $('#perNo').val();
		 var perNm = $('#perNm').val();
		 $('#regEmp').val(perNo);
		 $('#regEmpName').val(perNm);
		 $('#siteCd').attr("disabled",false);
		 $('#workDt').attr("disabled",false);
		 $('#calpicker').attr("disabled",false);
		 fn_emptyAppvPer();
  }
};

function fn_mainSearchCB(data){
	if(data != ''){
		dailyAppvFlag = false;
		for(var i=0;i<gridMain.getRowsNum();i++){
			gridMain.setCells2(i,gridMain.getColIndexById("cnt")).setValue('1');
			var workConIdx = gridMain.getColIndexById("workCon");
			var workConVal = gridMain.setCells2(i,workConIdx).getValue();
			var textAreaTag = "<textarea  style='width:100%; height:55px; margin-top :3px;' id='workCon"+(i)+"' name='workCon'>"+workConVal+"</textarea>";
			gridMain.setCells2(i, workConIdx).setValue(textAreaTag);
		}
	}else{
		dailyAppvFlag = true;
	}
}

function fn_sub01SearchCB(data){
	if(data != ''){
		for(var i=0;i<gridSub01.getRowsNum();i++){
			var itemCd = gridSub01.setCells2(i,gridSub01.getColIndexById("itemCd")).getValue();
			if(itemCd != ''){
				gridSub01.setCellExcellType(gridSub01.getRowId(i),gridSub01.getColIndexById("itemCd"),"ro");
				gridSub01.setCellExcellType(gridSub01.getRowId(i),gridSub01.getColIndexById("itemName"),"ro");
				gridSub01.setCellExcellType(gridSub01.getRowId(i),gridSub01.getColIndexById("itemSpec"),"ro");
			}
		}
	}else{
		return true;
	}
};

function fn_new(){
	location.replace(location.pathname);
};

function fn_remove(){
	if(!useFlag){
		dhtmlx.alert("사용자확인 선택후 진행하세요.");
		return true;
	}else if(!appvFlag){
		dhtmlx.alert("결제된 내역은 수정하실 수 없습니다.");
		return true;
	}else{
		var obj={};
		obj.siteCd = $('#siteCd').val();
		obj.workDt = searchDate($('#workDt').val());
		gfn_callAjax(obj,"formSearch", fn_removeChk);	
	}
};

function fn_removeChk(data){
    if(data == ''){
    	return;
    }else{
    	if(MsgManager.confirmMsg("WRN015")){
    		fn_all_removeCB();
    	}else{
    		return true;
    	}
    }
};

function fn_all_removeCB(){
	var obj={};
	obj.siteCd = $('#siteCd').val();
	obj.workDt = searchDate($('#workDt').val());
	gfn_callAjaxComm(obj,"delSave",fn_new);
}

function fn_subGridItemCd(){
  var flag = true;
  var getRowsNum = gridSub.getRowsNum();
  if(getRowsNum == 0){
	  flag = true;
  }else{
	  for(var i=0;i<getRowsNum;i++){
		  var itemCd = gridSub.setCells2(i,gridSub.getColIndexById("itemCd")).getValue();
		  if(itemCd == '' || itemCd == null){
			  flag = false;
			  break;
		  }
	  }
  }
  return flag;
};

function fn_save(){
	var siteCd = $('#siteCd').val();
	var itemCdCheck = fn_subGridItemCd();
	if(siteCd == '' || siteCd == null){
		dhtmlx.alert("현장코드를 입력하세요.");
		return true;
	}else if(!itemCdCheck){
		dhtmlx.alert("사용장비 등록에 장비코드는 필수항목입니다.");
		return true;
	}else if(!useFlag){
		dhtmlx.alert("사용자확인 선택후 진행하세요.");
		return true;
	}else if(!appvFlag){
		dhtmlx.alert("결제된 내역은 수정하실 수 없습니다.");
		return true;
	}else{
		var cudKey = $('#cudKey').val();
		var jsonData = formToJson(cudKey);
		
		$("#formJsonData").val(jsonData);
		var formData = new FormData();
		formData.append("formJsonData",$("#formJsonData").val());
		
		  $.ajax({
	        url: "/erp/scm/work/partners/dailyWork/constructionS/mainSave",
	        type: "POST",
	        data: formData,
	        dataType: "text",
	        processData: false,
	        contentType: false,
	        success: function(data) {
	        	fn_subSave();
	        }
	    });
	}
};

function formToJson(cudKey){
	var jsonData = {};
    jsonData = {
   	  cudKey : cudKey, 
   	  siteCd : $('#siteCd').val(),
   	  workDt : $("#workDt").val().split("/").join(""),
      weatherBc : $('#weatherBc').val(),
      conSec : $('#conSec').val(),
      appvNextYn : $('#appvNextYn').val(),
      tempMin : $('#tempMin').val(),
      tempMax : $('#tempMax').val(),
      workNm : $('#workNm').val(),
      workDesc : $('#workDesc').val(),
      rmk : $('#rmk').val(),
      regEmp : $('#regEmp').val(),
      regSett : $("select[name=regSett]").val(),
      reviewEmp : $('#reviewEmp').val(),
      reviewSett : $("select[name=reviewSett]").val(),
      review2Emp : $('#review2Emp').val(),
      review2Sett : $("select[name=review2Sett]").val(),
      confirmEmp : $('#confirmEmp').val(),
   	  confirmSett : $("select[name=confirmSett]").val()
    }
   return JSON.stringify(jsonData);		
};

function fn_subSave(data){
	$('#workDt').keyup();
	fn_saveWorkCon();
	saveFlag = true;
	var jsonStr = gridMain.getJsonUpdated();
	var jsonStr2 = gridSub.getJsonUpdated();
	var jsonStr3 = gridSub01.getJsonUpdated();
	   if(jsonStr == null || jsonStr.length <= 0){
		   saveFlag = false;
	   }else if(jsonStr2 == null || jsonStr2.length <= 0){
		   saveFlag = false;
	   }
	   else if(jsonStr3 == null || jsonStr3.length <= 0){
		   saveFlag = false;
	   }else{
		   saveFlag = true;
	   }
	if(saveFlag){
	    $("#jsonData").val(jsonStr);
	    $("#jsonData2").val(jsonStr2);
	    $("#jsonData3").val(jsonStr3);
	    var params = $("#pForm").serialize();  
	    gfn_callAjaxComm(params,"subSave",fn_search);	
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
	}else if(!useFlag){
		dhtmlx.alert("사용자확인 선택후 진행하세요.");
		return true;
	}else if(!appvFlag){
		dhtmlx.alert("결제된 내역은 수정하실 수 없습니다.");
		return true;
	}else{
	    if(flag == 'sub'){
		  var totalColNum = gridSub.getColumnCount();
		  var data = new Array(totalColNum);
		  var workDtColIdx  = gridSub.getColIndexById('workDt');     
	      var siteCdColIdx   = gridSub.getColIndexById('siteCd');
	        data[workDtColIdx]  = searchDate($('#workDt').val());
			data[siteCdColIdx]   = $('#siteCd').val();
		  gridSub.addRow(data);
		  
		}else if(flag == 'sub01'){
			  var totalColNum = gridSub01.getColumnCount();
			  var data = new Array(totalColNum);
			  var workDtColIdx  = gridSub01.getColIndexById('workDt');     
		      var siteCdColIdx   = gridSub01.getColIndexById('siteCd');
		      var printYnColIdx   = gridSub01.getColIndexById('printYn');
		        data[workDtColIdx]  = searchDate($('#workDt').val());
				data[siteCdColIdx]   = $('#siteCd').val();
				data[printYnColIdx]   = '1';
			  gridSub01.addRow(data);
		}
	}	
};

function fn_grid_delete(flag){
	if(!useFlag){
		dhtmlx.alert("사용자확인 선택후 진행하세요.");
		return true;
	}else if(!appvFlag){
		dhtmlx.alert("결제된 내역은 수정하실 수 없습니다.");
		return true;
	}else{
		if(flag == 'sub'){
			var rodid = gridSub.getSelectedRowId();
			gridSub.cs_deleteRow(rodid); 
		}else if(flag == 'sub01'){
			var rodid = gridSub01.getSelectedRowId();
			gridSub01.cs_deleteRow(rodid); 
		}	
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
	if(pName == 'changePass'){
		dhxWins.window("w1").close();
		gfn_load_pop('w1','comm/perNmPOP',[$('#siteCd').val(),'',"reOpenEmp"]);
	 }
	 if( pName == 'reOpenEmp' ){
		 dhxWins.window("w1").close();
		 var empArr = [data[0].perNo, data[0].perNm];
		 gfn_load_pop('w1','dailyWork/changePassPOP',[$('#siteCd').val(),empArr,"reChangePass"]);
	 }
	 if(pName == 'reChangePass'){
		 $('#password').focus(); 
	 }
	 if(pName == "siteCd"){
		 if(!useFlag){
			 $('#siteCd').val(data[0].siteCd);
			 $('#siteNm').val(data[0].siteNm);
			 fn_appvSearch(data[0].siteCd); 
		 }
		 $("#password").focus();
	 };
	 if(pName == "selConstruction"){
		 $('#workDt').val(data[0].workDt);
		 $('#siteCd').val(data[0].siteCd);
		 $('#siteNm').val(data[0].siteDs);
		 fn_appvSearch(data[0].siteCd);
		 $("#password").focus();
	 };
	 if(pName == "appvPerNo"){
		 $('#perNo').val(data[0].perNo);
		 $('#perNm').val(data[0].perNm);
		 $('#password').focus(); 
	 }
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
			 gridSub.setCells2(rowIdx,gridSub.getColIndexById("itemNm")).setValue(data[0].kitemDs);
			 gridSub.setCells2(rowIdx,gridSub.getColIndexById("itemSpec")).setValue(data[0].itemSz);
			 gridSub.setCells2(rowIdx,gridSub.getColIndexById("itemUnit")).setValue(data[0].itemUt);
		 }else{
			dhtmlx.alert("중복된 사용장비가 존재합니다. 확인해주세요.");
			return true;
		 }
	 }
	 if(pName == "itemCode"){
		 var rowIdx = gridSub01.getSelectedRowIndex();
		 gridSub01.setCells2(rowIdx,gridSub01.getColIndexById("itemCd")).setValue(data[0].itemCd);
		 gridSub01.setCells2(rowIdx,gridSub01.getColIndexById("itemName")).setValue(data[0].kitemDs);
		 gridSub01.setCells2(rowIdx,gridSub01.getColIndexById("itemSpec")).setValue(data[0].itemSz);
		 gridSub01.setCellExcellType(gridSub01.getRowId(rowIdx),gridSub01.getColIndexById("itemCd"),"ro");
		 gridSub01.setCellExcellType(gridSub01.getRowId(rowIdx),gridSub01.getColIndexById("itemName"),"ro");
		 gridSub01.setCellExcellType(gridSub01.getRowId(rowIdx),gridSub01.getColIndexById("itemSpec"),"ro");
	 }
};

function fn_appvSearch(siteCd){
	formAppvReset();
	var obj={};
	obj.siteCd = siteCd;
	obj.workDt = searchDate($('#workDt').val());
	gfn_callAjaxForForm("frmMain", obj, "appvFormSearch", fn_appvSearchCB); 
};

function formAppvReset(){
	$('#password').val('');
	$('#perNo').val('');
	$('#perNm').val('');
	$('#regEmp').val('');
	$('#regEmpName').val('');
	$('#reviewEmp').val('');
	$('#reviewEmpName').val('');
	$('#review2Emp').val('');
	$('#review2EmpName').val('');
	$('#confirmEmp').val('');
	$('#confirmEmpName').val('');
	$('#confirmBtn').val('확인');
	gridMain.clearAll();
	gridMain.parse('','json');
	gridSub.clearAll();
	gridSub.parse('','json');
	gridSub01.clearAll();
	gridSub01.parse('','json');
};

function fn_appvSearchCB(data){
	if(data == ''){
		dataFlag = false;
		var obj = {};
		 obj.siteCd = $('#siteCd').val();
		 gfn_callAjax(obj,"AppvEmpSearch", fn_appvSubSearchCB);
	}else{
		dataFlag = true;
		$('#perNo').val(data[0].regEmp);
		$('#perNm').val(data[0].regEmpName);
	}
};

function fn_appvSubSearchCB(data){
	if(data.length>4){
    	for(var i=0;i<data.length;i++){
    		var settKindVal = data[i].settKind;
    		if(settKindVal == '20'){
    			$('#reviewEmpName').val(data[i].perNm);
    			$('#reviewEmp').val(data[i].perNo);
    		}else if(settKindVal == '30'){
    			$('#review2EmpName').val(data[i].perNm);
    			$('#review2Emp').val(data[i].perNo);
    		}else if(settKindVal == '40'){
    			$('#confirmEmpName').val(data[i].perNm);
    			$('#confirmEmp').val(data[i].perNo);
    		}
    	};	
    }else{
    	for(var i=0;i<data.length;i++){
    		var settKindVal = data[i].settKind;
    		if(settKindVal == '10'){
    			$('#regEmpName').val(data[i].perNm);
    			$('#regEmp').val(data[i].perNo);
    			$('#perNm').val(data[i].perNm);
    			$('#perNo').val(data[i].perNo);
    		}else if(settKindVal == '20'){
    			$('#reviewEmpName').val(data[i].perNm);
    			$('#reviewEmp').val(data[i].perNo);
    		}else if(settKindVal == '30'){
    			$('#review2EmpName').val(data[i].perNm);
    			$('#review2Emp').val(data[i].perNo);
    		}else if(settKindVal == '40'){
    			$('#confirmEmpName').val(data[i].perNm);
    			$('#confirmEmp').val(data[i].perNo);
    		}
    	};	
    }  
	fn_emptyAppvPer();
};
function fn_emptyAppvPer(){
	var reviewEmpName = $('#reviewEmpName').val();
	var review2EmpName = $('#review2EmpName').val();
	var confirmEmpName = $('#confirmEmpName').val();
	if(reviewEmpName == ''){
		$('#reviewSett').val("P");
		$('#reviewSett').attr("disabled",true);
	}
	if(review2EmpName == ''){
		$('#review2Sett').val("P");	
		$('#review2Sett').attr("disabled",true);
	}
	if(confirmEmpName == ''){
		$('#confirmSett').val("P");
		$('#confirmSett').attr("disabled",true);
	}
};

function fn_report(btnFlag){
	if(btnFlag == 1){
		fn_reportConsCB();
	}else{
		fn_reportPerCB();
	}
	
};

function fn_reportConsCB(){
		var url = "/erp/scm/work/partners/dailyWork/constructionS/report/consSearch.do";
		url = url + "?siteCd=" + $('#siteCd').val();
		url = url + "&workDt=" + searchDate($('#workDt').val());
		window.open(url,'rpt','');
};

function fn_reportPerCB(){
	var obj = {};
	obj.siteCd = $('#siteCd').val();
	obj.workDt = searchDate($('#workDt').val());
	 gfn_callAjax(obj, "/erp/scm/work/partners/dailyWork/constructionS/perNoReportCheck", fn_printCB);
};

function fn_printCB(data){
	if(data != ''){
		var url = "/erp/scm/work/partners/dailyWork/constructionS/report/perNoSearch.do";
		url = url + "?siteCd=" + $('#siteCd').val();
		url = url + "&workDt=" + searchDate($('#workDt').val());
		window.open(url,'rpt',''); 	
	}else{
		dhtmlx.alert("출력할 데이터가 없습니다.");
		return true;
	}
};
</script>
<form id="pForm" name="pForm">
    <input type="hidden" name="jsonData" id="jsonData">
    <input type="hidden" name="jsonData2" id="jsonData2">
    <input type="hidden" name="jsonData3" id="jsonData3">
    <input type="hidden" name="formJsonData" id="formJsonData">
</form>
<div id="bootContainer">
 <form id="frmMain" name="frmMain">
   <input type="hidden" name="cudKey" id="cudKey">
   <input type="hidden" id="nextYn" name="nextYn" value=""> 
   <input type="hidden" id="appvNextYn" name="appvNextYn" value=""> 
   <input type="hidden" id="conSec" name="conSec" value=""> 
    <div style="width: 800px; float: left;">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
			     <img src="/images/button/dhtmlx/search.gif" id="searchBtn" style="border: 1px solid;">
				<label class="title0">일자</label>
				<input name="workDt" id="workDt" type="text" value="" placeholder="" class="searchDate format_date" >
				<input type="button" id="calpicker" name="calpicker" class="calicon inputCal">
			</div>
			<div class="ml10">
			  <button name="dailyAppvBtn" id="dailyAppvBtn"  class="btn4" style="background-color: #FFBB00;">일일출역표호출</button> 
			</div>
			<div class="ml10">
               <button name="perNoBtn" id="perNoBtn"  class="btn3">출력현황</button>
			</div>
			<div class="ml10">
              <button name="consBtn" id="consBtn"  class="btn3">공사일보</button>
			</div>
			<div class="ml10">
               <button name="consEmptyBtn" id="consEmptyBtn"  class="btn3">공사일보양식</button>
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left" style="margin-left: 5px;">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}" class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}"  class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left" style="margin-left: 35px;">
			<div class="ml30">
				<label class="title1">사용자확인</label>
				<label class="title0">사번</label>
				<input name="perNo" id="perNo" type="text" value=""  class="searchCode"  readonly="readonly" onkeydown="event.preventDefault()">
				<input name="perNm" id="perNm" type="text" value=""  class="searchCode"  readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left" style="margin-left: 5px;">
			<div class="ml30">
				<label class="title1">날씨</label>
			</div>
		</div>		
		<div class="left">
			<div class="mlZero">
				<select name="weatherBc" id="weatherBc" class="searchBox"></select>
			</div>
		</div>
		<div class="left" style="margin-left: 178px;">
			<div class="ml10">
			<input type="button" name="passBtn" id="passBtn" class="btn3" value="비밀번호 변경">
			<input type="button" value="확인" name="confirmBtn" id="confirmBtn" style="width: 58px; margin-left: 10px;">
				<label class="title0">비밀번호</label>
				<input name="password" id="password" type="password"  class="searchCode">
			</div>
		</div>		
	</div>
	<div class="listHeader">
		<div class="left" style="margin-left: 5px;">
			<div class="ml30">
				<label class="title1">최저기온</label>
				<input name="tempMin" id="tempMin" type="text" value="" class="inputSeq">
			</div>
		</div>	
		<div class="left">
			<div class="ml10">
				<label class="title1">최고기온</label>
				<input name="tempMax" id="tempMax" type="text" value="" class="inputSeq">
			</div>
		</div>		
	</div>
	<div class="listHeader">
		<div class="left" style="margin-left: 5px;">
			<div class="ml30">
				<label class="title1">공사명</label>
				<input name="workNm" id="workNm" type="text" value="" class="inputbox4">
			</div>
		</div>		
	</div>
	<div class=textAreaHeader>
		<div class="left" style="margin-left: 5px;">
			<div class="ml30">
				<label class="title1">작업사항</label>
			</div>
		</div>
		<div class="left">
			<div class="mlZero">
				<textarea name="workDesc" id="workDesc" rows="5" cols="80" style="width: 650px;" ></textarea>
			</div>
		</div>		
	</div>
	<div class="textAreaHeader">
		<div class="left" style="margin-left: 5px;">
			<div class="ml30">
				<label class="title1">특기사항</label>
			</div>
		</div>	
		<div class="left">
			<div class="mlZero">
				<textarea name="rmk" id="rmk" rows="3" cols="80" style="width: 650px;"></textarea>
			</div>
		</div>	
	</div>
  </div>
   <div style="width: 300px; float: left; margin-top: 35px;">
     <div class="left"> 
			<div class="ml10">
				<table border="1">
	        <tr>
	            <td id="appv" rowspan="2">
	                	결
	                <br>
	                <br>재
	            </td>
	            <td id="appv" align="center">담  당</td>
	            <td id="appv" align="center">공  사</td>
	            <td id="appv" align="center">공  무</td>
	            <td id="appv" align="center">소  장</td>
	        </tr>
	        <tr>
	            <td id="appv">
	               <input name="regEmpName" id="regEmpName" type="text" value=""  class="searchCode" readonly="readonly" onkeydown="event.preventDefault()">
	               <input type="hidden" name="regEmp" id="regEmp" value="">
	               <input type="hidden" name="regDt" id="regDt" value="">
	                <div>
	                    <select id="regSett" name="regSett" class="selectbox0" style="width: 91px;">
	                        <option value="N" selected="selected">미결</option>
	                        <option value="Y" >결재</option>
	                    </select>
	                </div>
	            </td>
	            <td id="appv">
	                    <input name="reviewEmpName" id="reviewEmpName" type="text" value="" class="searchCode" readonly="readonly" onkeydown="event.preventDefault()">
	                    <input type="hidden" name="reviewEmp" id="reviewEmp" value="">
	                    <input type="hidden" name="reviewDt" id="reviewDt" value="">
	                <div>
	                    <select id="reviewSett" name="reviewSett" class="selectbox0" style="width: 91px;">
	                    </select>
	                </div>
	            </td>
	            <td id="appv">
	                    <input name="review2EmpName" id="review2EmpName" type="text" value="" class="searchCode" readonly="readonly" onkeydown="event.preventDefault()">
	                    <input type="hidden" name="review2Emp" id="review2Emp" value="">
	                    <input type="hidden" name="review2Dt" id="review2Dt" value="">
	                <div>
	                    <select id="review2Sett" name="review2Sett" class="selectbox0" style="width: 91px;">
	                    </select>
	                </div>
	            </td>
	            <td id="appv">
	                    <input name="confirmEmpName" id="confirmEmpName" type="text" value="" placeholder="" class="searchCode" readonly="readonly" onkeydown="event.preventDefault()">
	                    <input type="hidden" name="confirmEmp" id="confirmEmp" value="">
	                    <input type="hidden" name="confirmDt" id="confirmDt" value="">
	                <div>
	                    <select id="confirmSett" name="confirmSett" class="selectbox0" style="width: 91px;">
	                    </select>
	                </div>
	            </td>
	        </tr>
	     </table>
		</div>
	  </div>
   </div>
  </form>			
</div>
<div id="container"></div>