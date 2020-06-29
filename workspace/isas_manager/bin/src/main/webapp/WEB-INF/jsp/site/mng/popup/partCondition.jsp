<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
	<script type="text/javascript">
<!--
$(window).load(function(){
	$("#eCopnPart4 select").bind("change",function(){
		$(".partMbrCount").text("(검색전) - 0");
		$("input[name=partMbrCount]").val(0);
	});

	$("#eCopnPart4 input").bind("keyup",function(){
		$(".partMbrCount").text("(검색전) - 0");
		$("input[name=partMbrCount]").val(0);
	});
});

function fnConditionSearch(){
	var fnConditionSearchCount =  function(data, dataType){
		var data = data.replace(/\s/gi,'');
		var returnData = "";
		$("input[name=partMbrCount]").val(data);
		$(".partMbrCount").text(setComma(data));
		if(data == "ng"){
			alert("아이콘 추가에 실패하였습니다.");
			return false;
		}else if(data == "ok"){
			alert("정상적으로 아이콘이 저장 되었습니다.");
			fnSearch();
		}else{
			return false;
		}
	};
		var params = {
			"mbrLevCdFrom" :  $("#mbrLevCdFrom").val(),
			"mbrLevCdTo" :  $("#mbrLevCdTo").val(),
			"partTpPmda" : $("#partTpPmda").val(),
			"purchaseStartDt" :  $("#purchaseStartDt").val(),
			"purchaseEndDt" :  $("#purchaseEndDt").val(),
			"period" :  $("#period").val(),
			"purchaseCount" :  removeComma($("#purchaseCount").val()),
			"purchaseCountTpMl" :  $("#purchaseCountTpMl").val(),
			"purchaseSum" :  removeComma($("#purchaseSum").val()),
			"buyerSexAmw" :  $("#buyerSexAmw").val(),
			"condiTp" :  $("#condiTp").val()
		};

	fnAjax("/mng/popup/conditionSearchCount.do", params, fnConditionSearchCount, "post", "text", "false");
}
//-->
</script>
	<div id="eCopnPart4" class="table_type2">
		<table>
			<caption>개별조건등록에 대한 작성 테이블 입니다.</caption>
			<colgroup>
				<col style="width:*;">
			</colgroup>
			<tbody>
				<tr>
					<td>
						<span>발행등급 </span>
						<select id="mbrLevCdFrom" name="mbrLevCdFrom">
						<c:forEach var="mbrLevCdMap" items="${mbrLevCdList}" varStatus="nStatus">
							<option value="${mbrLevCdMap.mbrLevCd}">${mbrLevCdMap.mbrLevNm}</option>
						</c:forEach>
						</select>
						<span>이상 </span>
						<select id="mbrLevCdTo" name="mbrLevCdTo">
						<c:forEach var="mbrLevCdMap" items="${mbrLevCdList}" varStatus="nStatus">

							<option value="${mbrLevCdMap.mbrLevCd}" <c:if test="${nStatus.last}">selected="selected"</c:if>>${mbrLevCdMap.mbrLevNm}</option>
						</c:forEach>
						</select>
						<span>까지 등급에게 쿠폰을 배정함.</span>
					</td>
				</tr>
				<tr>
					<td>
						<div class="fl" style="margin-right:5px;line-height:30px">
							<select id="partTpPmda" name="partTpPmda">
								<option value="A">전체</option>
								<option value="P">고정기간</option>
								<option value="M">월단위</option>
								<option value="D">일단위</option>
							</select>
			            </div>

						<!-- 고정기간일 -->
						<div class="fl" style="margin-right:5px;line-height:30px">
							<div id='purchaseStartDt' name="purchaseStartDt" style='float:left;'></div>
							<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
							<div id='purchaseEndDt' name="purchaseEndDt" style='float:left;'></div>
							<span>까지</span>
						</div>

						<!-- 월 or 일 단위 -->
						<div class="fl" style="margin-right:5px;line-height:30px">
							<input type="text" id="period" name="period" class="alignR validation[number]" style="width:80px;"  placeholder="단위별">
							<span id="periodText" class="periodText"></span>
						</div>

						<div class="fl" style="margin-right:5px;line-height:30px">
							<input type="text" id="purchaseCount" name="purchaseCount" class="marR5 alignR validation[number]" style="width:40px;" placeholder="0"> <!-- 구매횟수  -->
							<span>회</span>
							<select id="purchaseCountTpMl" name="purchaseCountTpMl">
								<option value="M">이상</option>
								<option value="L">이하</option>
							</select>
							<input type="text" id="purchaseSum" name="purchaseSum" class="marR5 alignR validation[number]" style="width:80px;" placeholder="0"> <!-- 구매합계  -->
							<span>원을 구매한</span>
							<select id="buyerSexAmw" name="buyerSexAmw">
								<option value="A">전체</option>
								<option value="M">남성</option>
								<option value="W">여성</option>
							</select>
							<span class="tpText">에게 쿠폰을 배정함.</span>
						</div>
						<div  style="position:absolute; right:0px; margin-right:5px;line-height:30px">
							<div id="eCopnPart3" class="fr partMbr"><span class="partMbrCount">(검색전) - 0</span>명<input type="hidden" name="partMbrCount"/></div>
							<div id="eCopnPart2" class=""><a class="btn_type1" href="javascript:;" onclick="fnConditionSearch();">조건별 인원 수 조회</a></div>
						</div>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
