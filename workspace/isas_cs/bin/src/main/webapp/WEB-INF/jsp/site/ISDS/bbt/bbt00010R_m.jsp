<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
	
		function init(){
			//fnSetting();
			fnEvent();
		}

		function fnSetting(){
			    oEditors = [];
				nhn.husky.EZCreator.createInIFrame({
					oAppRef: oEditors,
					elPlaceHolder: "boardCont",
					sSkinURI: "/SE/SmartEditor2Skin.html",
					htParams : {
						bUseToolbar : false,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseModeChanger : false			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
					},
					fOnAppLoad : function(){  },
					fCreator: "createSEditor2"
				});
		  }

		function fnEvent(){
			$("#listBtn").bind("click",function(){
				var param = "";
				if("${param.page}" != ""){
					 param = "&page=${param.page}";
				}
				location.href="bbt00010.do?pageCd=${param.pageCd}"+param;
			});

			$("#saveBtn").bind("click",function(){
				/* if(oEditors[0].getIR()=="<p><br></p>"){
					alert("내용은 필수 항목입니다.");
					return false;
				} */

				//oEditors.getById["boardCont"].exec("UPDATE_CONTENTS_FIELD", []);
				fnSubmit("workForm","저장");
			});

			$("#delBtn").bind("click",function(){
				$.delSubmit = function(){
					if(confirm('삭제하겠습니까?')){
						$('#workForm').attr('action', 'bbt00010Del.action');
						$("#workForm").submit();
					}else{
						return;
					}
				}
			});
		}
	</script>
</head>
<body>


	<div class="sub">
		<form id="workForm" name="workForm" action="bbt00010Save.action" method="post" >
			<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" name="boardSeq" id="boardSeq" value="${param.boardSeq}" />
			<input type="hidden" name="page" value="${param.page}">
			<c:if test="${param.boardCateSeq eq null}">
				<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${noticeView.boardCateSeq}" />
			</c:if>
			<c:if test="${noticeView.boardCateSeq eq null}">
				<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${param.boardCateSeq}" />
			</c:if>
		<div class="tit_bx">
			<a href="javascript:history.back()" class="btn_prev">이전 화면</a>
			<h2>글쓰기</h2>
		</div>
		<!--// tit_bx -->
		<div class="ing_bx nobg">
			<div class="box">
				<div class="tit">칭찬합시다<span class="star">필수입력사항</span></div>
				<dl class="type01">
					<dt class="star">성명</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" id="regName" name="regName" title="성명" class="validation[required]" value="${noticeView.regName}" maxlength="6"/>
						</div>
					</dd>
					<dt>칭찬대상자</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" id="recomName" name="recomName" class="" value="${noticeView.recomName}" maxlength="50"/>
						</div>
					</dd>
					<dt class="star">제목</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" id="boardTitle" name="boardTitle" value="${noticeView.boardTitle}" title="제목" class="validation[required]" class="" />
						</div>
					</dd>
					<dt class="star">내용</dt>
					<dd class="hauto">
						<div class="txtarea_bx">
							<textarea name="boardCont" id="boardCont" title="내용" class="validation[required]">${noticeView.boardCont}</textarea>
							<!-- <p class="unit_byte"><span>0</span>/1000 byte</p> -->
						</div>
					</dd>

					<!-- dt>첨부파일</dt>
					<dd class="hauto">
						<div class="input_txt_bx upload_area">
							<input type="text" name="" id="" value="" class="smInput1"/>
							<a href="#" class="smBtn">찾기</a>
							<p class="unit_byte"><span>0</span>/50MB</p>
						</div>
					</dd> -->
				</dl>
			</div>
		</div>
		<!--// ing_bx -->

		<div class="btnWrap wide pd15">
			<a href="#none" id="listBtn" class="btn gray">취소</a>
			<a href="#none" id="saveBtn" class="btn blue">등록</a>
		</div>
		</form>
	</div>
</body>