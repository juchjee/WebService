(function(window) {
	// String trim
	if (!String.trim) {
		String.prototype.trim = function() {
			return this.replace(/^\s+|\s+$/g, "");
		};
	}
	var errors = {};
	window.checkImage = function(url, success, failure) {
		var img = new Image();
		var loaded = false;
		var errored = false;
		img.onload = function(){
			if (loaded) return;
			loaded = true;
			if (success && success.call) success.call(img);
		};
		img.onerror = function() {
			if (errored) return;
			errors[url] = errored = true;
			if (failure && failure.call) failure.call(img);
		};
		if (errors[url]) {
			img.onerror.call(img);
			return;
		}
		img.src = url;
		if (img.complete)img.onload.call(img);
	};
})(this);

//jQuery disabled된 input 값까지 가지고 오기
(function($) {
	var purge = function($frame){
		var sem = $frame.length
		var deferred = $.Deferred();
		$frame.load(function() {
			var frame = this;
			frame.contentWindow.document.innerHTML = '';
			sem -= 1;
			if (sem <= 0) {
				$frame.remove();
				deferred.resolve();
			}
		});
		$frame.attr('src', 'about:blank');
		if ($frame.length === 0) deferred.resolve();
		return deferred.promise();
	};
	$.fn.serializeAll = function() {
		var data = $(this).serializeArray();
		$(':disabled[name]', this).each(function() {
			data.push({
				name : this.name,
				value : $(this).val()
			});
		});
		var dataString = "";
		$.each(data, function(count, obj) {
			if (dataString != "") {
				dataString += "&";
			}
			dataString += obj.name + "=" + obj.value;
		});
		return encodeURI(dataString);
	};
	$.fn.purgeFrame = function() {
		var deferred;
		if ($.browser.msie && parseFloat($.browser.version, 10) < 9) deferred = purge(this);
		else {
			this.remove();
			deferred = $.Deferred();
			deferred.resolve();
		}
		return deferred;
	};
})(jQuery);

// object 사이즈 체크
function getObjectSize(obj) {
    var size = 0, key;
    for (key in obj) {
        if (obj.hasOwnProperty(key)) size++;
    }
    return size;
}

//동적 comhelp validation and get
function comHelpparams(param){
	for (var key in paramsValidation) {
		var keyCodeNm = "txt"+key+"Cd";
		var keyNameNm = "txt"+key+"Nm";
		param += "&"+keyCodeNm+"="+ $("input[name='"+keyCodeNm+"']").val();
	}
	return param;
}

// 동적으로 input 생성
function makeInput(name, value) {
	var _input = document.createElement("input");
	_input.setAttribute("type", "hidden");
	_input.setAttribute("name", name);
	_input.setAttribute("value", value);
	return _input;
}

//동적으로 form 생성
//obj : json data, flag : null and false = POST, true = GET, target
function makeForm(ActionURL, obj, flag, target) {
	var _form = document.createElement('FORM');
	_form.name='_formR';
	if(flag){
		_form.setAttribute("method", "GET");
	}else{
		_form.setAttribute("method", "POST");
	}
	_form.action= ActionURL;
	if(target){
		_form.setAttribute("target", target);
	}else{
		_form.setAttribute("target", "_self");
	}
	if (obj) {
		for ( var obj_element in obj) {
			var obj_value = obj[obj_element];
			if (obj_value) {
				if($.isArray(obj_value)){
					for (var i = 0; i < obj_value.length; i++) {
						_form.appendChild(makeInput(obj_element, obj_value[i]));
					}
				}else{
					_form.appendChild(makeInput(obj_element, obj_value));
				}
			}
		}
	}
	document.body.appendChild(_form);
	_form.submit();
}

/**
 * @설명 : SelectBox 인덱스 0을 제외한 값 모두 삭제
 * @param inputId
 */
function selectBoxClear(inputId) {
	$("#" + inputId).children().each(function(index) {
		var obj = $(this);
		var text = obj.text();
		if (index == 0) {
			if (text.indexOf("선택") == -1)
				obj.remove();
		} else {
			obj.remove();
		}
	});
}

/**
 * @설명 : checkbox 전체선택
 * @param checkAllId
 *            전체선택하는 checkbox Id명 - 이것도 checkbox
 * @param checkName
 *            전체선택 되어질 Name(ID값 아님)
 */
function checkBoxAllCheck(checkAllId, checkName) {
	if ($("#" + checkAllId).is(":checked"))
		$("input[name=" + checkName + "]").attr("checked", true);
	else
		$("input[name=" + checkName + "]").attr("checked", false);
}

/**
 * @설명 : checkbox로 일괄수정 - js 유효성 검증 - submit
 * @param checkboxName ->
 *            checkBox의 Name (ID가 아닙니다)
 * @param formId ->
 *            parameter Send Form ID
 * @param actionUrl ->
 *            submit되어질 url
 */
function allModify(checkboxName, formId, actionUrl) {
	var str = $("input:checkbox[name=" + checkboxName + "]:checked");
	var check = str.length;
	if (check == 0) {
		alert("선택된 항목이 없습니다.");
		return false;
	}
	if (!c_confirm(check + "건에 대해서 수정"))
		return false;
	var fm = document.getElementById(formId);
	fm.target = "_self";
	fm.action = actionUrl;
	fm.submit();
}

/**
 * @설명 : 로컬 피씨의 오늘 날짜 구해 오기
 */
function getTimeStamp() {
	var d = new Date();
	var s = leadingZeros(d.getFullYear(), 4) + '-'
			+ leadingZeros(d.getMonth() + 1, 2) + '-'
			+ leadingZeros(d.getDate(), 2);
	return s;
}
/**
 * @날짜 : 2013. 6. 13
 * @설명 : 날짜 더하기(빼기) sDate ->yyyy-mm-dd,nDays 빼거나 더할
 */
function date_add(sDate, nDays) {
	var yy = parseInt(sDate.substr(0, 4), 10);
	var mm = parseInt(sDate.substr(5, 2), 10);
	var dd = parseInt(sDate.substr(8), 10);

	d = new Date(yy, mm - 1, dd + nDays);

	yy = d.getFullYear();
	mm = d.getMonth() + 1;
	mm = (mm < 10) ? '0' + mm : mm;
	dd = d.getDate();
	dd = (dd < 10) ? '0' + dd : dd;

	return '' + yy + '-' + mm + '-' + dd;
}

function leadingZeros(n, digits) {
	var zero = '';
	n = n.toString();

	if (n.length < digits) {
		for (var i = 0; i < digits - n.length; i++)
			zero += '0';
	}
	return zero + n;
}

/**
 * @설명 : Value로 SelectBox를 선택합니다.
 * @param formId
 *            선택되어질 SelectBox ID
 * @param value
 *            선택되어질 Value
 */
function selectBoxValueChoice(formId, value) {
	if (formId.indexOf("|") > -1 && value.indexOf("|")) {
		var tempId = formId.split('|');
		var tempValue = value.split('|');

		if (tempValue.length != tempId.length) {
			alert("Id와 Value 길이가 일치하지 않습니다");
			return false;
		}

		for (var i = 0; i < tempId.length; i++)
			$("#" + tempId[i]).val(tempValue[i]).attr("selected", "selected");

	} else {
		$("#" + formId).val(value).attr("selected", "selected");
	}
}

function c_replaceAll(str, orgStr, repStr) {
	if (str.indexOf(orgStr) > -1) {
		return str.split(orgStr).join(repStr);
	} else {
		return str;
	}
}

function c_replace(str, orgStr, repStr) {
	return c_replaceAll(str, orgStr, repStr);
}

/**
 * 금액 변경
 *
 * @param n
 * @returns
 */
function commify(n) {
	var reg = /(^[+-]?\d+)(\d{3})/;
	n += '';// 숫자를 문자열로 변환
	while (reg.test(n))
		n = n.replace(reg, '$1' + ',' + '$2');
	return n;
}

// 엑셀 스타일의 반올림 함수 정의
function roundXL(n, digits) {
	if (digits >= 0)
		return parseFloat(n.toFixed(digits)); // 소수부 반올림

	digits = Math.pow(10, digits); // 정수부 반올림
	var t = Math.round(n * digits) / digits;

	return parseFloat(t.toFixed(0));
}

