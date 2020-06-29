<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){//발주확인현황
	Ubi.setContainer(3,[1,8],"1C");
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
   
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"확인",       colId:"outsCon",    width:"60",  align:"center",   type:"ro"});
    gridMain.addHeader({name:"발주번호",    colId:"poNo",       width:"100", align:"left",     type:"ro"});
    gridMain.addHeader({name:"발주배정일자", colId:"balDt",      width:"80",  align:"center",   type:"ro"});
    gridMain.addHeader({name:"품목구분",    colId:"etcKindNm",  width:"60",  align:"center",   type:"ro"});
    gridMain.addHeader({name:"품목코드",    colId:"itemCd",     width:"70",  align:"left",     type:"ro"});
    gridMain.addHeader({name:"품명",       colId:"kitemDs",    width:"150", align:"left",     type:"ro"});
    gridMain.addHeader({name:"규격",       colId:"itemSz",     width:"200", align:"left",     type:"ro"});
    gridMain.addHeader({name:"단위",       colId:"itemUt",     width:"70",  align:"left",     type:"ro"});
    gridMain.addHeader({name:"수량",       colId:"balAsgnQty", width:"90",  align:"right",    type:"ron"});
    gridMain.addHeader({name:"단가",       colId:"itemUp",     width:"90",  align:"right",    type:"ron"});
    gridMain.addHeader({name:"금액",       colId:"itemAm",     width:"100", align:"right",    type:"ron"});
    gridMain.addHeader({name:"납기일자",    colId:"deliveryDt", width:"80",  align:"center",   type:"ro"});
    gridMain.addHeader({name:"납품장소",    colId:"locationAt", width:"100", align:"left",     type:"ro"});
    gridMain.addHeader({name:"비고",       colId:"rmks",       width:"150", align:"left",     type:"ro"});
    gridMain.addHeader({name:"배정마감",    colId:"endYn",      width:"70",   align:"center",  type:"ro"});
    gridMain.addHeader({name:"외주처 비고",  colId:"outsRmk",    width:"150",  align:"left",    type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@balDt","format_date");
    gridMain.dxObj.setUserData("","@deliveryDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setNumberFormat(["itemQn"],"0,000.00");
    gridMain.cs_setNumberFormat(["itemUp","itemAm"]);
    gridMain.cs_setColumnHidden(["mrNo","inqNo","sqNo","custCd","costId","deliSeq","itemQn","siteCd","siteDs","etcReqNo"]);
    
    $('input[name="outsCon"]:radio').change(function() { 
       	fn_search();
    });
    
    calMain = new dhtmlXCalendarObject([{input:"stBalDt",button:"calpicker1"},{input:"edBalDt",button:"calpicker2"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var nowDate = dateformat(new Date());
	var legSetDate = new Date();
	legSetDate.setMonth(legSetDate.getMonth() + 1);
	legSetDate.setDate(legSetDate.getDate() - 5);
	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth())+'/'+fn_day(legSetDate.getDate());
	$('#stBalDt').val(legDate);
	$('#edBalDt').val(nowDate);
	
	fn_search();
    
});
function fn_month(month){
	if(month == 0){
		month = 12;
	}
	if(month < 10){
		month = '0'+month;
     }
	return month;
};

function fn_day(day){
	if(day < 10){
		day = '0'+day;
     }
	return day;
};

function fn_search(){
	var obj={}; 
	obj.siteCd = $('#siteCd').val();
	obj.stBalDt = searchDate($('#stBalDt').val());
	obj.edBalDt = searchDate($('#edBalDt').val());
	obj.outsCon = $('input:radio[name="outsCon"]:checked').val();
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
};

function fn_searchCB(data){
	for(var i=0;i<gridMain.getRowsNum();i++){
		var endYn = gridMain.setCells2(i,gridMain.getColIndexById("endYn")).getValue();
		if(endYn == '0'){
			gridMain.setCells2(i, gridMain.getColIndexById("endYn")).setValue("미마감");
		}else{
			gridMain.setCells2(i, gridMain.getColIndexById("endYn")).setValue("마감");
		}
	}	
};

function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};

function fn_onClosePop(pName,data){
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
				<label class="title1">배정기간</label>
				<input name="stBalDt" id="stBalDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'edBalDt', 'max')"> ~ 
				<input name="edBalDt" id="edBalDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'stBalDt', 'min')">
			</div>
		</div>
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}" class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}" class="inputbox3" onkeydown="event.preventDefault()" readonly="readonly">
			</div>
		</div>
	</div>	
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">구분</label>
				<input type="radio" name="outsCon" id="outsCon" value="all">전체
				<input type="radio" name="outsCon" id="outsCon" value="michk" checked="checked">미확인
				<input type="radio" name="outsCon" id="outsCon" value="okchk" >확인
			</div>
		</div>
	</div>
</div>
<div id="container"></div>