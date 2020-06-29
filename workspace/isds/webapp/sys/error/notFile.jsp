<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>RESTful</title>
<meta http-equiv="CONTENT-TYPE" content="TEXT/HTML; CHARSET=EUC-KR">
<script type="text/javascript" src="/common/js/jquery-1.9.1.min.js"></script>
<script language="javascript">
$(document).ready( function() {
	alert("파일이 존재하지 않습니다.");
	if(opener != "undefined"){
		top.history.go(-1);
	}else{
		if(parent && parent!=this){
			parent.history.go(-1);
		}else{
			history.back(-1);
		}		
	}
});
</script>
</head>
<body>

</body>
</html>
