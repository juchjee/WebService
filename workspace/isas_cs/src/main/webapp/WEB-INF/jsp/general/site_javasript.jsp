﻿<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<script type="text/javascript"><c:if test="${notForwardHistory}">window.history.forward(1);</c:if>var frontUri="${rootUri}";var homeUrl="${homeUrl}";var mallFullUri="${rootUri}${frontUri}";function setEncryptionCookie(name,value,expireTimes,isCombining,callBackFn) {var _url=mallFullUri+(isCombining ? "setCookieCombining.action":"setCookie.action");if(!callBackFn)callBackFn=function(data,dataType){}; fnAjax(_url,{"name":name,"value":value,"expiretimes":expireTimes},callBackFn,'POST');}function iframe_call_msg(event){if(event.origin!=="${iConstant.get('HOME_URL')}"){return;}eval(event.data);}function iframe_send_msg(msg){if(opener){opener.postMessage(msg,"${iConstant.get('HOME_URL')}");}else{parent.postMessage(msg,"${iConstant.get('HOME_URL')}");}}(function(){if(window.addEventListener){window.addEventListener("message",iframe_call_msg,false);}else if(window.attachEvent){window.attachEvent("onmessage",iframe_call_msg);}if($ && $.ajaxSetup)$.ajaxSetup({cache:false})})();</script>