<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 게시판관리 : 공지사항 -->

<script type="text/javaScript" defer="defer">
	var contUrl = "${rootUri}${conUrl}tserviceL";

	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅 - 선택, 제품명, 판매가, 할인가, 쿠폰, 적립금, 재고, 판매상태, PC노출, 모바일노출, 과세, 등록일, 관리
	 *----------------------------------------------------------------------------------------------*/
	var _columns = [
	     { text: '선택', datafield: 'chk', width: '5%',  columntype: 'checkbox',sortable: false ,cellsalign: 'center', align: 'center'}
		,{ text: '번호', datafield: 'num',  width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '신청번호', datafield: 'asTempNo',  width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '접수번호', datafield: 'asNo',  width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '고객번호', datafield: 'csNo',  width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '고객명', datafield: 'tNm',  width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '연락가능번호', datafield: 'tHp',  width: '8%', cellsalign: 'center', align: 'center'}
		,{ text: '진행상태', datafield: 'status',  width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '당일신청횟수', datafield: 'asDayCount',  width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '등록일', datafield: 'regDt',  width: '8%', cellsalign: 'center', align: 'center'}
		,{ text: '예약일자', datafield: 'bookingDt',  width: '8%', cellsalign: 'center', align: 'center'}
		,{ text: '제품', datafield: 'prodNm',  width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '모델', datafield: 'modelNm',  width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '고장증상', datafield: 'ascodeNm',  width: '20%', cellsalign: 'left', align: 'center'}
		,{ text: '회원구분', datafield: 'csTp',  width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '주소', datafield: 'tAddrNm',  width: '20%', cellsalign: 'left', align: 'center'}
		,{ text: '수정', datafield: 'popButton', width: '5%', cellsalign: 'center', align: 'center',
			columntype: 'button', cellsrenderer: function () {
                return "수정";
             }, buttonclick: function (row) {
                var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', row);
					$.fancybox.open({
						href: "tserviceR.action?asTempNo="+ dataRecord.asTempNo,
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
		];

	var _datafields = [
	     { name: 'chk',    type: 'boolean', value: 'false'}
		,{ name: 'num', type: 'string'}
		,{ name: 'asTempNo', type: 'string'}
		,{ name: 'asNo', type: 'string'}
		,{ name: 'csNo', type: 'string'}
		,{ name: 'tNm', type: 'string'}
		,{ name: 'tHp', type: 'string'}
		,{ name: 'status', type: 'string'}
		,{ name: 'asDayCount', type: 'string'}
		,{ name: 'regDt', type: 'string'}
		,{ name: 'bookingDt', type: 'string'}
		,{ name: 'prodNm', type: 'string'}
		,{ name: 'modelNm', type: 'string'}
		,{ name: 'ascodeNm', type: 'string'}
		,{ name: 'csTp', type: 'string'}
		,{ name: 'tAddrNm', type: 'string'}
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
            data: {statBc: $("#statBc").val(),
         	   searchType:$("#searchType").val(),
         	   searchTxt:$("#searchTxt").val(),
         	   txtFromDt:$("#txtFromDt").val(),
         	   modelItemCd:$("#modelItemCd").val(),
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

		$("#btn_Search").on('click', fnSearch);


		$("#jqxgrid").on('celldoubleclick', function (event)
				{
					if(event.args.datafield != 'chk'){
		  		    var args = event.args;
		  		    var rowBoundIndex = args.rowindex;
					var datarow = $('#jqxgrid').jqxGrid('getrowdata', rowBoundIndex);
						setTimeout(function(){
							$("#modifyBtn").attr("href","tserviceR.action?asTempNo="+datarow.asTempNo);
							$("#modifyBtn").click();
						},200);
					}
				});


		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid','공지사항목록');
		});

		$(".delBtn").click(function(){
			var rows = $('#jqxgrid').jqxGrid('getrows');

			$.paramData = new Object();

			var j = 0;
			for(var i = 0; i < rows.length; i++){
				var row = rows[i];
				if(row.chk == true){
// 					$.paramData[j] =  row.boardSeq;
					$.paramData[j] =  row.asTempNo; //20190312 ryul 수정
					j++;
				}
			}
			if(j == 0){
				alert("삭제할 게시글을 선택해주세요.");
				return false;
			}

			if(confirm("삭제하시겠습니까?")){
// 				fnAjax("bbt00002D.action",  {"data":$.paramData}, function(data, dataType){
// 					var data = data.replace(/\s/gi,'');
// 					alert(data);
// 					$('#jqxgrid').jqxGrid('clearselection');
// 					fnSearch();
// 				},'POST','text');
				//20190313 ryul 수정
				fnAjax("csAdmCancel.action",  {"data":$.paramData}, function(data, dataType){
					var data = data.replace(/\s/gi,'');
					$('#jqxgrid').jqxGrid('clearselection');
					fnSearch();
				},'POST','text');
			}
		});

		$("#registBtn,#modifyBtn").fancybox({
			maxWidth	: 1920,
			maxHeight	: 1100,
			width		: 1000,
			autoSize	: true,
			beforeClose : function(){
		    	fnSearch();
			}
		});

	}

</script>
</head>
<body>
	<input name='chkAll' type='checkbox' style="display:none"/>
	<div class="pageContScroll_st2">
		<div class="top_box">
			<form id="workForm" name="workForm"  method="post">
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
								<select id="modelItemCd" name="modelItemCd" style="width:100px;">
									<option value="">제품전체</option>
									<option value="0">비데</option>
									<option value="1">위생도기</option>
									<option value="2">수전</option>
									<option value="3">비데블렌더</option>
									<option value="4">이누스바스</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">텍스트검색</th>
							<td>
								<select id="searchType" style="width:100px;">
									<option value="1">성명</option>
									<option value="2">휴대폰번호</option>
									<option value="3">주소</option>
								</select>
								<input type="text" id="searchTxt" class="marL10" style="width:145px;" />
							</td>
							<th scope="row">진행상태</th>
							<td>
								<select id="statBc" name="statBc" style="width:100px;">
									<option value="" >전체</option>
									<option value="0" selected="selected">처리대기</option>
									<option value="AS204100">접수</option>
									<option value="AS204200">수리진행</option>
									<option value="AS204300">수리완료</option>
									<option value="AS204400">정산</option>
									<option value="AS204800">상담처리</option>
									<option value="AS204900">취소</option>
								</select>
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
					<!-- 20190313 ryul 담당자 취소에서 삭제로 변경 (기능적으로 삭제가 맞음) - 송규희 대리님과 협의 -->
<!-- 						<a class="delBtn btn_type2" style="margin-left:0px;" href="javascript:;">담당자 취소</a> -->
						<a class="delBtn btn_type2" style="margin-left:0px;" href="javascript:;">삭제</a>
					</div>
						<a id="modifyBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;" style="display:none;"></a>
				</div>
<!-- 		<div class="align_area"> -->
<!-- 			<div class="left"> -->
<!-- 				<a class="btn_type2 btn_icon5" id="btnExcel" style="margin-left:0px;"  href="javascript:;" >엑셀다운로드</a> -->
<!-- 			</div> -->
<!-- 			<div class="center"> -->
<!-- 				<a class="btn_blue_line" id="btn_Search" href="#">검색</a> -->
<!-- 			</div> -->
<!-- 			<div class="right"> -->
<!-- 				<a id="registBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;">등록</a> -->
<!-- 				<a id="modifyBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;" style="display:none;"></a> -->
<!-- 				<a class="delBtn btn_type2" href="javascript:;">삭제</a> -->
<!-- 			</div> -->
<!-- 		</div> -->

		<div class="grid_type1">
			<div id="jqxgrid"></div>
		</div>

	</div>

</body>