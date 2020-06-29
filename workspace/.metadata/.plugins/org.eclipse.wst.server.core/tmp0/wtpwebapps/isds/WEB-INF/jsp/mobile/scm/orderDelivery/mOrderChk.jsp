<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style>
.dhx_loading_overlay{
	width:100%;
	height:100%;
	background-color:#D6D6D6;
	opacity:0.5;
	background-image:url(/component/dxTouch/codebase/imgs/loading.png);
	background-repeat:no-repeat;
	background-position:center;
}
.dhx_form{ 
background: #FFFFFF;
};
#gridMain{
font-size: 5px;
};
</style>
<script type="text/javascript">
var cnt = 0;
var gridData;
var w = $(window).width();
var h = $(window).height();
var h = h-120;
var date = dateformat(new Date());
var form = { id: 'app', view: 'layout',
		rows: [
				{ view: 'layout', type: 'wide',
					rows: [
						{   type: "clean", height: 45,
					        cols: [   
					          { view: "button", type: "round", label: "조회", click: "fn_search();" }, 
					          { view: "button", type: "round", label: "저장", click: "fn_save();" }
						    ]
					    },
						{ view: 'form', height : 90,
							elements: [
								{ view:"combo", label:'공장코드', id: "facCd",select:true,datatype:'json',url:'/mobile/scm/orderDelivery/MOrderChk/combo'},
								{ view:'text',  label:'발주일자', type:'date', id:'poDt',value:date}
							], id: 'frmMain'
						},
						{ view: 'grid', datatype: 'json',id:'gridMain', select:false, scroll:"xy",height : h,
							fields: [
								{ width: 50, label: '확인', template: function(obj){
									var checkTag = "<input type='checkbox' id='"+cnt+"' class='inputChk' style='margin-top:40%;'>";
									cnt++;
									return checkTag;
								}, type: 'custom', align: 'center', id: 'chk'
								},     
								{ width: (w/8)*3, label: '품명', template: '#itmNm#', type: 'custom', align: 'left', id: 'itmNm'
								},
								{ width: (w/8)*3, label: '규격', template: '#spec#', type: 'custom', align: 'left', id: 'spec'
								},
								{ width: w/8, label: '단위', template: '#umBcNm#', type: 'custom', align: 'center', id: 'umBcNm'
								},
								{ width: (w/8)*2, label: '수량', template: '#poQty#', type: 'custom', align: 'right', id: 'poQty'
								},
								{ width: (w/8)*3, label: '납기일자', template: function(obj){
									var dlvDt = obj.dlvDt.substring(0,4)+"/"+obj.dlvDt.substring(4,6)+"/"+obj.dlvDt.substring(6,8);
									return dlvDt;
								}, type: 'custom', align: 'center',
									sort: { by: '#dlvDt#', dir: 'asc', as: 'string'}, id: 'dlvDt'
								}
							], header: true
						}
					], id: 'orderChk'
				}
			]
		}
dhx.ready(function() {
	dhx.ui.fullScreen();
    dhx.ui(form);    
});

function fn_search(){
	var dw = $(window).width();
	if(w != dw){
		location.replace(location.pathname);
	}
	var gridMain = $$('gridMain');
	dhx.extend(gridMain, dhx.OverlayBox);
	gridMain.showOverlay();
	var obj = {};
	obj.facCd = $$('facCd').wg;
	obj.poDt = searchDate($$('poDt').getValue(),"-");
	obj.outsCon = 'michk';
	
	mobileAjax("/mobile/scm/orderDelivery/selMOrderChk",obj,function(data){
		gridData = data;
		gridMain.clearAll()
		gridMain.define('datatype', 'json');
		gridMain.define('data', data);
		gridMain.adjust();
		gridMain.define('scroll', 'xy');
	});	
}

function fn_save(){
	var jsonStr = "";
	var arr = [];
	for(var i=0;i<gridData.length;i++){
		var chk = $('#'+i).is(":checked");
        if(chk){
        	arr.push(gridData[i]);
        }
	}
	jsonStr = JSON.stringify(arr);
	$('#jsonData').val(jsonStr);
	var params = $("#pForm").serialize();  
	mobileAjax("/mobile/scm/orderDelivery/prcsMOrderChk",params,fn_saveCB);	
};
function fn_saveCB(data){
	dhx.alert(fn_alert('저장되었습니다.'));
	cnt = 0;
	fn_search();
}
</script>
<form id="pForm" name="pForm">
    <input type="hidden" name="jsonData" id="jsonData">
</form>