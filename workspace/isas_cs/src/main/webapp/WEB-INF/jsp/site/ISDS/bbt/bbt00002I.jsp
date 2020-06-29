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
		$.attfileAdd("file_add","1");
		$.attfileAdd("file_add","2");
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

	<div class="sub">
		<div class="box_guide mb20">
			<h2 class="tit">1:1문의</h2>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">고객의 소리</a></li>
					<li><a href="#">1:1문의</a></li>
					<li class="last"><a href="#">글쓰기</a></li>
				</ul>
			</div>
		</div>
		<p class="star ar f_bold">필수 입력사항</p>
		<div class="tblType01 mt10">
		<form name="insertForm" id="insertForm" action="bbt00002Save.action" method="post" enctype="multipart/form-data">
		<!-- <form name="insertForm" id="insertForm" action="bbt00002Save.action" method="post"> -->
			<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" name="boardSeq" id="boardSeq" value="${bbt2View.boardSeq}" />
			<input type="hidden" name="attchCd" id="attchCd" value="${fileList[0].attchCd}" />

			<table>
				<caption>1:1문의 글쓰기</caption>
				<tbody>
					<tr>
						<th scope="row" class="star"><label for="asPart">문의구분</label></th>
						<td>
							<div class="select_bx">
								<select name="questionTp" id="asPart">
									<option value="" selected="selected">선택</option>
									<option value="1" <c:if test="${bbt2View.questionTp eq 'A/S신청'}">selected</c:if> >A/S신청</option>
									<option value="2" <c:if test="${bbt2View.questionTp eq '제품문의'}">selected</c:if> >제품문의</option>
									<option value="3" <c:if test="${bbt2View.questionTp eq '칭찬접수'}">selected</c:if> >칭찬접수</option>
									<option value="4" <c:if test="${bbt2View.questionTp eq '기타'}">selected</c:if> >기타</option>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="goodsPart">제품구분</label></th>
						<td>
							<div class="select_bx">
								<select name="boardCateSeq" id="goodsPart">
									<option value="" selected="selected">선택</option>
									<c:forEach items="${cateList}" var="cateList" varStatus="loop">
										<option value="${cateList.boardCateSeq}" <c:if test="${cateList.boardCateSeq eq bbt2View.boardCateSeq}">selected</c:if> >${cateList.boardCateNm}</option>
									</c:forEach>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="model">제목</label></th>
						<td>
							<div class="input_bx"><input type="text" name="boardTitle" id="boardTitle" value="${bbt2View.boardTitle}" class="w100"></div>
						</td>
					</tr>

					<tr>
						<th scope="row" class="star">내용</th>
						<td>
							<div class="txtArea pb10">
								<textarea id="txtArea1" name="boardCont" value="${bbt2View.boardCont}" onkeyUp="fnByteCheck(this,'1000');">${bbt2View.boardCont}</textarea>
								<div>
									<span class="info">* 최대 1000byte(한글 500자, 영문 1000자)까지 가능</span>
									<span class="cur" id="chkByte">0/1000 byte</span>
								</div>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="file">첨부파일</label></th>
						<td>
							<div class="multi_file">
								<div class="file_add">
								</div>
								<div class="file_ex">
								<span>* 이미지 첨부만 가능.</span><span>0/50 MB</span>
								</div>
								<div class="file_lst">
								    <c:forEach items="${fileList}" var="fileList" varStatus="status">
										<div class="file_lst_bx">
											<span class="input_txt" onclick="exDown('${fileList.attchCd}');"  style="cursor:pointer"><c:out value="${fileList.attchFileNm}" /></span>
												<!--<button class="btn_del"><span class="blind" >파일삭제</span></button> -->
										</div>
					          		</c:forEach>

								</div>
							</div><!-- fileUpload -->
						</td>
						<!-- <td>
							<div class="multi_file">
								<div class="file_add">
									<input type="text" name="#" class="input_txt1"/>
									<input type="file" name="#" class="input_file"/>
									<span class="btn01Type">파일찾기</span><br>
								</div>
								<div class="file_ex">
								<span>* 이미지 첨부만 가능.</span><span>0/50 MB</span>
								</div>
								<div class="file_lst">
								    <div class="file_lst_bx">
										<div class="view_img_bx"></div>
										<span class="input_txt">&nbsp;</span>
										<button class="btn_del"><span class="blind">파일삭제</span></button>
									</div>
								</div>
							</div>fileUpload
						</td> -->
					</tr>


				</tbody>
			</table>

		</form>
		</div>
		<c:choose>
			<c:when test="${bbt2View.boardSeq  ne null  && bbt2View.boardSeq ne ''}">
				<div class="btnArea"><button class="left" id="listBtn">목록</button><button class="right" id="insertBtn">저장</button></div>
			</c:when>
			<c:otherwise>
				<div class="btnArea"><button class="left" id="listBtn">취소</button><button class="right" id="insertBtn">등록</button></div>
			</c:otherwise>
		</c:choose>
	</div>

	<!--// sub -->

</body>