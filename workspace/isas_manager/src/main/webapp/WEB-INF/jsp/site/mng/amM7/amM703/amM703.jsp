<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
<head>

<!-- 설정관리 : front 메뉴구조 설정 -->

<script type="text/javaScript" defer="defer">
	var contUrl = "${rootUri}${conUrl}amM703";
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init() {

		// 초기 그리드셋팅
		fnSearchInit();
		// 초기 데이터 셋팅 (1차 메뉴)
		fnSearch(0, 'root');
		// 이벤트
		fnEvent();

	}

	var frontPageCds = [ {
		label : "일반페이지",
		value : "view"
	}, {
		label : "게시판프로그램",
		value : "bbs"
	}, {
		label : "회원프로그램",
		value : "mbr"
	}, {
		label : "기타프로그램",
		value : "etc"
	} ];

	var frontSvTps = [ {
		label : "전체노출",
		value : "ALL"
	}, {
		label : "로그인이후",
		value : "SIGN"
	}, {
		label : "미로그인시",
		value : "UNSIGN"
	} ];

	var frontPageCds = [ {
		label : "일반페이지",
		value : "view"
	}, {
		label : "게시판프로그램",
		value : "bbs"
	}, {
		label : "회원프로그램",
		value : "mbr"
	}, {
		label : "기타프로그램",
		value : "etc"
	} ];

	var frontPageCds = [ {
		label : "일반페이지",
		value : "view"
	}, {
		label : "확장프로그램",
		value : "bbs"
	}, {
		label : "단일프로그램",
		value : "uni"
	} ];

	var pageAdapter = new $.jqx.dataAdapter(frontPageCds, {
		autoBind : true
	});

	var svTpAdapter = new $.jqx.dataAdapter(frontSvTps, {
		autoBind : true
	});

	bbsdataListAdapter = new $.jqx.dataAdapter({
		datatype : "json",
		url : "bbsProgList.action",
		data : {
			frontPageCd : 'bbs'
		}

	});

	unidataListAdapter = new $.jqx.dataAdapter({
		datatype : "json",
		url : "bbsProgList.action",
		data : {
			frontPageCd : 'uni'
		}
	});

	//var frontPageCds = ["bbs","etc"];
	//var frontPageNames = ["프로그램","일반페이지"];
	/** 1차 메뉴 목록 **/
	var _columns = [
			{
				text : '메뉴명',
				datafield : 'frontMenuNm',
				cellclassname : cellclass,
				width : '50%',
				cellsalign : 'center',
				align : 'center'
			},
			{
				text : '노출방식',
				displayfield : 'frontSvTpNm',
				datafield : 'frontSvTp',
				columntype : 'dropdownlist',
				cellclassname : cellclass,
				width : '30%',
				cellsalign : 'center',
				align : 'center',
				initeditor : function(row, cellvalue, editor) {
					editor.jqxDropDownList({
						source : svTpAdapter,
						displayMember : 'label',
						valueMember : 'value',
						selectedIndex : 0
					});
				}
			},
			{
				text : '메뉴코드',
				datafield : 'frontMenuCd',
				hidden : true
			},
			{
				text : '메뉴그룹코드',
				datafield : 'frontMenuGroup',
				hidden : true
			},
			{
				text : '페이지명',
				datafield : 'frontPageCd',
				hidden : true
			},
			{
				text : 'U',
				dataField : 'sortUp',
				width : "10%",
				cellsalign : 'center',
				align : 'center',
				cellsrenderer : function(row) {
					return "<div class=\"sortUp\" style=\"text-align:center;\" ><img src=\'${rootUri}images/btn_green_box_up_arrow.png\' alt=\'\' style=\"margin-top:8px;cursor:pointer;text-align:center;\" /></div>";
				}
			},
			{
				text : 'D',
				dataField : 'sortDown',
				width : "10%",
				cellsalign : 'center',
				align : 'center',
				cellsrenderer : function(row) {
					return "<div class=\"sortDown\" style=\"text-align:center;\" ><img src=\'${rootUri}images/btn_green_box_down_arrow.png\' alt=\'\' style=\"margin-top:8px;cursor:pointer;text-align:center;\"  /></div>";
				}
			} ];
	var _datafields = [ {
		name : 'frontMenuNm',
		type : 'string'
	}, {
		name : 'frontSvTpNm',
		value : 'frontSvTp',
		values : {
			source : svTpAdapter.records,
			value : 'value',
			name : 'label'
		}
	}, {
		name : 'frontSvTp',
		type : 'string'
	}, {
		name : 'frontMenuCd',
		type : 'string'
	}, {
		name : 'frontMenuGroup',
		type : 'string'
	}, {
		name : 'frontPageCd',
		type : 'string'
	}, {
		name : 'sortUp',
		type : 'image'
	}, {
		name : 'sortDown',
		type : 'image'
	} ];

	/** 2차 메뉴 목록 **/
	var _columns2 = [
			{
				text : '메뉴명',
				datafield : 'frontMenuNm',
				cellclassname : cellclass,
				width : '18%',
				cellsalign : 'center',
				align : 'center'
			},
			{
				text : '노출방식',
				displayfield : 'frontSvTpNm',
				datafield : 'frontSvTp',
				columntype : 'dropdownlist',
				cellclassname : cellclass,
				width : '13%',
				cellsalign : 'center',
				align : 'center',
				initeditor : function(row, cellvalue, editor) {
					editor.jqxDropDownList({
						source : svTpAdapter,
						displayMember : 'label',
						valueMember : 'value',
						selectedIndex : 0
					});
				}
			},
			{
				text : '메뉴유형',
				displayfield : 'frontPageNm',
				datafield : 'frontPageCd',
				columntype : 'dropdownlist',
				cellclassname : cellclass,
				width : '17%',
				cellsalign : 'center',
				align : 'center'

				,
				initeditor : function(row, cellvalue, editor) {
					editor.jqxDropDownList({
						source : pageAdapter,
						displayMember : 'label',
						valueMember : 'value'
					});

				}

			},
			{
				text : '파일/코드명',
				displayfield : 'progTp',
				datafield : 'boardMstCd',
				columntype : 'custom',
				cellclassname : cellclass,
				width : '18%',
				cellsalign : 'center',
				align : 'center'

				,
				initeditor : function(row, cellValue, editor, cellText, width,
						height) {
					var pageCd = $("#menuList2").jqxGrid('getcellvalue', row,	"frontPageCd");
					if (pageCd == "bbs") {
						editor.jqxDropDownList({
							width : '112px',
							height : '38px',
							source : bbsdataListAdapter,
							displayMember : 'label',
							valueMember : 'value',
							selectedIndex : 0
						});
					} else if (pageCd == "uni") {
						editor.jqxDropDownList({
							width : '112px',
							height : '38px',
							source : unidataListAdapter,
							displayMember : 'label',
							valueMember : 'value',
							selectedIndex : 0
						});
					} else {
						editor.jqxComboBox({
							width : '158px',
							height : '38px'
						});
					}
				}
			},
			{
				text : '프로그램명',
				datafield : 'boardMstNm',
				cellclassname : cellclass,
				width : '18%',
				cellsalign : 'center',
				align : 'center'
			},
			{
				text : '메뉴코드',
				datafield : 'frontMenuCd',
				hidden : true
			},
			{
				text : '메뉴그룹코드',
				datafield : 'frontMenuGroup',
				hidden : true
			},
			{
				text : 'U',
				dataField : 'sortUp',
				width : "8%",
				cellsalign : 'center',
				align : 'center',
				cellsrenderer : function(row) {
					return "<div class=\"sortUp\" style=\"text-align:center;\" ><img src=\'${rootUri}images/btn_green_box_up_arrow.png\' alt=\'\' style=\"margin-top:8px;cursor:pointer;text-align:center;\" /></div>";
				}
			},
			{
				text : 'D',
				dataField : 'sortDown',
				width : "8%",
				cellsalign : 'center',
				align : 'center',
				cellsrenderer : function(row) {
					return "<div class=\"sortDown\" style=\"text-align:center;\" ><img src=\'${rootUri}images/btn_green_box_down_arrow.png\' alt=\'\' style=\"margin-top:8px;cursor:pointer;text-align:center;\"  /></div>";
				}
			} ];
	var _datafields2 = [ {
		name : 'frontMenuNm',
		type : 'string'
	}, {
		name : 'frontSvTpNm',
		value : 'frontSvTp',
		values : {
			source : svTpAdapter.records,
			value : 'value',
			name : 'label'
		}
	}, {
		name : 'frontSvTp',
		type : 'string'
	}, {
		name : 'frontPageNm',
		value : 'frontPageCd',
		values : {
			source : pageAdapter.records,
			value : 'value',
			name : 'label'
		}
	}, {
		name : 'frontPageCd',
		type : 'string'
	}, {
		name : 'progTp',
		value : 'boardMstCd'
	}, {
		name : 'boardMstCd',
		type : 'string'
	}, {
		name : 'boardMstNm',
		type : 'string'
	}, {
		name : 'frontMenuCd',
		type : 'string'
	}, {
		name : 'frontMenuGroup',
		type : 'string'
	}, {
		name : 'sortUp',
		type : 'image'
	}, {
		name : 'sortDown',
		type : 'image'
	} ];

	/** 3차 메뉴 목록 **/
	/*
	var _columns3 = [{ text: '메뉴명', datafield: 'frontMenuNm', cellclassname: cellclass, width: '28%', cellsalign: 'center', align: 'center'},
	    			 { text: '메뉴유형', datafield: 'frontPageCd', cellclassname: cellclass, width: '28%', cellsalign: 'center', align: 'center'},
	    			 { text: '페이지명', datafield: 'boardMstCd', cellclassname: cellclass, width: '28%', cellsalign: 'center', align: 'center'},
	    			 { text: '메뉴코드', datafield: 'frontMenuCd', hidden: true},
	    			 { text: '메뉴그룹코드', datafield: 'frontMenuGroup', hidden: true},
	    			 { text: 'U', dataField: 'sortUp', width: "8%", cellsalign: 'center', align: 'center', cellsrenderer: function (row)
	    				 {return "<div class=\"sortUp\" style=\"text-align:center;\" ><img src=\'${rootUri}images/btn_green_box_up_arrow.png\' alt=\'\' style=\"margin-top:8px;cursor:pointer;text-align:center;\" /></div>";}
	    	         },
	    	         { text: 'D', dataField: 'sortDown', width: "8%", cellsalign: 'center', align: 'center', cellsrenderer: function (row)
	    	        	{return "<div class=\"sortDown\" style=\"text-align:center;\" ><img src=\'${rootUri}images/btn_green_box_down_arrow.png\' alt=\'\' style=\"margin-top:8px;cursor:pointer;text-align:center;\"  /></div>";}
	    	         }];
	var _datafields3 = [{ name: 'frontMenuNm', type: 'string'},{ name: 'frontPageCd', type: 'string'},{ name: 'boardMstCd', type: 'string'},
	                    { name: 'frontMenuCd', type: 'string'},{ name: 'frontMenuGroup', type: 'string'},{ name: 'sortUp', type: 'image'},{ name: 'sortDown', type: 'image'}];
	 */

	function fnSearchInit() {
		/** 1차 메뉴 그리드셋팅 **/
		fnGridOption('menuList1', {
			editable : true,
			selectionmode : 'singlecell',
			editmode : 'selectedcell',
			sortable : false,
			altrows : true,
			columns : _columns,
			pageable : false,
			height : 250
		});
		/** 2차 메뉴 그리드셋팅 **/
		fnGridOption('menuList2', {
			editable : true,
			selectionmode : 'singlecell',
			editmode : 'selectedcell',
			sortable : false,
			altrows : true,
			columns : _columns2,
			pageable : false,
			height : 250
		});
		/** 3차 메뉴 그리드셋팅 **/
		/*
		fnGridOption('menuList3',{
			editable: true
		    ,selectionmode: 'singlecell'
		    ,editmode: 'selectedcell'
		    ,autoheight: true
		    ,columns: _columns3
		    ,pageable: false
		});
		 */
	}

	function fnSearch(idx, paramData) {
		if (idx == 0) {
			$("#menuList1").jqxGrid('clearselection');
			$('#menuList1').jqxGrid('clear');
			fnResetGridEditData("menuList1");
			prevIdx = -1;
			$("#menuList2").jqxGrid('clearselection');
			$('#menuList2').jqxGrid('clear');
			fnResetGridEditData("menuList2");
			var dataAdapter = new $.jqx.dataAdapter({
				datatype : "json",
				datafields : _datafields,
				data : {
					"frontMenuGroup" : paramData,
					"frontMenuTp" : $("select[name=frontMenuTp]").val()
				},
				url : contUrl + ".action"
			});
		} else if (idx == 1) {
			$("#menuList2").jqxGrid('clearselection');
			$('#menuList2').jqxGrid('clear');
			fnResetGridEditData("menuList2");
			var dataAdapter = new $.jqx.dataAdapter({
				datatype : "json",
				datafields : _datafields2,
				data : {
					"frontMenuGroup" : paramData
				},
				url : contUrl + ".action"
			});
		}
		/*
		else if(idx==2){
			var dataAdapter = new $.jqx.dataAdapter({
				datatype: "json",
		        datafields: _datafields3,
				data : {"frontMenuGroup" : paramData},
		        url: contUrl + ".action"
			});
		}
		 */
		$(".menuList").eq(idx).jqxGrid({
			source : dataAdapter
		});
	}

	var prevIdx = -1;
	function fnEvent() {

		$("select[name=frontMenuTp]").bind('change', function(event) {
			fnSearch(0, 'root');
		});

		/** 메뉴 그리드 선택 이벤트  **/
		$(".menuList").on(
				'cellselect',
				function(event) {
					var i = ($(".menuList").index(this)) + 1;
					var cell = $('#menuList' + i).jqxGrid('getselectedcell');
					var datarow = $('#menuList' + i).jqxGrid('getrowdata',
							cell.rowindex);
					var args = event.args;
					/** 순서이동 이벤트 **/
					if (args.datafield == "sortUp"
							|| args.datafield == "sortDown") {
						var fnSortCheckSuccess = function(data, dataType) {
							var data = data.replace(/\s/gi, '');
							var returnData = "";
							if (data == "ng") {
								alert("이동에 실패하였습니다.");
							} else if (data == "firstData") {
								alert("해당 메뉴는 상위로 이동할 수 없습니다.");
							} else if (data == "lastData") {
								alert("해당 메뉴는 하위로 이동할 수 없습니다.");
							} else {
								alert("이동되었습니다.");
							}
							if (i == 1) {
								returnData = "root";
							} else {
								var cell = $('#menuList1').jqxGrid(
										'getselectedcell');
								var datarow = $('#menuList1').jqxGrid(
										'getrowdata', cell.rowindex);
								returnData = datarow.frontMenuCd;
							}
							fnSearch(i - 1, returnData);
						};
						var selectrow = cell.rowindex + 1;
						var datainfo = $("#menuList" + i).jqxGrid(
								'getdatainformation');
						var totrow = datainfo.rowscount;
						var params = {
							"frontMenuCd" : datarow.frontMenuCd,
							"sortType" : args.datafield,
							"selectRow" : selectrow,
							"totRow" : totrow
						};
						fnAjax("sortMod.action", params, fnSortCheckSuccess,
								"post", "text", "false");
					} else {
						if (cell.rowindex != prevIdx) {
							if (i != 2) {
								fnSearch(i, datarow.frontMenuCd);
							}
							prevIdx = cell.rowindex;
						}
					}
				});

		/** 추가버튼 이벤트 **/
		$(".btnAddNew").click(function() {
			var idx = $(".btnAddNew").index(this);
			if (idx == 1) {
				var rowindex = $("#menuList1").jqxGrid('getselectedcell');
				if (rowindex == null) {
					alert("1차메뉴를 선택해주세요.");
					return false;
				}
			}
			/*
			if(idx == 2){
				var rowindex = $("#menuList2").jqxGrid('getselectedcell');
				if(rowindex == null){
					alert("2차메뉴를 선택해주세요.");
					return false;
				}
			}
			 */
			fnbtnAddNew(idx);
		});

		/** 저장버튼 이벤트 **/
		$(".saveBtn").click(
				function() {
					var action = "";
					var gridId = "";
					if ($(".saveBtn").index(this) == 0) {
						action = "amM703IUD.action?frontMenuTp="
								+ $("select[name=frontMenuTp]").val() + "&idx="
								+ $(".saveBtn").index(this);
						gridId = "menuList1";
					} else if ($(".saveBtn").index(this) == 1) {
						action = "amM703MIUD.action?idx="
								+ $(".saveBtn").index(this);
						gridId = "menuList2";
					}
					/*
					 else if($(".saveBtn").index(this) == 2){
						action = "amM703MIUD.action";
						gridId = "menuList3";
					}
					 */
					else {
						return false;
					}
					var fnSaveSuccess = function(data, dataType) {
						var data = data.replace(/\s/gi, '');
						var returnData = "";
						if (data == "2") {
							alert("저장에 실패하였습니다.");
							return false;
						} else {
							alert("정상적으로 저장되었습니다.");
							if (data == "0") {
								fnSearch(0, 'root');
							} else {
								var cell = $('#menuList1').jqxGrid(
										'getselectedcell');
								var datarow = $('#menuList1').jqxGrid(
										'getrowdata', cell.rowindex);
								returnData = datarow.frontMenuCd;
								fnSearch(1, returnData);
							}
						}
					};
					fnSaveConfirm(action, gridId, fnSaveSuccess);
				});

		/** 삭제버튼 이벤트 **/
		$(".delBtn").click(
				function() {
					var fnDeleteSuccess = function(data, dataType) {
						var data = data.replace(/\s/gi, '');
						var returnData = "";
						if (data == "2") {
							alert("삭제에 실패하였습니다.");
							return false;
						} else {
							alert("정상적으로 삭제되었습니다.");
							if (data == "0") {
								fnSearch(0, 'root');
							} else {
								var cell = $('#menuList1').jqxGrid(
										'getselectedcell');
								var datarow = $('#menuList1').jqxGrid(
										'getrowdata', cell.rowindex);
								returnData = datarow.frontMenuCd;
								fnSearch(1, returnData);
							}
						}
					};
					if ($(".delBtn").index(this) == 0) {
						var cell = $('#menuList1').jqxGrid('getselectedcell');
						var rownum = cell.rowindex + 1;
						if (cell == null) {
							alert("1차메뉴를 선택해주세요.");
							return false;
						}
						var datainformation = $('#menuList2').jqxGrid(
								'getdatainformation');
						var rowscount = datainformation.rowscount;
						if (rowscount != 0) {
							alert("2차메뉴가 존재하여 삭제할 수 없습니다.");
							return false;
						}
						fnDeleteConfirm("amM703IUD.action?type=del&rownum="
								+ rownum + "&idx=" + $(".delBtn").index(this),
								"menuList1", "frontMenuCd", fnDeleteSuccess);
					} else if ($(".delBtn").index(this) == 1) {
						var cell = $('#menuList2').jqxGrid('getselectedcell');
						var datarow = $('#menuList2').jqxGrid('getrowdata',
								cell.rowindex);
						var frontMenuGroup = datarow.frontMenuGroup;
						var rownum = cell.rowindex + 1;
						if (cell == null) {
							alert("2차메뉴를 선택해주세요.");
							return false;
						}
						/*
						var datainformation = $('#menuList3').jqxGrid('getdatainformation');
						var rowscount = datainformation.rowscount;
						if(rowscount != 0){
							 alert("3차메뉴가 존재하여 삭제할 수 없습니다.");
							return false;
						}
						 */
						fnDeleteConfirm("amM703MIUD.action?type=del&rownum="
								+ rownum + "&frontMenuGroup=" + frontMenuGroup
								+ "&idx=" + $(".delBtn").index(this),
								"menuList2", "frontMenuCd", fnDeleteSuccess);
					}
					/*
					else if($(".delBtn").index(this) == 2){
						var cell = $('#menuList3').jqxGrid('getselectedcell');
						if(cell==null){
							alert("3차메뉴를 선택해주세요.");
							return false;
						}
						fnDeleteConfirm("amM703MIUD.action?type=del","menuList3","frontMenuCd");
					}
					 */
				});

		$("#menuList2").jqxGrid('setcolumnproperty', 'boardMstNm', 'editable',
				false);
	}

	/** 추가버튼 이벤트 **/
	function fnbtnAddNew(idx) {
		if (idx == 0) {
			$("#menuList1").jqxGrid('addrow', null, {});
		} else if (idx == 1) {
			var cell = $('#menuList1').jqxGrid('getselectedcell');
			var data = $('#menuList1').jqxGrid('getrowdata', cell.rowindex);
			$("#menuList2").jqxGrid('addrow', null, {
				frontMenuGroup : data.frontMenuCd
			});
		}
		/*
		else if(idx == 2){
			var cell = $('#menuList2').jqxGrid('getselectedcell');
			var data = $('#menuList2').jqxGrid('getrowdata', cell.rowindex);
			$("#menuList3").jqxGrid('addrow', null, {frontMenuGroup:data.frontMenuCd});
		}
		 */
	}
