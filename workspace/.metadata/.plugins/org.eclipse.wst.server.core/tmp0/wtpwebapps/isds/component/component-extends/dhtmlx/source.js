function gfn_temp(grid,data){
	for(var i=0;i<data.length;i++){
		for (var key in data[i]) {
	        	var classNm = grid.dxObj.getUserData("","@"+[key]);
	        	if(classNm == 'format_date' && data[i][key]!=null ){
	        		if(data[i][key].length>=8){
		        		var maskDate = dateMask(data[i][key]);
		        		data[i][key] = maskDate;
	        		}
	        	}
	        	if(classNm == 'format_month'){
	        		var maskDateM = dateMaskM(data[i][key]);
	        		data[i][key] = maskDateM;
	        	}
	        	if(classNm == 'format_time'){
	        		var maskTime = dateTimeMask(data[i][key]);
	        		data[i][key] = maskTime;
	        	}
	        	if(classNm == 'format_jumin'){
	        		var maskJumin = juminMask(data[i][key]);
	        		data[i][key] = maskJumin;
	        	}
	        	if(classNm == 'format_foreNo'){
	        		var maskJumin = juminMask(data[i][key]);
	        		data[i][key] = maskJumin;
	        	}
	        	if(classNm == 'format_mobileNo'){
	        		var maskMobile = mobileMask(data[i][key]);
	        		data[i][key] = maskMobile;
	        	}
	        	if(classNm == 'format_saupja'){
	        		var maskSaupja = saupjaMask(data[i][key]);
	        		data[i][key] = maskSaupja;
	        	}
	        	if(classNm == 'format_bupin'){
	        		var maskBupin = bupinMask(data[i][key]);
	        		data[i][key] = maskBupin;
	        	}
		  }
	};
	grid.clearAll();
    grid.parse(data,"js");

    return data;
}


function gfn_getMappingUrl(param){
	var tabId = parent.mainTabbar.getActiveTab();
	var uri = parent.mainMenu.getUserData(tabId, "uri");
	uri = "/"+uri+"/"+param;
	return uri.trim();
}

