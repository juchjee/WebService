<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">

	var contUrl = "${rootUri}${conUrl}/mng/amM1/amM102/amM1029";

	function init(){
		// 선택된 topmenu 적용
		var obj = $(".gnb > ul >li > a")[2];
		$(obj).addClass("on");

		fnSearchInit();
		fnSearch();
		fnEvent();
	}

   	var _columns = [
   		{ text: '문의구분', datafield: 'questionTp', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
   		{ text: '제품', datafield: 'boardCateNm', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
   		{ text: '제목', datafield: 'boardTitle', cellclassname: cellclass, width: '30%', cellsalign: 'left', align: 'center'},
   		{ text: '작성자', datafield: 'regId', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
   		{ text: '등록일', datafield: 'regDt', cellsformat: 'yyyy-MM-dd', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
   		{ text: '답변자', datafield: 'repId', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
   		{ text: '진행상태', datafield: 'boardState', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
   		{ text: '답변', datafield: 'boardSeq', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center',
			columntype: 'button', cellsrenderer: function (row) {
                return '답변등록';
            } , buttonclick: function (row) {
	            	var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
	    			var datarow = $('#jqxgrid').jqxGrid('getrowdata', rowindex);
	    			setTimeout(function(){
	    				$("#fancyBtn").attr("href","/mng/bbt/bbt00006R.action?boardMstCd=BBM00007&boardSeq="+datarow.boardSeq);
	    				$("#fancyBtn").click();
	    			},200);
            } 
		}
   	];

   	var _datafields = [
   		{ name: 'questionTp', type: 'string'}
   		,{ name: 'boardCateNm', type: 'string'}
   		,{ name: 'boardTitle', type: 'string'}
   		,{ name: 'regId', type: 'date'}
   		,{ name: 'regDt', type: 'string'}
   		,{ name: 'repId', type: 'string'}
   		,{ name: 'boardState', type: 'string'}
   		,{ name: 'boardSeq', type: 'string'}
   	];

   	function fnSearchInit(){
   		dateTimeInput("txtFromDt");
		dateTimeInput("txtToDt");
		fnGridOption('jqxgrid',{
			height:365
	       ,columns: _columns
	       ,autorowheight: true
	       ,selectionmode: 'singlerow'
	    });
	}
   	

	function fnSearch(){
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + ".action",
	        data: {mbrId : '${mbrId}', 
	        	   mbrNm : '${mbrNm}',
	        	   searchType:$("#searchType").val(),
	        	   searchTxt:$("#searchTxt").val(),
	        	   txtFromDt:$("#txtFromDt").val(),
	        	   txtToDt:$("#txtToDt").val(),
	        	   searchType2:$("#searchType2").val(),
	        	   searchType3:$("[name=searchType3]:checked").val(),
	        	   searchType4:$("#searchType4").val(),
	        	   searchType5:$("#searchType4").val()
	        }
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		fnAjax(	"amM1029Cnt.action",
				{ mbrId : '${mbrId}', mbrNm : '${mbrNm}' },
				function(data, dataType){
					$("#totCnt").text("총 상담건수 : "+data.totCnt+" 건");
					$("#miCnt").text("미처리 : "+data.miCnt+" 건");
				},'POST','json');
		return false;
	}

	function fnEvent(){
		
		$('#searchTxt').bind('keyup',function(e){
			if(e.keyCode == 13){
				fnSearch();
			}
		});
		
		$("#btn_Search").on('click', fnSearch);

  		$("#jqxgrid").on('rowdoubleclick', function (event)
		{
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			var datarow = $('#jqxgrid').jqxGrid('getrowdata', rowindex);

			setTimeout(function(){
				$("#fancyBtn").attr("href","/mng/bbt/bbt00006V.do?boardMstCd=BBM00007&boardSeq="+datarow.boardSeq);
				$("#fancyBtn").click();
			},200);
		});

  		$("#fancyBtn").fancybox({
			type: "iframe",
			maxWidth	: 1200,
			maxHeight	: 900,
			width		: 1200,
			height		: 900,
			modal : false,
			autoSize	: false
		});
	}

</script>

	<div class="member_detail_con">
		<h2>1:1문의</h2>
		<div class="member_detail_info">
			<ul>
				<li>
					<dl>
						<dt>회원이름</dt>
						<dd><span>${userInfo.mbrNm}</span></dd>
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
						<th>검색</th>
						<td>
							<select id="searchType" name="searchType" style="width:100px;">
								<option value="1">제목</option>
								<option value="2">내용</option>
								<option value="3">제목+내용</option>
							</select>
							<input type="text" id="searchTxt" name="searchTxt" class="marL10" style="width:182px;" />
						</td>
						<th>등록일</th>
						<td>
							<div id='txtFromDt' name="txtFromDt" value="${nowYmd}" style='float:left;'></div>
							<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
							<div id='txtToDt' name="txtToDt" value="${nowYmd}" style='float:left;'></div>
						</td>
					</tr>
					<tr>
						<th>문의구분</th>
						<td>
							<select id="searchType2" name="searchType2" style="width:100px;">
								<option value="" selected="selected">전체</option>
								<option value="1">A/S신청</option>
								<option value="2">제품문의</option>
								<option value="3">칭찬접수</option>
								<option value="4">기타</option>
							</select>
						</td>
						<th>진행상태</th>
						<td>
							<input type="radio" id="searchType3_1" name="searchType3" value="1" checked="checked"><i></i>
							<label for="searchType3_1">답변완료</label>
							<input type="radio" id="searchType3_2" name="searchType3" value="2"><i></i>
							<label for="searchType3_2">처리중</label>
						</td>
					</tr>
					<tr>
						<th>제품</th>
						<td colspan="3">
							<select id="searchType4" name="searchType4" style="width:100px;">
								<option value="">전체</option>
								<c:forEach items="${cateList}" var="cateList" varStatus="loop">
									<option value="${cateList.boardCateSeq}">${cateList.boardCateNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</table>
			</div>
		</div>
		<!-- // top_box -->
		<div class="btn_area marB20">
		<div class="left" style="margin-top:20px;">
				<span id="totCnt"></span>
			</div>
			<div class="center">
				<a id="btn_Search" class="btn_blue_line" href="#">검색</a>
			</div>

			<div class="right" style="margin-top:20px;">
				<span id="miCnt"></span>
			</div>
		</div>

		<a id="fancyBtn"  class="btn_type2" data-fancybox-type="iframe"  href="javascript:;"></a>
		<div class="grid_type1">
			<div id="jqxgrid">
			</div>
		</div>

	</div>

