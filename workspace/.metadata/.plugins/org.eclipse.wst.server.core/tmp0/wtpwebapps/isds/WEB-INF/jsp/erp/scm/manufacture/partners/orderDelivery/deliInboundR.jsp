<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){//입고마감현황
	Ubi.setContainer(3,[1,8],"1C");
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
	gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"NO",     colId:"no",        width:"60",  align:"center",  type:"cntr"});
    gridMain.addHeader({name:"납품일자",  colId:"deliDate", width:"80",   align:"center",  type:"ro"});
    gridMain.addHeader({name:"공장",     colId:"facNm",    width:"80",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"발주번호",  colId:"poNo",     width:"120",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"품목코드",  colId:"itmCd",    width:"90",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"품명",     colId:"itmNm",    width:"180",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"규격",     colId:"spec",     width:"180",  align:"left",    type:"ro"});
    gridMain.addHeader({name:"단위",     colId:"umBcNm",   width:"70",   align:"left",    type:"ro"});
    gridMain.addHeader({name:"발주수량",  colId:"poQty",    width:"70",   align:"right",   type:"ron"});
    gridMain.addHeader({name:"납품수량",  colId:"deliQty",  width:"80",   align:"right",   type:"ron"});
    gridMain.addHeader({name:"미납수량",  colId:"miDeliQty",width:"80",   align:"right",   type:"ron"});
    gridMain.addHeader({name:"납기일자",  colId:"dlvDt",    width:"80",   align:"center",  type:"ro"});
    gridMain.addHeader({name:"입고수량",  colId:"inQty",    width:"80",   align:"right",  type:"ron"});
    gridMain.addHeader({name:"미입고수량", colId:"miInQty", width:"80",   align:"right",  type:"ron"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@deliDate","format_date");
    gridMain.dxObj.setUserData("","@dlvDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["deliKey","deliSeq","deliNo","poFac","itmId","custCd","custNm"]);
    gridMain.cs_setNumberFormat(["poQty","deliQty","inQty","miInQty"]); 
    
    calMain = new dhtmlXCalendarObject([{input:"stDeliDate",button:"calpicker1"},
	                                    {input:"edDeliDate",button:"calpicker2"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var t = dateformat(new Date());
	byId("stDeliDate").value = t;
	byId("edDeliDate").value = t;
    

    $('input[name="gubn"]:radio').change(function() { 
       	fn_search();
    });
    
    $('#facCd').change(function() { 
       	fn_search();
    });
    
    gfn_facCd_comboLoadAllOption("facCd","facCdSearch");
    
    fn_search();

});
function fn_search(){
	var obj = {};
	obj.stDeliDate = searchDate($('#stDeliDate').val());
	obj.edDeliDate = searchDate($('#edDeliDate').val());
	obj.gubn = $('input:radio[name="gubn"]:checked').val(); 
	obj.facCd = $('#facCd').val();
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
};

function fn_searchCB(data){
	if(data != ''){
		fn_multiRowMerge2(gridMain, 1,9);
	}
}

function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};
</script>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">기간</label>
				<input name="stDeliDate" id="stDeliDate" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'edDeliDate', 'max')"> ~ 
				<input name="edDeliDate" id="edDeliDate" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'stDeliDate', 'min')">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">입고구분</label>
				<input type="radio" name="gubn" id="gubn" value="miIn" checked="checked">미입고
				<input type="radio" name="gubn" id="gubn" value="in">입고
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">공장코드</label>
			</div>
		</div>	
		<div class="left">	
			<div class="mlZero">
				<select name="facCd" id="facCd" class="searchBox"></select>
			</div>
		</div>	
	</div>
</div>
<div id="container"></div>