<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>RESTful</title>
<meta http-equiv="CONTENT-TYPE" content="TEXT/HTML; CHARSET=EUC-KR">
<script type="text/javascript" src="/common/js/jquery-1.9.1.min.js"></script>
<script language="javascript">
$(document).ready( function() {
	alert("메뉴 사용 권한이 없거나 페이지가 존재하지 않습니다.\n\n메인화면으로 이동합니다.");
	if(opener != "undefined"){
		top.location.href = "/erp/scm/main.do";
	}else{
		if(parent && parent!=this){
			parent.location.href = "/erp/scm/main.do";
		}else{
			location.href = "/erp/scm/main.do";	
		}		
	}
	
});
</script>
</head>
<body>

</body>
</html>
