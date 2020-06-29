/*----------------------------------------------------------------------------------------------
 * 공통 전역 변수 Setting
 *----------------------------------------------------------------------------------------------*/
var $grid_rows = {};//그리드 별로 수정 정보를 저장하기 위한 오브젝트
window.$select_grid_id = null;//수정 중인 그리드 아이디 기억

function fnResetGridEditData(gridId){
	$grid_rows[gridId] = {
		"org_rows" : {},
		"editedRows" : {}
	};
}

//그리드 옵션 셋팅
function fnGridOption(){
	//ie8이하 버전 Object.keys 정의
	if(!Object.keys){
		Object.keys = function(obj) {
			var keys = [];
			for (var i in obj) {
				if (obj.hasOwnProperty(i)) {
					keys.push(i);
				}
			}
			return keys;
		};
	}
	//매개변수값 저장
	switch (arguments.length){
	     case 1: //-- 매개변수가 하나일 때
	    	 fnGridOptionLoding(arguments[0],null,null,null,null);
	         break;
	     case 2: //-- 매개변수가 두 개 일 때
	    	 fnGridOptionLoding(arguments[0],null,null,arguments[1],null);
	         break;
	     case 3: //-- 매개변수가 세 개 일 때
	    	 fnGridOptionLoding(arguments[0],arguments[1],null,null,arguments[2]);
	         break;
	     case 4: //-- 매개변수가 네 개 일 때
	    	 fnGridOptionLoding(arguments[0],arguments[1],arguments[2],arguments[3],null);
	         break;
	     case 5: //-- 매개변수가 다섯 개 일 때
	    	 fnGridOptionLoding(arguments[0],arguments[1],arguments[2],arguments[3],arguments[4]);
	         break;
	}
}

function fnGridOptionLoding(id, heightInfo, widthInfo, objA, objB){
	/*var pagerrenderer = function () {
	    var element = $("<div style='margin-right: 10px; margin-top: 5px; width: 100%; height: 100%;'></div>");
	    var datainfo = $("#"+id).jqxGrid('getdatainformation');
	    var paginginfo = datainfo.paginginformation;
	    var label = $("<div style='font-size: 11px; margin: 2px 3px; font-weight: bold; float: left;'></div>");//페이지 처리 custerm start
	    label.text(datainfo.rowscount+' 건이 조회 되었습니다.');
	    label.appendTo(element);
	    return element;
	}*/
	//페이지 처리 custerm end
	fnCellendeditEvent(id);
    var defaultOption = new Object();
    defaultOption.theme = "custom";
    defaultOption.width = "100%";
    defaultOption.localization= Globalize.cultures.ko;
    defaultOption.height = 420;
    defaultOption.rowsheight = 40;
    defaultOption.columnsheight = 40;


    defaultOption.enableanimations = false;
    defaultOption.sortable = true;
    defaultOption.enabletooltips = true;
    defaultOption.altrows = true;
    defaultOption.columnsresize = true;
    defaultOption.pageable = true;
    defaultOption.pagesizeoptions = [10,30,50,100,200];
    defaultOption.pagesize = 50;
    //defaultOption.pagerbuttonscount = 10;
    //defaultOption.pagermode = 'simple';
    //defaultOption.pagerrenderer = pagerrenderer;
    //defaultOption.scrollmode = 'deferred';
	if(heightInfo != undefined || heightInfo != null){
		defaultOption.height=heightInfo;
	}
	if(widthInfo != undefined || widthInfo != null){
		defaultOption.width=widthInfo;
	}
	if(objA != undefined || objA != null){
		$.extend(defaultOption, objA);
	}
	if(objB != undefined || objB != null){
		$.extend(defaultOption, objB);
	}
    var windowHeight = $( window ).height();
    var defualtHeight = defaultOption.height;
    var resizeHeight = (windowHeight - defualtHeight);
    if(resizeHeight > 150){
    	defaultOption.height = resizeHeight;
    }else{
    	defaultOption.height = 150;

    }
	$("#"+id).jqxGrid(defaultOption);

		$( window ).resize(function() {
	        var windowHeight = $( window ).height();

	            var gridheight = (windowHeight - defualtHeight);
	           if(gridheight > 150){
	        	$("#"+id).jqxGrid('height', gridheight);
//	        	$("#"+id).jqxGrid('endupdate');
	           }else{
		        	$("#"+id).jqxGrid('height', 150);
	           }
	    	});


	fnResetGridEditData(id);
}

