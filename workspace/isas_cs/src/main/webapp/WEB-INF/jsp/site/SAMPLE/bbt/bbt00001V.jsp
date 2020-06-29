<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--

		function init(){

		}

		//태그 문자열을 디코딩 한다
		function decodeTag(str){
			return str && str.replace(/&quot;/g,"\"").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&nbsp;/g," ").replace(/&amp;/g,"&");
		}

		function prevGo(){
			document.preForm.action = "bbt00001V.do?pageCd=${boardMstCd}";
		   	document.preForm.submit();
		}

		function nextGo(){
			document.nextForm.action = "bbt00001V.do?pageCd=${boardMstCd}";
		   	document.nextForm.submit();
		}

	//-->
	</script>
</head>
<body>
	<div id="container" class="notice">
		<div id="contents" class="inner">
			<h3><img src="/common/images/tit/h3_tit5_1.png" alt="공지사항"></h3>
			<div class="bo_view01 tbl_res5">
				<table>
					<colgroup>
						<col width="750">
						<col width="150">
						<col width="100">
					</colgroup>
					<thead>
						<tr>
							<th><span>[&nbsp;<c:choose><c:when test="${not empty noticeView.boardCateNm}">${noticeView.boardCateNm}</c:when><c:otherwise>전체공지</c:otherwise></c:choose>&nbsp;]</span><c:out value="${noticeView.boardTitle}"/></th>
							<th>등록일<em><c:out value="${noticeView.regDt}"/></em></th>
							<th>조회수<em><c:out value="${noticeView.boardHit}"/></em></th>
						</tr>
					</thead>

					<tbody>
						<tr>
							<td colspan="3" class="view_table">
								<div id="boardCont"></div>
			            		  <textarea name="boardCont_Text" id="boardCont_Text" style="display:none;" ><c:if test="${not empty noticeView.boardCont}">${noticeView.boardCont}</c:if></textarea>
								<script type="text/javascript">
		            				$("#boardCont").html(decodeTag($("#boardCont_Text").html()));
			            		</script>
							</td>
						</tr>
						<c:if test="${not empty fileList}">
						<tr>
							<td colspan="3" style="z-index: 0;">
								<div style="float:left;margin:5px 0 5px 5px;"><strong>첨부파일</strong></div>
								<div style="float:left;">
								<c:forEach items="${fileList}" var="fileList" varStatus="status">
							         <div class="nowDtlAtt" style="margin-left:20px; line-height:20px;">
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
						<tr>
							<td class="prev" colspan="3" style="z-index: 0">
								<span>이전글</span>
								<c:if test="${!empty preView}">
									<a href="javascript:;" onclick="prevGo();">
										<c:out value="${preView.boardTitle}" />
									</a>
									<form id="preForm" name="preForm" method="post">
										<input type="hidden" name="boardSeq" value="${preView.boardSeq}"/>
										<input type="hidden" name="boardMstCd" value="${preView.boardMstCd}"/>
										<input type="hidden" name="boardCateSeq" value="${preView.boardCateSeq}"/>
										<input type="hidden" name="page" value="${param.page}"/>
									</form>
								</c:if>
								<c:if test="${empty preView}">
									이전글이 없습니다.
								</c:if>
							</td>
						</tr>

						<tr>
							<td class="next" colspan="3" style="z-index: 0">
								<span>다음글</span>
								<c:if test="${!empty nextView}">
									<a href="javascript:;" onclick="nextGo();">
										<c:out value="${nextView.boardTitle}" />
									</a>
									<form id="nextForm" name="nextForm" method="post">
										<input type="hidden" name="boardSeq" value="${nextView.boardSeq}"/>
										<input type="hidden" name="boardMstCd" value="${nextView.boardMstCd}"/>
										<input type="hidden" name="boardCateSeq" value="${nextView.boardCateSeq}"/>
										<input type="hidden" name="page" value="${param.page}"/>
									</form>
								</c:if>
								<c:if test="${empty nextView}">
									다음글이 없습니다.
								</c:if>
							</td>
						</tr>

					</tbody>
				</table>
				<a href="bbt00001.do?pageCd=BBM00001&page=${param.page}" class="btn01">목록으로</a>
			</div>
		</div>
	</div>


</body>