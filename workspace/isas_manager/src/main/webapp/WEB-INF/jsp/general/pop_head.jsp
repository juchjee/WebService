<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<!-- defaultHeader -->
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib.jsp" />
	<c:if test="${empty isCrm}">
	<script type="text/javascript">
		function popSearch(){
			if($("#mbrSearch").val()==""){
				alert("검색할 이름 또는 아이디를 입력해주세요.");
				$("#mbrSearch").focus();
				return false;
			}
			fnAjax("amM102S.action", {"mbrSearch" : $("#mbrSearch").val()}, function(data, dataType){
				//var data = data.replace(/\s/gi,'');
				if(data.cnt == 0){
					if(data.mCsList){
						var isAddNm = false;
						$.each(data.mCsList, function(index, obj){
							var rowStr = "<tr><td>"+obj.caMbrId+"</td><td>"+obj.csDt+"</td><td>"+obj.funnelNm+"</td><td>"+obj.csTypeNm+"</td><td>"
							+obj.caNonMbr+"</td><td>"+obj.csQuestion+"</td><td>"+obj.csConsult+"</td></tr>";
							$("#mCsListTable  > tbody:last").append(rowStr);
							if(!isAddNm){
								if(obj.caNonMbrNm){
									$("#caNonMbrNm").val(obj.caNonMbrNm);
									isAddNm = true;
								}
							}
						});
						$("#mCsListDiv").show();
					}
					return false;
				}else if(data.cnt > 1){
					$.fancybox.open({
						href: "${rootUri}${conUrl}amM102PL.action?mbrSearch="+$("#mbrSearch").val()+"&caller=${caller}&caNonMbrTel=${caller}",
						type: "iframe",
						maxWidth	: 1920,
						maxHeight	: 680,
						width		: 1000,
						height		: 500,
						autoSize	: true
					});
				}else{
					<c:if test="${not empty caller}">
					window.location = "${rootUri}${conUrl}amM1021F.pop?mbrId="+data.mbrId+"&caNonMbrTel=${caller}";
					</c:if>
					<c:if test="${empty caller}">
					window.location = "${rootUri}${conUrl}amM1021F.pop?mbrId="+data.mbrId;
					</c:if>
				}
			},"POST","json");
		}
		function enterCh(){
			 if(event.keyCode == 13)
		     {
				 popSearch();
		     }
		}
		function clockView(){
			var today=new Date();
			$("#csDt").val(today.getFullYear()+"-"+checkTime(today.getMonth()+1)+"-"+checkTime(today.getDate())+"      "+today.getHours()+":"+checkTime(today.getMinutes())+":"+checkTime(today.getSeconds()));
		}

		function startClock() { // internal clock//
			clockView();
			setInterval(clockView, 1000);
		}

		function checkTime(i) {
			if (i<10) {i = "0" + i};  // add zero in front of numbers < 10
				return i;
		}

		function goMapPop(){
			$.fancybox.open({
				href: "/mng/crm/map/mapList.action",
				type: "iframe",
				maxWidth	: 1920,
				maxHeight	: 1200,
				width		: 1200,
				height		: 800,
				autoSize	: true
			});
		}
	</script>
	</c:if>
	<c:if test="${not empty isCrm}">
	<script type="text/javascript">
		function popSearch(){
			if($("#mbrSearch").val()==""){
				alert("검색할 이름 또는 아이디를 입력해주세요.");
				$("#mbrSearch").focus();
				return false;
			}
			fnAjax("${rootUri}${conUrl}amM102S.action", {"mbrSearch" : $("#mbrSearch").val()}, function(data, dataType){
				//var data = data.replace(/\s/gi,'');
				if(data.cnt == 0){
					if(data.mCsList){
						var isAddNm = false;
						$.each(data.mCsList, function(index, obj){
							var rowStr = "<tr><td>"+obj.caMbrId+"</td><td>"+obj.csDt+"</td><td>"+obj.funnelNm+"</td><td>"+obj.csTypeNm+"</td><td>"
							+obj.caNonMbr+"</td><td>"+obj.csQuestion+"</td><td>"+obj.csConsult+"</td></tr>";
							$("#mCsListTable  > tbody:last").append(rowStr);
							if(!isAddNm){
								if(obj.caNonMbrNm){
									$("#caNonMbrNm").val(obj.caNonMbrNm);
									isAddNm = true;
								}
							}
						});
						$("#mCsListDiv").show();
					}
					return false;
				}else if(data.cnt > 1){
					$.fancybox.open({
						href: "${rootUri}${conUrl}amM102PL.action?mbrSearch="+$("#mbrSearch").val()+"&caller=${caller}&caNonMbrTel=${caller}",
						type: "iframe",
						maxWidth	: 1920,
						maxHeight	: 680,
						width		: 1000,
						height		: 500,
						autoSize	: true
					});
				}else{
					<c:if test="${not empty caller}">
					window.location = "${rootUri}${conUrl}amM1021F.pop?mbrId="+data.mbrId+"&caNonMbrTel=${caller}";
					</c:if>
					<c:if test="${empty caller}">
					window.location = "${rootUri}${conUrl}amM1021F.pop?mbrId="+data.mbrId;
					</c:if>
				}
			},"POST","json");
		}
		function enterCh(){
			 if(event.keyCode == 13)
		     {
				 popSearch();
		     }
		}
		function clockView(){
			var today=new Date();
			$("#csDt").val(today.getFullYear()+"-"+checkTime(today.getMonth()+1)+"-"+checkTime(today.getDate())+"      "+today.getHours()+":"+checkTime(today.getMinutes())+":"+checkTime(today.getSeconds()));
		}

		function startClock() { // internal clock//
			clockView();
			setInterval(clockView, 1000);
		}

		function checkTime(i) {
			if (i<10) {i = "0" + i};  // add zero in front of numbers < 10
				return i;
		}

		function goMapPop(){
			$.fancybox.open({
				href: "/mng/crm/map/mapList.action",
				type: "iframe",
				maxWidth	: 1920,
				maxHeight	: 1200,
				width		: 1200,
				height		: 800,
				autoSize	: true
			});
		}
	</script>
	</c:if>
	

<!-- /defaultHeader -->