<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"출근자",
		id:"perNum",
		width:"630",
		height:"500"
	} 
$(document).ready(function(){
	Ubi.setContainer(1,[1],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"#master_checkbox", colId:"chk",    width:"50",  align:"center", type:"ch"});
    gridMain.addHeader({name:"근무자번호",          colId:"perNo",  width:"140", align:"center", type:"ro"});
	gridMain.addHeader({name:"성명",              colId:"perNm",  width:"140", align:"center", type:"ro"});
	gridMain.addHeader({name:"주민번호",           colId:"regiNo", width:"140", align:"center", type:"ro"});
	gridMain.addHeader({name:"외국인등록번호",       colId:"foreNo", width:"140", align:"center", type:"ro"});
	gridMain.setUserData("","pk","");
	gridMain.dxObj.setUserData("","@regiNo","format_jumin");
    gridMain.dxObj.setUserData("","@foreNo","format_foreNo");
    gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	
	$("#confrimBtn").click(function(){
		fn_chkPerNum();
	});
	init_search();
});
function init_search(){
	$('#siteCd').val(PARAM_INFO.innerName);
	$('#workDt').val(PARAM_INFO.kind);
	$('#perNo').val(PARAM_INFO.addData);
	
	 var obj = {}; 
	 obj.siteCd =  $('#siteCd').val();
	 obj.workDt =  $('#workDt').val();
	 loadGridMain(obj); 
}
 function fn_search(){
	 var obj = {}; 
	 obj.siteCd =  $('#siteCd').val();
	 obj.workDt =  $('#workDt').val();
	 loadGridMain(obj); 
}
 function loadGridMain(params){
	 gfn_callAjaxForGrid(gridMain,params,"/erp/scm/work/partners/dailyWork/perNumSearch",subLayout.cells("a"),fn_searchCB);
 }
 
 function fn_searchCB(data){
	 if(data != ''){
		 var perNoArr = $('#perNo').val().split(",");
		 for(var i=0;i<data.length;i++){
			for(var j = 0;j<perNoArr.length;j++){
				if(data[i].perNo == perNoArr[j]){
					gridMain.setCells2(i,0).setValue("1");
				}
			} 
		 } 
	 }
 };
 
 function fn_chkPerNum(){
		var perNos= '';
	 var siteCd =  $('#siteCd').val();
	 var workDt =  $('#workDt').val();
	 var rowsNum = gridMain.getRowsNum();
	 var cnt = 0;
	if(rowsNum == 0){
		parent.dhxWins.window("w1").close();
	}else{
		for(var i=0;i<rowsNum;i++){
			var chkVal = gridMain.setCells2(i,0).getValue();
			if(chkVal == 1){
				cnt++;
			}
		}
		for(var i=0;i<gridMain.getRowsNum();i++){
			if(gridMain.setCells2(i,0).getValue() == "1"){
				perNos = perNos + gridMain.setCells2(i,1).getValue()+",";
			}
		}
		
		var totLen = perNos.length;
		perNos = perNos.trim();
		perNos = perNos.substring(0,totLen-1);
		var arr = [{"cnt":cnt,"perNos":perNos}];
		  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
		  parent.dhxWins.window("w1").close();
	}
 };
</script>
<input name="siteCd" id="siteCd" type="hidden" >
<input name="workDt" id="workDt" type="hidden" >
<input name="perNo" id="perNo" type="hidden" >
<div id="bootContainer">
  <form class="form-horizontal" id="frmSearch" name="frmSearch"> 
	<div class="listHeader">
		<div class="left">
			<div class="ml10">
				 <button name="confrimBtn" id="confrimBtn"  class="btn2">확인</button>
			</div>
		</div>
	</div>
  </form>	
</div>
<div id="container"></div>