/**
 * 그리드 수정작업 이벤트 시작 콜백
 * @param event
 */
function cellbegineditHandler (event) {
    var _args = event.args;
    var _gridId = $(this).attr('id');
    var _id = $("#" + _gridId).jqxGrid('getrowid', _args.rowindex);
    var _datas = _args.row;
    var _colname = _args.datafield;
    var org_rows = $grid_rows[_gridId]["org_rows"];
    window.$select_grid_id = _gridId;
    if(org_rows[_id] !== undefined){
    	var _org_col = org_rows[_id][_colname];
    	if(_org_col === undefined){
    		org_rows[_id][_colname] = getCellValue(_args.value || '');
    	}
    }else{
    	var _newObj = {};
    	_newObj[_colname] = getCellValue(_args.value || '');
    	org_rows[_id] = _newObj;
    }
}

/**
 * 그리드 수정작업 이벤트 끝 콜백
 * @param event
 */
function cellendeditHandler(event) {
    var _args = event.args;
    var _gridId = $(this).attr('id');
    var _id = $("#" + _gridId).jqxGrid('getrowid', _args.rowindex);
    var _colname = _args.datafield;
    var org_rows = $grid_rows[_gridId]["org_rows"];
    var editedRows = $grid_rows[_gridId]["editedRows"];
    if(org_rows[_id] != undefined){
    	var _keyarr = Object.keys(org_rows[_id]);
    	if($.inArray(_colname, _keyarr) > -1){
    		if(editedRows[_id] == undefined){
    			if(org_rows[_id][_colname] != getCellValue(_args.value)){
    				var _newObj = {};
        			_newObj[_colname] = getCellValue(_args.value);
        			editedRows[_id] = _newObj;
    			}
    		}else{
    			if(org_rows[_id][_colname] == getCellValue(_args.value)){
        			if(editedRows[_id][_colname] != undefined){
        				delete editedRows[_id][_colname];
        			}
        		}else if(_args.value != undefined){
        			editedRows[_id][_colname] = getCellValue(_args.value);
        		}
    		}
    	}
    }else{
    	return false;
    }
    if(editedRows[_id] != undefined){
    	var _isedit = false;
    	for(var _name in editedRows[_id]){
    		var _value = editedRows[_id][_name] || "";
    		var _oldValue = org_rows[_id][_name] || "";
    		if(_value != _oldValue){
    			_isedit = true;
    			break;
    		}
    	}
    	if(!_isedit){
    		delete editedRows[_id];
    	}
    }
}

//grid - update/insert 발생시 저장 처리
function fnCellendeditEvent(id){
	$grid_rows[id] = {
		"org_rows" : {},
		"editedRows" : {}
	};
    $("#" + id).on('cellbeginedit', cellbegineditHandler);
    $("#" + id).on('cellendedit', cellendeditHandler);
}

function getCellValue(obj){
	var objType = $.type(obj);
	if(objType == "date"){
		return obj.toString('yyyy-MM-dd');
	}else if(objType == "object"){
		return obj.value;
	}else{
		return obj;
	}
}

//grid - update/insert 발생시 저장 처리 강제 발생, 컬럼값 바꾸기전에 호출(전체 컬럼 값 체크)
function cellbegineditAllHandler(_datas, _gridId){
	var org_rows = $grid_rows[_gridId]["org_rows"];
	var _id = _datas.uid;
	window.$select_grid_id = _gridId;
	$.each(_datas, function (_colname, value) {
		if(_colname != "uid"){
			if(org_rows[_id] !== undefined){
		    	var _org_col = org_rows[_id][_colname];
		    	if(_org_col === undefined){
		    		org_rows[_id][_colname] = getCellValue(value);
		    	}
		    }else{
		    	var _newObj = {};
		    	_newObj[_colname] = getCellValue(value);
		    	org_rows[_id] = _newObj;
		    }
		}
    });
}

