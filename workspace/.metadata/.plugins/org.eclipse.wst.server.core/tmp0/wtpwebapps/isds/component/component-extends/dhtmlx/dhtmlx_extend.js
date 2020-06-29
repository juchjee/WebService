/*######################################
 * dhtmlx Common Variables & Function
 *#####################################*/
var editCol = "";
var delCol = "";
var chkCol = "chk";
var editStatCol = "editStat";
var cudKeyCol = "cudKey";
var actInsert = "INSERT";
var actUpdate = "UPDATE";
var actDelete = "DELETE";
var gAutoHeight = true;
var gridHeight = -50;
// Insert,Update Delete 구분 해주는 로직(in Grid)
function gfn_gridEditCell(stage, rId, cInd, nValue, oValue) {
	if (stage == 0) { // Before Editing
		var pk = this.getUserData("", "pk");

		var cudKeyColIdx = this.getColIndexById(cudKeyCol);

		if (pk != null && pk != "") {
			var arr = pk.split(",");
			for (var i = 0; i < arr.length; i++) {
				var pkColIdx = this.getColIndexById(arr[i]);
				if (this.cells(rId, cudKeyColIdx).getValue() != actInsert) {
					if (pkColIdx >= 0 && pkColIdx == cInd) {
						MsgManager.alertMsg("WRN003"); // 키컬럼 수정불가
						return false;
					}
				}
			}
		}
	} else if (stage == 1) { // Progressing Editing
		if (this.getColType(cInd) == "ed"
				|| this.getColType(cInd) == "dhxCalendarA") {
			var colId = this.getColumnId(cInd);
			var classNm = this.getUserData("", "@" + colId);
			if (classNm != null) {
				$("td.cellselected").find("input").addClass(classNm).keyup();
			}
			$(".dhx_combo_edit").select();
		} else if (this.getColType(cInd) == "ch") {
			setUpdateAcType(this, rId);
		} else if (this.getColType(cInd) == "radio") {
			setUpdateAcType(this, rId);
		}
	} else if ((stage == 2)) { // After Editing
		var colId = this.getColumnId(cInd);

		$("td").css("background", "");
		if ((oValue != nValue)) {
			setUpdateAcType(this, rId);
		}
	}
	return true;
}
// set crud status 체크
function setUpdateAcType(obj, rowId) {
	var cudKeyColIdx = obj.getColIndexById(cudKeyCol);
	if (cudKeyColIdx >= 0) {

		var cell = obj.cells(rowId, cudKeyColIdx);
		if (cell.getValue() != actInsert && cell.getValue() != actUpdate) {
			cell.setValue(actUpdate);
			editCol = editCol + (rowId - 1) + ";";
			var editStatColIdx = obj.getColIndexById(editStatCol);
			if (editStatColIdx >= 0) {
				var x = obj.cells(rowId, editStatColIdx);
			}
		}
	}
}

// 다중 calendar 입력값에 따른 날짜 계산
function setSens(flag, id, k) {
	if (flag == 1) {
		if (k == "min") {
			calMain.setSensitiveRange(byId(id).value, null);
		} else {
			calMain.setSensitiveRange(null, byId(id).value);
		}
	}
	if (flag == 2) {
		calMain.setSensitiveRange(new Date(), new Date());
	}
}

// element Id 가져오는 부분
function byId(id) {
	return document.getElementById(id);
}

// cell 계산
function cell_calculator(grid, id, stNum, endNum) {
	sum = 0;
	for (var i = stNum; i < endNum; i++) {
		sum = sum + grid.setCells(id, i).getValue() * 1;
	}
	return sum;
}

// 다중 Grid 사용시 버튼 가져오는 부분
var subToolbar = function(toolbar, sublayout, btn_id_array) {
	toolbar = sublayout.attachToolbar();

	var size = 18;
	toolbar.setIconSize(18);
	toolbar.setIconsPath("/images/button/dhtmlx/");
	toolbar.loadStruct("/common/json/button.json", fn_onLoad);

	function fn_onLoad() {
		var item_id_set_arr = [ 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11 ];

		for (var i = 0; i < btn_id_array.length; i++) {
			var index = item_id_set_arr.indexOf(btn_id_array[i]);
			if (index > -1) {
				item_id_set_arr.splice(index, 1);
			}
		}
		for (var i = 0; i < item_id_set_arr.length; i++) {
			toolbar.removeItem("btn" + item_id_set_arr[i]);
			toolbar.removeItem("sep" + item_id_set_arr[i]);
		}
	}
	return toolbar;
}

