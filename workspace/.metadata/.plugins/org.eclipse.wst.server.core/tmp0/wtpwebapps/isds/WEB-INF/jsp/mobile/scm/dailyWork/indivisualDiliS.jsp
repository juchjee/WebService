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
};
.dhx_form{
background: #FFFFFF;
};
</style>
<script type="text/javascript">
var w = $(window).width(); 
var date = dateformat(new Date());
var fullDate = new Date();
var hour = fullDate.getHours()+'';
var minute = fullDate.getMinutes();
if(minute <= 9){
	minute = '0'+minute;
}
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
						{ view: 'form', scroll: true, height : 130,
							elements: [
								{ view: 'text', label: '근무일자', id: 'workDt',value:date, readonly:true},
								{ view:'text' , label: '생년월일', type:'date', id:'regiNo'},
								{ view:"combo", label: '현장코드', id: "siteCd",select:true,datatype:'json',url:'/mobile/scm/dailyWork/indivisualDiliS/combo', readonly:true}
								
							], id: 'frmMain'
						},
						
						{ view: 'grid', datatype: 'json',
							fields: [
								{ width: w/3, label: '사번', template: '#perNo#', type: 'custom', align: 'left',
									sort: { by: '#perNo#', dir: 'asc', as: 'string'}, id: 'perNo'
								},
								{ width: w/3, label: '사원명', template: '#perNm#', type: 'custom', align: 'left',
									sort: { by: '#perNm#', dir: 'asc', as: 'string'}, id: 'perNm'
								},
								{ width: w/3, label: '출근시간', template: function(obj){
									var inTime = null;
									if(obj.inTime == null){
										inTime = hour+':'+minute;
									}else{
										inTime = obj.inTime.substring(0,2)+":"+obj.inTime.substring(2,4);
									}
									return "<input type='time' id='"+obj.perNo+"' class='inputTime' value='"+inTime+"' style='width:"+w/3+";height:42px;'>";
								}, type: 'custom', id: 'inTime'
								}
							], select: true, header: true, scroll: true, id: 'gridMain'
						}
					], id: 'container'
				}
			]
		}

var loginView = {
    type: "clean",
    css: "layout",
    rows: [toolbar, {gravity: 1}, { type: "clean", cols: [{ width: 15 }, form, {width: 15}]}, {gravity: 2}]
};
dhx.ready(function() {
	dhx.ui.fullScreen();
    dhx.ui(form); 
    $$("gridMain").attachEvent("onItemClick",function(id,ev,trg){
		$('#gridId').val(id);
	});
});
function fn_search(){
	if($$('regiNo').getValue() == ''){
		dhx.alert(fn_alert('생년월일을 기입하세요'));
		return;
	}else if($$('siteCd').wg == null){
		dhx.alert(fn_alert('현장코드를 기입하세요'));
	}else{
		var gridMain = $$('gridMain');
		dhx.extend(gridMain, dhx.OverlayBox);
		gridMain.showOverlay();
	
		var obj = {};
		obj.workDt = searchDate($$('workDt').wg,"-");
		obj. regiNo = birthDate($$('regiNo').getValue(),"-");
		obj.siteCd = $$('siteCd').wg;
		
		mobileAjax("/mobile/scm/dailyWork/indivisualDiliS/list",obj,function(data){
			gridMain.clearAll();
			gridMain.define('datatype', 'json');
			gridMain.define('data', data);
			gridMain.adjust();
			gridMain.define('scroll', 'x');
			gridMain.refresh();
			gridMain.hideOverlay();
		});
	}
}

function fn_save(){
	var id = $('#gridId').val();
	var inTimeVal = null;
	var menuList = $$('gridMain').item(id);
	if(menuList == null){
		dhx.alert(fn_alert('저장할 데이터가 없습니다.'));
		return;
	}else{
		inTimeVal = $('#'+menuList.perNo).val().split(":").join("");
		var obj = {};
		obj.siteCd = $$('siteCd').wg;
	    obj.perNo = menuList.perNo;
	    obj.workDt = searchDate($$('workDt').wg,"-");
	    obj.inTime =  inTimeVal;
		mobileAjax("/mobile/scm/dailyWork/indivisualDiliS/save",obj,fn_saveCB);	
	}
};
function fn_saveCB(data){
	dhx.alert(fn_alert('저장되었습니다.'));
	fn_search();
}
</script>
<form id="pForm" name="pForm">
<input type="hidden" id="gridId" name="gridId">
</form>