//grid - update/insert 발생시 저장 처리 강제 발생, 컬럼값 바꾼후에 호출(전체 컬럼 값 체크)
function cellendeditAllHandler(_datas, _gridId){
	var org_rows = $grid_rows[_gridId]["org_rows"];
    var editedRows = $grid_rows[_gridId]["editedRows"];
	var _id = _datas.uid;
	$.each(_datas, function (_colname, value) {
		if(_colname != "uid"){
			if(org_rows[_id] != undefined){
		    	var _keyarr = Object.keys(org_rows[_id]);
		    	if($.inArray(_colname, _keyarr) > -1){
		    		if(editedRows[_id] == undefined){
		    			if(org_rows[_id][_colname] != getCellValue(value)){
		    				var _newObj = {};
		        			_newObj[_colname] = getCellValue(value);
		        			editedRows[_id] = _newObj;
		    			}
		    		}else{
		    			if(org_rows[_id][_colname] == getCellValue(value)){
		        			if(editedRows[_id][_colname] != undefined){
		        				delete editedRows[_id][_colname];
		        			}
		        		}else if(value != undefined){
		        			editedRows[_id][_colname] = getCellValue(value);
		        		}
		    		}
		    	}
			}
		}
	});
	if(editedRows[_id] !== undefined){
    	var _isedit = false;
    	for(var _name in editedRows[_id]){
    		var _value = editedRows[_id][_name] || "";
    		var _oldValue = org_rows[_id][_name] || "";
    		if(_value != _oldValue){
    			_isedit = true;
    			break;
    		}
    	}
    	if(!_isedit){
    		delete editedRows[_id];
    	}
    }
	if(_gridId){
    	$('#' + _gridId).jqxGrid('refreshdata');
    }
}

//grid - update/insert 발생시 저장 처리 강제 발생, 컬럼값 바꾸기전에 호출
function cellbegineditUsedHandler(_colname, _datas, _gridId) {
	var org_rows = $grid_rows[_gridId]["org_rows"];
    var _id = _datas.uid;
    window.$select_grid_id = _gridId;
    if(org_rows[_id] !== undefined){
    	var _org_col = org_rows[_id][_colname];
    	if(_org_col === undefined){
    		org_rows[_id][_colname] = getCellValue(_datas[_colname]);
    	}
    }else{
    	var _newObj = {};
    	_newObj[_colname] = getCellValue(_datas[_colname]);
    	org_rows[_id] = _newObj;
    }
};

//grid - update/insert 발생시 저장 처리 강제 발생, 컬럼값 바꾼후에 호출
function cellendeditUsedHandler(_colname, _datas, _gridId){
	var org_rows = $grid_rows[_gridId]["org_rows"];
    var editedRows = $grid_rows[_gridId]["editedRows"];
	var _id = _datas.uid;
    if(org_rows[_id] != undefined){
    	var _keyarr = Object.keys(org_rows[_id]);
    	if($.inArray(_colname, _keyarr) > -1){
    		if(editedRows[_id] == undefined){
    			if(org_rows[_id][_colname] != getCellValue(_datas[_colname])){
    				var _newObj = {};
        			_newObj[_colname] = getCellValue(_datas[_colname]);
        			editedRows[_id] = _newObj;
    			}
    		}else{
    			if(org_rows[_id][_colname] == getCellValue(_datas[_colname])){
        			if(editedRows[_id][_colname] != undefined){
        				delete editedRows[_id][_colname];
        			}
        		}else if(_datas[_colname] != undefined){
        			editedRows[_id][_colname] = getCellValue(_datas[_colname]);
        		}
    		}
    	}
    }else{
    	return false;
    }
    if(editedRows[_id] !== undefined){
    	var _isedit = false;
    	for(var _name in editedRows[_id]){
    		var _value = editedRows[_id][_name] || "";
    		var _oldValue = org_rows[_id][_name] || "";
    		if(_value != _oldValue){
    			_isedit = true;
    			break;
    		}
    	}
    	if(!_isedit){
    		delete editedRows[_id];
    	}
    }
    if(_gridId){
    	$('#' + _gridId).jqxGrid('refreshdata');
    }
}

