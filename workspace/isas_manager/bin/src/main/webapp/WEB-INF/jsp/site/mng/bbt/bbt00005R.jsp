<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />

	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
	<!-- 게시판관리 : inus소식관리 등록 -->

<script type="text/javaScript" defer="defer">

	var oEditors = [];

	var contUrl = "${rootUri}${conUrl}bbt00002R";

	function init(){

		fnEvent();

		fnDataSetting();

	}

	$(window).load(function(){
		/* popup(contents) update */
		<c:if test="${empty viewMap.boardSeq}">$("#boardCont").css("height","320px");</c:if>

		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "boardCont",
			sSkinURI: "/SE/SmartEditor2Skin.html",
			htParams : {
				bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			},
			fOnAppLoad : function(){
				//_${divName}Arr.getById["${divName}"].exec("PASTE_HTML", [parent.$("#${divName}_Text").text()]);//부모 윈도우의  내용을 가지고 온다.
				//$("#btn_div").show();
			},
			fCreator: "createSEditor2"
		});
	});

	function fnEvent(){

		$(".bisImg").unbind("click");
		$(".bisImg").bind("click",function() {
			fileSearch({fileAttrName:"dtlImgPath",fileViewAttrName:"sumImgName",form:"workForm",filetype:'image'});
		});

		$.submit = function(){
			if($("#boardCateSeq").val()==""){
				alert("분류은(는) 필수 항목입니다.");
				$("#boardCateSeq").focus();
				return false;
			}
			if($("#boardTitle").val()==""){
				alert("제목은(는) 필수 항목입니다.");
				$("#boardTitle").focus();
				return false;
			}
			/* if($("#imageWidth").val()==""||$("#imageWidth").val()==0){
				alert("가로크기은(는) 필수 항목입니다.");
				$("#imageWidth").focus();
				return false;
			}
			if($("#imageHeight").val()==""||$("#imageHeight").val()==0){
				alert("세로크기은(는) 필수 항목입니다.");
				$("#imageHeight").focus();
				return false;
			} */
			if($("input:radio[name='contState']:checked").val()=="E"){
				if(oEditors[0].getIR()=="<p><br></p>"){
					alert("내용은(는) 필수 항목입니다.");
					return false;
				}
				oEditors.getById["boardCont"].exec("UPDATE_CONTENTS_FIELD", []);
			}

			fnSubmit("workForm","저장");
		}

		$.dtlAttDel = function(attchCd,idx){
			if(confirm("삭제하시겠습니까?")){
				fnAjax("bbt00001FD.action", {"attchCd" : attchCd}, function(data, dataType){
					$(".nowDtlAtt").eq(idx).html("");
					var data = data.replace(/\s/gi,'');
					alert(data);
				},'POST','text');
			}
		}

		$("input:radio[name='contState']").on('change', function(){
			var state = $("input:radio[name='contState']:checked").val();
			<c:if test="${!empty viewMap}">
				if(state=='L'){
					$('.linkScroll').show();
					$('.editScroll').hide();
					$("input[name=boardCont]").attr("disabled", false);
					$("textarea[name=boardCont]").attr("disabled", true);
					$(".noBg").css("height","500px");
					parent.$.fancybox.update();
				}else if(state=='E'){
					$('.editScroll').show();
					$('.linkScroll').hide();
					$("input[name=boardCont]").attr("disabled", true);
					$("textarea[name=boardCont]").attr("disabled", false);
					$(".noBg").css("height","850px");
					parent.$.fancybox.update();
				}
			</c:if>
			<c:if test="${empty viewMap}">
				if(state=='L'){
					$('.linkScroll').show();
					$('.editScroll').hide();
					$("input[name=boardCont]").attr("disabled", false);
					$("textarea[name=boardCont]").attr("disabled", true);
					$(".noBg").css("height","380px");
					parent.$.fancybox.update();
				}else if(state=='E'){
					$('.editScroll').show();
					$('.linkScroll').hide();
					$("input[name=boardCont]").attr("disabled", true);
					$("textarea[name=boardCont]").attr("disabled", false);
					$(".noBg").css("height","760px");
					parent.$.fancybox.update();
				}
			</c:if>
		});

		$(".popup_wrap > h2").text(parent.$("#tit_depths0").text()+" 등록/수정");
	}

	function fnDataSetting(){
		<c:if test="${!empty viewMap}">
			$("input[name=contState]:radio[value='${tpMap.imageTpLe}']").attr("checked",true);
			if($("input:radio[name='contState']:checked").val()=='E'){
				$('.editScroll').show();
				$('.linkScroll').hide();
				$("input[name=boardCont]").attr("disabled", true);
				$("textarea[name=boardCont]").attr("disabled", false);
				$(".noBg").css("height","830px");
				parent.$.fancybox.update();
			}else{
				$('.editScroll').hide();
				$('.linkScroll').show();
				$("input[name=boardCont]").attr("disabled", false);
				$("textarea[name=boardCont]").attr("disabled", true);
				$(".noBg").css("height","580px");
				parent.$.fancybox.update();
			}
		</c:if>
		<c:if test="${empty viewMap}">
			$("input[name=contState]:radio").eq(0).attr("checked",true);
			$('.linkScroll').show();
			$('.editScroll').hide();
			$("input[name=boardCont]").attr("disabled", false);
			$("textarea[name=boardCont]").attr("disabled", true);
			$(".noBg").css("height","500px");
			parent.$.fancybox.update();
		</c:if>
	}

	function exDown(code){
		fnFileDownLoad(code);
	}