// 팝업 불러오는 로직
function gfn_load_pop(eleId, view_path, paramArr, plusParamData) {
	var pLayout;
	var default_bln = true;
	
	dhxWins = new dhtmlXWindows();
	if (!$('#' + eleId).length) {
		if (dhxWins.isWindow(eleId)) {
			while (dhxWins.isWindow(eleId)) {
				var number = eleId.replace(/[^0-9]/g, '');
				eleId = eleId.replace(/\d+/g, '') + number++;
			}
		}
		var $div = $('<div/>').appendTo('#container');
		$div.attr('id', eleId);
	}

	w1 = dhxWins.createWindow(eleId, 20, 30, 800, 500);

	dhxWins.window(eleId).setModal(default_bln);
	pLayout = w1.attachLayout("1C");
	pLayout.attachEvent("onContentLoaded", function(id) {

		pLayout.cells(id).hideHeader();
		ifr = pLayout.cells(id).getFrame();
		dhxWins.window(eleId).setDimension(ifr.contentWindow.config.width,
				ifr.contentWindow.config.height);
		w1.setText(ifr.contentWindow.config.title);
		pLayout.cells(id).setSizes();
	});
	if (plusParamData != undefined) {
		pLayout.cells("a").attachURL("/erp/scm/popup/" + view_path + ".do?innerName=" + paramArr[0]
						+ "&kind=" + paramArr[1] + "&gubn=" + paramArr[2]+ "&addData=" + plusParamData);
	} else {
		pLayout.cells("a").attachURL("/erp/scm/popup/" + view_path + ".do?innerName=" + paramArr[0]
						+ "&kind=" + paramArr[1] + "&gubn=" + paramArr[2]);
	}
	
	w1.attachEvent("onClose",function(win){
		$(window.parent.document).find("#id").focus();
		return true;
	});
	
}

// 파일 업로드 해주는 로직
function gfn_getFileFormat(fileVal) {
	var data = [ 'bmp', 'doc', 'gif', 'jpg', 'txt', 'pdf', 'xls', 'xlsx','ppt', 'zip', 'alz' ];
	var fileFormat = '(', RegExpFormat = '', blnRst, formatObj;

	for (var i = 0; i < data.length; i++) {
		if (i == data.length - 1) {
			fileFormat += data[i];
			fileFormat = fileFormat.toLowerCase() + ')'
			break;
		}
		fileFormat += data[i] + '|';
	}
	RegExpFormat = "\." + fileFormat + "$";
	blnRst = (new RegExp(RegExpFormat, "i")).test(fileVal)
	formatObj = {
		format : fileFormat,
		flag : blnRst
	}
	return formatObj
}

function gfn_getImageFormat(fileVal) {
	var data = [ 'bmp', 'gif', 'jpg','jpeg', 'tiff', 'png'];
	var fileFormat = '(', RegExpFormat = '', blnRst, formatObj;

	for (var i = 0; i < data.length; i++) {
		if (i == data.length - 1) {
			fileFormat += data[i];
			fileFormat = fileFormat.toLowerCase() + ')'
			break;
		}
		fileFormat += data[i] + '|';
	}
	RegExpFormat = "\." + fileFormat + "$";
	blnRst = (new RegExp(RegExpFormat, "i")).test(fileVal)
	formatObj = {
		format : fileFormat,
		flag : blnRst
	}
	return formatObj
}

