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
	<!-- 게시판관리 : 고객상담관리 & 제품문의 -->

<script type="text/javaScript" defer="defer">

	var oEditors = [];

	var contUrl = "${rootUri}${conUrl}bbt00002R";
	function init(){
		fnEvent();
		fnDataSetting();
		
		$("#fancyboxImg").fancybox({
			beforeShow: function(){
				this.width = 550;
		        this.height = 350;
		    }
		});
	}

	$(window).load(function(){
		nhn.husky.EZCreator.createInIFrame({
			oAppRef: oEditors,
			elPlaceHolder: "boardReply",
			sSkinURI: "/SE/SmartEditor2Skin.html",
			htParams : {
				bUseToolbar : true,				// 툴바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseVerticalResizer : false,	// 입력창 크기 조절바 사용 여부 (true:사용/ false:사용하지 않음)
				bUseModeChanger : true			// 모드 탭(Editor | HTML | TEXT) 사용 여부 (true:사용/ false:사용하지 않음)
			},
			fOnAppLoad : function(){
			},
			fCreator: "createSEditor2"
		});
	});

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
						$(".noBg").css("height", (parseInt(nowHeight)-30)+"px");
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
			oEditors.getById["boardReply"].exec("UPDATE_CONTENTS_FIELD", []);
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
		$.attfileAdd("dtlfileAdd","0");
		<c:if test="${boardMstCd eq 'BBM00003'}">
			$(".noBg").css("height","1000px");
			parent.$.fancybox.update();
		</c:if>
		<c:if test="${boardMstCd eq 'BBM00007'}">
		$(".noBg").css("height","820px");
		parent.$.fancybox.update();
	</c:if>
	}

	function exDown(code){
		fnFileDownLoad(code);
	}

	function fnFancyboxImg(src){
		$("#fancyboxImg").attr("href",src);
		$("#fancyboxImg").click();
	}
</script>
</head>
<body class="noBg" >
<div class="popup_wrap">
	<h2></h2>
	<div class="pageContScroll_st4">
	<div class="table_type2"><form id="workForm" name="workForm"  method="post" <c:choose><c:when test="${not empty funcList}">action="bbt00001Save.action" enctype="multipart/form-data"</c:when><c:otherwise>action="bbt00001NoFileSave.action"</c:otherwise></c:choose>>
		<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardMstCd}" />
		<input type="hidden" name="boardSeq" id="boardSeq" value="${viewMap.boardSeq}" />
		<input type="hidden" name="bbtCd" id="bbtCd" value="bbt00002" />
		<table>
			<caption>분류, 작성일, 제목, 내용, 답변, 첨부파일, 최초 등록자, 최초 등록일, 최근 수정자, 최근 수정일로 구성된 고객상담관리에 대한 등록 테이블 입니다.</caption>
			<colgroup>
				<col style="width:12%;">
				<col style="width:42%;">
				<col style="width:12%;">
				<col style="width:43%;">
			</colgroup>
			<tbody>
				<tr>
					<th scope="row">진행상태</th>
					<td>
						<c:choose>
							<c:when test="${not empty viewMap.boardCateNm}">${viewMap.boardCateNm}</c:when>
							<c:otherwise>처리중</c:otherwise>
						</c:choose>
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
					<th scope="row">문의구분</th>
					<td>
						${viewMap.questionTp}
					</td>
					<th scope="row">제품</th>
					<td >
						
							<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${viewMap.boardCateSeq}"/>${viewMap.boardCateNm}
						
					</td>
				</tr>
				<tr>
					<th scope="row">제목</th>
					<td colspan="3">
						${viewMap.boardTitle}
					</td>
				</tr>
				<tr>
					<th scope="row">내용</th>
					<td colspan="3">
						<div id="boardCont" style="font-family:dotum;font-size:14px;padding:5px;"></div>
							<textarea name="boardCont_Text" id="boardCont_Text" style="display:none;" ><c:if test="${not empty viewMap.boardCont}">${viewMap.boardCont}</c:if></textarea>
							<script type="text/javascript">
				            	$("#boardCont").html(decodeTag($("#boardCont_Text").html()));
					        </script>
					</td>
				</tr>
				<tr>
					<th scope="row">답변</th>
					<td colspan="3">
						<div class="edit_area">
							<div class="editScroll" >
								<textarea name="boardReply" id="boardReply"  style="width:100%; height:200px;">${replyMap.boardReply}</textarea>
						    </div>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">이미지</th>
					<td colspan="3">
						<c:forEach items="${fileList}" var="fileList" varStatus="status">
							<div style="float:left;margin-right:10px;" onclick="fnFancyboxImg('${fileList.attchFilePath}');">
								<img src="${fileList.attchFilePath}" style="width:140px;height:94px;"/>
							</div>
						</c:forEach>
					</td>
				</tr>
				<tr>
					<c:forEach items="${funcList}" var="funcList">
						<c:if test="${funcList.boardFuncCd=='BBF00001'}">
							<c:if test="${empty viewMap}">
          						<th scope="row">첨부파일</th>
          						<td colspan="3" class="dtlfileAdd"></td>
          					</c:if>
		          			<c:if test="${!empty viewMap}">
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
		          			</c:if>
						</c:if>
					</c:forEach>
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
	<a id="fancyboxImg" href="javascript:;"></a>
	</div>
</body>
</html>