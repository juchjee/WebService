<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
var layout, toolbar, subLayout
var gridMain;
var calMain, combo01;
var PscrnParm = parent.scrnParm;
var mainTabbar = parent.mainTabbar;
var ActTabId = parent.ActTabId;    
$(document).ready(function(){
	Ubi.setContainer(1,[1,2,3,5,6],"1C"); //결재기준등록
	
	layout = Ubi.getLayout();
    toolbar = Ubi.getToolbar();
    subLayout = Ubi.getSubLayout(); 
    
    layout.cells("b").attachObject("bootContainer");
	
    gridMain = new dxGrid(subLayout.cells("a"),false);
    gridMain.addHeader({name:"No",     colId:"no",       width:"50", align:"center",  type:"cntr"});
    gridMain.addHeader({name:"구분",    colId:"kind",     width:"80", align:"center",  type:"combo"});
    gridMain.addHeader({name:"결재구분", colId:"settKind", width:"70", align:"center",  type:"combo"});
    gridMain.addHeader({name:"사번",    colId:"perNo",    width:"80", align:"left",    type:"ro"});
    gridMain.addHeader({name:"성명",    colId:"perNm",    width:"70", align:"left",    type:"ro"});
    gridMain.addHeader({name:"비고",    colId:"rmk",     width:"150", align:"left",    type:"ed"});
    gridMain.setUserData("","pk","");
    gridMain.dxObj.enableHeaderMenu("false");
    gridMain.init();
    gridMain.cs_setColumnHidden(["siteCd","custCd","cnt"]);
    gridMain.attachEvent("onRowDblClicked",doOnRowDblClicked);
    
    g_dxRules = { kind : [r_notEmpty], settKind : [r_notEmpty], perNo : [r_notEmpty]};

    combo01 =gridMain.getColumnCombo(gridMain.getColIndexById("kind"));
    combo02 =gridMain.getColumnCombo(gridMain.getColIndexById("settKind"));
    
    gfn_single_comboLoad(combo01,["10","20"],["일일출역표","공사일보"],2);
    gfn_single_comboLoad(combo02,["10","20","30","40"],["담당","공사","공무","소장"],4);
    
    combo01.attachEvent("onClose", function(){
    	var kindFlag = true;
        var kindVal = combo01.getSelectedValue();
        var rowIdx = gridMain.getSelectedRowIndex();
        var settKindVal = gridMain.setCells2(rowIdx,gridMain.getColIndexById("settKind")).getValue();
        if(settKindVal == '20' || settKindVal == '30'|| settKindVal == '40'){
        	for(var i=0;i<gridMain.getRowsNum();i++){
        		var kind = gridMain.setCells2(i,gridMain.getColIndexById("kind")).getValue();
                   if(kind == '일일출역표'){
                	   kind = '10';
                   }else if(kind == '공사일보'){
                	   kind = '20';
                   }
            	var settKind = gridMain.setCells2(i,gridMain.getColIndexById("settKind")).getValue();
            	if(settKind == '담당'){
            		settKind = '10';
                }else if(settKind == '공사'){
                	settKind = '20';
                }else if(settKind == '공무'){
                	settKind = '30';
                }else if(settKind == '소장'){
                	settKind = '40';
                }
            	if(i != rowIdx && kindVal == kind && settKindVal == settKind){
            		kindFlag = false;
            		break;
            	}
            };
        }
        if(!kindFlag){
        	dhtmlx.alert("공무,공사,소장은 한명씩 등록 가능합니다.");
        	gridMain.setCells2(rowIdx,gridMain.getColIndexById("settKind")).setValue('');
        }
    });
    
    combo02.attachEvent("onClose", function(){
    	var kindFlag = true;
        var settKindVal = combo02.getSelectedValue();
        var rowIdx = gridMain.getSelectedRowIndex();
        var kindVal = gridMain.setCells2(rowIdx,gridMain.getColIndexById("kind")).getValue();
        if(settKindVal == '20' || settKindVal == '30'|| settKindVal == '40'){
        	for(var i=0;i<gridMain.getRowsNum();i++){
        		var kind = gridMain.setCells2(i,gridMain.getColIndexById("kind")).getValue();
                if(kind == '일일출역표'){
             	   kind = '10';
                }else if(kind == '공사일보'){
             	   kind = '20';
                }
         	    var settKind = gridMain.setCells2(i,gridMain.getColIndexById("settKind")).getValue();
         	    if(settKind == '담당'){
         		   settKind = '10';
                 }else if(settKind == '공사'){
             	   settKind = '20';
                 }else if(settKind == '공무'){
             	   settKind = '30';
                 }else if(settKind == '소장'){
             	   settKind = '40';
                 }
            	if(i != rowIdx && kindVal == kind && settKindVal == settKind){
            		kindFlag = false;
            		break;
            	}
            };
        }
        if(!kindFlag){
        	dhtmlx.alert("공무,공사,소장은 한명씩 등록 가능합니다.");
        	gridMain.setCells2(rowIdx,gridMain.getColIndexById("kind")).setValue('');
        }
    });
    
    fn_search();
});
function doOnRowDblClicked(rId,cInd){
	var cnt = gridMain.setCells(rId,gridMain.getColIndexById("cnt")).getValue();
    if(cInd == 3 && cnt == '0'){
    	gfn_load_pop('w1','comm/perNmPOP',[$('#siteCd').val(),'',"perNm"]);
    };	
};

function fn_search(){
	var obj={};
	obj.siteCd = $('#siteCd').val();
	gfn_callAjaxForGrid(gridMain,obj,"gridMainSearch",subLayout.cells("a"),fn_searchCB);
};