//grid - update/insert 발생시 저장 처리
function fnSaveConfirm(url, _gridId, callBackFn){
    var editedRows = $grid_rows[_gridId]["editedRows"];
	if($.type(callBackFn) != 'function'){
		callBackFn = function(data, dataType){
			alert(MESSAGES_OK.SAVE);
			fnResetGridEditData(_gridId);
			$('#'+_gridId).jqxGrid('refresh');
			//fnSearch();
		};
	}
	if(getObjectSize(editedRows) > 0){
		if(confirm(message(MESSAGES_CFM.SAVE))){
			var _grid = $("#"+_gridId);
			var postData = new Array();//수정시 해당 row 데이터 저장
			for(var _name in editedRows){
				var data = _grid.jqxGrid('getrowdatabyid', _name);
				$.each(data, function(_inm, ivl){
					data[_inm] = getCellValue(ivl);
				});
				postData.push(data);
			}
			if(postData.length <= 0){
				alert(MESSAGES_VALID.NON_SAVE);
				return;
			}
			var editedRowsJson = JSON.stringify(postData);
			$.ajax({
				type: "POST",
				url: url,
				dataType: "text",
				data: {data : editedRowsJson},
				success: callBackFn,
				error: function(XMLHttpRequest, textStatus, errorThrown){
					//alert('Error : ' + errorThrown);  //  Ajax가 실패한 경우 에러메시지출력
				}
			});
		 }else{
			 alert("취소 되었습니다.");
		 }
	 }else{
		 alert(message(MESSAGES_VALID.NON_SAVE));
	 }
}

//이벤트 발생시 화면카운터 재정의
function pageCount(id){
	var datainfo = $("#"+id).jqxGrid('getdatainformation');
	 label.text(datainfo.rowscount+' 건이 조회 되었습니다.');
}

/**
 * @날짜 : 2014. 12. 08.
 * @설명 : grid : - Delete 발생시 처리
 * @param _url : 통신할 url
 * @param _obj : 서버에 보낼 JSON 데이터
 * @param _seq : _obj 데이터 중에 체크할 키이름
 * @param _jqxgrid : grid id
 */
function fnDeleteHandler(_url, _obj, _seq, _jqxgrid, _message, callBackFn){
	if(_url.indexOf("?") == -1){
		_url = _url+"?deleteFlag=true";
	}
	if(!_obj){
		alert("삭제할 대상이 없습니다.");
		return false;
	}
	var _obj_type = $.type(_obj);

	if($.type(callBackFn) != 'function'){
		callBackFn = function(data, dataType){
			if(data && data.message != undefined){
				if(data && data.message == "Y"){
						alert(MESSAGES_OK.DELETE);
					if(_obj_type == "object"){
						var commit = $("#" + _jqxgrid).jqxGrid('deleterow', _obj.uid);
						pageCount(_jqxgrid);
					}else{
						$("#" + _jqxgrid).jqxGrid('clearselection');
						fnSearch();
					}
				}else{
					alert(MESSAGES_ERR.DELETE_FAIL);
				}
			}else{
				alert(MESSAGES_OK.DELETE);
				$("#" + _jqxgrid).jqxGrid('clearselection');
				fnSearch();
			}
		}
	}


	if(_obj_type == 'object'){
		if(_obj[_seq] != null && _obj[_seq] != undefined && _obj[_seq] != 'null' && _obj[_seq] != 'undefined' && _obj[_seq] != ""){
			if(confirm(message(_message || MESSAGES_CFM.DELETE))){
				alert(_obj[_seq]);
				$.ajax({
					type: "POST",
//					dataType: "json",
					url: encodeURI(_url),
					data: _obj,
					success:callBackFn,
					 error: function(XMLHttpRequest, textStatus, errorThrown){
							alert(MESSAGES_ERR.COMMON_ERR +' : ' + errorThrown);  //  Ajax가 실패한 경우 에러메시지출력
					 }
				});
		    }
		}else{
			delete editedRows[_obj.uid];
			var commit = $("#" + _jqxgrid).jqxGrid('deleterow', _obj.uid);
		}
	}else if(_obj_type == 'array'){

		var selectedRecords = new Array();
		$(_obj).each(function(index, _obj_item){
			if(_obj_item && _obj_item[_seq] != null && _obj_item[_seq] != undefined && _obj_item && _obj_item[_seq] != 'null' && _obj_item[_seq] != 'undefined' && _obj_item[_seq] != ""){
				selectedRecords.push(_obj_item);
			}else{
				delete editedRows[_obj_item.uid];
				$("#" + _jqxgrid).jqxGrid('deleterow', _obj_item.uid);
			}
		});
		if(selectedRecords.length > 0){
			if(confirm(message(_message || MESSAGES_CFM.DELETE))){
				$.ajax({
					type: "POST",
					url: _url,
				 //dataType: "json",
					data: {type : 'array', data : JSON.stringify(selectedRecords)},
					success:callBackFn,
					 error: function(XMLHttpRequest, textStatus, errorThrown){
							alert(MESSAGES_ERR.COMMON_ERR +' : ' + errorThrown);  //  Ajax가 실패한 경우 에러메시지출력
					 }
				});
		    }
		}
	}else{
		alert("알수 없는 타입의 데이터 입니다.");
	}
}

