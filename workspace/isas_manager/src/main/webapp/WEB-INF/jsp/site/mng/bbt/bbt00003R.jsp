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
	<!-- 게시판관리 : 제품후기관리 수정 (수정화면만 존재) -->

<script type="text/javaScript" defer="defer">

	var oEditors = [];

	var contUrl = "${rootUri}${conUrl}bbt00003R";
	function init(){

	  fnEvent();

	  fnDataSetting();

	}

	function fnEvent(){
		$.attfileAdd = function(className,len){
			$("."+className).append("<div class=\"attfileAdd\" style=\"margin-top:5px;\">"+
				"	<div  class=\"fl\">"+
		        "		<input type=\"text\" name=\"dtlFileName\" class=\"fl verT marL5\" style=\"width:400px;\" /><a class=\"fl dtlImg btn_type1 marL10\" href=\"javascript:;\">파일찾기</a>"+
		        "		<a href=\"javascript:;\"  class=\"fl fileAdd btn_type4\">+</a>"+
		        "	</div>"+
	    		"</div>");


				$(".attfileAdd > div > .fileAdd").unbind("click");
				$(".attfileAdd > div > .fileAdd").bind("click",function() {
					if($(this).text() == "+"){
						/*popup update start*/
						var nowHeight = $(".noBg").css("height").replace(/\px/gi,'');
						$(".noBg").css("height", (parseInt(nowHeight)+33)+"px");
						parent.$.fancybox.update();
						/*popup update end*/

						$(this).removeClass("btn_type4");
						$(this).addClass("btn_type5");
						$(this).text("-");
						$.attfileAdd(className,$('.attfileAdd').length);
					}else if($(this).text() == "-"){

						/*popup update start*/
						var nowHeight = $(".noBg").css("height").replace(/\px/gi,'');
						$(".noBg").css("height", (parseInt(nowHeight)-33)+"px");
						parent.$.fancybox.update();
						/*popup update end*/

						var fileAddIdx = $(".attfileAdd > div > .fileAdd").index(this);
				 		var fileId = "dtlFilePath_"+fileAddIdx;
					 	$("form[name=workForm]").find("input[name=dtlFilePath_seq]").eq(fileAddIdx).remove();
					 	$("form[name=workForm]").find("input[class="+fileId+"]").remove();

					 	$(".attfileAdd").eq(fileAddIdx).remove();

						$("form[name=workForm]").find("input[name=dtlFilePath]").each(function(index, item){
							var reClassNameArr = $(this).attr("class").split("_");
				            var reClassName = reClassNameArr[0];

			            	var seqInput = $("form[name=workForm]").find("input[name=dtlFilePath_seq]");

				            if(reClassNameArr[1] > fileAddIdx){
					            var reClassIdx = (reClassNameArr[1]-1);
				            	$(this).attr("class",reClassName+"_"+reClassIdx);
				            	seqInput.eq(index).val(reClassIdx);
				            }
				        });
					}else{
						return false;
					}
				});

				$(".dtlImg").unbind("click");
				/*----------------------------- 상세이미지 - 파일 찾기 버튼 클릭 이벤트(소멸성이벤트) -----------------------------*/
				$(".dtlImg").bind("click",function() {
					//확장형 첨부일 경우 인덱스 인자 추가 전달
					var idx = $(".dtlImg").index(this);
					//파라메터 값 object 형
				  		var obj = new Object();
				  		obj.fileAttrName = "dtlFilePath"; //실제 전달할 파일 속성명
				  	   	obj.fileViewAttrName = "dtlFileName"; //현재 노출되는 속성명 name
				  	   	obj.form = "workForm"; //전송할 form name
				  	   	//obj.filetype = "image"; //파일 제한 종류 -- image (현재 이미지만 구현)
				  	   	obj.index = idx; //확장형 첨부파일일 경우 사용될 인덱스
					fileSearch(obj);
				});

		}

		$.submit = function(){
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



		$(".popup_wrap > h2").text(parent.$("#tit_depths0").text()+" 등록/수정");

	}

	function fnDataSetting(){

		var prodGrade = "${reviewMap.prodGrade}";

		if(prodGrade == "5"){
				returnValue = "<div class='star_wrap' style='position: relative;top: -8px;'><span class=\"star5\"><em>만족도</em></span></div>";
			}else if(prodGrade == "4"){
				returnValue = "<div class='star_wrap' style='position: relative;top: -8px;'><span class=\"star4\"><em>만족도</em></span></div>";
			}else if(prodGrade == "3"){
				returnValue = "<div class='star_wrap' style='position: relative;top: -8px;'><span class=\"star3\"><em>만족도</em></span></div>";
			}else if(prodGrade == "2"){
				returnValue = "<div class='star_wrap' style='position: relative;top: -8px;'><span class=\"star2\"><em>만족도</em></span></div>";
			}else if(prodGrade == "1"){
				returnValue = "<div class='star_wrap' style='position: relative;top: -8px;'><span class=\"star1\"><em>만족도</em></span></div>";
			}


	    $("#jqxRating").html(returnValue);

		//$.attfileAdd("dtlfileAdd","0"); //첨부파일 생성

	}

	function exDown(code){
		fnFileDownLoad(code);
	}

</script>
</head>
<body class="noBg" >
	<div class="popup_wrap">
	<h2></h2>
	<div class="pageContScroll_st4">
	<div class="table_type2">
		<form id="workForm" name="workForm"  method="post" <c:choose><c:when test="${not empty funcList}">action="bbt00001Save.action" enctype="multipart/form-data"</c:when><c:otherwise>action="bbt00001NoFileSave.action"</c:otherwise></c:choose>>
		<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardMstCd}" />
		<input type="hidden" name="boardSeq" id="boardSeq" value="${viewMap.boardSeq}" />
		<input type="hidden" name="prodGrade" id="prodGrade" value="${reviewMap.prodGrade}" />
				<input type="hidden" name="bbtCd" id="bbtCd" value="bbt00003" />
		<table>
			<caption>분류, 작성일, 제목, 내용, 답변, 첨부파일, 최초 등록자, 최초 등록일, 최근 수정자, 최근 수정일로 구성된 제품후기관리에 대한 등록 테이블 입니다.</caption>
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
						<select id="boardCateSeq" name="boardCateSeq" style="width:100px;display:none;">
							<c:forEach items="${cateList}" var="cateList">
								<option value="${cateList.boardCateSeq}" <c:if test="${cateList.boardCateSeq eq viewMap.boardCateSeq}">selected</c:if> >${cateList.boardCateNm}</option>
							</c:forEach>
						</select>
						<c:if test="${prodCnt!=0}">
							<select id="prodCd" name="prodCd" style="width:200px;">
								<c:forEach items="${prodList}" var="prodList">
									<option value="${prodList.prodCd}" <c:if test="${prodList.prodCd eq viewMap.prodCd}">selected</c:if> >${prodList.prodNm}</option>
								</c:forEach>
							</select>
						</c:if>
					</td>
					<th scope="row">작성일</th>
					<td>
						${viewMap.regDt}
						<input type="hidden" name="regDt" id="regDt" value="${viewMap.regDt}" />
					</td>
				</tr>
				<tr>
					<th scope="row">제목</th>
					<td>
