<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 게시판관리 : CS상담관리 -->

<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM601";
	function init(){
		fnEvent();
		fnDataSetting();
		fnSearchInit();
		fnSearch();
		//if('${admId}' == 'master' || '${admId}' == 'cbtis4' || '${admId}' == 'jujonggee'){
		//	$('.only').show();
		//}else{
		//	$('.only').hide();
		//}
	}

	var _columns = [
	    { text: '회원여부', datafield: 'mbrTpNm',  width: '6%', cellsalign: 'center', align: 'center'},
   		{ text: 'ID', datafield: 'mbrId',  width: '6%', cellsalign: 'center', align: 'center'},
   		{ text: '이름', datafield: 'mbrNm',  width: '6%', cellsalign: 'center', align: 'center'},
   		{ text: '전화', datafield: 'mbrMobile',  width: '8%', cellsalign: 'center', align: 'center'},
   		{ text: '지역', datafield: 'mbrLocal',  width: '6%', cellsalign: 'center', align: 'center'},
   		{ text: '연령', datafield: 'mbrAge',  width: '6%', cellsalign: 'center', align: 'center'},
   		{ text: '등급', datafield: 'mbrLevNm',  width: '8%', cellsalign: 'center', align: 'center'},
   		{ text: '성별', datafield: 'mbrSexNm',  width: '6%', cellsalign: 'center', align: 'center'},
   		{ text: '구매횟수', datafield: 'mbrOrderCount',  width: '6%', cellsalign: 'right', align: 'center' },
   		{ text: '결재금액', datafield: 'mbrAmount',  width: '10%', cellsalign: 'right', align: 'center' , cellsformat: 'c'},
   		{ text: '일반쿠폰 할인금액', datafield: 'orderNomalCopnAmt',  width: '9%', cellsalign: 'right', align: 'center', cellsformat: 'c' },
   		{ text: '회원쿠폰 할인금액', datafield: 'orderLevCopnAmt',  width: '9%', cellsalign: 'right', align: 'center' , cellsformat: 'c'},
   		{ text: '적립금사용액', datafield: 'orderResvAmt',  width: '9%', cellsalign: 'right', align: 'center' , cellsformat: 'c'},
   ]

  	var _datafields = [
  	    { name: 'mbrTpNm', type: 'string'}
  		,{ name: 'mbrId', type: 'string'}
  		,{ name: 'mbrNm', type: 'string'}
  		,{ name: 'mbrMobile', type: 'string'}
  		,{ name: 'mbrLocal', type: 'string'}
  		,{ name: 'mbrAge', type: 'string'}
  		,{ name: 'mbrLevNm', type: 'string'}
  		,{ name: 'mbrSexNm', type: 'string'}
  		,{ name: 'mbrOrderCount', type: 'string'}
  		,{ name: 'mbrAmount', type: 'number'}
  		,{ name: 'orderNomalCopnAmt', type: 'number'}
  		,{ name: 'orderLevCopnAmt', type: 'number'}
  		,{ name: 'orderResvAmt', type: 'number'}
  		];

  	function fnSearchInit(){
		fnGridOption('jqxgrid',{
			height:555
	       ,columns: _columns
	       ,showaggregates: true
	    });
	}

  	function fnSearch(){
  		var params = $("#searchForm").serialize();

		var postDataJson = JSON.stringify(params);

		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: "amM601.action?"+params
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

  	function fnEvent(){
  		$("#jqxgrid").on("bindingcomplete", function (event) {
  			$("#amtSum").text("0");
  			$("#orderCount").text("0");
  			$("#orderNomalCopnAmt").text("0");
  			$("#orderLevCopnAmt").text("0");
  			$("#sales").text("0");
  			$("#netSales").text("0");
  			$("#mbrCount").text("0");
  			$("#netSalesPtCopn").text("0");
			$("#orderPtCopnAmt").text("0");

  	  		var datainfo = $("#jqxgrid").jqxGrid('getdatainformation');
  	  		var params = $("#searchForm").serialize();


  	  	$.ajax({
	        url : "amM601Sum.action?"+params,
	        type: "POST",
	        async: false,
	        success:function(data, result)
	        {
	           $("#amtSum").text(setComma(parseInt(data.mbrAmount)));
	 	  	   $("#orderCount").text(setComma(parseInt(data.mbrOrderCount)));

	 	  	   $("#orderNomalCopnAmt").text(setComma(parseInt(data.orderNomalCopnAmt)));
	 	  	   $("#orderLevCopnAmt").text(setComma(parseInt(data.orderLevCopnAmt)));
	 	  	   $("#sales").text(setComma(parseInt(data.sales)));
	 	  	   $("#netSales").text(setComma(parseInt(data.netSales)));
	 	  	   $("#orderResvAmt").text(setComma(parseInt(data.orderResvAmt)));
	 	  	   $("#netSalesPtCopn").text(setComma(parseInt(data.netSales) + parseInt(data.orderPtCopnAmt)));
	 	  	   $("#orderPtCopnAmt").text(setComma(parseInt(data.orderPtCopnAmt)));
	        },
	        error: function(jqXHR, textStatus, errorThrown){}
	   	}); // ajax


  	  	   $("#mbrCount").text(setComma(datainfo.rowscount));

  		});

  		$("#btn_Search").on('click', fnSearch);
  		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid','회원주문매출통계');
		});


  		$("input[name=mbrTpNm]").bind('change', function(){
			if($(this).val() == "회원" ){
			 	$(".onlyMbr").show();
			}else{
				$(".onlyMbr").hide();
			}
  		});
  	}
  	function fnDataSetting(){
  		dateTimeInput("txtFromDt", null, "${iConstant.prev1DayYmd(-15)}");
		dateTimeInput("txtToDt", null, "${nowYmd}");
		$("input[name=mbrTpNm]").change();
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
							<caption>회원구분, 등급, 성별, 연령, 기간, 결제수단, 상품, 금액, 기기, 구매횟수, 지역, 상태로 구성된 회원주문매출통계에 대한 검색 테이블입니다.</caption>
							<colgroup>
								<col style="width:120px;" />
								<col style="width:*;" />
								<col style="width:180px;" />
								<col style="width:*;" />
							</colgroup>
							<tbody>
								<tr>
									<th scope="row">회원구분</th>
									<td colspan="3">
										<input type="radio" name="mbrTpNm" id="radio1_1" value=""  checked="checked"/><label for="radio1_1" class="marL5">전체</label>
										<input type="radio" name="mbrTpNm" id="radio1_2" class="marL10"  value="회원" /><label for="radio1_2" class="marL5">회원</label>
										<input type="radio" name="mbrTpNm" id="radio1_3" class="marL10" value="비회원" /><label for="radio1_3" class="marL5">비회원</label>
									</td>
								</tr>
								<tr>
									<th scope="row">일자검색</th>
									<td>
										<div style='float:left;margin-right:5px;'>
											<select name="orderDtStyle" style="width:140px;">
												<option value="orderPackingDt">발송(패킹)완료일자</option>
												<option value="orderDt">주문일자</option>
												<option value="orderSendDt">배송요청일자</option>
												<option value="orderDeliDt">배송완료일자</option>
											</select>
										</div>
										<div style='float:left;'>
										<div id='txtFromDt' style='float:left;'></div>
											<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
										<div id='txtToDt'  style='float:left;'></div>
										</div>
									</td>
									<th scope="row">결제방식</th>
									<td>
										<html:selectList name='orderCashCd' id='orderCashCd' list='${orderCashList}' listValue='orderCashCd' listName='orderCashNm' optionValues="" optionNames="전체" script='style="width:150px;"'/>
									</td>
								</tr>
								<tr>
									<th scope="row">상품</th>
									<td>
										<html:selectList name='prodCd' id='prodCd' list='${prodList}' listValue='prodCd' listName='prodNm' optionValues="" optionNames="전체" script='style="width:250px;"'/>
									</td>
									<th scope="row">금액</th>
									<td>
										<input type="text" name="mbrAmountFrom" class="validation[number]" style="width:99px;">
										원
										<span>~</span>
										<input type="text" name="mbrAmountTo" class="validation[number]" style="width:99px;">
										원
									</td>
								</tr>
								<tr>
									<th scope="row">기기</th>
									<td>
										<input type="radio" name="salesTpPma" id="radio5_1"  value="" checked="checked" /><label for="radio5_1" class="marL5">전체</label>
										<input type="radio" name="salesTpPma" id="radio5_2" value="P"  class="marL10" /><label for="radio5_2" class="marL5">PC</label>
										<input type="radio" name="salesTpPma" id="radio5_3" value="M"  class="marL10" /><label for="radio5_3" class="marL5">모바일</label>
										<input type="radio" name="salesTpPma" id="radio5_4" value="A"  class="marL10" /><label for="radio5_4" class="marL5">ARS</label>
									</td>
									<th scope="row">쿠폰할인금액</th>
									<td>
										<input type="text" name="orderCopnAmtFrom" class="validation[number]" style="width:99px;" value=""/>
										원
										<span>~</span>
										<input type="text" name="orderCopnAmtTo" class="validation[number]" style="width:99px;" value=""  />
										원
									</td>
								</tr>

								<tr>
									<th scope="row">상태</th>
									<td>
										<html:selectList name='orderStatusCd' id='orderStatusCd' list='${orderStatusList}' listValue='orderStatusCd' listName='orderStatusNm' optionValues="" optionNames="전체" script='style="width:250px;"'/>
									</td>
									<th scope="row">구매횟수</th>
									<td>
										<input type="text" name="mbrOrderCountFrom" class="validation[number]" style="width:99px;" />
										회
										<span>~</span>
										<input type="text" name="mbrOrderCountTo" class="validation[number]" style="width:99px;" />
										회
									</td>
								</tr>

								<tr class="onlyMbr">
									<th scope="row">지역</th>
									<td>
										<input type="text" name="mbrLocal" value="" />
									</td>
									<th scope="row">등급</th>
									<td>
										<html:selectList name='mbrLevCd' id='mbrLevCd' list='${mbrLevList}' listValue='mbrLevCd' listName='mbrLevNm' optionValues="" optionNames="전체" script='style="width:150px;"'/>
									</td>
								</tr>
								<tr class="onlyMbr">
									<th scope="row">성별</th>
									<td>
										<input type="radio" name="mbrSexMw" id="radio3_1"  value="" checked="checked" /><label for="radio3_1" class="marL5">전체</label>
										<input type="radio" name="mbrSexMw" id="radio3_2" value="M"  class="marL10" /><label for="radio3_2" class="marL5">남</label>
										<input type="radio" name="mbrSexMw" id="radio3_3" value="W" class="marL10" /><label for="radio3_3" class="marL5">여</label>
									</td>
									<th scope="row">연령</th>
									<td>
										<input type="text" name="mbrAgeFrom" class="validation[number]" style="width:99px;">
										세
										<span>~</span>
										<input type="text" name="mbrAgeTo" class="validation[number]" style="width:99px;">
										세
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<!-- // table_type -->
				</div>
				<!-- // top_box -->
				<div class="btn_area marB35" >
					<div class="center">
						<a id="btn_Search" class="btn_blue_line2" href="javascript:" >검색</a>
					</div>
					<div class="right" style="line-height:40px;">
						<a id="btnExcel" class="btn_type2 btn_icon5" href="javascript:;">엑셀다운로드</a>
					</div>
				</div>
				<!-- // btn_area -->
				<div class="table_type2" style="margin-bottom:10px;">
					<table>
						<caption>인원, 총금액, 판매상품으로 구성된 회원주문매출통계에 대한 테이블입니다.</caption>
						<colgroup>
							<col style="width:100px;" />
							<col style="width:*;" />
							<col style="width:100px;" />
							<col style="width:*;" />
							<col style="width:120px;" />
							<col style="width:*;" />
							<col style="width:100px;" />
							<col style="width:*;" />
							<col class="only" style="width:150px;" />
							<col class="only" style="width:*;" />
						</colgroup>
						<tbody>
							<tr>
								<th  scope="row" class="alignC">구매인원</th>
								<td>
									<span id="mbrCount">0</span>명
								</td>
								<th scope="row" class="alignC">일반쿠폰</th>
								<td>
									<span id="orderNomalCopnAmt">0</span>원
								</td>
								<th scope="row" class="alignC">회원쿠폰</th>
								<td>
									<span id="orderLevCopnAmt">0</span>원
								</td>
								<th scope="row" class="alignC">적립금사용</th>
								<td>
									<span id="orderResvAmt">0</span>원
								</td>
								<th scope="row" class="alignC only">적립금쿠폰</th>
								<td class="only">
									<span id="orderPtCopnAmt">0</span>원
								</td>
							</tr>
							<tr>

								<th scope="row" class="alignC">구매횟수</th>
								<td>
									<span id="orderCount">0</span>건
								</td>
								<th  scope="row" class="alignC">결재금액</th>
								<td>
									<span id="amtSum">0</span>원
								</td>
								<th scope="row" class="alignC" style="background-color: #c3a279">매출</th>
								<td>
									<span id="sales">0</span>원
								</td>
								<th scope="row" class="alignC" style="background-color: #c3a279">순매출</th>
								<td >
									<span id="netSales">0</span>원
								</td>
								<th scope="row" class="alignC only" style="background-color: #c3a279">적립금포함순매출</th>
								<td class="only">
									<span id="netSalesPtCopn">0</span>원
								</td>

							</tr>
						</tbody>
					</table>
				</div>
				</form>
				<!-- // table_type2 -->
				<!-- // table_type1 -->
				<div class="grid_type1" >
					<div id="jqxgrid" ></div>
				</div>

</div>
				<!-- // align_area -->
</body>