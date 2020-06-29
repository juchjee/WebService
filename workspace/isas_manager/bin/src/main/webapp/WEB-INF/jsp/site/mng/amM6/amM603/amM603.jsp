<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<!-- 통계 : 품목별 판매 통계 -->
<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM603";

	var _columns1 = [
		         		{ text: '순위', datafield: 'num',  width: '5%', cellsalign: 'center', align: 'center'},
		         		{ text: '상품 코드', datafield: 'prodCd',  width: '10%', cellsalign: 'left', align: 'center'},
		         		{ text: '상품명', datafield: 'prodNm',  width: '40%', cellsalign: 'left', align: 'center'},
		         		{ text: '판매가(정가)', datafield: 'prodPrice',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'c'},
		         		{ text: '판매 수량(ea)', datafield: 'prodQtySum',  width: '10%', cellsalign: 'right', align: 'center'},
		         		{ text: '판매 금액(won)', datafield: 'prodPriceSum',  width: '15%', cellsalign: 'right', align: 'center', cellsformat: 'c'},
		         		{ text: '판매수량 구성비(%)', datafield: 'qtyPercent',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'p'}
		         	];

	var _datafields1 = [
		         		{ name: 'num', type: 'string'}
		         		,{ name: 'prodCd', type: 'string'}
		         		,{ name: 'prodNm', type: 'string'}
		         		,{ name: 'prodQtySum', type: 'string'}
		         		,{ name: 'prodPrice', type: 'number'}
		         		,{ name: 'prodPriceSum', type: 'number'}
		         		,{ name: 'qtyPercent', type: 'number'}
		         	];

	function init(){
		$(function() {
			//initialize the pqSelect widget.
			$("#prodCd").pqSelect({
			    multiplePlaceholder: '전체',
			    maxDisplay: 2,
			    checkbox: true //adds checkbox to options
			}).on("change", function(evt) {
			    var val = $(this).val();
			}).pqSelect();
		});

		fnEvent();
		fnDataSetting();
		fnSearchInit();
		fnSearch();
 	}

  	function fnSearchInit(){
		fnGridOption('jqxgrid1',{sortable: false
			, pageable: false
			, autoheight: true
			, columns: _columns1
			, showaggregates: true
	    });
	}

  	function fnSearch(){
		$('#totalOrderAmt').text('0');
		$('#totalOrderCount').text('0');

		var params = $("#searchForm").serialize();

		var postDataJson = JSON.stringify(params);

		var dataAdapter1 = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields1,
	        url: "amM603.action?" + params
		});
		$("#jqxgrid1").jqxGrid({
			source: dataAdapter1
		});
		fnResetGridEditData('jqxgrid1');

		fnAjax("amM603Sum.action", params, function(data, dataType){
			if(data){
				$('#totalOrderAmt').text(formatNumber3(data[0].pTotal));
				$('#totalOrderCount').text(formatNumber3(data[0].pQty));
			}
		});
	}

  	function fnEvent(){
		$("#pProdCategoryA").on('change', fnPPCAHandler);
		$("#pProdCategoryB").on('change', fnPPCBHandler);

		$("#jqxgrid1").on("bindingcomplete", function (event) {
  	  		var datainfo = $("#jqxgrid1").jqxGrid('getdatainformation');
  	  		var params = $("#searchForm").serialize();
  		});

  		$("#btnSearch").on('click', fnSearch);

		$("#btnReset").on('click',function(){
			$("#txtFromDt1").val("${iConstant.prev1DayYmd(-6)}");
			$("#txtToDt1").val("${nowYmd}");
			$("#jqxgrid1").jqxGrid('clear');
		});

  		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid1','품목별판매통계');
		});

	}
  	function fnDataSetting(){
  		dateTimeInput("txtFromDt1", null, "${iConstant.prev1DayYmd(-6)}");
		dateTimeInput("txtToDt1", null, "${nowYmd}");
  	}
	function fnPPCAHandler(){
		var prodCategoryCd = $(this).val();
		if(prodCategoryCd){
			fnAjax("/mng/amM2/amM201/amM201" + "PPC.action", {"prodCategoryCd" : prodCategoryCd}, function(data, dataType){
				if(data){
					var strHtml = "<option value=''>중분류전체</option>";
					for (var i = 0; i < data.length; i++) {
						strHtml += "<option value='" + data[i].prodCategoryCd + "'>" + data[i].prodCategoryNm + "</option>";
					}
					$("#pProdCategoryB").html(strHtml);
					$("#pProdCategoryC").html("<option value=''>소분류전체</option>");
				}else{
					alert('<spring:message code="fail.request.msg"/>');
				}
			});
		}else{
			$("#pProdCategoryB").html("<option value=''>중분류전체</option>");
			$("#pProdCategoryC").html("<option value=''>소분류전체</option>");
		}
	}
	function fnPPCBHandler(){
		var prodCategoryCd = $(this).val();
		if(prodCategoryCd){
			fnAjax("/mng/amM2/amM201/amM201" + "PPC.action", {"prodCategoryCd" : prodCategoryCd}, function(data, dataType){
				if(data){
					var strHtml = "<option value=''>소분류</option>";
					for (var i = 0; i < data.length; i++) {
						strHtml += "<option value='" + data[i].prodCategoryCd + "'>" + data[i].prodCategoryNm + "</option>";
					}
					$("#pProdCategoryC").html(strHtml);
				}else{
					alert('<spring:message code="fail.request.msg"/>');
				}
			});
		}else{
			$("#pProdCategoryC").html("<option value=''>소분류</option>");
		}
	}

	function fnDateCheck(kind){
		if($('#txtToDt1').val() == ''){
			$('#txtToDt1').val("${nowYmd}");
		}
		if(kind == 'W'){
			$('#txtFromDt1').val(getTargetDate($('#txtToDt1').val(), -6));
		}else if(kind == 'M'){
			$('#txtFromDt1').val(getTargetDate($('#txtToDt1').val(), 1, -1));
		}else if(kind == 'Y'){
			$('#txtFromDt1').val(getTargetDate($('#txtToDt1').val(), 1, null, -1));
		}
	}
