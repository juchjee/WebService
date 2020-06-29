<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
<style type="text/css">
textarea{resize:none; line-height:1.5em; }
</style>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />

	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
	<!-- 게시판관리 : 공지사항 등록 -->
	
<script type="text/javaScript" defer="defer">

	var oEditors = [];
	var contUrl = "${rootUri}${conUrl}locStoreS";

	function init(){

		  fnEvent();

		  fnDataSetting();
	}

	function fnEvent(){
		$(".fieldBtn").click(function(){
			var diviValue = $("#addressLev1").val();
			var diviValue2 = $("#addressLev2").val();
			if(diviValue==""){
				alert("관할지역(도/시)를 선택해주세요.");
				$("#addressLev1").focus();
				return false;
			} 
			
			if(diviValue2==""){
				alert("관할지역(시/군/구)를 선택해주세요.");
				$("#addressLev1").focus();
				return false;
			}
			$("#workForm").append(makeInput("addressLevArr", diviValue+","+diviValue2));
			$("#cateMpg").append("<li><div>"+diviValue+' '+diviValue2+"<a class=\"\" href=\"javascript:;\"><img src=\"${rootUri}images/btn_keyword_del.png\" alt=\"관할지역 삭제\"></a></div></li>");
			
			$("#cateMpg a").bind("click",function() {
				var idx = $("#cateMpg a").index(this);
				$("#workForm").find("input[name='addressLevArr']").eq(idx).remove();
				$("#cateMpg > li").eq(idx).remove();
			});

		});
		
		
		
		$.submit = function(){
			<c:if test="${empty viewMap.mapStoreId}">
			if($("input[name=addressLevArr]").length == undefined || $("input[name=addressLevArr]").length == 0 ){
				alert("관할지역을 한개 이상 추가하셔야합니다.");
				return;
			}
			</c:if>
			fnSubmit("workForm","저장");
		}

		$(".popup_wrap > h2").text(parent.$("#tit_depths0").text()+" 등록/수정");

		

		$("#addressLev1").bind("change",function(){
			fnAjax("${rootUri}${conUrl}zipcodeSearch.action", {"addressLev1":$("#addressLev1").val()},
					function(data, dataType){
						if($("#addressLev1").val() == ""){
							$("#addressLev1").html("<option value=''>도/시 선택</option>");
							
							for (key in data) {
								$("#addressLev1").append("<option value='"+data[key].addressLev1+"'>"+data[key].addressLev1+"</option>");
							}
						}else{
							$("#addressLev2").html("<option value=''>시/군/구 선택</option>");
							
							for (key in data) {
								$("#addressLev2").append("<option value='"+data[key].addressLev2+"'>"+data[key].addressLev2+"</option>");
							}
						}
					},"POST"
				);
		});
		
		$("#addressMpgNow a").bind("click",function() {
			var idx = $("#addressMpgNow a").index(this);
			if(confirm("해당 관할지역을 삭제하시겠습니까?")){
				var params = {"addressLev" : $(".addressLev").eq(idx).val(),"mapStoreId":$("#mapStoreId").val()};
				fnAjax("mapdel.action", params, function(data, dataType){
					var data = data.replace(/\s/gi,'');
					var returnData = "";
					if(data == "ng"){
						alert("삭제에 실패하였습니다.");
					}else{
						alert("정상적으로 삭제되었습니다.");
					}
				}, "post", "text", "false");
				$("#addressMpgNow > li").eq(idx).remove();
			} else {
				return false;
			}
		});
	}

	function fnDataSetting(){
		$("#addressLev1").change();
		
		$("input[name=mapStoreItem]").each(function(index, value){
			<c:forEach items="${storeCateList}" var="storeCate" varStatus="loop">
			if($(this).val() == '${storeCate.boardCateSeq}'){
				$(this).attr("checked",true);
			}
			</c:forEach>
		});
	}
