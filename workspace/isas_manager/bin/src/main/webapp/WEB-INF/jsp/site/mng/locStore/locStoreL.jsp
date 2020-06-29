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
	var contUrl = "${rootUri}${conUrl}locStoreL";

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
	     { text: '선택', datafield: 'chk', width: '5%', cellclassname: cellclass, columntype: 'checkbox',sortable: false ,cellsalign: 'center', align: 'center'}
	    ,{ text: '매장코드', datafield: 'mapStoreId', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '관할지역', datafield: 'zcAddress', cellclassname: cellclass, width: '20%', cellsalign: 'center', align: 'center'}
		,{ text: '매장명', datafield: 'mapStoreTitle', cellclassname: cellclass, width: '10%', cellsalign: 'left', align: 'center'}
		,{ text: '주소', datafield: 'mapStoreAddr', cellclassname: cellclass, <c:choose><c:when test="${fn:length(cateList) > 1}">width: '20%'</c:when><c:otherwise>width: '40%'</c:otherwise></c:choose>, cellsalign: 'center', align: 'center'}
		,{ text: '취급품목', datafield: 'mapStoreItem', cellclassname: cellclass, width: '20%', cellsalign: 'center', align: 'center' <c:if test="${fn:length(cateList) == 1}">,hidden: true</c:if>}
		,{ text: '전화번호', datafield: 'mapStorePhone', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '수정', datafield: 'popButton', width: '5%', cellsalign: 'center', align: 'center',
			columntype: 'button', cellsrenderer: function () {
                return "수정";
             }, buttonclick: function (row) {
                var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', row);
					$.fancybox.open({
						href: "locStoreS.action?boardMstCd=${boardMstCd}&mapStoreId="+ dataRecord.mapStoreId,
						type: "iframe",
						maxWidth	: 1920,
						maxHeight	: 1100,
						width		: 1000,
						height 	    : 670,
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
	    ,{ name: 'mapStoreId', type: 'string'}
		,{ name: 'mapStoreItem', type: 'string'}
		,{ name: 'mapStoreTitle', type: 'string'}
		,{ name: 'mapStoreAddr', type: 'string'}
		,{ name: 'mapStorePhone', type: 'string'}
		,{ name: 'zcAddress', type: 'string'}
	];

	function fnSearchInit(){
		fnGridOption('jqxgrid',{
			height:320
	       ,columns: _columns
	       ,selectionmode: 'multiplecellsextended'
	    });
	}

	function fnSearch(){
		var params = $("#workForm").serialize()
		var dataAdapter = new $.jqx.dataAdapter({
    		datatype: "json",
            datafields: _datafields,
            url: contUrl + ".action?"+params
     
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

		$("#registBtn").click(function(){
			$("#registBtn").attr("href","locStoreS.action?boardMstCd=${boardMstCd}");
		});
		
		$("#jqxgrid").on('celldoubleclick', function (event)
				{
					if(event.args.datafield != 'chk'){
		  		    var args = event.args;
		  		    var rowBoundIndex = args.rowindex;
					var datarow = $('#jqxgrid').jqxGrid('getrowdata', rowBoundIndex);
						setTimeout(function(){
							$("#modifyBtn").attr("href","locStoreS.action?boardMstCd=${boardMstCd}&mapStoreId="+ datarow.mapStoreId),
							$("#modifyBtn").click();
						},200);
					}
				});


		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid',$("#tit_depths0").text());
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
				fnAjax("locStoreD.action",  {"data":$.paramData}, function(data, dataType){
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
			height 	    : 619,
			autoSize	: false,
			beforeClose : function(){
		    	fnSearch();
			}
		});

		$("#addressLev1").bind("change",function(){
			fnAjax("${rootUri}${conUrl}zipcodeSearch.action", {"addressLev1":$("#addressLev1").val()},
					function(data, dataType){
						if($("#addressLev1").val() == ""){
							$("#addressLev1").html("<option value=''>도/시 선택</option>");
							
							for (key in data) {
								$("#addressLev1").append("<option value='"+data[key].addressLev1+"'>"+data[key].addressLev1+"</option>");
							}
						}else{
							$("#addressLev2").html("<option value=''>시/군/구 선택</option>");
							
							for (key in data) {
								$("#addressLev2").append("<option value='"+data[key].addressLev2+"'>"+data[key].addressLev2+"</option>");
							}
						}
					},"POST"
				);
		});
	}
	function fnDataSetting(){
		$("#addressLev1").change();
	}
</script>
</head>
<body>
	<input name='chkAll' type='checkbox' style="display:none"/>
	<div class="pageContScroll_st2">
		<div class="top_box">
			<form id="workForm" name="workForm"  method="post">
			<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}"/>
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
							<th scope="row">관할지</th>
							<td>
								<select name="addressLev1" id="addressLev1"  title="관할지역(도/시)" ><option value="">도/시 선택</option></select>
								<select name="addressLev2" id="addressLev2" title="관할지역(시/군/구)" ><option value="">시/군/구 선택</option></select>
							</td>
							<th scope="row">텍스트검색</th>
							<td>
								<select id="searchType" style="width:100px;">
									<option value="1">매장명</option>
									<option value="2">주소</option>
									<option value="3">전화번호</option>
								</select>
								<input type="text" id="searchTxt" class="marL10" style="width:145px;" />
							</td>
							
						</tr>
						<c:if test="${fn:length(cateList) > 1}">
						<tr>
							<th scope="row">취급품목</th>
							<td colspan="3" style="height:27px;">
								<div class="option_ul">
									<ul>
										<c:forEach items="${cateList}" var="cateList" varStatus="loop">
											<li style="margin-left:0px;"><input name="mapStoreItem" id="cate${loop.index}" type="checkbox" class="validation[choose]" title="취급품목" value="${cateList.boardCateSeq}" />&nbsp;<label for="cate${loop.index}" class="marR15">${cateList.boardCateNm}</label> </li>
										</c:forEach>
									</ul>
								</div>
							</td>
						</tr>
						</c:if>
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