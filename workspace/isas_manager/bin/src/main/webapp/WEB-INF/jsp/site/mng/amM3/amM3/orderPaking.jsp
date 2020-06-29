<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />

	<script type="text/javascript" src="${rootUri}js/jwplayer/jwplayer.js"></script>


	<script type="text/javascript">

	$(window).load(function(){
		$.ajax({
	        url : "http://api.bit.ly/v3/shorten",
	        type: "GET",
	        data : {
	        	"login"		: 'psk1013',
	        	"apiKey"	: 'R_31a3add2c5fd43ada34ee6fcde1ebf41',
	        	"longUrl"	: 'http:\/\/58.229.234.98\/${param.orderPackingDt}\/${pakingMap.regiNo}.mp4'
	        },
	        success:function(data, textStatus, jqXHR)
	        {
	        	$('#tranMsg').val(data.data.url);
	        },
	        error: function(jqXHR, textStatus, errorThrown)
	        {
	        	alert("통신에 실패 하였습니다. 관리자에게 문의해 주세요.");
	        }
	   	}); // ajax

	});

	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){
	    jwplayer("myElement").setup({
// 	        'file': 'http://58.229.234.98/${param.orderPackingDt}/${param.orderNo}.mp4',
	        'file': 'http://58.229.234.98/${param.orderPackingDt}/${pakingMap.regiNo}.mp4',
			autostart: true,
			mute: true,
			'width': '380',
			'height': '240',
			controls: false
	    });
	    // 'file': 'http://58.229.234.98/${pakingMap.orderPackingDt}/${pakingMap.regiNo}.mp4',
	    fnEvent();
	}

	function fnEvent(){
		$("#subBtn").bind("click",function(){
			if(confirm("SMS발송 하시겠습니까?")){
				document.smsForm.action = "orderPakingSms.action";
				document.smsForm.submit();
			}
			else{
				return false;
			}
		});
	}
	</script>
</head>

<body class="noBg" >
	<div class="popup_wrap" style="background:#fff">
	<h2>패킹</h2>
	 <div class="pageContScroll_st6">

			<div class="table_type2">
				<div id="myElement">Loading the player...</div>
			</div>

			<form name="smsForm" id="smsForm" method="post">
			<div class="table_type1" >
				<table>
					<tr>
						<td rowspan="2" >
							<textarea id="tranMsg" name="tranMsg" maxlength="80" rows="5" cols="20" style="resize:none;"></textarea>
						</td>
						<td>받는 전화번호:<br>
							   <input type="text" name="tranPhone" id="tranPhone" size="20" class="input" value="${pakingMap.ordersMobile}">
							   <!-- http://58.229.234.98/${pakingMap.orderPackingDt}/${pakingMap.regiNo}.mp4 -->
						</td>
					</tr>
					<tr>
						<td>보내는 전화번호:<br>
							   <input type="text"  size="20" class="input" name="tranCallback" id="tranCallback" value="02-6205-3337" readonly="readonly"><p>
						</td>
					</tr>
				</table>
			</div>
			</form>

	</div>
	<div class="btn_area">
		    <div class="center">
		      	<a id="subBtn" class="btn_blue_line2" href="javascript:;">SMS발송</a>
		      	<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
		    </div>
		  </div>
	</div>
	<!-- // member_con -->
</body>
</html>
