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
		function saveFormData(){
			$('#jqxLoader').jqxLoader({ width: 250, height: 100, autoOpen: true, isModal: true, text:'저장중입니다. 잠시만 기다려주세요!'});
			$("form[name='saveForm']").submit();
		}
	</script>
</head>
<body class="noBg" style="height:710px;">
	<div class="popup_wrap">
		<h2>CS상담 상세</h2>
	<div class="pageContScroll_st4">
		<div class="table_type2">
		<form name="saveForm" id="saveForm" action="amM501S.action">
			<input type="hidden" name="csNo" value="${viewMap.csNo}">
			<input type="hidden" name="mbrId" value="${viewMap.csMbrId}">
			<table>
				<caption>유입경로, 상담유형, 문의자, 상담일, 문의내용, 답변내용, 처리결과, 처리점수, 최초 등록자, 최초 등록일, 최근 수정자, 최근 수정일로 구성된 제품문의관리에 대한 등록 테이블 입니다.</caption>
				<colgroup>
					<col style="width:12%;">
					<col style="width:42%;">
					<col style="width:12%;">
					<col style="width:43%;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">유입경로</th>
						<td>
							 <html:selectList name='csFunnel' id='csFunnel' list='${csFunnelList}' listValue='csTypeCd' listName='csTypeNm'
							 selectedValue="${viewMap.csFunnel}"/>
						</td>
						<th scope="row">상담유형</th>
						<td>
							<html:selectList name='csType' id='csType' list='${csTypeList}' listValue='csTypeCd' listName='csTypeNm'
							 selectedValue="${viewMap.csType}"/>
						</td>
					</tr>
					<tr>
						<th scope="row">문의자</th>
						<td><input type="text" name="caNonMbrNm" value="${viewMap.caNonMbrNm}" /></td>
						<th scope="row">전화번호</th>
						<td><input type="text" name="caNonMbrTel" value="${viewMap.caNonMbrTel}" /></td>
					</tr>
					<tr>
						<th scope="row">콜유형</th>
						<td><html:radio name="csCall" text="인바운드|아웃바운드" value="I|O" checkedValue="${viewMap.csCall}" defaultValue="I"/>
						</td>
						<th scope="row">상담일</th>
						<td>
							<c:out value="${viewMap.csDt}" />
						</td>
					</tr>
					<tr>
						<th scope="row">문의내용</th>
						<td colspan="3">
							<textarea name="csQuestion" style="width:100%;height:200px;font-size: 12px;padding:10px 0 10px 5px;">${viewMap.csQuestion}</textarea>
						</td>
					</tr>
					<tr>
						<th scope="row">답변내용</th>
						<td colspan="3">
							<textarea name="csConsult" style="width:100%;height:200px;font-size: 12px;padding:10px 0 10px 5px;">${viewMap.csConsult}</textarea>
						</td>
					</tr>
					<%-- <tr>
						<th scope="row">최초 등록자</th>
						<td>
							<c:out value="${viewMap.caMbrId}" />&nbsp;&nbsp;&nbsp;(&nbsp;<c:out value="${viewMap.mbrNm}" />&nbsp;)
						</td>
						<th scope="row">최초 등록일</th>
						<td>
							<c:out value="${viewMap.csDt}" />
						</td>
					</tr>
					<tr>
						<th scope="row">최근 수정자</th>
						<td>
							<c:out value="${viewMap.modId}" />&nbsp;&nbsp;&nbsp;(&nbsp;<c:out value="${viewMap.modNm}" />&nbsp;-&nbsp;<c:out value="${viewMap.modMa}" />&nbsp;)
						</td>
						<th scope="row">최근 수정일</th>
						<td>
							<c:out value="${viewMap.modDt}" />
						</td>
					</tr> --%>
				</tbody>
			</table>
			</form>
		</div>
		</div>

		<div class="btn_area">
		<div class="center">
			<a class="btn_blue_line2" href="javascript:saveFormData();">수정</a>
			<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">닫기</a>
		</div>
	</div>
	</div>

</body>
</html>