<%-- 						<input type="text" name="boardTitle" id="boardTitle" class="validation[required]" title="제목" value="${viewMap.boardTitle}" style="width:400px;"> --%>
						<div id="boardTitle" style="font-family:dotum;font-size:14px;padding:5px;">${viewMap.boardTitle}</div>
					</td>
					<th scope="row">별점</th>
					<td id="jqxRating">
					</td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td colspan="3">
							<div id="boardCont" style="font-family:dotum;font-size:14px;padding:5px; min-height:150px;"></div>
									  <textarea name="boardCont_Text" id="boardCont_Text" style="display:none;" ><c:if test="${not empty viewMap.boardCont}">${viewMap.boardCont}</c:if></textarea>
										<script type="text/javascript">
				            				$("#boardCont").html(decodeTag($("#boardCont_Text").html()));
					            		</script>
<!-- 						<div class="edit_area"> -->
<!-- 							<div class="editScroll" > -->
<%-- 								<textarea name="boardCont" id="boardCont" class="validation[required]" title="내용" rows="10" cols="100" style="width:100%; height:60px;">${viewMap.boardCont}</textarea> --%>

<!-- 				            </div> -->
<!-- 						</div> -->
					</td>
				</tr>
				<tr>
					<th scope="row">답변</th>
					<td colspan="3">
						<div class="edit_area">
							<div class="editScroll" >
								<!--<textarea name="boardReply" id="boardReply"  style="width:97%; height:100px;font-family:dotum;font-size:14px;padding:10px;float:left;"><c:if test="${empty reviewMap.boardReply}">(inus)&#10;안녕하세요 고객님. 소중한 의견 고맙습니다.&#10;고객님의 소중한 의견을 바탕으로 더 좋은 제품과 서비스 만들어 가도록 하겠습니다.&#10;inus과 함께 항상 건강하세요~&#10;&#10;** inus 프로바이오틱스는 질병 치료의 목적이 아닌 장내 유익균 증식 및 유해균 억제 그리고 원활한 배변활동에 도움을 주는 건강기능식품입니다.</c:if><c:if test="${!empty reviewMap.boardReply}">${reviewMap.boardReply}</c:if></textarea>-->
								<textarea name="boardReply" id="boardReply"  style="width:97%; height:100px;font-family:dotum;font-size:14px;padding:10px;float:left;"><c:if test="${empty reviewMap.boardReply}">(inus)&#10;안녕하세요 고객님. 소중한 의견 고맙습니다.&#10;고객님의 소중한 의견을 바탕으로 더 좋은 제품과 서비스 만들어 가도록 하겠습니다.&#10;inus과 함께 항상 건강하세요~&#10;<c:if test="${viewMap.prodCategoryCd == 'PPC00189'}">&#10;** inus 프로바이오틱스는 질병 치료의 목적이 아닌 장내 유익균 증식 및 유해균 억제 그리고 원활한 배변활동에 도움을 주는 건강기능식품입니다.</c:if><c:if test="${viewMap.prodCategoryCd == 'PPC00210'}">&#10;** inus 듀얼기능 복합제품은 질병 치료를 위한 의약품이 아닌 건강기능식품입니다.</c:if></c:if><c:if test="${!empty reviewMap.boardReply}">${reviewMap.boardReply}</c:if></textarea>
							</div>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">첨부파일</th>
					<td colspan="3" class="dtlfileAdd">
						<c:forEach items="${fileList}" var="fileList" varStatus="status">
							<div class="nowDtlAtt">
								<a href="javascript:;" onclick="exDown('${fileList.attchCd}');">
									<c:out value="${fileList.attchFileNm}" />
								</a>
								<a href="javascript:;">
									<img src="${rootUri}images/btn_keyword_del.png" alt="삭제" onclick="$.dtlAttDel('${fileList.attchCd}','${status.index}');">
								</a>
							</div>
						</c:forEach>
					</td>
				</tr>
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
			</tbody>
		</table>
	</form>
	</div>
	</div>
	<div class="btn_area">
		<div class="center">
			<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">취소</a>
			<a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">수정</a>
		</div>
	</div>
	</div>
</body>
</html>