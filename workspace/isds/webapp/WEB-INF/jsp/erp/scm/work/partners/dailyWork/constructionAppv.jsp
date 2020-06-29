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
$(document).ready(function(){
	Ubi.setContainer(4,[1,2,3],"1C"); //공사일보 등록
	
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
    gridMain.addHeader({name:"작업인원",  colId:"perNum",     width:"60",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"작업내용",  colId:"workCon",    width:"300", align:"left",   type:"ro"});
    gridMain.addHeader({name:"출력여부",  colId:"printYn",    width:"60", align:"center",   type:"ch"});
    gridMain.setUserData("","pk","");
    gridMain.attachFooter("&nbsp;,합계,,,#stat_total,#stat_total,,");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["custCd","siteCd","commgrpmCd","workDt","commgrpsCd","cnt","workSeq","commgrpdCd"]);
    
    gridSub = new dxGrid(gridTabbar.tabs("a2"),false);
    gridSub.addHeader({name:"No",      colId:"no",        width:"50",   align:"center", type:"cntr"});
    gridSub.addHeader({name:"장비코드",  colId:"itemCd",  width:"100",    align:"left",   type:"ro"});
    gridSub.addHeader({name:"장비명",    colId:"itemNm",  width:"150",    align:"left",   type:"ro"});
    gridSub.addHeader({name:"규격",     colId:"itemSpec",   width:"150", align:"left",   type:"ro"});
    gridSub.addHeader({name:"단위",     colId:"itemUnit",   width:"150", align:"center", type:"ro"});
    gridSub.addHeader({name:"전일수량",   colId:"preQty",     width:"60",  align:"right",  type:"ron"});
    gridSub.addHeader({name:"수량",     colId:"qty",        width:"60",  align:"right",  type:"ron"});
    gridSub.addHeader({name:"작업내용",  colId:"workConScm", width:"300", align:"left",   type:"ro"});
    gridSub.addHeader({name:"출력여부",  colId:"printYn",   width:"60", align:"center",   type:"ch"});
    gridSub.setUserData("","pk","");
    gridSub.attachFooter("&nbsp;,,합계,,,,#stat_total,#stat_total,,,");
    gridSub.dxObj.enableHeaderMenu("false");
    gridSub.init();
    gridSub.cs_setColumnHidden(["custCd","siteCd","workSeq","workDt"]);
	
	gridSub01 = new dxGrid(gridTabbar.tabs("a3"),false);
    gridSub01.addHeader({name:"No",    colId:"no",         width:"50",  align:"center",  type:"cntr"});
    gridSub01.addHeader({name:"품목코드",   colId:"itemCd",  width:"150",  align:"left",   type:"ro"});
    gridSub01.addHeader({name:"품명",   colId:"itemName",   width:"150",  align:"left",   type:"ro"});
    gridSub01.addHeader({name:"규격",   colId:"itemSpec",   width:"150",  align:"left",   type:"ro"});
    gridSub01.addHeader({name:"입고량",  colId:"inQty",     width:"80",   align:"right",   type:"ron"});
    gridSub01.addHeader({name:"시공량",  colId:"buildQty",  width:"80",   align:"right",   type:"ron"});
    gridSub01.addHeader({name:"반출량",  colId:"outQty",    width:"80",   align:"right",   type:"ron"});
    gridSub01.setUserData("","pk","");
    gridSub01.attachFooter("&nbsp;,합계,,,#stat_total,#stat_total,#stat_total");
    gridSub01.dxObj.enableHeaderMenu("false");
    gridSub01.init();
    gridSub01.cs_setColumnHidden(["custCd","siteCd","workSeq","workDt"]);
	gridSub01.cs_setNumberFormat(["inQty","buildQty","outQty"]);
	
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
    
    $('#appvKind').change(function(){
    	var appvKind = $('#appvKind').val();
    	var perNo = null;
    	var perNm = null;
    	if(appvKind == '10'){
    		perNo = $('#regEmp').val();
    		perNm = $('#regEmpName').val();
    	}else if(appvKind == '20'){
    		perNo = $('#reviewEmp').val();
    		perNm = $('#reviewEmpName').val();
    	}else if(appvKind == '30'){
    		perNo = $('#review2Emp').val();
    		perNm = $('#review2EmpName').val();
    	}else if(appvKind == '40'){
    		perNo = $('#confirmEmp').val();
    		perNm = $('#confirmEmpName').val();
    	};
    	$('#perNo').val(perNo);
    	$('#perNm').val(perNm);
    	
    	$('#password').val('');
    	$('#workDesc').val("");
    	$('#rmk').val("");
    	gridMain.clearAll();
    	gridMain.parse("","js");
    	gridSub.clearAll();
    	gridSub.parse("","js");
    	gridSub01.clearAll();
    	gridSub01.parse("","js");
    	$('#confirmBtn').val("확인");
    	$('#regSett').attr("disabled",true);
    	$('#reviewSett').attr("disabled",true);
    	$('#review2Sett').attr("disabled",true);
    	$('#confirmSett').attr("disabled",true);
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
    
    calMain.attachEvent("onChange", function(date, state){
        alert(data);
    });
    
    gfn_sett_comboLoad("reviewSett","1");
    gfn_sett_comboLoad("review2Sett","1");
    gfn_sett_comboLoad("confirmSett","1");
    
    fn_initAppvCheck();
    
    fn_searchWorkNm();

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
	gfn_callAjax(obj, "/erp/scm/work/partners/dailyWork/constructionS/selConsWorkNm", fn_searchWorkNmCB);
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
		$('#'+eleId).append("<option value='Y'>결재</option>");
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

function fn_search(){
	if(useFlag){
		var obj={};
		obj.siteCd = $('#siteCd').val();
		obj.workDt = searchDate($('#workDt').val());
		gfn_callAjaxForForm("frmMain", obj, "/erp/scm/work/partners/dailyWork/constructionS/formSearch", fn_searchCB);
	}else{
		return true;
	}
};

function fn_searchCB(data){
  if(data != '')	{
	  gfn_sett_comboLoad("reviewSett","2");
	  gfn_sett_comboLoad("review2Sett","2");
	    gfn_sett_comboLoad("confirmSett","2");
	  $('#regSett').val(data[0].regSett);
	  $('#reviewSett').val(data[0].reviewSett);
	  $('#review2Sett').val(data[0].review2Sett);
	  $('#confirmSett').val(data[0].confirmSett);
	 $('#cudKey').val("UPDATE");
	  printFlag = true;
	 var appvKind = $('#appvKind').val();
	 if(appvKind == '10'){
			$('#reviewSett').attr("disabled",true);
			$('#review2Sett').attr("disabled",true);
			$('#confirmSett').attr("disabled",true);
			fn_appvCheck('reg');
	 }else if(appvKind == '20'){
			$('#regSett').attr("disabled",true);
			$('#review2Sett').attr("disabled",true);
			$('#confirmSett').attr("disabled",true);
			fn_appvCheck('review');
	 }else if(appvKind == '30'){
			$('#regSett').attr("disabled",true);
			$('#reviewSett').attr("disabled",true);
			$('#confirmSett').attr("disabled",true);
			fn_appvCheck('review2');
	 }else{
			$('#regSett').attr("disabled",true);
			$('#reviewSett').attr("disabled",true);
			$('#review2Sett').attr("disabled",true);
			fn_appvCheck('confirm');
		}
	 var obj={};
		obj.siteCd = data[0].siteCd;
		obj.workDt = data[0].workDt;
	 gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/work/partners/dailyWork/constructionS/gridMainSearch",gridTabbar.tabs("a1"),fn_mainSearchCB);
	 gfn_callAjaxForGrid(gridSub,obj,"/erp/scm/work/partners/dailyWork/constructionS/gridSubSearch",gridTabbar.tabs("a2"));
	 gfn_callAjaxForGrid(gridSub01,obj,"/erp/scm/work/partners/dailyWork/constructionS/gridSub01Search",gridTabbar.tabs("a3"));
	 $('#siteCd').attr("disabled",true);
	 $('#workDt').attr("disabled",true);
	 $('#calpicker').attr("disabled",true);
  }else{
	  gfn_sett_comboLoad("reviewSett","1");
		gfn_sett_comboLoad("review2Sett","1");
		gfn_sett_comboLoad("confirmSett","1");
		printFlag = false;  
		$('#siteCd').attr("disabled",false);
		$('#workDt').attr("disabled",false);
		$('#calpicker').attr("disabled",false);
  }
};

function fn_mainSearchCB(data){
	if(data != ''){
		for(var i=0;i<gridMain.getRowsNum();i++){
			var workConIdx = gridMain.getColIndexById("workCon");
			var workConVal = gridMain.setCells2(i,workConIdx).getValue();
			var textAreaTag = "<textarea  style='width:100%; height:55px; margin-top :3px;' id='workCon"+(i)+"' name='workCon'>"+workConVal+"</textarea>";
			gridMain.setCells2(i, workConIdx).setValue(textAreaTag);
		}
	}
}

function fn_new(){
	location.replace(location.pathname);
};

function fn_save(){
	var siteCd = $('#siteCd').val();
	if(siteCd == '' || siteCd == null){
		dhtmlx.alert("현장코드를 입력하세요.");
		return true;
	}else if(!useFlag){
		return true;
	}else{
		var cudKey = $('#cudKey').val();
		var jsonData = formToJson(cudKey);
		
		$("#formJsonData").val(jsonData);
		var formData = new FormData();
		formData.append("formJsonData",$("#formJsonData").val());
		
		  $.ajax({
	        url: "/erp/scm/work/partners/dailyWork/constructionAppv/formSave",
	        type: "POST",
	        data: formData,
	        dataType: "text",
	        processData: false,
	        contentType: false,
	        success: function(data) {
	        	MsgManager.alertMsg("INF001");
	        	fn_search();
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

function fn_appvCheck(gubn){
	var nextYn = $('#nextYn').val();
	var regSett = $('#regSett').val();
	var reviewSett = $('#reviewSett').val();
	var review2Sett = $('#review2Sett').val();
	var confirmSett  = $('#confirmSett').val();
	if(nextYn == '1'){
		gfn_sett_comboLoad("reviewSett","2");
		gfn_sett_comboLoad("review2Sett","2");
		gfn_sett_comboLoad("confirmSett","2");
		$('#regSett').attr("disabled",true);
		$('#reviewSett').attr("disabled",true);
		$('#review2Sett').attr("disabled",true);
		$('#confirmSett').attr("disabled",true);
	}else{
		if(gubn == 'reg'){
			gfn_sett_comboLoad("reviewSett","2");
			gfn_sett_comboLoad("review2Sett","2");
			gfn_sett_comboLoad("confirmSett","2");
			$('#reviewSett').attr("disabled",true);
			$('#review2Sett').attr("disabled",true);
			$('#confirmSett').attr("disabled",true);
			if(reviewSett == 'Y' || review2Sett == 'Y' || confirmSett == 'Y'){
				$('#regSett').attr("disabled",true);
			}else{
				$('#regSett').attr("disabled",false);
			}
		}else if(gubn == 'review'){
			gfn_sett_comboLoad("reviewSett","2");
			gfn_sett_comboLoad("review2Sett","2");
			gfn_sett_comboLoad("confirmSett","2");
			if(confirmSett == 'Y' || regSett != 'Y' || reviewSett == 'P'|| review2Sett == 'Y'){
				 $('#reviewSett').attr("disabled",true);
			}else{
				gfn_sett_comboLoad("reviewSett","1");
				$('#reviewSett').attr("disabled",false);
			}
		}else if(gubn == 'review2'){
			gfn_sett_comboLoad("reviewSett","2");
			gfn_sett_comboLoad("review2Sett","2");
			gfn_sett_comboLoad("confirmSett","2");
			if(confirmSett == 'Y' || regSett != 'Y' || reviewSett == 'N' || review2Sett == 'P'){
				 $('#review2Sett').attr("disabled",true);
			}else{
				gfn_sett_comboLoad("review2Sett","1");
				$('#review2Sett').attr("disabled",false);
			}
		}else if(gubn == 'confirm'){
			gfn_sett_comboLoad("confirmSett","2");
			gfn_sett_comboLoad("reviewSett","2");
			gfn_sett_comboLoad("review2Sett","2");
			if(reviewSett == 'N' ||review2Sett == 'N' || regSett == 'N' || confirmSett == 'P'){
				 $('#confirmSett').attr("disabled",true);
			}else{
				gfn_sett_comboLoad("confirmSett","1");
				$('#confirmSett').attr("disabled",false);
			}
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
		 $('#password').focus();
	 }
	 if(pName == "selConstruction"){
		 $('#workDt').val(data[0].workDt);
		 $('#siteCd').val(data[0].siteCd);
		 $('#siteNm').val(data[0].siteDs);
		 fn_appvSearch(data[0].siteCd);
		 $('#password').focus();
	 };
	 if(pName == "appvPerNo"){
		 $('#perNo').val(data[0].perNo);
		 $('#perNm').val(data[0].perNm);
	 }
};

function fn_appvSearch(siteCd){
	formAppvReset();
	var obj = {};
	 obj.siteCd = siteCd;
	 obj.workDt = searchDate($('#workDt').val());
	 gfn_callAjaxForForm("frmMain", obj, "/erp/scm/work/partners/dailyWork/constructionS/appvFormSearch",fn_appvSearchCB);
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
	if(data != ''){
		$('#perNo').val(data[0].regEmp);
		$('#perNm').val(data[0].regEmpName);
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
               <button name="consBtn" id="consBtn"  class="btn3">공사일보</button>
			</div>
			<div class="ml10">
               <button name="perNoBtn" id="perNoBtn"  class="btn3">출력현황</button>
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
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}" class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml30">
				<label class="title0">결재구분</label>
				<select name="appvKind" id="appvKind" class="selectbox0">
				  <option value="10">담당</option>
				  <option value="20">공사</option>
				  <option value="30">공무</option>
				  <option value="40">소장</option>
				</select>
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
				<select name="weatherBc" id="weatherBc" class="searchBox" disabled="disabled" onkeydown="event.preventDefault()"></select>
			</div>
		</div>
		<div class="left" style="margin-left: 179px;">
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
				<textarea name="workDesc" id="workDesc" rows="5" cols="80" style="width: 650px;"></textarea>
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