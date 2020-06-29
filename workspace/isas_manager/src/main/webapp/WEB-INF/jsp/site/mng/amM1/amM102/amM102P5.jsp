<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

	<script type="text/javascript">
	var contUrl = "${rootUri}${conUrl}amM1025";
	function init(){
		var obj = $(".gnb > ul >li > a")[4];
		$(obj).addClass("on");

		fnSearchInit();
		fnSearch();
		fnSearchInit2();
		fnSearch2();
	}

	var _columns = [
		 { text: '번호', datafield: 'rowNum', width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '쿠폰발행코드', datafield: 'copnIsuCd', width: '15%', cellsalign: 'left', align: 'center'}
		,{ text: '쿠폰명', datafield: 'copnNm', width: '30%', cellsalign: 'left', align: 'center'}
		,{ text: '발행일', datafield: 'copnIsuDt', width: '10%', cellsalign: 'center', align: 'center'}
   		,{ text: '만료일', datafield: 'copnDt', width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '사용일', datafield: 'orderDt', width: '15%', cellsalign: 'center', align: 'center'}
		,{ text: '주문번호', datafield: 'orderNo', width: '15%', cellsalign: 'center', align: 'center'}
	];

	var _columns2 = [
	       		 { text: '번호', datafield: 'rowNum', width: '5%', cellsalign: 'center', align: 'center'}
	       		,{ text: '쿠폰발행코드', datafield: 'copnIsuCd', width: '15%', cellsalign: 'left', align: 'center'}
	       		,{ text: '쿠폰명', datafield: 'copnNm', width: '45%', cellsalign: 'left', align: 'center'}
	       		,{ text: '발행일', datafield: 'copnIsuDt', width: '15%', cellsalign: 'center', align: 'center'}
	       		,{ text: '만료일', datafield: 'copnDt', width: '20%', cellsalign: 'center', align: 'center'}
	       	];

	var _datafields = [
   		 { name: 'rowNum', type: 'string'}
   		,{ name: 'copnIsuCd', type: 'string'}
   		,{ name: 'copnNm', type: 'string'}
   		,{ name: 'copnIsuDt', type: 'string'}
   		,{ name: 'copnDt', type: 'string'}
   		,{ name: 'orderDt', type: 'string'}
   		,{ name: 'orderNo', type: 'string'}
   	];

	var _datafields2 = [
   		 { name: 'rowNum', type: 'string'}
   		,{ name: 'copnIsuCd', type: 'string'}
   		,{ name: 'copnNm', type: 'string'}
   		,{ name: 'copnIsuDt', type: 'string'}
   		,{ name: 'copnDt', type: 'string'}
   	];

	function fnSearchInit(){
		fnGridOption('jqxgrid',{
			height: 645
	       	,columns: _columns
	       	,selectionmode: 'singlerow'
	    });
	}

	function fnSearchInit2(){
		fnGridOption('jqxgrid2',{
			height: 645
	       	,columns: _columns2
	       	,selectionmode: 'singlerow'
	    });
	}

	function fnSearch(){
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + "usedCpn.action",
	        data: {mbrId : '${mbrId}'}
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

	function fnSearch2(){
		var dataAdapter2 = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields2,
	        url: contUrl + "unUsedCpn.action",
	        data: {mbrId : '${mbrId}'}
		});
		$("#jqxgrid2").jqxGrid({source: dataAdapter2});
		fnResetGridEditData('jqxgrid2');
		return false;
	}
	</script>

	<div class="member_detail_con">
		<h2>쿠폰내역</h2>
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
						<dt>쿠폰할인 총금액</dt>
						<dd><span>${totCopnDisAmt}</span></dd>
					</dl>
				</li>
			</ul>
		</div>
		<!-- // -->
		<div class="table_type1" style="margin-top: 30px;">
		<h3>미사용 쿠폰 내역</h3>
			<div class="grid_type1">
				<div id="jqxgrid2"></div>
			</div>
		</div>
		<div class="table_type1" style="margin-top: 30px;">
		<h3>사용 쿠폰 내역</h3>
			<div class="grid_type1" style="margin-bottom: 20px;">
				<div id="jqxgrid"></div>
			</div>
		</div>
		<!-- // table_type1 -->

	</div>
	<!-- // member_detail_con -->
