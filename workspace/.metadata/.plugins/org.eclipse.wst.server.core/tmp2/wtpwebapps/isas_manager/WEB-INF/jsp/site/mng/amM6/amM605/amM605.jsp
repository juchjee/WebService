<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 게시판관리 : CS상담관리 -->

<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM605";
	function init(){
		$("#copnCd").pqSelect({
		    multiplePlaceholder: '쿠폰 선택',
		    maxDisplay: 2,
		    checkbox: true //adds checkbox to options
		}).on("change", function(evt) {
		    var val = $(this).val();
		}).pqSelect();

		$("#copnTpPdmc").pqSelect({
		    multiplePlaceholder: '쿠폰 그룹 선택',
		    maxDisplay: 2,
		    checkbox: true //adds checkbox to options
		}).on("change", function(evt) {
		    var val = $(this).val();
		}).pqSelect();

		fnEvent();
		fnDataSetting();
		fnSearchInit();
		fnSearch();
	}

	var _columns1 = [
	         		{ text: '쿠폰명', datafield: 'lCopnNm',  width: '50%', cellsalign: 'left', align: 'center'},
	         		{ text: '건수(건)', datafield: 'lCnt',  width: '11%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
	         		{ text: '쿠폰 금액(won)', datafield: 'tCopnPrice',  width: '13%', cellsalign: 'right', align: 'center', cellsformat: 'c'},
	         		{ text: '건수', columngroup: 'rate', datafield: 'cntRate',  width: '13%', cellsalign: 'right', align: 'center', cellsformat: 'p'},
	         		{ text: '금액', columngroup: 'rate', datafield: 'priceRate',  width: '13%', cellsalign: 'right', align: 'center', cellsformat: 'p'}
	         	];

	var _datafields1 = [
	         		{ name: 'lCopnNm', type: 'string'}
	         		,{ name: 'lCnt', type: 'number'}
	         		,{ name: 'tCopnPrice', type: 'number'}
	         		,{ name: 'cntRate', type: 'number'}
	         		,{ name: 'priceRate', type: 'number'}
	         	];

	var _columns2 = [
		         		{ text: '아이디', datafield: 'mbrId',  width: '10%', cellsalign: 'center', align: 'center'},
		         		{ text: '성명', datafield: 'depositNm',  width: '10%', cellsalign: 'center', align: 'center'},
		         		{ text: '주문번호', datafield: 'orderNo',  width: '15%', cellsalign: 'center', align: 'center'},
		         		{ text: '주문금액', datafield: 'orderAmt',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'c'},
		         		{ text: '결제금액', datafield: 'depositAmount',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'c'},
		         		{ text: '쿠폰명', datafield: 'copnNm',  width: '35%', cellsalign: 'left', align: 'center'},
		         		{ text: '쿠폰 금액', datafield: 'copnPrice',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'c'}
		         	];

	var _datafields2 = [
			         		{ name: 'mbrId', type: 'string'}
			         		,{ name: 'depositNm', type: 'string'}
			         		,{ name: 'orderNo', type: 'string'}
			         		,{ name: 'orderAmt', type: 'string'}
			         		,{ name: 'depositAmount', type: 'string'}
			         		,{ name: 'copnNm', type: 'string'}
			         		,{ name: 'copnPrice', type: 'number'}
			         	];

  	function fnSearchInit(){
		fnGridOption('jqxgrid1',{
			width: '99.9%'
			, sortable: false
			, pageable: true
			, autoheight: true
			, columns: _columns1
			, showaggregates: true
			, columngroups:
               [
                 { text: '비율(%)', align: 'center', name: 'rate' }
               ]
	    });
		fnGridOption('jqxgrid2',{
			width: '99.9%'
			, sortable: false
			, pageable: true
			, autoheight: true
			, columns: _columns2
			, showaggregates: true
	    });
	}

 	function fnSearch(){
  		if(!fnValidation()){
  			return;
  		}
  		var params = $("#searchForm").serialize();

		var postDataJson = JSON.stringify(params);

		var dataAdapter1 = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields1,
	        url: "amM605CopnRate.action?"+params
		});
		$("#jqxgrid1").jqxGrid({
			source: dataAdapter1,
			columngroups:
	               [
	                 { text: '비율(%)', align: 'center', name: 'rate' }
	               ]
		});
		fnResetGridEditData('jqxgrid1');

		var dataAdapter2 = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields2,
	        url: "amM605CopnList.action?"+params
		});
		$("#jqxgrid2").jqxGrid({
			source: dataAdapter2
		});
		fnResetGridEditData('jqxgrid2');

		fnAjax("amM605Sum.action", params, function(data, dataType){
			if(data){
 				$('#totalOrderCopnCount').text(formatNumber3(data[0].tCnt));
				$('#totalOrderAmt').text(formatNumber3(data[0].tAmt));
				$('#totalOrderCopnAmt').text(formatNumber3(data[0].tCopnPrice));
				$('#totalOrderPercent').text(data[0].tRate);
			}
		});

	}

  	function fnEvent(){
  		$("#jqxgrid1").on("bindingcomplete", function (event) {
  	  		var datainfo = $("#jqxgrid1").jqxGrid('getdatainformation');
  	  		var params = $("#searchForm").serialize();
  		});

  		$("#jqxgrid2").on("bindingcomplete", function (event) {
  	  		var datainfo = $("#jqxgrid2").jqxGrid('getdatainformation');
  	  		var params = $("#searchForm").serialize();
  		});

  		$("#btnSearch").on('click', fnSearch);

		$("#btnReset").on('click',function(){
			$("#txtFromDt1").val("${iConstant.prev1DayYmd(-6)}");
			$("#txtToDt1").val("${nowYmd}");
			$("#jqxgrid1").jqxGrid('clear');
			$("#jqxgrid2").jqxGrid('clear');
		});

		$("#btnExcel1").on('click', function(){
			grideExportExcel('jqxgrid1','쿠폰사용비율');
		});
		$("#btnExcel2").on('click', function(){
			grideExportExcel('jqxgrid2','쿠폰사용내역');
		});
	}
  	function fnDataSetting(){
		$("#compareDate").prop('checked', true);
  		dateTimeInput("txtFromDt1", null, "${iConstant.prev1DayYmd(-6)}");
		dateTimeInput("txtToDt1", null, "${nowYmd}");
  	}

  	function fnValidation(){
  		if($('#txtFromDt1').val() == ''){
  			alert('기간 시작일자를 입력하세요');
  			$('#txtFromDt1').focus();
  			return false;
  		}else if($('#txtToDt1').val() == ''){
  			alert('기간 종료일자를 입력하세요');
  			$('#txtToDt1').focus();
  			return false;
  		}else{
  			return true;
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
						<col style="width:100px;" />
						<col style="width:*;" />
						<col style="width:150px;" />
						<col style="width:*;" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">기간</th>
							<td>
								<div style='float:left;'>
									<div id='txtFromDt1' style='float:left;'></div>
										<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
									<div id='txtToDt1'  style='float:left;'></div>
								</div>
							</td>
							<th scope="row">쿠폰 선택</th>
							<td>
								<select id="copnTpPdmc" name="copnTpPdmc" multiple=multiple style="width: 174px;">
									<option value="P">상품쿠폰</option>
									<option value="D">다운로드쿠폰</option>
									<option value="M">회원쿠폰</option>
								</select>
								<select id="copnCd" name="copnCd" multiple=multiple style="width:400px;">
									<c:forEach items="${copnList}" var="copnList">
										<option value="${copnList.prodCd}">${copnList.copnNm}</option>
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
	</div>
	<!-- // btn_area -->

	<h3>
		<div class="btn_area" style="top: 0px;">
			<div class="left">
				쿠폰 사용 비율
			</div>
			<div class="right">
				<a id="btnExcel1" class="btn_type2 btn_icon5" href="javascript:;">엑셀다운로드</a>
			</div>
		</div>
	</h3>
	<!-- // table_type1 -->
	<div class="grid_type1" >
		<div id="jqxgrid1" ></div>
	</div>

	<div class="table_type2" style="margin-top:20px; margin-bottom:30px; width: 1300px;">
		<table>
			<caption>쿠폰사용통계에 대한 테이블입니다.</caption>
			<colgroup>
				<col style="width:150px;" />
				<col style="width:150px;" />
				<col style="width:150px;" />
				<col style="width:150px;" />
				<col style="width:150px;" />
				<col style="width:150px;" />
				<col style="width:150px;" />
				<col style="width:150px;" />
			</colgroup>
			<tbody>
				<tr>
					<th  scope="row" class="alignC">쿠폰 사용 주문 건수</th>
					<td>
						<span id="totalOrderCopnCount">0</span>건
					</td>
					<th scope="row" class="alignC">쿠폰 사용 결제 금액</th>
					<td>
						<span id="totalOrderAmt">0</span>원
					</td>
					<th scope="row" class="alignC">쿠폰 비용</th>
					<td>
						<span id="totalOrderCopnAmt">0</span>원
					</td>
					<th scope="row" class="alignC">해당기간 매출 대비</th>
					<td>
						<span id="totalOrderPercent">0</span>%
					</td>
				</tr>
			</tbody>
		</table>
	</div>

	<h3>
		<div class="btn_area" style="top: 0px;">
			<div class="left">
				쿠폰 사용 내역
			</div>
			<div class="right">
				<a id="btnExcel2" class="btn_type2 btn_icon5" href="javascript:;">엑셀다운로드</a>
			</div>
		</div>

	</h3>
	<!-- // table_type2 -->
	<div class="grid_type2" >
		<div id="jqxgrid2" ></div>
	</div>
</div>
				<!-- // align_area -->
</body>