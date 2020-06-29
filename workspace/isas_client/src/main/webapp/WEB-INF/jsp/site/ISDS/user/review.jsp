<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
	<style type="text/css">
		#remainTxt {float:right;font-family:'NanumGothic';color:#666;font-weight:bold;}
	</style>
	<script type="text/javascript">
	<!--
	$(document).ready(function() {
		// 나의 제품 후기 내용 입력란 글자수 제한
		$("#boardText").keyup(function(){
			var inputTxt 	= $(this).val();
			var txtLength 	= inputTxt.length;
			var remainTxt	= txtLength + " / 1000";

			if(txtLength > 1000){
				alert("1000자이상을 입력하셨습니다.\n입력제한수는 1000자 입니다.");
				$(this).val(inputTxt.substring(0,1000));
				return;
			}
			$("#remainTxt").html(remainTxt);
		});
	});

	function init(){

		fnEvent();

	}

	function fnEvent(){

		$(".bisImg").unbind("click");
		$(".bisImg").bind("click",function() {
			fileSearch({fileAttrName:"dtlFilePath",fileViewAttrName:"sumImgName",form:"workForm",filetype:'image'});
		});

		$.dtlAttDel = function(attchCd,idx){
			if(confirm("삭제하시겠습니까?")){
				fnAjax("bbt00001FD.action", {"attchCd" : attchCd}, function(data, dataType){
					$(".nowDtlAtt").eq(idx).html("");
					var data = data.replace(/\s/gi,'');
					alert(data);
				},'POST','text');
			}
		}
	}

	function exDown(code){
		fnFileDownLoad(code);
	}

	function fnReg(){
		$('#regBtn').hide();
		<c:if test="${!isLogIn}">
			alert("로그인 후 이용가능합니다.");
			$('#regBtn').show();
			return false;
		</c:if>
		if($(".jqxRating").val()==0){
			alert("만족도를 선택해주세요");
			$('#regBtn').show();
			$(".jqxRating").focus();
			return false;
		}else{
			$("#prodGrade").val($(".jqxRating").val());
		}
		var tsubject=document.workForm.boardTitle.value;
		if(tsubject=='') {
			alert("상품평 제목을 입력해주세요");
			document.workForm.boardTitle.focus();
			$('#regBtn').show();
			return false;
		}
		var tvalue=document.workForm.boardText.value;
		if(tvalue=='') {
			alert("상품평 내용을 입력해주세요");
			document.workForm.boardText.focus();
			$('#regBtn').show();
			return false;
		}
		$("#boardCont").val($('#boardText').val().replace(/\n/g, "<br>"));
		workForm.submit();
	}

	//-->
	</script>
</head>
<body>

