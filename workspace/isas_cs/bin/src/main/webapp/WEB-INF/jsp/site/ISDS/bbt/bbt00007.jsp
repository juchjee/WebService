<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
    <script type="text/javascript" src="http://localhost:8080/common/js/jqwidgets/jqxgrid.js"></script>
	<script type="text/javascript">
		function init(){
			fnEvent();
			
			$("#fancyboxImg").fancybox({
				beforeShow: function(){
					this.width = 550;
			        this.height = 350;
			    }
			});
		}

		function fnEvent(){
			doPage = function(pageNum){
				document.viewform.page.value = pageNum;
		    	document.viewform.action = "bbt00007.do?pageCd=${boardMstCd}";
		       	document.viewform.submit();
			}
		}

		function fnFancyboxImg(src){
			$("#fancyboxImg").attr("href",src);
			$("#fancyboxImg").click();
			return false;
		}		

	</script>
</head>
<body>
	<div class="sub">
	
	<form id="viewform" name="viewform" method="post">
		<input type="hidden" id="boardSeq" name="boardSeq" />
		<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
		<input type="hidden" id="page" name="page" value="${page}"/>
		
		<div class="box_guide">
			<c:choose>
				<c:when test="${boardMstCd eq 'BBM00056'}">
					<h2 class="tit">비데</h2>
				</c:when>
				<c:when test="${boardMstCd eq 'BBM00068'}">
					<h2 class="tit">위생도기</h2>
				</c:when>
				<c:when test="${boardMstCd eq 'BBM00069'}">
					<h2 class="tit">수전</h2>
				</c:when>
				<c:when test="${boardMstCd eq 'BBM00071'}">
					<h2 class="tit">이누스바스</h2>
				</c:when>
				<c:otherwise>
					<h2 class="tit"></h2>
				</c:otherwise>
			</c:choose>
			<p class="desc">부품을 확인하세요.</p>
			<div class="page_location">
				<ul>
					<li><a href="javascript:;"><span class="home"><span class="hidden">home</span></span></a></li>				<li><a href="javascript:;">부품구매</a></li>
					<c:choose>
						<c:when test="${boardMstCd eq 'BBM00056'}">
							<li class="last"><a href="javascript:;">비데</a></li>
						</c:when>
						<c:when test="${boardMstCd eq 'BBM00068'}">
							<li class="last"><a href="javascript:;">위생도기</a></li>
						</c:when>
						<c:when test="${boardMstCd eq 'BBM00069'}">
							<li class="last"><a href="javascript:;">수전</a></li>
						</c:when>
						<c:when test="${boardMstCd eq 'BBM00071'}">
							<li class="last"><a href="javascript:;">이누스바스</a></li>
						</c:when>
						<c:otherwise>
							<li class="last"><a href="javascript:;"></a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
		<div class="board type2">
			<table cellspacing="0">
				<caption>부품구매</caption>
				<colgroup>
					<col style="width:20%"><col style="width:50%"><col style="width:15"><col style="width:15">
				</colgroup>
				<thead>
					<tr>
						<th colspan="2">부품명</th>
						<th>가격</th>
						<th>구매처</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${prodList}" var="prod" varStatus="loop">
						<tr>
							<td><img src="${prod.attchFilePath}" alt="" onclick="fnFancyboxImg('${prod.attchFilePath}');"/></td>
							<td class="subject">
								<strong class="st">[${prod.boardTitle}]</strong>
								<a href="#" class="tit boardCont" id="boardCont" style="cursor:text"></a>
			            		<textarea class="boardCont_Text" name="boardCont_Text" id="boardCont_Text" style="display:none;" >
									<c:if test="${not empty prod.boardCont}">${prod.boardCont}</c:if>
								</textarea>
								<script type="text/javascript">
					            	$(".boardCont").eq(${loop.index}).html(decodeTag($(".boardCont_Text").eq(${loop.index}).html()));
						        </script>
		            		</td>
							<td class="price"><strong><span class="validation[number]">${prod.prodPrice}</span></strong>원</td>
							<td class="tel"><strong>${prod.prodTel}</strong>${prod.prodPurch}</td>
						</tr>
					</c:forEach>
					<c:if test="${empty prodList}">
						<tr>
							<td colspan="5">내용이 없습니다.</td>
						</tr>
		            </c:if>
				</tbody>
			</table>
		</div>
		<!-- #box_tabs -->
		<c:out value="${pageTag}" escapeXml="false" />
	
	</form>
	
	<a id="fancyboxImg" href="javascript:;"></a>
	</div>

</body>