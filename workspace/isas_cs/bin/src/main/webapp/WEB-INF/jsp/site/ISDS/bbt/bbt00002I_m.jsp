<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
	
	function init(){
		fnEvent();
		fnDataSetting();
	}
	
	function fnEvent(){
		
		/* textarea : byte 체크 */
		$('textarea[name=boardCont]').trigger("keyup");
		
		/* 첨부파일 : 이미지파일 확인 */
		$.attfileAdd = function(className,len){

			$("."+className).append("<input type='text' name='dtlImgName' class='input_txt1' style='margin-bottom:5px;'/><span class='btn01Type dtlImg' style='cursor:pointer;margin-bottom:5px;'>파일찾기</span>");
			$(".dtlImg").unbind("click");
			/*----------------------------- 상세이미지 - 파일 찾기 버튼 클릭 이벤트(소멸성이벤트) -----------------------------*/
			$(".dtlImg").bind("click",function() {
				//확장형 첨부일 경우 인덱스 인자 추가 전달
				var idx = $(".dtlImg").index(this);
				//파라메터 값 object 형
			  		var obj = new Object();
			  		obj.fileAttrName = "dtlImgPath"; //실제 전달할 파일 속성명
			  	   	obj.fileViewAttrName = "dtlImgName"; //현재 노출되는 속성명 name
			  	   	obj.form = "insertForm"; //전송할 form name
			  	   	obj.filetype = "image"; //파일 제한 종류 -- image (현재 이미지만 구현)
			  	   	obj.index = idx; //확장형 첨부파일일 경우 사용될 인덱스
				fileSearch(obj);
			});
		}
		
		/* 저장버튼 : DB저장 */
		$("#insertBtn").bind("click",function(){
			//fnValidation();
			if(!strLength($("#txtArea1").val())){
				alert('1000byte를 넘을 수 없습니다.');
				return false;
			}
			if(fnValidation() == true){
				fnSubmit("insertForm","저장");
			}
		});
	
		/* 취소버튼 : 목록 페이지 이동 */
		$("#listBtn").bind("click",function(){

			var param = "";
			if("${param.page}" != ""){
				 param = "&page=${param.page}";
			}
			
			if('${bbt2View.boardSeq}' != "" && '${bbt2View.boardSeq}' != null){
				location.href="bbt00002R.do?pageCd=${boardMstCd}"+param;
			}else{
				var listConfirm = confirm("작성을 취소하시겠습니까?");
				 if(listConfirm){
					location.href="bbt00002R.do?pageCd=${boardMstCd}"+param;
				 }
			 }
		});
		
	}
	
	function strLength(str){
		var len = 0;
	    for (var i = 0; i < str.length; i++) {
	        if (escape(str.charAt(i)).length == 6) {
	            len++;
	        }
	        len++;
	    }
	    if(len>1000){
	    	return false;
	    }
	    return true;
	}
	
	function fnDataSetting(){
		
		/* 첨부파일 3개 보이기 */
		$.attfileAdd("file_add","0");
		$.attfileAdd("file_add2","1");
		$.attfileAdd("file_add3","2");
		
		/* 첨부파일 버튼 : 첨부파일 web에 있는 functions.js 스크립트 사용으로 스타일이 깨져 mobile 첨부파일버튼 class 넣어줌  */
		$('.btn01Type').addClass("smBtn");
		
	}
	
	function fnByteCheck(e, byteLength){
		var text = $(e).val();
		var textLength = 0;
		for(var i = 0; i < text.length; i++){
			/* if(escape(text.charAt(i)).length == 6){
				textLength++;
			}
			textLength++;
			*/
			if(encodeURIComponent(text.charAt(i)).length == 9){// 한글
				textLength += 2;
			}else if(encodeURIComponent(text.charAt(i)).length == 1){// 영문
				textLength += 1;
			}else{ //특수문자
				textLength += 2;
			}
		}
		var cutbyLenText = cutByLen(text, byteLength);
		if(textLength > byteLength){
			$("#txtArea1").val("");
			$("#txtArea1").val(cutbyLenText);
			$("#txtArea1").html("");
			$("#txtArea1").html(cutbyLenText);
			$('#chkByte').text("");
			$('#chkByte').text("1000/1000");
		}else{
			$('#chkByte').text("");
			$('#chkByte').text(textLength+"/1000");
		}
	}
	
	 function cutByLen(str, maxByte) {
		 for(b=i=0;c=str.charCodeAt(i);) {
			 b+=c>>7?2:1;
			 if(b > maxByte){
				 break;
			 }
			 i++;
		 }
		 return str.substring(0,i);
	 }
	 
	function fnValidation(){
		var questionTp = document.insertForm.questionTp;
		var boardCateSeq = document.insertForm.boardCateSeq;
		var boardTitle = document.insertForm.boardTitle;
		var boardCont = document.insertForm.boardCont;
		
		if(questionTp.value == ""){
			alert("문의구분을 선택해주세요.")
			questionTp.focus();
			return false;
		}
		
		if(boardCateSeq.value == ""){
			alert("제품구분을 선택해주세요.")
			boardCateSeq.focus();
			return false;
		}
		
		if($.trim(boardTitle.value) == ""){
			alert("제목을 입력해주세요.")
			boardTitle.focus();
			return false;
		}else{
			boardTitle.value = $.trim(boardTitle.value);
		}
		
		if($.trim(boardCont.value) == ""){
			alert("내용을 입력해주세요.")
			boardCont.focus();
			return false;
		}else{
			boardCont.value = $.trim(boardCont.value);
		} 
		
		return true;
	}
	
	function exDown(code){
		fnFileDownLoad(code);
	}
	
	</script>
