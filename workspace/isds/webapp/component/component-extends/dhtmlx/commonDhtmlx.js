$(document).ready(function(){
	//form 한국어 타입 추가
	dhtmlXCalendarObject.prototype.langData["ko"] = {
			dateformat: '%Y/%m/%d',
			monthesFNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
			monthesSNames: ["1월","2월","3월","4월","5월","6월","7월","8월","9월","10월","11월","12월"],
			daysFNames: ["일요일","월요일","화요일","수요일","목요일","금요일","토요일;"],
			daysSNames: ["일","월","화","수","목","금","토"],
			weekstart: 7,
			weekname: "주"
		}
	//엑셀 버튼 공통 사용
	fn_excel = function(){
		gridMain.getDxObj().toExcel("http://scm.isdongseo.co.kr/grid-excel/generate");	
	}
    
	//도움말 버튼 공통사용
	fn_help = function(){
		var mainTabbar = parent.mainTabbar;
		var menuId = mainTabbar.getActiveTab();
		var tempFileId = parent.mainMenu.getUserData(menuId, "uri");
		var fileId = tempFileId.split("/").join(".")+".pdf";
		var url = "/common/help/"+fileId;
		
		window.open(url, "_blank");
	}
	
	//class에 format_date 가 있는 input에 대하여 value 주입
    if($(".format_date").length > 1){
    	var jsonData = new Array();
    	$(".format_date").each(function(index){
    		var jsonObject = new Object();
    		jsonObject.input = $(this).attr("id");
    		jsonObject.button = "calpicker"+(index+1)+"";
			jsonData.push(jsonObject);
    	});
    	
        calMain = new dhtmlXCalendarObject(jsonData);
        calMain.loadUserLanguage("ko");
        calMain.hideTime();
        var t = dateformat(new Date());
        
        $(".format_date").each(function(index){
        	$(this).val(t);
        });
    }else if($(".format_date").length == 1){
    	var jsonData = new Array();
    	var jsonObject = new Object();
    	jsonObject.input = $(".format_date").attr("id");
    	jsonObject.button = "calpicker";
    	jsonData.push(jsonObject);
    	
        calMain = new dhtmlXCalendarObject(jsonData);
        calMain.loadUserLanguage("ko");
        calMain.hideTime();
        var t = dateformat(new Date());
        
        if($(".format_date").val() == ""){
        	$(".format_date").val(t);	
        }
    }
    
    //팝업 본 화면 내의 input에서는 더블클릭해도 팝업 안뜨도록 막음
	var thisFileFullName = document.URL.substring(document.URL.lastIndexOf("/") + 1, document.URL.length);
	thisFileFullName = thisFileFullName.substring(thisFileFullName.lastIndexOf('.'), 0);
	
    //공통으로 사용되는 input에 팝업 [현장코드조회]
    if($("#siteCd").length > 0){
    	$("#siteCd").dblclick(function(){
    		if("siteCdPOP"!=thisFileFullName) {
    			gfn_load_pop('w1','comm/siteCdPOP',['',"현장코드","siteCd"]);
    		}
    	});
    	$("#siteCd").keypress(function(e){
    		if(e.which == 13){
    			if("siteCdPOP"!=thisFileFullName) {
    				gfn_load_pop('w1','comm/siteCdPOP',[$('#siteCd').val(),"현장코드","siteCd"]);
        		}
    			return false;
    		}
    	});
    }
    
    //공통으로 사용되는 input에 팝업 [차량번호조회]
    if($("#carNo").length > 0){
    	$("#carNo").dblclick(function(){
    		if("carInfoPOP"!=thisFileFullName) {
    			gfn_load_pop('w1','shipment/carInfoPOP',['',"차량번호","carNo"]);
    		}
    	});
    	$("#carNo").keypress(function(e){
    		if(e.which == 13){
    			if("carInfoPOP"!=thisFileFullName) {
    				gfn_load_pop('w1','shipment/carInfoPOP',[$('#carNo').val(),"차량번호","carNo"]);
        		}
    			return false;
    		}
    	});
    }
    
    
    //공통으로 사용되는 input에 팝업 [사원정보조회]
    if($("#empNo").length > 0){
    	$("#empNo").dblclick(function(){
    		if("empInfoPOP"!=thisFileFullName) {
    			gfn_load_pop('w1','comm/empInfoPOP',['',"사원정보","empNo"]);
    		}
    	});
    	$("#empNo").keypress(function(e){
    		if(e.which == 13){
        		if("empInfoPOP"!=thisFileFullName) {
        			gfn_load_pop('w1','comm/empInfoPOP',[$('#empNo').val(),"사원정보","empNo"]);
        		}
    			return false;
    		}
    	});
    }
    if($("#schEmpNo").length > 0){ /* 조회조건용 */
    	$("#schEmpNo").dblclick(function(){
    		gfn_load_pop('w1','comm/empInfoPOP',['',"사원정보","schEmpNo"]);
    	});
    	$("#schEmpNo").keypress(function(e){
    		if(e.which == 13){
    			gfn_load_pop('w1','comm/empInfoPOP',[$('#schEmpNo').val(),"사원정보","schEmpNo"]);
    			return false;
    		}
    	});
    }

    //공통으로 사용되는 input에 팝업 [상품코드조회]
    if($("#saleCode").length > 0){
    	$("#saleCode").dblclick(function(){
    		if("saleCodePOP"!=thisFileFullName) {
    			gfn_load_pop('w1','comm/saleCodePOP',['',"상품정보","saleCode"]);
    		}
    	});
    	$("#saleCode").keypress(function(e){
    		if(e.which == 13){
        		if("saleCodePOP"!=thisFileFullName) {
        			gfn_load_pop('w1','comm/saleCodePOP',[$('#saleCode').val(),"상품정보","saleCode"]);
        		}
    			return false;
    		}
    	});
    }

    //공통으로 사용되는 input에 팝업 [판매채널(거래처코드)]
    if($("#custCd").length > 0){
    	$("#custCd").dblclick(function(){
    		if("custInfoPOP"!=thisFileFullName) {
    			gfn_load_pop('w1','custCard/custInfoPOP',['',"판매채널","custCd"]);
    		}
    	});
    	$("#custCd").keypress(function(e){
    		if(e.which == 13){
    			if("custInfoPOP"!=thisFileFullName) {
    				gfn_load_pop('w1','custCard/custInfoPOP',[$('#custCd').val(),"판매채널","custCd"]);
    			}
    			return false;
    		}
    	});
    }

    //공통으로 사용되는 input에 팝업 [판매채널(거래처코드)]
    if($("#schCustCd").length > 0){
    	$("#schCustCd").dblclick(function(){
    		if("custInfoPOP"!=thisFileFullName) {
    			gfn_load_pop('w1','custCard/custInfoPOP',['',"판매채널","schCustCd"]);
    		}
    	});
    	$("#schCustCd").keypress(function(e){
    		if(e.which == 13){
    			if("custInfoPOP"!=thisFileFullName) {
    				gfn_load_pop('w1','custCard/custInfoPOP',[$('#schCustCd').val(),"판매채널","schCustCd"]);
    			}
    			return false;
    		}
    	});
    }

});