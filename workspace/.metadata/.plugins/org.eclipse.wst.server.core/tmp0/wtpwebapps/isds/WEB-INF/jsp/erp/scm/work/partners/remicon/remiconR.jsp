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
	Ubi.setContainer(2,[1,8],"2E"); //레미콘 의뢰 현황
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout();  
	
	layout.cells("b").attachObject("bootContainer");
	
	subLayout.cells("a").showHeader()
    subLayout.cells("a").setText("조회결과")
    gridMain = new dxGrid(subLayout.cells("a"),false);
	gridMain.addHeader({name:"현장코드",    colId:"siteCd",  width:"60",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"현장명",      colId:"siteDs",  width:"220", align:"left",   type:"ro"});
    gridMain.addHeader({name:"거래처명",    colId:"custDs",   width:"220", align:"left",   type:"ro"});
    gridMain.addHeader({name:"품목코드",    colId:"itemCd",   width:"70", align:"left",   type:"ro"});
    gridMain.addHeader({name:"품목명(한글)", colId:"kitemDs",  width:"80", align:"left",   type:"ro"});
    gridMain.addHeader({name:"규격",       colId:"itemSz",   width:"80", align:"left",   type:"ro"});
    gridMain.addHeader({name:"단위",       colId:"itemUt",   width:"60",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"비목",       colId:"itemUc",   width:"60",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"청구수량",    colId:"itemQn",    width:"90",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"청구단가",    colId:"itemUp",    width:"90",  align:"right",  type:"ron"});
    gridMain.addHeader({name:"부가세",     colId:"itemVat",   width:"90",   align:"right", type:"ron"});
    gridMain.addHeader({name:"합계",       colId:"itemSum",   width:"110", align:"right",  type:"ron"});
    gridMain.addHeader({name:"요청상태",    colId:"inputNm",   width:"80",  align:"center", type:"ro"});
    gridMain.addHeader({name:"요청일자",    colId:"invoiceDt", width:"80",  align:"center", type:"ro"});
    gridMain.addHeader({name:"접수수량",    colId:"inputQn",   width:"80",  align:"right",  type:"ron"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@invoiceDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["poNo","mrNo","inqNo","invoiceNo","custCd","sqNo","costCd","itemDs","inputBc","scmYn","deliSeq","costId"]);
    gridMain.cs_setNumberFormat(["itemQn","itemUp","itemVat","itemSum","inputQn"],"0,000");
    gridMain.attachEvent("onRowSelect",doOnRowSelect);
    
    subLayout.cells("b").showHeader()
    subLayout.cells("b").setText("입출현황")
    gridSub = new dxGrid(subLayout.cells("b"),false);
    gridSub.addHeader({name:"품목명(한글)",  colId:"kitemDs",    width:"80", align:"left",   type:"ro"});
    gridSub.addHeader({name:"규격",        colId:"itemSz",    width:"80", align:"left",   type:"ro"});
    gridSub.addHeader({name:"단위",        colId:"itemUt",    width:"60",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"비목",        colId:"itemUc",     width:"60",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"실행수량",     colId:"itemQn",     width:"70",  align:"right",  type:"ron"});
    gridSub.addHeader({name:"입/출",       colId:"inoutCd",    width:"60",  align:"center", type:"ro"});
    gridSub.addHeader({name:"발주수량",     colId:"orderQn",    width:"80",  align:"right",   type:"ron"});
    gridSub.addHeader({name:"비고",        colId:"rmks",       width:"80",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"RFID_NO",    colId:"rfidNo",    width:"80",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"RFID순번",    colId:"rfidsqNo",   width:"60",  align:"center",   type:"ro"});
    gridSub.addHeader({name:"거래처코드",    colId:"custCd",    width:"80",   align:"left",   type:"ro"});
    gridSub.addHeader({name:"거래처명",     colId:"custDs",    width:"130", align:"left",   type:"ro"});
    gridSub.addHeader({name:"현황",       colId:"instate",    width:"70",   align:"center", type:"ro"});
    gridSub.addHeader({name:"차량번호",     colId:"carNo",     width:"70",   align:"center", type:"ro"});
    gridSub.addHeader({name:"비고",        colId:"rmks2",     width:"100",  align:"left",   type:"ro"});
    gridSub.addHeader({name:"입출일자",     colId:"dateinDt",  width:"140",   align:"center", type:"ro"});
    gridSub.addHeader({name:"입/출예정일자", colId:"outputDt",  width:"80",   align:"center", type:"ro"});
    gridSub.addHeader({name:"정산여부",     colId:"jungsanYn", width:"60",    align:"center", type:"ro"});
    gridSub.setUserData("","pk","");
    gridSub.dxObj.enableHeaderMenu("false");
    gridSub.init();
    gridSub.cs_setColumnHidden(["siteCd","siteDs","itemCd","invoiceDt","sqNo","poNo","mrNo","inqNo","invoiceNo",
                                "invoicechkNo"]);
  
    $('#moveBtn').click(function(){
 		movePage();
 	});
    
    calMain = new dhtmlXCalendarObject([{input:"stInvoiceDt",button:"calpicker1"},{input:"edInvoiceDt",button:"calpicker2"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var nowDate = new Date();
	var legSetDate = new Date();
	var lastSetDate = new Date(nowDate.getYear(),nowDate.getMonth()+1,"");
	var lastDay = lastSetDate.getDate();
	
	var legDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth() + 1)+'/'+"01";
	var lastDate = legSetDate.getFullYear()+'/'+fn_month(legSetDate.getMonth() + 1)+'/'+lastDay;
	
	$('#stInvoiceDt').val(legDate);
	$('#edInvoiceDt').val(lastDate);
	
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

function doOnRowSelect(id,ind){
	var obj = {};
	 obj.siteCd = gridMain.setCells(id,gridMain.getColIndexById("siteCd")).getValue();
	obj.stInvoiceDt = searchDate($('#stInvoiceDt').val());
    obj.edInvoiceDt = searchDate($('#edInvoiceDt').val());
	obj.invoiceNo = gridMain.setCells(id,gridMain.getColIndexById("invoiceNo")).getValue();
	obj.custCd = gridMain.setCells(id,gridMain.getColIndexById("custCd")).getValue();
	obj.poNo = gridMain.setCells(id,gridMain.getColIndexById("poNo")).getValue();
	obj.mrNo = gridMain.setCells(id,gridMain.getColIndexById("mrNo")).getValue();
	obj.inqNo = gridMain.setCells(id,gridMain.getColIndexById("inqNo")).getValue();
	obj.sqNo = gridMain.setCells(id,gridMain.getColIndexById("sqNo")).getValue();
	obj.costId = gridMain.setCells(id,gridMain.getColIndexById("costId")).getValue();
	obj.deliSeq = gridMain.setCells(id,gridMain.getColIndexById("deliSeq")).getValue();
	
	gfn_callAjaxForGrid(gridSub,obj,"gridSubSearch",subLayout.cells("b"),fn_subSearchCB);
};

function fn_subSearchCB(data){
	if(data != ''){
		for(var i=0;i<gridSub.getRowsNum();i++){
			var inputNm = gridSub.setCells2(i,gridSub.getColIndexById("instate")).getValue();
			if(inputNm == "입고완료" || inputNm == "출고완료"){
				gridSub.dxObj.cells(gridSub.getRowId(i),gridSub.getColIndexById("instate")).setBgColor('#FFE08C');  
			}else if(inputNm == "입고대기" || inputNm == "출고대기"){
				gridSub.dxObj.cells(gridSub.getRowId(i),gridSub.getColIndexById("instate")).setBgColor('#B2CCFF');  
			}
		}
	}
}

function movePage(){
	var rId  = gridMain.getSelectedRowId();
	var openFlag = gridMain.setCells(rId,gridMain.getColIndexById("inputNm")).getValue();
	if(openFlag == "접수대기" || openFlag == "접수완료"){
		moveFilePage(rId);
	}else{
		return;
	}
};

function moveFilePage(rId){
	var cFlag = true;
	var preId = "8000000011";
    var uri = "erp/scm/work/partners/remicon/remiconS";
	var custCd = gridMain.setCells(rId,gridMain.getColIndexById("custCd")).getValue();
	var custDs = gridMain.setCells(rId,gridMain.getColIndexById("custDs")).getValue();
	var invoiceNo = gridMain.setCells(rId,gridMain.getColIndexById("invoiceNo")).getValue();
	var scmYn = gridMain.setCells(rId,gridMain.getColIndexById("scmYn")).getValue();
	var siteCd = gridMain.setCells(rId,gridMain.getColIndexById("siteCd")).getValue();
	var mrNo = gridMain.setCells(rId,gridMain.getColIndexById("mrNo")).getValue();
	var inqNo = gridMain.setCells(rId,gridMain.getColIndexById("inqNo")).getValue();
	var poNo = gridMain.setCells(rId,gridMain.getColIndexById("poNo")).getValue();
	var sqNo = gridMain.setCells(rId,gridMain.getColIndexById("sqNo")).getValue();
	var costId = gridMain.setCells(rId,gridMain.getColIndexById("costId")).getValue();
	var deliSeq = gridMain.setCells(rId,gridMain.getColIndexById("deliSeq")).getValue();
	var outputDt = gridMain.setCells(rId,gridMain.getColIndexById("invoiceDt")).getValue();
	
	
	var param = "?custCd="+custCd+"&custDs="+custDs+"&invoiceNo="+invoiceNo+"&scmYn="+scmYn+"&outputDt="+outputDt+
			     "&siteCd="+siteCd+"&mrNo="+mrNo+"&inqNo="+inqNo+"&poNo="+poNo+"&sqNo="+sqNo+"&costId="+costId+"&deliSeq="+deliSeq;
	var ids = mainTabbar.getAllTabs();

	for(var i=0;i<ids.length;i++){
		if(ids[i] == preId){
			if(MsgManager.confirmMsg("INF006")) { 
				mainTabbar.tabs(preId).detachObject(true);
				mainTabbar.tabs(preId).attachURL("/"+uri+".do"+param);
				mainTabbar.tabs(preId).setActive();
				cFlag = false;
				break;
			}else{
				cFlag = false;
				return;
			}
		}
	}
	
	if(cFlag){
		mainTabbar.addTab(preId, "납품등록(RFID)", null, null, true, true);
		mainTabbar.tabs(preId).attachURL("/"+uri+".do"+param);		
	}
};

function fn_search(){
	var obj = {};
	obj.inputBc = $('#inputBc').val();
	obj.stInvoiceDt = searchDate($('#stInvoiceDt').val());
	obj.edInvoiceDt = searchDate($('#edInvoiceDt').val());
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
}

function fn_searchCB(data){
	if(data != ''){
		for(var i=0;i<gridMain.getRowsNum();i++){
			var inputNm = gridMain.setCells2(i,gridMain.getColIndexById("inputNm")).getValue();
			if(inputNm == "접수완료"){
				gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("inputNm")).setBgColor('#FFE08C');  
			}else if(inputNm == "접수대기"){
				gridMain.dxObj.cells(gridMain.getRowId(i),gridMain.getColIndexById("inputNm")).setBgColor('#B2CCFF');  
			}
		}
		gridMain.selectRow(0,true,true,true);
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
				<label class="title1">요청일자</label>
				<input name="stInvoiceDt" id="stInvoiceDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'edInvoiceDt', 'max')"> ~ 
				<input name="edInvoiceDt" id="edInvoiceDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'stInvoiceDt', 'min')">
			</div>
		</div>
	</div>
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">요청상태</label>
				<select name="inputBc" id="inputBc" class=searchBox>
				  <option value="%">전체</option>
				  <option value="01">접수대기</option>
				  <option value="02">접수취소</option>
				  <option value="03">접수완료</option>
				</select>
			</div>
		</div>
		<div class="left">
			<div class="ml10">
				<button name="moveBtn" id="moveBtn" value="" class="btn4">납품등록(RFID)</button>
			</div>
		</div>
	</div>
</div>
<div id="container"></div>