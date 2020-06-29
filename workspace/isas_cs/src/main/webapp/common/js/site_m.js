function woh_open(url, target, feature, replace) {
//     alert("checkPlusMain.action".indexof(-1))
//    if (!"checkPlusMain.action".indexof(-1)) { // <- 여기에 새창 띄우기를 후킹할 페이지를 적어줍니다.

        var iframe = document.createElement("IFRAME");
        iframe.src = url;
        iframe.frameborder = "0";
        iframe.style.position = "fixed";
        iframe.style.top = "0px";
        iframe.style.left = "0px";
        iframe.style.width = "100%";
        iframe.style.height = "100%";
        iframe.style.background = "#ffffff";
        document.body.appendChild(iframe);
        return;
}
function woh_installHook() {
    if (typeof(window.__oldOpen) == "undefined") {
        window.__oldOpen = window.open;
        window.open = woh_open;
    }
}
//woh_installHook();


function alertSetting() {

	alert = window.showModalDialog();
	return;
}


function alertInit() {
    window.showModalDialog = alertSetting; // modal 실행
} alertInit();


/*자동로그인 기기저장*/
var isMobile = {
	    Android: function() {
	        return navigator.userAgent.match(/Android/i);
	    },
	    BlackBerry: function() {
	        return navigator.userAgent.match(/BlackBerry/i);
	    },
	    iOS: function() {
	        return navigator.userAgent.match(/iPhone|iPad|iPod/i);
	    },
	    Opera: function() {
	        return navigator.userAgent.match(/Opera Mini/i);
	    },
	    Windows: function() {
	        return navigator.userAgent.match(/IEMobile/i) || navigator.userAgent.match(/WPDesktop/i);
	    },
	    any: function() {
	        return (isMobile.Android() || isMobile.BlackBerry() || isMobile.iOS() || isMobile.Opera() || isMobile.Windows());
	    }
	};

function callNative(cmd){
	if(isMobile.iOS()){
		var location = "iscs://callNative("+cmd+")";
		window.location = location;
	}else if(isMobile.Android()){
		window.iscs.callNative(cmd);
	}
}

//저장된 id 값 불러오기
//ex) {"cmdId":"js_loadSessionId", "successFunc" : "callback 함수명", "failFunc" : "callback 함수명"}
function loadSessionId() {
	callNative("{\"cmdId\":\"js_loadSessionId\", \"successFunc\" : \"callback\", \"failFunc\" : \"callback\"}");
}

//저장할 id 값 전달
//ex) {"cmdId":"js_saveSessionId", "params" : "{\"id\" : \"저장할 id값\"}" }
function saveSessionId(id,pw,chk){
   // id값 체크
	var info = id+"___"+pw+"___"+chk;

	callNative("{\"cmdId\":\"js_saveSessionId\", \"successFunc\" : \"savecallback\", \"failFunc\" : \"savecallback\", \"params\" : \"{\\\"id\\\" : \\\""+info+"\\\"}\" }");
//	if(!confirm("자동 로그인을 하시겠습니까?")){
//		removeSessionId();
//		alert("자동 로그인을 취소하였습니다.");
//	}
}


//저장된 id 값 삭제
function removeSessionId(){
   callNative("{\"cmdId\":\"js_removeSessionId\", \"successFunc\" : \"removecallback\", \"failFunc\" : \"removecallback\"}");
}


function fnLogout(){
	removeSessionId();
}

function removecallback(json){
	var json = JSON.parse(json);
	   var status = json.status;
	   if(status == 0){

	   }

		location.href= "/ISDS/mm/actionLogSystem.out.action";
		return;
}



//loadSession callback
//ex) {"status" : 0, "data" : "{\"id\" : \"저장된 id 값\"}"}
function callback(json){
   var json = JSON.parse(json);
   var status = json.status;
   if(status == 0){
       // 0 성공
       var data = JSON.parse(json.data);

       var idStr = data.id;
       var idStrArr =  idStr.split("___");
       var id = idStrArr[0];
       var pw = idStrArr[1];
       var chk = idStrArr[2];
       if(chk == "on"){

       	fnAjax("/ISDS/mm/autoLoginChk.action", {"mbrId":id,"mbrPw":pw},
				function(data, dataType){
	    	   		if(data.status != "ng"){
	    	   		}else{
	    	   		//	removeSessionId();
	    	   			//		location.href="/";
	    	   		}
    	   			location.href="/";

    	   			return;
				},"POST"
			);
   		}else{
   			return;
   		}
       // 저장된 id 전달
   }else if(status = 1){
	   return;
   }else{
     //  alert('error');
       // 실패시
	   return;
   }
}