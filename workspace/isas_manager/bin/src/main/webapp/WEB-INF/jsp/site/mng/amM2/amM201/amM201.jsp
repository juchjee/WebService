<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
<style>
div.jqx-item{cursor:pointer;}
</style>
<script type="text/javaScript" defer="defer">
<!--
	var contUrl = "${rootUri}${conUrl}amM201";
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();

		//화면 기본 데이터 셋팅
		fnDataSetting();
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅 - 선택, 제품명, 판매가, 할인가, 쿠폰, 적립금, 재고, 판매상태, PC노출, 모바일노출, 과세, 등록일, 관리
	 *----------------------------------------------------------------------------------------------*/
	var _columns = [

	     { text: '번호', datafield: 'no', columntype: 'number', width: '3%', cellsalign: 'right', align: 'center'
	    	,cellsrenderer: function (row, column, value) {
	            return "<div style='margin:13px 5px 0px 0;text-align:right;'>" + (value + 1) + "</div>";
	        }
	     }
		,{ text: '분류', datafield: 'prodCateCnt', width: '4%', cellsalign: 'right', align: 'center'}
		,{ text: '상품명', datafield: 'prodNm', width: '17%', cellsalign: 'left', align: 'center'}
		,{ text: '제품구성', datafield: 'prodTypeGspNm', width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '판매가', datafield: 'prodPrice', width: '6%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
		,{ text: '할인가', datafield: 'prodSalePrice', width: '6%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
		,{ text: '쿠폰', datafield: 'copnProdCnt', width: '4%', cellsalign: 'right', align: 'center' }
		,{ text: '적립금', datafield: 'prodResvFund', width: '6%', cellsalign: 'right', align: 'center' , cellsformat: 'c'}
		,{ text: '포인트', datafield: 'prodPtInScoreNm', width: '5%', cellsalign: 'right', align: 'center' }
		,{ text: '재고', datafield: 'orderQtyNm', width: '6%', cellsalign: 'right', align: 'center' }
		,{ text: '판매상태', datafield: 'prodStatusNm', width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '상품종류', datafield: 'prodTpNm', width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '판매기간', datafield: 'prodPmntDt', width: '16%', cellsalign: 'center', align: 'center'}
		,{ text: 'PC', datafield: 'prodDisPcYn', width: '4%', cellsalign: 'center', align: 'center'}
		,{ text: '모바일', datafield: 'prodDisMobileYn', width: '4%', cellsalign: 'center', align: 'center'}
		,{ text: '수정', datafield: 'popButton', width: '4%', cellsalign: 'center', align: 'center',
			columntype: 'button', cellsrenderer: function () {
                return "수정";
             }, buttonclick: function (row) {
                var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', row);

                if($(".depths_0").html().indexOf("${homeUrl}/mng/amM2/amM202/amM202.do") == -1){
						alert("수정/등록 관한이 없습니다.");
						return false;
               }else{
					$.fancybox.open({
						href: "${homeUrl}/mng/amM2/amM202/amM202U.action?prodCd="+ dataRecord.prodCd,
						type: "iframe",
			 			maxWidth	: 1300,
			 			maxHeight	: 900,
			 			width		: 1300,
			 			height		: 900,
			 			modal : false,
			 			autoSize	: false
					});
               }
            }
		}
		,{ text: '상품코드', datafield: 'prodCd', hidden: true}
		,{ text: '제품구성코드', datafield: 'prodTypeGsp', hidden: true}
	];

	var _datafields = [
	     { name: 'no', type: 'string'}
		,{ name: 'prodCateCnt', type: 'string'}
		,{ name: 'prodNm', type: 'string'}
		,{ name: 'prodTypeGspNm', type: 'string'}
		,{ name: 'prodPrice', type: 'number'}
		,{ name: 'prodSalePrice', type: 'number'}
		,{ name: 'copnProdCnt', type: 'string'}
		,{ name: 'prodResvFund', type: 'number'}
		,{ name: 'prodPtInScoreNm', type: 'string'}
		,{ name: 'orderQtyNm', type: 'string'}
		,{ name: 'prodStatusNm', type: 'string'}
		,{ name: 'prodTpNm', type: 'string'}
		,{ name: 'prodPmntDt', type: 'string'}
		,{ name: 'prodDisPcYn', type: 'string'}
		,{ name: 'prodDisMobileYn', type: 'string'}
		,{ name: 'prodCd', type: 'string'}
		,{ name: 'prodTypeGsp', type: 'string'}
	];

	function fnSearchInit(){
		dateTimeInput("txtFromDt");
		dateTimeInput("txtToDt");
		fnGridOption('jqxgrid',{
// 	        ,selectionmode: multiplerowsextended'
	         height: 441
	        //,statusbarheight: 25
	        //,showstatusbar: true
	        //,showaggregates: true
           , altrows: true
	        ,columns: _columns
	    });
		$("#prodStatusCd").val("PPS00001").attr("selected", "selected");
	}
	/*----------------------------------------------------------------------------------------------
	 * grid search
	 *----------------------------------------------------------------------------------------------*/
	function fnSearch(){
		var params = $("#searchForm").serialize();
		var dataAdapter = new $.jqx.dataAdapter({
    		datatype: "json",
            datafields: _datafields,
            url: contUrl + ".action?"+params
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		return false;
	}

	function fnPPCAHandler(){
		var prodCategoryCd = $(this).val();
		if(prodCategoryCd){
			fnAjax(contUrl + "PPC.action", {"prodCategoryCd" : prodCategoryCd}, function(data, dataType){
				if(data){
					var strHtml = "<option value=''>중분류전체</option>";
					for (var i = 0; i < data.length; i++) {
						strHtml += "<option value='" + data[i].prodCategoryCd + "'>" + data[i].prodCategoryNm + "</option>";
					}
					$("#pProdCategoryB").html(strHtml);
					$("#pProdCategoryC").html("<option value=''>소분류전체</option>");
				}else{
					alert('<spring:message code="fail.request.msg"/>');
				}
			});
		}else{
			$("#pProdCategoryB").html("<option value=''>중분류전체</option>");
			$("#pProdCategoryC").html("<option value=''>소분류전체</option>");
		}
	}
	function fnPPCBHandler(){
		var prodCategoryCd = $(this).val();
		if(prodCategoryCd){
			fnAjax(contUrl + "PPC.action", {"prodCategoryCd" : prodCategoryCd}, function(data, dataType){
				if(data){
					var strHtml = "<option value=''>소분류</option>";
					for (var i = 0; i < data.length; i++) {
						strHtml += "<option value='" + data[i].prodCategoryCd + "'>" + data[i].prodCategoryNm + "</option>";
					}
					$("#pProdCategoryC").html(strHtml);
				}else{
					alert('<spring:message code="fail.request.msg"/>');
				}
			});
		}else{
			$("#pProdCategoryC").html("<option value=''>소분류</option>");
		}
	}
	/*----------------------------------------------------------------------------------------------
	 * 이벤트 Setting
	 *----------------------------------------------------------------------------------------------*/
	 function fnEvent(){
		$("#btn_Search").on('click', fnSearch);//검색
		$("#pProdCategoryA").on('change', fnPPCAHandler);
		$("#pProdCategoryB").on('change', fnPPCBHandler);


		$("#jqxgrid").on("celldoubleclick", function (event)
		{
				    var args = event.args;
				    var rowBoundIndex = args.rowindex;
				    if(args.datafield != 'popButton'){
						var prodCd = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "prodCd");
						setTimeout(function(){
							$("#fancyBtn").attr("href","amM201R.action?prodCd="+prodCd);
							$("#fancyBtn").click();

						},200);
				    }

		});

		$("a#copnProdCnt, a#orderQty").bind("click", function(e){
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			if(rowindex > -1){
				var prodCd = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "prodCd");
				var prodTypeGsp = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "prodTypeGsp");
				if($(this).attr("id") == "copnProdCnt"){
					var cnt = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "copnProdCnt");
					if(cnt == "0개"){
						alert("해당 상품은 쿠폰이 없습니다.");
						return false;
					}else{
						$("#copnProdCnt").attr("href","amM201Copn.action?prodCd="+prodCd);
					}
				}else if($(this).attr("id") == "orderQty"){
					if(prodTypeGsp == "S"){
						$("#orderQty").attr("href","amM201SetQty.action?prodCd="+prodCd);
					}else{
						$("#orderQty").attr("href","amM201Qty.action?prodCd="+prodCd);
					}

				}else{
					return false;
				}
			}else{
				alert("선택된 상품이 없습니다");
				return false;
			}
		});


		$("a#soldOut, a#salesEnd").bind("click", function(e){
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			if(rowindex > -1){
				var prodCd = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "prodCd");
				if($(this).attr("id") == "soldOut"){
					if(confirm("해당 상품을 품절처리 하시겠습니까?")){
						fnAjax("amM201SoldOut.action", {"prodCd" : prodCd}, function(data, dataType){
							if(data){
								var data = data.replace(/\s/gi,'');
								alert(data);
						    	fnSearch();
							}else{
								alert('<spring:message code="fail.request.msg"/>');
							}
						},"POST","text");
					}

				}else if($(this).attr("id") == "salesEnd"){
					if(confirm("해당 상품을 판매종료 하시겠습니까?")){
						fnAjax("amM201SalesEnd.action", {"prodCd" : prodCd}, function(data, dataType){
							if(data){
								var data = data.replace(/\s/gi,'');
								alert(data);
						    	fnSearch();
							}else{
								alert('<spring:message code="fail.request.msg"/>');
							}
						},"POST","text");
					}
				}else{
					return false;
				}
			}else{
				alert("선택된 상품이 없습니다");
				return false;
			}
		});

		$("a#categoryCnt").bind("click", function(e){
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			if(rowindex > -1){
				var prodCd = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "prodCd");
				$("#categoryCnt").attr("href","amM201CateCnt.action?prodCd="+prodCd);
			}else{
				alert("선택된 상품이 없습니다");
				return false;
			}
		});

		$("#orderQty").fancybox({
			maxWidth	: 400,
			maxHeight	: 800,
			width		: 400,
			height		: 482,
			modal : false,
			autoSize	: true,
		    transitionIn      : 'none',
		    transitionOut     : 'none',
		    type              : 'iframe',
			beforeClose : function(){
		    	fnSearch();
			}
		});

		$("#anotherQty").fancybox({
			maxWidth	: 400,
			maxHeight	: 800,
			width		: 400,
			height		: 482,
			modal : false,
			autoSize	: true,
		    transitionIn      : 'none',
		    transitionOut     : 'none',
		    type              : 'iframe',
			beforeClose : function(){
		    	fnSearch();
			}
		});

		$("#fancyBtn").fancybox({
			type: "iframe",
 			maxWidth	: 1300,
 			maxHeight	: 900,
 			width		: 1300,
 			height		: 900,
 			autoSize	: false,
 			modal : false
		});

	}
		/*----------------------------------------------------------------------------------------------
		 * 화면 기본 데이터 셋팅
		 *----------------------------------------------------------------------------------------------*/
		function fnDataSetting(){
			dateTimeInput("txtFromDt");
			dateTimeInput("txtToDt");
		}

		function openFancy(a){
			$("#anotherQty").attr("href","amM201Qty.action?prodCd="+a);
			$("#anotherQty").click();
		}
	//-->
