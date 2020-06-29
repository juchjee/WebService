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
		,{ text: '송장번호', datafield: 'regiNo', width: '10%', cellsalign: 'left', align: 'center'}
		,{ text: '상품명', datafield: 'prodNm', width: '18%', cellsalign: 'left', align: 'center'}
		,{ text: '발송(패킹)완료일', datafield: 'orderPackingDt' , width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '배송상태', datafield: 'orderSendDtNm',width: '7%', cellsalign: 'center', align: 'center'}
// 		,{ text: '배송완료일', datafield: 'orderDeliDt', width: '7%' , cellsalign: 'center', align: 'center'}
		,{ text: '매출타입', datafield: 'salesTpPmaNm', width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '주문일자', datafield: 'orderDt', width: '7%' , cellsalign: 'center', align: 'center'}
		,{ text: '결제금액', datafield: 'depositAmount', width: '8%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
		,{ text: '쿠폰할인가', datafield: 'orderCopnAmt', width: '7%',cellsalign: 'right', align: 'center' , cellsformat: 'c'}
		,{ text: '배송비', datafield: 'orderDeliChargeNm', width: '6%', cellsalign: 'center', align: 'center'}
		,{ text: '결제방식', datafield: 'orderCashNm', width: '9%', cellsalign: 'center', align: 'center'}
		,{ text: '주문자', datafield: 'ordersNm', width: '5%', cellsalign: 'center', align: 'center' }
		,{ text: '주문자휴대전화', datafield: 'ordersMobile', width: '10%', cellsalign: 'center', align: 'center' }
		,{ text: '입금자', datafield: 'depositNm', width: '5%', cellsalign: 'center', align: 'center' }
		,{ text: '수령인', datafield: 'receiptNm', width: '5%', cellsalign: 'center', align: 'center' }
		,{ text: '수령인휴대전화', datafield: 'receiptMobile', width: '10%', cellsalign: 'center', align: 'center' }
		,{ text: '회원아이디', datafield: 'mbrId', width: '10%', cellsalign: 'center', align: 'center' }
		,{ text: '주문상태코드', datafield: 'orderStatusCd', hidden: true}
		,{ text: '매출타입', datafield: 'salesTpPmaCd', hidden: true}
		,{ text: '주문번호(REAL)', datafield: 'orderNo', hidden: true}
	];
	var _datafields = [
	     { name: 'orderNoNm', type: 'string'}
	    ,{ name: 'regiNo', type: 'string'}
		,{ name: 'prodNm', type: 'string'}
		,{ name: 'orderPackingDt', type: 'string'}
		,{ name: 'orderSendDtNm', type: 'string'}
// 		,{ name: 'orderDeliDt', type: 'string'}
		,{ name: 'salesTpPmaNm', type: 'string'}
		,{ name: 'orderDt', type: 'string'}
		,{ name: 'depositAmount', type: 'number'}
		,{ name: 'orderCopnAmt', type: 'number'}
		,{ name: 'orderDeliChargeNm', type: 'string'}
		,{ name: 'orderCashNm', type: 'string'}
		,{ name: 'ordersNm', type: 'string'}
		,{ name: 'ordersMobile', type: 'string'}
		,{ name: 'depositNm', type: 'string'}
		,{ name: 'receiptNm', type: 'string'}
		,{ name: 'receiptMobile', type: 'string'}
		,{ name: 'mbrId', type: 'string'}
		,{ name: 'orderStatusCd', type: 'string'}
		,{ name: 'salesTpPmaCd', type: 'string'}
		,{ name: 'orderNo', type: 'string'}
	];

	function fnSearchInit(){
		fnGridOption('jqxgrid',{
	       	selectionmode: 'checkbox'
	        ,height: 400
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
		 $("#btn_Search").on('click', fnSearch);//검색

		 $("#orderCancel").bind("click", function(e){
				var title = $(this).text();
				var id = $(this).attr("id");
				var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindexes');
				if(rowindex == ""){
					alert(title+"할 대상을 선택해주세요.");
					return false;
				}

				var postData = new Array();

				for(key in rowindex){
					var paramData = new Object();
					paramData["orderNo"] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderNo");
					paramData["orderStatusCd"] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderStatusCd");
					paramData["orderCashCd"] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderCashCd");
					paramData["orderCashCd"] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderCashCd");

					postData.push(paramData);
				}
				var postDataJson = JSON.stringify(postData);
				if(confirm(title+"를 하시겠습니까?")){
					fnAjax("/mng/amM3/amM3/orderCancelProc.action",{data : postDataJson}, function(data, dataType){
						var data = data.replace(/\s/gi,'');
						alert(data);
						fnSearch();
						$('#jqxgrid').jqxGrid('clearselection');
					},'POST','text');
				}
		 });

		 $("#orderOk").bind("click", function(e){
			 	var paramData = new Array();
				var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindexes');
				if(rowindex == ""){
					alert("배송완료 대상을 선택해주세요.");
					return false;
				}
				for(key in rowindex){
					var orderStatusCd = $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderStatusCd");
					if(orderStatusCd != "OOS00009"){
						paramData.push({orderNo:$('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderNo")});
					}
				}
				var postDataJson = JSON.stringify(paramData);
				if(confirm("해당 주문건을 수동으로 배송완료 하시겠습니까?")){
					fnAjax("orderOk.action",{data : postDataJson}, function(data, dataType){
						var data = data.replace(/\s/gi,'');
						if(data=="ok"){
							alert("정상적으로 배송완료 처리되었습니다.");
							fnSearch();
						}else{
							alert("배송완료처리가 실패하였습니다.");
							fnSearch();
						}
						$('#jqxgrid').jqxGrid('clearselection');
					},'POST','text');
				}else{
					return false;
				}
		 });

		$("#jqxgrid").on("celldoubleclick", function (event){
						 var args = event.args;
						var rowBoundIndex = args.rowindex;
									var orderNo = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "orderNo");
									setTimeout(function(){
										$("#fancyBtn").attr("href","/mng/amM3/amM3/orderDtl.action?orderNo="+orderNo);
										$("#fancyBtn").click();
									},200);
		});

		$("input[name=conditionVal]").bind("keyup",function(e){
			if(e.keyCode == 13){
				fnSearch();
			}

		});
		$("#fancyBtn").fancybox({
			type: "iframe",
			maxWidth	: 1200,
			maxHeight	: 900,
			width		: 1200,
			height		: 800,
			modal : false,
			autoSize	: false
		});

		// 회차 검색 여부 확인
		$("#packingTimeCheck").bind("click", function(e){
			if($("input[name='packingTimeCheck']").is(":checked")){
				alert("회차검색 선택시 일자검색은 검색 조회조건에 포함되지 않습니다");
				$("#packingTimeCheck").val("Y");
			}else{
				$("#packingTimeCheck").val("N");
			}
		});

		// 회차 검색선택시 활성화
		$('#packingTime').on('change', function() {
			if(!$("input[name='packingTimeCheck']").is(":checked")){
				$("input[name=packingTimeCheck]").prop("checked", true);
				alert("회차 선택시 일자검색은 검색조건에 포함되지 않습니다");
			}
	    });
	}

	/*----------------------------------------------------------------------------------------------
	 * 화면 기본 데이터 셋팅
	 *----------------------------------------------------------------------------------------------*/
	function fnDataSetting(){
		var nowTimeArr = "${nowYmd}".split("-");
  		dateTimeInput("txtFromDt", null, "${iConstant.prevDayYmd(-15)}");
		dateTimeInput("txtToDt", null, "${nowYmd}");
		dateTimeInput("orderPackingTime", null, "${nowYmd}");
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
					<col style="width:10%;">
					<col style="width:40%;">
					<col style="width:10%;">
					<col style="width:40%;">
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
							<select name="orderDtStyle" style="width:120px;">
								<option value="orderDt">주문일자</option>
								<option value="orderSendDt">배송요청일자</option>
								<option value="orderDeliDt">배송완료일자</option>
								<option value="orderPackingDt">발송(패킹)완료일자</option>
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
						<th scope="row">배송상태</th>
						<td>
							<div style="float:left;margin-right:10px;"><input type="radio" id="orderStatusCdAll" name="orderStatusCd" value="" checked="checked"/><label for="orderStatusCdAll">전체</label></div>
							<div style="float:left;margin-right:10px;"><input type="radio" id="OOS00004" name="orderStatusCd" value="OOS00004"/><label for="OOS00004">배송중</label></div>
							<div style="float:left;margin-right:10px;"><input type="radio" id="OOS00009" name="orderStatusCd" value="OOS00009"/><label for="OOS00009">배송완료</label></div>
						</td>
						<th scope="row">결재금액</th>
						<td>
							<div style="float:left;margin-right:10px;"><input type="text" style="width:80px;" class="validation[number]" name="depositAmountFrom" value="" checked="checked"/></div>
							<div style="float:left;margin-right:10px;line-height:30px;">-</div>
							<div style="float:left;margin-right:10px;"><input type="text"  style="width:80px;" class="validation[number]" name="depositAmountTo" value="" checked="checked"/></div>
						</td>
					</tr>
					<tr>
						<th scope="row">회차검색</th>
						<td colspan="3">
							<div style='float:left;'>
								<div id='orderPackingTime' style='float:left;'></div>
							</div>
							<select name="packingTime" id="packingTime" style="width:80px;">
								<option value="1" selected>1회차</option>
								<option value="2">2회차</option>
								<option value="3">3회차</option>
							</select>
							&nbsp;&nbsp;
							<input type="checkbox" name="packingTimeCheck" id="packingTimeCheck" value="Y">&nbsp;선택
							&nbsp;&nbsp;<font style="font-weight:bold;color:red;font-size:12px;">※ 배송상태(배송중/배송완료)에 한해서만 회차검색이 가능합니다</font>

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
			<div class="left " style="line-height:40px;">
				<a id="orderCancel" class="listBtn btn_type2" href="#">주문취소접수</a>
			</div>
			<div class="right" style="line-height:40px;">
			<a id="orderOk" class="btn_type2"  href="javascript:;">수동배송완료</a>
			<a class="btn_type2 btn_icon5" style="margin-left: 0px;" id="btnExcel"  href="javascript:;" onclick="grideExportExcel('jqxgrid','배송상태목록');">엑셀다운로드</a>
			</div>
		</div>

	<!-- // align_area -->
		<div class="grid_type1">
			<div id="jqxgrid" ></div>
		</div>

</body>