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
	var contUrl = "${rootUri}${conUrl}amM205";
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
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
		,{ text: '상품명', datafield: 'prodNm', cellclassname: cellclass, width: '25%', cellsalign: 'left', align: 'center'}
		,{ text: '구매포인트', datafield: 'prodPtOutScore', cellclassname: cellclass, width: '7%', cellsalign: 'right', align: 'center' }
		,{ text: '재고', datafield: 'orderQty', cellclassname: cellclass, width: '7%', cellsalign: 'right', align: 'center' }
		,{ text: '판매상태', datafield: 'prodStatusNm', cellclassname: cellclass, width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '상품종류', datafield: 'prodTpNm', cellclassname: cellclass, width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '판매기간', datafield: 'prodPmntDt', cellclassname: cellclass, width: '22%', cellsalign: 'center', align: 'center'}
		,{ text: 'PC', datafield: 'prodDisPcYn', cellclassname: cellclass, width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '모바일', datafield: 'prodDisMobileYn', cellclassname: cellclass, width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '수정', datafield: 'popButton', cellclassname: cellclass, width: '8%', cellsalign: 'center', align: 'center',
			columntype: 'button', cellsrenderer: function () {
                return "수정";
             }, buttonclick: function (row) {
                var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', row);

               if($(".depths_0").html().indexOf("${homeUrl}/mng/amM2/amM202/amM202.do") == -1){
						alert("수정/등록 관한이 없습니다.");
						return false;
               }else{

// 					$("#viewPage").attr("href","/mng/amM2/amM202/amM202U.action?prodCd="+ dataRecord.prodCd);
// 					$("#viewPage").click();

					$.fancybox.open({
						href: "/mng/amM2/amM202/amM202U.action?prodCd="+ dataRecord.prodCd,
						type: "iframe",
						maxWidth	: 1200,
						maxHeight	: 900,
						width		: 1000,
						height		: 900,
						autoSize	: false
					});
               }
            }
		}
		,{ text: '상품코드', datafield: 'prodCd', hidden: true}
	];

	var _datafields = [
	     { name: 'no', type: 'string'}
		,{ name: 'prodNm', type: 'string'}
		,{ name: 'prodPtOutScore', type: 'string'}
		,{ name: 'orderQty', type: 'string'}
		,{ name: 'prodStatusNm', type: 'string'}
		,{ name: 'prodTpNm', type: 'string'}
		,{ name: 'prodPmntDt', type: 'string'}
		,{ name: 'prodDisPcYn', type: 'string'}
		,{ name: 'prodDisMobileYn', type: 'string'}
		,{ name: 'prodCd', type: 'string'}
	];

	function fnSearchInit(){
		dateTimeInput("txtFromDt");
		dateTimeInput("txtToDt");
		fnGridOption('jqxgrid',{
	        height: 400
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
		var params = $("#searchForm").serialize();
		var dataAdapter = new $.jqx.dataAdapter({
    		datatype: "json",
            datafields: _datafields,
            url: contUrl + ".action?"+params
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

	/*----------------------------------------------------------------------------------------------
	 * 이벤트 Setting
	 *----------------------------------------------------------------------------------------------*/
	 function fnEvent(){
		$("#btn_Search").on('click', fnSearch);//추가

		$("#jqxgrid").on("celldoubleclick", function (event)
		{
				    // event arguments.
				    var args = event.args;
				    // row's bound index.
				    var rowBoundIndex = args.rowindex;
				    if(args.datafield != 'popButton'){
						var prodCd = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "prodCd");

					  setTimeout(function(){
							$("#viewPage").attr("href","amM205R.action?prodCd="+prodCd);

							$("#viewPage").click();
				    },200);
				    }

		});

		$("a#orderQty").bind("click", function(e){
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			if(rowindex > -1){
				var prodCd = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "prodCd");

				$("#orderQty").attr("href","/mng/amM2/amM201/amM201Qty.action?prodCd="+prodCd);

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
						fnAjax("amM205SoldOut.action", {"prodCd" : prodCd}, function(data, dataType){
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
						fnAjax("amM205SalesEnd.action", {"prodCd" : prodCd}, function(data, dataType){
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


		$("#orderQty").fancybox({
			maxWidth	: 400,
			maxHeight	: 486,
			width		: 400,
			height		: 482,
			autoSize	: true,
		    transitionIn      : 'none',
		    transitionOut     : 'none',
		    type              : 'iframe',
			beforeClose : function(){
		    	fnSearch();
			}
		});
		$("#viewPage").fancybox({
			type: "iframe",
 			maxWidth	: 1300,
 			maxHeight	: 900,
 			width		: 1300,
 			height		: 900,
 			autoSize	: false,
 			modal : false
		});
	}

	//-->
</script>
</head>

<body>

	<a id="viewPage" class="fancybox bis" data-fancybox-type="iframe" href="javascript:;"></a>
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
							<th scope="row">상품명</th>
							<td>
								<input name="prodNm" type="text" style="width:200px;" />
							</td>
							<th scope="row">판매기간</th>
							<td>
								<div id='txtFromDt' style='float:left;'></div>
								<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
								<div id='txtToDt'  style='float:left;'></div>
							</td>
						</tr>
						<tr>
							<th scope="row">구매포인트</th>
							<td>
								<input name="priceFrom" class="validation[number]" type="text" style="width:79px;" />
								P
								<span>~</span>
								<input name="priceTo" class="validation[number]" type="text" style="width:79px;" />
								P
							</td>
							<th scope="row">판매상태</th>
							<td>
								<html:selectList name='prodStatusCd' id='prodStatusCd' list='${pProdStatus}' listValue='prodStatusCd' listName='prodStatusNm' optionValues="" optionNames="전체" script='style="width:144px;"'/>
							</td>
						</tr>
						<tr>

							<th scope="row">상품종류</th>
							<td>
								<html:selectList name='prodTpCd' id='prodTpCd' list='${prodTpList}' listValue='prodTpCd' listName='prodTpNm' optionValues="" optionNames="전체" script='style="width:144px;"'/>
							</td>
							<th scope="row"></th>
							<td>
							</td>
						</tr>

					</tbody>
				</table>
				</form>
			</div>
			<!-- // table_type -->
		</div>
		<!-- // top_box -->
		<div class="btn_area marB20">
			<div class="center">
				<a id="btn_Search" class="btn_blue_line2" href="#">검색</a>
			</div>
		</div>
		<div class="align_area">
			<div class="left btns">
				<a id="soldOut" class="btn_type2" href="javascript:;">선택상품 품절처리</a>
				<a id="salesEnd" class="btn_type2" href="javascript:;">선택상품 판매종료</a>
			</div>
			<div class="right">
				<a class="btn_type2 btn_icon5" id="btnExcel"  href="javascript:;" onclick="grideExportExcel('jqxgrid','포인트상품관리목록');">엑셀다운로드</a>
				<a id="orderQty" class="btn_type2" data-fancybox-type="iframe" href="#">선택상품 입고정보</a>
			</div>
		</div>
		<!-- // align_area -->
		<div class="grid_type1">
			<div id="jqxgrid" ></div>
		</div>
	</div>
</body>