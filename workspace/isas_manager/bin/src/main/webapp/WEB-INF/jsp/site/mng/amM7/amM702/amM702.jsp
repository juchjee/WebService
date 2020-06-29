<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 설정관리 : 배송/반품/환불정보 설정 -->

<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM702";
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){
		//이벤트 설정
		fnEvent();
// 		$(".addBtn").click();
	}
	function fnEvent(){

		$(".addBtn").bind("click",function() {
			if($(this).text() == "추가"){
				var num = $(".fancybox").length+1;
				$(".addTr").append(
				        "		<tr>"+
				        "		<td>"+
				        "		<input type=\"text\" name=\"retORefTit\" style=\"width:180px\" />"+
						"	    </td>"+
						"	    <td scope=\"row\">"+
						"	    <div class=\"thInfo\"><a class=\"fancybox sme btn_type1\"  data-fancybox-type=\"iframe\" href=\"/mng/smartEditor.action?divName=ROR"+num+"\">에디터호출</a></div>"+
						"		</td>"+
						"	    <td>"+
						"	    <div class=\"editScroll\" >"+
						"       <div id=\"ROR"+num+"\" class=\"edit_area\">"+
						"		</div>"+
						"		</div>"+
						"		<input type=\"hidden\" name=\"retORefSeq\" />"+
						"		<textarea name=\"retORefCont\" id=\"ROR"+num+"_Text\" style=\"display:none;\" ></textarea>"+
						"	    </td>"+
						"	    <td>"+
						"       <a href=\"javascript:;\" class=\"delBtn btn_type2\">삭제</a>"+
						"	    </td>"+
						"		</tr>");
			}
		});

	}

	$.submit = function(){
		$("#workForm").submit();
	}

	$.del = function(num){
		$("#delSeq").val(num);
		$("#delForm").submit();
		$("#delSeq").val("");
	}

</script>
</head>
<body>
	<div class="pageContScroll_st1">
		<div class="align_area">
			<div class="right">
				<a href="javascript:;" class="addBtn btn_type2">추가</a>
				<a href="javascript:;" class="btn_type2" onclick="$.submit();">저장</a>
			</div>
		</div>
			<!-- 삭제를 위한 form -->
			<form id="delForm" name="delForm" action="amM702Del.action" method="post">
				<input type="hidden" id="delSeq" name="delSeq" />
			</form>
		<div class="table_type2">
			<form id="workForm" name="workForm" action="amM702Save.action" method="post">
				<table class="tableAdd">
			        <caption>타이틀명, 내용으로 구성된 배송/반품/환불정보 설정에 대한 작성 테이블 입니다.</caption>
			        <colgroup>
			        	<col style="width:200px;">
			        	<col style="width:120px;">
			        	<col style="width:*">
			        	<col style="width:100px;">
			        </colgroup>
			        <thead>
						<tr>
							<th scope="col">타이틀명</th>
							<th scope="col">에디터</th>
							<th scope="col">내용</th>
							<th scope="col">삭제</th>
						</tr>
					</thead>
			        <tbody class="addTr">
						<c:forEach items="${amM701L}" var="amM701L" varStatus="status">
							<tr>
								<td>
									<input type="text" name="retORefTit" value="${amM701L.retORefTit}" style="width:180px" />
								</td>
								<td scope="row">
									<div class="thInfo">
										<c:if test="${!empty amM701L.retORefSeq}">
										<a class="fancybox sme btn_type1"  data-fancybox-type="iframe" href="/mng/smartEditor.action?divName=ROR${status.count}">에디터호출</a>
										</c:if>
									</div>
								</td>
								<td>
					            	<textarea name="retORefCont" id="ROR${status.count}_Text" style="display:none;" ><c:if test="${not empty amM701L.retORefCont}">${amM701L.retORefCont}</c:if></textarea>
									<div class="editScroll" >
							            <div id="ROR${status.count}" class="edit_area">
							            		<c:if test="${empty amM701L.retORefCont}">
							            		미리보기 -  내용이 없습니다.
							            		</c:if>
							            </div>
							            <c:if test="${not empty amM701L.retORefCont}">
							            <script type="text/javascript">
				            				$("#ROR${status.count}").html(decodeTag($("#ROR${status.count}_Text").html()));
				            			</script>
				            			</c:if>
						            </div>
					            	<input type="hidden" name="retORefSeq" value="${amM701L.retORefSeq}" />
								</td>
								<td>
									<a href="javascript:;" class="btn_type2" onclick="$.del('${amM701L.retORefSeq}');">삭제</a>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</form>
		</div>
	</div>

</body>