/**
 * 해당 id의 값이 입력되었는지 확인합니다 없을 경우 해당 Id의 title이 alert창으로 뜸 | 구분자로 다수처리 가능 Ex ->
 * if(!onlyRequiredValidation('id1|id2')) return false;
 *
 * @param id
 * @returns {Boolean}
 */
function onlyRequiredValidation(id) {
	if (id.indexOf('|') > -1) {
		var tmp = id.split('|');

		for (var i = 0; i < tmp.length; i++) {
			if (!fieldValidater(tmp[i], {
				required : "true"
			}))
				return false;
		}
	} else {
		if (!fieldValidater(id, {
			required : "true"
		}))
			return false;
	}
	return true;
}

/**
 * 금액을 한글로 변경 Ex -> money2han('111111111') -> return 일억일천일백일십일만일천일백일십일
 *
 * @param v
 * @returns {String}
 */
function money2han(v) {
	var num_pattern = /([^0-9],)/;
	var han1 = [ '', '일', '이', '삼', '사', '오', '육', '칠', '팔', '구' ];
	var han2 = [ '', '', '십', '백', '천' ];
	var han3 = [ '', '만', '억', '조', '경' ];
	num_pattern = v.match(num_pattern);
	var out = "";

	if (num_pattern == null && v.length > 0) {
		var numstr, num, str, j;
		v = v.replace(/,/g, "");
		var vv = v;

		if (vv.length < 21) {
			do {
				numstr = vv.substr(vv.length - 4, 4);

				vv = vv.substr(0, vv.length - 4);
				len = numstr.length;

				j = Math.floor((v.length - vv.length - 1) / 4);

				if (parseInt(numstr) > 0) {
					str = "";
					for (var i = 0; i < len; i++) {
						num = parseInt(numstr.substr(i, 1));
						if (num != 0) {
							str = str + han1[num] + han2[len - i];
						}
					}
					out = str + han3[j] + out;
				}
			} while (vv.length > 0);
		}
	}
	return out;
}

/**
 * @param formId
 * @param url
 */
function formSubmit(url, formId) {
	var _form = $("#" + formId);
	_form.attr('method', 'POST');
	_form.attr('target', '_self');
	_form.attr('action', url).submit();
}

/**
 * 숫자와 .점 유효성 검사 id |로 다수 처리가능
 *
 * @param id
 * @returns {Boolean}
 */
function isValid_Num_Dot(id) {
	var tmp_id = id.split('|');

	if (tmp_id <= 0)
		return false;

	for (var i = 0; i < tmp_id.length; i++) {
		var obj = $("#" + tmp_id[i]);
		var sNum = obj.val();
		var title = obj.attr('title');
		var numbers = "1234567890.";
		for (var i = 0; i < sNum.length; i++) {
			if (numbers.indexOf(sNum.charAt(i)) < 0) {
				alert(title + "는 숫자와 점(.)만  입력이 가능합니다.");
				obj.focus();
				return false;
			}
		}
	}
	return true;
}

/**
 * 숫자와 .점 유효성 검사 id |로 다수 처리가능
 *
 * @param id
 * @returns {Boolean}
 */
function isValid_Num_Dot_minus(id) {
	var tmp_id = id.split('|');

	if (tmp_id <= 0)
		return false;

	for (var i = 0; i < tmp_id.length; i++) {
		var obj = $("#" + tmp_id[i]);
		var sNum = obj.val();
		var title = obj.attr('title');
		var numbers = "1234567890.-";
		for (var i = 0; i < sNum.length; i++) {
			if (numbers.indexOf(sNum.charAt(i)) < 0) {
				alert(title + "는 숫자와 점(.)만  입력이 가능합니다.");
				obj.focus();
				return false;
			}
		}
	}
	return true;
}

function undefinedNullCheck(obj) {
	if(typeof obj == 'number')
		return true;
	else if(typeof obj == 'undefined' || obj == null || obj == '')
		return false;
	else
		return true;
}

function nvlTrim(obj, ch) {
	return $.trim(nvl(obj, ch));
}

function nvl_numToString(obj, ch) {
	var _ch = '';
	var objType = typeof obj;
	if (typeof ch != 'undefined')
		_ch = ch;
	if(objType == 'number'){
		return '' + obj;
	}
	if (objType == 'undefined' || obj == null || obj == '')
		return _ch;
	else
		return obj;
}

function nvl(obj, ch) {
	var _ch = '';
	var objType = typeof obj;
	if (typeof ch != 'undefined')
		_ch = ch;
	if (objType == 'undefined' || obj == null || obj == '')
		return _ch;
	else
		return obj;
}

/**
 * - 참조없는 배열복사
 *
 * @param arrayData
 * @returns
 */
function onlyOneArrayData(arrayData) {
	return JSON.parse(JSON.stringify(arrayData));
}

// 배열내에 중복된 요소 제거함수
function fextractDupArr(arr) {
	for (var i = 0; i < arr.length; i++) {
		var checkDobl = 0;

		for (var j = 0; j < arr.length; j++) {
			if (arr[i] != arr[j]) {
				continue;
			} else {
				checkDobl++;
				if (checkDobl > 1) {
					spliced = arr.splice(j, 1);
				}
			}
		}
	}
	return arr;
}

function my_console(str) {
	console && console.log(str);
}

function modalPopUp(url, height) {
	var $url = url;
	$.fancybox({
		'href' : $url,
		showCloseButton : false,
		hideOnOverlayClick : false,
		padding : 0,
		height : height,
		width : 1000,
		scrolling : 'no',
		'autoScale' : false,
		'transitionIn' : 'none',
		'transitionOut' : 'none',
		'type' : 'iframe'
	});
}

// 소수이하 반올림 funcRound('123.5678',2)
function funcRound(data, pntLen) {
	if (isNaN(data) || isNaN(pntLen)) {
		alert('Input value ' + data + 'or decimal below' + pntLen
				+ 'is not numeral.');
		return;
	}
	data = parseFloat(data);
	pntLen = parseInt(pntLen, 10);

	var round = Math.pow(10, pntLen);
	var newDoub = Math.floor(data * round + .5) / round;

	return newDoub;
}

// 입력값에 콤마 추가
function formatNumber3(num) {
	num = new String(num);
	num = num.replace(/,/gi, "");
	return formatNumber2(num);
}

function formatNumber2(num) {
	fl = "";
	if (isNaN(num)) {
		alert("문자는 사용할 수 없습니다.");
		return "";
	}
	if (num == 0)
		return num;

	if (num < 0) {
		num = num * (-1);
		fl = "-";
	} else {
		num = num * 1; // 처음 입력값이 0부터 시작할때 이것을 제거한다.
	}
	num = new String(num);
	temp = "";
	co = 3;
	num_len = num.length;
	while (num_len > 0) {
		num_len = num_len - co;
		if (num_len < 0) {
			co = num_len + co;
			num_len = 0;
		}
		temp = "," + num.substr(num_len, co) + temp;
	}
	return fl + temp.substr(1);
}

/**
 * 핸드폰 번호 인증
 */
function checkHandPhone(obj1, obj2, obj3) {
	var ret = isHandPhone(obj1.value + "-" + obj2.value + "-" + obj3.value);
	if (!ret) {
		alert("휴대전화 형식이 올바르지 않습니다");
		obj1.focus();
		return false;
	}
	return true;
}

function isHandPhone(str) {
	var pt = /01[0|1|6|7|8|9]-[0-9]{3,4}-[0-9]{4}/g;
	if (str.match(pt)) {
		return true;
	} else {
		return false;
	}
}

/**
 * 전화번호 체크로직
 */
function checkPhone(obj1, obj2, obj3) {
	var ret = isPhone(obj1.value + "-" + obj2.value + "-" + obj3.value);
	if (!ret) {
		alert("전화번호 형식이 올바르지 않습니다");
		obj1.focus();
		return false;
	}
	return true;
}

/**
 * 전화번호에 구분자를 붙인다.
 *
 * @param	obj
 */
function addPhoneFormat(obj) {
	var value = obj.value;

	if (trim(value) == "") {
		return;
	}

	value = deletePhoneFormatStr(value);

	if (!isPhone(value)) {
		title = obj.getAttribute("title");

		if (title == null) {
			title = "";
		}

		alert(title + " 형식이 올바르지 않습니다.");
		try{
			obj.focus();
		} catch(ex)	{}

		if (window.event) {
			window.event.returnValue = false;
		}

		return;
	}

	obj.value = addPhoneFormatStr(value);
}

