<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 게시판관리 : CS상담관리 -->

<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM501";
	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
		$(".fancybox.big").fancybox({
			maxWidth	: 1200,
			maxHeight	: 900,
			width		: 1000,
			height		: 900
		});
	}

	var _columns = [
	    { text: '선택', datafield: 'chk', width: '5%', cellclassname: cellclass, columntype: 'checkbox',sortable: false ,cellsalign: 'center', align: 'center'},
   		{ text: '상담번호', datafield: 'csNo', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center'},
   		{ text: '상담일', datafield: 'csDt', cellsformat: 'yyyy-MM-dd', cellclassname: cellclass, width: '9%', cellsalign: 'center', align: 'center'},
   		{ text: '문의자', datafield: 'caNonMbrNm', cellclassname: cellclass, width: '9%', cellsalign: 'center', align: 'center'},
   		{ text: '문의자연락처', datafield: 'caNonMbrTel', cellclassname: cellclass, width: '9%', cellsalign: 'center', align: 'center'},
		{ text: '유입경로', datafield: 'csFunnelNm', cellclassname: cellclass, width: '8%', cellsalign: 'center', align: 'center'},
   		{ text: '상담유형', datafield: 'csTypeNm', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
   		{ text: '문의내용', datafield: 'csQuestion', cellclassname: cellclass, width: '20%', cellsalign: 'left', align: 'center'},
   		{ text: '답변내용', datafield: 'csConsult', cellclassname: cellclass, width: '15%', cellsalign: 'left', align: 'center'},
   		{ text: '답변자', datafield: 'caMbrId', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center'},
		{ text: '콜 유형', datafield: 'csCall', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center'}
   		];

  	var _datafields = [
  	     { name: 'chk', type: 'boolean', value: 'false'}
  		,{ name: 'csNo', type: 'string'}
  		,{ name: 'csDt', type: 'date'}
  		,{ name: 'caNonMbrNm', type: 'string'}
  		,{ name: 'caNonMbrTel', type: 'string'}
  		,{ name: 'csFunnelNm', type: 'string'}
  		,{ name: 'csTypeNm', type: 'string'}
  		,{ name: 'csQuestion', type: 'string'}
  		,{ name: 'csConsult', type: 'string'}
  		,{ name: 'caMbrId', type: 'string'}
  		,{ name: 'csCall', type: 'string'}
  		];

  	function fnSearchInit(){
  		dateTimeInput("txtFromDt", null, "${nowYmd}");
		dateTimeInput("txtToDt", null, "${nowYmd}");
		fnGridOption('jqxgrid',{
			height:315
	       ,columns: _columns
	       ,selectionmode: 'multiplecellsextended'
	       ,autorowheight: true
	    });
	}

  	function fnSearch(){
  		var params = $("#searchForm").serialize();
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + ".action",
	        data: {searchType:$("#searchType").val(),searchTxt:$("#searchTxt").val(),
	        	   csFunnel: $("#csFunnel").val(),csType: $("#csType").val(),
	        	   txtFromDt:$("#txtFromDt").val(),txtToDt:$("#txtToDt").val()}
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

  	function fnEvent(){
  		$('#jqxgrid').on('columnclick', function (e) {
			if(e.args.datafield == 'chk'){
				var rows = $('#jqxgrid').jqxGrid('getrows');
				var newChkValue = $("input[name=chkAll]").is(":checked");
				var rowIDs = new Array();
				for(var i = 0, endI = rows.length; i < endI; i++){
					rows[i].chk = !newChkValue;
					rowIDs.push(rows[i].uid);
				}
				$("#jqxgrid").jqxGrid('updaterow', rowIDs, rows);
				$("input[name=chkAll]").prop("checked", !newChkValue);
			}
		 });

		$("#jqxgrid").off('cellclick').on('cellclick', function(e){
			if(e.args.datafield == 'chk'){
				$('#jqxgrid').jqxGrid('setcellvalue', e.args.rowindex, 'chk', !e.args.value);
			}
		});

  		$("#btn_Search").on('click', fnSearch);
//   		$("#csFunnel").on('change', fnSearch);
//   		$("#csType").on('change', fnSearch);

  		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid','엑셀 다운로드');
		});

  		$("#jqxgrid").on('celldoubleclick', function (event)
  				{
  					if(event.args.datafield != 'chk'){
  				  		    var args = event.args;
  				  		    var rowBoundIndex = args.rowindex;
  							var datarow = $('#jqxgrid').jqxGrid('getrowdata', rowBoundIndex);
  							$("#boardSeq").val(datarow.boardSeq);
  								setTimeout(function(){
  									$("#modifyBtn").attr("href","amM501R.action?csNo="+datarow.csNo);
  									$("#modifyBtn").click();
  								},200);
  					}
  				});

		$("#modifyBtn").fancybox({
			type: "iframe",
			maxWidth	: 1200,
			maxHeight	: 780,
			width		: 1200,
			height		: 780,
			modal : false,
			autoSize	: false,
			beforeClose : function(){
		    	fnSearch();
			}
		});

		$(".delBtn").click(function(){

			$.paramData = new Object();

			var rows = $('#jqxgrid').jqxGrid('getrows');
			var j = 0;
			for(var i = 0; i < rows.length; i++){
				var row = rows[i];
				if(row.chk == true){
					$.paramData[j] =  row.csNo;
					j++;
				}
			}
			if(j == 0){
				alert("삭제할 게시글을 선택해주세요.");
				return false;
			}
			if(confirm("삭제하시겠습니까?")){
				fnAjax("amM501D.action",  {"data":$.paramData}, function(data, dataType){
					var data = data.replace(/\s/gi,'');
					alert(data);
					$('#jqxgrid').jqxGrid('clearselection');
					fnSearch();
				},'POST','text');
			}
		});
  	}

</script>
</head>
<body>
<input name='chkAll' type='checkbox' style="display:none"/>
<div class="pageContScroll_st2">
	<div class="top_box">
		<div class="table_type">
			<table>
				<caption>분류선택, 상품등록일, 키워드검색, 판매상태, 상품가격으로 구성된 상품관리목록에 대한 검색 테이블입니다.</caption>
				<colgroup>
						<col style="width:135px;" />
						<col style="width:350px;" />
						<col style="width:135px;" />
						<col style="width:*" />
					</colgroup>
				<tbody>
					<tr>
						<th scope="row">상담일</th>
						<td>
							<div id='txtFromDt' name="txtFromDt" style='float:left;'></div>
							<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
							<div id='txtToDt' name="txtToDt"  style='float:left;'></div>
						</td>
						<th scope="row">텍스트검색</th>
						<td>
							<select id="searchType" name="searchType" style="width:100px;">
								<option value="0">전체</option>
								<option value="1">문의내용</option>
								<option value="2">상담내용</option>
							</select>
							<input type="text" id="searchTxt" name="searchTxt" class="marL10" style="width:182px;" />
						</td>
					</tr>
					<tr>
						<th scope="row">상담유입경로</th>
						<td>
							<select id="csFunnel" name="csFunnel" style="width:100px;">
								<option value="">전체</option>
								<c:forEach items="${funnelList}" var="funnelList">
									<option value="${funnelList.csTypeCd}" >${funnelList.csTypeNm}</option>
								</c:forEach>
							</select>
						</td>
						<th scope="row">상담유형</th>
						<td>
							<select id="csType" name="csType" style="width:100px;">
								<option value="">전체</option>
								<c:forEach items="${typeList}" var="typeList">
									<option value="${typeList.csTypeCd}" >${typeList.csTypeNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</tbody>
			</table>

		</div>
		<!-- // text_type -->
	</div>
	<!-- // top_box -->
	<div class="btn_area marB35" >
			<div class="center">
				<a id="btn_Search" class="btn_blue_line2" href="javascript:" >검색</a>
			</div>
			<div class="left" style="line-height:40px;">
				<a class="btn_type2 btn_icon5" id="btnExcel" style="margin-left:0px;"  href="javascript:;" >엑셀다운로드</a>
			</div>
			<div class="right" style="line-height:40px;">
				<a class="delBtn btn_type2" href="javascript:;">삭제</a>
			</div>
				<a id="modifyBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;" style="display:none;"></a>
		</div>

	<div class="grid_type1">
		<div id="jqxgrid"></div>
	</div>

</div>
</body>