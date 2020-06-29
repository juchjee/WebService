<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
	<script type="text/javascript" src="/SE/js/HuskyEZCreator.js"></script>
	<script type="text/javascript">
	<!--

		var oEditors = [];

		function init(){

			fnEvent();
			if('${bbt2View.boardSeq}' == ''){
				$('.btn_wrap').css('width', '400px');
				$('#regBtn').prop('class', 'btn01');
				$('#delBtn').hide();
			}
		}

		function fnEvent(){
			$.submit = function(){
				if('${bbt2View.boardSeq}' == ''){
					$('#regBtn').prop('class', 'btn01');
					$('#regBtn').hide();
				}

				if($("#boardTitle").val()==""){
					alert("제목은(는) 필수 항목입니다.");
					$("#boardTitle").focus();
					$('#regBtn').show();
					return false;
				}

				if($("#boardCont").val()==""){
					alert("내용은(는) 필수 항목입니다.");
					$("#boardCont").focus();
					$('#regBtn').show();
					return false;
				}

				$("#workForm").submit();
			}
			$.delSubmit = function(){
				if(confirm('삭제하겠습니까?')){
					$('#workForm').attr('action', 'myadviceDel.action');
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

			<form id="workForm" name="workForm" action="myadviceSave.action" method="post" >
			<input type="hidden" name="boardMstCd" id="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" name="boardSeq" id="boardSeq" value="${bbt2View.boardSeq}" />
			<table class="tsytle tbl_res4" cellpadding="0" cellspacing="0">
				<colgroup>
					<col width="250">
					<col width="750">
				</colgroup>
				<tbody>
					<tr>
						<th>제목</th>
						<td><input type="text" style="width:100%;" name="boardTitle" id="boardTitle" class="validation[required]" title="제목" value="${bbt2View.boardTitle}" /></td>
					</tr>
					<tr>
						<th>아이디</th>
						<td>
							<c:out value="${mbrId}"/>
							<input type="hidden" name="regId" id="regId" value="${mbrId}" />
						</td>
					</tr>
					<c:choose>
						<c:when test="${fn:length(cateList) > 1}">
							<tr>
								<th>분류</th>
								<td>
									<p class="mem_dc">
										<select id="boardCateSeq" name="boardCateSeq">
											<c:if test="${empty bbt2View}">
												<c:forEach items="${cateList}" var="cateList">
													<option value="${cateList.boardCateSeq}" >${cateList.boardCateNm}</option>
												</c:forEach>
											</c:if>
											<c:if test="${!empty bbt2View}">
												<c:forEach items="${cateList}" var="cateList">
													<option value="${cateList.boardCateSeq}" <c:if test="${cateList.boardCateSeq eq bbt2View.boardCateSeq}">selected</c:if> >${cateList.boardCateNm}</option>
												</c:forEach>
											</c:if>
										</select>
									</p>
								</td>
							</tr>
						</c:when>
						<c:otherwise>
							<tr style="display:none;">
								<th>분류</th>
								<td>
									<p class="mem_dc">
										<select id="boardCateSeq" name="boardCateSeq">
											<c:forEach items="${cateList}" var="cateList">
												<option value="${cateList.boardCateSeq}" >${cateList.boardCateNm}</option>
											</c:forEach>
										</select>
									</p>
								</td>
							</tr>
						</c:otherwise>
					</c:choose>
					<tr>
						<th>공개여부</th>
						<td>
							<c:if test="${empty bbt2View}">
								<input type="radio" name="openYn" id="openY" value="N" checked />비공개
								<input type="radio" name="openYn" id="openN" value="Y" />공개
							</c:if>
							<c:if test="${!empty bbt2View}">
								<input type="radio" name="openYn" id="openY" value="N" <c:if test="${bbt2View.openYn eq 'N'}">checked</c:if> />비공개
								<input type="radio" name="openYn" id="openN" value="Y" <c:if test="${bbt2View.openYn eq 'Y'}">checked</c:if> />공개
							</c:if>
						</td>
					</tr>
					<tr>
						<th>내용</th>
						<td class="writing">
							<div>
								<textarea name="boardCont" id="boardCont" style="width:100%; height:351px;padding:5px;margin:5px;text-indent:0px;">${bbt2View.boardCont}</textarea>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
			</form>
			<br/>
			<div class="btn_wrap" style="width:600px;">
				<a href="javascript:;" id="regBtn" onclick="$.submit();" class="col1 btn01_1"><span>등록하기</span></a>
				<a href="javascript:;" id="delBtn" onclick="$.delSubmit();" class="col1 btn01"><span>삭제</span></a>
				<a class="btn01_1" href="myadvice.do">취소</a>
			</div>
		</div>
	</div>
	<!--=============== #CONNTENTS ===============-->
</div>
<!--=============== #CONTAINER ===============-->


</body>