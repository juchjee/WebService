<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
<head>
<c:import url="/WEB-INF/jsp/general/meta.jsp" />
<title><spring:message code="eGov.title" /></title>
<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />


<!-- 마케팅관리 : 이벤트관리 등록(4가지 종류 : 일반/응모/퀴즈/쿠폰) -->
<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
<script type="text/javascript" src="/js/functions.js"></script>
<script type="text/javaScript" defer="defer">
	var contUrl = "${rootUri}${conUrl}amM401";
	(function() {
		parent.fnCallBackHandler && parent.fnCallBackHandler(980, 737);
	})();
	var oEditors = []; // 네이버 스마트 에디터
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/

	function init() {
		//이벤트 설정
		fnEvent();

		//초기 데이터 셋팅
		fnDataSetting();

		//DatePicker 호출
		dateTimeInput("eventStartDt");
		dateTimeInput("eventEndDt");

		/*----------------------------- 네이버 스마트 에디터 Start -----------------------------*/
		nhn.husky.EZCreator.createInIFrame({
			oAppRef : oEditors,
			elPlaceHolder : "eventCont",
			sSkinURI : "/SE/SmartEditor2Skin.html",
			htParams : {
				bUseToolbar : true, // 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : false, // 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true
			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			},
			fOnAppLoad : function() {
				//_${divName}Arr.getById["${divName}"].exec("PASTE_HTML", [parent.$("#${divName}_Text").text()]);//부모 윈도우의  내용을 가지고 온다.
				//$("#btn_div").show();
			},
			fCreator : "createSEditor2"
		});
		/*----------------------------- 네이버 스마트 에디터 End -----------------------------*/

	}

	/*----------------------------------------------------------------------------------------------
	 * 페이지 이벤트 함수 모음
	 *----------------------------------------------------------------------------------------------*/
	function fnEvent() {
		// 참여제한 활성화 처리
		$("input[name=eventLimitsTpUl]").on("change", function() {
			if (this.value == "L") {
				$("#eventLimitsCount").attr("disabled", false);
			} else {
				$("#eventLimitsCount").attr("disabled", true);
			}
		});

		// 이벤트 종류에 따른 Table-Row 처리
		$("#eventTp").on("change", function() {
			switch (this.value) {
			case "EET00003":
				$("#rowQuiz").css("display", "");
				$("#rowCopnSelect").css("display", "none");
				$("#rowCopn").css("display", "none");
				$("#rowSns").css("display", "none");
				break;
			case "EET00004":
				$("#rowCopnSelect").css("display", "");
				$("#rowCopn").css("display", "");
				$("#rowQuiz").css("display", "none");
				$("#rowSns").css("display", "none");
				break;
			case "EET00005":
				$("#rowCopnSelect").css("display", "none");
				$("#rowCopn").css("display", "none");
				$("#rowQuiz").css("display", "none");
				$("#rowSns").css("display", "");
				break;
			default:
				$("#rowQuiz").css("display", "none");
				$("#rowCopnSelect").css("display", "none");
				$("#rowCopn").css("display", "none");
				$("#rowSns").css("display", "none");

			}
		});

		// 퀴즈이벤트 주관식 객관식 선택
		$("input[name=eventQuizTpCs]").on("change", function() {
			if (this.value == "S") { // 주관식
				$("#answerMultiple").css("display", "none");
			} else { // 객관식
				$("#answerMultiple").css("display", "");
				$(".dtQuizAdd").empty();
				$.quizAdd("dtQuizAdd", "0");
			}
		});

		/*----------------------------- 리스트이미지 - 파일찾기 버튼 클릭 이벤트 Start -----------------------------*/
		$(".evtImg").bind("click", function() {
			fileSearch({
				fileAttrName : "eventBasicImgPath",
				fileViewAttrName : "eventBasicImgName",
				form : "eventForm",
				filetype : 'image'
			});
		});
		/*----------------------------- 리스트이미지 - 파일찾기 버튼 클릭 이벤트 End-------------------------------*/

		/*----------------------------- 소셜포스팅 이미지 - 파일찾기 버튼 클릭 이벤트 Start -----------------------------*/
		$(".SnsImg").bind("click", function() {
			fileSearch({
				fileAttrName : "eventSnsImgPath",
				fileViewAttrName : "eventSnsImgName",
				form : "eventForm",
				filetype : 'image'
			});
		});
		/*----------------------------- 소셜포스팅이미지 - 파일찾기 버튼 클릭 이벤트 End-------------------------------*/

		/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 Start -----------------------------*/
		$.submit = function() {

			if ($("#eventTp").val() == "EET00005") {
				if ($("#eventForm").find("input[name='eventSnsImgPath']").length == 0) {
					alert("소셜포스팅 이미지를 등록하세요!");
					return false;
				}
			}

			if ($("input[name=eventTitle]").val() == "") {
				alert(message(MESSAGES_VALID.REQUIRED, [ "제목" ]));
				$("input[name=eventTitle]").focus();
				return false;
			}
			if ($("input[name=eventStartDt]").val() == "") {
				alert(message(MESSAGES_VALID.REQUIRED, [ "이벤트 시작일" ]));
				$("input[name=eventStartDt]").focus();
				return false;
			}
			if ($("input[name=eventEndDt]").val() == "") {
				alert(message(MESSAGES_VALID.REQUIRED, [ "이벤트 종료일" ]));
				$("input[name=eventEndDt]").focus();
				return false;
			}
			if ($("#eventForm").find("input[name='eventBasicImgPath']").length == 0) {
				alert("이벤트 이미지를 등록하세요!");
				return false;
			}
			if ($("input[name=eventLeadCont]").val() == "") {
				alert(message(MESSAGES_VALID.REQUIRED, [ "리드문구" ]));
				$("input[name=eventLeadCont]").focus();
				return false;
			}

			var sHTML = oEditors.getById["eventCont"].getIR();
			if (sHTML == "<p><br></p>" || sHTML == "") { // <p><br></p> 는 아무것도 입력 안했을때 기본으로 들어있는 내용이므로 이것도 널값으로 체크
				alert(message(MESSAGES_VALID.REQUIRED, [ "내용" ]));
				return false;
			}

			oEditors.getById["eventCont"].exec("UPDATE_CONTENTS_FIELD", []); // 에디터의 내용이 textarea 에 적용됨
			if ($("textarea[name=eventCont]").val().trim().length < 1) {
				alert(message(MESSAGES_VALID.REQUIRED, [ "내용" ]));
				return false;
			}

			// 퀴즈이벤트인 경우 질문과 답 입력 체크
			if ($("#eventTp").val() == "EET00003") {
				if ($("input[name=eventQuizQuest]").val() == "") {
					alert(message(MESSAGES_VALID.REQUIRED, [ "퀴즈질문" ]));
					return false;
				}
				if ($("input[name=eventQuizAns]").val() == "") {
					alert(message(MESSAGES_VALID.REQUIRED, [ "퀴즈에 대한 정답" ]));
					return false;
				}
				// 객관식인데 보기에 아무 입력이 없는경우
				if ($("input[name=eventQuizTpCs]:checked").val() == 'C') {
					if ($("input[name=quizCondition]")[0].value == "") {
						alert("객관식의 보기항목을 입력해야 합니다.");
						return false;
					}
				}
			}

			// 쿠폰다운로드 이벤트 인 경우
			if ($("#eventTp").val() == "EET00004") {
				var cnt = $("input[name=copnImgName]").length;
				if (cnt < 1) {
					alert("하나 이상의 쿠폰을 등록해야 합니다.");
					return false;
				}

				for (i = 0; i < cnt; i++) {
					if ($("input[name=copnImgName]")[i].value == "") {
						alert("모든 쿠폰에는 이미지가 필요합니다.");
						return false;
					}
				}
			}

			fnSubmit("eventForm", "저장");
		}
		/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 End -----------------------------*/

		/*----------------------------- 객관식 - 추가 버튼 클릭 이벤트 Start -----------------------------*/
		$.quizAdd = function(className, len) {
			len = parseInt(len) + 1;
			$("." + className)
					.append(
							"<div class=\"quizAdd\">"
									+ "	<div class=\"fl numbering\" style=\"line-height: 26px\">"
									+ len
									+ ".</div>"
									+ "	<div  class=\"fl\" style=\"width: 90%;\">"
									+ "		<input type=\"text\" name=\"quizCondition\" class=\"fl verT marL5\" style=\"width: 90%;\"/>"
									+ "		<a href=\"javascript:;\"  class=\"fl addCondition btn_type4\">+</a>"
									+ "	</div>" + "</div>");

			$(".quizAdd > div > .addCondition").unbind("click");
			$(".quizAdd > div > .addCondition")
					.bind(
							"click",
							function() {
								if ($(this).text() == "+") {
									// +버튼 클릭 시
									$(this).removeClass("btn_type4");
									$(this).addClass("btn_type5");
									$(this).text("-");
									$.quizAdd(className, $('.quizAdd').length);
								} else if ($(this).text() == "-") {
									// -버튼 클릭 시
									var conditionAddIdx = $(
											".quizAdd > div > .addCondition")
											.index(this);
									$(".quizAdd").eq(conditionAddIdx).remove();
									$
											.each(
													$(".quizAdd > .numbering"),
													function(index) {
														var numbering = $(".quizAdd > .numbering")[index];
														numbering.innerText = (index + 1)
																+ ".";
													});
								} else {
									return false;
								}
							});
		} // $.quizAdd
		/*----------------------------- 객관식 - 추가 버튼 클릭 이벤트 End -----------------------------*/

	} // fnEvent()
	/*----------------------------------------------------------------------------------------------
	 * 페이지 데이터 셋팅
	 *----------------------------------------------------------------------------------------------*/

	function fnDataSetting() {
	}

	/*----------------------------------------------------------------------------------------------
	 * 특별설정함수
	 *----------------------------------------------------------------------------------------------*/
	// 쿠폰검색 팝업에서 체크 한 수 만큼 Image 등록객체 생성
	function copnCount(cnt, items) {
		$("#rowCopn").css("display", "");
		for (var i = 0; i < cnt; i++) {
			if (document.getElementById(items[i].value) == null) {
				var idx;
				$("input[name=secMpgArr]").each(function(index, item) {
					if (item.value == items[i].value) {
						idx = index;
					}
				});
				$("#contCopn")
						.append(
								"<div id='"+items[i].value+"'>"
										+ "<input type='text' name='copnImgName' style='width:200px;' readonly >"
										+ "<a class='copnImg btn_type1 marL10' href='#'>파일찾기</a>"
										+ "<div><label>"
										+ items[i].label
										+ "</label>"
										+ "<a href=\"javascript:delcopnImg('"
										+ items[i].value
										+ "');\"><img src=\"/images/btn_keyword_del.png\" alt=\"삭제\"></a></div>"
										+ "</div>");
			}
		}

		$(".copnImg").unbind("click");
		/*----------------------------- 상세이미지 - 파일 찾기 버튼 클릭 이벤트(소멸성이벤트) -----------------------------*/
		$(".copnImg").bind("click", function() {
			//확장형 첨부일 경우 인덱스 인자 추가 전달
			var idx = $(".copnImg").index(this);
			var index = $(this).parent().attr("id");
			//파라메터 값 object 형
			var obj = new Object();
			obj.fileAttrName = "copnImgPath"; //실제 전달할 파일 속성명
			obj.fileViewAttrName = "copnImgName"; //현재 노출되는 속성명 name
			obj.form = "eventForm"; //전송할 form name
			obj.filetype = "image"; //파일 제한 종류 -- image (현재 이미지만 구현)
			obj.index = index; //확장형 첨부파일일 경우 사용될 인덱스
			obj.idx = idx; // 찾은 파일의 value 값을 input 에 담을때
			fileSearch(obj);
		});

	}

	//쿠폰이미지 삭제 처리
	function delcopnImg(id) {
		$("#contCopn > div ").each(function(index, item) {
			if (item.id == id) {
				// 			var idx = $(this).attr("data-seq");
				var idx;
				$("input[name=secMpgArr]").each(function(indexes, items) {
					if (items.value == id) {
						idx = indexes;
					}
				});
				$(this).remove();
				$(".copnImgPath_" + id).remove();
				$(".copnImgPath_seq_" + id).remove();
			}
		});
		$("#" + id).remove();
		$("input[name=secMpgArr][value=" + id + "]").remove();
		var exist = "0";
		$("#deleteCopn > input").each(function(index, item) {
			if (item.value == id) {
				exist = "1";
			}
		});
		if (exist == "0") {
			$("#deleteCopn")
					.append(
							"<input type=\"hidden\" name=\"deleteCopnArr\" value="+id+">");
		}
	}