function fn_searchCB(data){
	for(var i=0;i<gridMain.getRowsNum();i++){
		gridMain.setCellExcellType(gridMain.getRowId(i),gridMain.getColIndexById("kind"),"ro");
		gridMain.setCellExcellType(gridMain.getRowId(i),gridMain.getColIndexById("settKind"),"ro");
		gridMain.setCells2(i,gridMain.getColIndexById("cnt")).setValue('1');
		var kind = gridMain.setCells2(i,gridMain.getColIndexById("kind")).getValue();
		var settKind = gridMain.setCells2(i,gridMain.getColIndexById("settKind")).getValue();
		if(kind == '10'){
			gridMain.setCells2(i,gridMain.getColIndexById("kind")).setValue('일일출역표');
		}else{
			gridMain.setCells2(i,gridMain.getColIndexById("kind")).setValue('공사일보');
		}
		if(settKind == '10'){
			gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('담당');
		}else if(settKind == '20'){
			gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('공사');
		}else if(settKind == '30'){
			gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('공무');
		}else{
			gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('소장');
		}
	}
};

function fn_new(){
   location.replace(location.pathname);	
};

function fn_save(){
	for(var i=0;i<gridMain.getRowsNum();i++){
		cudKey = gridMain.setCells2(i,gridMain.getColIndexById("cudKey")).getValue();
		if(cudKey == ''){
			gridMain.setCells2(i,gridMain.getColIndexById("cudKey")).setValue('UPDATE');
		}
		var kind = gridMain.setCells2(i,gridMain.getColIndexById("kind")).getValue();
		var settKind = gridMain.setCells2(i,gridMain.getColIndexById("settKind")).getValue();
		if(kind == '일일출역표'){
			gridMain.setCells2(i,gridMain.getColIndexById("kind")).setValue('10');
		}else if(kind == '공사일보'){
			gridMain.setCells2(i,gridMain.getColIndexById("kind")).setValue('20');
		}
		if(settKind == '담당'){
			gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('10');
		}else if(settKind == '공사'){
			gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('20');
		}else if(settKind == '공무'){
			gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('30');
		}else if(settKind == '소장'){
			gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('40');
		}
	};
	var jsonStr = gridMain.getJsonUpdated();
	  if (jsonStr == null || jsonStr.length <= 0){
		  for(var i=0;i<gridMain.getRowsNum()-1;i++){
				var kind = gridMain.setCells2(i,gridMain.getColIndexById("kind")).getValue();
				var settKind = gridMain.setCells2(i,gridMain.getColIndexById("settKind")).getValue();
				if(kind == '10'){
					gridMain.setCells2(i,gridMain.getColIndexById("kind")).setValue('일일출역표');
				}else{
					gridMain.setCells2(i,gridMain.getColIndexById("kind")).setValue('공사일보');
				}
				if(settKind == '10'){
					gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('담당');
				}else if(settKind == '20'){
					gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('공사');
				}else if(settKind == '30'){
					gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('공무');
				}else{
					gridMain.setCells2(i,gridMain.getColIndexById("settKind")).setValue('소장');
				}
			}
		  return true; 
	  }
	    $("#jsonData").val(jsonStr);
	  var params = $("#pform").serialize();  
	  gfn_callAjaxComm(params,"mainSave",fn_search);	
};

function fn_add(){	
	var siteCd = $('#siteNm').val();
	if(siteCd == ''){
		dhtmlx.alert("현장코드를 입력하세요");
		return true;
	}else{
	   var totalColNum = gridMain.getColumnCount();
	   var data = new Array(totalColNum);
	   var siteCdColIdx   = gridMain.getColIndexById('siteCd');
	   var cudKeyColIdx   = gridMain.getColIndexById('cudKey');
	   var cntColIdx      = gridMain.getColIndexById('cnt');
	   data[siteCdColIdx]   = $('#siteCd').val();
	   data[cudKeyColIdx] = 'INSERT';
	   data[cntColIdx] = '0';
	 	gridMain.addRow(data);
	} 
};

function fn_onClosePop(pName,data){
	 if(pName == "siteCd"){
		 $('#siteCd').val(data[0].siteCd);
		 $('#siteNm').val(data[0].siteNm);
		 $('#siteCd').focus();
		 fn_search();
	 }
	 if(pName == "perNm"){
		 var rowIdx = gridMain.getSelectedRowIndex();
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("perNo")).setValue(data[0].perNo);
		 gridMain.setCells2(rowIdx,gridMain.getColIndexById("perNm")).setValue(data[0].perNm);
	 }
};

function fn_exit(){
	var exitVal = cs_close_event([gridMain]);
	if(exitVal){
		mainTabbar.tabs(ActTabId).close();	
	}else{
		if(MsgManager.confirmMsg("WRN012")){
			mainTabbar.tabs(ActTabId).close();	
		}else{
			return true;
		}
	} 
};
</script>
<form id="pform" name="pform" method="post">
    <input type="hidden" id="jsonData" name="jsonData" />
</form>
<div id="bootContainer">
	<div class="listHeader">
	    <input type="hidden" name="dummy" id="dummy">
		<div class="left">
			<div class="ml30">
				<label class="title1">현장코드</label>
				<input name="siteCd" id="siteCd" type="text" value="${siteCd}"  class="searchCode">
				<input name="siteNm" id="siteNm" type="text" value="${siteNm}"  class="inputbox3" readonly="readonly" onkeydown="event.preventDefault()">
			</div>
		</div>	
	</div>
</div>
<div id="container"></div>