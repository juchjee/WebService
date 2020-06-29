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
	    { text: '주문번호', datafield: 'orderNoNm', width: '7%', cellsalign: 'center', align: 'center', editable: false}
		,{ text: '주문자', datafield: 'ordersNm', width: '5%', cellsalign: 'center', align: 'center', editable: false}
		,{ text: '수령인', datafield: 'receiptNm', width: '5%', cellsalign: 'center', align: 'center', editable: false}
		,{ text: '상품명', datafield: 'prodNm', width: '15%', cellsalign: 'left', align: 'center', editable: false}
		,{ text: '주문자휴대전화', datafield: 'ordersMobile', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
		,{ text: '수령인휴대전화', datafield: 'receiptMobile', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
		,{ text: '수령인전화', datafield: 'receiptTel', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
		,{ text: '우편번호', datafield: 'receiptZipcode', cellclassname: cellclass, width: '4%', cellsalign: 'center', align: 'center'}
		,{ text: '수령지주소', datafield: 'receiptAddr', cellclassname: cellclass, width: '20%', cellsalign: 'left', align: 'center'}
		,{ text: '수령지상세주소', datafield: 'receiptAddrDtl', cellclassname: cellclass, width: '10%', cellsalign: 'left', align: 'center'}
		,{ text: '송장메세지', datafield: 'message', width: '8%', cellsalign: 'left', align: 'center', editable: false}
		,{ text: '에러코드', datafield: 'errorCode', width: '4%', cellsalign: 'center', align: 'center', editable: false}
		,{ text: '매출타입', datafield: 'salesTpPmaNm', width: '7%', cellsalign: 'center', align: 'center', editable: false}
		,{ text: '주문일자', datafield: 'orderDt', width: '7%', cellsalign: 'center', align: 'center', editable: false}
	    ,{ text: '입금일자', datafield: 'depositDt', width: '7%', cellsalign: 'center', align: 'center', editable: false}
		,{ text: '결제금액', datafield: 'depositAmount', width: '5%', cellsalign: 'right', align: 'center' , cellsformat: 'c', editable: false}
		,{ text: '배송비', datafield: 'orderDeliChargeNm', width: '6%', cellsalign: 'center', align: 'center', editable: false}
		,{ text: '결제방식', datafield: 'orderCashNm', width: '9%', cellsalign: 'center', align: 'center', editable: false}
		,{ text: '입금자', datafield: 'depositNm', width: '5%', cellsalign: 'center', align: 'center', editable: false}
		,{ text: '회원아이디', datafield: 'mbrId', width: '7%', cellsalign: 'center', align: 'center', editable: false}
		,{ text: '주문상태코드', datafield: 'orderStatusCd', hidden: true}
		,{ text: '매출타입', datafield: 'salesTpPmaCd', hidden: true}
		,{ text: '주문번호(REAL)', datafield: 'orderNo', hidden: true}
	];
	var _datafields = [
	     { name: 'orderNoNm', type: 'string'}
		,{ name: 'prodNm', type: 'string'}
		,{ name: 'ordersMobile', type: 'string'}
		,{ name: 'receiptMobile', type: 'string'}
		,{ name: 'receiptTel', type: 'string'}
		,{ name: 'receiptZipcode', type: 'string'}
		,{ name: 'receiptAddr', type: 'string'}
		,{ name: 'receiptAddrDtl', type: 'string'}
		,{ name: 'message', type: 'string'}
		,{ name: 'errorCode', type: 'string'}
		,{ name: 'salesTpPmaNm', type: 'string'}
		,{ name: 'orderDt', type: 'string'}
		,{ name: 'depositDt', type: 'string'}
		,{ name: 'depositAmount', type: 'number'}
		,{ name: 'orderDeliChargeNm', type: 'string'}
		,{ name: 'orderCashNm', type: 'string'}
		,{ name: 'ordersNm', type: 'string'}
		,{ name: 'depositNm', type: 'string'}
		,{ name: 'receiptNm', type: 'string'}
		,{ name: 'mbrId', type: 'string'}
		,{ name: 'orderStatusCd', type: 'string'}
		,{ name: 'salesTpPmaCd', type: 'string'}
		,{ name: 'orderNo', type: 'string'}
	];

	function fnSearchInit(){
		fnGridOption('jqxgrid',{
	       	selectionmode: 'checkbox'
	       	,pageable: true
	       	,pagesizeoptions : [100,200,500,1000]
	        ,height: 330
	        ,pagesize: 500
	        ,editable: true
	        ,altrows: true
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
		$('#jqxgrid').jqxGrid('clearselection');
	}

	/*----------------------------------------------------------------------------------------------
	 * 이벤트 Setting
	 *----------------------------------------------------------------------------------------------*/
	 function fnEvent(){
		 $("#btn_Search").on('click', fnSearch);//검색

		 $("#orderCancelIng").bind("click", function(e){
				var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindexes');
				if(rowindex == ""){
					alert("환불진행할 대상을 선택해주세요.");
					return false;
				}
				var postData = new Array();
				for(key in rowindex){
					 var paramData = new Object();
					paramData["orderNo"] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderNo");
					paramData["orderStatusCd"] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderStatusCd");
					paramData["orderCashCd"] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderCashCd");

					postData.push(paramData);
				}
				var postDataJson = JSON.stringify(postData);
				if(confirm("해당 주문건들을 환불접수 하시겠습니까?")){
					fnAjax("/mng/amM3/amM3/orderCancelProc.action",{data : postDataJson}, function(data, dataType){
						var data = data.replace(/\s/gi,'');
						alert(data);
						$('#jqxgrid').jqxGrid('clearselection');
						fnSearch();
						$('#jqxgrid').jqxGrid('clearselection');
					},'POST','text');
				}
		 });


		$("#jqxgrid").on("celldoubleclick", function (event){
				var args = event.args;
				var rowBoundIndex = args.rowindex;
				var orderNo = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "orderNo");
				if(event.args.datafield == 'ordersMobile'
						|| event.args.datafield == 'receiptMobile'
						|| event.args.datafield == 'receiptZipcode'
						|| event.args.datafield == 'receiptAddr'
						|| event.args.datafield == 'receiptAddrDtl' ){
						return false;
					}else{
						setTimeout(function(){
							$("#fancyBtn").attr("href","/mng/amM3/amM3/orderDtl.action?orderNo="+orderNo);
							$("#fancyBtn").click();
						},200);
					}
		});

		$("#fancyBtn").fancybox({
				type: "iframe",
				maxWidth	: 1200,
				maxHeight	: 900,
				width		: 1200,
				height		: 900,
				modal : false,
				autoSize	: false
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
	}

	function fnEpostSuccess(data, dataType){
		loadingOff();
		if(data){
			alert(data.message);
			if(data.flag == "Y"){
				fnResetGridEditData("jqxgrid");
				fnSearch();
			}
		}
		runEpost = false;
	}

	function fnEpostError(data, dataType){
		loadingOff();
		try {
			if(data.responseText.indexOf("해당 페이지는 로그인 후 이용 가능 합니다.")){
				window.location.reload();
			}
		} catch (e) {
			alert(e.message);
		}
		runEpost = false;
	}

	var runEpost = false;
	function fnEpostHandler(){
		if(runEpost) return false;
		var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindexes');
		if(rowindex == ""){
			alert("송장번호 발급 받을 대상을 선택해주세요.");
			return false;
		}
		var orderNos = "";
		var paginginformation = $("#jqxgrid").jqxGrid('getpaginginformation');
		var pagenum = paginginformation.pagenum;//현제페이지
		var pagesize = paginginformation.pagesize;//페이지당 로우 갯수
		var firstRow = pagenum * pagesize;
		var lastRow = firstRow + pagesize;
		$.each(rowindex, function(index, key){
			if(firstRow <= key && lastRow > key){
				if(orderNos != ""){
					orderNos += "▤";
				}
				orderNos +=  $('#jqxgrid').jqxGrid('getcellvalue', key, "orderNo");
			}
		});
		if(orderNos == ""){
			alert("송장번호 발급 받을 대상을 선택해주세요.");
			return false;
		}
		if(confirm("해당 주문건들에 대해서 송장번호 발급을 실행 하겠습니까?")){
			runEpost = true;
			loadingOn();

			var packingOrderTime = "";
			var txtToDt = $("#txtToDt").val();

			if($("select[name=orderToDtTime]").val() == '09'){
				packingOrderTime = "1";		// 1회차
			}else if($("select[name=orderToDtTime]").val() == '13'){
				packingOrderTime = "2";		// 2회차
			}else if($("select[name=orderToDtTime]").val() == '15'){
				packingOrderTime = "3";		// 3회차
			}else{
				packingOrderTime = "4";		// 4회차
			}

			try {
				fnAjax("${rootUri}${conUrl}amM303Epost.action",{"orderNos" : orderNos, "txtToDt" : txtToDt, "packingOrderTime" : packingOrderTime }, fnEpostSuccess,'POST','json', true, fnEpostError);
			} catch (e) {
				alert(e.message);
				loadingOff();
			}
		}
		return false;
	}

	function fnEpostUpdateHandler(){
		if(runEpost) return false;
		runEpost = true;
		loadingOn();
		var _gridId = "jqxgrid";
		var editedRows = $grid_rows[_gridId]["editedRows"];
		if(getObjectSize(editedRows) > 0){
			if(confirm(message(MESSAGES_CFM.SAVE))){
				var _grid = $("#"+_gridId);
				var postData = new Array();//수정시 해당 row 데이터 저장
				for(var _name in editedRows){
					var data = _grid.jqxGrid('getrowdatabyid', _name);
					$.each(data, function(_inm, ivl){
						data[_inm] = getCellValue(ivl);
					});
					postData.push(data);
				}
				if(postData.length <= 0){
					alert(MESSAGES_VALID.NON_SAVE);
					return;
				}
				var editedRowsJson = JSON.stringify(postData);

				var packingOrderTime = "";
				var txtToDt = $("#txtToDt").val();

				if($("select[name=orderToDtTime]").val() == '09'){
					packingOrderTime = "1";		// 1회차
				}else if($("select[name=orderToDtTime]").val() == '13'){
					packingOrderTime = "2";		// 2회차
				}else if($("select[name=orderToDtTime]").val() == '15'){
					packingOrderTime = "3";		// 3회차
				}else{
					packingOrderTime = "4";		// 4회차
				}

				fnAjax("${rootUri}${conUrl}amM303UpdateEpost.action", {"data" : editedRowsJson, "txtToDt" : txtToDt, "packingOrderTime" : packingOrderTime}, fnEpostSuccess,'POST','json', true, fnEpostError);
			}else{
				 alert("취소 되었습니다.");
			 }
		 }else{
			 alert(message(MESSAGES_VALID.NON_SAVE));
		 }
		return false;
	}

	/**
	 * Loading중 On
	 */
	function loadingOn(){
	    var obj = document.getElementById("loader_background");
	    obj.style.width = document.body.scrollWidth + 'px';
	    obj.style.height = document.body.scrollHeight + 'px';
	    obj.style.filter = "alpha(opacity=60)";
	    obj.style.opacity = "0.6";
	    obj.style.visibility = "visible";
	}

	/**
	 * Loading중 Off
	 */
	function loadingOff(){
		$("#loader_background").css("visibility","hidden");
	}

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
							<select name="orderDtStyle" style="width:100px;">
								<option value="depositDt">입금일자</option>
								<option value="orderDt">주문일자</option>
								<option value="orderSendDt">배송일자</option>
							</select>
							</div>
							<div style='float:left;'>
							<div id='txtFromDt' style='float:left;'></div>
								<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
							<div id='txtToDt'  style='float:left;'></div>
							</div>
							<div style='float:left;margin-left:5px;'>
							<select name="orderToDtTime" style="width:130px;">
<!-- 								<option value="">전체</option> -->
								<option value="09">~ 9시 (1회차)</option>
								<option value="13">~ 13시 (2회차)</option>
								<option value="15">~ 15시 (3회차)</option>
								<option value="17">~ 17시 (4회차)</option>
							</select>
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
			<a id="orderCancelIng" class="btn_type2"  href="javascript:;">환불접수</a>
			</div>
			<div class="right" style="line-height:40px;">
				<a class="btn_type2" style="margin-left: 0px;"  href="javascript:;" onclick="return fnEpostHandler();">송장번호발급</a>
				<a class="btn_type2" style="margin-left: 0px;" href="javascript:;" onclick="return fnEpostUpdateHandler();">수정데이터재전송</a>
				<a class="btn_type2 btn_icon5" style="margin-left: 0px;" id="btnExcel"  href="javascript:;" onclick="grideExportExcel('jqxgrid','입금확인목록');">엑셀다운로드</a>
			</div>
		</div>
	<!-- // top_box -->

	<!-- // table_type1 -->
	<!-- // align_area -->
	<div class="grid_type1">
		<div id="jqxgrid" ></div>
	</div>
	<div id="loader_background" style="text-align:center;width:100%;height:100%;top:0px;position:absolute; z-index:1000;background:#1B1B1B;visibility:hidden;">
		<div style="position:absolute; width:100%; top:50%; height:240px; margin-top:-120px;"><img src="${contextPath}/images/ajax-loader.gif" alt="Loading" /></div>
	</div>
</body>