<html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title>본인인증서비스</title>
</head>
<body>
	<table id='waiting' style='position:absolute;margin:0;width:100%;height:100%;'>
    	<tr><td align='center' style='font-size:10pt; background:#FFFFFF;'><img src='${rootUri}common/img/icon/ajaxLoader.gif'/><br><br></td></tr>
    </table>
	<!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
	<form name="reqKMCISForm" method="post" action="#">
	    <input type="hidden" name="tr_cert"     value = "${tr_cert}">
	    <input type="hidden" name="tr_url"      value = "${rootUri}ISDS/mm/checkPlusSuccess.action">
	    <input type="hidden" name="tr_add"      value = "N">

	    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다. 해당 파라미터는 추가하실 수 없습니다. -->
		<input type="hidden" name="param_r1" value="${param.param_r1}">
		<input type="hidden" name="param_r2" value="${param.param_r2}">
		<input type="hidden" name="param_r3" value="${param.param_r3}">

	</form>
	<script type="text/javascript">
	(function(){
		var UserAgent = navigator.userAgent;http://cs.inusbath.com/common/img/icon/ajaxLoader.gif
	    /* 모바일 접근 체크*/
	    // 모바일일 경우 (변동사항 있을경우 추가 필요)
	    if (UserAgent.match(/iPhone|iPod|Android|Windows CE|BlackBerry|Symbian|Windows Phone|webOS|Opera Mini|Opera Mobi|POLARIS|IEMobile|lgtelecom|nokia|SonyEricsson/i) != null || UserAgent.match(/LG|SAMSUNG|Samsung/) != null) {
	   		 document.reqKMCISForm.target = '';
		  }

		  // 모바일이 아닐 경우
		  else {
// 	   		KMCIS_window = window.open('', 'KMCISWindow', 'width=425, height=550, resizable=0, scrollbars=no, status=0, titlebar=0, toolbar=0, left=435, top=250' );

// 	   		if(KMCIS_window == null){
// 	  			alert(" ※ 윈도우 XP SP2 또는 인터넷 익스플로러 7 사용자일 경우에는 \n    화면 상단에 있는 팝업 차단 알림줄을 클릭하여 팝업을 허용해 주시기 바랍니다. \n\n※ MSN,야후,구글 팝업 차단 툴바가 설치된 경우 팝업허용을 해주시기 바랍니다.");
// 	      }

// 	   		document.reqKMCISForm.target = 'KMCISWindow';
		  }
		  document.reqKMCISForm.action = 'https://www.kmcert.com/kmcis/web/kmcisReq.jsp';
		  document.reqKMCISForm.submit();
	})();
	</script>
</body>
</html>