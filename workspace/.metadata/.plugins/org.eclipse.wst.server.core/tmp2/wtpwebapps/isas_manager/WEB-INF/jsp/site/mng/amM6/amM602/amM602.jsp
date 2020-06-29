<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 통계 : 회원 주문 통계 -->

<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM602";
	function init(){
		fnEvent();
		fnDataSetting();
		fnSearchInit();
		fnSearch();
	}

	var _columns1 = [
	         		{ text: '구분', datafield: 'kind',  width: '10%', cellsalign: 'center', align: 'center', cellsformat: 'c2'},
	         		{ text: '건수', columngroup: 'period', datafield: 'oCount',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
	         		{ text: '금액(won)', columngroup: 'period', datafield: 'oAmount',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
	         		{ text: '주문건수비율(%)', columngroup: 'period', datafield: 'oRate',  width: '15%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
	         		{ text: '건수', columngroup: 'comparePeriod', datafield: 'cCount',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
	         		{ text: '금액(won)', columngroup: 'comparePeriod', datafield: 'cAmount',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
	         		{ text: '주문건수비율(%)', columngroup: 'comparePeriod', datafield: 'cRate',  width: '15%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
	         		{ text: '비교기간 대비 주문 건수 증감(%)', datafield: 'udRate',  width: '20%', cellsalign: 'right', align: 'center', cellsformat: 'f'}
	         	];

	var _datafields1 = [
	         		{ name: 'kind', type: 'string'}
	         		,{ name: 'oCount', type: 'number'}
	         		,{ name: 'oAmount', type: 'number'}
	         		,{ name: 'oRate', type: 'number'}
	         		,{ name: 'cCount', type: 'number'}
	         		,{ name: 'cAmount', type: 'number'}
	         		,{ name: 'cRate', type: 'number'}
	         		,{ name: 'udRate', type: 'number'}
	         	];


	var _columns2 = [
		         		{ text: '구분', datafield: 'kind',  width: '10%', cellsalign: 'center', align: 'center', cellsformat: 'c2'},
		         		{ text: '건수', columngroup: 'period', datafield: 'oCount',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
		         		{ text: '금액(won)', columngroup: 'period', datafield: 'oAmount',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
		         		{ text: '주문건수비율(%)', columngroup: 'period', datafield: 'oRate',  width: '15%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
		         		{ text: '건수', columngroup: 'comparePeriod', datafield: 'cCount',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
		         		{ text: '금액(won)', columngroup: 'comparePeriod', datafield: 'cAmount',  width: '10%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
		         		{ text: '주문건수비율(%)', columngroup: 'comparePeriod', datafield: 'cRate',  width: '15%', cellsalign: 'right', align: 'center', cellsformat: 'f'},
		         		{ text: '비교기간 대비 주문 건수 증감(%)', datafield: 'udRate',  width: '20%', cellsalign: 'right', align: 'center', cellsformat: 'f'}
		         	];

	var _datafields2 = [
	         		{ name: 'kind', type: 'string'}
	         		,{ name: 'oCount', type: 'number'}
	         		,{ name: 'oAmount', type: 'number'}
	         		,{ name: 'oRate', type: 'number'}
	         		,{ name: 'cCount', type: 'number'}
	         		,{ name: 'cAmount', type: 'number'}
	         		,{ name: 'cRate', type: 'number'}
	         		,{ name: 'udRate', type: 'number'}
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
		fnGridOption('jqxgrid2',{
			width: '99.9%'
			, sortable: false
			, pageable: false
			, autoheight: true
			, columns: _columns2
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
	        url: "amM602.action?"+params
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

		var dataAdapter2 = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields2,
	        url: "amM602New.action?"+params
		});
		$("#jqxgrid2").jqxGrid({
			source: dataAdapter2,
            columngroups:
            [
              { text: '기간', align: 'center', name: 'period' },
              { text: '비교 기간', align: 'center', name: 'comparePeriod' }
            ]

		});
		fnResetGridEditData('jqxgrid2');
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

  		$("#btn_Search").on('click', fnSearch);

		$("#btn_reset").on('click',function(){
			$("#compareArea").show();
			$("#txtFromDt1").val("${iConstant.prev1DayYmd(-6)}");
			$("#txtToDt1").val("${nowYmd}");
			$("#jqxgrid1").jqxGrid('clear');
			$("#jqxgrid2").jqxGrid('clear');
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

		$("#btnExcel1").on('click', function(){
			grideExportExcel('jqxgrid1','회원_비회원_통계');
		});

		$("#btnExcel2").on('click', function(){
			grideExportExcel('jqxgrid2','재구매_신규구매_통계');
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
				</div>
				<!-- // btn_area -->
				</form>

				<h3>
					<div class="btn_area" style="top: 0px;">
						<div class="left">
							회원 / 비회원
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

				<h3 style="margin-top:20px;">
					<div class="btn_area" style="top: 0px;">
						<div class="left">
							재 구매 / 신규 구매
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