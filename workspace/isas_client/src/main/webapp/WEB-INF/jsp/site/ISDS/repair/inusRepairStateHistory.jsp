<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<style type="text/css">
		.access .input_box > input[type="button"] {width:29%;}
		.btn02Type, .btn03Type{height:100%}
	</style>

	<script type="text/javascript" defer="defer">
		function init(){
			fnEvent();
			fnDataSetting();
		}

		function fnEvent(){
			$.fnDetail = function(asNo){
				makeForm("inusRepairStateHistoryDetail.do", {"page": "${param.page}", "asNo": asNo});
			}


			$.fnBack = function(asNo){
				makeForm("inusRepairStateDetail.do", {"page": "${param.page}", "asNo": asNo});
			}

			doPage = function(pageNum){
				document.frmSearch.page.value = pageNum;
				fnSearch();
			}
		}

		function fnDataSetting(){

			if("${searchType}" == "5"){
				$(".calender_bx").show();
			}
		}
		/* 조회버튼 이벤트 */
		function fnSearch(){

			if($("#txtFromDt").val() != "" || $("#txtToDt").val() != ""){
				$("#dateFlag").val("Y");
			}else{
				$("#dateFlag").val("N");
			}

			if($("#searchTxt").val() != ""){
				$("#searchTxt").val($.trim($("#searchTxt").val()));
			}
			frmSearch.submit();
		}

		function fnSearchTypeChange(){
			if($("#searchType").val() == "5"){
				$(".calender_bx").show();
			}else{
				$("#txtFromDt").val("");
				$("#txtToDt").val("");
				$(".calender_bx").hide();
			}
		}

		 function fnSearchDate(){
// 			 $("#searchType option:eq(0)").prop("selected","selected");
// 			 $(".select_guide div div span").text("전체");
		 }


		function keydown(seq) {
			  var keycode = '';
			  if(window.event) keycode = window.event.keyCode;
			 if(keycode == 13){
				 if(seq == 1){
					 fnSearch();
				 }
			 }
			  return false;
		}
</script>


</head>
<body>
	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:" onclick="$.fnBack('${param.asNo}');" class="btn_prev">이전 화면</a>
			<h2>History 내역</h2>
		</div>
		<!--// tit_bx -->
		<div class="sch_opt_bx">
			<form name="frmSearch" method="post" action="/ISDS/repair/inusRepairStateHistory.do">
				<input type="hidden" name="dateFlag" id="dateFlag" value="" >
				<input type="hidden" id="page" name="page" value="${page}"/>
				<input type="hidden" id="asNo" name="asNo" value="${param.asNo}"/>
				<table>
					<caption>History내역 검색</caption>
					<tbody>
						<tr>
							<th scope="row" rowspan="2" class="pt10 vtT"><label for="ct_select">기간</label></th>
							<td>
								<div class="select_guide">
									<select class="m_select select01" name="searchType" id="searchType" onchange="fnSearchTypeChange();">
										<option value="">전체</option>
										<option value="1" <c:if test="${searchType eq '1'}">selected</c:if>>당일</option>
										<option value="2" <c:if test="${searchType eq '2'}">selected</c:if>>최근7일</option>
										<option value="3" <c:if test="${searchType eq '3'}">selected</c:if>>최근15일</option>
										<option value="4" <c:if test="${searchType eq '4'}">selected</c:if>>최근30일</option>
										<option value="5" <c:if test="${searchType eq '5'}">selected</c:if>>날짜입력</option>
									</select><!-- m_select -->
								</div><!-- select_guide -->
							</td>
						</tr>
						<tr >
							<td>
								<div class="calender_bx" style="display:none;">
									<div class="cal_input">
										<input type="text" name="txtFromDt" id="txtFromDt" value="${txtFromDt}" class=""  onclick="f_datepicker(this);" onchange="fnSearchDate();"/> <!-- 2017-09-06 수정 -->
									</div>
									<span class="line">~</span>
									<div class="cal_input">
										<input type="text" name="txtToDt" id="txtToDt" value="${txtToDt}" class="" onclick="f_datepicker(this);" onchange="fnSearchDate();" /> <!-- 2017-09-06 수정 -->
									</div>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
			<div class="btnBox mt10">
				<a href="#" class="btn" onclick="fnSearch();">조회</a>
			</div>
		</div>

		<!--// sch_opt_bx -->
		<div class="tit_box">
			<h3><strong>${repairThisHistoyNm}</strong>님의 History 내역입니다.</h3>
		</div>


		<!--// sch_opt_bx -->
		<c:forEach items="${repairStateHistoyList}" var="repairStateHistoy" varStatus="loop">
			<div class="ing_bx">
				<a href="javascript:" onclick="$.fnDetail('${repairStateHistoy.asNo}');">
					<div class="box">
						<div class="date">${repairStateHistoy.recDt}</div>
						<dl class="situ">
							<dt>제품</dt>
							<dd>${repairStateHistoy.model}<c:if test="${not empty repairStateHistoy.modelItemCd}">(${repairStateHistoy.modelItemCd})</c:if></dd>
							<dt>성명</dt>
							<dd>${repairStateHistoy.tNm}</dd>
							<dt>전화번호</dt>
							<dd>${repairStateHistoy.tHp}</dd>
							<dt>진행상태</dt>
							<dd class="fc-red fc-bold">${repairStateHistoy.statBcNm}</dd>
						</dl>
					</div>
				</a>
			</div>
		</c:forEach>
		<c:if test="${empty repairStateHistoyList}">
		<div class="ing_bx" style="text-align:center;height:100px;line-height:100px;">
			검색된 접수 내역이 없습니다.
		</div>
		</c:if>

		<!--// ing_bx -->
	</section>
	<!--// sub -->
</body>