</script>
</head>
<body>
	<div class="pageContScroll_st2">
		<div class="department_table_area">
			<!-- 1차 메뉴 -->
			<div>
				<div style="text-align: right">
					<select name="frontMenuTp">
						<option value="WEB">웹메뉴</option>
						<option value="UWEB">모바일메뉴</option>
						<option value="SWEB">기사모바일메뉴</option>
					</select> <a class="btnAddNew btn_type1 marL5" href="javascript:;">추가</a> <a
						class="saveBtn btn_type1 marL5" href="javascript:;">저장</a> <a
						class="delBtn btn_type1 marL5" href="javascript:;">삭제</a>
					<div style="margin-top: 5px;">
						<div id="menuList1" class="menuList"></div>
					</div>
				</div>
			</div>
			<!-- 2차 메뉴 -->
			<div>
				<div style="text-align: right">
					<a class="btnAddNew btn_type1 marL5" href="javascript:;">추가</a> <a
						class="saveBtn btn_type1 marL5" href="javascript:;">저장</a> <a
						class="delBtn btn_type1 marL5" href="javascript:;">삭제</a>
					<div style="margin-top: 5px;">
						<div id="menuList2" class="menuList"></div>
					</div>
				</div>
			</div>
			<!-- 3차 메뉴 -->
			<!--
		<div>
			<div style="text-align:right">
				<a class="btnAddNew btn_type1 marL5" href="javascript:;">추가</a>
				<a class="saveBtn btn_type1 marL5" href="javascript:;">저장</a>
				<a class="delBtn btn_type1 marL5" href="javascript:;">삭제</a>
				<div  style="margin-top:5px;">
				<div id="menuList3" class="menuList"></div>
				</div>
			</div>
		</div>
		-->
		</div>
	</div>

</body>