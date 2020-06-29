<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
<script type="text/javaScript" defer="defer">
<!--
	var contUrl = "${rootUri}${conUrl}amM104";

	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
		fnDataSetting();
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅
	 *----------------------------------------------------------------------------------------------*/
	var _columns = [
      	{ text: 'NO', datafield: 'rowNum', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: 'ID', datafield: 'mbrId', cellclassname: cellclass, width: '11%', cellsalign: 'center', align: 'center'}
		,{ text: '성명', datafield: 'mbrNm', cellclassname: cellclass, width: '11%', cellsalign: 'center', align: 'center'}
		,{ text: '가입일', datafield: 'mbrJoinDt',  cellclassname: cellclass, width: '11%', cellsalign: 'center', align: 'center'}
		,{ text: '휴면일', datafield: 'test2',  cellclassname: cellclass, width: '11%', cellsalign: 'center', align: 'center'}
		,{ text: '탈퇴일', datafield: 'mbrRsgDt',  cellclassname: cellclass, width: '11%', cellsalign: 'center', align: 'center'}
		,{ text: '등급', datafield: 'mbrLevNm', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '분류', datafield: 'mbrTpBte', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '구매', datafield: 'orderCnt', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '강제', datafield: 'test3', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center',
			cellsrenderer: function (row) {
				return '<div style="text-align:center; margin-top:12px;"><img src="${rootUri}images/blt_circle_coercion.png" alt="강제" /></div>';
            }
		}
	];

	var _datafields = [
		 { name: 'rowNum', type: 'string'}
		,{ name: 'mbrId', type: 'string'}
		,{ name: 'mbrNm', type: 'string'}
		,{ name: 'mbrJoinDt', type: 'string'}
		,{ name: 'test2', type: 'string'}
		,{ name: 'mbrRsgDt', type: 'string'}
		,{ name: 'mbrLevNm', type: 'string'}
		,{ name: 'mbrTpBte', type: 'string'}
		,{ name: 'orderCnt', type: 'string'}
		,{ name: 'test3', type: 'image'}
	];

	function fnSearchInit(){
		dateTimeInput("txtFromDt", null, "${iConstant.prev1DayYmd(-15)}");
		dateTimeInput("txtToDt", null, "${nowYmd}");
		fnGridOption('jqxgrid',{
	       	columns: _columns
	       	,selectionmode: 'singlecell'
	    });
	}

	function fnSearch(){
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + ".action",
	        data: {
	           searchType:$("#searchType").val() ,
         	   searchTxt:$("#searchTxt").val() ,
         	   txtFromDt:$("#txtFromDt").val() ,
         	   txtToDt:$("#txtToDt").val() ,
         	   mbrTpBte:$("#mbrTpBte").val() ,
         	   mbrLevCd:$("#mbrLevCd").val() ,
         	   orderCnt:$("#orderCnt").val()
         	}
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

	function fnEvent(){

		$("#searchTxt").bind("keyup",function(e){
			if(e.keyCode == 13){
				fnSearch();
			}
		});
		$("#btn_Search").on('click', fnSearch);
		$("#mbrTpBte").on('change', fnSearch);
		$("#orderCnt").on('change', fnSearch);
		$("#mbrLevCd").on('change', fnSearch);

		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid','휴면회원목록');
		});
	}

	function fnDataSetting(){

	}
//-->
</script>
</head>

