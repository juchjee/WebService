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

	var contUrl = "${rootUri}${conUrl}bbt00006R";
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


		$.dtlAttDel = function(attchCd,idx){
			if(confirm("삭제하시겠습니까?")){
				fnAjax("bbt00001FD.action", {"attchCd" : attchCd}, function(data, dataType){
					$(".nowDtlAtt").eq(idx).html("");
					var data = data.replace(/\s/gi,'');
					alert(data);
				},'POST','text');
			}
		}

		$(".popup_wrap > h2").text(parent.$("#tit_depths0").text()+" 1:1문의 답변등록");
	}

	function fnDataSetting(){
		$.attfileAdd("dtlfileAdd","0");
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
<body class="noBg" style="height:680px">
	<div class="popup_wrap">
	<h2></h2>
	<div class="pageContScroll_st4">
	<div class="table_type2">
		<form id="workForm" name="workForm" action="bbt00006Save.action" method="post" enctype="multipart/form-data">
		<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardMstCd}" />
		<input type="hidden" name="boardSeq" id="boardSeq" value="${viewMap.boardSeq}" />
		<table>
			<caption>진행상태, 등록일, 문의구분, 제품, 작성자, 제목, 내용, 답변내용으로 구성된 제품후기관리에 대한 등록 테이블 입니다.</caption>
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
						${viewMap.boardState}
					</td>
					<th scope="row">등록일</th>
					<td>
						${viewMap.regDt}
					</td>
				</tr>
				<tr>
					<th scope="row">문의구분</th>
					<td colspan="3">
						${viewMap.questionTp}
					</td>
				</tr>
				<tr>
					<th scope="row">제품</th>
					<td colspan="3">
						${viewMap.boardCateNm}
					</td>
				</tr>
				<tr>
					<th scope="row">작성자</th>
					<td colspan="3">
						${viewMap.regId}
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
	            		<c:out value="${viewMap.boardCont}" escapeXml="false;" />
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
					<th scope="row">답변</th>
					<td colspan="3" id="boardReplyTd">
						<div class="edit_area" style="display:none;">
							<div class="editScroll" >
								<textarea name="boardReply" id="boardReply" rows="10" cols="100" style="width:100%; height:200px;"><c:out value="${viewMap.boardReply}" escapeXml="false;" /></textarea>
				            </div>
				            <script type="text/javascript">
				            	$("#boardReplyTd").html(decodeTag($("#boardReply").html()));
					        </script>
						</div>
					</td>
				</tr>
				<tr>
					<th scope="row">답변자</th>
					<td>
						<c:if test="${viewMap.boardReply ne ''}">${viewMap.repId}</c:if>
					</td>
					<th scope="row">답변등록일</th>
					<td>
						<c:if test="${viewMap.boardReply ne ''}">${viewMap.repDt}</c:if>
					</td>
				</tr>
			</tbody>
		</table>
	</form>
	</div>
	</div>
	<div class="btn_area">
		<div class="center">
			<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">닫기</a>
		</div>
	</div>
	<a id="fancyboxImg" href="javascript:;"></a>
	</div>
</body>
</html>