<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain, gridSub;
var calMain;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;
$(document).ready(function(){
	Ubi.setContainer(1,[1,8],"2E"); //송장상세내역
	 
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
	subLayout.cells("a").attachObject("bootContainer2");
	subLayout.cells("a").showHeader();
    subLayout.cells("a").setText("송장기본정보");
    subLayout.cells("a").setHeight(240);
	
	subLayout.cells("b").showHeader()
    subLayout.cells("b").setText("송장상세내역")
    gridMain = new dxGrid(subLayout.cells("b"),false);
	gridMain.addHeader({name:"순번",    colId:"sqNo",     width:"50",   align:"center", type:"ron"});
    gridMain.addHeader({name:"품목코드", colId:"itemCd",   width:"70",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"품목명",   colId:"kitemDs",  width:"120", align:"left",   type:"ro"});
    gridMain.addHeader({name:"규격",    colId:"itemSz",   width:"100",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"잡자재명", colId:"etcNm",    width:"100",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"잡자재규격", colId:"etcSz",   width:"100",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"단위",    colId:"itemUt",   width:"60",   align:"center", type:"ro"});
    gridMain.addHeader({name:"비목",    colId:"itemUc",   width:"70",   align:"left",   type:"ro"});
    gridMain.addHeader({name:"수량",    colId:"itemQn",   width:"70",   align:"right",  type:"ron"});
    gridMain.addHeader({name:"단가",    colId:"itemUp",   width:"80",   align:"right",  type:"ron"});
    gridMain.addHeader({name:"공급가액",  colId:"itemAm",  width:"80",   align:"right",  type:"ron"});
    gridMain.addHeader({name:"부가세",   colId:"itemVat",  width:"80",   align:"right",  type:"ron"});
    gridMain.addHeader({name:"계",      colId:"itemSum",  width:"100",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"공종코드",  colId:"costCd",   width:"100",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"공종명",   colId:"itemDs",   width:"80",   align:"left",   type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setNumberFormat(["itemQn","itemUp","itemVat","itemSum","itemAm"]);

    getjsonData();

    fn_search();

});
function getjsonData(){
 	if(PARAM_INFO.invoiceNo != undefined){
 		$('#invoiceNo').val(PARAM_INFO.invoiceNo);
	}
};

function fn_search(){
	var obj = {};
	obj.invoiceNo = $('#invoiceNo').val();
	gfn_callAjax(obj,"/erp/scm/work/partners/orderDelivery/inboundDetailR/invoiceDelNo",fn_searchCB);
};

function fn_searchCB(data){
	var obj = {};
	if(data != ''){
		obj.invoiceNo = data[0].invoicedelNo;
	}else{
		obj.invoiceNo = $('#invoiceNo').val();
	}
	gfn_callAjaxForForm("frmMain",obj,"/erp/scm/work/partners/orderDelivery/inboundDetailR/formSearch");
	gfn_callAjaxForGridR(gridMain,obj,"/erp/scm/work/partners/orderDelivery/inboundDetailR/gridMainSearch",subLayout.cells("b"));
}

function fn_exit(){
	var tabId = '1000000026';
	mainTabbar.tabs(tabId).close();	
};

</script>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">송장번호</label>
				<input name="invoiceNo" id="invoiceNo" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
</div>
<div id="bootContainer2">
  <form name="frmMain" id="frmMain">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">송장종류</label>
				<input name="invoicebc" id="invoicebc" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
				<input name="invoiceNm" id="invoiceNm" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">발주서번호</label>
				<input name="poNo" id="poNo" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">입하현장(입고)</label>
				<input name="siteCd" id="siteCd" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
				<input name="siteDs" id="siteDs" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">회계마감일자</label>
				<input name="accountDt" id="accountDt" type="text" value="" class="inputbox1 format_date" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">출하현장(출고)</label>
				<input name="siteoutCd" id="siteoutCd" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
				<input name="siteoutDs" id="siteoutDs" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">발행일자</label>
				<input name="invoiceDt" id="invoiceDt" type="text" value="" class="inputbox1 format_date" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
    <div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">거래처코드</label>
				<input name="custCd" id="custCd" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
				<input name="custDs" id="custDs" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">전표번호</label>
				<input name="slipNo" id="slipNo" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title2">작성자</label>
				<input name="id" id="id" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
				<input name="nm" id="nm" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
		<div class="left">
			<div class="ml50">
				<label class="title2">삭제송장번호</label>
				<input name="invoicedelNo" id="invoicedelNo" type="text" value="" class="inputbox1" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>
	</div>
  </form>	
</div>
<div id="container"></div>