<body>
<div class="pageContScroll_st2">
	<div class="top_box">
		<div class="table_type">
			<table>
				<caption>키워드검색, 가입일, 회원분류, 회원등급, 구매이력, 성별로 구성된 회원목록에 대한
					검색 테이블입니다.</caption>
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: *;" />
					<col style="width: 10%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">키워드검색</th>
						<td>
							<select id="searchType" style="width: 134px;">
								<option value="1">회원명</option>
								<option value="2">아이디</option>
								<option value="3">전화번호</option>
								<option value="4">추천인</option>
								<option value="5">이메일</option>
							</select>
							<input type="text" id="searchTxt" style="width: 134px;" />
						</td>
						<th scope="row">가입일</th>
						<td>
							<div id='txtFromDt' name="txtFromDt" style='float:left;'></div>
							<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
							<div id='txtToDt' name="txtToDt"  style='float:left;'></div>
						</td>
					</tr>
					<tr>
						<th scope="row">회원분류</th>
						<td>
							<select id="mbrTpBte" style="width: 174px;">
								<option value="">전체</option>
								<option value="B">일반회원</option>
								<option value="T">전화회원</option>
								<option value="E">임직원</option>
							</select>
						</td>
						<th scope="row">회원등급</th>
						<td>
							<select id="mbrLevCd" style="width: 174px;">
								<option value="">전체</option>
								<c:forEach items="${plicyList}" var="plicyList">
									<option value="${plicyList.mbrLevCd}">${plicyList.mbrLevNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">구매이력</th>
						<td>
							<select id="orderCnt" style="width: 174px;">
								<option value="">전체</option>
								<option value="1">있음</option>
								<option value="2">없음</option>
							</select>
						</td>
						<th scope="row"></th>
						<td>

						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- // table_type -->
	</div>
	<!-- // top_box -->
	<div class="btn_area marB35">
		<div class="center">
			<a class="btn_blue_line2" id="btn_Search" href="#">검색</a>
		</div>
	</div>
	<!-- // btn_area -->
	<div class="align_area">
		<div class="left">
			<p>대상회원 : 총 ${totalCount}명</p>
		</div>
		<div class="right">
			<a class="btn_type2 btn_icon5" href="#" id="btnExcel">엑셀다운로드</a>
		</div>
	</div>

	<div class="grid_type1">
		<div id="jqxgrid"></div>
	</div>


	<!--
	<div class="table_type1">
		<table>
			<caption>선택, NO, ID, 성명, 성별, 나이, 가입일, 휴먼일, 탈퇴일, 전화, 등급,
				분류, 구매, 강제로 구성된 회원목록에 대한 리스트 테이블 입니다.</caption>
			<colgroup>
				<col style="width: 5%;" />
				<col style="width: 7%;" />
				<col style="width: 7%;" />
				<col style="width: 6%;" />
				<col style="width: 6%;" />
				<col style="width: 6%;" />
				<col style="width: 9%;" />
				<col style="width: 9%;" />
				<col style="width: 9%;" />
				<col style="width: 14%;" />
				<col style="width: 7%;" />
				<col style="width: 5%;" />
				<col style="width: 5%;" />
				<col style="width: 5%;" />
			</colgroup>
			<thead>
				<tr>
					<th scope="col">선택</th>
					<th scope="col">NO</th>
					<th scope="col">ID</th>
					<th scope="col">성명</th>
					<th scope="col">성별</th>
					<th scope="col">나이</th>
					<th scope="col">가입일</th>
					<th scope="col" class="colRed">휴먼일</th>
					<th scope="col" class="colRed">탈퇴일</th>
					<th scope="col">전화</th>
					<th scope="col">등급</th>
					<th scope="col">분류</th>
					<th scope="col">구매</th>
					<th scope="col">강제</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td><input type="checkbox" /></td>
					<td>107550</td>
					<td>dawqw3331</td>
					<td>홍길동</td>
					<td>남</td>
					<td>99</td>
					<td>2015.10.10</td>
					<td class="colRed">2015.10.10</td>
					<td class="colRed">2015.10.10</td>
					<td>010-1234-5678</td>
					<td>Normal</td>
					<td>일반</td>
					<td>3</td>
					<td><img src="${rootUri}images/blt_circle_coercion.png" alt="강제" /></td>
				</tr>
			</tbody>
		</table>
	</div>
	 -->

</div>
</body>