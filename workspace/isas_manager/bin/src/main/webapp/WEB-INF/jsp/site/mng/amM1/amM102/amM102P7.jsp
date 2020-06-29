<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

	var contUrl = "${rootUri}${conUrl}amM1027";

	function init(){

		var obj = $(".gnb > ul >li > a")[6];
		$(obj).addClass("on");

		fnSearchInit();
		fnSearch();
		fnEvent();
		fnDataSetting();
	}

	var _columns = [
		{ text: '분류', datafield: 'boardCateNm', cellclassname: cellclass, width: '10%', cellsalign: 'left', align: 'center'}
   		,{ text: '상품명', datafield: 'prodNm', cellclassname: cellclass, width: '20%', cellsalign: 'left', align: 'center'}
   		,{ text: '제목', datafield: 'boardTitle', cellclassname: cellclass, width: '35%', cellsalign: 'left', align: 'center'}
   		,{ text: '답변', datafield: 'boardState', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
   		,{ text: '작성자', datafield: 'regId', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
   		,{ text: '등록일', datafield: 'regDt', cellsformat: 'yyyy-MM-dd', cellclassname: cellclass, width: '15%', cellsalign: 'center', align: 'center'}
   		,{ text: '순', datafield: 'boardSeq', hidden:true , cellclassname: cellclass, cellsalign: 'center', align: 'center'}
   	];

   	var _datafields = [
   		{ name: 'boardCateNm', type: 'string'}
   		,{ name: 'prodNm', type: 'string'}
   		,{ name: 'boardTitle', type: 'string'}
   		,{ name: 'boardState', type: 'string'}
   		,{ name: 'regId', type: 'string'}
   		,{ name: 'regDt', type: 'date'}
   		,{ name: 'boardSeq', type: 'string'}
    ]

	function fnSearchInit(){
   		dateTimeInput("txtFromDt");
		dateTimeInput("txtToDt");
		fnGridOption('jqxgrid',{
			height:365
	       ,columns: _columns
	       ,selectionmode: 'singlerow'
	    });
	}

	function fnSearch(){
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + ".action",
	        data: {mbrId : '${mbrId}', mbrNm : '${mbrNm}',
	        	   stateYn:$("input:radio[name='stateYn']:checked").val(),
	        	   txtFromDt:$("#txtFromDt").val(),
            	   txtToDt:$("#txtToDt").val(),
            	   boardCateSeq: $("#boardCateSeq").val(),
            	   searchType:$("#searchType").val(),
	        	   searchTxt:$("#searchTxt").val(),
	       		  }
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		fnAjax(	"amM1027Cnt.action",
				{ mbrId : '${mbrId}', mbrNm : '${mbrNm}' },
				function(data, dataType){
					$("#totCnt").text("총 상담건수 : "+data.totCnt+" 건");
					$("#miCnt").text("미처리 : "+data.miCnt+" 건");
				},'POST','json');
		return false;
	}

	function fnEvent(){
		$("input:radio[name='stateYn']").on('change', fnSearch);
		$("#boardCateSeq").on('change', fnSearch);
		$("#btn_Search").on('click', fnSearch);

		$("#jqxgrid").on('rowdoubleclick', function (event)
		{
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			var datarow = $('#jqxgrid').jqxGrid('getrowdata', rowindex);
			$("#boardSeq").val(datarow.boardSeq);

			$.fancybox.open({
				href: "/mng/bbt/bbt00002R.action?boardMstCd=BBM00006&boardSeq="+datarow.boardSeq,
				type: "iframe",
				maxWidth	: 1920,
				maxHeight	: 1100,
				width		: 1000,
				height		: 680,
				modal : false,
				autoSize	: true
			});
		});
	}

	function fnDataSetting(){
		$("input[name=stateYn]").eq(0).attr("checked",true);
	}

</script>

	<div class="member_detail_con">
		<h2>제품문의</h2>
		<div class="member_detail_info">
			<ul>
				<li>
					<dl>
						<dt>회원이름</dt>
						<dd><span>${mbrNm} (${mbrId})</span></dd>
					</dl>
				</li>
			</ul>
		</div>
		<!-- // -->
		<div class="top_box">
			<div class="table_type">
				<table>
					<colgroup>
						<col style="width:135px;" />
						<col style="width:350px;" />
						<col style="width:135px;" />
						<col style="width:*" />
					</colgroup>
					<tr>
						<th>상태선택</th>
						<td>
							<input type="radio" name="stateYn" value="" id="answer3" class="marR5" /><label for="answer1">전체</label>
							<input type="radio" name="stateYn" value="Y" id="answer1" class="marR5" /><label for="answer1">답변완료</label>
							<input type="radio" name="stateYn" value="N" id="answer2" class="marR5" /><label for="answer2">답변대기</label>
						</td>
						<th>문의기간</th>
						<td>
							<div id='txtFromDt' name="txtFromDt" style='float:left;'></div>
							<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
							<div id='txtToDt' name="txtToDt"  style='float:left;'></div>
						</td>
					</tr>
					<tr>
						<th>분류선택</th>
						<td>
							<select id="boardCateSeq" name="boardCateSeq" style="width:100px;">
								<option value="">전체</option>
								<c:forEach items="${cateList}" var="cateList">
									<option value="${cateList.boardCateSeq}" >${cateList.boardCateNm}</option>
								</c:forEach>
							</select>
						</td>
						<th>키워드</th>
						<td>
							<select id="searchType" style="width:100px;">
								<option value="1">제목</option>
								<option value="2">내용</option>
								<option value="3">제목+내용</option>
							</select>
							<input type="text" id="searchTxt" class="marL10" style="width:182px;" />
						</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- // top_box -->
		<div class="btn_area marB20">
			<div class="center">
				<a id="btn_Search" class="btn_blue_line" href="#">검색</a>
			</div>
		</div>
		<div class="align_area">
			<div class="left">
				<span id="totCnt"></span>
			</div>
			<div class="right">
				<span id="miCnt"></span>
			</div>
		</div>
		<!-- // align_area -->

		<div class="grid_type1">
			<div id="jqxgrid">
			</div>
		</div>

	</div>
