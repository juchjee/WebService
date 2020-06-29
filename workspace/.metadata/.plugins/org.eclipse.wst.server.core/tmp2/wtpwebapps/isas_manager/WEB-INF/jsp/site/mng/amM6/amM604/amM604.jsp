<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 통계 : 회원 주문 통계 -->

<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM604";
	function init(){
		fnEvent();
		fnDataSetting();
		fnSearchInit();
		fnSearch();
	}
	var _columns1 = [
					{ text: '순위', datafield: 'num',  width: '5%', cellsalign: 'center', align: 'center'},
	         		{ text: '상품코드', datafield: 'prodCd',  width: '7%', cellsalign: 'center', align: 'center'},
	         		{ text: '상품명', datafield: 'prodNm',  width: '20%', cellsalign: 'center', align: 'center'},
	         		{ text: '판매 수량(ea)', columngroup: 'period', datafield: 'prodQtySum',  width: '7%', cellsalign: 'right', align: 'center'},
	         		{ text: '구성비(%)', columngroup: 'period', datafield: 'orderQtyPercent',  width: '7%', cellsalign: 'right', align: 'center', cellsformat: 'p'},
	         		{ text: '비교기간대비증감(%)', columngroup: 'period', datafield: 'orderQtyCompare',  width: '9%', cellsalign: 'right', align: 'center', cellsformat: 'p'},
	         		{ text: '판매 금액(won)', columngroup: 'period', datafield: 'prodPriceSum',  width: '11%', cellsalign: 'right', align: 'center', cellsformat: 'c'},
	         		{ text: '구성비(%)', columngroup: 'period', datafield: 'orderSumPercent',  width: '7%', cellsalign: 'right', align: 'center', cellsformat: 'p'},
	         		{ text: '비교기간대비증감(%)', columngroup: 'period', datafield: 'orderSumCompare',  width: '9%', cellsalign: 'right', align: 'center', cellsformat: 'p'},
	         		{ text: '판매 수량(ea)', columngroup: 'comparePeriod', datafield: 'prodQtySumAfter',  width: '7%', cellsalign: 'right', align: 'center'},
	         		{ text: '판매 금액(won)', columngroup: 'comparePeriod', datafield: 'prodPriceSumAfter',  width: '11%', cellsalign: 'right', align: 'center', cellsformat: 'c'}
	         	];

	var _datafields1 = [
	         		{ name: 'num', type: 'string'}
	         		,{ name: 'prodCd', type: 'string'}
	         		,{ name: 'prodNm', type: 'string'}
	         		,{ name: 'prodQtySum', type: 'number'}
	         		,{ name: 'orderQtyPercent', type: 'number'}
	         		,{ name: 'orderQtyCompare', type: 'number'}
	         		,{ name: 'prodPriceSum', type: 'number'}
	         		,{ name: 'orderSumPercent', type: 'number'}
	         		,{ name: 'orderSumCompare', type: 'number'}
	         		,{ name: 'prodQtySumAfter', type: 'number'}
	         		,{ name: 'prodPriceSumAfter', type: 'number'}
	         	];

  	function fnSearchInit(){
		fnGridOption('jqxgrid1',{
			width: '99.9%'
			, sortable: false
			, pageable: false
			, autoheight: true
			, columns: _columns1
			, showaggregates: true
			, columngroups:
               [
                 { text: '기간', align: 'center', name: 'period' },
                 { text: '비교 기간', align: 'center', name: 'comparePeriod' }
               ]
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
	        url: "amM604.action?"+params
		});
		$("#jqxgrid1").jqxGrid({
			source: dataAdapter1,
            columngroups:
            [
              { text: '기간', align: 'center', name: 'period' },
              { text: '비교 기간', align: 'center', name: 'comparePeriod' }
            ]
		});
		fnResetGridEditData('jqxgrid1');

		fnAjax("amM604Sum.action", params, function(data, dataType){
			if(data){
				$('#totalOrderAmt').text(formatNumber3(data[0].tPrice));
				$('#totalOrderCount').text(formatNumber3(data[0].tQty));
			}
		});
	}

  	function fnEvent(){
  		$("#jqxgrid1").on("bindingcomplete", function (event) {
  	  		var datainfo = $("#jqxgrid1").jqxGrid('getdatainformation');
  	  		var params = $("#searchForm").serialize();
  		});

  		$("#btn_Search").on('click', fnSearch);

		$("#btn_reset").on('click',function(){
			$("#compareArea").show();
			$("#txtFromDt1").val("${iConstant.prev1DayYmd(-6)}");
			$("#txtToDt1").val("${nowYmd}");
			$("#jqxgrid1").jqxGrid('clear');
			$("#compareDate").prop('checked', true);
			$("#txtFromDt2").val("${iConstant.prev1DayYmd(-13)}");
			$("#txtToDt2").val("${iConstant.prev1DayYmd(-7)}");
		});

		$("#compareDate").on('click',function(){
			if(!$("#compareDate").is(':checked')){
				$("#txtFromDt2").val('');
				$("#txtToDt2").val('');
				$("#compareArea").hide();
			}else{
				$("#compareArea").show();
			}
		});

		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid1','품목별판매통계()');
		});
 	}
  	function fnDataSetting(){
		$("#compareDate").prop('checked', true);
  		dateTimeInput("txtFromDt1", null, "${iConstant.prev1DayYmd(-6)}");
		dateTimeInput("txtToDt1", null, "${nowYmd}");
  		dateTimeInput("txtFromDt2", null, "${iConstant.prev1DayYmd(-13)}");
		dateTimeInput("txtToDt2", null, "${iConstant.prev1DayYmd(-7)}");
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
  		}else if($("#compareDate").is(':checked')){
  	  		if($('#txtFromDt2').val() == ''){
  	  			alert('비교기간 시작일자를 입력하세요');
  	  			$('#txtFromDt2').focus();
  	  			return false;
  	  		}else if($('#txtToDt2').val() == ''){
  	  			alert('비교기간 종료일자를 입력하세요');
  	  			$('#txtFromDt2').focus();
  	  			return false;
  	  		}else{
  	  			return true;
  	  		}
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
					<col style="width:10%" />
					<col style="width:40%;" />
					<col style="width:10%;" />
					<col style="width:40%;" />
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
						<th scope="row">
							<input type="checkbox" name="compareDate" id="compareDate"/>
							비교기간
						</th>
						<td>
							<div style='float:left;' id='compareArea'>
								<div id='txtFromDt2' style='float:left;'></div>
								<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
								<div id='txtToDt2'  style='float:left;'></div>
							</div>
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
			<a id="btn_reset" class="btn_blue_line2" href="javascript:" >초기화</a>
		</div>
		<div class="right" style="line-height:40px;">
			<a id="btnExcel" class="btn_type2 btn_icon5" href="javascript:;">엑셀다운로드</a>
		</div>
	</div>
	<!-- // btn_area -->
	</form>

	<div class="table_type2" style="margin-bottom:10px; width: 500px;">
		<table>
			<caption>품목별판매통계(기간)에 대한 테이블입니다.</caption>
			<colgroup>
				<col style="width:100px;" />
				<col style="width:150px;" />
				<col style="width:100px;" />
				<col style="width:150px;" />
			</colgroup>
			<tbody>
				<tr>
					<th  scope="row" class="alignC">총 판매수량</th>
					<td>
						<span id="totalOrderCount">0</span>개
					</td>
					<th scope="row" class="alignC">총 판매금액</th>
					<td>
						<span id="totalOrderAmt">0</span>원
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- // table_type1 -->
	<div class="grid_type1" >
		<div id="jqxgrid1" ></div>
	</div>
</div>
<!-- // align_area -->
</body>