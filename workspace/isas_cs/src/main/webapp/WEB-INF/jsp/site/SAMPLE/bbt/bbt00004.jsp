<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--

		function init(){
			var seq = $("#boardCateSeq").val();
			if(seq==""){
				$("#col1").addClass("on");
			}
			else{
				$("#col"+seq).addClass("on");
			}
		}

		function noticeCate(code){
			$("#page").val(1);
			$("#boardCateSeq").val(code);
			document.faqForm.action = "bbt00004.do?pageCd=${boardMstCd}";
			document.faqForm.submit();
		}

		function noticeView(seq){
			$("#boardSeq").val(seq);
			document.faqForm.action = "bbt00004V.do?pageCd=${boardMstCd}";
		   	document.faqForm.submit();
		}

		function doPage(pageNum){
			document.faqForm.page.value = pageNum;
	    	document.faqForm.action = "bbt00004.do?pageCd=${boardMstCd}";
	       	document.faqForm.submit();
		}

		//태그 문자열을 디코딩 한다
		function decodeTag(str){
			return str && str.replace(/&quot;/g,"\"").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&nbsp;/g," ").replace(/&amp;/g,"&");
		}

	//-->
	</script>
</head>
<body>

<div id="container" class="faq">

	<div id="contents" class="inner">
		<h3><img src="/common/images/tit/h3_tit5_4.png" alt="FAQ"></h3>
		<form id="faqForm" name="faqForm" method="post">
		<input type="hidden" id="boardSeq" name="boardSeq" />
		<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
		<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${boardCateSeq}" />
		<input type="hidden" id="page" name="page" />
		<div class="bostyle01">
			<ul class="title">
				<li id="col1"><a class="col1" href="javascript:;" onclick="noticeCate('');"><span>전체</span><em>(${allCnt})</em></a></li>
				<c:forEach items="${cateList}" var="cateList" varStatus="status">
					<li id="col${cateList.boardCateSeq}">
						<a class="col${status.count+1}" href="javascript:;" onclick="noticeCate('${cateList.boardCateSeq}');">
							<span><c:out value="${cateList.boardCateNm}"/></span><em>(${cateList.boardCnt})</em>
						</a>
					</li>
				</c:forEach>
			</ul>
			<div class="table_wrap tbl_res1">
			<table cellpadding="0" cellspacing="0">
				<colgroup>
					<col width="80">
					<col width="130">
					<col width="790">
				</colgroup>

						<thead>
							<tr>
								<th>번호</th>
								<th>분류</th>
								<th>제목</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${faqList}" var="faqList" varStatus="status">
								<tr class="item">
									<td><c:out value="${faqList.boardSeq}"/></td>
									<td><c:out value="${faqList.boardCateNm}"/></td>
									<td><span><c:out value="${faqList.boardTitle}"/></span></td>
								</tr>
								<tr class="hide">
									<td colspan="3">
										<span id="boardCont${status.count}">
											<textarea name="boardCont${status.count}_text" id="boardCont${status.count}_text" style="display:none;" ><c:if test="${not empty faqList.boardCont}">${faqList.boardCont}</c:if></textarea>
											<script type="text/javascript">
												$("#boardCont${status.count}").html(decodeTag($("#boardCont${status.count}_text").html()));
											</script>
										</span>
									</td>
								</tr>
							</c:forEach>
							<c:if test="${empty faqList}">
								<tr>
					                <td colspan="3">내용이 없습니다.</td>
					            </tr>
				            </c:if>
						</tbody>
					</table>

					<p class="search_bar">
						<select title="FAQ검색" name="skey">
							<option value="1" >제목</option>
							<option value="2" >내용</option>
							<option value="3" >제목+내용</option>
						</select>
						<input type="text" maxlength="50" name="sval" />
						<input type="image" src="${rootUri}common/img/icon/btn_search.png" class="faqInputBtn" alt="FAQ검색"/>
					</p>

					<c:out value="${pageTag}" escapeXml="false" />

				</div>
			</div>
			</form>
		</div>

</div>

</body>