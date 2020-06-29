<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
	
		function init(){
			fnSetting();
			fnEvent();
		}

		function fnSetting(){
			    oEditors = [];
				nhn.husky.EZCreator.createInIFrame({
					oAppRef: oEditors,
					elPlaceHolder: "boardCont",
					sSkinURI: "/SE/SmartEditor2Skin.html",
					htParams : {
						bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
						bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
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
				if(oEditors[0].getIR()=="<p><br></p>"){
					alert("내용은 필수 항목입니다.");
					return false;
				}

				oEditors.getById["boardCont"].exec("UPDATE_CONTENTS_FIELD", []);
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
		<div class="box_guide">
			<h2 class="tit">칭찬합시다</h2>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">고객의 소리</a></li>
					<li><a href="#">칭찬합시다</a></li>
					<li class="last"><a href="#">칭찬합시다</a></li>
				</ul>
			</div>
		</div>

		<div class="tblType01 mt30">
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

			<table>
				<caption>칭찬합시다 글쓰기</caption>
				<tbody>
					<tr>
						<th scope="row" class="star"><label for="model">성명</label></th>
						<td>
							<div class="input_bx"><input type="text" id="regName" name="regName" title="성명" class="validation[required]" value="${noticeView.regName}" maxlength="6"></div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="model">칭찬대상자</label></th>
						<td>
							<div class="input_bx"><input type="text" id="recomName" name="recomName" title="칭찬대상자" value="${noticeView.recomName}" maxlength="50"></div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="model">제목</label></th>
						<td>
							<div class="input_bx"><input type="text" id="boardTitle" name="boardTitle" title="제목" class="validation[required]" class="w100"  value="${noticeView.boardTitle}"></div>
						</td>
					</tr>

					<tr>
						<th scope="row" class="star">내용</th>
						<td>
							<div class="txtArea pb10">
<!-- 								<textarea id="txtArea1" name="trouble" value=""></textarea> -->
								<textarea name="boardCont" id="boardCont" class="validation[required]" title="내용" style="width:100%; height:340px;">${noticeView.boardCont}</textarea>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			</form>
		</div>
		<div class="btnArea"><button class="left" id="listBtn">취소</button><button class="right" id="saveBtn">등록</button></div>
	</div>
</body>