</script>
</head>

<body>
	 <div class="pageContScroll_st2">
		<div class="top_box">
			<div class="table_type">
			<form name="searchForm" id="searchForm">
				<table>
					<caption>분류선택, 상품등록일, 키워드검색, 판매상태, 상품가격으로 구성된 상품관리목록에 대한 검색 테이블입니다.</caption>
					<colgroup>
						<col style="width:135px;" />
						<col style="width:35%;" />
						<col style="width:135px;" />
						<col style="width:*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">분류선택</th>
							<td  style="min-width:370px">
								<html:selectList name='prodCategoryCdA' id='pProdCategoryA' list='${pProdCategory}' listValue='prodCategoryCd' listName='prodCategoryNm' optionValues="" optionNames="대분류전체" script='style="width:120px;"'/>
								<select name='prodCategoryCdB' id='pProdCategoryB' style="width:120px;">
									<option value=''>중분류전체</option>
								</select>
								<select name='prodCategoryCdC' id='pProdCategoryC' style="width:120px;">
									<option value=''>소분류전체</option>
								</select>

							</td>
							<th scope="row">판매기간</th>
							<td>
								<div id='txtFromDt' style='float:left;'></div>
								<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
								<div id='txtToDt'  style='float:left;'></div>
							</td>
						</tr>
						<tr>
							<th scope="row">상품명</th>
							<td>
								<input name="prodNm" type="text" style="width:200px;" />
							</td>
							<th scope="row">판매상태</th>
							<td>
								<html:selectList name='prodStatusCd' id='prodStatusCd' list='${pProdStatus}' listValue='prodStatusCd' listName='prodStatusNm' optionValues="" optionNames="전체" script='style="width:144px;"'/>
								<select name="disView" style="width:80px;">
									<option value="">전체</option>
									<option value="Y" selected>노출</option>
									<option value="N">비노출</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">상품가격</th>
							<td>
								<select name="priceTp" style="width:94px;">
									<option value="R">판매가</option>
									<option value="S">할인가</option>
								</select>
								<input name="priceFrom" class="validation[number]" type="text" style="width:79px;" />
								원
								<span>~</span>
								<input name="priceTo" class="validation[number]" type="text" style="width:79px;" />
								원
							</td>
							<th scope="row">상품종류</th>
							<td>
								<html:selectList name='prodTpCd' id='prodTpCd' list='${prodTpList}' listValue='prodTpCd' listName='prodTpNm' optionValues="" optionNames="전체" script='style="width:144px;"'/>
							</td>
						</tr>
						<tr>
							<th scope="row">제품구성</th>
							<td>
								<select name="prodTypeGsp" style="width:94px;">
									<option value="">전체</option>
									<option value="G">일반</option>
									<option value="S">세트</option>
								</select>
							</td>
							<th scope="row">상품쿠폰</th>
							<td>
								<html:selectList name='prodCopnCd' id='prodCopnCd' list='${prodCopnList}' listValue='copnCd' listName='copnNm' optionValues="" optionNames="전체" script='style="width:144px;"'/>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
			</div>
			<!-- // table_type -->
		</div>
		<!-- // top_box -->
		<div class="btn_area">
			<div class="center">
				<a id="btn_Search" class="btn_blue_line2" href="javascript:;">검색</a>
			</div>
		</div>
		<div class="btn_align_area">
			<div class="left btns">
				<a id="soldOut" class="btn_type2" href="javascript:;">선택상품 품절처리</a>
				<a id="salesEnd" class="btn_type2" href="javascript:;">선택상품 판매종료</a>
				<a class="btn_type2 btn_icon5" id="btnExcel"  href="javascript:;" onclick="grideExportExcel('jqxgrid','상품관리목록');">엑셀다운로드</a>
			</div>
			<div class="right">
				<a id="categoryCnt" class="fancybox bis btn_type2"  data-fancybox-type="iframe" href="javascript:;" >선택상품 분류정보</a>
				<a id="copnProdCnt" class="fancybox bis btn_type2" data-fancybox-type="iframe" href="javascript:;" >선택상품 쿠폰정보</a>
				<a id="orderQty" class="btn_type2" data-fancybox-type="iframe"  href="javascript:;">선택상품 입고정보</a>
				<a id="fancyBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;" style="display:none"></a>
				<a id="anotherQty" class="btn_type2" data-fancybox-type="iframe"  href="javascript:;" style="display:none"></a>
			</div>
		</div>
		<!-- // align_area -->
		<div class="grid_type1">
			<div id="jqxgrid" ></div>
		</div>
	</div>
</body>