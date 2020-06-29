<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script type="text/javascript">
var mainLayout;
var mainTabbar;
var leftLayout;
var mainMenu;
var leftForm, leftToolbar;
var scrnParm;
var ActTabId;
var menuId;
$( document ).ready(function() {
	mainLayout = new dhtmlXLayoutObject({//메인 layout 생성
			parent: "container",
			pattern: "3T"
	});
	
	mainLayout.forEachItem(function(cell){//cell 구분짓는 a,b,c remove
      cell.hideHeader();
	});
	mainLayout.cells("b").showHeader();
	mainLayout.cells("b").setText(' ')
	mainMenu = mainLayout.cells("b").attachTree();
	mainMenu.enableSmartCheckboxes(true);

	mainTabbar = mainLayout.cells("c").attachTabbar();
	mainLayout.cells("a").attachObject("top");
	mainTabbar.enableAutoReSize(true);
	
	mainLayout.cells("b").setWidth(240);
	mainLayout.cells("a").setHeight(30);
	mainLayout.cells("a").fixSize(false, true);

	/* 메뉴 쪽 레이아웃 사이즈 조절 가능*/
	mainLayout.cells("b").fixSize(true, false);
	mainLayout.cells("b").fixSize(false, true);

	mainTabbar.attachEvent("onSelect", function(id, lastId){
		mainMenu.getDxObj().selectItem(id); //Tabbar 클릭시 Tree scroll이 해당위치로 이동
		mainMenu.getDxObj().focusItem(id); //Tabbar 클릭시 menu path get
		getViewFullPath(id); //왼쪽 상단의 페이지 풀 경로
		return true;
	});
	$(window).resize(function(){
		mainLayout.setSizes();
	});

	$('#log_out').click(function(event) { //logout 버튼 클릭시
		event.preventDefault();
		dhtmlx.confirm({
			title:"확 인",
			ok:"네", cancel:"아니오",
			text:"정말로 로그아웃 하시겠습니까?",
			callback:function(result){
				if(result)
					extLogout();
				else
					return true;
			}
		});
		
		function extLogout(){
			$.ajax({
				url : "/logout",
		        type : "POST",
		        dataType: "json"
			});
			location.replace("/erp/scm/login.do");
		}
	});
	
	$('#home a').click(function(event) {//home 버튼 클릭 시 main으로 이동
		event.preventDefault();
		location.replace("/erp/scm/main.do");
	});
	
	$('.dhxtabbar_tabs_ar_left').click(function(e) {//tabbar 좌화살표 클릭시 메뉴이동
		 mainTabbar.goToPrevTab();
	});
	
	$('.dhxtabbar_tabs_ar_right').click(function(e) {//tabbar 우화살표 클릭시 메뉴이동
		mainTabbar.goToNextTab();
	});
	
	menuTreeSearch();
});
function menuTreeSearch(){
	var obj = {};
	obj.kind ="web";
	gfn_callAjaxComm(obj,"/erp/scm/menu",load_treeCB,'');
}

function load_treeCB(data){
	if(mainMenu!=null) {
		mainMenu.destructor();
	}
	mainMenu = mainLayout.cells("b").attachTree();
	mainMenu = new dxTree(mainMenu);
	mainMenu.setData(data);
	mainMenu.click(function(id){
		fncSelectItem(mainMenu, id);
	});
	mainMenu.load("menucd", "pmenucd", "menuname", mainMenu);
};

var fncSelectItem = function(tree, id) {
	
	var exegbn = "";
	try { // 폴더 클릭시 하위 목록 열고 닫는 로직
		exegbn = tree.getUserData(id, "exegbn");
		if(exegbn=="0" && tree.getDxObj().getOpenState(id)==1) {
			tree.getDxObj().closeItem(id);
		} else {
			tree.getDxObj().openItem(id);
			tree.getDxObj().selectItem(id, false, false);
		}

	} catch(e){
		alert(e);
	}
	if(exegbn=="1") { // 윈도우 클릭시 실제 로드되는 로직
		var flag = true;
		var uri = tree.getUserData(id, "uri");
		scrnParm = tree.getUserData(id, "scrnParm");
		/*메뉴id 전역변수 처리*/
		menuId = id;
	
		var menuItemText = tree.getDxObj().getItemText(id);
		mainTabbar.forEachTab(function(tab){
		    var tabId = tab.getId();
		    if(id == tabId){ 
				flag=false;
				mainTabbar.tabs(tabId).setActive();
				menuId = tabId;
			}
		});
		if(flag){
			ActTabId = id;
		 	/*  closeBtn = '<input type="image" src="/images/button/dhtmlx/close_2.gif" width="11" height="11"'+
			'id="closeBtn" name="closeBtn" onClick="closeEvent('+id+')">';  */
			
			//mainTabbar.addTab(id, menuItemText+'&nbsp;&nbsp;'+closeBtn, null, null, true, false);
			mainTabbar.addTab(id, menuItemText, null, null, true, true);
            mainTabbar.tabs(id).attachURL("/"+uri+".do");
		}
	}
};

function getViewFullPath(id){
	var finalPath="";
	var path;
	var level;
	var initPath = mainMenu.getDxObj().getItemText(id);

	level = mainMenu.getDxObj().getLevel(id);
	mainMenu.getDxObj().selectItem(id);
	do {
		var parentId = mainMenu.getDxObj().getParentId(id);
		path = " > "+mainMenu.getDxObj().getItemText(parentId);
		finalPath = path+finalPath;
		id = parentId;
		level--;
	}while (level > 1);
	$("#pathbar").val(finalPath.slice(2)+" > "+initPath);
}
</script>
<form id="hiddenform" name="hiddenform" method="post">
    <input type="hidden" id="scrnParm" name="scrnParm" />
</form>
<div id="top">
    <div style="float:left;margin-top:3px;margin-left:20px;" id="home">
       <p class="crop" id = "home a">
	        <img id="" alt="is_small_log" src="/images/logo/is_small_logo.jpg" width="100px;" height="25px;">
        </p>
	  <span id='pathbar' style='font-weight:bold; border:0px;background-color:transparent;width:400px;'></span>
    </div>
    <div style="float:right;margin-top:5px;margin-right:20px;" id="logout">
         <input name='id' id='id' readonly style='width :120px; font-size:12px; font-weight:bold; margin-right:0px; border:0px;background-color:transparent; text-align:right' value="아이디 : ${id}">
        <input name='userNm' id='userNm' readonly style='width :120px; font-size:12px; font-weight:bold; margin-right:20px; border:0px;background-color:transparent; text-align:right' value="이름 : ${userNm}">
        <input name='custCd' id='custCd' readonly style='width :200px; font-size:12px; font-weight:bold; margin-right:50px; border:0px;background-color:transparent; text-align:right' value="거래처명 : ${custNm}">
        <a href="#" id="log_out">로그아웃</a></div>
</div>
<div id="container"></div>
