<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

<script type="text/javaScript" defer="defer">
	var contUrl = "${rootUri}${conUrl}amM707";
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){
		var fnCacheResetSuccess =  function(data, dataType){

			alert(data);
			var data = data.replace(/\s/gi,'');
			var returnData = "";
			if(data == "ng"){
				alert("초기화에 실패하였습니다.");
				return false;
			}else if(data == "ok"){
				alert("정상처리 되었습니다.");
				if(confirm("현재페이지를 다시읽기 하시겠습니까?")){
					document.reset();
				}
			}else{
				return false;
			}
		};
		
		
		/** 캐시 초기화 버튼 이벤트 **/
		$(".cacheResetBtn").click(function(){
			var tp = "";
			if($(".cacheResetBtn").index(this) == 0){
				tp = "admin";
			}else if($(".cacheResetBtn").index(this) == 1){
				tp = "front";
			}else{
				tp = "N/A";
			}
			fnAjax("amM707.action", {"tp" : tp}, function(data, dataType){
				var data = data.replace(/\s/gi,'');
				var returnData = "";
				if(data == "ng"){
					alert('<spring:message code="fail.request.msg"/>');
					return false;
				}else if(data == "ok"){
					alert("정상처리 되었습니다.");
					location.reload();
				}else{
					return false;
				}
			}, "post", "text", "false");
		});
	}
	

</script>
</head>
<body>
	<div style="text-align:left;margin:0 0 10px 0;x">
		<a class="cacheResetBtn btn_type1" href="javascript:;">관리자페이지 캐시 초기화</a>
	</div>
	<div style="text-align:left;margin:10px 0 0 0;x">
		<a class="cacheResetBtn btn_type1" href="javascript:;">사용자페이지 캐시 초기화</a>
	</div>
	
</body>