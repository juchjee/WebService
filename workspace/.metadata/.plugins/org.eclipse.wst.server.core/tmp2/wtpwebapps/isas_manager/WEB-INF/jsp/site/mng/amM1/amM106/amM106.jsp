<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
<script type="text/javaScript" defer="defer">
<!--
	var contUrl = "${rootUri}${conUrl}amM106";

	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅
	 *----------------------------------------------------------------------------------------------*/
	var _columns = [
		{ text: 'ID', datafield: 'mbrId', cellclassname: cellclass, width: '15%', cellsalign: 'center', align: 'center'}
		,{ text: '성명', datafield: 'mbrNm', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '이용포인트', datafield: 'mbrPtScore', cellclassname: cellclass, width: '15%', cellsalign: 'center', align: 'center'}
		,{ text: '상태', datafield: 'aState', cellclassname: cellclass, width: '15%', cellsalign: 'center', align: 'center'}
		,{ text: '이용일', datafield: 'mbrPtAccDt', cellclassname: cellclass, width: '15%', cellsalign: 'center', align: 'center'}
		,{ text: '이용내역', datafield: 'ptNm', cellclassname: cellclass, width: '30%', cellsalign: 'center', align: 'center'}
	];

	var _datafields = [
   		{ name: 'mbrId', type: 'string'}
   		,{ name: 'mbrNm', type: 'string'}
   		,{ name: 'mbrPtScore', type: 'string'}
   		,{ name: 'aState', type: 'string'}
   		,{ name: 'mbrPtAccDt', type: 'string'}
   		,{ name: 'ptNm', type: 'string'}
   	];

	function fnSearchInit(){
		dateTimeInput("txtFromDt", null, "${iConstant.prev1DayYmd(-1)}");
		dateTimeInput("txtToDt", null, "${nowYmd}");
		fnGridOption('jqxgrid',{
			height: 345
	       	,columns: _columns
	       	,selectionmode: 'singlerow'
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
	         	   txtToDt:$("#txtToDt").val()
	         	}
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		fnAjax(	"amM106Cnt.action",
				{ searchType:$("#searchType").val()},
				function(data, dataType){
					$("#countMap").html("이용건수 : 총 "+data.totCnt+"<span>총 발생포인트 : 총 "+data.inScore+"</span><span>총 차감포인트 : 총 "+data.outScore+"</span><span>총 잔여포인트 : 총 "+data.miScore+"</span>");
				},'POST','json');
		return false;
	}


	function fnEvent(){
		$("#searchTxt").bind("keyup",function(e){
			if(e.keyCode == 13){
				fnSearch();
			}
		});

		$("#btn_Search").on('click', fnSearch);
		<c:choose>
		<c:when test='${not empty isCrm}'>
			$("#jqxgrid").on('celldoubleclick', function (event){
				var args = event.args;
				var row = args.rowindex;
				var datarow = $('#jqxgrid').jqxGrid('getrowdata', row);
			    if(args.datafield != 'dtl' && args.datafield != 'dm' && args.datafield != 'sms'){
					window.open("/mng/crm/softPhone/SoftPhone.pop?admId=${admId}&mbrId="+datarow.mbrId, "mbrId", "width=1366, height=875, scrollbars=yes");
				}
			});
	   </c:when>
       <c:otherwise>
	       	$("#jqxgrid").on('celldoubleclick', function (event){
				var args = event.args;
				var row = args.rowindex;
				var datarow = $('#jqxgrid').jqxGrid('getrowdata', row);
			    if(args.datafield != 'dtl' && args.datafield != 'dm' && args.datafield != 'sms'){
					window.open("/mng/amM1/amM102/amM1021F.pop?mbrId="+datarow.mbrId, "mbrId", "width=1070, height=875, scrollbars=yes");
				}
			});
	    </c:otherwise>
	</c:choose>
	}
//-->
</script>
</head>

<body>
<div class="pageContScroll_st2">
	<div class="top_box">
		<div class="table_type">
			<table>
				<caption>키워드검색, 가입일로 구성된 회원목록에 대한 검색 테이블입니다.</caption>
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
							</select>
							<input type="text" id="searchTxt" style="width: 134px;" />
						</td>
						<th scope="row">발생기간</th>
						<td>
							<div id='txtFromDt' name="txtFromDt" style='float:left;'></div>
							<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
							<div id='txtToDt' name="txtToDt"  style='float:left;'></div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div class="btn_area marB35">
		<div class="center">
			<a class="btn_blue_line2" id="btn_Search" href="#">검색</a>
		</div>
	</div>

	<div class="align_area">
		<div class="left">
			<p id="countMap"></p>
		</div>
		<div class="right">
			<a class="btn_type2 btn_icon5" id="btnExcel" href="#" onclick="javascript:grideExportExcel('jqxgrid','포인트이용내역');">엑셀다운로드</a>
		</div>
		<!--
		<div class="right">
			<a class="btn_type2 btn_icon6" href="#">선택삭제</a>
		</div>
		-->
	</div>

	<div class="grid_type1">
		<div id="jqxgrid"></div>
	</div>

</div>
</body>