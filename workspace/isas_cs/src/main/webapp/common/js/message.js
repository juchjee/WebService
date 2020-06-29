//문자 코드 셋팅
var MESSAGES_OK = {
	"COMPLETE" : "정상적으로 완료되었습니다.",
	"SAVE" : "정상적으로 저장되었습니다.",
	"DELETE" : "정상적으로 삭제되었습니다.",
	"DEADLINE_OK" : "@년@월 @가 생성되었습니다.",
	"DEADLINE_CANCEL" : "@년@월 @가 생성이 취소 되었습니다.",
	"PAY_OK" : "@일 , @원, 입금처리 되었습니다."
}
var MESSAGES_CFM = {
	"CREATE" : "등록하시겠습니까?",
	"SAVE" : "저장하시겠습니까?",
	"DELETE" : "삭제하시겠습니까?",
	"DUP" : "전체마감 하시겠습니까?",
	"UNDUP" : "전체마감해제 하시겠습니까?",
	"LOCK" : "전체잠금 하시겠습니까?",
	"UNLOCK" : "전체해제 하시겠습니까?",
	"DECIDESAVE" : "본 내용으로 확정처리 하시겠습니까?",
	"POPUP_CANCEL" : "수정을 취소하고 팝업을 닫습니까?"
}
var MESSAGES_VALID = {
	"NON_SAVE" : "저장 데이터가 없습니다.",
	"KEYIN" : "@를(을) 입력하셔야 합니다.",
	"REQUIRED" : "@은(는) 필수 항목입니다.",
	"CHOICE" : "@만 선택 가능합니다.",
	"DATE_FORM_TO" : "시작일은 종료일 보다 클 수 없습니다.",
	"SEARCH_REQUIRED" : "@가(이) 검색되지 않았습니다.",
	"DATA_LENGTH" : "@는(은) 길이가 @자 이어야 합니다.",
	"DATA_VALID" : "@가(이) 중복 됩니다.",
	"NOTTYPE" : "@ 형식이 맞지 않습니다.",
}
var MESSAGES_ERR = {
	"SESSION_FAIL" : "세션정보가 없습니다. 다시 로그인 해주세요.",
	"PASSWORD_FAIL" : "비밀번호와 비밀번호 확인 값이 일치하지 않습니다.",
	"LENGTH_FAIL" : "@은/는 @ 이상이어야 합니다.",
	"LOGIN_FAIL" : "해당 페이지는 로그인 후 이용 가능 합니다.",
	"YEAR_NULL" : "조건 년도를 입력하세요.",
	"YEAR_FAIL" : "년도조건이 옳지 않습니다.",
	"FROM_TO_DATE_FAIL" : "시작일은 종료일 보다 클 수 없습니다.",
	"PARAM_FAIL" : "검색 조건을 확인하세요.",
	"SAVE_FAIL" : "저장에 실패 하였습니다.",
	"DELETE_FAIL" : "삭제에 실패 하였습니다.",
	"DEADLINE_FAIL" : "마감에 실패 하였습니다. 관리자에게 문의 하세요",
	"COMMON_ERR" : "정상적으로 처리 되지 못했습니다.전산실로 문의 하시기 바랍니다.",
}
// 메시지 호출
var message = function(code, arguments) {
	return coMessage_getMsg(code, arguments);
}
// 메시지 변수값(@)이 필요시 해당 문자위치에 입력
function coMessage_getMsg(message, paramArray) {
	if (message == null) {
		return null;
	}
	var index = 0;
	var re = /@/g;
	var count = 0;

	if (paramArray == null) {
		return message;
	}

	while ((index = message.indexOf("@", index)) != -1) {
		if (paramArray[count] == null) {
			paramArray[count] = "";
		}

		message = message.substr(0, index) + String(paramArray[count])
				+ message.substring(index + 1);

		index = index + String(paramArray[count++]).length;
	}
	return message;
}