</head>
<body>

	<section class="sub cont">
	
		<form name="insertForm" id="insertForm" action="bbt00002Save.action" method="post" enctype="multipart/form-data">
			<!-- <form name="insertForm" id="insertForm" action="bbt00002Save.action" method="post"> -->
				<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardMstCd}" />
				<input type="hidden" name="boardSeq" id="boardSeq" value="${bbt2View.boardSeq}" />
				<input type="hidden" name="attchCd" id="attchCd" value="${fileList[0].attchCd}" />
			
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>글쓰기</h2>
		</div>
		<!--// tit_bx -->
		<div class="ing_bx nobg">
			<div class="box">
				<div class="tit">1:1문의<span class="star">필수입력사항</span></div>
				<dl class="type01">
					<dt class="star">문의구분</dt>
					<dd>
						<div class="select_guide">
							<select class="m_select select01"  name="questionTp" id="asPart">
									<option value="" selected="selected">선택</option>
									<option value="1" <c:if test="${bbt2View.questionTp eq 'A/S신청'}">selected</c:if> >A/S신청</option>
									<option value="2" <c:if test="${bbt2View.questionTp eq '제품문의'}">selected</c:if> >제품문의</option>
									<option value="3" <c:if test="${bbt2View.questionTp eq '칭찬접수'}">selected</c:if> >칭찬접수</option>
									<option value="4" <c:if test="${bbt2View.questionTp eq '기타'}">selected</c:if> >기타</option>
								</select>
						</div>
					</dd>
					<dt class="star">제품구분</dt>
					<dd>
						<div class="select_guide">
							<select class="m_select select01"  name="boardCateSeq" id="goodsPart">
								<option value="" selected="selected">선택</option>
									<c:forEach items="${cateList}" var="cateList" varStatus="loop">
										<option value="${cateList.boardCateSeq}" <c:if test="${cateList.boardCateSeq eq bbt2View.boardCateSeq}">selected</c:if> >${cateList.boardCateNm}</option>
									</c:forEach>
							</select>
						</div>
					</dd>
					<dt class="star">제목</dt>
					<dd>
						<div class="input_txt_bx upload_area">
							<input type="text" name="boardTitle" id="boardTitle" value="${bbt2View.boardTitle}" />
						</div>
					</dd>
					<dt class="star">내용</dt>
					<dd class="hauto">
						<div class="txtarea_bx">
							<textarea id="txtArea1" name="boardCont" value="${bbt2View.boardCont}" onkeyup="fnByteCheck(this,'1000');" >${bbt2View.boardCont}</textarea>
							<p class="unit_byte"><span id="chkByte">0/1000 byte</span></p>
						</div>
					</dd>
					<dt>첨부파일</dt>
					<dd class="hauto">
						<div class="input_txt_bx file_add">
							<a href="#" class="smBtn w20">찾기</a>
						</div>
						<div class="input_txt_bx file_add2">
							<a href="#" class="smBtn w20">찾기</a>
						</div>
						<div class="input_txt_bx file_add3">
							<a href="#" class="smBtn w20">찾기</a>
						</div>
						<div class="ar"><span class="cur fs-11">0/50MB</span></div>
						<c:if test="${not empty fileList}">
							<c:forEach items="${fileList}" var="fileList" varStatus="status">
								<div class="file_lst_bx">
									<span class="input_txt" onclick="exDown('${fileList.attchCd}');"  style="cursor:pointer"><c:out value="${fileList.attchFileNm}" /></span>
								</div>
			          		</c:forEach>
							<div class="view_cont qna_q" style="border-top:none;">
								<div class="box_img mt10">
									<c:forEach items="${fileList}" var="fileList" varStatus="status">
										<div class="preview">
											<img src="${fileList.attchFilePath}"/>
										</div>
									</c:forEach>
								</div>
							</div>
						</c:if>
					</dd>
				</dl>
			</div>
		</div>
		<!--// ing_bx -->

		</form>

		<div class="btnWrap wide pd15">
			<c:choose>
			<c:when test="${bbt2View.boardSeq  ne null  && bbt2View.boardSeq ne ''}">
				<a href="#none" class="btn gray" id="listBtn">목록</a>
			<a href="#none" class="btn blue" id="insertBtn">저장</a>
			</c:when>
			<c:otherwise>
				<a href="#none" class="btn gray" id="listBtn">취소</a>
			<a href="#none" class="btn blue" id="insertBtn">등록</a>
			</c:otherwise>			
		</c:choose>
		</div>
	</section>
	<!--// sub -->
		
</body>