<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
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
	     { text: '선택', datafield: 'chk', width: '5%',  columntype: 'checkbox',sortable: false ,cellsalign: 'center', align: 'center'}
		,{ text: '번호', datafield: 'num', width: '5%',  cellsalign: 'center', align: 'center'}
		,{ text: '문의구분', datafield: 'questionTp',  width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '제품', datafield: 'boardCateNm',  width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '제목', datafield: 'boardTitle',  width: '30%', cellsalign: 'left', align: 'center'}
		,{ text: '작성자', datafield: 'regId',  width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '등록일', datafield: 'regDt', cellsformat: 'yyyy-MM-dd',  width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '답변자', datafield: 'test',  width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '진행상태', datafield: 'boardState',  width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '시퀀스', datafield: 'boardSeq', hidden:true}
		];

	var _datafields = [
	     {name: 'chk',    type: 'boolean', value: 'false'}
		,{ name: 'num', type: 'string'}
		,{ name: 'questionTp', type: 'string'}
		,{ name: 'boardCateNm', type: 'string'}
		,{ name: 'boardTitle', type: 'string'}
		,{ name: 'regId', type: 'string'}
		,{ name: 'regDt', type: 'date'}
		,{ name: 'test', type: 'string'}
		,{ name: 'boardState', type: 'string'}
		,{ name: 'regDt', type: 'date'}
	    ,{ name: 'boardSeq', type: 'string'}
	];

	function fnSearchInit(){
  		dateTimeInput("txtFromDt", null, "${iConstant.prevDayYmd(-10)}");
		dateTimeInput("txtToDt", null, "${nowYmd}");
		fnGridOption('jqxgrid',{
			 height:320
	       ,columns: _columns
	       ,selectionmode: 'multiplecellsextended'
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
            	   boardFirstYn:$("#boardFirstYn").is(":checked"),
            	   questionTp:$("#questionTp").val(),
            	   txtToDt:$("#txtToDt").val()}
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

		//$("#boardCateSeq").on('change', fnSearch);
		$("#btn_Search").on('click', fnSearch);
		//$("input:radio[name='stateYn']").on('change', fnSearch);

  		$("#jqxgrid").on('celldoubleclick', function (event)
		{
			if(event.args.datafield != 'chk'){
  		    var args = event.args;
  		    var rowBoundIndex = args.rowindex;
			var datarow = $('#jqxgrid').jqxGrid('getrowdata', rowBoundIndex);
			$("#boardSeq").val(datarow.boardSeq);
				setTimeout(function(){
					$("#modifyBtn").attr("href","bbt00002R.action?boardMstCd=${boardMstCd}&boardSeq="+datarow.boardSeq);
					$("#modifyBtn").click();
				},200);
			}
		});

		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid','고객상담_서비스문의');
		});

		$("#registBtn").click(function(){
			$("#registBtn").attr("href","bbt00002R.action?boardMstCd=${boardMstCd}");
		});


		$(".delBtn").click(function(){
			var rows = $('#jqxgrid').jqxGrid('getrows');

			$.paramData = new Object();


			var rows = $('#jqxgrid').jqxGrid('getrows');
			var j = 0;
			for(var i = 0; i < rows.length; i++){
				var row = rows[i];
				if(row.chk == true){
					$.paramData[j] =  row.boardSeq;
					j++;
				}
			}
			if(j == 0){
				alert("삭제할 게시글을 선택해주세요.");
				return false;
			}

			if(confirm("삭제하시겠습니까?")){
				fnAjax("bbt00002D.action",  {"data":$.paramData}, function(data, dataType){
					var data = data.replace(/\s/gi,'');
					alert(data);
					$('#jqxgrid').jqxGrid('clearselection');
					fnSearch();
				},'POST','text');
			}
		});

		$("#registBtn,#modifyBtn").fancybox({
			type: "iframe",
			maxWidth	: 1200,
			maxHeight	: 900,
			width		: 1200,
			height		: 900,
			modal : false,
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
	<input name='chkAll' type='checkbox' style="display:none"/>
	<div class="pageContScroll_st2">
		<div class="top_box">
			<form id="workForm" name="workForm" action="bbt00002R.do?boardMstCd=${boardMstCd}" method="post">
				<input type="hidden" id="boardSeq" name="boardSeq" />
				<div class="table_type">
					<table>
					<caption>등록일, 분류, 키워드검색으로 구성된 공지사항목록에 대한 검색 테이블입니다.</caption>
					<colgroup>
						<col style="width:135px;" />
						<col style="width:350px;" />
						<col style="width:135px;" />
						<col style="width:*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">등록일</th>
							<td>
								<div id='txtFromDt' name="txtFromDt" style='float:left;'></div>
								<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
								<div id='txtToDt' name="txtToDt"  style='float:left;'></div>
							</td>
							<th scope="row">제품</th>
							<td>
								<c:choose>
									<c:when test="${fn:length(cateList) == 1}">
										<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${cateList[0].boardCateSeq}"/>${cateList[0].boardCateNm}
									</c:when>
									<c:otherwise>
										<select id="boardCateSeq" name="boardCateSeq" style="width:100px;">
											<option value="">분류전체</option>
											<c:forEach items="${cateList}" var="cateList">
												<option value="${cateList.boardCateSeq}" >${cateList.boardCateNm}</option>
											</c:forEach>
										</select>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="row">텍스트검색</th>
							<td>
								<select id="searchType" style="width:100px;">
									<option value="1">제목</option>
									<option value="2">내용</option>
									<option value="3">제목+내용</option>
									<option value="4">작성자아이디</option>
									<option value="5">작성자명</option>
								</select>
								<input type="text" id="searchTxt" class="marL10" style="width:145px;" />
							</td>
							<th scope="row">문의구분</th>
							<td>
								<select id="questionTp" name="questionTp" style="width:100px;">
									<option value="">전체</option>
									<option value="1">A/S신청</option>
									<option value="2">제품문의</option>
									<option value="3">칭찬접수</option>
									<option value="4">기타</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">진행상태</th>
							<td colspan="3" style="height:27px;">
								<div class="option_ul" >
									<ul >
										<li style="margin-left:5px;"><input type="radio" id="statusA" class="type1" value="" name="questionStatus" checked="checked" /><label for="statusA">전체</label></li>
										<li><input type="radio" id="statusP" class="type1" value="P" name="question" /><label for="questionStatus">처리중</label></li>
										<li><input type="radio" id="statusC" class="type1" value="C" name="question" /><label for="questionStatus">답변완료</label></li>
									</ul>
								</div>
							</td>
							
						</tr>
					</tbody>
				</table>
				</div>
			</form>
		</div>
		<div class="btn_area marB35" >
					<div class="center">
						<a id="btn_Search" class="btn_blue_line2" href="javascript:" >검색</a>
					</div>
					<div class="left" style="line-height:40px;">
						<a class="btn_type2 btn_icon5" id="btnExcel" style="margin-left:0px;"  href="javascript:;" >엑셀다운로드</a>
					</div>
					<div class="right" style="line-height:40px;">
<!-- 							<a id="registBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;">등록</a> -->
						<a class="delBtn btn_type2" style="margin-left:0px;" href="javascript:;">삭제</a>
					</div>
						<a id="modifyBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;" style="display:none;"></a>
				</div>

		<div class="grid_type1">
			<div id="jqxgrid"></div>
		</div>
	</div>
</body>