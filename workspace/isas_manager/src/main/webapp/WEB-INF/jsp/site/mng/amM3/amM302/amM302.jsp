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
		fnSearchReceive();
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅
	 *----------------------------------------------------------------------------------------------*/
	var _columns = [
		 { text: '주문번호', datafield: 'orderNoNm', width: '10%', cellsalign: 'center', align: 'center' }
		,{ text: '상품명', datafield: 'prodNm', width: '18%', cellsalign: 'left', align: 'center'}
		,{ text: '매출타입', datafield: 'salesTpPmaNm', width: '9%', cellsalign: 'center', align: 'center'}
		,{ text: '주문일자', datafield: 'orderDt', width: '12%' , cellsalign: 'center', align: 'center'}
		,{ text: '결제금액', datafield: 'depositAmount', width: '10%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
		,{ text: '배송비', datafield: 'orderDeliChargeNm', width: '8%', cellsalign: 'center', align: 'center'}
		,{ text: '결제방식', datafield: 'orderCashNm', width: '11%', cellsalign: 'center', align: 'center'}
		,{ text: '주문자', datafield: 'ordersNm', width: '10%', cellsalign: 'center', align: 'center' }
		,{ text: '주문자휴대전화', datafield: 'ordersMobile', width: '10%', cellsalign: 'center', align: 'center' }
		,{ text: '입금자', datafield: 'depositNm', width: '10%', cellsalign: 'center', align: 'center' }
		,{ text: '수령인', datafield: 'receiptNm', width: '10%', cellsalign: 'center', align: 'center' }
		,{ text: '수령인휴대전화', datafield: 'receiptMobile', width: '10%', cellsalign: 'center', align: 'center' }
		,{ text: '회원아이디', datafield: 'mbrId', width: '10%', cellsalign: 'center', align: 'center' }
		,{ text: '주문상태코드', datafield: 'orderStatusCd', hidden: true}
		,{ text: '결제방식', datafield: 'orderCashCd', hidden: true}
		,{ text: '매출타입', datafield: 'salesTpPmaCd', hidden: true}
		,{ text: '주문번호(REAL)', datafield: 'orderNo', hidden: true}
	];


	var _datafields = [
	     { name: 'orderNoNm', type: 'string'}
		,{ name: 'prodNm', type: 'string'}
		,{ name: 'salesTpPmaNm', type: 'string'}
		,{ name: 'orderDt', type: 'string'}
		,{ name: 'depositAmount', type: 'number'}
		,{ name: 'orderDeliChargeNm', type: 'string'}
		,{ name: 'orderCashNm', type: 'string'}
		,{ name: 'ordersNm', type: 'string'}
		,{ name: 'ordersMobile', type: 'string'}
		,{ name: 'depositNm', type: 'string'}
		,{ name: 'receiptNm', type: 'string'}
		,{ name: 'receiptMobile', type: 'string'}
		,{ name: 'mbrId', type: 'string'}
		,{ name: 'orderStatusCd', type: 'string'}
		,{ name: 'orderCashCd', type: 'string'}
		,{ name: 'salesTpPmaCd', type: 'string'}
		,{ name: 'orderNo', type: 'string'}
	];

	var _columns2 = [
				{ text: '순번', datafield: 'no', width: '10%', cellsalign: 'center', align: 'center'
			    	,cellsrenderer: function (row, column, value) {
			            return "<div style='margin:13px 5px 0px 0;text-align:right;'>" + (row + 1) + "</div>";
			        }
			     }
	       		,{ text: '입금자명', datafield: 'depositNm', width: '30%', cellsalign: 'center', align: 'center'}
	       		,{ text: '입금액', datafield: 'depositAmount', width: '30%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
	       		,{ text: '입금일자', datafield: 'regDt', width: '30%', cellsalign: 'center', align: 'center'}
	       		,{ text: '순번', datafield: 'recvSeq', hidden:true}
	       	];
 	var _datafields2 = [
 	    { name: 'no', type: 'string'}
 		,{ name: 'depositNm', type: 'string'}
 		,{ name: 'depositAmount', type: 'number'}
 		,{ name: 'regDt', type: 'string'}
 		,{ name: 'recvSeq', type: 'string'}
 	];

	function fnSearchInit(){
		fnGridOption('jqxgrid',{
	       	selectionmode: 'checkbox'
	       	,width:'68%'
	        ,height: 330
	        //,statusbarheight: 25
	        //,showstatusbar: true
	        //,showaggregates: true
           , altrows: true
	        ,columns: _columns
	    });

		fnGridOption('jqxgrid2',{
	       	selectionmode: 'singlerow'
		     ,width:'30%'
	        ,height: 360
	        //,statusbarheight: 25
	        ,showstatusbar: false
	        //,showaggregates: true
	        ,pageable:false
           , altrows: true
	        ,columns: _columns2
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

	function fnSearchReceive(){
		var dataAdapter2 = new $.jqx.dataAdapter({
    		datatype: "json",
            datafields: _datafields2,
            url: "depositTransferReceiveList.action"
		});
		$("#jqxgrid2").jqxGrid({source: dataAdapter2});
	}

	/*----------------------------------------------------------------------------------------------
	 * 이벤트 Setting
	 *----------------------------------------------------------------------------------------------*/
	 function fnEvent(){
		 $("#btn_Search").on('click', fnSearch);//검색

		 $("#orderCancel").bind("click", function(e){
				var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindexes');
				if(rowindex == ""){
					alert("주문취소할 대상을 선택해주세요.");
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
				if(confirm("해당 주문건들을 취소 하시겠습니까?")){
					fnAjax("/mng/amM3/amM3/orderCancelProc.action",{data : postDataJson}, function(data, dataType){
						var data = data.replace(/\s/gi,'');
						alert(data);
						fnSearch();
						$('#jqxgrid').jqxGrid('clearselection');
					},'POST','text');
				}
		 });

		 $("#orderMatching").bind("click", function(e){
				var paramData = new Object();
				var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindexes');
				var rowindex2 = $("#jqxgrid2").jqxGrid('getselectedrowindexes');
				if(rowindex == ""){
					alert("매칭할 대상을 선택해주세요.");
					return false;
				}
				if(rowindex.length > 1){
					alert("한개이상 매칭 대상을 선택할 수 없습니다.");
					return false;
				}
				if(rowindex2 == ""){
					alert("매칭할 입금자를 선택해주세요.");
					return false;
				}
				for(key in rowindex){
					paramData["orderNo"] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderNo");
					paramData["orderStatusCd"] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderStatusCd");
					paramData["orderCashCd"] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderCashCd");
					paramData["recvSeq"] =  $('#jqxgrid2').jqxGrid('getcellvalue',rowindex2[key], "recvSeq");
				}
				var postDataJson = JSON.stringify(paramData);
				if(confirm("해당 주문건을 매칭 하시겠습니까?")){
					fnAjax("orderMatching.action",{data : postDataJson}, function(data, dataType){
						var data = data.replace(/\s/gi,'');
						if(data=="ok"){
							alert("정상적으로 입금자 수동 매칭이 완료되었습니다.");
							fnSearch();
							fnSearchReceive();
						}else{
							alert("입금자 수동 매칭이 실패하였습니다.");
							fnSearch();
							fnSearchReceive();
						}
						$('#jqxgrid').jqxGrid('clearselection');
					},'POST','text');
				}else{
					return false;
				}
		 });

		 $("#orderDel").bind("click", function(e){
				var rowindex = $("#jqxgrid2").jqxGrid('getselectedrowindexes');
				if(rowindex == ""){
					alert("삭제할 대상을 선택해주세요.");
					return false;
				}
				var recvSeq =  $('#jqxgrid2').jqxGrid('getcellvalue', rowindex, "recvSeq");
				if(confirm("해당 건을 삭제하시겠습니까?")){
					fnAjax("orderReceive.action", {"recvSeq" : recvSeq}, function(data, dataType){
						if(data=="ok"){
							alert("정상적으로 삭제되었습니다.");
							fnSearch();
							fnSearchReceive();
						}else{
							alert("삭제에 실패하였습니다.");
							fnSearch();
							fnSearchReceive();
						}
						$('#jqxgrid').jqxGrid('clearselection');
					},"POST","text");
				}
		 });

		 $("#orderPass").bind("click", function(e){
			 	var paramData = new Array();
				var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindexes');
				if(rowindex == ""){
					alert("매칭할 대상을 선택해주세요.");
					return false;
				}
				for(key in rowindex){
					paramData.push({orderNo:$('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "orderNo")});
				}
				var postDataJson = JSON.stringify(paramData);
				if(confirm("해당 주문건을 수동으로 결제승인 하시겠습니까?")){
					fnAjax("orderPass.action",{data : postDataJson}, function(data, dataType){
						var data = data.replace(/\s/gi,'');
						if(data=="ok"){
							alert("정상적으로 수동결제승인이 완료되었습니다.");
							fnSearch();
						}else{
							alert("수동결제승인이 실패하였습니다.");
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
										$.fancybox.open({
											href: "/mng/amM3/amM3/orderDtl.action?orderNo="+orderNo,
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
							</select>
							<input type="text" name="conditionVal" style="width:180px;ime-mode:active;">
						</td>
						<th scope="row">결재방식</th>
						<td>
							<select name='orderCash' id='orderCash' style="width:134px;">
								 <option value="">전체</option>
							     <option value="Escrow">에스크로(가상계좌)</option>
							     <option value="Vbank">무통장입금(가상계좌)</option>
							     <option value="Online">무통장입금(일반)</option>
							</select>
						</td>
					</tr>

					<tr>
						<th scope="row">일자검색</th>
						<td>
							<div style='float:left;margin-right:5px;'>
							<select name="orderDtStyle" style="width:100px;">
								<option value="orderDt">주문일자</option>
								<option value="orderSendDt">배송일자</option>
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
			<a class="btn_type2 btn_icon5"  id="btnExcel" href="#" onclick="grideExportExcel('jqxgrid','입금대기목록');">엑셀다운로드</a>
			<a id="orderCancel" class="btn_type2" style="margin-left: 0px;"  href="javascript:;">무통장주문취소</a>
			<a id="orderPass" class="btn_type2"  style="margin-left: 0px;" href="javascript:;">수동결제승인</a>
			</div>
			<div class="right" style="line-height:40px;">
			<a id="orderDel" class="btn_type2"  href="javascript:;">삭제</a>
			<a id="orderMatching" style="margin-left: 0px;"  class="btn_type2"  href="javascript:;">입금자 수동 매칭</a>
			</div>
		</div>
	<!-- // top_box -->

	<!-- // align_area -->
		<div class="grid_type1">
			<div id="jqxgrid" style="float:left;" ></div>
			<div id="jqxgrid2" style="float:right;" ></div>
		</div>

</body>