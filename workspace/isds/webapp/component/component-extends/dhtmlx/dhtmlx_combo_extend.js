//기본 단일 dhtmlx Combo 셋팅
function gfn_single_comboLoad(comboId,value,key,cLength,detachEvent){
	comboId.setTemplate({
	    input: "#interName#",
	    columns: [
	       {header: "구분", width: 100,  option: "#interName#"}
	    ]
	});
	for(var i=0;i<cLength;i++){
		comboId.addOption(value[i],key[i]);
	}

	comboId.enableFilteringMode(true);
	comboId.enableAutocomplete(true);
	comboId.allowFreeText(true);
	
	if(!detachEvent){
		comboId.attachEvent("onBlur", function(){
		    var getValue = comboId.getComboText();
		    var flag = true;
		    for (var i = 0; i < key.length; i++) {
		    	if(key[i] == getValue || value[i] == getValue){
		    		flag = false;
		    		break;
		    	 }
		       }
		    if(flag){
		    	MsgManager.alertMsg("WRN013");
		    	comboId.setComboText("");
		    }
		 });
	}
};

function gfn_facCd_comboLoad(eleId,url,callbackFn) {
	$("#"+eleId+" option").remove();
    $.ajax({
        url: "/erp/scm/manufacture/partners/orderDelivery/"+url,
        type: "POST",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        data: {},
        async: false,
        dataType: "json",
        beforeSend: function() {},
        success: function(data) {
        	for(var i = 0; i<data.length; i++){
        		$('#'+eleId).append('<option value='+data[i].facCd+'>'+data[i].facNm+'</option>');
        	}
        	$('#'+eleId+'option:eq(0)').attr("selected","selected");
        	$('#'+eleId).trigger('change');
        	
        	if (callbackFn != undefined) {
                callbackFn.call(this, data);
             }
        }
    })  
};

function gfn_facCd_comboLoadAllOption(eleId,url,callbackFn) {
	$("#"+eleId+" option").remove();
    $.ajax({
        url: "/erp/scm/manufacture/partners/orderDelivery/"+url,
        type: "POST",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        data: {},
        async: false,
        dataType: "json",
        beforeSend: function() {},
        success: function(data) {
        	$('#'+eleId).append('<option value='+'%'+'>'+'전체'+'</option>');
        	for(var i = 0; i<data.length; i++){
        		$('#'+eleId).append('<option value='+data[i].facCd+'>'+data[i].facNm+'</option>');
        	}
        	$('#'+eleId+'option:eq(0)').attr("selected","selected");
        	$('#'+eleId).trigger('change');
        	
        	if (callbackFn != undefined) {
                callbackFn.call(this, data);
             }
        }
    })  
};

// elementId, url, 전체보일지 여부, callback함수
function gfn_bsCd_comboLoadOption(eleId,url,allYn,callbackFn) {
	$("#"+eleId+" option").remove();
    $.ajax({
        url: "/erp/scm/remiconAdmin/partners/shipment/"+url,
        type: "POST",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        data: {},
        async: false,
        dataType: "json",
        beforeSend: function() {},
        success: function(data) {
        	if("Y"==allYn) {
        		$('#'+eleId).append('<option value='+'%'+'>'+'전체'+'</option>');
        	}
        	for(var i = 0; i<data.length; i++){
        		$('#'+eleId).append('<option value='+data[i].bsCd+'>'+data[i].bsNm+'</option>');
        	}
        	$('#'+eleId+'option:eq(0)').attr("selected","selected");
        	$('#'+eleId).trigger('change');
        	
        	if (callbackFn != undefined) {
                callbackFn.call(this, data);
             }
        }
    })  
};


function gfn_weather_comboLoad(eleId,callbackFn) {
	$("#"+eleId+" option").remove();
    $.ajax({
        url: "/erp/scm/work/partners/dailyWork/weatherSearch",
        type: "POST",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        data: {},
        async: false,
        dataType: "json",
        beforeSend: function() {},
        success: function(data) {
        	for(var i = 0; i<data.length; i++){
        		$('#'+eleId).append('<option value='+data[i].weatherBc+'>'+data[i].title+'</option>');
        	}
        	$('#'+eleId+'option:eq(0)').attr("selected","selected");
        	$('#'+eleId).trigger('change');
        	
        	if (callbackFn != undefined) {
                callbackFn.call(this, data);
             }
        }
    })  
};


//elementId, url, 전체보일지 여부, callback함수
function gfn_baseCd_comboLoadOption(param, eleId,url,allYn,defaultLbl,callbackFn) {
	$("#"+eleId+" option").remove();
    $.ajax({
        url: "/erp/scm/inusBath/partners/custCard/"+url,	//baseCdSearch
        type: "POST",
        contentType: 'application/x-www-form-urlencoded; charset=UTF-8',
        data: param,
        async: false,
        dataType: "json",
        beforeSend: function() {},
        success: function(data) {
        	if("Y"==allYn) {
        		$('#'+eleId).append('<option value='+''+'>'+defaultLbl+'</option>');
        	} else if(""!=defaultLbl){
        		$('#'+eleId).append('<option value='+''+'>'+defaultLbl+'</option>');
        	}
        	for(var i = 0; i<data.length; i++){
        		$('#'+eleId).append('<option value='+data[i].baseCd+'>'+data[i].title+'</option>');
        	}
        	$('#'+eleId+'option:eq(0)').attr("selected","selected");
        	$('#'+eleId).trigger('change');
        	
        	if (callbackFn != undefined) {
                callbackFn.call(this, data);
             }
        }
    })  
};