</script>
</head>
<body>
<div class="pageContScroll_st2">
	<!-- // tit_path -->
	<form name="searchForm" id="searchForm">
		<div class="top_box" style="margin: 0 0 0 0">
			<div class="table_type">
				<table>
					<caption>기간별 회원주문통계에 대한 검색 테이블입니다.</caption>
					<colgroup>
						<col style="width:120px;" />
						<col style="width:*;" />
						<col style="width:180px;" />
						<col style="width:*;" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">분류선택</th>
							<td  style="min-width:370px">
								<html:selectList name='prodCategoryCdA' id='pProdCategoryA' list='${pProdCategory}' listValue='prodCategoryCd' listName='prodCategoryNm' optionValues="" optionNames="대분류전체" script='style="width:120px;"'/>
								<select name='prodCategoryCdB' id='pProdCategoryB' style="width:120px;">
									<option value=''>중분류전체</option>
								</select>
								<select name='prodCategoryCdC' id='pProdCategoryC' style="width:120px;">
									<option value=''>소분류전체</option>
								</select>

							</td>
							<th scope="row">기간</th>
							<td>
								<div style='float:left;'>
									<div id='txtFromDt1' style='float:left;'></div>
										<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
									<div id='txtToDt1'  style='float:left;'></div>
									&nbsp;&nbsp;
									<button type="button" name="weekDate" id="weekDate" onclick="javascript:fnDateCheck('W');">주간</button>
									<button type="button" name="monthDate" id="monthDate" onclick="javascript:fnDateCheck('M');">월간</button>
									<button type="button" name="yearDate" id="yearDate" onclick="javascript:fnDateCheck('Y');">연간</button>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">판매 상태</th>
							<td>
								<html:selectList name='prodStatusCd' id='prodStatusCd' list='${pProdStatus}' listValue='prodStatusCd' listName='prodStatusNm' optionValues="" optionNames="전체" script='style="width:144px;"'/>
								<select name="disView" style="width:80px;">
									<option value="">전체</option>
									<option value="Y" selected>노출</option>
									<option value="N">비노출</option>
								</select>
							</td>
							<th scope="row">상품 선택</th>
							<td>
								<select id="prodCd" name="prodCd" multiple=multiple style="width:400px;">
									<c:forEach items="${prodList}" var="prodList">
										<option value="${prodList.prodCd}" class="validation[choose]" title="분류" <c:if test="${prodList.prodCd eq viewMap.prodCd}">selected</c:if> >${prodList.prodNm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- // table_type -->
		</div>
	</form>
	<!-- // top_box -->
	<div class="btn_area marB35" >
		<div class="center">
			<a id="btnSearch" class="btn_blue_line2" href="javascript:" >검색</a>
			<a id="btnReset" class="btn_blue_line2" href="javascript:" >초기화</a>
		</div>
		<div class="right" style="line-height:40px;">
			<a id="btnExcel" class="btn_type2 btn_icon5" href="javascript:;">엑셀다운로드</a>
		</div>
	</div>
	<!-- // btn_area -->

	<!-- // btn_area -->
	<div class="table_type2" style="margin-bottom:10px; width: 500px;">
		<table>
			<caption>품목별판매통계에 대한 테이블입니다.</caption>
			<colgroup>
				<col style="width:100px;" />
				<col style="width:150px;" />
				<col style="width:100px;" />
				<col style="width:150px;" />
			</colgroup>
			<tbody>
				<tr>
					<th  scope="row" class="alignC">총 판매수량</th>
					<td>
						<span id="totalOrderCount">0</span>개
					</td>
					<th scope="row" class="alignC">총 판매금액</th>
					<td>
						<span id="totalOrderAmt">0</span>원
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<!-- // table_type1 -->
	<div class="grid_type1" >
		<div id="jqxgrid1" ></div>
	</div>
</div>
<!-- // align_area -->
</body>