function fileupload(tagId,imgId,callbackFn){
	 $('#'+tagId).fileupload({
	        dataType: 'json',
	        add: function (e, data) {

	            if ((/\.(gif|jpg|jpeg|tiff|png)$/i).test(data.files[0].name)) {
	                if (data.files && data.files[0]) {
	                    var reader = new FileReader();
	                    reader.onload = function(e) {
	                        $('#'+imgId).attr('src', e.target.result);
	                    }
	                    reader.readAsDataURL(data.files[0]);
	                    data.submit();
	                    if (callbackFn != undefined) {
	                        callbackFn.call(this, data);
	                    }
	                }
	            }

	        },
	        
	        done: function (e, data) {
	        	$("tr:has(td)").remove();
	            $.each(data.result, function (index, file) {


	                $("#uploaded-files").append(
	                		$('<tr/>')
	                		.append($('<td/>').text(file.fileName))
	                		.append($('<td/>').text(file.fileSize))
	                		.append($('<td/>').text(file.fileType))
	                		.append($('<td/>').html("<a href='rest/controller/get/"+index+"'>Click</a>"))
	                		)
	            });
	        },

	        progressall: function (e, data) {
		        var progress = parseInt(data.loaded / data.total * 100, 10);
		        $('#progress .bar').css(
		            'width',
		            progress + '%'
		        );
	   		},

			dropZone: $('#dropzone')
	    });
	 return true;
}
// 조회시 date type formatting 해주는 로직
function searchDate(dateValue) {
	var value = '';
	var splitfrDate = dateValue.split("/");
	for (var i = 0; i < splitfrDate.length; i++) {
		value = value + splitfrDate[i];
	}

	return value;
}

// 사업장 번호 체크
function gfn_check_compNo(compNo) {
	var check = true;
	if (compNo.length != 10) {
		check = false;
	}
	if (check) {
		var sum = 0;
		var checkNo = "137137135";
		for (var i = 0; i < checkNo.length; i++)
			sum += (compNo.charAt(i) - '0') * (checkNo.charAt(i) - '0');
		sum += ((compNo.charAt(8) - '0') * 5) / 10;
		sum %= 10;
		sum = 10 - sum;
		if ((sum == compNo.charAt(9) - '0')) {
			check = true;
		} else {
			check = false;
		}
	}
	return check;
};

// 법인번호 체크
function gfn_check_corporateNo(corpNo) {
	var check = true;
	if (corpNo.length != 13) {
		check = false;
	}
	if (check) {
		var arr_regno = corpNo.split("");
		var arr_wt = new Array(1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2);
		var iSum_regno = 0;
		var iCheck_digit = 0;

		for (i = 0; i < 12; i++) {
			iSum_regno += eval(arr_regno[i]) * eval(arr_wt[i]);
		}
		iCheck_digit = 10 - (iSum_regno % 10);
		iCheck_digit = iCheck_digit % 10;

		if (iCheck_digit != arr_regno[12]) {
			check = false;
		} else {
			check = true;
		}
	}
	return check;
};

// 주민번호 체크
function gfn_check_jumin(grid, colId) {
	var jFlag = true;
	for (var i = 0; i < grid.getRowsNum(); i++) {
		colIdIdx = grid.getColIndexById(colId);
		colVal = grid.dxObj.cells2(i, colIdIdx).getValue();
		var classNm = grid.dxObj.getUserData("", "@" + colId);
		cudVal = grid.dxObj.cells2(i,grid.getColIndexById("cudKey")).getValue();
		
		if (classNm == 'format_jumin') {
			if (colVal != '' && (cudVal == 'INSERT' || cudVal == 'UPDATE')) {
				jFlag = check_jumin_flag(colVal);
				if (!jFlag) {
					grid.dxObj.selectRow(grid.dxObj.getRowId(i-1),true);
					break;
				}
			}
		} 
	}
	return jFlag;
}

function gfn_check_fore(grid, colId) {
	var jFlag = true;
	for (var i = 0; i < grid.getRowsNum(); i++) {
		colIdIdx = grid.getColIndexById(colId);
		colVal = grid.dxObj.cells2(i, colIdIdx).getValue();
		var classNm = grid.dxObj.getUserData("", "@" + colId);
		cudVal = grid.dxObj.cells2(i,grid.getColIndexById("cudKey")).getValue();
		
		if (classNm == 'format_foreNo') {
			if (colVal != '' && (cudVal == 'INSERT' || cudVal == 'UPDATE')) {
				jFlag = check_foreNo_flag(colVal);
				if (!jFlag) {
					grid.dxObj.selectRow(grid.dxObj.getRowId(i-1),true);
					break;
				}
			}
		}
	}
	return jFlag;
}

