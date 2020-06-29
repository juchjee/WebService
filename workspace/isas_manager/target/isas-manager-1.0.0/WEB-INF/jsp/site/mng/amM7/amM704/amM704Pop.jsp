<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />
	<script type="text/javascript">

		var contUrl = "${rootUri}${conUrl}amM704";

		<c:if test="${empty admDetail}">
		var idCheck = false;
		</c:if>
		<c:if test="${not empty admDetail}">
		var idCheck = true;
		</c:if>
		function init(){
			fnSearchInit();
			fnEvent();
		}

		function fnSearchInit(){
			<c:if test="${empty admDetail}">
			dateTimeInput("admJobDt", null, "${nowYmd}");
			</c:if>
			<c:if test="${not empty admDetail}">
			dateTimeInput("admJobDt", null, "${admDetail.admJobDt}");
			</c:if>
		}

		function fnEvent(){

			<c:if test="${empty admDetail}">
				$("#admId").bind('keyup',function(e){
					if($("#admId").val().length>4){
						var params = {"admId":$("#admId").val()};
						var fnIconAddSuccess =  function(data, dataType){
							var data = data.replace(/\s/gi,'');
							var returnData = "";

							if(data == "ng"){
								document.getElementById("idChNo").style.display="block";
		    					document.getElementById("idChYes").style.display="none";
		    					idCheck = false;
								return false;
							}else if(data == "ok"){
								document.getElementById("idChYes").style.display="block";
		    					document.getElementById("idChNo").style.display="none";
		    					idCheck = true;
								return false;
							}
						};
						fnAjax("amM704IC.action", params, fnIconAddSuccess, "post", "text", "false");
					}else{
						document.getElementById("idChYes").style.display="none";
						document.getElementById("idChNo").style.display="none";
					}
			    });
			</c:if>

			$(".saveBtn").click(function(){
				<c:if test="${empty admDetail}">
				if($("#admId").val().length<5){
					alert("아이디는 5자리이상으로 입력해주세요.");
					$("#admId").focus();
					idCheck = false;
					return false;
				}
				if($("#admId").val()==""){
					alert("관리자 아이디는 필수 항목입니다.");
					$("#admId").focus();
					idCheck = false;
					return false;
				}
				</c:if>
				if($("#admPw").val()==""){
					alert("관리자 비밀번호는 필수 항목입니다.");
					$("#admPw").focus();
					idCheck = false;
					return false;
				}

				// 이름은 공통validation(아이디.비밀번호(연속숫자입력 시 ,)제외)
	    		fnSubmit("workForm","저장");
			});

		}
	</script>
</head>

<body class="noBg">
	<div class="popup_wrap">
		<c:if test="${empty admDetail}">
			<h2>관리자 등록</h2>
		</c:if>
		<c:if test="${!empty admDetail}">
			<h2>관리자 수정</h2>
		</c:if>
		<p class="table_info">비밀번호는 영문, 숫자, 특수 문자를 포함하여 8자리이상으로 등록 하십시오.예시 ) myid_1234</p>
		<div class="table_type2">
			<form id="workForm" name="workForm" action="amM704PSave.action" method="post">
				<table>
					<caption>부서, 직급, 아이디, 비밀번호, 이름, 전화번호, 입사일, 등록일, 이메일로 구성된 관리자 등록에 대한 작성 테이블 입니다.</caption>
					<colgroup>
						<col style="width:18%;" />
						<col style="width:32%;" />
						<col style="width:18%;" />
						<col style="width:32%;" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">권한</th>
							<td>
								<select id="admAuthCd" name="admAuthCd" style="width: 113px;">
									<c:forEach items="${authList}" var="authList">
										<option value="${authList.admAuthCd}" <c:if test="${authList.admAuthCd eq admDetail.admAuthCd}">selected</c:if>>${authList.admAuthNm}</option>
									</c:forEach>
								</select>
							</td>
							<th scope="row">직급</th>
							<td>
								<select id="admPosition" name="admPosition" style="width: 113px;">
									<c:forEach items="${positionList}" var="positionList">
										<option value="${positionList.admPositionCd}" <c:if test="${positionList.admPositionCd eq admDetail.admPosition}">selected</c:if>>${positionList.admPositionNm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">아이디</th>
							<td>
								<c:if test="${empty admDetail}">
									<input type="text" name="admId" id="admId" value="${admDetail.admId}" style="width:93px" />
									<span id="idChYes" style="display:none; color:green; float:right; line-height:26px; margin-right:20px;">사용가능</span>
									<div class="colRed" id="idChNo" style="display:none; float:right; line-height:26px; margin-right:20px;">중복아이디</div>
								</c:if>
								<c:if test="${!empty admDetail}">
									<c:out value="${admDetail.admId}" />
									<input type="hidden" name="admId" id="admId" value="${admDetail.admId}" style="width:93px" />
								</c:if>
							</td>
							<th scope="row">비밀번호</th>
							<td>
								<input type="text" name="admPw" id="admPw" style="width:93px" />
							</td>
						</tr>
						<tr>
							<th scope="row">이름</th>
							<td>
								<input type="text" name="admName" id="admName" class="validation[required]" title="관리자 이름" value="${admDetail.admName}" style="width:93px" />
							</td>
							<th scope="row">전화번호</th>
							<td>
								<input type="text" name="admTel" id="admTel" maxlength="13" value="${admDetail.admTel}" style="width:93px" />
							</td>
						</tr>
						<tr>
							<th scope="row">입사일</th>
							<td>
								<div id="admJobDt" name="admJobDt" style='float:left;'></div>
							</td>
							<th scope="row">등록일</th>
							<td>
								<c:if test="${empty admDetail}">
									${nowYmd}
									<input type="hidden" id="admRegDt" name="admRegDt" value="${nowYmd}" />
								</c:if>
								<c:if test="${!empty admDetail}">
									${admDetail.admRegDt}
									<input type="hidden" id="admRegDt" name="admRegDt" value="${admDetail.admRegDt}" />
								</c:if>
							</td>
						</tr>
						<c:if test="${ empty admDetail }">
						<tr>
							<th scope="row">이메일</th>
							<td colspan="3">
								<input type="text" name="admEmail" id="admEmail" value="${admDetail.admEmail}" style="width:259px" />
							</td>
						</tr>
						</c:if>
						<c:if test="${ !empty admDetail }">
						<tr>
							<th scope="row">이메일</th>
							<td>
								<input type="text" name="admEmail" id="admEmail" value="${admDetail.admEmail}" />
							</td>
							<th scope="row">상태</th>
							<td>
								<select name="useFlagYn" id="useFlagYn" style="width: 100px;">
									<option value="">전체</option>
									<option value="Y" <c:if test="${admDetail.useFlagYn eq 'Y'}">selected="selected"</c:if>>재직</option>
									<option value="N" <c:if test="${admDetail.useFlagYn eq 'N'}">selected="selected"</c:if>>퇴사</option>
								</select>
							</td>
						</tr>
						</c:if>
					</tbody>
				</table>
			</form>
		</div>
		<!-- // table_type2 -->
		<div class="btn_area">
			<div class="center">
				<c:if test="${empty admDetail}">
					<a class="saveBtn btn_blue_line2" href="javascript:;">등록</a>
				</c:if>
				<c:if test="${!empty admDetail}">
					<a class="saveBtn btn_blue_line2" href="javascript:;">수정</a>
					<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">닫기</a>
				</c:if>
			</div>
		</div>
		<!-- // btn_area -->
	</div>
</body>
</html>
