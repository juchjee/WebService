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
	Ubi.setContainer(2,[1,8],"1C");
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
	
	layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"입고번호",   colId:"inNo",      width:"120",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"순번",      colId:"inSq",      width:"50",   align:"center", type:"ron"});
    gridMain.addHeader({name:"입고일자",   colId:"inDt",      width:"80",   align:"center", type:"ro"});
    gridMain.addHeader({name:"거래처코드",  colId:"custCd",    width:"70",  align:"left",  type:"ro"});
    gridMain.addHeader({name:"거래처명",   colId:"custNm",    width:"150",  align:"left",  type:"ro"});
    gridMain.addHeader({name:"품목코드",   colId:"itmCd",     width:"70",  align:"left",  type:"ro"});
    gridMain.addHeader({name:"품목명",    colId:"itmNm",     width:"180",  align:"left",  type:"ro"});
    gridMain.addHeader({name:"규격",     colId:"spec",      width:"180",  align:"left",  type:"ro"});
    gridMain.addHeader({name:"품목계정",  colId:"itmBcNm",   width:"60",  align:"left",  type:"ro"});
    gridMain.addHeader({name:"단위",     colId:"umBcNm",    width:"50",  align:"left",  type:"ro"});
    gridMain.addHeader({name:"입고수량",  colId:"umQty",     width:"70",   align:"right", type:"ron"});
    gridMain.addHeader({name:"입고단가",  colId:"inUp",      width:"70",   align:"right", type:"ron"});
    gridMain.addHeader({name:"입고금액",  colId:"inAmt",     width:"80",   align:"right", type:"ron"});
    gridMain.addHeader({name:"운반단가",  colId:"etcAmt",    width:"70",   align:"right", type:"ron"});
    gridMain.addHeader({name:"운반비용",  colId:"etcTotAmt", width:"80",   align:"right", type:"ron"});
    gridMain.addHeader({name:"상차비용",  colId:"carAmt",    width:"60",   align:"right", type:"ron"});
    gridMain.addHeader({name:"검수자",   colId:"qcEmp",     width:"60",   align:"left",  type:"ro"});
    gridMain.addHeader({name:"검수자명",  colId:"qcNm",      width:"70",   align:"left",  type:"ro"});
    gridMain.addHeader({name:"등록자",   colId:"mnm",       width:"60",   align:"left",  type:"ro"});
    gridMain.addHeader({name:"발주번호",  colId:"poNo",     width:"120",  align:"left",   type:"ro"});
    gridMain.addHeader({name:"발주순번",  colId:"poSq",     width:"50",   align:"center", type:"ron"});
    gridMain.addHeader({name:"비고",     colId:"rmks",     width:"100",  align:"left",   type:"ro"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.setUserData("","@inDt","format_date");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setNumberFormat(["umQty","inUp","inAmt","etcAmt","etcTotAmt","carAmt"]); 
    
    //gfn_facCd_comboLoad("facCd","facCdAllSearch"); 기존에 전체조회
    gfn_facCd_comboLoad("facCd","facCdSearch"); //현재 해당 커래처코드만
    
    calMain = new dhtmlXCalendarObject([{input:"stInDt",button:"calpicker1"},
	                                    {input:"edInDt",button:"calpicker2"}]);
	calMain.loadUserLanguage("ko");
	calMain.hideTime();
	var t = dateformat(new Date());
	byId("stInDt").value = t;
	byId("edInDt").value = t;

});
function fn_search(){
	var obj = {};
	obj.facCd = $('#facCd').val();
	obj.stInDt = searchDate($('#stInDt').val());
	obj.edInDt = searchDate($('#edInDt').val());
	gfn_callAjaxForGridR(gridMain,obj,"gridMainSearch",subLayout.cells("a"));
};

function fn_exit(){
	mainTabbar.tabs(ActTabId).close();	
};
</script>
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="ml30">
				<label class="title1">기간</label>
				<input name="stInDt" id="stInDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker1" name="calpicker1" class="calicon inputCal" onclick="setSens(1,'edInDt', 'max')"> ~ 
				<input name="edInDt" id="edInDt" type="text" value="" placeholder="" class="searchDate">
				<input type="button" id="calpicker2" name="calpicker2" class="calicon inputCal" onclick="setSens(1,'stInDt', 'min')">
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