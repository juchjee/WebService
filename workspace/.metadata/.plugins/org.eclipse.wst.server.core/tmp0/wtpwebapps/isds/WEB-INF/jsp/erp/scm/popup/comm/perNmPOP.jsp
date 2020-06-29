<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout,toolbar,subLayout;
var gridMain;
var toolbar;
var config={
		title:"사원검색",
		id:"siteCd",
		width:"540",
		height:"500"
	}
$(document).ready(function(){
	Ubi.setContainer(1,[1],"1C");
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
    
    gridMain = new dxGrid(subLayout.cells("a"), false);
    gridMain.addHeader({name:"현장코드", colId:"siteCd", width:"140", align:"center", type:"ro"});
    gridMain.addHeader({name:"근무자구분",  colId:"perKindNm", width:"80", align:"center", type:"ro"});
	gridMain.addHeader({name:"사원번호",  colId:"perNo", width:"140", align:"center", type:"ro"});
	gridMain.addHeader({name:"사원명",  colId:"perNm", width:"140", align:"center", type:"ro"});
	gridMain.setUserData("","pk","");
	gridMain.dxObj.enableHeaderMenu("false");
	gridMain.init();
	gridMain.cs_setColumnHidden(["perKind"]);
	init_search();
	
	$("#workPerNm").keypress(function(e){
    	if(e.keyCode == 13 && e.target.id == 'workPerNm'){
    		fn_searchPerNm();
    	}
    });
    
    $('#selPerNmBtn').click(function(e){
    	if(e.target.id == 'selPerNmBtn'){
    		fn_searchPerNm();
    	}
    });
});
function init_search(){
	$('#siteCd').val(PARAM_INFO.innerName);
	$('#perNm').val(PARAM_INFO.kind);
	 var obj = {}; 
	 obj.siteCd = $('#siteCd').val();
	 obj.perNm =  $('#perNm').val();
	loadGridMain(obj); 
};

 function fn_search(){
	 var obj = {}; 
	 obj.siteCd = $('#siteCd').val();
	 obj.perNm =  $('#perNm').val();
	loadGridMain(obj);  
};
 
 function loadGridMain(obj){
	 gfn_callAjaxForGrid(gridMain,obj,"/erp/scm/work/partners/dailyWork/perNmSearch",subLayout.cells("a"),fn_loadGridListCodeCB);
 };
 
 function fn_loadGridListCodeCB(data) {
		if(data.length<1){
			parent.MsgManager.alertMsg("WRN011");
			parent.dhxWins.window("w1").close();
		}else{
		   gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);	
		}
	};

function doOnRowDblClicked(rId,cInd){
	  var cell = cInd;
	  var perNm = gridMain.setCells(rId,3).getValue();
	  var perNo = gridMain.setCells(rId,2).getValue();
	  var perKindNm = gridMain.setCells(rId,1).getValue();
	  var perKind = gridMain.setCells(rId,gridMain.getColIndexById("perKind")).getValue();
	  var arr = [{"perNm":perNm,"perNo":perNo,"perKindNm":perKindNm,"perKind":perKind}];
	  parent.fn_onClosePop(PARAM_INFO.gubn,arr);  
	  parent.dhxWins.window("w1").close();
};

function fn_searchPerNm(){
	var perNm = $('#workPerNm').val();
	if(perNm == ''){
		return true;
	}else{
		var cnt = 0;
		var selectRowIdx = gridMain.getSelectedRowIndex();
		if(selectRowIdx == -1){
			selectRowIdx = 0;
		}
		for(var i=selectRowIdx+1;i<gridMain.getRowsNum();i++){
			var gridPerNm = gridMain.setCells2(i,gridMain.getColIndexById("perNm")).getValue();
			if(gridPerNm.indexOf(perNm) > -1){
				gridMain.selectRow(i,true, true, true);
				cnt++;
				break;
			}
		}
		if(cnt == 0){
			for(var i=0;i<gridMain.getRowsNum();i++){
				var gridPerNm = gridMain.setCells2(i,gridMain.getColIndexById("perNm")).getValue();
				if(gridPerNm.indexOf(perNm) > -1){
					gridMain.selectRow(i,true, true, true);
					break;
				}
			}
		}
	}
};
</script>
<input name="perNm" id="perNm" type="hidden" >
<input name="siteCd" id="siteCd" type="hidden" >
<div id="bootContainer">
	<div class="listHeader">
		<div class="left">
			<div class="mlZero">
				<label class="title1">근무자</label>
				<input name="workPerNm" id="workPerNm" type="text" value=""  class="searchCode">
			</div>
		</div>
		<div class="left">
			<div class="ml10">
			    <button name="selPerNmBtn" id="selPerNmBtn" value="" class="btn3">근무자찾기</button>
			</div>
		</div>		
	</div>
</div>
<div id="container"></div>