function fnDeleteConfirm(url,_gridId,keyColumn,callBackFn){
     var cells = $('#'+_gridId).jqxGrid('getselectedcell');
	 var selectedrowindex = cells.rowindex;
	 var keyValue = $('#'+_gridId).jqxGrid('getcellvalue', selectedrowindex, keyColumn);


     var id = $('#'+_gridId).jqxGrid('getrowid', selectedrowindex);

 	if($.type(callBackFn) != 'function'){
		callBackFn = function(data, dataType){
			 var commit = $('#'+_gridId).jqxGrid('deleterow', id);
			alert(MESSAGES_OK.DELETE);
			//fnSearch();
		};
	}

	if(keyValue == null || keyValue == undefined || keyValue == ''){
			 var commit = $('#'+_gridId).jqxGrid('deleterow', id);
	}else{
		 if(confirm(message(MESSAGES_CFM.DELETE))){
			  var key = new Object();
				    key.keyColumn = keyColumn;
				    key.keyValue = keyValue;
			 var keyData = JSON.stringify(key);
			         $.ajax({
					 type: "POST",
					 url: url,
					 dataType: "text",
				     data: {data: keyData},
				 	 success:callBackFn,
				 	 error: function(XMLHttpRequest, textStatus, errorThrown){
				             alert('Error : ' + errorThrown);  //  Ajax가 실패한 경우 에러메시지출력
				    }
			 });
	    }
	}
}
//row update시 설정 저장 로직
function cellclass(row, datafield, value, rowdata) {
	var _gridId = window.$select_grid_id || $(this.owner).attr('host').attr('id');
	if(_gridId){
		var editedRows = $grid_rows[_gridId]["editedRows"];
		if(editedRows[$("#" + _gridId).jqxGrid('getrowid', row)]){
			return "editedRow";
		}
	}
}

/**
 * 엑셀 다운로드
 * @param grid_id
 * @param exporttitle
 * @param etc
 */
