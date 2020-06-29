<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />
	<script type="text/javascript">

		var contUrl = "${rootUri}${conUrl}amM704";

		function init(){
			fnSearchInit();
			fnEvent();
			fnDataSet();
			$("#boardTpStyle").change();
		}

		function fnSearchInit(){

		}

		function fnEvent(){
			$(".saveBtn").click(function(){
				if($("input[name='boardStatusYn']:checked").length < 1){
					alert("상태를 선택하세요.");
					return;
				}
				if($("input[name='boardFuncCd']:checked").length < 1){
					$("#funcCd").val("N");
				}
				<c:if test="${empty boardDetail}">
				if($("#cateMpg > li").length==0){
					$("#cateIn").val($("input[name='boardMstNm']").val());
					$(".fieldBtn").click();
					//alert("분류구분을 입력하세요.");
					//$("#cateIn").focus();
					//return;
				}
				</c:if>
				fnSubmit("workForm","저장");
			});

			$(".fieldBtn").click(function(){
				var diviValue = $("#cateIn").val();
				if(diviValue==""){
					alert("분류구분을 입력해주세요.");
					$("#cateIn").focus();
					return false;
				}
				$("#workForm").append(makeInput("cateMpgArr", diviValue));
				$("#cateMpg").append("<li><div>"+diviValue+"<a class=\"\" href=\"javascript:;\"><img src=\"${rootUri}images/btn_keyword_del.png\" alt=\"카테고리 삭제\"></a></div></li>");
				$("#cateIn").val("");
				$("#cateMpg a").bind("click",function() {
					var idx = $("#cateMpg a").index(this);
					$("#workForm").find("input[name='cateMpgArr']").eq(idx).remove();
					$("#cateMpg > li").eq(idx).remove();
				});

			});

			$("#cateMpg a").bind("click",function() {
				var idx = $("#cateMpg a").index(this);
				$("#workForm").find("input[name='cateMpgArr']").eq(idx).remove();
				$("#cateMpg > li").eq(idx).remove();
			});

			$("#cateMpgNow a").bind("click",function() {
				var idx = $("#cateMpgNow a").index(this);
				if(confirm("해당 구분을 삭제하시면 게시판관리에 구분과 관련된 내용이 노출되지않습니다.정말로 삭제하시겠습니까?")){
					var params = {"boardCateSeq" : $(".boardCateSeq").eq(idx).val()};
					var fnKeyDelSuccess =  function(data, dataType){
						var data = data.replace(/\s/gi,'');
						var returnData = "";
						if(data == "ng"){
							alert("정지에 실패하였습니다.");
						}else{
							alert("정상적으로 정지되었습니다.");
						}
					};
					fnAjax("amM706CD.action", params, fnKeyDelSuccess, "post", "text", "false");
					$("#cateMpgNow > li").eq(idx).remove();
				} else {
					return false;
				}
			});


			$("#boardTpStyle").bind("change",function() {
				if($("select[name=boardTpStyle]").val() =="uni"){
					$("input[name=boardFuncCd]:checkbox").attr("disabled", true);
				}else{
					$("input[name=boardFuncCd]:checkbox").removeAttr("disabled");
				}
			});
			
			$("#boardTpStyle").bind("change",function() {
				fnAjax("boardTpCdSearch.action", {"boardTpStyle" : $("select[name=boardTpStyle]").val()}, function(data, dataType){
					$("#boardTpCd").html("");
					for (key in data) {
							if(data[key].boardTpCd == "${boardDetail.boardTpCd}"){
								$("#boardTpCd").append("<option value='"+data[key].boardTpCd+"' selected='selected'>"+data[key].boardTpNm+"</option>");
							}else{
								$("#boardTpCd").append("<option value='"+data[key].boardTpCd+"'>"+data[key].boardTpNm+"</option>");
							}
					}
					
					},'POST','json');
			});
			
		}

		function fnDataSet(){
			<c:forEach items="${skillmpg}" var="skillmpg">
			 $("input[name=boardFuncCd]:checkbox[value='${skillmpg.boardFuncCd}']").attr("checked",true);
			</c:forEach>
			$("#boardTpStyle").change();
		}
		
	

	</script>