/**
 * 전화번호에 구분자를 붙인다.
 */
function addPhoneFormat2() {
	var obj = window.event.srcElement;
	addColor(obj);
	addPhoneFormat(obj);
}

/**
 * 전화번호에 구분자를 붙인다.
 *
 * @param	str
 */
function addPhoneFormatStr(str) {
	if (str.length <= 4) {
		return	str;
	}
	return	str.substring(0, str.length - 4) + "-" + str.substring(str.length - 4);
}

/**
 * 전화번호에서 구분자를 없앤다.
 *
 * @param	obj
 */
function deletePhoneFormat(obj) {
	obj.value = deletePhoneFormatStr(obj.value);
}

/**
 * 전화번호에서 구분자를 없앤다.
 */
function deletePhoneFormat2() {
	var obj = window.event.srcElement;
	deleteColor(obj);
	deletePhoneFormat(obj);
	obj.select();
}

/**
 * 전화번호에서 구분자 없앤다.
 *
 * @param	str
 */
function deletePhoneFormatStr(str) {
	var temp = '';

	for (var i = 0; i < str.length; i++) {
		if (str.charAt(i) == '-') {
			continue;
		} else {
			temp += str.charAt(i);
		}
	}

	return	temp;
}

function isPhone(strng) {
	var stripped = strng.replace(/[\(\)\.\-\ ]/g, '');
	if (isNaN(parseInt(stripped))) {
		return false;
	}

	if (stripped.length < 9 || stripped.length > 11) {
		return false;
	}

	return true;
}

/**
 * 비밀번호 체크
 */
function checkPassword(obj) {
	var msg = isPassword(obj.value);
	if (msg != "") {
		alert(msg);
		obj.focus();
		return false;
	}
	return true;
}

function isSecretNumber(str) {
	var len = str.length;
	ch = new Array;

	for (var i = 0; i < len; i++) {
		var c = str.charAt(i);
		ch[i % 3] = c;
		if ((i > 1) && (ch[0] == ch[1]) && (ch[0] == ch[2]))
			return true;
	}
	return false;
}

function isSequenceNum(str) {
	var len = str.length;
	ch = new Array;

	for (var i = 0; i < len; i++) {
		var c = str.charAt(i);
		ch[i % 3] = c;
		if (i > 1) {
			if (isInt(ch[0]) && isInt(ch[1]) && isInt(ch[2])) {
				if ((parseInt(ch[0], 10) + 1 == parseInt(ch[1], 10))
						&& (parseInt(ch[0], 10) + 2 == parseInt(ch[2], 10)))
					return true;
				if ((parseInt(ch[0], 10) == parseInt(ch[1], 10) + 1)
						&& (parseInt(ch[0], 10) == parseInt(ch[2], 10) + 2))
					return true;
			}
		}
	}
	return false;
}

function isPassword(strng) {
	var error = "";
	if (strng == "") {
		error = "비밀번호를 입력해주세요";
	}
	strng = strng.toLowerCase();
	if ((strng.length < 6) || (strng.length > 12)) {
		error = "비밀번호는 6자이상 12이하로 입력하셔야 됩니다";
	} else if (((strng.search(/[a-z]+/) == -1) || (strng.search(/[0-9]+/) == -1))) {
		error = "비밀번호는 문자/숫자 조합으로만 가능합니다";
	} else if (isSecretNumber(strng.toUpperCase())) {
		error = "비밀번호에 같은 문자가 3자이상 반복되면 안됩니다.";
	} else if (isSequenceNum(strng.toUpperCase())) {
		error = "비밀번호에 연속되는 숫자가 3자이상 반복되면 안됩니다.";
	}
	return error;
}

// 아이디 체크 로직
function checkUserId(obj) {
	var str = new String(obj.value);
	var retVal = checkSpace(str);
	if (retVal != "") {
		alert("아이디는 빈 공간 없이 연속된 영문 소문자와 숫자, '_' 만 사용할 수 있습니다.");
		obj.focus();
		return false;
	}
	if (str.charAt(0) == '_') {
		alert("아이디의 첫문자는 '_'로 시작할수 없습니다.");
		obj.focus();
		return false;
	}
	/* checkFormat */
	var isID = /^[a-z0-9_]{4,50}$/;
	if (!isID.test(str)) {
		alert("아이디는 4~50자의 영문 소문자와 숫자, '_'만 사용할 수 있습니다.");
		obj.focus();
		return false;
	}
	return true;
}

function checkSpace(inputString) {
	if (inputString.search(/\s/) != -1) {
		return 1;
	} else {
		return "";
	}
}

// 팝업창
// arg1 : url
// arg2 : window name
// arg3 : width
// arg4 : height
// arg5 : 창 중앙 위치 여부
// arg6 : top
// arg7 : left
function showPopup() {
	var url, name, w, h, loca, top, left, status, scroll, resize;
	var menubar, toolbar, locat, fullscreen;
	var winprops, win;
	url = arguments[0];
	name = arguments[1];
	if (arguments[2] == "" || arguments[2] == null)
		w = 300;
	else
		w = arguments[2];
	if (arguments[3] == "" || arguments[3] == null)
		h = 200;
	else
		h = arguments[3];
	if (arguments[4] == "" || arguments[4] == null || arguments[4] == "1"
			|| arguments[4] == "yes") {
		top = (screen.height - h) / 2;
		left = (screen.width - w) / 2;
		loca = 'top=' + top + '; left=' + left + ';';
	} else if (arguments[4] == "0" || arguments[4] == "no") {
		if (arguments[5] == "" || arguments[5] == null)
			top = 0;
		else
			top = arguments[5];
		if (arguments[6] == "" || arguments[6] == null)
			left = 0;
		else
			left = arguments[6];
		loca = 'top=' + top + '; left=' + left + ';';
	} else
		loca = '';
	if (arguments[7] == "" || arguments[7] == null)
		status = '1';
	else
		status = arguments[7];
	if (arguments[8] == "" || arguments[8] == null)
		scroll = '0';
	else
		scroll = arguments[8];
	if (arguments[9] == "" || arguments[9] == null)
		resize = '0';
	else
		resize = arguments[9];
	if (arguments[10] == "" || arguments[10] == null)
		menubar = '0';
	else
		menubar = arguments[10];
	if (arguments[11] == "" || arguments[11] == null)
		toolbar = '0';
	else
		toolbar = arguments[11];
	if (arguments[12] == "" || arguments[12] == null)
		locat = '0';
	else
		locat = arguments[12];
	if (arguments[13] == "" || arguments[13] == null)
		fullscreen = '0';
	else
		fullscreen = arguments[13];
	winprops = 'width=' + w + '; height=' + h + '; ' + loca + ' status='
			+ status + '; scrollbars=' + scroll + '; resizable=' + resize
			+ '; menubar=' + menubar + '; toolbar=' + toolbar + '; location='
			+ locat + '; fullscreen=' + fullscreen;
	win = window.open(url, name, winprops);
	return win;
}

/* 유효한(존재하는) 일(日)인지 체크 */
function isValidDay(yyyy, mm, dd) {
	var m = parseInt(mm, 10) - 1;
	var d = parseInt(dd, 10);
	var end = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) {
		end[1] = 29;
	}
	return (d >= 1 && d <= end[m]);
}
/* 월의 마지막 날짜 */
function getMonthLastDay(yyyy, mm) {
	var m = parseInt(mm, 10) - 1;
	var end = new Array(31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31);
	if ((yyyy % 4 == 0 && yyyy % 100 != 0) || yyyy % 400 == 0) {
		end[1] = 29;
	}
	return end[m];
}

/* 날짜 체크 */
function format_YYYYMMDD(obj) {
	var num, year, month, day;
	num = obj.value;
	year = "";
	month = "";
	day = "";
	if (num == "") {
		obj.value = "";
	}
	if (isNaN(num)) {
		window.alert("날짜입력형식 오류입니다. 숫자로만 작성하셔야 합니다.");
		obj.focus();
		obj.value = "";
	}
	if (num != 0 && num.length >= 8) {
		year = num.substring(0, 4);
		month = num.substring(4, 6);
		day = num.substring(6, 8);
		if (isValidDay(year, month, day) == false) {
			num = "";
			window.alert("유효하지 않는 일자입니다. 다시 한번 확인하시고 입력해 주세요.");
			obj.focus();
			obj.value = "";
		}
	}
	return num;
}


