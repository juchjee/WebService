<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- defaultHeader -->
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib.jsp" />
	<script type="text/javascript">
		function menuInit(){
			$(".depths_0 .on").each(function(i){
				var dom = $(this);
				var value = dom.text();
				if(i == 0){
					$("#tit_depths1").text(value);
					$("#tit_depths1").attr('href', $(dom.parent().find('li a').get(0)).attr('href'));
				}else if(i == 1){
					$("#tit_depths0").text(value);
					$("#tit_depths2").text(value);
					$("#tit_depths2").attr("href", dom.attr("href"));
				}
			});
		}
	</script>
<!-- /defaultHeader -->