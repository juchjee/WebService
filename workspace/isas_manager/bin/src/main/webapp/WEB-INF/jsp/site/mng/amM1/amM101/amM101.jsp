<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<script type="text/javaScript" defer="defer">
<!--
	var contUrl = "${rootUri}${conUrl}amM101";

	function fnInsert(){
		if(confirm('<spring:message code="common.regist.msg"/>')){
			var obj = {
					"mbrLevNm" : $("#mbrLevNmI").val(),
					"mbrLevNo" : $("#mbrLevNoI").val(),
					"mbrLevAmot" : $("#mbrLevAmotI").val()
				};
			makeForm(contUrl + "I.do", obj);
		}
		return false;
	}

	function fnDelete(id){
		if(confirm('<spring:message code="common.delete.msg"/>')){
			var obj = {"mbrLevCd" : id};
			makeForm(contUrl + "D.do", obj);
		}
		return false;
	}
	function fnUpdate(id){
		if(confirm('<spring:message code="common.update.msg"/>')){
			if(id){
				var obj = {
						"mbrLevCd" : id,
						"mbrLevNo" : $("#" + id).find("input[name='mbrLevNo']").val(),
						"mbrLevAmot" : $("#" + id).find("input[name='mbrLevAmot']").val()
					};
				makeForm(contUrl + "U.do", obj);
			}
		}
		return false;
	}

//-->
</script>
</head>

<body>
<!-- 	<div class="top_box"> -->
<!-- 		<div class="text_type"> -->
<!-- 			<p> -->
<!-- 				회원 등급은 회원 가입일로부터 1년 기간의 상품구매 총합을 기준으로 1개월마다 재갱신 됩니다.<br />구간의 설정은 -->
<!-- 				중복 되지 않게 설정하여 주십시오 -->
<!-- 			</p> -->
<!-- 			<div> -->
<!-- 				<div class="serach_type"> -->
<!-- 					<ul> -->
<!-- 						<li> -->
<!-- 							<dl> -->
<!-- 								<dt>회원등급명</dt> -->
<!-- 								<dd> -->
<!-- 									<input id="mbrLevNmI" type="text" style="width: 108px;" /> -->
<!-- 								</dd> -->
<!-- 							</dl> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<dl> -->
<!-- 								<dt>등급레벨</dt> -->
<!-- 								<dd> -->
<!-- 									<input id="mbrLevNoI" type="text" class="alignC" style="width: 59px;" /> -->
<!-- 								</dd> -->
<!-- 							</dl> -->
<!-- 						</li> -->
<!-- 						<li> -->
<!-- 							<dl> -->
<!-- 								<dt>총합금액</dt> -->
<!-- 								<dd> -->
<!-- 									<input id="mbrLevAmotI" type="text" class="alignR" style="width: 129px;" /> 원 -->
<!-- 								</dd> -->
<!-- 							</dl> -->
<!-- 						</li> -->
<!-- 						<li><a class="btn_blue_line" href="#" onclick="return fnInsert();">등록</a></li> -->
<!-- 					</ul> -->
<!-- 				</div> -->
<!-- 			</div> -->
<!-- 		</div> -->
<!-- 		<!-- // text_type -->
<!-- 	</div> -->
	<!-- // top_box -->
	<div class="align_area">
		<div class="right">
			<p>총회원수 : <span class="validation[number]">${totalCount}</span>명</p>
		</div>
	</div>
	<!-- // align_area -->
	<div class="table_type1">
		<table>
			<caption>회원 등급명, 할인률, 년간 총구매금, 해당회원수, 관리로 구성된 회원등급관리에 대한 리스트 테이블 입니다.</caption>
			<colgroup>
				<col style="width: 25%;" />
				<col style="width: 22%;" />
				<col style="width: 30%;" />
				<col style="width: 23%;" />
<%-- 				<col style="width: 22%;" /> --%>
			</colgroup>
			<thead>
				<tr>
					<th scope="col">회원 등급명</th>
					<th scope="col">등급레벨</th>
					<th scope="col">년간 총구매금</th>
					<th scope="col">해당회원수</th>
<!-- 					<th scope="col">관리</th> -->
				</tr>
			</thead>
			<tbody>
			<c:forEach var="amM101Map" items="${amM101List}" varStatus="nStatus">
				<tr id="${amM101Map.mbrLevCd}">
					<td>${amM101Map.mbrLevNm}</td>
					<td><span class="validation[number]">${amM101Map.mbrLevNo}</span><!-- <input name="mbrLevNo" type="text" class="alignC" style="width: 44px;" value="${amM101Map.mbrLevNo}" readonly="readonly" />--></td>
					<td class="alignR"><span class="validation[number]">${amM101Map.mbrLevAmot}</span><!-- <input name="mbrLevAmot" type="text" class="alignR" style="width: 104px;" value="${amM101Map.mbrLevAmot}" readonly="readonly" />-->원 이상</td>
					<td class="alignR"><span class="validation[number]">${amM101Map.mbrLevCdCnt}</span></td>
<!-- 					<td> -->
<!-- 						<div class="btn_area_table"> -->
<!-- 							<div class="center"> -->
<%-- 								<a class="btn_type1" href="#" onclick="return fnDelete('${amM101Map.mbrLevCd}');">삭제</a> --%>
<%-- 								<a class="btn_type1" href="#" onclick="return fnUpdate('${amM101Map.mbrLevCd}');">수정</a> --%>
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</td> -->
				</tr>
			</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- // table_type1 -->
</body>