<!--=============== #CONTAINER ===============-->
<div id="container" class="user">
  	<!--=============== #CONNTENTS ===============-->
	<div id="contents" class="inner">
		<h3><img src="/common/images/tit/h3_tit7_6.png" alt="나의 제품후기"></h3>

		<ul class="mypage_menu">
					<li class="col1 "><a href="/ISDS/user/mypage.do" ><span>아이콘</span>마이페이지</a></li>
					<li class="col2 "><a href="/ISDS/user/order.do" ><span>아이콘</span>주문/배송 조회</a></li>
					<li class="col3"><a href="/ISDS/user/wishList.do" ><span>아이콘</span>위시리스트</a></li>
					<li class="col4  "><a href="/ISDS/user/cash.do" ><span>아이콘</span>멤버십 혜택/포인트/쿠폰</a></li>
					<li class="col5 "><a href="/ISDS/user/product.do" ><span>아이콘</span>나의 문의내역</a></li>
					<li class="col6 on"><a href="/ISDS/user/review.do" ><span>아이콘</span>나의 제품후기</a></li>
					<li class="col7"><a href="/ISDS/user/setting.do" ><span>아이콘</span>회원정보</a></li>
					<li class="col8"><a href="/ISDS/order/cart.do" ><span>아이콘</span>장바구니</a></li>
		</ul>


		<div class="review">
			<ul class="tabmenu">
				<li class="on"><a href="review.do">나의 제품후기 쓰기</a></li>
				<li><a href="review_set.do">나의 제품후기 관리</a></li>
			</ul>

			<div class="top_info">
				<ul>
					<li>후기 작성시 <span>포인트(텍스트 200점, 포토 500점)</span>가 적립됩니다.</li>
					<li>취소/반품/교환의 경우 작성하신 후기 및 적립금은 자동삭제 됩니다.</li>
					<li>제품후기는 배송완료 후 익일 작성하실 수 있습니다.</li>
				</ul>
			</div>

			<div class="review_list">
				<span class="title_text02"><em id="review_list_cnt">${totalCnt}</em>건의 미등록 제품후기가 있습니다.</span>
					<ul>
						<c:forEach items="${payProdList}" var="payProdList" varStatus="status">
							<li>
								<div>
									<a class="img_box" href="/ISDS/store/store_view.do?orderNo=${payProdList.orderNo}&prodCd=${payProdList.prodCd}">
										<img src="${payProdList.basicImg}" alt="${payProdList.prodNm}" width="140" height="140">
									</a>
									<a href="#">
										<span class="title"><c:out value="${payProdList.prodNm}"/></span>
										<!-- 구매일 추후 추가 -->
										<span class="date">구매일 <em><c:out value="${payProdList.orderDt}"/></em></span>
									</a>
									<span class="btn_box">
										<a href="#" onclick="javascript:data_set('${payProdList.prodCd}','','${payProdList.basicImg}','${payProdList.prodNm}','${payProdList.secProdNm}','${payProdList.orderNo}');layer_open('layer');return false;" class="btn09">제품후기 작성</a>
									</span>
									<em>${payProdList.pptCd}</em>
								</div>
							</li>
						</c:forEach>
						<c:if test="${empty payProdList}">
							<div id="result_msg" class="nocomment">등록 가능한 후기가 없습니다.</div>
						</c:if>
					</ul>
			</div>

			<script>
				function data_set(v1,v2,v3,v4,v5,v6){
					$("#prodCd").val(v1);
					$("#review_write_title").html("<em>"+v5+"</em>"+v4);
					$("#review_write_img").attr("src",v3);
					$(".jqxRating").jqxRating({});
					$("#orderNo").val(v6);
				}
			</script>

			<!--=============== #layer ===============-->
			<div class="layer cont">
				<div class="bg"></div>
				<div id="layer" class="pop-layer">
					<div class="pop-container">
						<div class="pop-cont">
							<div class="title">
								<strong>나의 제품후기쓰기</strong>
								<a href="#" class="cbtn">Close</a>
							</div>
							<div class="pcont">
								<ul class="top_info">
									<li>후기 작성시 <span>포인트(텍스트 200점, 포토 500점)</span>가 적립됩니다.</li>
									<li>구매한 후 6개월이 지난 제품의 후기는 작성하실 수 없습니다.</li>
									<li>취소/반품/교환의 경우 작성하신 후기 및 적립금은 자동삭제 됩니다.</li>
								</ul>

								<form name="workForm" id="workForm" action="reviewSave.action" method="post" enctype="multipart/form-data">
								<input type="hidden" name="prodCd" id="prodCd" />
								<input type="hidden" name="prodGrade" id="prodGrade" />
								<input type="hidden" name="orderNo" id="orderNo" />
								<textarea name="boardCont" id="boardCont" style="display:none;"></textarea>
								<table cellpadding="0" cellspacing="0" class="tsytle">
									<colgroup>
										<col width="20%">
										<col width="80%">
									</colgroup>
									<tbody>
										<tr>
											<th>제품 정보</th>
											<td class="product_info">
												<img src="" id="review_write_img" />
												<span class="" id="review_write_title"></span>
											</td>
										</tr>

										<c:choose>
							  				<c:when test="${fn:length(cateList) > 1}">
												<tr>
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
											<th>제품 만족도</th>
											<td>
												<div class="jqxRating"></div>
											</td>
										</tr>
										<tr>
											<th>제목</th>
											<td><input type="text" name="boardTitle" id="boardTitle" maxlength="70" ></td>
										</tr>
										<tr>
											<th>후기내용</th>
											<td>
												<textarea name="boardText" id="boardText" placeholder="*텍스트후기 200점/ 포토후기 500점 포인트 지급"></textarea>
												<span id="remainTxt">0 / 1000</span>
											</td>
										</tr>
										<tr>
											<th>사진첨부</th>
											<td>
												<c:forEach items="${fileList}" var="fileList" varStatus="status">
						          					<div class="nowDtlAtt">
														<a href="javascript:;" onclick="exDown('${fileList.attchCd}');">
															<c:out value="${fileList.attchFileNm}" />
														</a>
						                				<a href="javascript:;">
						                				<img src="${rootUri}images/btn_keyword_del.png" alt="삭제" onclick="$.dtlAttDel('${fileList.attchCd}','${status.index}');">
						                				</a>
													</div>
						          				</c:forEach>
												<input type="text" name="sumImgName" id="sumImgName" style="width:200px" readonly="readonly" />
												<a href="javascript:;" class="bisImg btn10">찾아보기</a>
											</td>
										</tr>
									</tbody>
								</table>

								<div style="text-align: center">
									<img id="regBtn" src="${rootUri}common/img/icon/write_btn.png" alt="등록하기" style="cursor:pointer;" onclick="fnReg();"  />
								</div>
								</form>

							</div>
						</div>
					</div>
				</div>
			</div>
			<!--=============== #layer ===============-->

		</div>
	</div>
	<!--=============== #CONNTENTS ===============-->
</div>
<!--=============== #CONTAINER ===============-->
</body>