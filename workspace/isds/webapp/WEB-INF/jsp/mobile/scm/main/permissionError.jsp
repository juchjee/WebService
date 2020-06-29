<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.util.*" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<style type="text/css" media="screen">
body{
  margin:0px !important;
  height: 100%;
}
html{
  height: 100%;
}
pre.code {
  white-space: pre-wrap;
}
</style>
<script type="text/javascript">	
dhx.ready(function() {
	dhx.alert({ 
		labelOk : "확인",
		title : "알림",
		message:"해당메뉴에 권한이 없습니다.",
		callback: returnLogin
     })
});
function returnLogin(){
	location.assign('/mobile/scm/main/main.do');
}
</script>	