</script>
</head>
<body class="noBg" style="height:830px">
	<div class="popup_wrap">
		<h2></h2>
		<div class="pageContScroll_st4">
		<div class="table_type2">
		<form id="workForm" name="workForm" action="bbt00005Save.action" method="post" enctype="multipart/form-data">
			<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" name="boardSeq" id="boardSeq" value="${viewMap.boardSeq}" />
			<table>
				<caption>분류, 작성일, 제목, 썸네일등록, 내용, 첨부파일, 최초 등록자, 최초 등록일, 최근 수정자, 최근 수정일로 구성된 inus소식관리에 대한 등록 테이블 입니다.</caption>
				<colgroup>
					<col style="width:12%;">
					<col style="width:42%;">
					<col style="width:12%;">
					<col style="width:43%;">
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">분류</th>
						<td>
							<select id="boardCateSeq" name="boardCateSeq" style="width:100px;">
								<c:if test="${empty viewMap}">
									<option value="">분류선택</option>
									<c:forEach items="${cateList}" var="cateList">
										<option value="${cateList.boardCateSeq}" <c:if test="${cateList.boardCateSeq eq cateSeq}">selected</c:if> >${cateList.boardCateNm}</option>
									</c:forEach>
								</c:if>
								<c:if test="${!empty viewMap}">
									<c:forEach items="${cateList}" var="cateList">
										<option value="${cateList.boardCateSeq}" <c:if test="${cateList.boardCateSeq eq viewMap.boardCateSeq}">selected</c:if> >${cateList.boardCateNm}</option>
									</c:forEach>
								</c:if>
							</select>
						</td>
						<th scope="row">작성일</th>
						<td>
							<c:if test="${empty viewMap}">
								${nowYmd}
								<input type="hidden" name="regDt" id="regDt" value="${nowYmd}" />
							</c:if>
							<c:if test="${!empty viewMap}">
								${viewMap.regDt}
								<input type="hidden" name="regDt" id="regDt" value="${viewMap.regDt}" />
							</c:if>
						</td>
					</tr>
					<tr>
						<th scope="row">제목</th>
						<td colspan="3">
							<input type="text" name="boardTitle" id="boardTitle" class="validation[required]" title="제목" style="width:600px;" value="${viewMap.boardTitle}">
						</td>
					</tr>
					<tr>
						<th scope="row">썸네일등록</th>
						<td colspan="3">
							<c:forEach items="${fileList}" var="fileList" varStatus="status">
	          					<c:if test="${fileList.attchId eq 'boardBBT5Img'}" >
		          					<div class="nowDtlAtt">
										<a href="javascript:;" onclick="exDown('${fileList.attchCd}');">
											<c:out value="${fileList.attchFileNm}" />
										</a>
		                				<a href="javascript:;">
		                				<img src="${rootUri}images/btn_keyword_del.png" alt="삭제" onclick="$.dtlAttDel('${fileList.attchCd}','${status.index}');">
		                				</a>
									</div>
								</c:if>
	          				</c:forEach>
							<input type="text" name="sumImgName" id="sumImgName" class="marR5" style="width:200px" readonly="readonly" />
							<a class="bisImg btn_type1  marL10" href="javascript:;">파일찾기</a>
						</td>
					</tr>
					<tr>
						<th scope="row">화면가로크기</th>
						<td>
							<input type="text" name="imageWidth" id="imageWidth"  class="validation[number]" title="가로크기" style="width:100px"  placeholder="0" value="${tpMap.imageWidth}" />
						</td>
						<th scope="row">화면세로크기</th>
						<td>
							<input type="text" name="imageHeight" id="imageHeight" class="validation[number]" title="세로크기" style="width:100px"  placeholder="0" value="${tpMap.imageHeight}" />
						</td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td colspan="3">
							<input type="radio" name="contState" value="L" id="answer1" class="marR5" /><label for="answer1">링크</label>&nbsp;&nbsp;
							<input type="radio" name="contState" value="E" id="answer2" class="marR5" /><label for="answer2">에디터</label>

							<div class="edit_area" style="margin-top:5px;">
								<div class="linkScroll">
									<input type="text" name="boardCont" style="width:600px;" value="${viewMap.boardCont}" />
								</div>
								<div class="editScroll" style="display:none;" >
									<textarea name="boardCont" id="boardCont" class="validation[required]" title="내용" rows="10" cols="100" style="width:100%; height:300px;">${viewMap.boardCont}</textarea>
					            </div>
							</div>

						</td>
					</tr>
					<c:if test="${!empty viewMap}">
		        		<tr>
							<th scope="row">최초 등록자</th>
							<td>
								${viewMap.regId}&nbsp;&nbsp;&nbsp;(&nbsp;${viewMap.regNm}&nbsp;-&nbsp;${viewMap.regMa}&nbsp;)
							</td>
							<th scope="row">최초 등록일</th>
							<td>
								${viewMap.regDt}
							</td>
						</tr>
						<tr>
							<th scope="row">최근 등록자</th>
							<td>
								${viewMap.modId}&nbsp;&nbsp;&nbsp;(&nbsp;${viewMap.modNm}&nbsp;-&nbsp;${viewMap.modMa}&nbsp;)
							</td>
							<th scope="row">최근 등록일</th>
							<td>
								${viewMap.modDt}
							</td>
						</tr>
					</c:if>
				</tbody>
			</table>
			</form>
		</div>
	</div>
	<div class="btn_area">
		<div class="center">
			<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">취소</a>
			<a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">등록</a>
		</div>
	</div>
	</div>
</body>