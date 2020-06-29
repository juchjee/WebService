<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 게시판관리 : 제품후기관리 -->

<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}bbt00003";

	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
		fnDataSetting();
	}

	function fnPhotoView(val){
		if(val != ''){
		    $.fancybox.open({
				href		: val,
				type		: "image",
				maxWidth	: 450,
				maxHeight	: 330,
				width		: 500,
				height		: 330,
				autoSize	: false,
				modal 		: false,
			    afterLoad	: function(data){
				    //alert(data);
			    }
			});
		}
	}
	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅 - 선택, 제품명, 판매가, 할인가, 쿠폰, 적립금, 재고, 판매상태, PC노출, 모바일노출, 과세, 등록일, 관리
	 *----------------------------------------------------------------------------------------------*/
	<c:if test="${prodCnt!=0}">
	var _columns = [
		{ text: '선택', datafield: 'chk', width: '3%', cellclassname: cellclass, columntype: 'checkbox',sortable: false ,cellsalign: 'center', align: 'center'}
		,{ text: '시퀀스', datafield: 'boardSeq', width: '5%', cellclassname: cellclass, cellsalign: 'center', align: 'center'}
		,{ text: '분류', datafield: 'boardCateNm', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '상품명', datafield: 'prodNm', cellclassname: cellclass, width: '17%', cellsalign: 'left', align: 'center'}
		,{ text: '제목', datafield: 'boardTitle', cellclassname: cellclass, width: '30%', cellsalign: 'left', align: 'center',
  			cellsrenderer: function (row, column, value) {
                var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', row);
  				if(dataRecord.attchFilePath != ''){
  					value = "<a style='cursor: pointer' onclick='fnPhotoView(\"" + dataRecord.attchFilePath + "\")'>" + value + " <img src='/images/icon/camera.jpg' style='width: 17px;'/></a>";
  				}else{
  					value = value;
  				}
  				return "<div class='jqx-grid-cell-left-align' style='margin-top: 11.5px;'>" + value + "</div>";
  	        }
  		}
		,{ text: '답변', datafield: 'boardState', cellclassname: cellclass, width: '7%', cellsalign: 'center', align: 'center'}
		,{ text: '별점', datafield: 'prodGrade', cellclassname: cellclass, width: '8%', cellsalign: 'center', align: 'center',
			cellsrenderer: function (row, column, value) {
				var returnValue = "";
  				if(value == 5){
  					returnValue = "<div class='star_wrap'><span class=\"star5\"><em>만족도</em></span></div>";
  				}else if(value == 4){
  					returnValue = "<div class='star_wrap'><span class=\"star4\"><em>만족도</em></span></div>";
  				}else if(value == 3){
  					returnValue = "<div class='star_wrap'><span class=\"star3\"><em>만족도</em></span></div>";
  				}else if(value == 2){
  					returnValue = "<div class='star_wrap'><span class=\"star2\"><em>만족도</em></span></div>";
  				}else if(value == 1){
  					returnValue = "<div class='star_wrap'><span class=\"star1\"><em>만족도</em></span></div>";
  				}

  				return returnValue;
	        }
		}
		,{ text: '작성자', datafield: 'regId', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '등록일', datafield: 'regDt', cellsformat: 'yyyy-MM-dd', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		];

	var _datafields = [
	         { name: 'chk',    type: 'boolean', value: 'false'}
			,{ name: 'boardSeq', type: 'string'}
     		,{ name: 'boardCateNm', type: 'string'}
     		,{ name: 'prodNm', type: 'string'}
     		,{ name: 'boardTitle', type: 'string'}
     		,{ name: 'boardState', type: 'string'}
     		,{ name: 'prodGrade', type: 'number'}
     		,{ name: 'regId', type: 'string'}
     		,{ name: 'regDt', type: 'date'}
     		,{ name: 'attchFilePath', type: 'string'}
     	];
	</c:if>
	<c:if test="${prodCnt==0}">
	var _columns = [
		{ text: '선택', datafield: 'chk', width: '5%', cellclassname: cellclass, columntype: 'checkbox',sortable: false ,cellsalign: 'center', align: 'center'}
		,{ text: '시퀀스', datafield: 'boardSeq', width: '5%' , cellclassname: cellclass, cellsalign: 'center', align: 'center'}
  		,{ text: '분류', datafield: 'boardCateNm', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
  		,{ text: '제목', datafield: 'boardTitle', cellclassname: cellclass, width: '40%', cellsalign: 'left', align: 'center',
  			cellsrenderer: function (row, column, value) {
                var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', row);
  				if(dataRecord.attchFilePath != ''){
  					value = "<a style='cursor: pointer' onclick='fnPhotoView(\"" + dataRecord.attchFilePath + "\")'>" + value + " <img src='/images/icon/camera.jpg' style='width: 17px;'/></a>";
  				}else{
  					value = value;
  				}
  				return "<div class='jqx-grid-cell-left-align' style='margin-top: 11.5px;'>" + value + "</div>";
  	        }
  		}
  		,{ text: '답변', datafield: 'boardState', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
  		,{ text: '별점', datafield: 'prodGrade', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center',
  			cellsrenderer: function (row, column, value) {
  				var returnValue = "";
  				if(value == 5){
  					returnValue = "<div class='star_wrap'><span class=\"star5\"><em>만족도</em></span></div>";
  				}else if(value == 4){
  					returnValue = "<div class='star_wrap'><span class=\"star4\"><em>만족도</em></span></div>";
  				}else if(value == 3){
  					returnValue = "<div class='star_wrap'><span class=\"star3\"><em>만족도</em></span></div>";
  				}else if(value == 2){
  					returnValue = "<div class='star_wrap'><span class=\"star2\"><em>만족도</em></span></div>";
  				}else if(value == 1){
  					returnValue = "<div class='star_wrap'><span class=\"star1\"><em>만족도</em></span></div>";
  				}


  				return returnValue;
  	        }
  		}
  		,{ text: '작성자', datafield: 'regId', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
  		,{ text: '등록일', datafield: 'regDt', cellsformat: 'yyyy-MM-dd', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
  		];

	var _datafields = [
	         { name: 'chk',    type: 'boolean', value: 'false'}
			,{ name: 'boardSeq', type: 'string'}
       		,{ name: 'boardCateNm', type: 'string'}
       		,{ name: 'boardTitle', type: 'string'}
       		,{ name: 'boardState', type: 'string'}
       		,{ name: 'prodGrade', type: 'number'}
       		,{ name: 'regId', type: 'string'}
       		,{ name: 'regDt', type: 'date'}
     		,{ name: 'attchFilePath', type: 'string'}
       	];
	</c:if>

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
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + ".action",
	        data: {boardMstCd: '${boardMstCd}',
	        	   boardCateSeq: $("#boardCateSeq").val(),
	        	   searchType:$("#searchType").val(),
	        	   searchTxt:$("#searchTxt").val(),
	        	   stateYn:$("input:radio[name='stateYn']:checked").val(),
	        	   photoKind:$("input:radio[name='photoKind']:checked").val(),
	        	   txtFromDt:$("#txtFromDt").val(),
	        	   prodCd:$("#prodCd").val(),
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
							$("#modifyBtn").attr("href","bbt00003R.action?boardMstCd=${boardMstCd}&boardSeq="+datarow.boardSeq);
							$("#modifyBtn").click();
						},200);
			}
		});

		$("#registBtn").click(function(){
			$("#registBtn").attr("href","bbt00003R.action?boardMstCd=${boardMstCd}");
		});

		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid','제품후기');
		});



		$(".delBtn").click(function(){

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
				fnAjax("bbt00003D.action",  {"data":$.paramData}, function(data, dataType){
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
			autoSize	: false,
			beforeClose : function(){
		    	fnSearch();
			}
		});

	}

	function fnDataSetting(){
		$("input[name=stateYn]").eq(0).attr("checked",true);
		$("input[name=photoKind]").eq(0).attr("checked",true);
	}

</script>
</head>
<body>
	<input name='chkAll' type='checkbox' style="display:none"/>
	<div class="pageContScroll_st2">
		<div class="top_box">
			<form id="workForm" name="workForm" action="bbt00003R.do?boardMstCd=${boardMstCd}" method="post">
			<input type="hidden" id="boardSeq" name="boardSeq" />
			<div class="table_type">
				<table>
					<caption>답변상태, 상품등록일, 분류, 키워드검색으로 구성된 제품후기목록에 대한 검색 테이블입니다.</caption>
					<colgroup>
						<col style="width:135px;" />
						<col style="width:350px;" />
						<col style="width:135px;" />
						<col style="width:350px;" />
						<col style="width:135px;" />
						<col style="width:*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">답변</th>
							<td>
								<div class="fl" style="margin:2px 5px 2px 0;">
									<input type="radio" name="stateYn" value="" id="answer3" class="marR5" /><label for="answer1">전체</label>&nbsp;&nbsp;
								</div>
								<div class="fl" style="margin:2px 5px 2px 0;">
									<input type="radio" name="stateYn" value="Y" id="answer1" class="marR5" /><label for="answer1">답변완료</label>&nbsp;&nbsp;
								</div>
								<div class="fl" style="margin:2px 5px 2px 0;">
									<input type="radio" name="stateYn" value="N" id="answer2" class="marR5" /><label for="answer2">답변대기</label>
								</div>
							</td>
							<th scope="row">등록일</th>
							<td>
								<div class="fl" style="margin:2px 5px 2px 0;">
									<div id='txtFromDt'></div>
								</div>
								<div class="fl" style="margin:2px 5px 2px 0;">
									<div style='line-height:28px;'>&nbsp;~&nbsp;</div>
								</div>
								<div class="fl" style="margin:2px 5px 2px 0;">
									<div id='txtToDt'  ></div>
								</div>
							</td>
							<th scope="row">분류</th>
							<td>
								<div class="fl" style="margin:2px 5px 2px 0;">
									<input type="radio" name="photoKind" value="" id="photoKind1" class="marR5" /><label for="photoKind1">전체</label>&nbsp;&nbsp;
								</div>
								<div class="fl" style="margin:2px 5px 2px 0;">
									<input type="radio" name="photoKind" value="P" id="photoKind2" class="marR5" /><label for="photoKind2">포토</label>&nbsp;&nbsp;
								</div>
								<div class="fl" style="margin:2px 5px 2px 0;">
									<input type="radio" name="photoKind" value="T" id="photoKind3" class="marR5" /><label for="photoKind3">텍스트</label>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">제품</th>
							<td>
								<select id="prodCd" name="prodCd" style="width:200px;">
									<option value="">제품전체</option>
								<c:forEach items="${prodList}" var="prodList">
									<option value="${prodList.prodCd}" >${prodList.prodNm}</option>
								</c:forEach>
							</select>
							</td>
							<th scope="row">텍스트검색</th>
							<td>
								<select id="searchType" style="width:100px;">
									<option value="1">제목</option>
									<option value="2">내용</option>
									<option value="3">제목+내용</option>
									<option value="4">작성자</option>
								</select>
								<input type="text" id="searchTxt" class="marL10" style="width:145px;" />
							</td>
							<th scope="row"></th>
							<td>
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
				<a class="delBtn btn_type2" style="margin-left:0px;" href="javascript:;">삭제</a>
			</div>
				<a id="modifyBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;" style="display:none;"></a>
		</div>

		<div class="grid_type1">
			<div id="jqxgrid">
			</div>
		</div>
	</div>

</body>