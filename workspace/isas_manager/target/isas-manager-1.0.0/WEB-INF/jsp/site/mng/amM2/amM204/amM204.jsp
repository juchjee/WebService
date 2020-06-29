<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<script type="text/javaScript" defer="defer">

		var contUrl = "${rootUri}${conUrl}amM204";
		/*----------------------------------------------------------------------------------------------
		 * 화면 load시 실행 함수 (onload)
		 *----------------------------------------------------------------------------------------------*/

		function init(){
			fnSearchInit();
			fnSearch();
			fnEvent();
		}

		/** 그룹 그리드 셋팅 **/
		var _columns = [
			{ text: '그룹명', datafield: 'prodKeywordGrNm', cellclassname: cellclass, width: '100%', cellsalign: 'center', align: 'center'},
	        { text: '그룹코드', datafield: 'prodKeywordGrCd', hidden: true}];
		var _datafields = [
			{ name: 'prodKeywordGrNm', type: 'string'}
		   ,{ name: 'prodKeywordGrCd', type: 'String'}];

		/** 키워드 그리드 셋팅 **/
		var _columns2 = [
   			{ text: '키워드명', datafield: 'prodKeywordNm', cellclassname: cellclass, width: '100%', cellsalign: 'left', align: 'center'},
   	        { text: '코드값', datafield: 'prodKeywordCd', editable: false, cellclassname: cellclass, width: '30%', cellsalign: 'center', align: 'center', hidden: true},
			{ text: '그룹코드', datafield: 'prodKeywordGrCd', hidden: true}];
   		var _datafields2 = [
   			,{ name: 'prodKeywordNm', type: 'string'}
   			,{ name: 'prodKeywordCd', type: 'String'}
   		    ,{ name: 'prodKeywordGrCd', type: 'String'}];

   		/** 그리드 옵션 설정 **/
   		function fnSearchInit(){
   		var appearance = new Object();
   			appearance.editable = true;
     	    appearance.selectionmode = "singlecell";
     	    appearance.editmode = 'selectedcell';
     	    appearance.height = 250;
     	    appearance.sortable = false;
    	    appearance.altrows = true;
    	    appearance.pageable = false;
    	    appearance.columns = _columns;
			fnGridOption('gridList1',appearance);
 	  		appearance.columns = _columns2;
			fnGridOption('gridList2',appearance);
   		}
   		/** 그리드 생성 **/
		function fnSearch(){
			var dataAdapter = new $.jqx.dataAdapter({
	    		datatype: "json",
	            datafields: _datafields,
	            url: contUrl + ".action"
			});
			$("#gridList1").jqxGrid({source: dataAdapter});
			var dataAdapter2 = new $.jqx.dataAdapter({
	            datafields: _datafields2
			});
		}

		function fnSearch2(){
			var cell = $('#gridList1').jqxGrid('getselectedcell');
		     var datarow = $('#gridList1').jqxGrid('getrowdata', cell.rowindex);

			// 키워드 조회 이벤트
			if(args.datafield == "prodKeywordGrNm"){
				var params = {
					"prodKeywordGrCd" : datarow.prodKeywordGrCd
				};
				// 키워드 그리드 조회
				var url = "/mng/amM2/amM204/amM204M.action";
				var source =
	            {
					datatype: "json",
		    		datafields: _datafields2,
	                data: params,
	                id: 'id',
	                url: url
	            };
				// 키워드 그리드 셋팅
            	var dataAdapter2 = new $.jqx.dataAdapter(source);
            	$("#gridList2").jqxGrid({source: dataAdapter2});
				code = datarow.prodKeywordGrCd;
			}
		}

   		var prevIdx = -1;
		function fnEvent(){

			var code = "";
			/** 그룹 그리드 선택 시 키워드 그리드 조회 **/
			$("#gridList1").on('cellselect', function (event)
			{
			    var cell = $('#gridList1').jqxGrid('getselectedcell');
				if(cell.rowindex != prevIdx){
					fnSearch2();
					prevIdx = cell.rowindex;
				}
			});

			/** 그리드 셀 추가 이벤트 **/
			$(".btnAddNew").click(function(){
				var idx = $(".btnAddNew").index(this);
				if(idx == 1){
					var rowindex = $("#gridList1").jqxGrid('getselectedcell');
					if(rowindex == null){
						alert("그룹명을 선택해주세요.");
						return false;
					}
				}
				fnbtnAddNew(idx);
			});

			/** 등록 및 수정 처리 로직 **/
			$(".saveBtn").click(function(){
				var action =  "";
				var gridId = "";
				if($(".saveBtn").index(this) == 0){
					action = "amM204IUD.action";
					gridId = "gridList1";
				}else if($(".saveBtn").index(this) == 1){
					action = "amM204MIUD.action";
					gridId = "gridList2";
				}else{
					return false;
				}
				var fnIconAddSuccess =  function(data, dataType){
					var data = data.replace(/\s/gi,'');
					var returnData = "";
					if(data == "ng"){
						alert("저장에 실패하였습니다.");
						return false;
					}else if(data == "ok"){
						alert("정상적으로 저장되었습니다.");
						location.reload();
					}
				};
				fnSaveConfirm(action, gridId,fnIconAddSuccess);
			});

			/** 삭제 처리 로직 **/
			$(".delBtn").click(function(){
				var fnDelSuccess =  function(data, dataType){
					var data = data.replace(/\s/gi,'');
					var returnData = "";
					if(data == "ng"){
						alert("삭제에 실패하였습니다.");
						return false;
					}else if(data == "ok"){
						alert("정상적으로 삭제되었습니다.");
						location.reload();
					}
				};
				if($(".delBtn").index(this) == 0){
					var cell = $('#gridList1').jqxGrid('getselectedcell');
					if(cell==null){
						alert("그룹명을 선택해주세요.");
						return false;
					}
					var datainformation = $('#gridList2').jqxGrid('getdatainformation');
					var rowscount = datainformation.rowscount;
					if(rowscount != 0){
		        		 alert("키워드가 존재하여 삭제할 수 없습니다.");
						return false;
					}
					fnDeleteConfirm("amM204IUD.action?type=del","gridList1","prodKeywordGrCd",fnDelSuccess);
				}
				else if($(".delBtn").index(this) == 1){
					var cell = $('#gridList2').jqxGrid('getselectedcell');
					if(cell==null){
						alert("키워드명을 선택해주세요.");
						return false;
					}
					fnDeleteConfirm("amM204MIUD.action?type=del","gridList2","prodKeywordCd",fnDelSuccess);
				}
			});

		}

		function fnbtnAddNew(idx){
			if(idx == 0 ){
				$("#gridList1").jqxGrid('addrow', null, {});
			}else {
				var cell = $('#gridList1').jqxGrid('getselectedcell');
				if(cell==null){
					alert("그룹명을 선택해주세요.");
					return false;
				}
			    var data = $('#gridList1').jqxGrid('getrowdata', cell.rowindex);
				$("#gridList2").jqxGrid('addrow', null, {prodKeywordGrCd:data.prodKeywordGrCd});
			}
		}

</script>
</head>

<body>
	<div class="pageContScroll_st2">
		<form id="workForm" name="workForm" action="" method="post">
			<div class="department_table_area">
				<div>
					<div class="align_area">
						<div class="right">
							<a class="btnAddNew btn_type1" href="javascript:;">추가</a>
							<a class="saveBtn btn_type1" href="javascript:;">저장</a>
							<a class="delBtn btn_type1" href="javascript:;">삭제</a>
						</div>
					</div>
					<!-- // align_area -->
					<div>

						<div id="gridList1" class="gridList"></div>

					</div>
					<!-- // table_type1 -->
				</div>
				<!-- // -->
				<div>
					<div class="align_area">
						<div class="right">
							<a class="btnAddNew btn_type1" href="javascript:;">추가</a>
							<a class="saveBtn btn_type1 " href="javascript:;">저장</a>
							<a class="delBtn btn_type1 " href="javascript:;">삭제</a>
						</div>
					</div>
					<!-- // align_area -->
					<div>
						<!-- 키워드 그리드 -->
						<div id="gridList2" class="gridList"></div>
					</div>
					<!-- // table_type1 -->
				</div>
			</div>
		</form>
	</div>
</body>