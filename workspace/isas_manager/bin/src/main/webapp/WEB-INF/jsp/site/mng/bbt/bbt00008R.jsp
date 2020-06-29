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

	<!-- 게시판관리 : I6SHOP소식관리 등록 -->

<script type="text/javaScript" defer="defer">

	var oEditors = [];
	var contUrl = "${rootUri}${conUrl}bbt00002R";

	function init(){
		fnEvent();

		fnDataSetting();
		
		//등록 썸네일 셋팅
		$("#youtubeLink").change(function(){
			//fnSumImg($("#youtubeLink").val());
			fnSumImg($("#youtubeLink").val());
		});
		
		
		//수정 썸네일 셋팅
		if("${tpMap.youtubeLink}"!=""){
			var utvLink="${tpMap.youtubeLink}";
			fnSumImg(utvLink);
		}
		
		//이미지 팝업
		$("#fancyboxImg").fancybox({
			beforeShow: function(){
				this.width = 550;
		        this.height = 350;
		    }
		});
	}
	
	//썸네일 셋팅
	
	function fnSumImg(data) {
	    var sumImg = "";
		var arrData ="";
	    if(data)  {
	        var regExp = /^.*((youtu.be\/)|(v\/)|(\/u\/\w\/)|(embed\/)|(watch\?))\??v?=?([^#\&\?]*).*/;
	        var matchs = data.match(regExp);
	        if (matchs) {
	        	sumImg += matchs[7];
	        }
	        if(sumImg.match("</iframe>")){
	        	arrData = sumImg.split("\"");
	        	sumImg = arrData[0];
	        }
	        $("#youtubeLink1").attr("src","http://img.youtube.com/vi/"+sumImg+"/mqdefault.jpg");
	    }
	}

	function fnEvent(){

		$.attfileAdd = function(className,len){
			$("."+className).append("<div class=\"attfileAdd\" style=\"margin-top:5px;\">"+
				"	<div  class=\"fl\">"+
		        "		<input type=\"text\" name=\"dtlFileName\" class=\"fl verT marL5 \"title=\"썸네일이미지\" style=\"width:400px;\" /><a class=\"fl dtlImg btn_type1 marL10\" href=\"javascript:;\">파일찾기</a>"+
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


			fnSubmit("workForm","저장");
		}

		$.dtlAttDel = function(attchCd,idx){
			if(confirm("삭제하시겠습니까?")){
				fnAjax("bbt00001FD.action", {"attchCd" : attchCd}, function(data, dataType){
					$(".nowDtlAtt").eq(idx).remove();
					var data = data.replace(/\s/gi,'');
					alert(data);
				},'POST','text');
			}
		}

	

		$(".popup_wrap > h2").text(parent.$("#tit_depths0").text()+" 등록/수정");
	}

	function fnDataSetting(){
		<c:if test="${empty viewMap.boardSeq}">
			$(".noBg").css("height","480px")
		</c:if>
		<c:if test="${not empty viewMap.boardSeq}">
			$(".noBg").css("height","550px")
		</c:if>
			
			$.attfileAdd("dtlfileAdd","0");
	}

	function exDown(code){
		fnFileDownLoad(code);

	}
	
	function fnFancyboxImg(){
		$("#fancyboxImg").attr("href",$("#youtubeLink1").attr("src"));
		$("#fancyboxImg").click();
	}

</script>
</head>
<body class="noBg" >

	<div class="popup_wrap">
		<h2></h2>
		<div class="pageContScroll_st4">
		<div class="table_type2">
			<form id="workForm" name="workForm" action="bbt00008Save.action" method="post" enctype="multipart/form-data">
				<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardMstCd}" />
				<input type="hidden" name="boardSeq" id="boardSeq" value="${viewMap.boardSeq}" />
				<input type="hidden" name="bbtCd" id="bbtCd" value="bbt00008" />
				<input type="hidden" name="attchCd" id="attchCd" value="${fileList[0].attchCd}" />
			<table>
				<caption>분류, 작성일, 제목, 썸네일등록, 내용, 첨부파일, 최초 등록자, 최초 등록일, 최근 수정자, 최근 수정일로 구성된 소식관리에 대한 등록 테이블 입니다.</caption>
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
							<c:forEach items="${funcList}" var="funcList">
								<c:if test="${funcList.boardFuncCd=='BBF00001'}">
									<c:if test="${empty fileList}">
		          						<th scope="row">리스트썸네일</th>
		          						<td colspan="3" class="dtlfileAdd" style="padding:0px 15px 5px 7px;"></td>
		          					</c:if>
				          			<c:if test="${!empty fileList}">
				          				<th scope="row">리스트썸네일</th>
				          				<td colspan="3" class="dtlfileAdd" style="padding:0px 15px 5px 7px">
					          				<c:forEach items="${fileList}" var="fileList" varStatus="status">
					          					<div class="nowDtlAtt" style="padding:5px 0 5px 10px;">
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
					<tr>
						<th scope="row">화면가로크기</th>
						<td>
							<input type="text" name="mavWidth" id="mavWidth"  class="validation[number]" title="가로크기" style="width:100px"  placeholder="0" value="<c:choose><c:when test="${empty tpMap.imageWidth}">670</c:when><c:otherwise>${tpMap.imageWidth}</c:otherwise></c:choose>" />
						</td>
						<th scope="row">화면세로크기</th>
						<td>
							<input type="text" name="movHeight" id="movHeight" class="validation[number]" title="세로크기" style="width:100px"  placeholder="0" value="<c:choose><c:when test="${empty tpMap.imageHeight}">376</c:when><c:otherwise>${tpMap.imageHeight}</c:otherwise></c:choose>" />
						</td>
					</tr>
					<tr>
						<th scope="row">내용</th>
						<td colspan="3">
							<textarea name="boardCont" id="boardCont"  style="width:97%; height:100px;font-family:dotum;font-size:14px;padding:10px;">${viewMap.boardCont}</textarea>
						</td>
					</tr>
					<tr>
						<th scope="row">유튜브링크</th>
						<td colspan="3">
							<input type="text" name="youtubeLink" id="youtubeLink"style="width:600px;" class="validation[required]" title="유튜브링크" value="${tpMap.youtubeLink}" />
						</td>
					</tr>
					<tr>
						<th scope="row">유튜브이미지</th>
						<td colspan="3">
							<img src="" name="youtubeLink1" id="youtubeLink1" onclick="fnFancyboxImg();"> />
							
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
	<a id="fancyboxImg" href="javascript:;"></a>
	</div>
</body>