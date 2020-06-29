<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<script type="text/javascript">

		function cateSave(mode,type){
			if($("#prodCategoryNm").val()==""){
				alert("카테고리명을 입력해주세요.");
				$("#prodCategoryNm").focus();
				return false;
			}
			if(mode=='regist'){
				if(confirm("등록하시겠습니까?")){
					frm = document.cateForm;
		  			frm.action = '<c:url value="/mng/amM2/amM203/amM203I.do"/>';
		    		frm.submit();
				} else {
					return false;
				}
			} else if(mode=='modify'){
				if(confirm("수정하시겠습니까?")){
					frm = document.cateForm;
		  			frm.action = '<c:url value="/mng/amM2/amM203/amM203U.do"/>';
		    		frm.submit();
				} else {
					return false;
				}
			}
		}

	</script>
</head>

<body class="noBg">
	<div class="popup_wrap">
		<c:if test="${mode == 'regist'}">
			<h2>상품카테고리 등록</h2>
		</c:if>
		<c:if test="${mode == 'modify'}">
			<h2>상품카테고리 수정</h2>
		</c:if>
		<div class="table_type2">
			<form id="cateForm" name="cateForm" action="" method="post">
			<input type="hidden" name="type" id="type" value="${type}" />
			<input type="hidden" name="mode" id="mode" value="${mode}" />
			<input type="hidden" name="code" id="code" value="${code}" />
			<table>
				<caption>구분, 카테고리명, 노출여부, 카테고리 제목 이미지, 코드명으로 구성된 상품카테고리 등록에 대한 작성 테이블 입니다.</caption>
				<colgroup>
					<col style="width:20%;" />
					<col style="width:80%;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">구분</th>
						<td>
							<c:choose>
								<c:when test="${type eq 'large'}">
									대분류
								</c:when>
								<c:otherwise>
									<div>
									<c:if test="${type eq 'medium'}">
										<c:if test="${mode eq 'modify'}">
											<c:forEach var="amM203LMap" items="${amM203L}" varStatus="nStatus">
												<c:if test="${amM203LMap.prodCategoryCd eq amM203Detail.prodCategoryGrpCd}">
													<c:out value="${amM203LMap.prodCategoryNm}" />
												</c:if>
											</c:forEach>
										</c:if>
										<c:if test="${mode eq 'regist'}">
											<c:out value="${amM203Detail.prodCategoryNm}" />
											<input type="hidden" id="prodCategoryCd" name="prodCategoryCd" value="${amM203Detail.prodCategoryCd}" />
										</c:if>
									</c:if>
									<c:if test="${type eq 'small'}">
										<c:if test="${mode eq 'modify'}">
											<c:forEach var="amM203LMap" items="${amM203L}" varStatus="nStatus">
												<c:if test="${amM203LMap.prodCategoryCd eq amM203SDetail.prodCategoryGrpCd}">
													<c:out value="${amM203LMap.prodCategoryNm}" />&nbsp;>&nbsp;<c:out value="${amM203SDetail.prodCategoryNm}" />
												</c:if>
											</c:forEach>
										</c:if>
										<c:if test="${mode eq 'regist'}">
											<c:forEach var="amM203LMap" items="${amM203L}" varStatus="nStatus">
												<c:if test="${amM203LMap.prodCategoryCd eq amM203Detail.prodCategoryGrpCd}">
													<c:out value="${amM203LMap.prodCategoryNm}" />&nbsp;>&nbsp;<c:out value="${amM203Detail.prodCategoryNm}" />
												</c:if>
											</c:forEach>
											<input type="hidden" id="prodCategoryCd1" name="prodCategoryCd1" value="${amM203Detail.prodCategoryCd}" />
										</c:if>
									</c:if>
								</div>
								</c:otherwise>
							</c:choose>
						</td>
					</tr>
					<tr>
						<th scope="row">카테고리명</th>
						<td>
							<c:if test="${mode == 'modify'}">
								<input type="text" name="prodCategoryNm" id="prodCategoryNm" value="${amM203Detail.prodCategoryNm}" style="width:259px;" />
							</c:if>
							<c:if test="${mode == 'regist'}">
								<input type="text" name="prodCategoryNm" id="prodCategoryNm" style="width:259px;" />
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">노출여부</th>
						<td>
							<c:if test="${mode == 'regist'}">
								<input type="radio" id="viewY" name="prodCategoryDisYn" value="Y" checked="checked" class="marL5" /><label for="viewY" class="marR10">노출</label>
								<input type="radio" id="viewN" name="prodCategoryDisYn" value="N" class="marL5" /><label for="viewN">비노출</label>
							</c:if>
							<c:if test="${mode == 'modify'}">
								<input type="radio" id="viewY" name="prodCategoryDisYn" value="Y" <c:if test="${amM203Detail.prodCategoryDisYn == 'Y'}">checked="checked"</c:if> class="marL5" /><label for="viewY" class="marR10">노출</label>
								<input type="radio" id="viewN" name="prodCategoryDisYn" value="N" <c:if test="${amM203Detail.prodCategoryDisYn == 'N'}">checked="checked"</c:if> class="marL5" /><label for="viewN">비노출</label>
							</c:if>
						</td>
					</tr>
				</tbody>
			</table>
			</form>
		</div>
		<!-- // table_type2 -->
		<div class="btn_area">
			<div class="center">
				<c:if test="${mode == 'regist'}">
					<a class="btn_blue_line2" href="#" onclick="cateSave('${mode}','${type}');">카테고리 등록</a>
				</c:if>
				<c:if test="${mode == 'modify'}">
					<a class="btn_blue_line2" href="#" onclick="cateSave('${mode}','${type}');">카테고리 수정</a>
				</c:if>
				<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">닫기</a>
			</div>
		</div>
		<!-- // btn_area -->
	</div>
	<!-- // popup_wrap -->
</body>

</html>
