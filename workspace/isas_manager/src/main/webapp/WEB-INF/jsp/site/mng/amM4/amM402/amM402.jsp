<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 마케팅관리 : 쿠폰관리 -->

	<script type="text/javaScript" defer="defer">
	<!--
		var contUrl = "${rootUri}${conUrl}amM402";
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
			{ text: '등록일자', datafield: 'regDt', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
			,{ text: '쿠폰명', datafield: 'copnNm', cellclassname: cellclass, width: '21%', cellsalign: 'left', align: 'center'}
			,{ text: '사용기간', datafield: 'copnLimitTpApmd', cellclassname: cellclass, width: '11%', cellsalign: 'left', align: 'center'}
			,{ text: '쿠폰종류', datafield: 'copnTpPdmc', cellclassname: cellclass, width: '8%', cellsalign: 'center', align: 'center'}
			,{ text: '사용방식', datafield: 'copnUseTpGo', cellclassname: cellclass, width: '8%', cellsalign: 'center', align: 'center'}
			,{ text: '할인방식', datafield: 'copnDisTpRap', cellclassname: cellclass, width: '8%', cellsalign: 'center', align: 'center'}
			,{ text: '발행수량', datafield: 'copnIsuQty', cellclassname: cellclass, width: '8%', cellsalign: 'right', align: 'center'}
			,{ text: '발급수량', datafield: 'copnUseQty', cellclassname: cellclass, width: '8%', cellsalign: 'right', align: 'center'}
			,{ text: '이용수량', datafield: 'copnUseYQty', cellclassname: cellclass, width: '8%', cellsalign: 'right', align: 'center'}
			,{ text: '신규발행여부', datafield: 'copnFlagYn', cellclassname: cellclass, width: '8%', cellsalign: 'center', align: 'center'}
			,{ text: '상세보기', datafield: 'popButton', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center',
				columntype: 'button', cellsrenderer: function () {
	                return "상세보기";
	             }, buttonclick: function (row) {
	                var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', row);

					$.fancybox.open({
						href: encodeURI("amM402Up.action?COPN_CD=" + dataRecord.copnCd),
						type: "iframe",
			 			maxWidth	: 850,
			 			maxHeight	: 1000,
			 			width		: 850,
			 			height		: 1000,
			 			modal : false,
			 			autoSize	: false
					});
	            }
			}
			,{ text: '쿠폰코드', datafield: 'copnCd', hidden: true}
		];

		var _datafields = [
			{ name: 'regDt', type: 'string'}
			,{ name: 'copnNm', type: 'string'}
			,{ name: 'copnLimitTpApmd', type: 'string'}
			,{ name: 'copnTpPdmc', type: 'string'}
			,{ name: 'copnUseTpGo', type: 'string'}
			,{ name: 'copnDisTpRap', type: 'string'}
			,{ name: 'copnIsuQty', type: 'string'}
			,{ name: 'copnUseQty', type: 'string'}
			,{ name: 'copnUseYQty', type: 'string'}
			,{ name: 'copnFlagYn', type: 'string'}
			,{ name: 'copnCd', type: 'string'}
		];

		function fnSearchInit(){
			fnGridOption('jqxgrid',{
				height:295
				,selectionmode:'none'
				,columns: _columns
		    });
		}
		/*----------------------------------------------------------------------------------------------
		 * grid search
		 *----------------------------------------------------------------------------------------------*/
		function fnSearch(){
			var dataAdapter = new $.jqx.dataAdapter({
	    		datatype: "json",
	            datafields: _datafields,
	            url: contUrl + ".action",
	            data: {
	            	copnFlagYn: $("#copnFlagYn").val(),
	            	copnTpPdmc: $("#copnTpPdmc").val(),
	            	copnNm: $("#copnNm").val()
	            }
			});
			$("#jqxgrid").jqxGrid({source: dataAdapter});
			fnResetGridEditData('jqxgrid');
			return false;
		}

		/*----------------------------------------------------------------------------------------------
		 * 이벤트 Setting
		 *----------------------------------------------------------------------------------------------*/
		function fnEvent(){
			$("#copnFlagYn").on('change', fnSearch);//추가
			$("#copnTpPdmc").on('change', fnSearch);//추가
			$("#btn_Search").on('click', fnSearch);//추가
		}

		function fnBtnEventHandler(type){
			var urlS = 'amM402';
			var urlE = '.action';
			var titleStr = '';
			var url = urlS + type + urlE;
			if(type == 'P'){
				titleStr='상품용 쿠폰등록';
			}else if(type == 'C'){
				titleStr='CS전용 쿠폰등록';
			}else if(type == 'D'){
				titleStr='다운용 쿠폰등록';
			}else if(type == 'M'){
				titleStr='회원용 쿠폰등록';
			}

			$.fancybox.open({
				href: encodeURI(url),
				type: "iframe",
	 			maxWidth	: 850,
	 			maxHeight	: 1000,
	 			width		: 850,
	 			height		: 1000,
	 			modal : false,
	 			autoSize	: false
			});

		}

	//-->
	</script>
</head>
<body>
	 <div class="pageContScroll_st2">
	<div class="top_box">
		<div class="table_type">
			<table>
				<caption>신규발행여부로 구성된 마케팅관리 하위의 쿠폰관리에 대한 검색 테이블입니다.</caption>
				<colgroup>
					<col style="width: 15%;" />
					<col style="width: *;" />
					<col style="width: 15%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">신규 쿠폰 발행 여부</th>
						<td>
							<select id="copnFlagYn" name="copnFlagYn" style="width: 174px;">
									<option value="">전체</option>
									<option value="Y">신규 쿠폰 발행 중</option>
									<option  value="N">신규 쿠폰 뱔행 정지</option>
							</select>
						</td>
						<th scope="row">쿠폰 종류</th>
						<td>
							<select id="copnTpPdmc" name="copnTpPdmc" style="width: 174px;">
									<option value="">전체</option>
									<option value="P">상품쿠폰</option>
									<option  value="D">다운로드쿠폰</option>
									<option  value="M">회원쿠폰</option>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">쿠폰명</th>
						<td colspan="3">
							<input type="text" name="copnNm" id="copnNm" style="width: 350px;"/>
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
			<a id="btn_Search" class="btn_blue_line2" href="javascript:;">검색</a>
		</div>
	</div>

	<div class="align_area">
		<div class="left">
			<a class="btn_type2 btn_icon5" id="btnExcel" style="margin-left:0px;"  href="javascript:;" onclick="grideExportExcel('jqxgrid','쿠폰목록');">엑셀다운로드</a>
		</div>
		<div class="right">
			<a class="btn_type2" href="javascript:fnBtnEventHandler('P');">상품용 쿠폰등록</a>
			<a class="btn_type2" href="javascript:fnBtnEventHandler('D');">다운용 쿠폰등록</a>
			<a class="btn_type2" href="javascript:fnBtnEventHandler('M');">회원용 쿠폰등록</a>
<!-- 			<a class="btn_type2" href="javascript:fnBtnEventHandler('C');">CS전용 쿠폰등록</a> -->
		</div>
	</div>
	<!-- // btn_area -->
	<div class="grid_type1">
		<div id="jqxgrid"></div>
	</div>
	<!-- // table_type1 -->

    </div>
</body>