</script>
</head>
<body class="noBg">
	<div class="popup_wrap" style="background: #fff">
		<h2>이벤트 등록</h2>
		<div class="table_type2 pageContScroll_st2">
			<form id="eventForm" name="eventForm" action="amM401Save.action"
				method="post" enctype="multipart/form-data">
				<table>
					<caption>이벤트 종류, 이벤트 제목, 이벤트 기간, 메인배너 Image, 리스트 Image,
						리드문구 (100자이내), 내용으로 구성된 이벤트 등록에 대한 작성 테이블 입니다.</caption>
					<colgroup>
						<col style="width: 10%;">
						<col style="width: 90%;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">이벤트 종류</th>
							<td><html:selectList name='eventTp' id='eventTp'
									list='${eventList}' listValue='eventTpCd' listName='eventTpNm'
									script='style="width:120px;"' /></td>
						</tr>
						<tr>
							<th scope="row">이벤트 제목</th>
							<td><input type="text" style="width: 500px;" id="eventTitle"
								name="eventTitle"></td>
						</tr>
						<tr>
							<th scope="row">참여등급</th>
							<td><html:selectList name='mbrLevLimitCd' id='mbrLevLimitCd'
									list='${mbrLevList}' listValue='mbrLevCd' listName='mbrLevNm'
									script='style="width:144px;"' /> 이상</td>
						</tr>
						<tr>
							<th scope="row">이벤트 기간</th>
							<td>
								<div id='eventStartDt' style='float: left;'></div>
								<div style='float: left; line-height: 28px;'>&nbsp;~&nbsp;</div>
								<div id='eventEndDt' style='float: left;'></div>
							</td>
						</tr>
						<tr>
							<th scope="row">참여제한</th>
							<td><input id="eventLimitsTpU" name="eventLimitsTpUl"
								type="radio" value="U" checked="checked" /><label
								for="eventLimitsTpU">무제한</label>&nbsp; <input
								id="eventLimitsTpL" name="eventLimitsTpUl" type="radio"
								value="L" /><label for="eventLimitsTpL">제한</label> <span><input
									id="eventLimitsCount" name="eventLimitsCount" type="text"
									class="validation[number,required]" placeholder="0"
									maxlength="11" style="width: 80px;" disabled="disabled" /> 명</span></td>
						</tr>
						<tr>
							<th scope="row">당첨자순위지정</th>
							<td><input id="eventRankN" name="eventRankYn" type="radio"
								value="N" checked="checked" /><label for="eventRankN">비지정</label>&nbsp;
								<input id="eventRankY" name="eventRankYn" type="radio" value="Y" /><label
								for="eventRankY">지정</label></td>
						</tr>
						<tr>
							<th scope="row">리스트 Image</th>
							<td><input type="text" name="eventBasicImgName"
								style="width: 200px;" readonly> <a
								class="evtImg btn_type1  marL10" href="javascript:;">파일찾기</a></td>
						</tr>
						<tr>
							<th scope="row">리드문구<br />(100자이내)
							</th>
							<td>
								<div class="textarea_form">
									<input type="text" name="eventLeadCont" id="eventLeadCont"
										style="width: 800px"
										onKeyUp="javascript:fnChkByte(this,'100')" value="" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">내용</th>
							<td>
								<div class="edit_area">
									<div class="editScroll">
										<textarea name="eventCont" id="eventCont"
											class="validation[required]" title="내용" rows="10" cols="100"
											style="width: 99%; height: 200px;"></textarea>
									</div>
								</div>
							</td>
						</tr>
						<tr id="rowQuiz" style="display: none;">
							<th scope="row">퀴즈입력</th>
							<td>
								<div id="eventQuiz">
									<input type="radio" id="answer1" name="eventQuizTpCs" value="S"
										checked="checked" /><label for="answer1">주관식</label> <input
										type="radio" id="answer2" name="eventQuizTpCs" value="C"
										class="marL10" /><label for="answer2">객관식</label>
								</div>
								<div class="quiz_dl">
									<dl>
										<dt>퀴즈질문</dt>
										<dd>
											<input type="text" style="width: 600px;"
												name="eventQuizQuest" />
										</dd>
									</dl>
								</div>
								<div id="answerMultiple" style="display: none;">
									<div class="quiz_dl">
										<dl>
											<dt>퀴즈답</dt>
											<dd>
												<div class="quiz_ul">
													<div>
														<div class="dtQuizAdd"></div>
													</div>
												</div>
											</dd>
										</dl>
									</div>
								</div>
								<div class="quiz_dl">
									<dl>
										<dt>정답</dt>
										<dd>
											<input type="text" style="width: 200px;" name="eventQuizAns" />
										</dd>
									</dl>
								</div>
							</td>
						</tr>
						<tr id="rowCopnSelect" style="display: none;">
							<th scope="row">쿠폰등록</th>
							<td>
								<div class="add_field">
									<a class="fancybox bis btn_type1" data-fancybox-type="iframe"
										href="amM401Sec.action">쿠폰검색</a>
									<div class="field_ul" style="display: none;">
										<ul id="secMpg"></ul>
									</div>
									<!-- // field_ul -->
								</div> <!-- // add_field -->
							</td>
						</tr>
						<tr id="rowCopn" style="display: none;">
							<th scope="row">쿠폰 Image</th>
							<td>
								<div id="contCopn" class="field_ul_copn"></div>
							</td>
						</tr>
						<tr id="rowSns" style="display: none;">
							<th scope="row">소셜 포스팅 Image</th>
							<td><input type="text" name="eventSnsImgName"
								style="width: 200px;" readonly> <a
								class="SnsImg btn_type1  marL10" href="javascript:;">파일찾기</a></td>
						</tr>
					</tbody>
				</table>
				<!-- // table_type2 -->
			</form>
		</div>
		<div class="btn_area">
			<div class="center">
				<a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">등록</a><a
					class="btn_blue_line2" href="javascript:;"
					onclick="parent.$.fancybox.close();">닫기</a>
			</div>
		</div>
	</div>
	<!-- // btn_area -->
</body>
</html>