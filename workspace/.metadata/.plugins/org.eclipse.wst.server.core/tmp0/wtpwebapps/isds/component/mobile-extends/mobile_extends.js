//mobile ajax 별도로 구현
function mobileAjax(url,param,callbackFn){
	$.ajax({
    	url:  url,
        type: "POST",
        data: param,
        async:false,
        dataType: "json",
        success: function(data, event) {
        	if (callbackFn != undefined) {
                callbackFn.call(this, data);
             }
        }
    });	
};

// error 메시지 팝업으로 보여주기
function fn_alert(msg){
	var msgObj = {
		labelOk : "확인",
		title : "알림",
		message : msg
	}
	return msgObj
}

// url 메뉴 이동
function fn_moveMenu(uri){
	location.assign(uri);
};

// 달력 구하는 것
function dateformat(date){
	var isdate= date;      

        var yyyy = isdate.getFullYear().toString();       
        var mm = (isdate.getMonth()+1).toString();       
        var dd  = isdate.getDate().toString();                                   
        return yyyy + '-' + (mm[1]?mm:"0"+mm[0]) + '-' + (dd[1]?dd:"0"+dd[0]);
};

function searchDate(dateValue,splitChar){
	var value = '';
	var splitfrDate = dateValue.split(splitChar);
	for(var i=0;i<splitfrDate.length;i++){
		value = value + splitfrDate[i];
	}
    return value;
}

function birthDate(dateValue,splitChar){
	var value = '';
	var splitfrDate = dateValue.split(splitChar);
	for(var i=0;i<splitfrDate.length;i++){
		value = value + splitfrDate[i];
	}
	value = value.substring(2,8);
    return value;
}