</head>
<body class="noBg">
	<div class="popup_wrap">
		<c:if test="${empty boardDetail}">
			<h3>프로그램 등록</h3>
		</c:if>
		<c:if test="${!empty boardDetail}">
			<h3>프로그램 수정</h3>
		</c:if>
		<form id="workForm" name="workForm" action="amM706PSave.action" method="post" >
		<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardDetail.boardMstCd}" />
		<input type="hidden" name="funcCd" id="funcCd" />
		<div class="table_type2">
			<table>
				<caption>게시판명, URL, 게시판유형, 상태, 분류구분, 기능설정, 최초 등록자, 최초 등록일, 최근 수정자, 최근 수정일로 구성된 게시판 등록에 대한 작성 테이블 입니다.</caption>
				<colgroup>
					<col style="width:15%;" />
					<col style="width:35%;" />
					<col style="width:15%;" />
					<col style="width:35%;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">프로그램명</th>
						<td>
							<input type="text" id="boardMstNm" name="boardMstNm" value="${boardDetail.boardMstNm}" class="validation[required]" title="게시판명" style="width:154px" />
						</td>
						<th scope="row">상태</th>
						<td>
							<c:if test="${empty boardDetail}">
								<input type="radio" name="boardStatusYn" value="Y" class="marR5" checked="checked" /><label for="fn1" class="marR15">사용</label>
								<input type="radio" name="boardStatusYn" value="N" class="marR5" /><label for="fn2" class="marR15">미사용</label>
							</c:if>
							<c:if test="${!empty boardDetail}">
								<input type="radio" name="boardStatusYn" value="Y" class="marR5" <c:if test="${boardDetail.boardStatusYn eq 'Y'}">checked</c:if> /><label for="fn1" class="marR15">사용</label>
								<input type="radio" name="boardStatusYn" value="N" class="marR5" <c:if test="${boardDetail.boardStatusYn eq 'N'}">checked</c:if> /><label for="fn2" class="marR15">미사용</label>
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">관리자메뉴명</th>
						<td>
							<select id="admMenuCd" name="admMenuCd" style="width: 113px;">
								<c:forEach items="${admMenuList}" var="admMenu">
									<option value="${admMenu.admMenuCd}" <c:if test="${admMenu.admMenuCd eq boardDetail.admMenuCd}">selected='selected'</c:if> >${admMenu.admMenuNm}</option>
								</c:forEach>
								<option value="N/A" <c:if test="${'N/A' eq boardDetail.admMenuCd}">selected='selected'</c:if>>프론트전용</option>
							</select>
						</td>
						<th scope="row">유형 / 종류</th>
						<td>
							<select id="boardTpStyle" name="boardTpStyle" style="width: 113px;">
								<option value="bbs" <c:if test="${'bbs' eq boardDetail.boardTpStyle}">selected='selected'</c:if>>확장프로그램</option>
								<option value="uni" <c:if test="${'uni' eq boardDetail.boardTpStyle}">selected='selected'</c:if>>단일프로그램</option>
							</select>	
						
							<select id="boardTpCd" name="boardTpCd" style="width: 113px;">
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">기능설정 </th>
						<td>
							<c:forEach items="${skillList}" var="skillList">
								<input type="checkbox" id="boardFuncCd" name="boardFuncCd" value="${skillList.boardFuncCd}" class="marR5" />
								<label for="fn1" class="marR15">${skillList.boardFuncNm}</label>
							</c:forEach>
						</td>
						<th scope="row"></th>
						<td>
<%-- 							<c:if test="${empty boardDetail}"> --%>
<!-- 								<input type="radio" name="boardProdYn" value="Y" class="marR5" /><label for="fn1" class="marR15">사용</label> -->
<!-- 								<input type="radio" name="boardProdYn" value="N" class="marR5" checked="checked" /><label for="fn2" class="marR15">미사용</label> -->
<%-- 							</c:if> --%>
<%-- 							<c:if test="${!empty boardDetail}"> --%>
<%-- 								<c:if test="${boardDetail.boardMstCd eq 'BBM00005' || boardDetail.boardMstCd eq 'BBM00006'}"> --%>
<%-- 									<input type="radio" name="boardProdYn" value="Y" class="marR5" <c:if test="${boardDetail.boardProdYn eq 'Y'}">checked</c:if> /><label for="fn1" class="marR15">사용</label> --%>
<%-- 									<input type="radio" name="boardProdYn" value="N" class="marR5" <c:if test="${boardDetail.boardProdYn eq 'N'}">checked</c:if> /><label for="fn2" class="marR15">미사용</label> --%>
<%-- 								</c:if> --%>
<%-- 							</c:if> --%>
						</td>
					</tr>
					<c:if test="${!empty boardDetail}">
						<tr>
							<th scope="row">분류구분</th>
							<td colspan="3">
								<div class="add_field">
									<div class="field_ul">
										<ul id="cateMpgNow">
											<c:if test="${!empty boardDetail}">
									      		<c:forEach items="${catempg}" var="catempg">
									        		<li>
									        			<div>${catempg.boardCateNm}<a  href="javascript:;"><img src="${rootUri}images/btn_keyword_del.png" alt="카테고리 삭제"></a></div>
									        			<input type="hidden" class="boardCateSeq" name="boardCateSeq" value="${catempg.boardCateSeq}" />
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
						<tr style="height:150px;"valign="top">
							<th scope="row">분류추가</th>
							<td colspan="3">
								<div class="add_field">
									<input type="text" id="cateIn" style="width154px;" />
									<a class="fieldBtn btn_type1" href="#">필드추가</a>
									
									<!-- // field_ul -->
								</div>
								<div class="field_ul" style="margin-top:10px;">
										<ul id="cateMpg"></ul>
									</div>
							</td>
						</tr>
				</tbody>
			</table>
		</div>
		</form>
		<!-- // table_type2 -->
		<div class="btn_area">
			<div class="center">
				<c:if test="${empty boardDetail}">
					<a class="saveBtn btn_blue_line2" href="javascript:;">저장</a>
				</c:if>
				<c:if test="${!empty boardDetail}">
						<a class="saveBtn btn_blue_line2" href="javascript:;">수정</a>
						<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">닫기</a>
				</c:if>
			</div>
		</div>
	</div>

</body>