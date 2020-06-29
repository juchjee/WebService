<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />


	<!-- 마케팅관리 : 이벤트 상세(미리보기) -->
<script type="text/javascript" src="/js/functions.js"></script>
<script type="text/javaScript" defer="defer">
var contUrl = "${rootUri}${conUrl}amM401";
/*----------------------------------------------------------------------------------------------
 * 화면 load시 실행 함수 (onload)
 *----------------------------------------------------------------------------------------------*/
function init(){
	//이벤트 설정
	fnEvent();

	//초기 데이터 셋팅
	fnDataSetting();
}

/*----------------------------------------------------------------------------------------------
 * 페이지 이벤트 함수 모음
 *----------------------------------------------------------------------------------------------*/
function fnEvent(){

	/*----------------------------- 이벤트 참여 Start -----------------------------*/
	$.eventPart = function(){
		var answer = "";
		if( '${eventDetail.eventTp}' == "EET00004" ){
			// 객관식이면
			if( $("#eventQuizTpCs").val() == "C" ){
				answer = $("input[name=quiz_answer_list]:checked").val();
				if( answer == undefined ){
					alert("객관식의 답을 선택하세요.");
					return false;
				}
			}else{ // 주관식이면
				answer = $("#eventQuizAns").val();
				if( answer == "" ){
					alert("주관식의 답을 입력하세요.");
					return false;
				}
			}
		}
		fnAjax(		"amM401Part.action",
						{
							"eventSeq" : $("#eventSeq").val(),
							"eventTp" : $("#eventTp").val(),
							"eventQuizAns" : answer,
							"eventQuizNo" : $("#eventQuizNo").val()
						},
						function(data, dataType){
							if( data.limitover == "over" ){
								alert("참여제한 수를 초과하여 더이상 응모할 수 없습니다.");
							}else if( data.limitover == "already" ){
								alert("이미 응모하셨습니다.");
							}else if( data.login == "F" ){
								// 로그인이 되어있지 않아서 로그인페이지로 이동시킴
								window.location="evnLoginRedirect.do?eventSeq=${eventDetail.eventSeq}";
							}else{
								if( dataType == "success"){
									alert("정상적으로 응모되었습니다.");
								}
							}


						},'POST','json');
	}
	/*----------------------------- 이벤트 참여 End -----------------------------*/
}
/*----------------------------------------------------------------------------------------------
 * 페이지 데이터 셋팅
 *----------------------------------------------------------------------------------------------*/
function fnDataSetting(){
	// 게시 이벤트 인 경우
	if( '${eventDetail.eventTp}' == "EET00001" ){
		$("#part_area").css("display", "none");
	}

	// 퀴즈 이벤트 인 경우
	if( '${eventDetail.eventTp}' == "EET00003" ){
		$(".event_subTit1").css("display", "");
		// 주관식이면 답입력란 보여줌
		if( '${quizDetail.eventQuizTpCs}' == "S" ){
			$(".correct_answer").css("display", "");
		}
	}

	// 쿠폰다운로드 이벤트 인 경우
	if( '${eventDetail.eventTp}' == "EET00004" ){
		$("#part_area").css("display", "none");
		$(".copn_area").css("display", "");
	}

	// 소셜 댓글이벤트 인 경우
	if( '${eventDetail.eventTp}' == "EET00005" ){
		$("#part_area").css("display", "none");
	}

}
</script>
</head>
<body class="noBg">
	<div class="popup_wrap type1">
	<div class="pageContScroll_st3">
	<input type="hidden" id="eventSeq" name="eventSeq" value="${eventDetail.eventSeq}" />
	<input type="hidden" id="eventTp" name="eventTp" value="${eventDetail.eventTp}" />
	<input type="hidden" id="eventQuizTpCs" name="eventQuizTpCs" value="${quizDetail.eventQuizTpCs}" />
	<input type="hidden" id="eventQuizNo" name="eventQuizNo" value="${quizDetail.eventQuizNo}" />
		<p class="event_tit">${eventDetail.eventTitle}</p>
		<div class="event_infor">
			<p>이벤트 등록일 ${eventDetail.regDt}</p>
			<p>이벤트 기간  ${eventDetail.eventDt}</p>
		</div>
		<!-- // event_infor -->

		<div class="event_txt_view1">
			${eventDetail.eventLeadCont}
		</div>
		<div class="event_txt_view2">
            <textarea name="eventCont" id="${eventDetail.eventSeq}_Text" style="display:none;" ><c:if test="${not empty eventDetail.eventCont}">${eventDetail.eventCont}</c:if></textarea>
			<div class="editScroll" >
	            <c:choose>
            		<c:when test="${empty eventDetail.eventCont}">
            		 <div id="${eventDetail.eventSeq}" class="edit_area">미리보기 -  내용이 없습니다.</div>
            		</c:when>
            		<c:otherwise>
            		<div id="${eventDetail.eventSeq}" class="edit_area"></div>
            		<script type="text/javascript">
            			$("#${eventDetail.eventSeq}").html(decodeTag($("#${eventDetail.eventSeq}_Text").html()));
            		</script>
            		</c:otherwise>
           		</c:choose>
            </div>
		</div>
		<div class="event_subTit1" style="display: none;">
			${quizDetail.eventQuizQuest}
		</div>
		<div class="quiz_answer_view">
			<ul>
			<c:forEach items="${choiceList}" var="data" varStatus="loop">
				<li>${loop.index+1}.<input type="radio" name="quiz_answer_list" id="quiz_answer1" value="${loop.index+1}" class="marL10" /><label for="quiz_answer1">${data.quizItem}</label></li>
			</c:forEach>
			</ul>
		</div>
		<div class="correct_answer" style="display: none;">
			정답<input type="text" id="eventQuizAns" style="width:70%;" class="marL10" value="" />
		</div>
		<div class="copn_area" style="display: none;">
			<div style="text-align: center;">
			<c:forEach items="${copnDownList}" var="datas" varStatus="loop">
				<span class="sImg">
					<img src='${datas.attchFilePath}' style="text-align: center;" />
				</span>
			</c:forEach>
			</div>
		</div>
		<div class="" id="part_area" style="text-align: center;">
			<div class="center">
				<a class="btn_blue_line2" href="#" onclick="$.eventPart();">이벤트 참여하기</a>
			</div>
		</div>


	</div>
	<!-- // popup_wrap -->
  <div class="btn_area">
    <div class="center">
		<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
    </div>
  </div>
</div>

</body>