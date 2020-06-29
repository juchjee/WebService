<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 게시판관리 : inus소식관리 -->

<script type="text/javaScript" defer="defer">
	var contUrl = "${rootUri}${conUrl}bbt00008";

	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅 - 선택, 제품명, 판매가, 할인가, 쿠폰, 적립금, 재고, 판매상태, PC노출, 모바일노출, 과세, 등록일, 관리
	 *----------------------------------------------------------------------------------------------*/
	var _columns = [

  	     { text: '선택', datafield: 'chk', width: '5%', cellclassname: cellclass, columntype: 'checkbox',sortable: false ,cellsalign: 'center', align: 'center'}
		,{ text:'번호', datafield: 'num', width: '5%',  cellsalign: 'center', align: 'center'}
		,{ text: '분류', datafield: 'boardCateNm',  width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '제목', datafield: 'boardTitle',  width: '45%', cellsalign: 'left', align: 'center'}
		,{ text: '등록일', datafield: 'regDt', cellsformat: 'yyyy-MM-dd',  width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '작성자', datafield: 'regId',  width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '조회수', datafield: 'boardHit',  width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '수정', datafield: 'popButton', width: '5%', cellsalign: 'center', align: 'center',
			columntype: 'button', cellsrenderer: function () {
                return "수정";
             }, buttonclick: function (row) {
                var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', row);
					$.fancybox.open({
						href: "bbt00008R.action?boardMstCd=${boardMstCd}&boardSeq="+ dataRecord.boardSeq,
						type: "iframe",
						maxWidth	: 1920,
						maxHeight	: 1100,
						width		: 1000,
						height 	    : 740,
						autoSize	: false,
						beforeClose : function(){
					    	fnSearch();
						}
					});
            }
		}
		,{ text: '시퀀스', datafield: 'boardSeq',hidden: true}
		];

	var _datafields = [
	     { name: 'chk',    type: 'boolean', value: 'false'}
		,{ name: 'num', type: 'string'}
		,{ name: 'boardCateNm', type: 'string'}
		,{ name: 'boardTitle', type: 'string'}
		,{ name: 'regId', type: 'string'}
		,{ name: 'regDt', type: 'date'}
		,{ name: 'boardHit', type: 'string'}
		,{ name: 'boardSeq', type: 'string'}
	];

	function fnSearchInit(){
		dateTimeInput("txtFromDt", null, "");
		dateTimeInput("txtToDt", null, "");
		fnGridOption('jqxgrid',{
			height:320
	       ,columns: _columns
	       ,selectionmode: 'multiplecellsextended'
	    });
	}

	function fnSearch(){
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + ".action",
	        data: {boardMstCd: '${boardMstCd}',
	        	   boardCateSeq: $("#boardCateSeq").val(),
	        	   searchType:$("#searchType").val(),
	        	   searchTxt:$("#searchTxt").val(),
	        	   txtFromDt:$("#txtFromDt").val(),
            	   txtToDt:$("#txtToDt").val()
	        	   }
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

		$("#registBtn").click(function(){
			$("#registBtn").attr("href","bbt00008R.action?boardMstCd=${boardMstCd}");
		});

		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid','inus소식');
		});

		$("#jqxgrid").on('celldoubleclick', function (event)
				{
					if(event.args.datafield != 'chk'){
		  		    var args = event.args;
		  		    var rowBoundIndex = args.rowindex;
					var datarow = $('#jqxgrid').jqxGrid('getrowdata', rowBoundIndex);
					$("#boardSeq").val(datarow.boardSeq);
						setTimeout(function(){
							$("#modifyBtn").attr("href","bbt00008R.action?boardMstCd=${boardMstCd}&boardSeq="+datarow.boardSeq);
							$("#modifyBtn").click();
						},200);
					}
				});

	

		$(".delBtn").click(function(){
			var rows = $('#jqxgrid').jqxGrid('getrows');

			$.paramData = new Object();


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
			maxWidth	: 1920,
			maxHeight	: 1100,
			width		: 1000,
			autoSize	: true
		});

	}

</script>
</head>
<body>
<input name='chkAll' type='checkbox' style="display:none"/>
<div class="pageContScroll_st2">
	<div class="top_box">
		<form id="workForm" name="workForm" action="bbt00008R.do?boardMstCd=${boardMstCd}" method="post">
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
							<th scope="row">분류</th>
							<td>
								<select id="boardCateSeq" name="boardCateSeq" style="width:100px;">
									<option value="">분류전체</option>
									<c:forEach items="${cateList}" var="cateList">
										<option value="${cateList.boardCateSeq}" >${cateList.boardCateNm}</option>
									</c:forEach>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">텍스트검색</th>
							<td colspan="3">
								<select id="searchType" style="width:100px;">
									<option value="1">제목</option>
									<option value="2">내용</option>
									<option value="3">제목+내용</option>
								</select>
								<input type="text" id="searchTxt" class="marL10" style="width:145px;" />
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
						<a id="registBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;">등록</a>
						<a class="delBtn btn_type2" style="margin-left:0px;" href="javascript:;">삭제</a>
					</div>
						<a id="modifyBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;" style="display:none;"></a>
				</div>

	<div class="grid_type1">
		<div id="jqxgrid"></div>
	</div>
</div>
</body>