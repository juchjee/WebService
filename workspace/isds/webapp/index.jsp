<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<script language=javascript>
var filter = "win16|win32|win64|mac|macintel";
if ( navigator.platform  ) {
    if ( filter.indexOf( navigator.platform.toLowerCase() ) < 0 ) {
    	location.href = "/mobile/scm/main/login.do";
    } else {
    	location.href = "/erp/scm/login.do";
    }
}
</script>
</html>