function openWin(url,w,h,e){
	var ex = null;
	try {
		ex = e || window.event;
		ex.returnValue = false;
	}catch(excp){
	}
	window.open(url,"",'width='+w+',height='+h+',resizable=0,scrollbars=0,status=0');
}

function openSite(url,target,e){
	var ex = null;
	try {
		ex = e || window.event;
		ex.returnValue = false;
	}catch(excp){
	}
	window.open(url,target,"width=960,height=768,resizable=1,scrollbars=1,status=0,menubar=0,toolbar=1");
}

function openSiteBc(url,target,e){
	var ex = null;
	try {
		ex = e || window.event;
		ex.returnValue = false;
	}catch(excp){
	}
	window.open(url,target,"width=960,height=768,resizable=1,scrollbars=1,status=0,menubar=0,toolbar=1,alwaysRaised");
}

///////////////////////////////////////////////////////////
// 특정 url로 이동
function goSite(url){
	if(url != ''){
		if(url.indexOf("http")<0) url = "http://"+url;
		popup(url,1024,768,9);
	}else alert('url이 없습니다.');
}


///////////////////////////////////////////////////////////
// 0으로 체우기

function getZeroFill(n,str) {
	var ret="";
	var i=0;
	var len=0;
	if(str == ""){
		ret = "0";
		len = 1;
	}else{
		ret = str;
		len = str.length;
	}
	if(len < n){
		for(i=0;i<n-len;i++){
			ret = "0" + ret;
		}
	}
	return ret;
}

///////////////////////////////////////////////////////////
// 페이지 위치 변경 처리
function goUrl(url,target){
	if(!target) target = window;
	target.location.href=url;
}

///////////////////////////////////////////////////////////
// String 문자열 처리
function LTrim(strValue){
    while (strValue.length>0){
       if(strValue.charAt(0)==' '){
           strValue=strValue.substring(1,strValue.length);
   }
       else
          return strValue;
    }
return strValue;
}

function RTrim(strValue){
    while (strValue.length>0){
       if(strValue.charAt(strValue.length-1)==' '){
           strValue=strValue.substring(0,strValue.length-1);
   }
       else
           return strValue;
   }
   return strValue;
}

/**
 * rtrim
 *
 * @param	text
 * @return	string
 */
function rtrim(text) {
	if (text == "") {
		return	text;
	}
	var len = text.length;
	var st = 0;
	while ((st < len) && (text.charAt(len - 1) <= ' ')) {
		len--;
	}
	return	(len < text.length) ? text.substring(st, len) : text;
}

function Trim(str) {
	var search = 0;
	while ( str.charAt(search) == " ") search = search + 1;
	str = str.substring(search, (str.length));
	search = str.length - 1;
	while (str.charAt(search) ==" ") search = search - 1;
	return str.substring(0, search + 1);
}

function Trim2(str){
	var reg = /\s+/g;
	return str.replace(reg,'');
}

//문자열 변환
function Replace(strString, strChar) {
	var strTmp = "";
	for (var i = 0; i< strString.length; i++) {
		if (strString.charAt(i) != strChar) {
			strTmp = strTmp + strString.charAt(i);
		}
	}
	return strTmp;
}

//문자열 변환
function strReplace(szFind, szReplace, szAll) {
	var i;
	var length;

	length = szReplace.length - szFind.length;

	for (i=0; i < szAll.length; i++) {
		if (szAll.substr(i,szFind.length) == szFind) {
			if ( i > 0 ) {
				if (szFind == "\n") {
					szAll = szAll.substr(0, i-1) + szReplace + szAll.substr(i+szFind.length,szAll.length - (i+szFind.length));
				} else {
					szAll = szAll.substr(0, i) + szReplace + szAll.substr(i+szFind.length,szAll.length - (i+szFind.length));
				}
			} else {
				szAll = szReplace + szAll.substr(i+szFind.length,szAll.length - (i+szFind.length));
			}
			i = i + length;
		}
	}
	return szAll;
}
// 대문자로 변경
function toUpperCase(val){
	return val.toUpperCase();
}

/***************************
 onkeyup="this.value=numFormat(this)"
 123,456 형 숫자로 리턴
**************************/
function numFormat(obj) {
	var num = obj.value;
	var num_str = (num.toString()).replace(/[\(\)\.\,\ ]/g, '');
	var result = '';

	for (var i = 0; i < num_str.length; i++) {
		var tmp = num_str.length - (i + 1);
		if (i % 3 == 0 && i != 0)
			result = ',' + result;
		result = num_str.charAt(tmp) + result;
	}
	obj.value = result;
}

//*******************************
// *** 셀렉트박스 선택 되었는지
// ******************************
function isSelect(sel) {
	if(sel.selectedIndex==0){
		return false;
	}else{
		return true;
	}
}

//*******************************
// *** 라디오버튼 체크 되었는지
// ******************************
function isRadio(sel) {
	var n=0;
	if(sel.length==undefined){
		if(sel.value) n++;
	}else{
		for(var i=0; i<sel.length; i++){
			if(sel[i].checked){
				n++;
			}
		}
	}
	if(n==0){
		return false;
	}else{
		return true;
	}
}

//*******************************
// *** 라디오버튼 값 가져오기
// ******************************
function radioValue(sel) {
	if(sel.length==undefined){
		return sel.value;
	}else{
		for(var i=0; i<sel.length; i++){
			if(sel[i].checked){
				return sel[i].value;
			}
		}
	}
}

//*******************************
// *** 히든폼에 값이 있는지
// ******************************
function isHidden(sel) {
	if(!sel.value){
		return false;
	}else{
		return true;
	}
}

//***************************
// *** 입력이 되었는지 체크
// **************************
function isInput(obj){
	if(obj.type!=undefined){
		if(obj.type=="select-one"){
			if(!isSelect(obj))
			return false;
		}else if(obj.type=="radio" || obj.type==undefined){

			if(!isRadio(obj))
			return false;
		}else if(obj.type=="hidden"){
			if(!isHidden(obj))
			return false;
		}else{
			var val = Trim(obj.value);
			if(val.length==0 || val=="")
			return false;
		}
		return true;
	}else{
		return false;
	}
}

//*******************************************
//*** 값이 같은지 체크 (pwd1/pwd2)
//*******************************************
function isEqual(obj1,obj2){
	if(obj1.value != obj2.value) return false;
	return true;
}

//************************************
//*** 입력된 문자의 길이가 같은지 체크
//************************************
function isChkLen(obj,len){
	if(obj.value.length != len)  return false;
	return true;
}

//***********************************
// *** 입력된 문자의 길이 범위를 체크
//***********************************
function isBtnLen(obj,len1,len2){
	if(obj.value.length <len1 && obj.value.length > len2) return false;
	return true ;
}

//***********************************
// *** 입력된 문자의 길이 범위를 err체크
//***********************************
function isBtnLens(obj,len1,len2){
	if(obj.value.length <len1 || obj.value.length > len2) return false;
	return true ;

}


//*****************************//
//*** 숫자만 입력 가능
//*****************************//
function isNum(obj){
	if(obj.value.search(/\D/) != -1 ) return false;
	return true ;
}

//*****************************//
//***특수문자 제어 기능 (영문과 숫자만)
//*****************************//
function isOnlyEng(obj) {
	var inText = obj.value;
	var ret;
	for (var i = 0; i < inText.length; i++) {
		ret = inText.charCodeAt(i);
		if ((ret > 122) || (ret < 48) || (ret > 57 && ret < 65) || (ret > 90 && ret < 97)) {
			return false;
		}
	}
	return true;
}

//****************************************
//*** 입력된 문자열이 주민등록번호인지 체크
//****************************************
function isJuminNum(aNum1, aNum2){
	var tot=0, result=0, re=0, se_arg=0;
	var chk_num="";
	var aNum = aNum1 + aNum2;
	if (aNum.length != 13){
		return false;
	}else{
		for (var i=0; i <12; i++){
			if (isNaN(aNum.substr(i, 1))) return false;
			se_arg = i;
			//외국인 인 경우
			if(i==6) {
				if (aNum.substr(i, 1) == 7 || aNum.substr(i, 1) == 8 || aNum.substr(i, 1) == 5 || aNum.substr(i, 1) == 6)
				return true;
			}
			if (i >= 8) se_arg = i - 8;
			tot = tot + Number(aNum.substr(i, 1)) * (se_arg + 2);
		}
		if (chk_num != "err"){
			re = tot % 11;
			result = 11 - re;
			if (result >= 10) result = result - 10;
			if (result != Number(aNum.substr(12, 1))) return false;
			if ((Number(aNum.substr(6, 1)) < 1) || (Number(aNum.substr(6, 1)) > 4)) return false;
		}
	}
	return true;
}

