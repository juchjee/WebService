<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){
	Ubi.setContainer(4,[1,8],"1C"); //일일근태 조회
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"출근확인",    colId:"workYn", width:"50",  align:"center", type:"ch"});
    gridMain.addHeader({name:"No",       colId:"no",     width:"50",  align:"center", type:"cntr"});
    gridMain.addHeader({name:"근무일자",   colId:"workDt",  width:"80", align:"center", type:"ro"});
    gridMain.addHeader({name:"근무자번호",  colId:"perNo",   width:"80", align:"left",   type:"ro"});
    gridMain.addHeader({name:"성명",      colId:"perNm",   width:"70", align:"left",   type:"ro"});
    gridMain.addHeader({name:"근태구분",   colId:"workKn",  width:"60", align:"center",  type:"ro"});
    gridMain.addHeader({name:"정상",      colId:"normal",  width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"연장",      colId:"extend",  width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"야근",      colId:"night",   width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"특근",      colId:"special", width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"외출",      colId:"outside", width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"조퇴",      colId:"early",   width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"지각",      colId:"late",    width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"총근무",     colId:"total",   width:"70",  align:"right",  type:"ron"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@workDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.attachEvent("onCheck",doOnCheck);
    
    $("#perNm").dblclick(function(){
    	gfn_load_pop('w1','comm/perNmPOP',[$('#siteCd').val(),'',"perNm"]);
    });
    
    $("#perNm").keypress(function(e){
    	if(e.which == 13){
    		gfn_load_pop('w1','comm/perNmPOP',[$('#siteCd').val(),$('#perNm').val(),"perNm"]);
    		return false;
    	}
    });

    fn_search();
});
function doOnCheck(rId,cInd,state){
	if(state){
		gridMain.setCells(rId,0).setValue('0');
	}else{
		gridMain.setCells(rId,0).setValue('1');
	}
}
function fn_search(){
	var obj={};
	obj.sdate  = searchDate($('#sdate').val());
	obj.edate  = searchDate($('#edate').val());
	obj.workKn = $('#workKn').val(); 
	obj.perNm  = $('#perNm').val();
	obj.siteCd = $('#siteCd').val();
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
}

function fn_searchCB(data){
	if(data != ''){
		fn_multiRowMerge2(gridMain, 2,4);
	}
};

function fn_exit(){
	mainTabbar.tabs(ActTabId).close();
};

function fn_onClosePop(pName,data){
	 if(pName == "perNm"){
		 $('#perNm').val(data[0].perNm);
		 $('#perNm').focus();
	 }
	 if(pName == "siteCd"){
		 $('#siteCd').val(data[0].siteCd);
		 $('#siteNm').val(data[0].siteNm);
		 $('#siteCd').focus();
	 }
};
</script>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">근무일자</label>
				<input name="sdate" id="sdate" type="text" value="" placeholder="" class="searchDate format_date" >
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'edate', 'max')"> ~ 
				<input name="edate" id="edate" type="text" value="" placeholder="" class="searchDate format_date" >
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'sdate', 'min')">
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
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">근태구분</label>
				<select name="workKn" id="workKn" class="searchBox">
				  <option value="10">정상</option>
				  <option value="20">휴가</option>
				  <option value="30">결근</option>
				  <option value="40">출장</option>
				</select>
			</div>
		</div>		
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">성명</label>
				<input name="perNm" id="perNm" type="text" value="" placeholder="" class="searchCode">
			</div>
		</div>		
	</div>		
</div>
<div id="container"></div>