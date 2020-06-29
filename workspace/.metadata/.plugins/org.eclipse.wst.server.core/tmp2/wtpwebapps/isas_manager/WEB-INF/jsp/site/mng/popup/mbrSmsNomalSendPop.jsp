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
	<script type="text/javascript">
	$(window).load(function(){
		$("textarea[name=tranMsg]").bind("keyup",function(){
			var maxByte = 80;
			var str =  $(this).val();
			var str_len = str.length;
			var rbyte = 0;
			var rlen = 0;
			var one_char = "";
			var str2 = "";

				for(var i=0; i<str_len; i++){
				one_char = str.charAt(i);
				if(escape(one_char).length > 4){
				    rbyte += 2;                                         //한글2Byte
				}else{
				    rbyte++;                                            //영문 등 나머지 1Byte
				}

				if(rbyte <= maxByte){
				    rlen = i+1;                                          //return할 문자열 갯수
				}
			}

			if(rbyte > maxByte){
				$(".smsStrCnt").css("color","red");
			}else{
				$(".smsStrCnt").css("color","");
			}

			$(".smsStrCnt").text(rbyte);
		});

		$("#subBtn").bind("click",function(){
			if(confirm("SMS발송 하시겠습니까?")){
				var tranMsg = $("textarea[name=tranMsg]").val();

				if(tranMsg.length == 0){
					alert("발송할 문자를 입력해 주세요.");
					$('#tranMsg').focus();
					return;
				}
				if(parseInt($(".smsStrCnt").text()) > 80){
					alert("SMS는 80Byte 이상 작성이 불가능합니다.");
					$('#tranMsg').focus();
					return;
				}
				if($("#tranPhone").val() == ''){
					alert("받는 전화번호를 입력해 주세요.");
					$('#tranPhone').focus();
					return;
				}

				document.smsForm.action = "mbrSmsNomalSendPop.action";
				document.smsForm.submit();
			}
			else{
				return false;
			}
		});
	});
	</script>
</head>

<body class="noBg" >
	<div class="popup_wrap" style="background:#fff">
	<h2>일반 SMS 발송</h2>
	 <div class="pageContScroll_st6">
			<form name="smsForm" id="smsForm" method="post">
			<div class="table_type1" >
				<table>
					<tr>
						<td rowspan="2" >
							<textarea id="tranMsg" name="tranMsg" maxlength="80" rows="5" cols="20" style="resize:none;"></textarea>
							<p class="alignR" style="margin-top:10px;">(<span class="smsStrCnt" >0</span>/80) Byte</p>
						</td>
						<td>받는 전화번호:<br>
							   <input type="text" name="tranPhone" id="tranPhone" size="20" class="input" value="">
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
