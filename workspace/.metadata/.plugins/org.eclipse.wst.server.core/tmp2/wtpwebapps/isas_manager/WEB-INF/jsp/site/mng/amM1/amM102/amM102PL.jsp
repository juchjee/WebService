<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<c:import url="/WEB-INF/jsp/general/head.jsp" />
<c:import url="/WEB-INF/jsp/general/lib_jqx_core.jsp" />
<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />

<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM102PL";

	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
	};


	var _columns = [
		{ text: '아이디', datafield: 'mbrId', cellclassname: cellclass, width: '20%', cellsalign: 'center', align: 'center'}
		,{ text: '이름', datafield: 'mbrNm', cellclassname: cellclass, width: '20%', cellsalign: 'center', align: 'center'}
		,{ text: '주소', datafield: 'mbrAddr', cellclassname: cellclass, width: '20%', cellsalign: 'center', align: 'center'}
		,{ text: '전화번호', datafield: 'mbrPhone', cellclassname: cellclass, width: '20%', cellsalign: 'center', align: 'center'}
		,{ text: '휴대폰번호', datafield: 'mbrMobile', cellclassname: cellclass, width: '20%', cellsalign: 'center', align: 'center'}
	];

	var _datafields = [
   		{ name: 'mbrId', type: 'string'}
   		,{ name: 'mbrNm', type: 'string'}
   		,{ name: 'mbrAddr', type: 'string'}
   		,{ name: 'mbrPhone', type: 'string'}
   		,{ name: 'mbrMobile', type: 'string'}
   	];

	function fnSearchInit(){
		fnGridOption('jqxgrid',{
			height:160
	       ,columns: _columns
	       ,selectionmode: 'singlerow'
	    });
	}

	function fnSearch(){
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + "A.action",
	        data: {mbrSearch : '${mbrSearch}'}
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

	function fnEvent(){
		$("#jqxgrid").on('rowdoubleclick', function (event)
		{
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			var datarow = $('#jqxgrid').jqxGrid('getrowdata', rowindex);
			parent.$.fancybox.close();
			parent.location = "/mng/amM1/amM102/amM1021F.pop?mbrId="+datarow.mbrId;
		});
	}

</script>
</head>
<body class="noBg" style="height:480px">
	<div class="popup_wrap">
		<div class="top_box">
			<div class="text_type">
			<p>해당 정보를 더블클릭하면 회원정보로 이동합니다.</p>
			</div>
		</div>
		<br/>
		<div class="grid_type1">
			<div id="jqxgrid"></div>
		</div>

	</div>
</body>
</html>