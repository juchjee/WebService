<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<c:import url="/WEB-INF/jsp/general/lib_jqx_core.jsp" />
	<!-- 설정관리 : 부서별 권한설정 -->

<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM705";
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){
		// 초기 그리드셋팅
		fnSearchInit();
		// 초기 데이터 셋팅 (1차 메뉴)
		fnSearch('');
	 	// 이벤트
		fnEvent();
	}

	var _columns1 = [{ text: '권한명', datafield: 'admAuthNm', cellclassname: cellclass, width: '100%', cellsalign: 'center', align: 'center'},
	                 { text: '권한여부', datafield: 'useFlagYn', hidden: true, cellclassname: cellclass, cellsalign: 'center', align: 'center'},
	                 { text: '', datafield: 'admAuthCd', cellclassname: cellclass, cellsalign: 'center', align: 'center', hidden: true}];
	var _datafields1 = [{ name: 'admAuthNm', type: 'string'},
	                    { name: 'useFlagYn', type: 'string'},
	                    { name: 'admAuthCd', type: 'string'}];

	var _columns2 = [{ text: '메뉴명', datafield: 'admMenuNm', width: '100%', align: 'center'},
	                 { text: '그룹코드', datafield: 'admMenuGroup', hidden: true,  align: 'center'},
	                 { text: '메뉴코드', datafield: 'admMenuCd', hidden: true,  align: 'center'},
	                 { text: '권한별코드', datafield: 'admAuthMenuCd', hidden: true,  align: 'center'}];
	var _datafields2 = [{ name: 'admMenuNm', type: 'string'},
	                    { name: 'admMenuGroup', type: 'string'},
	                    { name: 'admMenuCd', type: 'string'},
	                    { name: 'admAuthMenuCd', type: 'string'}];

	function fnSearchInit(){
		fnGridOption('authList1',{
			editable: true
			,editmode: 'dblclick'
			,selectionmode: 'singlecell'
	        ,columns: _columns1
	        ,pageable: false
	        ,sortable : false
    	    ,altrows : true
	        ,height : 250
	    });


		var treeSizeHeight = ($( window ).height() - 250);

	    if(treeSizeHeight <= 150){
	    	treeSizeHeight = 150;
	    }
			$("#authList2").jqxTreeGrid(
		        {
		            hierarchicalCheckboxes: true
		            ,checkboxes: true
		            ,columns: _columns2
		            ,height: treeSizeHeight
		            ,editable: true
		        });

			$( window ).resize(function() {
		        var treeResizeHeight = $( window ).height() -250;

		           if(treeResizeHeight > 150){
		        	$("#authList2").jqxTreeGrid('height', treeResizeHeight);
		           }else{
			        	$("#authList2").jqxTreeGrid('height', 150);
		           }
		    	});
	}

	function fnSearch(admAuthCd){
		var dataAdapter1 = new $.jqx.dataAdapter({
			datatype: "json",
            datafields: _datafields1,
            url: contUrl + ".action"
		});
		$("#authList1").jqxGrid({ source: dataAdapter1 });
	}

	function fnSearch2(admAuthCd){
		if(admAuthCd!=""){
			var dataAdapter2 = new $.jqx.dataAdapter({
				datatype: "json",
	            datafields: _datafields2,
	            url: contUrl + "ML.action",
	            data : {"admAuthCd" : admAuthCd},
	            hierarchy:
	            { keyDataField: { name: 'admMenuCd' }, parentDataField: { name: 'admMenuGroup' } }
			});
			$("#authList2").jqxTreeGrid({ source: dataAdapter2 });
		}
	}

	function fnEvent(){

		$('#authList2').on('bindingComplete', function (event) {

			$("#authList2").jqxTreeGrid('expandAll');

			var rows = $("#authList2").jqxTreeGrid('getRows');
			var idx = 1;
			var traverseTree = function(rows)
		      {
				 for(var i = 0; i < rows.length; i++)
		          {
					  if(rows[i].admAuthMenuCd != ""){
		        	      $("#authList2").jqxTreeGrid('checkRow',idx);
		        	  }
		              if (rows[i].records)
		              {
		                  traverseTree(rows[i].records);
		              }
		              idx++
		          }
		      };
		      traverseTree(rows);
	     });

		$("#authList1").on('cellselect', function (event)
		{
			var cell = $("#authList1").jqxGrid('getselectedcell');
			var datarow = $("#authList1").jqxGrid('getrowdata', cell.rowindex);
			fnSearch2(datarow.admAuthCd);
		});

		$(".saveBtn").click(function(){
			var action =  "amM705IUD.action";
			var gridId = "authList1";
			var fnSaveSuccess =  function(data, dataType){
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
			fnSaveConfirm(action, gridId,fnSaveSuccess);
		});

		$(".saveAuth").click(function(){
			var cell = $('#authList1').jqxGrid('getselectedcell');
			var datarow = $("#authList1").jqxGrid('getrowdata', cell.rowindex);

			if(cell==null){
				alert("권한명을 선택해주세요.");
				return false;
			}

			var fnIconAddSuccess =  function(data, dataType){
				var data = data.replace(/\s/gi,'');
				var returnData = "";
				if(data == "ng"){
					alert("저장에 실패하였습니다.");
					return false;
				}else if(data == "ok"){
					alert("정상적으로 저장 되었습니다.");
					fnSearch('');
					if(confirm("현재페이지를 새로고침 하시겠습니까?")){
						location.reload();
					}
				}else{
					return false;
				}
			};

			var postData = new Array();
			var checkedRows = $("#authList2").jqxTreeGrid('getCheckedRows');
			for (var i = 0; i < checkedRows.length; i++) {
				postData.push({admMenuCd:checkedRows[i].admMenuCd,admMenuGroup:checkedRows[i].admMenuGroup});
			}
			var editedRowsJson = JSON.stringify(postData);
			fnAjax("amM705MIU.action", {data : editedRowsJson, admAuthCd : datarow.admAuthCd}, fnIconAddSuccess, "post", "text", "false");
		});

		$(".btnAddNew").click(function(){
			fnbtnAddNew();
		});


		$(".delBtn").click(function(){
				var cell = $('#authList1').jqxGrid('getselectedcell');
				if(cell==null){
					alert("권한명을 선택해주세요.");
					return false;
				}
				var fnDeleteSuccess =  function(data, dataType){
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
				fnDeleteConfirm("amM705IUD.action?type=del","authList1","admAuthCd",fnDeleteSuccess);
		});

	}

	function fnbtnAddNew(){
		$("#authList1").jqxGrid('addrow', null, {});
	}

</script>
</head>
<body>
	<div class="pageContScroll_st2">
	<div class="multi_table_area">
		<div>
			<div style="text-align:right">
					<a class="btnAddNew btn_type1" href="#">추가</a>
					<a class="saveBtn btn_type1" href="#">저장</a>
					<a class="delBtn btn_type1" href="#">삭제</a>
			</div>
			<div style="text-align:right">
			<div  style="margin-top:5px;">
				<div id="authList1" class="authList"></div>
			</div>
			</div>

		</div>
		<!-- // -->
		<div>
			<div style="text-align:right">
					<a class="saveAuth btn_type1" href="#">권한 저장</a>
			</div>
			<div style="text-align:right">
			<div  style="margin-top:5px;">
				<div id="authList2" class="authList"></div>
			</div>
			</div>
		</div>
	</div>
	</div>
</body>