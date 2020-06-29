<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>   
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
	<tiles:insertAttribute name="header"/>
</head>
<script type="text/javascript">
 $(document).ready(function(){
 $(document).bind('keydown', function(event) {
		 var target = event.target || event.srcElement;

	   if (event.keyCode == 8 && !/input|textarea/i.test(target.nodeName)) {
			  return false;
		 } 
	   });	
}); 
</script>
<body  style="width:100%; background-color:white;" >
	<tiles:insertAttribute name="body"/>
</body>
</html> 

 