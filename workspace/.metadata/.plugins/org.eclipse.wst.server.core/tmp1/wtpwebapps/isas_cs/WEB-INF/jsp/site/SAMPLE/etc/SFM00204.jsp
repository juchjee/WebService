<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript" src="${rootUri}common/js/lightbox.js"></script>

	<script type="text/javascript">
	<!--

		function init(){
			var status = $("#cateStatus").val();
			if(status==""){
				$(".col1").addClass("on");
			}else{
				$(".col"+status).addClass("on");
			}
		}

		function newsCate(code,count){
			$("#page").val(1);
			$("#boardCateSeq").val(code);
			$("#cateStatus").val(count);
			document.newForm.action = "etc.do?pageCd=SFM00204";
			document.newForm.submit();
		}

		function doPage(pageNum){
			document.newForm.page.value = pageNum;
	    	document.newForm.action = "etc.do?pageCd=SFM00204";
	       	document.newForm.submit();
		}

		function hit_update(seq){
			var params = {"boardSeq" : seq};
			var fnHitUpSuccess =  function(data, dataType){
				var data = data.replace(/\s/gi,'');
				var returnData = "";
				if(data == "ng"){
					alert("잠시 후 다시 확인해주세요.");
				}else{
					$("#hit_"+seq+"").text("조회수 "+data);
				}
			};
			fnAjax("hitUpdate.action", params, fnHitUpSuccess, "post", "text", "false");
		}

	//-->
	</script>
</head>
<body>
<div id="container" class="news">

	<div id="contents" class="inner">
		<h3>듀오락 소식</h3>

		<div id="tab_wrap">
			<ul class="tabmenu">
				<li class="col1"><a href="javascript:;" onclick="newsCate('','1');"><span>전체</span></a></li>
				<c:forEach items="${cateList}" var="cateList" varStatus="status">
					<li class="col${status.count+1}">
						<a href="javascript:;" onclick="newsCate('${cateList.boardCateSeq}','${status.count+1}');">
							<c:out value="${cateList.boardCateNm}"/>
						</a>
					</li>
				</c:forEach>
			</ul>

			<div id="tab01">
				<form name="newForm" method="post">
				<input type="hidden" id="page" name="page" />
				<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${boardCateSeq}" />
				<input type="hidden" id="cateStatus" name="cateStatus" value="${cateStatus}" />
				<div class="top_box">
					<span class="title_text02"><em id="review_list_cnt">${pageInfo.totalCount}</em>건의 소식이 있습니다.</span>
					<select name="s_order" onchange="this.form.submit();">
						<option value="bb_date" selected="selected">최신순</option>
						<option value="bb_hit" >조회순</option>
					</select>
				</div>
				</form>

				<ul class="bostyle02">
					<c:forEach items="${duoNewList}" var="duoNewList" varStatus="status">
						<li>
							<c:if test="${duoNewList.imageTpLe eq 'L'}">
								<a href="${duoNewList.boardCont}" data-width="${duoNewList.imageWidth}" data-height="${duoNewList.imageHeight}" class="html5lightbox" data-group="all" title="${duoNewList.boardTitle}" onclick="hit_update('${duoNewList.boardSeq}')">
									<span class="img_box zitem">
										<img src="${duoNewList.attchFilePath}" alt="${duoNewList.boardTitle}">
										<em class="ad"><c:out value="${duoNewList.boardCateNm}"/></em>
									</span>
									<span class="text_box">
										<strong><c:out value="${duoNewList.boardTitle}"/></strong>
										<span>
											<span class="date"><c:out value="${duoNewList.regDt}"/></span>
											<span class="hit" id="hit_${duoNewList.boardSeq}">조회수 <c:out value="${duoNewList.boardHit}"/></span>
										</span>
									</span>
								</a>
							</c:if>
							<c:if test="${duoNewList.imageTpLe eq 'E'}">
								<a href="editBox.action?boardSeq=${duoNewList.boardSeq}" data-width="${duoNewList.imageWidth+20}" data-height="${duoNewList.imageHeight}" class="html5lightbox" data-group="all" title="${duoNewList.boardTitle}" onclick="hit_update('${duoNewList.boardSeq}')" >
									<span class="img_box zitem">
										<img src="${duoNewList.attchFilePath}" alt="${duoNewList.boardTitle}">
										<em class="ad"><c:out value="${duoNewList.boardCateNm}"/></em>
									</span>
									<span class="text_box">
										<strong><c:out value="${duoNewList.boardTitle}"/></strong>
										<span>
											<span class="date"><c:out value="${duoNewList.regDt}"/></span>
											<span class="hit" id="hit_${duoNewList.boardSeq}">조회수 <c:out value="${duoNewList.boardHit}"/></span>
										</span>
									</span>
								</a>
							</c:if>
						</li>
					</c:forEach>
				</ul>
				<a href="#" class="btn"></a>
			</div>
			<c:out value="${pageTag}" escapeXml="false" />
		</div>
	</div>
</div>

</body>