<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
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


		bbtList = function(){
			location.href="/ISDS/bbt/bbt00007.do?pageCd="+$("#boardMstCd").val();
		}

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

	<section class="sub">

	<form id="viewform" name="viewform" method="post">
		<input type="hidden" id="boardSeq" name="boardSeq" />
		<input type="hidden" id="page" name="page" value="${page}"/>

		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>부품구매</h2>
		</div>
		<!--// tit_bx -->
		<div class="content">
			<div class="select_guide w100">
				<select class="m_select select01" name="boardMstCd" id="boardMstCd" onchange="bbtList()">
					<option value="BBM00056" <c:if test="${boardMstCd eq 'BBM00056'}">selected</c:if>>비데</option>
					<option value="BBM00068" <c:if test="${boardMstCd eq 'BBM00068'}">selected</c:if>>위생도기</option>
					<option value="BBM00069" <c:if test="${boardMstCd eq 'BBM00069'}">selected</c:if>>수전</option>
					<option value="BBM00071" <c:if test="${boardMstCd eq 'BBM00071'}">selected</c:if>>이누스바스</option>
				</select>
			</div>


			<c:forEach items="${prodList}" var="prod" varStatus="loop">
				<div class="partView">
					<dl>
						<dt><c:out value="${prod.boardTitle}" escapeXml="false"></c:out></dt>
						<dd>
							<p class="boardCont"></p>
							<textarea class="boardCont_Text" name="boardCont_Text" id="boardCont_Text" style="display:none;" >
								<c:if test="${not empty prod.boardCont}">${prod.boardCont}</c:if>
							</textarea>
							<script type="text/javascript">
				            	$(".boardCont").eq(${loop.index}).html(decodeTag($(".boardCont_Text").eq(${loop.index}).html()));
					        </script>
							<div class="imgBox">
								<!-- 추후 삭제될 것 -->
								<p><img src="${prod.attchFilePath}" alt="" onclick="fnFancyboxImg('${prod.attchFilePath}');"></p>
								<!-- 추후 삭제될 것 -->
							</div>
						</dd>
					</dl>
					<dl class="type02">
						<dt>판매처</dt>
						<dd>${prod.prodPurch}&nbsp;${prod.prodTel}</dd>
						<dt>가격</dt>
						<dd><fmt:formatNumber value="${prod.prodPrice}" pattern="###,###.##"/>원</dd>
					</dl>
					<a href="tel:${prod.prodTel}" class="btn blueBg">전화걸기</a>
				</div>
			</c:forEach>
			<c:if test="${empty prodList}">
				<div class="board no_data mt10">
					<p>내용이 없습니다.</p>
				</div>
            </c:if>
		</div>

	</form>
	
	<a id="fancyboxImg" href="javascript:;"></a>

	</section>
	<!--// sub -->

</body>