/**
 * 주민번호 형식인지 체크 한다.
 *
 * @param	str
 * @return	boolean
 */
function isJumin(str) {
	var tmp = 0;
	var sex = str.substring(6, 7);
	var birthday;
	if (str.length != 13) {
		return	false;
	}
	if (sex == 1 || sex == 2) {
		birthday = "19" + str.substring(0, 6);
	} else if (sex == 3  || sex == 4) {
		birthday = "20" + str.substring(0, 6);
	} else {
		return	false;
	}
	if (!isDate(birthday)) {
		return	false;
	}
	for (var i = 0; i < 12 ; i++) {
		tmp = tmp + ((i%8+2) * parseInt(str.substring(i,i+1)));
	}
	tmp = 11 - (tmp %11);
	tmp = tmp % 10;
    if (tmp != str.substring(12, 13)) {
		return	false;
	}
	return	true;
}

/**
 * 날짜 체크
 *
 * @param	date
 * @return	boolean
 */
function isDate(date) {
	var _flag = true;
	var year = 0;
	var month = 13;
	var day = 32;
	if ($.type(date) != "string" && !(date.length == 8 || date.length == 10)){
		return	false;
	}
	try {
		if(date.length == 8){
			year = Number(date.substring(0, 4));
			month = Number(date.substring(4, 6));
			day = Number(date.substring(6, 8));
		}
		if(date.length == 10){
			year = Number(date.substring(0, 4));
			month = Number(date.substring(5, 7));
			day = Number(date.substring(8, 10));
		}
		_flag = false;
	} catch (e) {
		return	false;
	}
	if(_flag){
		return	false;
	}
	if (month < 1 || month > 12) {
		return	false;
	}
	var totalDays;
	switch (month){
		case 1 :
			totalDays = 31;
			break;
		case 2 :
			if (((year % 4 == 0) && (year % 100 != 0)) || (year % 400 == 0)) totalDays = 29;
			else totalDays = 28;
			break;
		case 3 :
			totalDays = 31;
			break;
		case 4 :
			totalDays = 30;
			break;
		case 5 :
			totalDays = 31;
			break;
		case 6 :
			totalDays = 30;
			break;
		case 7 :
			totalDays = 31;
			break;
		case 8 :
			totalDays = 31;
			break;
		case 9 :
			totalDays = 30;
			break;
		case 10 :
			totalDays = 31;
			break;
		case 11 :
			totalDays = 30;
			break;
		case 12 :
			totalDays = 31;
			break;
	}
	if (day > totalDays) {
		return	false;
	}
	return	true;
}


