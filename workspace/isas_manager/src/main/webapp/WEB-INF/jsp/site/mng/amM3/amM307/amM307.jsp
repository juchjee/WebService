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
	    ,{ text: '상품명', datafield: 'prodNm', width: '18%', cellsalign: 'left', align: 'center'}
	    ,{ text: '클레임상태', datafield: 'claimTpNm', width: '7%', cellsalign: 'center', align: 'center'}
	    ,{ text: '클레임요청일', datafield: 'claimReqDt', width: '7%', cellsalign: 'center', align: 'center'}
	    ,{ text: '주문일자', datafield: 'orderDt', width: '7%' , cellsalign: 'center', align: 'center'}
	    ,{ text: '주문자', datafield: 'ordersNm', width: '5%', cellsalign: 'center', align: 'center' }
	    ,{ text: '입금자', datafield: 'depositNm', width: '5%', cellsalign: 'center', align: 'center' }
	    ,{ text: '수령인', datafield: 'receiptNm', width: '5%', cellsalign: 'center', align: 'center' }
	    ,{ text: '결제금액', datafield: 'depositAmount', width: '8%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
	    ,{ text: '배송비', datafield: 'orderDeliChargeNm', width: '6%', cellsalign: 'center', align: 'center'}
	    ,{ text: '주문상태', datafield: 'orderStatusNm', width: '7%', cellsalign: 'center', align: 'center'}
	    ,{ text: '배송상태', datafield: 'orderSendDtNm',width: '7%', cellsalign: 'center', align: 'center'}
	    ,{ text: '결제방식', datafield: 'orderCashNm', width: '9%', cellsalign: 'center', align: 'center'}
	    ,{ text: '패킹상태', datafield: 'orderPackingStatus', width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '발송(패킹)완료일', datafield: 'orderPackingDt' , width: '7%', cellsalign: 'center', align: 'center'}
	    ,{ text: '송장번호', datafield: 'regiNo', width: '10%', cellsalign: 'left', align: 'center'}
	    ,{ text: '배송요청일', datafield: 'orderSendDt', width: '7%', cellsalign: 'center', align: 'center'}
	    ,{ text: '배송완료일', datafield: 'orderDeliDt', width: '7%', cellsalign: 'center', align: 'center'}
	    ,{ text: '매출타입', datafield: 'salesTpPmaNm', width: '7%', cellsalign: 'center', align: 'center'}
	    ,{ text: '주문자휴대전화', datafield: 'ordersMobile', width: '10%', cellsalign: 'center', align: 'center' }
	    ,{ text: '수령인휴대전화', datafield: 'receiptMobile', width: '10%', cellsalign: 'center', align: 'center' }
	    ,{ text: '주문상태코드', datafield: 'orderStatusCd', hidden: true}
	    ,{ text: '클레임상태코드', datafield: 'claimTpCd', hidden: true}
	    ,{ text: '주문번호(REAL)', datafield: 'orderNo', hidden: true}
	];


	var _datafields = [
	     { name: 'orderNoNm', type: 'string'}
	    ,{ name: 'prodNm', type: 'string'}
	    ,{ name: 'claimTpNm', type: 'string'}
	    ,{ name: 'claimReqDt', type: 'string'}
	    ,{ name: 'orderDt', type: 'string'}
	    ,{ name: 'ordersNm', type: 'string'}
	    ,{ name: 'depositNm', type: 'string'}
	    ,{ name: 'receiptNm', type: 'string'}
	    ,{ name: 'depositAmount', type: 'number'}
	    ,{ name: 'orderDeliChargeNm', type: 'string'}
	    ,{ name: 'orderStatusNm', type: 'string'}
	    ,{ name: 'orderSendDtNm', type: 'string'}
	    ,{ name: 'orderCashNm', type: 'string'}
	    ,{ name: 'orderPackingDt', type: 'string'}
	    ,{ name: 'orderPackingStatus', type: 'string'}
	    ,{ name: 'orderPackingDt', type: 'string'}
	    ,{ name: 'regiNo', type: 'string'}
	    ,{ name: 'orderSendDt', type: 'string'}
	    ,{ name: 'orderDeliDt', type: 'string'}
	    ,{ name: 'salesTpPmaNm', type: 'string'}
	    ,{ name: 'ordersMobile', type: 'string'}
	    ,{ name: 'receiptMobile', type: 'string'}
	    ,{ name: 'orderStatusCd', type: 'string'}
	    ,{ name: 'claimTpCd', type: 'string'}
	    ,{ name: 'orderNo', type: 'string'}
	];

	function fnSearchInit(){
		fnGridOption('jqxgrid',{
	       	selectionmode: 'singlecell'
	        ,height: 370
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
		if(fnValidation()){
			var params = $("#searchForm").serialize();
			var dataAdapter = new $.jqx.dataAdapter({
	    		datatype: "json",
	            datafields: _datafields,
	            url: "orderSelectList.action?"+params
			});
			$("#jqxgrid").jqxGrid({source: dataAdapter});
		}
	}

	/*----------------------------------------------------------------------------------------------
	 * 이벤트 Setting
	 *----------------------------------------------------------------------------------------------*/
	 function fnEvent(){
		 $("#btn_Search").on('click', fnSearch);//검색

		 $(".listBtn").bind("click", function(e){
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
					paramData["type"] =  id;
					postData.push(paramData);
				}
				var postDataJson = JSON.stringify(postData);
				if(confirm(title+"를 하시겠습니까?")){
					fnAjax("/mng/amM3/amM3/orderCancelProc.action",{data : postDataJson}, function(data, dataType){
						var data = data.replace(/\s/gi,'');
						alert(data);
						fnSearch();
					},'POST','text');
				}
		 });



			$("#jqxgrid").on("celldoubleclick", function (event){
						 var args = event.args;
						var rowBoundIndex = args.rowindex;
									var orderNo = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "orderNo");
									var claimTpCd = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "claimTpCd");


									setTimeout(function(){
										$.fancybox.open({
											href: "/mng/amM3/amM3/orderClaimDtl.action?orderNo="+orderNo,
											type: "iframe",
								 			maxWidth	: 1300,
								 			maxHeight	: 1600,
								 			width		: 1300,
								 			height		: 1600,
								 			autoSize	: false,
								 			modal : false,
											beforeClose : function(){
										    	fnSearch();
											}
										});
									},200);

		});
		 $("#orderStatusAll").bind("click",function(){
				$("input[name=orderStatusCd]").prop("checked",$(this).is(":checked"));
		});

		$("#claimTpAll").bind("click",function(){
			$("input[name=claimTpCd]").prop("checked",$(this).is(":checked"));
		});

		$("input[name=conditionVal]").bind("keyup",function(e){
			if(e.keyCode == 13){
				fnSearch();
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
		$("#OCT00001").prop("checked",true);
		$("#OCT00002").prop("checked",true);
		$("#OCT00003").prop("checked",true);
		$("#OCT00004").prop("checked",true);
		$("#OCT00005").prop("checked",true);
	}
	//-->
</script>
</head>

<body>
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
								<option value="claimReqDt">크래임요청일자</option>
								<option value="claimDueDt">크래임완료일자</option>
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
						<th scope="row">클레임상태</th>
						<td colspan="3">
								<div style="float:left; margin:5px 0 5px;"><input type="checkbox" id="claimTpAll" name="claimTpAll" value="" /><label for="claimTpAll" class="marL5 marR10">전체</label></div>
							<c:forEach items="${claimTpList}" var="claimTp" varStatus="idx">
								<div style="float:left; margin:5px 0 5px;"><input type="checkbox" id="${claimTp.claimTpCd}" class="validation[choose]" title="클레임상태" name="claimTpCd" value="${claimTp.claimTpCd}" /><label for="${claimTp.claimTpCd}" class="marL5 marR10">${claimTp.claimTpNm}</label></div>
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
				<a class="btn_type2 btn_icon5" id="btnExcel"  href="javascript:;" onclick="grideExportExcel('jqxgrid','클레임목록');">엑셀다운로드</a>
			</div>
		</div>


	<!-- // top_box -->
	<!-- // align_area -->
		<div class="grid_type1" style="margin-top:35px;" >
			<div id="jqxgrid" ></div>
		</div>

</body>