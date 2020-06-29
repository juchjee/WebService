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
	Ubi.setContainer(3,[1,8],"1C"); //월근태집계
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"No",       colId:"no",      width:"50",   align:"center", type:"cntr"});
    gridMain.addHeader({name:"근무자번호",  colId:"perNo",   width:"80",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"성명",      colId:"perNm",   width:"70",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"근무일수",   colId:"cnt",      width:"60",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"근무시간",   colId:"normal",   width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"연장시간",   colId:"extend",   width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"야근시간",   colId:"night",    width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"특근시간",   colId:"special",  width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"지각시간",   colId:"late",     width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"조퇴시간",   colId:"early",    width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"외출시간",   colId:"outside",  width:"70",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"총근무",     colId:"total",   width:"70",  align:"right",  type:"ron"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["custCd","siteCd"]);
    
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
function fn_search(){
	var obj={};
	obj.sdate  = searchDate($('#sdate').val());
	obj.edate  = searchDate($('#edate').val()); 
	obj.perNm  = $('#perNm').val();
	obj.siteCd  = $('#siteCd').val();
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"));
}


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
				<input name="sdate" id="sdate" type="text" value="" placeholder="" class="searchDate format_date">
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'edate', 'max')"> ~ 
				<input name="edate" id="edate" type="text" value="" placeholder="" class="searchDate format_date">
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'sdate', 'min')">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}" class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}"  class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>		
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">성명</label>
				<input name="perNm" id="perNm" type="text" value="" class="searchCode">
			</div>
		</div>		
	</div>		
</div>
<div id="container"></div>