//*****************************//
//***이메일이 올바른지 체크 ***//
//*****************************//
function emailCheck (emailStr) {
	// Email check 함수
	var emailPat=/^(.+)@(.+)$/;
	var specialChars="\\(\\)<>@,;:\\\\\\\"\\.\\[\\]";
	var validChars="\[^\\s" + specialChars + "\]";
	var firstChars=validChars;
	var quotedUser="(\"[^\"]*\")";
	var ipDomainPat="/^\[(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})\]$/";
	var atom="(" + firstChars + validChars + "*" + ")";
	var word="(" + atom + "|" + quotedUser + ")";
	var userPat=new RegExp("^" + word + "(\\." + word + ")*$");
	var domainPat=new RegExp("^" + atom + "(\\." + atom +")*$");
	var matchArray=emailStr.match(emailPat);
	if (matchArray==null) {
		alert("e-mail 주소가 정확하지 않습니다.\n @ 와 . 을 확인하십시오");
		return false;
	}
	var user=matchArray[1];
	var domain=matchArray[2];
	if (user.match(userPat)==null) {
		alert("메일 아이디가 정확한 것 같지 않습니다.");
		return false;
	}
	var IPArray=domain.match(ipDomainPat);
	if (IPArray!=null) {
		for (var i=1;i<=4;i++) {
			if (IPArray[i]>255) {
				alert("IP가 정확하지 않습니다.");
				return false;
			}
		}
		return true;
	}
	var domainArray=domain.match(domainPat);
	if (domainArray==null) {
		alert("이메일 도메인 이름이 정확하지 않습니다.");
		return false;
	}
	var atomPat=new RegExp(atom,"g");
	var domArr=domain.match(atomPat);
	var len=domArr.length;
	if (domArr[domArr.length-1].length<2 ||
		domArr[domArr.length-1].length>3) {
		alert("이메일의 도메인명의 국가코드는 2자보다 크고 3자보다 작아야 합니다.");
		return false;
	}
	if (domArr[domArr.length-1].length==2 && len<3) {
		var errStr="This address ends in two characters, which is a country";
		errStr+=" code. Country codes must be preceded by ";
		errStr+="a hostname and category (like com, co, pub, pu, etc.)";
		alert("유효한 이메일값이 아닙니다. 정확히 입력해 주시길 바랍니다.");
		return false;
	}
	if (domArr[domArr.length-1].length==3 && len<2) {
		var errStr="이 주소는 호스트명이 일치하지 않습니다.";
		alert(errStr);
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////////
// 한글인지 체크
function isHangul (obj){
	if (obj.type == object) {
		var str = obj.value;
        for(var i=0; i<str.length; i++){
            var code = str.charCodeAt(i);
            var ch = str.substr(i,1).toUpperCase();
            code = parseInt(code);
            if((ch<"0" || ch>"9") && (ch<"A" || ch>"Z") && ((code>255) || (code<0))){
            	return true;
            }
        }
        return false;
	} else {
		return isHangul2(obj);
	}
}

// 한글인지 아닌지 구별
function isHangul2(s)
{
     var len;
     len = s.length;
     for (var i = 0; i < len; i++)  {
         if (s.charCodeAt(i) != 32 && (s.charCodeAt(i) < 44032 || s.charCodeAt(i) > 55203))
             return false;
     }
     return true;
}

///////////////////////////////////////////////////////////
// 공백체크
function isEmpty( str ) {
   for ( var i = 0 ; i < str.length ; i++ )    {
      if ( str.substring( i, i+1 ) == " " )
         return true;
   }
   return false;
}

///////////////////////////////////////////////////////////
// 폼 항목들 입력값 체크
function chkInput(obj, msg){
	if(!isInput(obj)){
		alert(msg);
		if(obj.type !="radio" && obj.type != undefined && obj.type != "hidden"){
		obj.value="";
			obj.focus();
		}
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////////
// 폼 항목의 숫자 체크
function chkNum(obj,msg)
{
	if(!chkInput(obj,msg)) return false;
	if(!isNum(obj)){
		alert(msg);
		obj.value="";
		obj.focus();
		return false;
	}
	return true;
}

///////////////////////////////////////////////////////////
// 폼 항목 영문/수자 체크
function chkOnlyEng(obj, msg){
	if(!isInput(obj) || !isOnlyEng(obj)){
		alert(msg);
		obj.value="";
		obj.focus();
		return false;
	}
	return true;
}

function chkBtnLen(obj,len1,len2,msg){
	if(!isBtnLen(obj,len1,len)){
		alert(msg);
		obj.value="";
		obj.focus();
	}
}

/**
 * 특정이름의 멀티체크박스를 체크 또는 체크해제한다.
 * ex) <input type=checkbox name=IDS value='...'>
 *     <script language='javascript'>
 *		toggleMultiChk(this.checked, 'IDS')
 *	   </script>
 *
 * @param bCheck    true|false(체크할 상태)
 * @param itemName  체크대상 체크박스이름
 */
function toggleMultiChk(bCheck, itemName){
	var obj = document.getElementsByName(itemName);
	if(typeof(obj) == 'undefined'){
		return;
	}

	for(var i=0; i<obj.length; i++){
		obj[i].checked = bCheck;
	}
}
/**
 * 체크된 개수
 * @param itemName 체크박스명
 */
function getMultiCheckedNum(itemName){
	var obj = document.getElementsByName(itemName);
	if(typeof(obj) == 'undefined'){
		return 0;
	}
	var chkedCnt=0;

	for(var i=0; i<obj.length; i++){
		if(obj[i].checked)
			chkedCnt++;
	}
	return chkedCnt;
}
/**
 * 체크된 항목들 값을 취합해서 리턴
 * @param itemName 체크박스명
 * @param delim    구분자
 */
function getMultiCheckedString(itemName, delim){
	var obj = document.getElementsByName(itemName);
	var div = delim;
	if(div=="")
	div="|";
	if(typeof(obj) == 'undefined'){
		return "";
	}
	var s="";
	var n=0;
	for(var i=0; i<obj.length; i++){
		if(obj[i].checked){
			if(n>0)
				s += div;
			s += obj[i].value;
			n++;
		}
	}
	return s;
}


/**
 * 체크된 항목들 값을 취합해서 리턴
 * @param itemName 체크박스명
 * @param delim    구분자
 */
function checkedToString(obj, delim){
	var div = delim;
	if(div=="")
	div="|";
	if(typeof(obj) == 'undefined'){
		return "";
	}
	if(obj.length == undefined){
		return (obj.checked) ? obj.value : "";
	}
	var s="";
	var n=0;
	for(var i=0; i<obj.length; i++){
		if(obj[i].checked){
			if(n>0)
				s += div;
			s += obj[i].value;
			n++;
		}
	}
	return s;
}

///////////////////////////////////////////////////////////
// 포커스이동
// onkeyup="moveFocus(this,this.form.jumin2,6)"
function moveFocus(obj1,obj2,movLen){
	movLen = (!movLen) ? 6 : movLen; //  = 6 //포커스이동   ;
	if(obj1.value.length == movLen ) obj2.focus();
}
//대문자로 변경
function upperCase(str) {
	if (str.length = 0 ) return "";
	else return str.toUpperCase();
}
//소문자로 변경
function lowerCase(str) {
	if (str.length = 0 ) return "";
	else return str.toLowerCase();
}

function number(obj) {
	if(!isNumber(obj))obj.value='';
}

/**
 숫자인지 체크
*/
function isNumber2(obj) {
    var pattern = /^[0-9]+$/;
	for(var i = 0; i<obj.value.length; i++) {
		var chr = obj.value.substr(i, 1);
		if(!(pattern.test(chr) || ((event.keyCode>=48) && (event.keyCode<=57)))){
			alert("숫자만 입력 가능합니다.");
			obj.value = obj.value.substr(0, i);
			obj.select();
		}
	}
}

/**
 * 오직 숫자로만 이루어져 있는지 체크 한다.
 *
 * @param	num
 * @return	boolean
 */
function isNumber(num) {
	var re = /[0-9]*[0-9]$/;
	if (re.test(rtrim(num))) return	true;
	return	false;
}


function isNumberValue(elem) {
    var re = /^[-]?\d*\.?\d*$/;
	elem = elem.toString( );
	if (!elem.match(re)) {
	    alert("숫자만 입력가능합니다.");
        return false;
    }
    return true;
}

function isNumVal(elem) {
    var re = /^[-]?\d*\.?\d*$/;
    elem = elem.toString( );
    if (!elem.match(re)) {
        return false;
    }
    return true;
}

/**
 숫자와 , 인지 체크
*/
function isNumberAndDot(elem) {
    var str = elem.value;
    var re = (/^[0-9,\,]+$/);
    str = str.toString( );
	if (!str.match(re)) {
	    alert("숫자만 입력가능합니다.");
        return false;
    }
    return true;
}

// 숫자만 입력하게 한다.
// onkeydown="return onlyNumber();"
function onlyNumber() {
	if ((window.event.keyCode == 8) || (window.event.keyCode == 9) || (window.event.keyCode == 46)) { //백스페이스키와  tab, del키는 먹게한다.
	window.event.returnValue=true;
	}else if ((window.event.keyCode >= 96) && (window.event.keyCode <= 105)) { //숫자패드는 먹게 한다.
		window.event.returnValue=true;
	}else if( (window.event.keyCode<48) || (window.event.keyCode>57) ) {
		window.event.returnValue=false;
	}
}

// 숫자 및 '.' 만 입력
function onlyNumberAndDot() {
	if ((window.event.keyCode == 8) || (window.event.keyCode == 190) || (window.event.keyCode == 9) || (window.event.keyCode == 46)) { //백스페이스키와  '.', tab, del키는 먹게한다.
	window.event.returnValue=true;
	}else if (((window.event.keyCode >= 96) && (window.event.keyCode <= 105)) || (window.event.keyCode == 110)) { //숫자패드는 먹게 한다.
		window.event.returnValue=true;
	}else if( (window.event.keyCode<48) || (window.event.keyCode>57) ) {
		window.event.returnValue=false;
	}
}

function lockKey() {
  if(event.keyCode == 116) {
	  /************************
	    새로고침.. F5 번키.. 막음.
	  ************************/
	  alert("특수 키는 사용하실 수 없습니다.");
	  event.keyCode = 0;
	  event.returnValue = false;
	  return false;
   }else if ((event.keyCode == 78) && (event.ctrlKey == true)) {
	   /************************
	    CTRL + N 즉 새로 고침을 막음.
	  ************************/
	  alert("특수 키는 사용하실 수 없습니다.");
	  event.keyCode = 0;
	  return false;
   }
}

function getContextPath(){
	var _window = window
	var context_path = null;
	if(_window){
		context_path = _window.contextPath
	}else{
		_window = this;
	}
	if(_window && (context_path == undefined || context_path == null)){
		if(_window.opener){
			context_path == _window.opener.contextPath;
		}
		if(context_path == undefined || context_path == null){
			if(_window.parent){
				context_path == _window.parent.contextPath;
			}
			if(context_path == undefined || context_path == null){
				context_path = '';
			}
		}
	}else{
		context_path = '';
	}
	return context_path;
}

//파일 다운로드
function file_onClick(full_file_name , contextPath){
	var sub_path = "/FILESV/";
	var encodeName = getContextPath();
	encodeName += sub_path + encodeURI(full_file_name);
	window.open(encodeName);
}

//숫자만
function numberOnly(val) {
	if($.type(val) != "string")
	val = val.toString(); // 문자로 변환
	return val.replace(/[^0-9]/g, '');
}

//Submit 전 숫자 input 설정
function fnBeforeSettingNumberInput() {
	$(".numberType").each(function() {
		$(this).val(removeComma($(this).val()));
	});
}

//천단위 마다 콤마(,) 찍기
function setComma(val, reval) {
	var numberStr =  String(val);
	var tempNumber1 = "";
	var tempNumber2 = "";
	var tempNumber3 = "";
	if(numberStr.indexOf("-", 0) != -1){
		 tempNumber1 = numberStr.substring(0, 1);
		 tempNumber2 = numberStr.split("-");
		 tempNumber3 = tempNumber2[1];
		 numberStr = removeComma(tempNumber3);
	}
	if(undefinedNullCheck(val)){
		val = removeComma(val);
		var reg = /(^[+-]?\d+)(\d{3})/;	// 정규식
		while (reg.test(val)) {
			val = val.replace(reg, '$1' + ',' + '$2');
		}
		val=tempNumber1+val;
		return val;
	}else{
		return reval;
	}
}

// 콤마(,)제거
function removeComma(val) {
	if($.type(val) != "string") val = "" + val; // 문자로 변환
	return val.replace(/[^0-9|.]/g, '');
}

//콤마(,)제거
function removeComma_minus(val) {
	if($.type(val) != "string") val = val.toString(); // 문자로 변환
	if(val.substring(0, 1) == '-'){
		return '-' + val.replace(/[^0-9|.]/g, '');
	}
	if(val.substring(0, 2) == '0-'){
		return '-' + (val.substring(2, val.length)).replace(/[^0-9|.]/g, '');
	}
	return val.replace(/[^0-9|.]/g, '');
}

function strngToNum(val) {
	return Number(removeComma(val));
}

function strngToNum_minus(val) {
	return removeComma_minus(val);
}

	//숫자 이거나 -체크
function isNumberAndHyphen(elem) {
	var str = elem.value;
	var re = /^[0-9|-]+$/g;
	str = str.toString();
	if (str.match(re)) {
		return true;
	}
	alert("숫자이거나 , -만 입력가능합니다.");
	return false;
}

/**
 * 사업자번호 유효확인
 *
 * @param	from 시작일
 * @param	to 종료일
 * @return	일수
 */
function validBusiNo(membNo){
	if (membNo.length == 10) {
		a  	= membNo.charAt(0);
		b  	= membNo.charAt(1);
		c  	= membNo.charAt(2);
		d  	= membNo.charAt(3);
		e  	= membNo.charAt(4);
		f  	= membNo.charAt(5);
		g  	= membNo.charAt(6);
		h  	= membNo.charAt(7);
		i  	= membNo.charAt(8);
		Osub 	= membNo.charAt(9);
		suma = a*1 + b*3 + c*7 + d*1 + e*3 + f*7 + g*1 + h*3;
		sumb = (i*5) %10;
		sumc = parseInt((i*5) / 10,10);
		sumd = sumb + sumc;
		sume = suma + sumd;
		sumf = a + b + c + d + e + f + g + h + i
		k = sume % 10;i
		Modvalue = 10 - k;
		LastVal = Modvalue % 10;
		if (sumf == 0){
			return false;
		}
	}else{
		return false;
	}
	if ( Osub == LastVal ){
		return true;
	}else {
		return false;
	}
}

function ltrim(str){
    var s = new String(str);
    if (s.substr(0,1) == " ") return ltrim(s.substr(1));
    else return s;
}

function rtrim(str){
    var s = new String(str);
    if(s.substr(s.length-1,1) == " ") return rtrim(s.substring(0, s.length-1))
    else return s;
}

function trim(str){
	return ltrim(rtrim(str));
}

/**
 * 주민번호에 "-"를 붙인다.
 *
 * @param	str
 */
function addJuminFormatStr(str) {
	return	str.substring(0, 6) + "-" + str.substring(6, 13);
}
/**
 * 사업자번호에 "-"를 붙인다.
 *
 * @param	str
 */
function addSaupFormatStr(str) {
	return	str.substring(0, 3) + "-"+ str.substring(3, 5) + "-"+ str.substring(5);
}
/**
 * 숫자에 천단위로 콤마(,) 붙여주기
 * @param obj
 * */
String.prototype.comma = function() {
	var tmp = this.split('.');
	var minus = false;
	var str = new Array();
	if(tmp[0].indexOf('-') >= 0) {
		minus = true;
		tmp[0] = tmp[0].substring(1, tmp[0].length);
	}
	var v = tmp[0].replace(/,/gi,'');
	for(var i=0; i<=v.length; i++) {
		str[str.length] = v.charAt(v.length-i);
		if(i%3==0 && i!=0 && i!=v.length) {
			str[str.length] = '.';
		}
	}
	str = str.reverse().join('').replace(/\./gi,',');
	if(minus) str = '-' + str;
	return (tmp.length==2) ? str + '.' + tmp[1] : str;
};

function oNum(obj) {
	 var val = obj.value;
	var re = /[^0-9\.\,\-]/gi;
	obj.value = val.replace(re, '');
}

function getRandomValue(){
	var date = new Date();
	return  date.getMinutes()+date.getSeconds()+date.getMilliseconds()+Math.floor(Math.random()*100000);
}

/*
 * _url : 요청 Url
 * _data : 요청과 함께 서버에 보내는 string 또는 object
 * _successFn (data,textStatus,jqXHR) : 요청이 성공일때 실행되는 callback 함수
 * _type : 'POST' or 'GET' 서버에 데이터를 HTTP POST 또는 HTTP GET 방식으로 통신
 * _dataType : 서버에서 내려온 data 형식. ( default : xml,json,script,text,html )
 * _async : false 동기식, true 비동기식
 * _errorFn : 요청이 실패일때 실행되는 callback 함수
*/
function fnAjax(_url, _data, _successFn, _type, _dataType, _async, _errorFn, _timeout){
	var _options = {};
	if($.type(_type) == 'string' && _type.length > 2){
		var _upperType = _type.toUpperCase();
		if(_type == 'GET' || _type == 'POST'){
			_options.type = _upperType;
		}else{
			_options.type = 'GET';
		}
	}else{
		_options.type = 'GET';
	}
	if(_data != undefined && _data != null && _data != ""){
		if(_options.type == 'GET'){
			if($.type(_data) == 'string'){
				_options.url = _url + '?' + _data;
			}else if($.type(_data) == 'object'){
				var _dataTemp = '';
				var key;
			    for (key in _data) {
			    	if(_dataTemp != ''){
			    		_dataTemp += '&'
			    	}
			    	_dataTemp += key + '=' + _data[key];
			    }
			    _options.url = _url + '?' + _dataTemp;
			}
		}else{
			_options.url = _url;
			_options.data = _data;
		}
	}
	if($.type(_async) == 'boolean'){
		_options.async = _async;
	}
	if($.type(_successFn) == 'function'){
		_options.success = _successFn;
	}else{
		_options.success = function(data, dataType){
			alert(data);
		};
	}
	if($.type(_errorFn) == 'function'){
		_options.error = _errorFn;
	}else{
		_options.error =  function(XMLHttpRequest, textStatus, errorThrown){
//			alert('Error : ' + errorThrown);  //  Ajax가 실패한 경우 에러메시지출력
		};
	}
	if($.type(_dataType) == 'string'){
		_options.dataType = _dataType;
	}else{
		_options.dataType = 'json';
	}
	if($.type(_timeout) == 'string' || $.type(_timeout) == 'number'){
		_options.timeout = _timeout;
	}
	$.ajax(_options);
}


//태그 문자열을 디코딩 한다
function decodeTag(str){
	return str && str.replace(/&quot;/g,"\"").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&nbsp;/g," ").replace(/&amp;/g,"&");
}

function endsWithJong(str){
	  var sTest = str.charAt(str.length-1);
	  var nTmp = sTest.charCodeAt(0) - 0xAC00;
	  var jong = nTmp % 28;
	  return jong != 0 ? true : false;
	}

function fnValidation(){
	var valid = true;
	var checkedBoolean = false;
	var groupBoolean = false;
	var groupIdx = 0;
	var groupChoseIdx = 0;
	var validNm = "";
	var loopFlag = "on";
	$("[class*=validation]").each(function(index, value){

		if($(this).is(":disabled") == false){
				if($(this).attr("title") == undefined){
					validNm = $(this).attr("name");
					$.word = "은(는)";
				}else{
					validNm = $(this).attr("title");
					var endsWithJongBoolean = endsWithJong(validNm);
					if(endsWithJongBoolean == true){
						$.word = "은";
					}else{
						$.word = "는";
					}
				}

				if($(this).attr("class").indexOf("required") > -1){
					if($(this).val() == ""){
						alert(validNm + $.word+" 필수 항목입니다.");
						this.focus();
						return valid = false;
					}
				}

				if($(this).attr("class").indexOf("password") > -1){
				 var strValue = $(this).val();
				    var strReg = /^[A-Za-z0-9]+$/;
				    if (!strReg.test(strValue)) {
				        alert(validNm +$.word+" 영문과 숫자만 입력 가능합니다.");
				        return valid = false;
				    }else if (strValue.length < 4 || strValue.length > 12) {
				        alert(validNm +$.word+"  4~12자까지만 입력이 가능합니다.");
				        return valid = false;
				    }
				}

				if($(this).attr("class").indexOf("requiredArr") > -1){
					if($(this).length == 0){
						alert(validNm + $.word+" 필수 항목입니다.");
						this.focus();
						return valid = false;
					}
				}
					if($(this).attr("class").indexOf("choose") > -1){
						var targetName = $(this).attr("name");

							if($(this).attr("type") == "checkbox"){
									if($("[name="+targetName+"]").length == $("[name="+targetName+"]").not(":checked").length){
										alert(validNm + $.word+" 필수 선택 항목 입니다.");
										this.focus();
										return valid = false;
									}else{
										 return  checkedBoolean = true;
									}
							}else if($(this).attr("type") == "radio"){
									if($("[name="+targetName+"]").length == $("[name="+targetName+"]").not(":checked").length){
										alert(validNm + $.word+" 필수 선택 항목 입니다.");
										this.focus();
										return valid = false;
									}else{
										 return  checkedBoolean = true;
									}
							}
					}
				}

				if($("[class*=validation]").attr("class").indexOf("groupChoose") > -1){
					var targetGroupName = $(this).attr("class").split("groupChoose:'(")[1].split(")'")[0];

					if($(this).attr("type") == "checkbox"){
							if($(this).is(":checked") == true){
								groupBoolean = true;
							}
					}else if($(this).attr("type") == "radio"){
						if($(this).is(":checked") == true){
							groupBoolean = true;
							}
					}else if($(this).attr("type") == "text"){
						if($(this).val() != ""){
							groupBoolean = true;
						}
					}else if($(this).is("textarea")){
						if($(this).val() != ""){
							groupBoolean = true;
						}
					}else if($(this).is("select")){
						if($(this).val() != ""){
							groupBoolean = true;
						}
					}

					groupIdx++;
					groupChoseIdx++;

					if($("[class*='("+targetGroupName+")']").length == groupIdx){
						if(groupBoolean == true){
							if($("[class*=groupChoose]").length != groupChoseIdx){
								if($("[class*=groupChoose]").eq(groupChoseIdx+1).attr("class").indexOf("groupChoose") > -1){
									groupBoolean = false;
									groupIdx = 0;
								}
							}
						}else{
							return false;
						}
					}
				}
	});

	if($("[class*=validation]").length >  0){
		if($("[class*=validation]").attr("class").indexOf("groupChoose") > -1){
			if(groupBoolean == false ){
				alert(validNm + $.word+" 필수 선택 항목 입니다.");
				this.focus();
				return valid = false;
			}
		}
	}
	return valid;
}

function fnNowDate(){
	var time = new Date();
	var year = time.getYear() + 1900;
	var month
	if(time.getMonth() + 1 < 10){
		month = '0' + (time.getMonth() + 1);
	}else{
		month = time.getMonth() + 1;
	}
	var day;
	if(time.getDate() < 10){
		day = '0' + time.getDate();
	}else{
		day = time.getDate();
	}
	var hour;
	if(time.getHours() < 10){
		hour = '0' + time.getHours();
	}else{
		hour = time.getHours();
	}
	var minute;
	if(time.getMinutes() < 10){
		minute = '0' + time.getMinutes();
	}else{
		minute = time.getMinutes();
	}
	var second;
	if(time.getSeconds() < 10){
		second = '0' + time.getSeconds();
	}else{
		second = time.getSeconds();
	}


	return year+month+day+hour+minute+second;
}

//동적  디자인 파일 찾기 클릭
/* --- param ----
 * obj.fileAttrName; //실제 사용자 로컬 파일경로
 * obj.fileViewAttrName  //현재 노출되는 input name
 * obj.form  //전송할 form name
 * obj.filetype //파일 제한 종류 -- image (현재 이미지만 구현)
 * obj.index //확장형 첨부파일일 경우 사용될 인덱스
 * */
function fileSearch(obj){

 	if(obj.index == undefined){
 		obj.index = 0;
 	}
 		var fileId = obj.fileAttrName+"_"+obj.index;
 		var fileId_seq = obj.fileAttrName+"_seq_"+obj.index;
	 //현재 input file이 존재하면 제거 후 다시 생성
 	$("form[name="+obj.form+"]").find("input[class="+fileId+"]").remove();
 	$("form[name="+obj.form+"]").find("input[class="+fileId_seq+"]").remove();
 	$("form[name="+obj.form+"]").append(makeInputFile(obj.fileAttrName,fileId,'file'));
 	$("form[name="+obj.form+"]").append(makeInputFile(obj.fileAttrName+"_seq", fileId_seq,'hidden',obj.index));


	 //일회성 이벤트 생성 파일선택 후 변경되었을 시 처리 함수
	$("input[class="+fileId+"]").bind("change",function(e) {
		var imgPath = $(this).val();
		var imgPathArr = imgPath.split("\\");
	   if(imgPathArr.length > 1){
			var ImgName = imgPathArr[imgPathArr.length-1];

			//파일타입이 이미지일 때...
			if(obj.filetype == "image"){
				var fTypeArr =  ImgName.split(".");
				var fType =  fTypeArr[fTypeArr.length-1].toLowerCase();
				if(fType == "jpg" || fType == "gif" || fType == "bmp" || fType == "png"){
					if( obj.idx != undefined ){
						$("input[name="+obj.fileViewAttrName+"]").eq(obj.idx).val(ImgName);
					}else{
						$("input[name="+obj.fileViewAttrName+"]").eq(obj.index).val(ImgName);
					}
				}else{
					$(this).remove();
				 	$("form[name="+obj.form+"]").find("input[class="+obj.index+"]").remove();
				 	$("form[name="+obj.form+"]").find("input[class="+fileId+"]").remove();
					alert("이미지형 파일이 아닙니다. \n 이미지형 파일 - (jpg, gif, bmp, png)");
					return false;
				}
			}else if(obj.filetype == "html"){
				var fTypeArr =  ImgName.split(".");
				var fType =  fTypeArr[fTypeArr.length-1].toLowerCase();
				if(fType == "jsp" || fType == "html" || fType == "htm"){
					$("input[name="+obj.fileViewAttrName+"]").eq(obj.index).val(ImgName);
				}else{
					$(this).remove();
				 	$("form[name="+obj.form+"]").find("input[class="+obj.index+"]").remove();
				 	$("form[name="+obj.form+"]").find("input[class="+fileId+"]").remove();
					alert("웹(html)형 파일이 아닙니다. \n html형 파일 - (html, htm, jsp)");
					return false;
				}
			}else{
				$("input[name="+obj.fileViewAttrName+"]").eq(obj.index).val(ImgName);
			}
	   }

	   //사용 후 소멸
		$("input[class="+fileId+"]").unbind("change");
	});

	$("input[class="+fileId+"]").click();
}

//동적으로 input (type=file)생성
function makeInputFile(name,fileId,type,val) {
	var _input = document.createElement("input");
	_input.setAttribute("type", type);
	_input.setAttribute("name", name);
	_input.setAttribute("class", fileId);
	if(val != undefined){
	_input.setAttribute("value", val);
	}
	_input.setAttribute("style", "display:none");
	return _input;
}

//금지단어 변환
function fnChkWord(val){
	var arryData;
	var strTxt = '변비,설사,장염,배탈,효과,복통,배앓이,면역력,면연력,면역,감기,크론병,크론,아토피,피부,피부질환,임산부,임신,당뇨,과민성대장증후군,과민성,대장증후군,대장,비염,스트레스,질환,변,알레르기,알러지,트러블,자폐,토피,폐렴,페렴,독감,암,다이어트';
	var ast = '';
	if(strTxt != ''){
		arryData = strTxt.split(',');
		for(var i=0; i<arryData.length; i++){
			ast = '';
			for(var j=0; j<arryData[i].length; j++){
				ast = ast + '*';
			}
			val = eval("val.replace(/" + arryData[i] + "/g, ast)");
		}
	}
	return val;
}


//전화번호 자동 완성
function setTelNo(val){
	var chkVal = removeComma(val);
	if(chkVal.substring(0,2) == "02"){
		if(chkVal.length > 9){
			return chkVal.substring(0,2)+"-"+chkVal.substring(2,6)+"-"+chkVal.substring(6,10);
		}else if(chkVal.length > 5){
			return chkVal.substring(0,2)+"-"+chkVal.substring(2,5)+"-"+chkVal.substring(5,9);
		}else if(chkVal.length > 3){
			return chkVal.substring(0,2)+"-"+chkVal.substring(2,10);
		}else{
			return chkVal;
		}
	}else{
		if(chkVal.length > 10)
		{
			return chkVal.substring(0,3)+"-"+chkVal.substring(3,7)+"-"+chkVal.substring(7,11);
		}else if(chkVal.length > 6){
			return chkVal.substring(0,3)+"-"+chkVal.substring(3,6)+"-"+chkVal.substring(6,10);
		}else if(chkVal.length > 3){
			return chkVal.substring(0,3)+"-"+chkVal.substring(3,11);
		}else{
			return chkVal;
		}
	}
}

//jqTrans 초기화
function fnfixSelect(selector) {
    var i=$(selector).parent().find('div,ul').remove().css('zIndex');
    $(selector).unwrap().removeClass('jqTransformHidden').jqTransSelect();
    $(selector).parent().css('zIndex', i);
}