// 주민번호 체크 상세 로직
function check_jumin_flag(value) {
	var preValue = value.substring(0, 6);
	var nextValue = value.substring(7, 14);
	var jumin = preValue + nextValue;
	var fmt = /^\d{6}[1234]\d{6}$/; // 포멧 설정
	if (!fmt.test(jumin)) {
		return false;
	}
	// 생년월일 검사
	var birthYear = (jumin.charAt(6) <= "2") ? "19" : "20";
	birthYear += jumin.substr(0, 2);
	var birthMonth = jumin.substr(2, 2) - 1;
	var birthDate = jumin.substr(4, 2);
	var birth = new Date(birthYear, birthMonth, birthDate);

	if (birth.getYear() % 100 != jumin.substr(0, 2)
			|| birth.getMonth() != birthMonth || birth.getDate() != birthDate) {
		return false;
	}

	// Check Sum 코드의 유효성 검사
	var buf = new Array(13);
	for (var i = 0; i < 13; i++)
		buf[i] = parseInt(jumin.charAt(i));

	multipliers = [ 2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5 ];
	for (var sum = 0, i = 0; i < 12; i++)
		sum += (buf[i] *= multipliers[i]);

	if ((11 - (sum % 11)) % 10 != buf[12]) {
		return false;
	}
	return true;
};

function check_foreNo_flag(value) {
	var preValue = value.substring(0, 6);
	var nextValue = value.substring(7, 14);
	var initNextValue = value.substring(7, 8);
	var valueLength = preValue + nextValue;
	initNextValue = initNextValue*1;
	if(valueLength.length == 13){
		return true;
	}else if(4<initNextValue<9){
		return true;
	}else{
		return false;
	}
};

/*function check_foreNo_flag(value) {
	var preValue = value.substring(0, 6);
	var nextValue = value.substring(7, 14);
	value = preValue + nextValue;
	
	var sum = 0;
    if (value.length != 13) {
        return false;
    } else if (value.substr(6, 1) != 5 && value.substr(6, 1) != 6 && value.substr(6, 1) != 7 && value.substr(6, 1) != 8) {
        return false;
    }
    if (Number(value.substr(7, 2)) % 2 != 0) {
        return false;
    }
    for (var i = 0; i < 12; i++) {
        sum += Number(value.substr(i, 1)) * ((i % 8) + 2);
    }
    if ((((11 - (sum % 11)) % 10 + 2) % 10) == Number(value.substr(12, 1))) {
        return true;
    }
    return false;
};*/

// 단일 컬럼에 대한 merge
function fncRowMerge(colIdx, grid) {
	var preVal = grid.getDxObj().cells2(0, colIdx).getValue();
	var nowVal = "";
	for (var i = 1; i < grid.getRowsNum(); i++) {
		nowVal = grid.getDxObj().cells2(i, colIdx).getValue();
		if (preVal == nowVal) {
			var rowID = grid.getRowId(i);
			var color = $('td').css('background-color');
			grid.getDxObj().setCellTextStyle(rowID, colIdx,
					"color:" + color + ";");

		}
		preVal = nowVal;
	}
};

// 다중 컬럼에 대한 merge
function fn_multiRowMerge(grid, stColIdx, reverse) {
	if (stColIdx == undefined) {
		stColIdx = 0;
	}
	var totNum = grid.getRowsNum();
	var colIdx = grid.getColumnsNum();
	var colArr = new Array(colIdx);
	var oldVal = null;
	var newVal = null;
	for (var i = 0; i < totNum - 1; i++) {
		for (var j = stColIdx; j < colArr.length; j++) {
			oldVal = grid.getDxObj().cells2(i, j).getValue();
			newVal = grid.getDxObj().cells2(i + 1, j).getValue();
			if (oldVal == newVal) {
				var rowID = grid.getRowId(i + 1);
				var color = $('td').css('background-color');
				grid.getDxObj().setCellTextStyle(rowID, j,
						"color:" + color + ";");
			} else {
				oldVal = newVal;
				break;
			}
		}
	}
};

