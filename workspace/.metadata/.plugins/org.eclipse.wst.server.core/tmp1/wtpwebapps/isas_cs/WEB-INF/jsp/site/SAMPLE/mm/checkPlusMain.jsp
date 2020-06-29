<html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title>NICE평가정보 가상주민번호 서비스</title>
</head>
<body>
<c:if test="${empty sMessage}">
	<table id='waiting' style='position:absolute;margin:0;width:100%;height:100%;'>
    	<tr><td align='center' style='font-size:10pt; background:#FFFFFF;'><img src='${rootUri}common/img/icon/ajaxLoader.gif'/><br><br></td></tr>
    </table>
	<!-- 본인인증 서비스 팝업을 호출하기 위해서는 다음과 같은 form이 필요합니다. -->
	<form name="form_chk" method="post">
		<input type="hidden" name="m" value="checkplusSerivce">			<!-- 필수 데이타로, 누락하시면 안됩니다. -->
		<input type="hidden" name="EncodeData" value="${sEncData}">		<!-- 위에서 업체정보를 암호화 한 데이타입니다. -->
	    <!-- 업체에서 응답받기 원하는 데이타를 설정하기 위해 사용할 수 있으며, 인증결과 응답시 해당 값을 그대로 송신합니다. 해당 파라미터는 추가하실 수 없습니다. -->
		<input type="hidden" name="param_r1" value="${param.param_r1}">
		<input type="hidden" name="param_r2" value="${param.param_r2}">
		<input type="hidden" name="param_r3" value="${param.param_r3}">
	</form>
	<script type="text/javascript">
	(function(){
		document.form_chk.action = "https://check.namecheck.co.kr/checkplus_new_model4/checkplus.cb";
		document.form_chk.submit();
	})();
	</script>
</c:if>
<c:if test="${!empty sMessage}">
	<table style='position:absolute;margin:0;width:98%;height:98%'>
    	<tr>
    		<td align='center'>
    			<c:out value="${sMessage}" />
    		</td>
    	</tr>
    	<tr>
    		<td align='center'>
				<a href="javascript:self.close();">
					<img src="${rootUri}common/img/icon/pop_btn02.png" alt="취소(안심본인증을 종료하고 창닫기)">
				</a>
    		</td>
    	</tr>
    </table>
</c:if>
</body>
</html>