function grideExportExcel(grid_id, exporttitle){

	if(!grid_id){
		alert('그리드를 지정하지 않으셨습니다.');
		return;
	}
	$("#_xmlDownLoadForm").remove();
	var excelObj = {
		local_grid : $("#"+grid_id),
		_colNameArrs : [],
		_colTextArrs : [],
		_cellsalignArrs : [],
		_StatusRowjqxgr : [],
		_cellsFormat : {},
		fnGetColgroups : function (){
			var _colgroups = this.local_grid.jqxGrid('columngroups');
			var _colgroupStr = "";
			if(_colgroups){
				var _colgroupArrs = [];
				$.each(_colgroups, function(i, obj){
					var _name = obj.text + "▨";
					var _groups = obj.groups;
					var itemstr = "";
					$.each(_groups, function(j, subObj){
						if(itemstr != "")
							itemstr += "▥";
							itemstr += $.trim(subObj.displayfield);
					});
					_name += itemstr;
					_colgroupArrs.push(_name);
				});
				_colgroupStr = _colgroupArrs.join('▤');
			}
			return _colgroupStr;
		},
		fnGetColumns : function(){
			var columns = this.local_grid.jqxGrid('getstate').columns || null;
			var _grid = this.local_grid;
			if(columns == null || Object.keys(columns).length == 0){
				alert('그리드가 존재하지 않습니다.');
				throw "";
			}
			var gridDatafields = {};
			if(this.local_grid.jqxGrid('source')){
				var _source = this.local_grid.jqxGrid('source')['_source'];
				if(_source){
					var _datafields = _source['datafields'];
					$.each(_datafields, function(key, obj) {
						gridDatafields[obj.name] = obj.type;
					});
				}
			}
			var _colTypeArrs = [];
			var _cellsFormatArrs = [];
			var _cellsFormat = this._cellsFormat;
			$.each(columns, function(key, obj) {
				if(!obj.hidden){
					excelObj._colNameArrs.push(key);
					excelObj._colTextArrs.push(obj.text);
					excelObj._cellsalignArrs.push(obj.cellsalign);
					_colTypeArrs.push(gridDatafields[key] || 'string');
					var cells_format = ''+_grid.jqxGrid('getcolumn', key).cellsformat;
					_cellsFormatArrs.push(cells_format);
					_cellsFormat[key] = cells_format;
				}
				excelObj._StatusRowjqxgr.push(obj.hidden);
			});
			if(excelObj._colNameArrs.length <= 0){
				alert('엑셀 다운로드할 내용이 없습니다.');
				throw "";
			}
			var reStr = '<input type="hidden" name="colNames" value="'+excelObj._colNameArrs.join('▤')+'" />'
			+ '<input type="hidden" name="colTexts" value="'+excelObj._colTextArrs.join('▤')+'" />'
			+ '<input type="hidden" name="cellSalign" value="'+excelObj._cellsalignArrs.join('▤')+'" />'
			+ '<input type="hidden" name="colTypes" value="'+_colTypeArrs.join('▤')+'" />'
			+ '<input type="hidden" name="cellsFormats" value="'+_cellsFormatArrs.join('▤')+'" />';
			return reStr;
		},
		fnGetRowsData : function(){
			var rows=this.local_grid.jqxGrid('getrows');     // Get First row to get the labels
		    if(!rows || rows.length <= 0){
		    	alert("엑셀로 출력 할 내용이 없습니다.");
		    	throw "";
		    }
		    var rowsData = "";
		    var _cellsFormat = this._cellsFormat;
		    $.each(rows, function(i, obj){
		    	var tempData = null;
		    	$.each(excelObj._colNameArrs, function(j, keyname){
		    		var tempItem = obj[keyname];
		    		var typeItem = $.type(tempItem);
		    		if(tempData != null){
		    			tempData += "▤";
		    		}else if(tempData == null){
		    			tempData = "";
		    		}
		    		if (typeItem == "date") {
		    			tempData += $.format.date(tempItem, _cellsFormat[keyname]);
					}else if(!typeItem || typeItem == "null" || typeItem == "undefined"){
						tempData += "";
					}else if(tempItem.replace){
						tempData += $.trim(tempItem.replace(/(<([^>]+)>)/ig,""));
					}else{
						tempData += tempItem;
					}
		    	});
		    	rowsData += ($.trim(tempData) + "▥");
		    });
		    return rowsData;
		},
		fnGetStatusRowjqxgr : function(){
			var statusrowjqxgrid = $(this.local_grid.find('#statusrowjqxgrid')).find('.jqx-grid-cell');
		    var statusrowjqxgr = "";
		    if(statusrowjqxgrid.length > 0){
		    	$.each(statusrowjqxgrid, function(k, obj){
		    		if(!excelObj._StatusRowjqxgr[k]){
		    			if(statusrowjqxgr != ""){
			    			statusrowjqxgr += "▤";
			    		}
			    		statusrowjqxgr += $.trim(obj.textContent);
		    		}
		    	});
		    }
			return '<input type="hidden" name="statusrow" value="'+statusrowjqxgr+'" />';
		}
	};

	var _formStr = '<form id="_xmlDownLoadForm" action="/mng/downLoadXlsFile.action" method="post" encType="multipart/form-data">'
    + '<input type="hidden" name="excelName" value="'+exporttitle+'" />'
    + '<input type="hidden" name="colgroups" value="" />'
    + excelObj.fnGetColumns()
    + '<textarea name="content"></textarea>'
    + excelObj.fnGetStatusRowjqxgr()
    + '<input type="file" name="filexls" />'
    + '</form>';
	var _form = jQuery(_formStr);
	_form.find("input[name='colgroups']").val(excelObj.fnGetColgroups());
	_form.find("textarea[name='content']").text(excelObj.fnGetRowsData());
	_form.appendTo("body").submit().remove();
}