function gfn_callAjax(param,url,callbackFn){
	if (!url.match(/\//g)) url = gfn_getMappingUrl(url);
	$.ajax({
    	url:  url,
        type: "POST",
        async:false,
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', // default content type (mime-type)
        data: param,
        dataType: "json",
        success: function(data) {
        	
      		if (callbackFn != undefined) {
                  callbackFn.call(this, data);
               }	
        }
    });
}

function gfn_callAjaxComm(param,url,callbackFn,msg){
	if (!url.match(/\//g)) url = gfn_getMappingUrl(url);
	var gData = [];
	$.ajax({
    	url:  url,
        type: "POST",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', // default content type (mime-type)
        data: param,
        async:false,
        dataType: "json",
        success: function(data, event, xhr, settings) {
        	gData=data;
        	
        	if(xhr.getResponseHeader("EXCEPTION")=="Y") {
      			var exObj = JSON.parse(xhr.responseText);
      			if(exObj.EXCEPTION_TYPE == 'BIZ'){
      				alert(MsgManager.getMsg(exObj.EXCEPTION_MSG_CODE, exObj.EXCEPTION_MSG_PARAM));
      			}else{
      				alert(exObj.EXCEPTION_MSG_CODE);
      			}
      			return;
      		}else{	
      			//20180802 ryul 아래 if문에 && gData.rtnCode == "1" 추가 > 서브미션이 성공했을 때만 '저장되었습니다.' 메시지 뜨도록 처리
      			if (msg == undefined && gData.rtnCode == "1") {
      				parent.MsgManager.alertMsg("INF001");
                 }
      			if (callbackFn != undefined) {
                    callbackFn.call(this, data);
                 }	
      		 }
        },
        error: function(xhr) { // if error occured

        }
    });
	return gData;
}

function gfn_callAjaxForGrid(grid, param, url, layout, callbackFn) {
	if (!url.match(/\//g)) url = gfn_getMappingUrl(url);
	$.ajax({
    	url:  url,
        type: "POST",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', // default content type (mime-type)
        data: param,
        dataType: "json",
        beforeSend: function() {
            layout.progressOn();
        },
        success: function(data,status) {
        	gfn_temp(grid,data);
          if (callbackFn != undefined) {
              callbackFn.call(this, data);
           }          
        },
        complete: function() {
            layout.progressOff();
        }
    });
}

function gfn_callAjaxForGridR(grid, param, url, layout, callbackFn) {
	if (!url.match(/\//g)) url = gfn_getMappingUrl(url);
	$.ajax({
    	url:  url,
        type: "POST",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', // default content type (mime-type)
        data: param,
        dataType: "json",
        beforeSend: function() {
            layout.progressOn();
        },
        success: function(data,status) {
        	gfn_temp(grid,data);
          if (callbackFn != undefined) {
              callbackFn.call(this, data);
           }
        	  if(data.length>0){
  				var firstColType = grid.dxObj.getColType(0)
  				var startIdx = 0
  				if(firstColType == 'cntr'){
  					startIdx = 1
  				}
  				fn_multiRowMerge(grid, startIdx)
  			}
          
        },
        complete: function() {
            layout.progressOff();
        }
    });
}

function gfn_callAjaxForForm(formId, p_data, url, callbackFn) {
	var gData = [];
	if (!url.match(/\//g)) url = gfn_getMappingUrl(url);
    $.ajax({
        url: url,
        type: "POST",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8', // default content type (mime-type)
        data: p_data,
        dataType: "json",
        beforeSend: function() {},
        success: function(data) {
        	gData = data;
           	if (callbackFn != undefined) {
                callbackFn.call(this, data);
            }
           	$("#" + formId).exSetDataInFrom(data[0]);
        }
    });
    return gData;
}

function gfn_getFormElemntsData(formId,added) {
	function addElements(formId,added){
		  for(var key in added){
		       $('<input>').attr({
		            type: 'hidden',
		            id: "",
		            name: key
		       }).appendTo("#"+formId).addClass('crud-added');
			}
		}

		function editElements(){
			$("#"+formId+" *").filter(':input').each(function(){
			    $("#"+formId+" input[class*='format']").each(function(){
			    	$.applyDataMask($(this));
			    	$(this).val($(this).cleanVal());
			    });
			});
		}
		function createElements(formId){
			   $("#"+formId).find(':checkbox').each(function() {
			       var els = $('<input>').attr({
			            type: 'hidden',
			            id: "", 
			            name: $(this).attr("name")
			        }).appendTo("#"+formId).addClass("crud-added");
			        if ($(this).is(":checked")) {
			            $(els).val($(this).val());
			        } else { 
			        	$(els).val('0');
			        }
			    });
		}
		if(added != undefined)addElements(formId,added);

		editElements(formId);
		createElements(formId);

		return  $("#"+formId).serialize();
};


//onchange="gfn_chkDateFrTo(fromDt, toDt, curCtrl)"
function gfn_chkDateFrTo(fromDt, toDt, curCtrl) {
	//1. 빈값 체크
	//2. 현재 컨트롤 아이디와 날짜 비교
	//3. 날짜 크기 비교
	//4. fromDt가 현재 컨트롤일 경우, toDt보다 클 경우, "toDt보다 클 수 없습니다." 메시지 처리
	//5. toDt가 현재 컨트롤일 경우, fromDt보다 작을 경우, "fromDt보다 작을 수 없습니다." 메시지 처리
	//"WRN022":"{0}보다  클 수 없습니다."
	//"WRN023":"{0}보다  작을 수 없습니다."
	var curCtrlId = curCtrl.id;
	var fromDtId = fromDt.id;
	var toDtId = toDt.id;
	
	var fromDtVal = fromDt.value.replace(/[^0-9]/g,"");
	var toDtVal = toDt.value.replace(/[^0-9]/g,"");
	
	var lblFromDt = $("label[for='" + fromDt.id + "']").text();
	var lblToDt = $("label[for='" + toDt.id + "']").text();
	
	if((fromDtVal!="" && toDtVal!="") && (fromDtVal > toDtVal)) {
		$('#' + curCtrlId).val("");	//초기화
		if(curCtrlId == fromDtId) {
			return MsgManager.alertMsg("WRN022",lblToDt);	//{0}보다  클 수 없습니다.
		} else if(curCtrlId == toDtId) {
			return MsgManager.alertMsg("WRN023",lblFromDt);	//{0}보다  작을 수 없습니다.
		}
	}
}