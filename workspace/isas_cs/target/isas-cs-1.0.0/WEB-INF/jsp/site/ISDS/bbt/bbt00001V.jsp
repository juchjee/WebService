<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--

		function init(){
			fnEvent();
		}

		function fnEvent(){
			$("#listBtn").bind("click",function(){
				var param = "";
				if("${param.page}" != ""){
					 param = "&page=${param.page}";
				}
				location.href="bbt00001.do?pageCd=${param.pageCd}"+param;
			});

		}



	//-->
	</script>
</head>
<body>


	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">공지사항</h2>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">고객의 소리</a></li>
					<li class="last"><a href="#">공지사항</a></li>
				</ul>
			</div>
		</div>
		<div class="board_view">
			<table>
				<caption>공지사항 상세</caption>
				<thead>
				<tr>
					<th><c:out value="${noticeView.boardTitle}"/></th>
				</tr>
				<tr>
					<td>
						<p><strong class="txt3">등록일</strong> <span><c:out value="${noticeView.regDt}"/></span></p>
						<p class="right"><strong class="txt3">조회수</strong><span><c:out value="${noticeView.boardHit}"/></span></p>
					</td>
				</tr>
				<c:if test="${not empty fileList}">
						<tr>
							<td  style="z-index: 0;">
								<div style="float:left;"><strong class="txt3">첨부파일</strong></div>
								<div style="float:left;">
									<c:forEach items="${fileList}" var="fileList" varStatus="status">
							         <div class="nowDtlAtt" style="margin-left:5px;<c:if test="${!status.frist}">margin-top:8px;</c:if>">
										<a href="javascript:;"  onclick="fnFileDownLoad('${fileList.attchCd}');">
											<c:out value="${fileList.attchFileNm}" />
										</a>
									</div>
							   		 </c:forEach>
								</div>
							    <div style="clear: both;"></div>
							</td>
						</tr>
				</c:if>
				</thead>
				<tbody>
				<tr>
					<td class="cont">
						<p id="boardCont" class="txt">
							<textarea name="boardCont_Text" id="boardCont_Text" style="display:none;" ><c:if test="${not empty noticeView.boardCont}">${noticeView.boardCont}</c:if></textarea>
							<script type="text/javascript">
				            	$("#boardCont").html(decodeTag($("#boardCont_Text").html()));
					        </script>
						</p>
					</td>
				</tr>

				</tbody>
			</table>
		</div>
		<div class="btnArea"><button class="left" id="listBtn">목록</button></div>
	</div>

</body>