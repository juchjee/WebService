<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />

	<!-- 마케팅관리 : 이메일관리 -->
<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
<script type="text/javaScript" defer="defer">

	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	 var oEditors = [];

	 function init(){
		fnSearch();
	 	fnEvent();
	 	fnDataSetting();
	 }

		function fnSearch(){
			var url = "/mng/popup/mbrEmailList.action";
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

			var url = "/mng/popup/mbrTempList.action";
			var source =
		    {
		     datatype: "json"
		     ,datafields: [
		             { name: 'msgRoleNm' },
		             { name: 'msgRoleCd' },
		             { name: 'mailCont' },
		             { name: 'mailAttr' }
		         ]
		         ,url: url
		     };
		     var dataAdapter = new $.jqx.dataAdapter(source);
			 $("#listbox1").jqxListBox({ source: dataAdapter, displayMember: "msgRoleNm", valueMember: "mailAttr"});
		}

		// 이벤트
		function fnEvent(){
			$('#listbox1').on('select', function (event) {
				oEditors.getById["mailCont"].exec("SET_CONTENTS", [""]);
				var item = $("#listbox1").jqxListBox('getSelectedItem');
				var valueArr = item.value.split("_");
				$("input[name=mailTitle]").val(item.label);
				oEditors.getById["mailCont"].exec("PASTE_HTML", [decodeTag(valueArr[1])]);
				$("input[name=msgRoleCd]").val(valueArr[0]);
			});

			$.submit = function(){

				var idArr = [];
				<c:forEach items="${mbrEmailList}" var="mbrEmailList">
					idArr.push("${mbrEmailList.mbrId}");
				</c:forEach>
				$("#idArr").val(idArr);

				oEditors.getById["mailCont"].exec("UPDATE_CONTENTS_FIELD", []);
				oEditors.getById["mailFooterCont"].exec("UPDATE_CONTENTS_FIELD", []);

				fnSubmit("workForm","발송");
				//document.workForm.submit();
			}
		}

		function fnDataSetting(){
			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "mailCont",
				sSkinURI: "/SE/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				},
				fCreator: "createSEditor2"
			});

			nhn.husky.EZCreator.createInIFrame({
				oAppRef: oEditors,
				elPlaceHolder: "mailFooterCont",
				sSkinURI: "/SE/SmartEditor2Skin.html",
				htParams : {
					bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
					bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
				},
				fCreator: "createSEditor2"
			});

		}

	</script>
</head>

<body class="noBg" >
	 <form id="workForm" name="workForm" action="/mng/popup/mbrEmailSendPop.action" method="post" >
	 	<input type="hidden" name="condiTp" id="condiTp" value="MAIL" />
	 	<input type="hidden" name="msgDivRc"  value="C"/>
	 	<input type="hidden" name="msgRoleCd" />
	 	<input type="hidden" name="idArr" id="idArr" />
		<div class="popup_wrap">
			<h2>이메일 발송</h2>
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
					<td><h3>이메일 발송 회원</h3></td>
					<td><h3>이메일 발송 템플릿</h3></td>
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

			<h3 style="margin-top:20px;">메일 제목</h3>
					<input name="mailTitle"  class="validation[required]"style="font-size:14px; padding:5px; width:745px;height:30px;" />

			<h3 style="margin-top:20px;">메일 내용</h3>
					<textarea name="mailCont" id="mailCont" class="validation[required]" title="이메일내용"  style="width:100%; height:200px; display:none;"></textarea>
			<h3 style="margin-top:20px;">메일 Footer</h3>
					<textarea name="mailFooterCont" id="mailFooterCont" class="validation[required]" title="이메일Footer"  style="width:100%; height:200px; display:none;">${footerCont.mailFooterCont}</textarea>
			</div>
			<div class="btn_area">
				<div class="center">
					<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
					<a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">발송</a>
				</div>
			</div>
			<!-- // btn_area -->
		</div>
		<!-- // popup_wrap -->
	</form>
</body>
</html>
