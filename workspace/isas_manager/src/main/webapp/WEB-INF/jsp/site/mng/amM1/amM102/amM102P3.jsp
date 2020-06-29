<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

	var contUrl = "${rootUri}${conUrl}amM1023";

	function init(){
		var obj = $(".gnb > ul >li > a")[2];
		$(obj).addClass("on");

		fnSearchInit();
		fnSearch();
		fnEvent();
	};
//
	var _columns = [
		{ text: '주문번호', datafield: 'orderNo',  width: '8%', cellsalign: 'left', align: 'center'}
		,{ text: '제품명', datafield: 'prodNm',  width: '26%', cellsalign: 'left', align: 'center'}
		,{ text: '주문자', datafield: 'mbrNm',  width: '8%', cellsalign: 'center', align: 'center'}
		,{ text: '수령자', datafield: 'receiptNm',  width: '8%', cellsalign: 'center', align: 'center'}
		,{ text: '결제금액', datafield: 'depositAmount',  width: '10%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
		,{ text: '결제방식', datafield: 'orderCashNm',  width: '12%', cellsalign: 'center', align: 'center'}
		,{ text: '주문상태', datafield: 'orderStatusNm',  width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '클레임상태', datafield: 'claimTpNm',  width: '8%', cellsalign: 'center', align: 'center'}
		,{ text: '주문일', datafield: 'orderDt',  width: '10%', cellsalign: 'center', align: 'center'}
	];

	var _datafields = [
   		{ name: 'orderNo', type: 'string'}
   		,{ name: 'prodNm', type: 'string'}
   		,{ name: 'mbrNm', type: 'string'}
   		,{ name: 'receiptNm', type: 'string'}
   		,{ name: 'depositAmount', type: 'number'}
   		,{ name: 'orderCashNm', type: 'string'}
   		,{ name: 'orderStatusNm', type: 'string'}
   		,{ name: 'claimTpNm', type: 'string'}
   		,{ name: 'orderDt', type: 'string'}
   	];

	function fnSearchInit(){
		fnGridOption('jqxgrid',{
			height:285
	       ,columns: _columns
	       ,selectionmode: 'singlerow'
	    });
	}

	function fnSearch(){
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + ".action",
	        data: {mbrId : '${mbrId}', mbrNm : '${mbrNm}'}
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

	function fnEvent(){
		$("#jqxgrid").on("celldoubleclick", function (event){
			var args = event.args;
			var rowBoundIndex = args.rowindex;
			var orderNo = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "orderNo");
			setTimeout(function(){
				$.fancybox.open({
					href: "orderDtl.action?orderNo="+orderNo,
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
	}
</script>

	<div class="member_detail_con">
		<h2>상품구매내역</h2>
		<div class="member_detail_info">
			<ul>
				<li>
					<dl>
						<dt>회원이름</dt>
						<dd><span>${mbrNm} (${mbrId})</span></dd>
					</dl>
				</li>
				<li>
					<dl>
						<dt>결제금액</dt>
						<dd><span>${amM203Sum.depositAmount}</span> (배송완료기준) </dd>
					</dl>
				</li>
			</ul>
		</div>
		<!-- // -->
		<div class="align_area">
			<div class="left">
				<span>아래 주문번호를 클릭하면 주문상세내역을 볼 수 있습니다.</span>
			</div>
		</div>
		<!-- // align_area -->

		<div class="grid_type1">
			<div id="jqxgrid"></div>
		</div>

	</div>


