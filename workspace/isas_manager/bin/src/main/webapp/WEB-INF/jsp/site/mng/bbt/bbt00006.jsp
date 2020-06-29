<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 게시판관리 : 고객상담관리 & 제품문의 -->

<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}bbt00002";

	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
		fnDataSetting();
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅 - 선택, 제품명, 판매가, 할인가, 쿠폰, 적립금, 재고, 판매상태, PC노출, 모바일노출, 과세, 등록일, 관리
	 *----------------------------------------------------------------------------------------------*/

	 var _columns = [
		{ text: '분류', datafield: 'boardCateNm', cellclassname: cellclass, width: '10%', cellsalign: 'left', align: 'center'}
		,{ text: '제목', datafield: 'boardTitle', cellclassname: cellclass, width: '55%', cellsalign: 'left', align: 'center'}
		,{ text: '답변', datafield: 'boardState', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '작성자', datafield: 'regId', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '등록일', datafield: 'regDt', cellsformat: 'yyyy-MM-dd', cellclassname: cellclass, width: '15%', cellsalign: 'center', align: 'center'}
		,{ text: '순', datafield: 'boardSeq', hidden:true , cellclassname: cellclass, cellsalign: 'center', align: 'center'}
		];

	var _datafields = [
		{ name: 'boardCateNm', type: 'string'}
		,{ name: 'boardTitle', type: 'string'}
		,{ name: 'boardState', type: 'string'}
		,{ name: 'regId', type: 'string'}
		,{ name: 'regDt', type: 'date'}
		,{ name: 'boardSeq', type: 'string'}
	];

	function fnSearchInit(){
		dateTimeInput("txtFromDt", null, "${iConstant.prev1DayYmd(-15)}");
		dateTimeInput("txtToDt", null, "${nowYmd}");
		fnGridOption('jqxgrid',{
			height:290
	       ,columns: _columns
	       ,selectionmode: 'multiplerowsextended'
	    });
	}

	function fnSearch(){
		//var params = $("#searchForm").serialize();
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + ".action",
	        data: {boardMstCd: '${boardMstCd}',
	        	   boardCateSeq: $("#boardCateSeq").val(),
	        	   searchType:$("#searchType").val(),
	        	   searchTxt:$("#searchTxt").val(),
	        	   stateYn:$("input:radio[name='stateYn']:checked").val(),
	        	   txtFromDt:$("#txtFromDt").val(),
            	   txtToDt:$("#txtToDt").val()}
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

	function fnEvent(){
		$("#boardCateSeq").on('change', fnSearch);
		$("#btn_Search").on('click', fnSearch);
		$("input:radio[name='stateYn']").on('change', fnSearch);

		$("#jqxgrid").on('rowdoubleclick', function (event)
		{
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			var datarow = $('#jqxgrid').jqxGrid('getrowdata', rowindex);
			$("#boardSeq").val(datarow.boardSeq);
			$.fancybox.open({
				href: "bbt00006R.action?boardMstCd=${boardMstCd}&boardSeq="+datarow.boardSeq,
				type: "iframe",
				maxWidth	: 1920,
				maxHeight	: 1100,
				width		: 1000,
				height		: 680,
				modal : false,
				autoSize	: true
			});
		});

		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid','서비스문의');
		});

		$("#modifyBtn").click(function(){
			var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
			if(rowindex==-1){
				alert("수정할 서비스문의를 선택해주세요.");
				return false;
			}
			var datarow = $("#jqxgrid").jqxGrid('getrowdata', rowindex);
			$("#boardSeq").val(datarow.boardSeq);
			$("#modifyBtn").attr("href","bbt00006R.action?boardMstCd=${boardMstCd}&boardSeq="+datarow.boardSeq);
		});

		$(".delBtn").click(function(){
			var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindexes');
			if(rowindex==-1){
				alert("삭제할 서비스문의를 선택해주세요.");
				return false;
			}

			$.paramData = new Object();
			for(key in rowindex){
				$.paramData[key] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "boardSeq");
			}

			if(confirm("삭제하시겠습니까?")){
				fnAjax("bbt00006D.action",  {"data":$.paramData}, function(data, dataType){
					var data = data.replace(/\s/gi,'');
					alert(data);
					fnSearch();
				},'POST','text');
			}
		});

		$("#modifyBtn").fancybox({
			maxWidth	: 1920,
			maxHeight	: 1100,
			width		: 1000,
			height		: 680,
			autoSize	: true,
			beforeClose : function(){
		    	fnSearch();
			}
		});
	}

	function fnDataSetting(){
		$("input[name=stateYn]").eq(0).attr("checked",true);
	}

</script>

</head>
<body>
	<div class="pageContScroll_st2">
		<div class="top_box">
			<form id="workForm" name="workForm" action="bbt00006R.do?boardMstCd=${boardMstCd}" method="post">
			<input type="hidden" id="boardSeq" name="boardSeq" />
			<div class="table_type">
				<table>
					<caption>답변상태, 상품등록일, 분류, 키워드검색으로 구성된 고객상담에 대한 검색 테이블입니다.</caption>
					<colgroup>
						<col style="width:80px;" />
						<col style="width:20%;" />
						<col style="width:80px;" />
						<col style="width:20%;" />
						<col style="width:80px;" />
						<col style="width:*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">답변</th>
							<td>
								<input type="radio" name="stateYn" value="" id="answer3" class="marR5" /><label for="answer1">전체</label>&nbsp;&nbsp;
								<input type="radio" name="stateYn" value="Y" id="answer1" class="marR5" /><label for="answer1">답변완료</label>&nbsp;&nbsp;
								<input type="radio" name="stateYn" value="N" id="answer2" class="marR5" /><label for="answer2">답변대기</label>
							</td>
							<th scope="row">등록일</th>
							<td>
								<div id='txtFromDt' name="txtFromDt" style='float:left;'></div>
								<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
								<div id='txtToDt' name="txtToDt"  style='float:left;'></div>
							</td>
							<th scope="row">키워드</th>
							<td>
								<select id="boardCateSeq" name="boardCateSeq" style="width:100px;">
									<option value="">전체</option>
									<c:forEach items="${cateList}" var="cateList">
										<option value="${cateList.boardCateSeq}" >${cateList.boardCateNm}</option>
									</c:forEach>
								</select>
								<select id="searchType" style="width:100px;">
									<option value="1">제목</option>
									<option value="2">내용</option>
									<option value="3">제목+내용</option>
								</select>
								<input type="text" id="searchTxt" class="marL10" style="width:182px;" />
								<a class="btn_blue_line" id="btn_Search" href="#">검색</a>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
		</div>
		<div class="align_area">
			<div class="left">
				<a class="btn_type2 btn_icon5" id="btnExcel" style="margin-left:0px;"  href="javascript:;" >엑셀다운로드</a>
			</div>
			<div class="right">
				<a id="modifyBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;">수정</a>
				<a class="delBtn btn_type2" style="margin-left:0px;" href="javascript:;">삭제</a>
			</div>
		</div>

		<div class="grid_type1">
			<div id="jqxgrid"></div>
		</div>
	</div>
</body>