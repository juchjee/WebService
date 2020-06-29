<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<script type="text/javascript">
$(document).ready(function() {
	// 현재시간 표시
	startClock();
	$("input[name=csCall]").bind("click",function(){
		if($(this).val() == "O"){
			$("input[name=csFunnel]").prop("checked",false);
//			$("input[name=csFunnel]").prop("disabled",true);
			$("input[name=csType]").prop("checked",false);
//			$("input[name=csType]").prop("disabled",true);
		}else{
			$("input[name=csFunnel]").prop("checked",false);
			$("input[name=csType]").prop("checked",false);
// 			$("input[name=csFunnel]").prop("disabled",false);
//			$("input[name=csType]").prop("disabled",false);
		}
	});
	// 이전값 불러오기
	var csQuestion = "${csQuestion}";
	var csConsult = "${csConsult}";
	var csProcess= "${csProcess}";
	$("#csQuestion").val(decodeTag(csQuestion.replace(/<br\s*[\/]?>/gi, "\n")));
	$("#csConsult").val(decodeTag(csConsult.replace(/<br\s*[\/]?>/gi, "\n")));
	$("#csProcess").val(decodeTag(csProcess.replace(/<br\s*[\/]?>/gi, "\n")));
	$("#caNonMbrTel").val("${caNonMbrTel}");
	$("#caNonMbrNm").val("${caNonMbrNm}");
	if( "${csFunnel}" != "" ){
		$("input:radio[name='csFunnel'][value='${csFunnel}']").attr("checked", true);
	}
	if( "${csType}" != "" ){
		$("input:radio[name='csType'][value='${csType}']").attr("checked", true);
	}
	if( "${csCall}" != "" ){
		$("input:radio[name='csCall'][value='${csCall}']").click();
		//$("[name=csCall][value=${csCall}]").attr("checked", true);
	}
	if( "${userInfo.mbrScore}" != "" ){
		$("input:radio[name='mbrScore'][value='${mbrScore}']").attr("checked", true);
	}
	// 상담 등록
	$(".advice_breakdown_register").click(function(){
		if($("input[name=csFunnel]:checked").val() == null){
			alert('상담유입경로는 필수 항목입니다.');
			$("input[name=csFunnel]:eq(0)").focus();
			return false;
		}
		if($("input[name=csType]:checked").val() == null){
			alert('상담유형은 필수 항목입니다.');
			$("input[name=csType]:eq(0)").focus();
			return false;
		}
		if($("input[name=csCall]:checked").val() == null){
			alert('상담내용 IN/OUT 은 필수 항목입니다.');
			$("input[name=csCall]:eq(0)").focus();
			return false;
		}
		$("#frmCsInfo").attr("action", "amM102CsSave.action");
		fnSubmit("frmCsInfo", "상담내역을 저장");
	});
});

</script>
<div class="right_con">
	<div class="member_advice_breakdown">
		<h3 class="dot_brown">상담내역 등록 <a id="mapPop" style="margin-left:80px;" data-fancybox-type="iframe" class="btn_type1" href="javascript:;" onclick="goMapPop();">지도</a></h3>
		<div class="pageContScroll_st3">
		<form id="frmCsInfo" name="frmCsInfo" method="post">
		<input type="hidden" name="admId" value="${admId}">
		<input type="hidden" name="mbrId" value="${mbrId}">
		<input type="hidden" name="mbrNm" value="${mbrNm}">
		<input type="hidden" id="popUrl" name="popUrl" value="${popUrl}">
			<div class="advice_breakdown_con">
				<div class="top_adviser">
					<p class="tit">상담자</p>
					<div class="adviser">
						<span>${admId} (${admName})</span>
					</div>
					<!-- // adviser -->
				</div>
				<p class="tit">상담유입경로</p>
				<div class="advise_ul">
					<ul>
						<c:forEach items="${csFunnelList}" varStatus="loop" var="datas" >
							<li>
								<input type="radio" name="csFunnel" title="상담유입경로" id="${datas.csTypeCd}" value="${datas.csTypeCd}"/>
								<label for="${datas.csTypeCd }">${datas.csTypeNm}</label>
							</li>
						</c:forEach>
					</ul>
				</div>
				<!-- // advise_ul -->
				<p class="tit">상담유형</p>
				<div class="advise_ul">
					<ul>
						<c:forEach items="${csTypeList}" varStatus="loop" var="datas" >
							<li> <input type="radio" name="csType" title="상담유형" id="${datas.csTypeCd}" value="${datas.csTypeCd}"/><label for="${datas.csTypeCd }">${datas.csTypeNm}</label></li>
						</c:forEach>
					</ul>
				</div>
				<!-- // advise_ul -->
				<p class="tit" style="float:left; margin-right: 40px;">상담내용</p>
				<div class="advise_ul">
					<input type="radio" id="radioIn" name="csCall"  title="IN, OUT" value="I"> <label for="radioIn" style="color:#fff">IN</label>
					<input type="radio" id="radioOut" name="csCall"  title="IN, OUT" value="O"> <label for="radioOut" style="color:#fff">OUT</label>
				</div>
				<div class="advise_form">
					<input type="text" id="csDt" name="csDt" value="" style="text-align: center;"  readonly />
				</div>
				<p class="tit" style="float:left; margin-right: 20px;">이름</p>
				<div class="advise_form" style="height: 25px">
					<input type="text" id="caNonMbrNm" name="caNonMbrNm" value="" style="float:right; width:140px;"/>
				</div>
				<p class="tit" style="float:left; margin-right: 20px;">전화번호</p>
				<div class="advise_form" style="height: 25px">
					<input type="text" id="caNonMbrTel" name="caNonMbrTel" value="" style="float:right; width:140px;"/>
				</div>
				<div class="advise_form">
					<textarea id="csQuestion" name="csQuestion" class="validation[required]" title="문의내용" placeholder="문의 내용을 입력하여 주십시오"></textarea>
					<textarea id="csConsult" name="csConsult" class="validation[required]" title="상담내용" placeholder="상담 내용을 입력하여 주십시오"></textarea>
				</div>
				<!-- // advise_form -->
				<!-- // advise_ul -->
			</div>
			<!-- // advice_breakdown_con -->
		</form>
	</div>
			<a class="advice_breakdown_register" href="javascript:;" style="margin-bottom: 20px;">등록</a>
	</div>
	<!-- // member_advice_breakdown -->
</div>
<!-- // right_con -->