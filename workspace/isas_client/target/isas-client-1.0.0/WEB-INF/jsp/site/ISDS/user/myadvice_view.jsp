<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
	<!--
	function init(){

		fnEvent();
	}

	function fnEvent(){
		$.submit = function(){

			if(confirm('삭제하겠습니까?')){
				$("#workForm").submit();
			}else{
				return;
			}
		}
	}
	//-->
	</script>
</head>
<body>

<!--=============== #CONTAINER ===============-->
<div id="container" class="user">
  	<!--=============== #CONNTENTS ===============-->
	<div id="contents" class="inner">
		<h3><img src="/common/images/tit/h3_tit7_5.png" alt="나의 문의내역"></h3>

		<ul class="mypage_menu">
					<li class="col1 "><a href="/ISDS/user/mypage.do" ><span>아이콘</span>마이페이지</a></li>
					<li class="col2 "><a href="/ISDS/user/order.do" ><span>아이콘</span>주문/배송 조회</a></li>
					<li class="col3"><a href="/ISDS/user/wishList.do" ><span>아이콘</span>위시리스트</a></li>
					<li class="col4 "><a href="/ISDS/user/cash.do" ><span>아이콘</span>멤버십 혜택/포인트/쿠폰</a></li>
					<li class="col5 on"><a href="/ISDS/user/product.do" ><span>아이콘</span>나의 문의내역</a></li>
					<li class="col6"><a href="/ISDS/user/review.do" ><span>아이콘</span>나의 제품후기</a></li>
					<li class="col7"><a href="/ISDS/user/setting.do" ><span>아이콘</span>회원정보</a></li>
					<li class="col8"><a href="/ISDS/order/cart.do" ><span>아이콘</span>장바구니</a></li>
		</ul>

		<div class="question bostyle01">
			<ul class="tabmenu">
				<li><a href="product.do">제품문의</a></li>
				<li class="on"><a href="myadvice.do">나의 상담/문의 내역</a></li>
			</ul>

			<div class="top_info">
				<ul>
					<li>남겨주신 고객상담을 편리하게 보실 수 있습니다.</li>
					<li>상담신청은 <span>24시간 신청가능</span>하며 접수내용은 듀오락 상담원이 직접 답변해드립니다.</li>
					<li>고객상담 답변가능시간 : 평일 9:00 ~ 18:00 /  토요일 9:00 ~ 18:00 (일/공휴일 제외)</li>
				</ul>
			</div>

			<form id="workForm" name="workForm" action="myadviceDel.action" method="post" >
			<input type="hidden" name="boardSeq" id="boardSeq" value="${bbt2View.boardSeq}" />
			<table class="tsytle tbl_res4" cellpadding="0" cellspacing="0">
				<colgroup>
					<col width="250">
					<col width="750">
				</colgroup>
				<tbody>
					<tr>
						<th>제목</th>
						<td><c:out value="${bbt2View.boardTitle}"/></td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>
							<c:out value="${bbt2View.regId}"/>
						</td>
					</tr>
					<tr>
						<th>분류</th>
						<td>
							<c:out value="${bbt2View.boardCateNm}" />
						</td>
					</tr>
					<tr>
						<th>공개여부</th>
						<td>
							<input disabled="disabled" type="radio" name="openYn" id="openY" value="N" <c:if test="${bbt2View.openYn eq 'N'}">checked</c:if> />비공개
							<input disabled="disabled" type="radio" name="openYn" id="openN" value="Y" <c:if test="${bbt2View.openYn eq 'Y'}">checked</c:if> />공개
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td class="writing">
							<div>
								<div id="boardCont"></div>
						           <textarea name="boardCont_text" id="boardCont_text" style="display:none;" ><c:if test="${not empty bbt2View.boardCont}">${bbt2View.boardCont}</c:if></textarea>
									<script type="text/javascript">
											$("#boardCont").html(decodeTag($("#boardCont_text").html()));
						            </script>
							</div>
						</td>
					</tr>
					<c:if test="${!empty bbt2View.boardReply}" >
					<tr>
						<th>답글</th>
						<td class="writing">
							<div>
								<div id="boardReply"></div>
						           <textarea name="boardReply_text" id="boardReply_text" style="display:none;" ><c:if test="${not empty bbt2View.boardReply}">${bbt2View.boardReply}</c:if></textarea>
									<script type="text/javascript">
											$("#boardReply").html(decodeTag($("#boardReply_text").html()));
						            </script>
							</div>
						</td>
					</tr>
					</c:if>
				</tbody>
			</table>
			</form>
			<br/>
			<div class="btn_wrap" style="width:400px;">
				<c:if test="${bbt2View.regId eq mbrId}">
					<a href="javascript:;" onclick="$.submit();" class="col1 btn01"><span>삭제</span></a>
				</c:if>
				<a class="btn01_1" href="myadvice.do">취소</a>
			</div>
		</div>
	</div>
	<!--=============== #CONNTENTS ===============-->
</div>
<!--=============== #CONTAINER ===============-->


</body>