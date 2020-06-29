<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain, combo01;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;   
var useFlag = false;
var printFlag = false;
$(document).ready(function(){
	Ubi.setContainer(3,[1,2,3,9],"1C"); //결재기준등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"No",      colId:"no",         width:"50", align:"center",  type:"cntr"});
    gridMain.addHeader({name:"근무자구분", colId:"perKindNm",  width:"70", align:"left",    type:"ro"});
    gridMain.addHeader({name:"성명",     colId:"perNm",      width:"70", align:"left",    type:"ro"});
    gridMain.addHeader({name:"공종대분류", colId:"title",      width:"70", align:"left",    type:"ro"});
    gridMain.addHeader({name:"공종코드",  colId:"commgrpsDs", width:"80", align:"left",    type:"ro"});
    gridMain.addHeader({name:"세부공종",  colId:"descNm",     width:"90", align:"left",   type:"ro"});
    gridMain.addHeader({name:"적용공수",  colId:"accpMd",     width:"60", align:"center",  type:"combo"});
    gridMain.addHeader({name:"금액",    colId:"amt",         width:"80", align:"right",   type:"ron"});
    gridMain.addHeader({name:"작업내용",  colId:"workCond",   width:"200", align:"left",   type:"ro"});
    gridMain.addHeader({name:"비고",     colId:"rmk",        width:"200", align:"left",   type:"ro"});
    gridMain.addHeader({name:"출력여부",  colId:"printYn",    width:"60",  align:"center",   type:"ch"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setNumberFormat(["amt"]);
    gridMain.cs_setColumnHidden(["siteCd","custCd","workDt","commgrpmCd","commgrpsCd","perNo","perKind","commgrpdCd"]);

    combo01 =gridMain.getColumnCombo(gridMain.getColIndexById("accpMd"));
    
    gfn_single_comboLoad(combo01,["0.5","1"],["0.5","1.0"],2);
    
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
    		gfn_load_pop('w1','dailyWork/selDailyAttendSPOP',[$('#siteCd').val(),"일일출역표검색","selDailyAttendS"]);
    	}
		return false;
	});
    
    
    $("#perNoEmptyBtn").click(function(){
    	var url = "/erp/scm/work/partners/dailyWork/constructionS/report/perNoEmptySearch.do";
		window.open(url,'rpt',''); 
		return false;
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
    	gridMain.clearAll();
    	gridMain.parse("","js");
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
    
    fn_initAppvCheck();
 
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
		gfn_callAjaxForForm("frmMain", obj, "appvEmpSearch", fn_searchCB);
		gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/work/partners/dailyWork/dailyAttendS/gridMainSearch",subLayout.cells("a"));
	}else{
		return true;
	}
};

function fn_searchCB(data){
	if(data != ''){
		gfn_sett_comboLoad("reviewSett","2");
		gfn_sett_comboLoad("review2Sett","2");
	    gfn_sett_comboLoad("confirmSett","2");
		$('#regSett').val(data[0].regSett);
		$('#reviewSett').val(data[0].reviewSett);
		$('#review2Sett').val(data[0].review2Sett);
		$('#confirmSett').val(data[0].confirmSett);
		$('#cudKey').val("UPDATE");
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
		printFlag = true;
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

function fn_new(){
	location.replace(location.pathname);
};

function fn_save(){
     if(!useFlag){
		return true;
	}else{
		var cudKey = $('#cudKey').val();
		var jsonData = formToJson(cudKey);
		
		$("#jsonData").val(jsonData);
		var formData = new FormData();
		formData.append("jsonData",$("#jsonData").val());
		
		  $.ajax({
	        url: "/erp/scm/work/partners/dailyWork/dailyAttendApproval/formSave",
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

function fn_onClosePop(pName,data){
	 if(pName == "siteCd"){
		 if(!useFlag){
			 $('#siteCd').val(data[0].siteCd);
			 $('#siteNm').val(data[0].siteNm); 
			 fn_appvSearch(data[0].siteCd);
		 }
		 $('#password').focus();
	 }
	 if(pName == "selDailyAttendS"){
		 $('#workDt').val(data[0].workDt);
		 $('#siteCd').val(data[0].siteCd);
		 $('#siteNm').val(data[0].siteDs);
		 fn_appvSearch(data[0].siteCd);
		 $('#password').focus();
	 }
	 if(pName == "appvPerNo"){
		 $('#perNo').val(data[0].perNo);
		 $('#perNm').val(data[0].perNm);
	 }
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
};

function fn_appvSearch(siteCd){
	formAppvReset();
	var obj = {};
	 obj.siteCd = siteCd;
	 obj.workDt = searchDate($('#workDt').val());
	 gfn_callAjaxForForm("frmMain", obj, "appvEmpSearch", fn_appvSearchCB);
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
};


function fn_appvSearchCB(data){
	if(data != ''){
		$('#perNo').val(data[0].regEmp);
		$('#perNm').val(data[0].regEmpName);
	}
};

function fn_print(){
	if(printFlag){
		var obj = {};
		obj.siteCd = $('#siteCd').val();
		obj.workDt = searchDate($('#workDt').val());
		 gfn_callAjax(obj, "/erp/scm/work/partners/dailyWork/constructionS/perNoReportCheck", fn_printCB);
	}else{
		dhtmlx.alert("등록된 내역이 없습니다.");
		return true;
	}
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
</script>
<form id="pform" name="pform" method="post">
    <input type="hidden" id="jsonData" name="jsonData" />
</form>
<div id="bootContainer">
  <form id="frmMain" name="frmMain">
  <input type="hidden" id="cudKey" name="cudKey" value="">
  <input type="hidden" id="nextYn" name="nextYn" value=""> 
   <div style="width: 840px; float: left; margin-top: 10px;">
    <div class="listHeader">
		<div class="left">
			<div class="ml30">
			    <img src="/images/button/dhtmlx/search.gif" id="searchBtn" style="border: 1px solid;">
				<label class="title0">일자</label>
				<input name="workDt" id="workDt" type="text" value="" class="searchDate format_date">
				<input type="button" id="calpicker" name="calpicker" class="calicon inputCal">
			</div>
			<div class="ml10">
               <button name="perNoEmptyBtn" id="perNoEmptyBtn"  class="btn3">출력현황양식</button>
			</div>
		</div>	
		<div class="left" style="margin-left: 24px;">
			<div class="ml30">
			    <input type="button" name="passBtn" id="passBtn" class="btn3" value="비밀번호 변경">
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
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}"  class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}"  class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left"  style="margin-left: 114px;">
			<div class="ml10">
			<input type="button" value="확인" name="confirmBtn" id="confirmBtn" style="width: 54px;">
				<label class="title0">비밀번호</label>
				<input name="password" id="password" type="password"  class="searchCode">
			</div>
		</div>
	</div>
   </div>
   <div style="width: 300px; float: left; margin-top: 13px;">
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