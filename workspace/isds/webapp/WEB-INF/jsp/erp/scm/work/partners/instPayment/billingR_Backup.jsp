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
	Ubi.setContainer(4,[1,8],"1C"); //기성청구확인
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
	 gridMain = new dxGrid(subLayout.cells("a"),false);
	    gridMain.addHeader({name:"No",     colId:"no",         width:"50",  align:"center", type:"cntr"});
	    gridMain.addHeader({name:"공종코드", colId:"costId",     width:"80", align:"left",   type:"ro"});
	    gridMain.addHeader({name:"명칭",    colId:"itemDs",     width:"80", align:"left",   type:"ro"});
	    gridMain.addHeader({name:"규격",    colId:"sizeSz",     width:"100", align:"left",   type:"ro"});
	    gridMain.addHeader({name:"단위",    colId:"unitDs",     width:"60", align:"center",  type:"ro"});
	    gridMain.addHeader({name:"구분",    colId:"hdFd",       width:"60", align:"center",  type:"ro"});
	    gridMain.addHeader({name:"계약내역", colId:"hadoQn",     width:"80",  align:"right",  type:"ron"});
	    gridMain.addHeader({name:"#cspan", colId:"hadoUp",     width:"80",  align:"right",  type:"ron"});
	    gridMain.addHeader({name:"#cspan", colId:"hadoAm",     width:"80",  align:"right",  type:"ron"});
	    gridMain.addHeader({name:"전월누계", colId:"hadogspQn",  width:"80",  align:"right",  type:"ron"});
	    gridMain.addHeader({name:"#cspan", colId:"hadogspAm",  width:"80",  align:"right",  type:"ron"});
	    gridMain.addHeader({name:"당월청구", colId:"hadogsQn",    width:"80",  align:"right",  type:"ron"});
	    gridMain.addHeader({name:"#cspan", colId:"hadogsAm",   width:"80",  align:"right",  type:"ron"});
	    gridMain.addHeader({name:"누계기성", colId:"hadogstQn",   width:"80",  align:"right",  type:"ron"});
	    gridMain.addHeader({name:"#cspan", colId:"hadogstAm",  width:"80",  align:"right",  type:"ron"});
	    gridMain.addHeader({name:"확인",    colId:"reqCon",     width:"60",  align:"center",  type:"ch"});
	    gridMain.attachHeader("#rspan,#rspan,#rspan,#rspan,#rspan,#rspan,수량,단가,금액,수량,금액,수량,금액,수량,금액,#rspan");
	    gridMain.setUserData("","pk","");
	    gridMain.init();
	    gridMain.cs_setNumberFormat(["hadoQn","hadogspQn","hadogsQn","hadogstQn"],"00.000");
	    gridMain.cs_setColumnHidden(["siteCd","hadocontNo","workYm","costCd"]);
	    gridMain.attachEvent("onCheck",doOnCheck);
	    
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
	     
	     $('input[name="flag"]:radio').change(function() { 
	        	fn_search();
	         });
	    

});
function doOnCheck(rId,cInd,state){
	if(state){
		gridMain.setCells(rId,gridMain.getColIndexById("reqCon")).setValue(0);
	}else{
		gridMain.setCells(rId,gridMain.getColIndexById("reqCon")).setValue(1);	
	}
	return;	
};
	
function fn_search(){
	var obj={};
	obj.hadocontNo = $('#hadocontNo').val();
	obj.siteCd = $('#siteCd').val();
	obj.workYm = searchDate($('#workYm').val());
	obj.sqSn = $('#sqSn').val();
	obj.flag = $('input:radio[name="flag"]:checked').val(); 
    gfn_callAjaxForGridR(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
};

function fn_searchCB(data){
	if(data != ''){
		fncChangeRowColor(1,gridMain);
	}
}

function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
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
		 $('#hadocontNo').focus();
	 }
};
</script>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="left">
			<div class="ml30">
				<label class="title1">청구일자</label>
				<input name="workYm" id="workYm" type="text" value="" class="searchDate format_month">
				<input type="button" id="calpicker" name="calpicker" class="calicon inputCal">
			</div>
		</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input type="hidden" id="sqSn" name="sqSn" value="0">
				<input name="siteCd" id="siteCd" type="text" value="" placeholder="" class="searchCode">
				<input name="siteNm" id="siteNm" type="text"  class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>		
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">계약번호</label>
				<input name="hadocontNo" id="hadocontNo" type="text" value=""  class="searchCode" readonly="readonly" onkeydown="event.preventDefault()">
				<input name="hadocontDs" id="hadocontDs" type="text" value="" class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>	
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">구분</label>
				<input type="radio" name="flag" id="flag" value="%" checked="checked">전체
				<input type="radio" name="flag" id="flag" value="1">확인
				<input type="radio" name="flag" id="flag" value="0" >미확인
			</div>
		</div>		
	</div>
</div>
<div id="container"></div>