function fn_multiRowMerge2(grid, stColIdx,edColIdx) {
	if (stColIdx == undefined) {
		stColIdx = 0;
	}
	var totNum = grid.getRowsNum();
	var colIdx = grid.getColumnsNum();
	var colArr = new Array(colIdx);
	var oldVal = null;
	var newVal = null;
	for (var i = 0; i < totNum - 1; i++) {
		for (var j = stColIdx; j < edColIdx; j++) {
			oldVal = grid.getDxObj().cells2(i, j).getValue();
			newVal = grid.getDxObj().cells2(i + 1, j).getValue();
			if (oldVal == newVal) {
				var rowID = grid.getRowId(i + 1);
				var color = $('td').css('background-color');
				grid.getDxObj().setCellTextStyle(rowID, j,
						"color:" + color + ";");
			} else {
				oldVal = newVal;
				break;
			}
		}
	}
};

function fncChangeRowColor(colIdx, grid) {
	var preVal = grid.getDxObj().cells2(0, colIdx).getValue();
	var nowVal = "";
	var color = "#FFFFFF";
	for (var i = 1; i < grid.getRowsNum(); i++) {
		nowVal = grid.getDxObj().cells2(i, colIdx).getValue();
		if (preVal == nowVal) {
			var rowID = grid.getRowId(i);
			grid.getDxObj().setRowColor(rowID, color);
		} else {
			if (color == '#FFFFFF') {
				color = "#EAEAEA";
			} else {
				color = "#FFFFFF";
			}

		}
		preVal = nowVal;

	}
};

/* 조회화면에서 등록화면으로 이동[그리드 더블클릭 이벤트 시 사용한다.] */
function gfn_moveMenu(menuCd, param) {
	/* menuCd : 이동할 화면코드 || param : 넘겨줄 파라미터 */
	var cFlag = true;
	var mainMenu = parent.mainMenu;
	var mainTabbar = parent.mainTabbar;
	var ids = mainTabbar.getAllTabs();
	var preId = menuCd;
	for (var i = 0; i < ids.length; i++) {
		if (ids[i] == preId) {
			if (MsgManager.confirmMsg("INF006")) {
				mainTabbar.tabs(preId).detachObject(true);
				var uri = mainMenu.getUserData(preId, "uri");
				mainTabbar.tabs(preId).attachURL("/" + uri + ".do" + param);
				mainTabbar.tabs(preId).setActive();
				cFlag = false;
				break;
			} else {
				cFlag = false;
				return;
			}
		}
	}
	if (cFlag) {
		mainMenu.getDxObj().selectItem(preId, false, false);
		var uri = mainMenu.getUserData(preId, "uri");
		var menuItemText = mainMenu.getDxObj().getItemText(preId);

		mainTabbar.addTab(preId, menuItemText,null, null, true, true);
		mainTabbar.tabs(preId).attachURL("/" + uri + ".do" + param);
	}
};
// 조회화면 params return function
function fn_dbl_params(idx, grid, rId, toMenucd) {
	var obj = {};
	var param = '?';
	for (var i = 0; i < idx.length; i++) {
		obj[idx[i]] = grid.setCells(rId, grid.getColIndexById(idx[i]))
				.getValue();
		param += idx[i] + '=' + obj[idx[i]] + '&';
	}
	param = param + "actTabId=" + toMenucd;
	return param;
};

// 종료버튼 클릭시 insert,update 체크
function cs_close_event(gridArr) {
	var flag = true;
	for (var i = 0; i < gridArr.length; i++) {
		for (j = 0; j < gridArr[i].getRowsNum(); j++) {
			var cudKeyIdx = gridArr[i].getColIndexById('cudKey');
			var cudVal = gridArr[i].setCells2(j, cudKeyIdx).getValue();
			if (cudVal != '') {
				flag = false;
				break;
			}
		}
	}

	return flag;
};