<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<script type="text/javaScript" defer="defer">
<!--
	var contUrl = "${rootUri}${conUrl}amM105";

	function fnUpdate(id,yn,state){
		if(state=="U"){
			if(confirm('포인트 정책을 적용하시겠습니까?')){
				if(id){
					var obj = {
							"ptCd" : id,
							"userYn" : yn
					};
					makeForm(contUrl + "U.do", obj);
				}
			}
			return false;
		}else{
			if(confirm('사용중인 포인트 정책을 해지 하시겠습니까?')){
				if(id){
					var obj = {
							"ptCd" : id,
							"userYn" : yn
					};
					makeForm(contUrl + "U.do", obj);
				}
			}
			return false;
		}
	}

	function fnPupdate(id,num){
		if(confirm('포인트를 수정하시겠습니까?')){
			if(id){
				var obj = {
						"ptCd" : id,
						"ptScore" : $("#ptScore"+num).val()
				};
				makeForm(contUrl + "PU.do", obj);
			}
		}
		return false;
	}

//-->
</script>
</head>

<body>
	<div class="top_box">
		<div class="text_type">
			<p>
				포인트의 적용은 적용 가능 리스트에서 포인트를 설정하시고 적용 버튼을 클릭하시면 해당 포인트 적립이 시행됩니다.<br />포인트
				적립해지는 미적용 버튼을 클릭하시면 적용이 해지됩니다. 미적용 변경시 기존 발생 포인트는 변경 되지 않습니다.
			</p>
		</div>
		<!-- // text_type -->
	</div>
	<!-- // top_box -->
	<div class="table_type1">
		<table>
			<caption>포인트명, 포인트, 이용상태, 포인트타입으로 구성된 포인트 정책관리에 대한 리스트
				테이블 입니다.</caption>
			<colgroup>
				<col style="width: 20%;" />
				<col style="width: 15%;" />
				<col style="width: 10%;" />
				<col style="width: 30%;" />
				<col style="width: 10%;" />
				<col style="width: 15%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">포인트명</th>
					<th scope="col">포인트</th>
					<th scope="col">이용상태</th>
					<th scope="col">포인트타입</th>
					<th scope="col"></th>
					<th scope="col"></th>
				</tr>
			</thead>
			<tbody>
				<c:forEach items="${amM105List}" var="amM105List" varStatus="status">
					<tr>
						<td><c:out value="${amM105List.ptNm}"/></td>
						<td><input type="text" name="ptScore" id="ptScore${status.count}" class="alignR" style="width: 69px;" value="${amM105List.ptScore}" /></td>
						<td>
							<c:if test="${amM105List.ptRfctYn eq 'Y'}">사용중</c:if>
							<c:if test="${amM105List.ptRfctYn eq 'N'}">미사용</c:if>
						</td>
						<td><c:out value="${amM105List.ptRfctEx}"/></td>
						<td><a class="btn_type1" href="javascript:;" onclick="return fnPupdate('${amM105List.ptCd}','${status.count}');">수정</a></td>
						<td>
							<c:if test="${amM105List.ptRfctYn eq 'Y'}">
								<a class="btn_type3 bg_red" href="#" onclick="return fnUpdate('${amM105List.ptCd}','${amM105List.ptRfctYn}','C');">이용해지</a>
							</c:if>
							<c:if test="${amM105List.ptRfctYn eq 'N'}">
								<a class="btn_type3" href="#" onclick="return fnUpdate('${amM105List.ptCd}','${amM105List.ptRfctYn}','U');">적용</a>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	<!-- // table_type1 -->
</body>