</script>
</head>
<body class="noBg" style="min-width:680px;" >
	<div class="popup_wrap" style="padding: 27px 17px 0px;">
		<h2></h2>
			<div class="table_type2">
			<form id="workForm" name="workForm" action="mapSave.action" method="post" >
				<input type="hidden" name="boardMstCd" id="boardMstCd" value="${param.boardMstCd}" />
				<input type="hidden" name="mapStoreId" id="mapStoreId" value="${viewMap.mapStoreId}" />
				<table>
					<caption>분류, 작성일, 제목, 내용, 첨부파일, 최초 등록자, 최초 등록일, 최근 수정자, 최근 수정일로 구성된 공지사항관리에 대한 등록 테이블 입니다.</caption>
					<colgroup>
						<col style="width:12%;">
						<col style="width:42%;">
						<col style="width:12%;">
						<col style="width:43%;">
					</colgroup>
					<tbody>
						<c:if test="${fn:length(cateList) > 1}">
						<tr>
							<th scope="row">취급품목</th>
							<td>
							<div class="option_ul">
								<ul>
									<c:forEach items="${cateList}" var="cateList" varStatus="loop">
										<li style="margin-left:0px;"><input name="mapStoreItem" id="cate${loop.index}" type="checkbox" class="validation[choose]" title="취급품목" value="${cateList.boardCateSeq}" />&nbsp;<label for="cate${loop.index}" class="marR15">${cateList.boardCateNm}</label> </li>
									</c:forEach>
								</ul>
							</div>
							</td>
						</tr>
						</c:if>
						<tr>
							<th scope="row">매장명</th>
							<td colspan="3">
								<input type="text" name="mapStoreTitle" id="mapStoreTitle" class="validation[required]" title="제목" value="${viewMap.mapStoreTitle}" style="width:80%;">
							</td>
						</tr>
						
						<c:if test="${!empty viewMap}">
						<tr>
							<th scope="row">관할지역</th>
							<td colspan="3">
								<div class="add_field">
									<div class="field_ul">
										<ul id="addressMpgNow">
											<c:if test="${!empty addressmpgList}">
									      		<c:forEach items="${addressmpgList}" var="addressmpg">
									        		<li>
									        			<div>${addressmpg.addressLev1} ${addressmpg.addressLev2}<a  href="javascript:;"><img src="${rootUri}images/btn_keyword_del.png" alt="관할지역 삭제"></a></div>
									        			<input type="hidden" class="addressLev" name="addressLev" value="${addressmpg.addressLev1},${addressmpg.addressLev2}" />
									        		</li>
									        	</c:forEach>
											</c:if>
										</ul>
									</div>
									<!-- // field_ul -->
								</div>
							</td>
						</tr>
						</c:if>
						<tr>
							<th scope="row">관할지역 추가</th>
							<td colspan="3" style="height:73px;"valign="top">
								<select name="addressLev1" id="addressLev1"  title="관할지역(도/시)" ><option value="">도/시 선택</option></select>
								<select name="addressLev2" id="addressLev2" title="관할지역(시/군/구)" ><option value="">시/군/구 선택</option></select>
								<a class="fieldBtn btn_type1" href="#">추가</a>
									<div class="field_ul" style="margin-top:10px;">
										<ul id="cateMpg"></ul>
									</div>
							</td>
						</tr>
						<tr>
							<th scope="row">주소</th>
							<td colspan="3">
								<input type="text" name="mapStoreAddr" id="mapStoreAddr" class="validation[required]" title="주소" value="${viewMap.mapStoreAddr}" style="width:80%;" >
							</td>
						</tr>
						<tr>
							<th scope="row">위치정보</th>
							<td colspan="3">
								위도 : <input type="text" name="pointX" id="pointX" class="validation[required]" title="위도" value="${viewMap.pointX}" style="width:150px;">
								&nbsp;&nbsp;&nbsp;경도 : <input type="text" name="pointY" id="pointY" class="validation[required]" title="제목" value="${viewMap.pointY}" style="width:150px;">
							</td>
						</tr>
						<tr>
							<th scope="row">전화번호</th>
							<td colspan="3">
								<input type="text" name="mapStorePhone" id="mapStorePhone" class="validation[required,telNo]" title="전화번호" value="${viewMap.mapStorePhone}" style="width:200px;">
							</td>
						</tr>
						<tr>
							<th scope="row">안내</th>
							<td colspan="3">
								<div>
									<div style="border:1px solid #dedede;padding:10px;background:#fff;">
										<textarea name="mapEtc" id="mapEtc" style="border:0px;width:100%; height:150px;">${viewMap.mapEtc}</textarea>
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
			</div>
	</div>
	<div class="btn_area">
		<div class="center">
			<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">취소</a>

			<a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">
				<c:if test="${not empty viewMap.boardSeq}">수정</c:if>
				<c:if test="${empty viewMap.boardSeq}">등록</c:if>
			</a>
		</div>
	</div>
	<!-- // table_type2 -->

</body>
</html>