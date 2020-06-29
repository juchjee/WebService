<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
<style>
div.jqx-item{cursor:pointer;}
div.jqx-grid-cell-left-align{margin-top:0px;}
</style>
<script type="text/javaScript" defer="defer">
<!--
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){
		fnEvent();
		fnDataSetting();
		fnSearchInit();
		fnSearch();
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅 - 선택, 제품명, 판매가, 할인가, 쿠폰, 적립금, 재고, 판매상태, PC노출, 모바일노출, 과세, 등록일, 관리
	 *----------------------------------------------------------------------------------------------*/
	var _columns = [
	     { text: '주문번호', datafield: 'orderNoNm', width: '7%', cellsalign: 'center', align: 'center' }
		,{ text: '주문자', datafield: 'ordersNm', width: '5%', cellsalign: 'center', align: 'center' }
	    ,{ text: '수령인', datafield: 'receiptNm', width: '5%', cellsalign: 'center', align: 'center' }
	    ,{ text: '수령인휴대전화', datafield: 'receiptMobile', width: '7%', cellsalign: 'center', align: 'center' }
	    ,{ text: '상품명', datafield: 'prodNm', width: '18%', cellsalign: 'left', align: 'center'}
		,{ text: '주문상태', datafield: 'orderStatusNm', width: '7%', cellsalign: 'center', align: 'center'}
// 	    ,{ text: '배송상태', datafield: 'orderSendDtNm',width: '7%', cellsalign: 'center', align: 'center'}
// 	    ,{ text: '매출액', datafield: 'sales', width: '8%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
// 	    ,{ text: '순매출액', datafield: 'netSales', width: '8%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
	    ,{ text: '결제금액', datafield: 'depositAmount', width: '6%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
	    ,{ text: '일반쿠폰할인액', datafield: 'orderNomalCopnAmt', width: '6%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
	    ,{ text: '멤버쉽쿠폰할인액', datafield: 'orderLevCopnAmt', width: '7%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
	    ,{ text: '적립금사용액', datafield: 'orderResvAmt', width: '6%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
		,{ text: '배송비', datafield: 'orderDeliChargeNm', width: '5%', cellsalign: 'center', align: 'center', editable: false}
	    ,{ text: '주문일자', datafield: 'orderDt', width: '7%' , cellsalign: 'center', align: 'center'}
	    ,{ text: '입금일자', datafield: 'depositDt', width: '7%' , cellsalign: 'center', align: 'center'}
	    ,{ text: '결제방식', datafield: 'orderCashNm', width: '9%', cellsalign: 'center', align: 'center'}
		,{ text: '클레임상태', datafield: 'claimTpNm', width: '5%', cellsalign: 'center', align: 'center'}
// 		,{ text: '패킹상태', datafield: 'orderPackingStatus', width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '발송(패킹)완료일', datafield: 'orderPackingDt' , width: '7%', cellsalign: 'center', align: 'center'}
	    ,{ text: '송장번호', datafield: 'regiNo', width: '7%', cellsalign: 'left', align: 'center'}
	    ,{ text: '배송요청일', datafield: 'orderSendDt', width: '7%' , cellsalign: 'center', align: 'center'}
	    ,{ text: '배송완료일', datafield: 'orderDeliDt', width: '7%' , cellsalign: 'center', align: 'center'}
	    ,{ text: '매출타입', datafield: 'salesTpPmaNm', width: '7%', cellsalign: 'center', align: 'center'}
	    ,{ text: '주문자휴대전화', datafield: 'ordersMobile', width: '7%', cellsalign: 'center', align: 'center' }
	    ,{ text: '입금자', datafield: 'depositNm', width: '5%', cellsalign: 'center', align: 'center' }
		,{ text: '회원아이디', datafield: 'mbrId', width: '8%', cellsalign: 'center', align: 'center' }
		,{ text: '주문상태코드', datafield: 'orderStatusCd', hidden: true}
		,{ text: '클레임상태코', datafield: 'claimTpCd', hidden: true}
		,{ text: '주문번호(REAL)', datafield: 'orderNo', hidden: true}
	];

	var _datafields = [
	     { name: 'orderNoNm', type: 'string'}
	    ,{ name: 'prodNm', type: 'string'}
		,{ name: 'orderStatusNm', type: 'string'}
// 	    ,{ name: 'orderSendDtNm', type: 'string'}
	    ,{ name: 'orderStatusNm', type: 'string'}
// 	    ,{ name: 'sales', type: 'number'}
// 	    ,{ name: 'netSales', type: 'number'}
	    ,{ name: 'depositAmount', type: 'number'}
	    ,{ name: 'orderNomalCopnAmt', type: 'number'}
	    ,{ name: 'orderLevCopnAmt', type: 'number'}
	    ,{ name: 'orderResvAmt', type: 'number'}
	    ,{ name: 'orderDeliChargeNm', type: 'string'}
	    ,{ name: 'depositDt', type: 'string'}
	    ,{ name: 'orderDt', type: 'string'}
	    ,{ name: 'orderCashNm', type: 'string'}
		,{ name: 'claimTpNm', type: 'string'}
// 	    ,{ name: 'orderPackingStatus', type: 'string'}
	    ,{ name: 'orderPackingDt', type: 'string'}
	    ,{ name: 'regiNo', type: 'string'}
	    ,{ name: 'orderSendDt', type: 'string'}
        ,{ name: 'orderDeliDt', type: 'string'}
	    ,{ name: 'salesTpPmaNm', type: 'string'}
	    ,{ name: 'ordersNm', type: 'string'}
	    ,{ name: 'ordersMobile', type: 'string'}
	    ,{ name: 'depositNm', type: 'string'}
	    ,{ name: 'receiptNm', type: 'string'}
	    ,{ name: 'receiptMobile', type: 'string'}
		,{ name: 'mbrId', type: 'string'}
		,{ name: 'orderStatusCd', type: 'string'}
		,{ name: 'claimTpCd', type: 'string'}
		,{ name: 'orderNo', type: 'string'}
	];

	function fnSearchInit(){
		fnGridOption('jqxgrid',{
	       	selectionmode: 'singlecell'
	        ,height: 460
	        //,statusbarheight: 25
	        //,showstatusbar: true
	        //,showaggregates: true
           , altrows: true
	        ,columns: _columns
	    });
	}
	/*----------------------------------------------------------------------------------------------
	 * grid search
	 *----------------------------------------------------------------------------------------------*/
	function fnSearch(){
		var params = $("#searchForm").serialize();
		var dataAdapter = new $.jqx.dataAdapter({
    		datatype: "json",
            datafields: _datafields,
            url: "orderSelectList.action?"+params
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
	}

	/*----------------------------------------------------------------------------------------------
	 * 이벤트 Setting
	 *----------------------------------------------------------------------------------------------*/
	 function fnEvent(){
		 $("#jqxgrid").on("bindingcomplete", function (event) {
  			 $("#depositAmountSum").text("0");
  			 $("#salesSum").text("0");
  			 $("#netSalesSum").text("0");
  			 $("#orderNomalCopnAmtSum").text("0");
  			 $("#orderLevCopnAmtSum").text("0");
  			 $("#orderCount").text("0");

  	  		var datainfo = $("#jqxgrid").jqxGrid('getdatainformation');
  	  		var params = $("#searchForm").serialize();


  	  	$.ajax({
	        url : "orderAmtSum.action?"+params,
	        type: "POST",
	        async: false,
	        success:function(data, result)
	        {
	           $("#depositAmountSum").text(setComma(parseInt(data.depositAmountSum)));
	 	  	   $("#salesSum").text(setComma(parseInt(data.salesSum)));
	 	  	   $("#netSalesSum").text(setComma(parseInt(data.netSalesSum)));
	 	  	   $("#orderNomalCopnAmtSum").text(setComma(parseInt(data.orderNomalCopnAmtSum)));
	 	  	   $("#orderLevCopnAmtSum").text(setComma(parseInt(data.orderLevCopnAmtSum)));
	        },
	        error: function(jqXHR, textStatus, errorThrown){}
	   	}); // ajax

  	  	   $("#orderCount").text(setComma(datainfo.rowscount));

  		});

		 $("#btn_Search").on('click', fnSearch);//검색

			$("#jqxgrid").on("celldoubleclick", function (event){
						 var args = event.args;
						var rowBoundIndex = args.rowindex;
									var orderNo = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "orderNo");
									var claimTpCd = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "claimTpCd");

									setTimeout(function(){
										$("#fancyBtn").attr("href","/mng/amM3/amM3/orderDtl.action?orderNo="+orderNo+"&claimTpCd="+claimTpCd);
										$("#fancyBtn").click();
									},200);
		});



		$("#claimYnAll").bind("click",function(){
			if($(this).is(":checked") == true){
				$("#claimTp").show();
			}else{
				$("#claimTp").hide();
			}
		});

		$("input[name=conditionVal]").bind("keyup",function(e){
			if(e.keyCode == 13){
				fnSearch();
			}
		});

 		$("#fancyBtn").fancybox({
			type		: "iframe",
			maxWidth	: 1200,
			maxHeight	: 900,
			width		: 1200,
			height		: 900,
			modal 		: false,
			autoSize	: false
		});
	}

	/*----------------------------------------------------------------------------------------------
	 * 화면 기본 데이터 셋팅
	 *----------------------------------------------------------------------------------------------*/
	function fnDataSetting(){
		var nowTimeArr = "${nowYmd}".split("-");
// 		dateTimeInput("txtFromDt", null, "${iConstant.prevDayYmd(-7)}");
  		dateTimeInput("txtFromDt", null, "${nowYmd}");
		dateTimeInput("txtToDt", null, "${nowYmd}");
		$("#claimTp").hide();
// 		$("#orderStatusAll").click();
	}
	//-->
</script>
</head>

<body>
	<a id="fancyBtn"  data-fancybox-type="iframe"  href="javascript:;" style="display:none"></a>
	<div class="top_box">
		<div class="table_type">
			<form name="searchForm" id="searchForm">
			<table>
				<caption>주문검색, 주문번호, 일자검색, 매출타입, 수령인휴대전화, 주문상태, 클레임상태로 구성된 전체주문조회 및 관리에 대한 검색 테이블입니다.</caption>
				<colgroup>
					<col style="width:12%;">
					<col style="width:38%;">
					<col style="width:12%;">
					<col style="width:38%;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">선택검색</th>
						<td>
							<select name="condition" style="width:134px;">
								<option value="ordersNm">주문자</option>
								<option value="ordersMobile">주문자휴대전화</option>
								<option value="receiptNm">수령인</option>
								<option value="receiptMobile">수령인휴대전화</option>
								<option value="depositNm">입금자</option>
								<option value="mbrId">회원아이디</option>
								<option value="orderNm">상품명</option>
								<option value="orderNo">주문번호</option>
								<option value="regiNo">송장번호</option>
							</select>
							<input type="text" name="conditionVal" style="width:180px;ime-mode:active;">
						</td>
						<th scope="row">결재방식</th>
						<td>
							<html:selectList name='orderCash' id='orderCash' list='${orderCashList}' listValue='orderCashCd' listName='orderCashNm' optionValues="" optionNames="전체" script='style="width:134px;"'/>
						</td>
					</tr>

					<tr>
						<th scope="row">일자검색</th>
						<td>
							<div style='float:left;margin-right:5px;'>
							<select name="orderDtStyle" style="width:130px;">
								<option value="orderDt" selected>주문일자</option>
								<option value="depositDt">입금일자</option>
								<option value="orderPackingDt">발송(패킹)완료일자</option>
								<option value="orderSendDt">배송요청일자</option>
								<option value="orderDeliDt">배송완료일자</option>
								<option value="claimReqDt">크래임요청일자</option>
								<option value="claimDueDt">크래임완료일자</option>
							</select>
							</div>
							<div style='float:left;'>
							<div id='txtFromDt' style='float:left;'></div>
								<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
							<div id='txtToDt'  style='float:left;'></div>
							</div>
						</td>
						<th scope="row">매출타입</th>
						<td>
							<select name="salesStyle" style="width:174px;">
								<option value="" >전체</option>
								<option value="normal" >일반매출</option>
								<option value="mobile" >스마트폰매출</option>
								<option value="ars" >전화주문매출</option>
								<option value="new" >신규매출</option>
								<option value="set" >세트상품</option>
								<option value="point" >포인트사용</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">주문상태</th>
						<td>
						<c:forEach items="${orderStatusList}" var="orderStatus" varStatus="idx">
							<div style="float:left; margin:5px 0 5px;"><input type="checkbox" id="${orderStatus.orderStatusCd}" name="orderStatusCd" value="${orderStatus.orderStatusCd}"   /><label for="${orderStatus.orderStatusCd}" class="marL5 marR10">${orderStatus.orderStatusNm}</label></div>
						</c:forEach>
						</td>
						<th scope="row">클레임주문건</th>
						<td >
						<div style="float:left; margin:5px 0 5px;"><input type="checkbox" id="claimYnAll" name="claimYnAll" value="Y"   /><label for="claimYnAll" class="marL5 marR10">클레임 주문건 포함</label></div>
						</td>
					</tr>
					<tr id="claimTp">
						<th scope="row">클레임상태</th>
						<td colspan="3">
						<c:forEach items="${claimTpList}" var="claimTp" varStatus="idx">
							<div style="float:left; margin:5px 0 5px;"><input type="checkbox" id="${claimTp.claimTpCd}" name="claimTpCd" value="${claimTp.claimTpCd}" /><label for="${claimTp.claimTpCd}" class="marL5 marR10">${claimTp.claimTpNm}</label></div>
						</c:forEach>
						</td>
					</tr>
				</tbody>
			</table>
			</form>
		</div>
		<!-- // table_type -->
	</div>

		<!-- // top_box -->
		<div class="btn_area marB35" >
			<div class="center">
				<a id="btn_Search" class="btn_blue_line2" href="javascript:;">검색</a>
			</div>
			<div class="right" style="line-height:40px;">
				<a class="btn_type2 btn_icon5" id="btnExcel"  href="javascript:;" onclick="grideExportExcel('jqxgrid','주문관리목록');">엑셀다운로드</a>
			</div>
		</div>
		<div class="table_type2" style="margin-bottom:10px;min-width:970px; font-size:12px;">
					<table>
						<caption>인원, 총금액, 판매상품으로 구성된 회원주문매출통계에 대한 테이블입니다.</caption>
						<colgroup>

							<col style="width:*;" />
							<col style="width:*;" />
							<col style="width:*;" />
							<col style="width:*;" />
							<col style="width:*;" />
							<col style="width:*;" />
							<col style="width:*;" />
							<col style="width:*;" />
							<col style="width:*;" />
							<col style="width:*;" />
							<col style="width:*;" />
							<col style="width:*;" />
						</colgroup>
						<tbody>
							<tr>
								<th  scope="row" class="alignC">건수</th>
								<td>
									<span id="orderCount">0</span>건
								</td>
								<th id="" scope="row" class="alignC">결제금액<br/><span style="font-weight:normal;">(클레임제외)</span></th>
								<td>
									<span id="depositAmountSum">0</span>원
								</td>
								<th scope="row" class="alignC">일반쿠폰</th>
								<td>
									<span id="orderNomalCopnAmtSum">0</span>원
								</td>

								<th scope="row" class="alignC">회원쿠폰</th>
								<td>
									<span id="orderLevCopnAmtSum">0</span>원
								</td>
								<th scope="row" class="alignC">적립금사용</th>
								<td>
									<span id="orderResvAmt">0</span>원
								</td>
								<th scope="row" class="alignC" style="background-color: #c3a279">매출</th>
								<td>
									<span id="salesSum">0</span>원
								</td>
								<th scope="row" class="alignC"  style="background-color: #c3a279">순매출</th>
								<td>
									<span id="netSalesSum">0</span>원
								</td>

							</tr>
						</tbody>
					</table>
				</div>
	<!-- // align_area -->
		<div class="grid_type1">
			<div id="jqxgrid" ></div>
		</div>

</body>