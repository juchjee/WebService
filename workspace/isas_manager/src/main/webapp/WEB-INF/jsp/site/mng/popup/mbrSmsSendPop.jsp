<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />
	<script type="text/javascript">

		function init(){
			fnSearch();
			fnEvent();
		}

		function fnSearch(){
			var url = "/mng/popup/mbrSmsList.action";
			var source =
            {
				datatype: "json"
	    		,datafields: [
                    { name: 'mbrId' },
                    { name: 'mbrNm' }
                ]
                ,url: url
                ,data:{idArr : '${idArr}', nmArr : '${nmArr}'}
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
			$("#listbox").jqxListBox({ source: dataAdapter, displayMember: "mbrId", valueMember: "mbrNm"});

			var url = "/mng/popup/mbrSmsTemp.action";
			var source =
		    {
		     datatype: "json"
		     ,datafields: [
		             { name: 'msgRoleNm' },
		             { name: 'msgRoleCd' },
		             { name: 'smsCont' },
		             { name: 'smsAttr' }
		         ]
		         ,url: url
		     };
		     var dataAdapter = new $.jqx.dataAdapter(source);
			 $("#listbox1").jqxListBox({ source: dataAdapter, displayMember: "msgRoleNm", valueMember: "smsAttr"});
		}

		// 이벤트 (검색/전체보기)
		function fnEvent(){
			$("textarea[name=smsCont]").bind("keyup",function(){
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

			$('#listbox1').on('select', function (event) {
				var item = $("#listbox1").jqxListBox('getSelectedItem');
				var valueArr = item.value.split("_");
				$("textarea[name=smsCont]").val(valueArr[1]);
				$("input[name=msgRoleCd]").val(valueArr[0]);
			});

			$.submit = function(){

				var idArr = [];
				<c:forEach items="${mbrSmsList}" var="mbrSmsList">
					idArr.push("${mbrSmsList.mbrId}");
				</c:forEach>
				$("#idArr").val(idArr);

				var smsCont = $("textarea[name=smsCont]").val();

				if(smsCont.length == 0){
					alert("저장할 문자를 입력해 주세요.");
					return;
				}
				if(smsCont.length > 80){
					alert("80자 이상은 MMS로 전송해주세요.");
					return;
				}
				document.workForm.submit();
			}
 		}

	</script>
</head>

<body class="noBg" style="height:542px;">
	 <form id="workForm" name="workForm" action="/mng/popup/mbrSmsSendPop.action" method="post" >
	 	<input type="hidden" name="condiTp" id="condiTp" value="SMS" />
	 	<input type="hidden" name="msgRoleCd" id="msgRoleCd"  />
	 	<input type="hidden" name="msgDivRc" id="msgDivRc"  value="SMS" />
		<input type="hidden" name="idArr" id="idArr" />
		<div class="popup_wrap">
			<h2>SMS 발송</h2>
			<div class="pageContScroll_st4">

			<div class="top_box">
				<div class="text_type">
					<c:forEach items="${msgVariableList}" var="msgVariable">
						<p style="padding:3px;">${msgVariable.msgVariableCd}<span class="colRed"> ----- ${msgVariable.msgVariableNm}</span></p>
					</c:forEach>
				</div>
			</div>

			<table style="margin-top:20px;">
				<colgroup>
					<col style="width:50%;">
					<col style="width:50%;">
				</colgroup>
				<tr>
					<td><h3>SMS 발송 회원</h3></td>
					<td><h3>SMS 발송 템플릿</h3></td>
				</tr>
			</table>
			<div id="eCopnPart4" class="table_type2">
				<table>
					<caption>발송에 대한 작성 테이블 입니다.</caption>
					<colgroup>
						<col style="width:50%;">
						<col style="width:50%;">
					</colgroup>
					<tbody>
						<tr>
							<td>
								<div id="listbox"></div>
							</td>
							<td>
								<div id="listbox1"></div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<div class="textarea_form" >
				<textarea name="smsCont" id="smsCont" style="font-size:14px; padding:5px; width:630px;height:120px;word-break:nowrap;" ></textarea>
			</div>
			<p class="alignR" style="margin-top:10px;">(<span class="smsStrCnt" >0</span>/80) byte</p>

			</div>

			<div class="btn_area">
				<div class="center">
					<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
					<a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">발송</a>
				</div>
			</div>
		</div>
	</form>
</body>
</html>
