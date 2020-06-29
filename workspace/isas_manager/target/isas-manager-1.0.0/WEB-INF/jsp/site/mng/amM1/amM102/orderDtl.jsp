<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />
	<script type="text/javascript">
	$(document).ready(function() {
		$('#printDetail').on("click", function(){
			win = window.open("/mng/amM3/amM3/orderDtlPrint.action?orderNo=${orderInfo.orderNo}&claimTpCd=${claimTpCd}", "orderDtl", "width=800px, height=900px, scrollbars=yes");
			self.focus();
			win.print();
			setTimeout(function(){
				win.close();
			},2000);

		}); // on
	});

	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){
		fnEvent();
	}

	/*----------------------------------------------------------------------------------------------
	 * 이벤트 Setting
	 *----------------------------------------------------------------------------------------------*/
	 function fnEvent(){
		$.orderCancel = function(){
			    var paramData = new Object();
				var postData = new Array();
				paramData["orderNo"] =  "${orderInfo.orderNo}";
				paramData["orderStatusCd"] =   "${orderInfo.orderStatusCd}";
				paramData["orderCashCd"] =   "${orderInfo.orderCashCd}";

				postData.push(paramData);
			var postDataJson = JSON.stringify(postData);
			if(confirm("해당 주문건을 취소 하시겠습니까?")){
				fnAjax("orderCancelProc.action",{data : postDataJson}, function(data, dataType){
					var data = data.replace(/\s/gi,'');
					alert(data);
					parent.$('#jqxgrid').jqxGrid('clearselection');
					parent.fnSearch();
					location.reload();
				},'POST','text');
			}
		}

		$("#regiNo").bind("click",function(){
			if(confirm("해당 운송장번호를 수동으로 등록 하시겠습니까?")){
				fnAjax("regiNoManual.action", {orderNo : "${orderInfo.orderNo}",regiNo: $("#regiNoText").val()},function(data, dataType){
					var data = data.replace(/\s/gi,'');
					alert(data);
					parent.$('#jqxgrid').jqxGrid('clearselection');
					parent.fnSearch();
					location.reload();
				},'POST','text');
			}
		});

		$("#orderPackingDt").bind("click",function(){
			if(confirm("해당 수동으로 패킹완료 처리 하시겠습니까?")){
				fnAjax("orderPackingDtManual.action", {orderNo : "${orderInfo.orderNo}"},function(data, dataType){
					var data = data.replace(/\s/gi,'');
					alert(data);
					parent.$('#jqxgrid').jqxGrid('clearselection');
					parent.fnSearch();
					location.reload();
				},'POST','text');
			}
		});

		$("#receiptOperNote").bind("click",function(){
			if(confirm("해당 운영자메모를 저장 하시겠습니까?")){
				fnAjax("receiptOperNoteSave.action", {orderNo : "${orderInfo.orderNo}",receiptOperNote: $("#receiptOperNoteText").val()},function(data, dataType){
					var data = data.replace(/\s/gi,'');
					alert(data);
					parent.$('#jqxgrid').jqxGrid('clearselection');
					parent.fnSearch();
					location.reload();
				},'POST','text');
			}
		});

		$("#receiptDeliveryNote").bind("click",function(){
			if(confirm("배송시 요청사항 메모를 저장 하시겠습니까?")){
				fnAjax("receiptDeliveryNoteSave.action", {orderNo : "${orderInfo.orderNo}",receiptDeliveryNoteText: $("#receiptDeliveryNoteText").val()},function(data, dataType){
					var data = data.replace(/\s/gi,'');
					parent.$('#jqxgrid').jqxGrid('clearselection');
					parent.fnSearch();
					location.reload();
				},'POST','text');
			}
		});

		$("#addrSave").bind("click",function(){
			if(confirm("배송지를 수정 하시겠습니까?")){
				fnAjax("/mng/amM3/amM3/addrSave.action", {receiptZipcode : $('input[name=receiptZipcode]').val()
					,receiptAddr: $('input[name=receiptAddr]').val()
					,receiptAddrDtl: $('input[name=receiptAddrDtl]').val()
					,receiptNm: $('input[name=receiptNm]').val()
					,receiptMobile1: $('input[name=receiptMobile1]').val()
					,receiptMobile2: $('input[name=receiptMobile2]').val()
					,receiptMobile3: $('input[name=receiptMobile3]').val()
					,receiptTel1: $('input[name=receiptTel1]').val()
					,receiptTel2: $('input[name=receiptTel2]').val()
					,receiptTel3: $('input[name=receiptTel3]').val()
					,orderNo: '${orderInfo.orderNo}'
					},function(data, dataType){
					var data = data.replace(/\s/gi,'');
					alert(data);
					location.reload();
				},'POST','text');
			}
		});

		/** 주소 찾기 **/
	    $("#addrSearch").click(function(){
	      var thisId = $(this).attr("id");
	      new daum.Postcode({
	            oncomplete: function(data) {
	              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	                  // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                  // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                  var fullAddr = ''; // 최종 주소 변수
	                  var extraAddr = ''; // 조합형 주소 변수
	                  // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                  if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                      fullAddr = data.roadAddress;
	                  } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                      fullAddr = data.jibunAddress;
	                  }
	                  // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                  if(data.userSelectedType === 'R'){
	                      //법정동명이 있을 경우 추가한다.
	                      if(data.bname !== ''){
	                          extraAddr += data.bname;
	                      }
	                      // 건물명이 있을 경우 추가한다.
	                      if(data.buildingName !== ''){
	                          extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                      }
	                      // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
	                      extraAddr = (extraAddr !== '' ? '('+ extraAddr +') ' : '');
	                  }
	                  // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                    $('input[name=receiptZipcode]').val(data.zonecode);
	                    $('input[name=receiptAddr]').val(fullAddr);
	                    // 커서를 상세주소 필드로 이동한다.
	                    $('input[name=receiptAddrDtl]').val(extraAddr);
	                    $('input[name=receiptAddrDtl]').focus();
	            }
	        }).open();
	    });
	}

	function pakingPop(orderNo,orderPackingDt){
		$.fancybox.open({
			href: "/mng/amM3/amM3/orderPaking.action?orderNo="+orderNo+"&orderPackingDt="+orderPackingDt,
			type: "iframe",
 			maxWidth	: 400,
 			maxHeight	: 600,
 			width		: 400,
 			height		: 600,
 			autoSize	: false,
 			modal : false
		});
	}

	function fnMbrDetail(){
		<c:choose>
			<c:when test='${not empty isCrm}'>
				window.open("/mng/crm/softPhone/SoftPhone.pop?admId=${admId}&mbrId=${orderInfo.mbrId}", "mbrId", "width=1366, height=875, scrollbars=yes");
		   </c:when>
		   <c:otherwise>
				window.open("/mng/amM1/amM102/amM1021F.pop?mbrId=${orderInfo.mbrId}", "mbrId", "width=1070, height=875, scrollbars=yes");
		    </c:otherwise>
		</c:choose>
	}
	</script>
</head>

<body class="noBg">
	<div class="popup_wrap" style="background:#fff">
	<h2>상세주문관리</h2>
	<div class="member_con">
		<div class="gnb leng5">
			<ul>
				<li>
					<a href="javascript:;" onclick="$('.pageContScroll_st1').mCustomScrollbar('scrollTo','10px',{   scrollInertia:300});">주문내역</a>
				</li>
				<li>
					<a href="javascript:;" onclick="$('.pageContScroll_st1').mCustomScrollbar('scrollTo','330px',{   scrollInertia:300});">구매자정보</a>
				</li>
				<li>
					<a href="javascript:;" onclick="$('.pageContScroll_st1').mCustomScrollbar('scrollTo','590px',{   scrollInertia:300});">결제정보</a>
				</li>
				<li>
					<a href="javascript:;" onclick="$('.pageContScroll_st1').mCustomScrollbar('scrollTo','745px',{   scrollInertia:300});">배송정보</a>
				</li>
				<li>
					<a href="javascript:;" onclick="$('.pageContScroll_st1').mCustomScrollbar('scrollTo','1149px',{   scrollInertia:300});">클레임정보</a>
				</li>
			</ul>
		</div>
		<!-- // gnb -->
	 <div class="pageContScroll_st6">
		<div class="member_detail_con">
			<div class="align_area" >
				<div class="left">
					<h3>주문내역</h3>
				</div>
				<div class="right">
					<span class="font16 lineH28">주문번호 : <b>${orderInfo.orderNo}</b> (${orderInfo.orderDtFull})</span>
				</div>
			</div>
			<!-- // align_area -->
			<div class="table_type1" >
				<table>
					<caption>선택, 주문상품, 결제금액, 상태, 문서관련으로 구성된 주문내역에 대한 상세 테이블 입니다.</caption>
					<colgroup>
						<col style="width:40%;" />
						<col style="width:30%;" />
						<col style="width:15%;" />
						<col style="width:15%;" />
					</colgroup>
					<thead>
						<tr>
							<th scope="col">주문상품</th>
							<th scope="col">결제금액</th>
							<th scope="col">상태</th>
							<th scope="col">업무</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td class="alignL">
								<c:forEach items="${orderInfo.prodInfoList}" var="prodInfo" varStatus="idx">
										<div style="margin:5px 0 5px 10px;">
												<div class="fl">${prodInfo.prodNm}<c:if test="${prodInfo.prodTypeGsp eq 'P'}"><span class="ptText">(포인트상품)</span></c:if></div>
												<div >(수량 : <span class="validation[number]">${prodInfo.prodQty}</span>)</div>
										</div>
										<c:if test="${!idx.last}"><center><div style="width:96%;height:1px;margin-bottom:5px;border-top:#ccc 1px dotted;"></div></center></c:if>
									</c:forEach>
							</td>
							<td>
								<div class="price_list_area">
									<div class="price_list">
										<ul>
											<li>
												<dl>
													<dt><span>상품금액</span></dt>
													<dd><span class="validation[number]">${orderInfo.orderAmt}</span>&nbsp;<span>원</span></dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt><span>상품할인</span></dt>
													<dd><div style="color:red;">-&nbsp;<span class="validation[number]">${orderInfo.orderSaleAmt}</span>&nbsp;원</div></dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt><span>쿠폰할인</span></dt>
													<dd><div style="color:red;">-&nbsp;<span class="validation[number]">${orderInfo.orderCopnAmt}</span>&nbsp;원</div></dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt><span>적립금사용</span></dt>
													<dd><div style="color:red;">-&nbsp;<span class="validation[number]">${orderInfo.orderResvAmt}</span>&nbsp;원</div></dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt><span>배송비</span></dt>
													<dd>
														<c:choose>
															<c:when test="${orderInfo.orderDeliCharge == 0}">
																<div><span>무료배송</span></div>
															</c:when>
															<c:otherwise>
																<div><span class="validation[number]">${orderInfo.orderDeliCharge}</span>&nbsp;원</div>
															</c:otherwise>
														</c:choose>
													</dd>
												</dl>
											</li>
										</ul>
									</div>
									<!-- // price_list -->
									<div class="price_total" >
										<dl>
											<dt><span>결제금액</span></dt>
											<dd style="margin-top:0px;"><span class="validation[number]">${orderInfo.orderSum}</span>&nbsp;원</dd>
										</dl>
									</div>
									<!-- // price_list_area -->
								</div>
								<!-- // price_list_area -->
							</td>
							<td>
									${orderInfo.orderStatusNm}
									<c:if test="${orderInfo.claimYn eq 'Y'}">
										<br/><span style="color:red">클레임 주문건 : ${orderInfo.claimTpNm}</span>
									</c:if>
									<c:if test="${not empty orderInfo.regiNo}">
											<br /><span>(우체국택배)</span>
											<div class="marT10"><a class="btn_type2" href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=${orderInfo.regiNo}&displayHeader=N" ><span>배송추적</span></a></div>
									</c:if>
							</td>
							<td>
								<c:choose>
									<c:when test="${orderInfo.orderCashCd eq 'Online'}">
											<a class="btn_type2" href="javascript:void(0)"  onclick="fnReceipt();"><span>현금영수증</span></a>
									</c:when>
									<c:otherwise>
										<a class="btn_type2" href="javascript:void(0)" onclick="window.open('https://iniweb.inicis.com/mall/cr/cm/mCmReceipt_head.jsp?noTid=${orderInfo.tid}&noMethod=1', '', 'width=399, height=709');return false">
											<c:choose>
													<c:when test="${orderInfo.orderCashCd eq 'Card'}"><span>카드매출전표출력</span></c:when>
													<c:when test="${orderInfo.orderCashCd eq 'HPP'}"><span>휴대폰결제 영수증</span></c:when>
													<c:otherwise><span>현금영수증</span></c:otherwise>
											</c:choose>
										</a>
									</c:otherwise>
								</c:choose>
								<c:if test="${orderInfo.claimYn eq 'N'}">
									<c:choose>
										<c:when test="${orderInfo.orderStatusCd eq 'OOS00001'}">
										<div class="marT10"><a class="btn_type2" href="javascript:;" onclick="$.orderCancel();"><span>무통장주문취소</span></a></div>
										</c:when>
										<c:when test="${orderInfo.orderStatusCd eq 'OOS00002'}">
											<div class="marT10"><a class="btn_type2" href="javascript:;" onclick="$.orderCancel();"><span>주문환불진행</span></a></div>
										</c:when>
										<c:when test="${orderInfo.orderStatusCd eq 'OOS00003' || orderInfo.orderStatusCd eq 'OOS00004' || orderInfo.orderStatusCd eq 'OOS00009'}">
											<div class="marT10"><a class="btn_type2" href="javascript:;" onclick="$.orderCancel();"><span>주문취소접수</span></a></div>
										</c:when>
									</c:choose>
								</c:if>
							</td>
						</tr>
					</tbody>

				</table>
			</div>
			<!-- // table_type1 -->
			<div class="align_area">
				<div class="right">
					<div class="order_status">
						<p><span>결제방법 :</span> <span>${orderInfo.orderCashNm}</span></p>
						<p><span>적립포인트 :</span> <span class="validation[number]">${orderInfo.prodPtInScore}</span> <span>P</span></p>
						<p><span>적립금 :</span> <span class="validation[number]">${orderInfo.prodResvFund}</span><span>원</span></p>
					</div>
				</div>
			</div>
			<!-- // align_area -->
			<h3>구매자정보</h3>
			<div class="table_type2">
				<table>
					<caption>아이디, 이름, 생일/성별, 회원등급, 회원분류, 추천인, 휴대폰번호, 유선전화, 이메일, 우편번호, 주소, 보유적립금, 적립금사용, 보유포인트로 구성된 구매자정보에 대한 상세 테이블 입니다.</caption>
					<colgroup>
						<col style="width:10%;" />
						<col style="width:23%;" />
						<col style="width:10%;" />
						<col style="width:23%;" />
						<col style="width:10%;" />
						<col style="width:24%;" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">아이디</th>
							<td>
								${orderInfo.mbrId}
							</td>
							<th scope="row">이름</th>
							<td>
								<a href="javascript:fnMbrDetail();">${orderInfo.mbrNm}</a>
							</td>
							<th scope="row">생일/성별</th>
							<td>
								<c:choose>
									<c:when test="${orderInfo.mbrBirthdtTypeGl eq 'G'}">(양력)</c:when>
									<c:when test="${orderInfo.mbrBirthdtTypeGl eq 'L'}">(음력)</c:when>
								</c:choose>
								 ${orderInfo.mbrNm}
								 <c:choose>
									<c:when test="${orderInfo.mbrSexMw eq 'M'}">/ 남</c:when>
									<c:when test="${orderInfo.mbrSexMw eq 'W'}">/ 여</c:when>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="row">회원등급</th>
							<td>
								${orderInfo.mbrLevNm}
							</td>
							<th scope="row">회원분류</th>
							<td>
								<c:choose>
									<c:when test="${orderInfo.mbrTpBte eq 'B'}">일반회원</c:when>
									<c:when test="${orderInfo.mbrTpBte eq 'T'}">전화회원</c:when>
									<c:when test="${orderInfo.mbrTpBte eq 'E'}">임직원</c:when>
								</c:choose>
							</td>
							<th scope="row">추천인</th>
							<td>
								${orderInfo.mbrRec}
							</td>
						</tr>
						<tr>
							<th scope="row">휴대폰번호</th>
							<td>
								${orderInfo.mbrMobile}
							</td>
							<th scope="row">유선전화</th>
							<td>
								${orderInfo.mbrPhone}
							</td>
							<th scope="row">이메일</th>
							<td>
								${orderInfo.mbrEmail}
							</td>
						</tr>
						<tr>
							<th scope="row">우편번호</th>
							<td>
								${orderInfo.mbrZipcode}
							</td>
							<th scope="row">주소</th>
							<td colspan="3">
								${orderInfo.mbrAddr}
								${orderInfo.mbrAddrDtl}
							</td>
						</tr>
						<tr>
							<th scope="row">보유포인트</th>
							<td class="alignR">
								<span class="validation[number]">${orderInfo.mbrPtScore}</span>&nbsp;P
							</td>
							<th scope="row">포인트사용</th>
							<td class="alignR">
								<span class="validation[number]">${orderInfo.mbrPtUseScore}</span>&nbsp;P
							</td>
							<th scope="row">보유적립금</th>
							<td class="alignR">
								<span class="validation[number]">${orderInfo.mbrResvUseScore}</span>&nbsp;원
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- // table_type2 -->
			<h3>결재정보</h3>
			<div class="table_type2">
				<table>
					<caption>주문금액, 입금금액, 입금일, 결제(입금)자, 결제방법, 결제(계좌)번호, 입금확인자, 주문일, 입금확인일로 구성된 결재정보에 대한 상세 테이블 입니다.</caption>
					<colgroup>
						<col style="width:10%;" />
						<col style="width:23%;" />
						<col style="width:10%;" />
						<col style="width:23%;" />
						<col style="width:10%;" />
						<col style="width:24%;" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">주문금액</th>
							<td class="alignR">
								<span class="validation[number]">${orderInfo.orderSum}</span>&nbsp;원
							</td>
							<th scope="row">입금금액</th>
							<td class="alignR">
								<c:choose>
									<c:when test="${orderInfo.depositFlagYnpc eq 'Y'}">(입금)</c:when>
									<c:when test="${orderInfo.depositFlagYnpc eq 'N'}">(미결재)</c:when>
									<c:when test="${orderInfo.depositFlagYnpc eq 'P'}">(입금취소진행)</c:when>
									<c:when test="${orderInfo.depositFlagYnpc eq 'C'}">(입금취소)</c:when>
								</c:choose>
								<span class="validation[number]">${orderInfo.depositAmount}</span>&nbsp;원
							</td>
							<th scope="row">입금일</th>
							<td>
								${orderInfo.depositDt}
							</td>
						</tr>
						<tr>
							<th scope="row">결제(입금)자</th>
							<td>
								${orderInfo.depositNm}
							</td>
							<th scope="row">결제방법</th>
							<td>
								${orderInfo.orderCashNm}
							</td>
							<th scope="row">결제(계좌)번호</th>
							<td>
								<c:if test="${not empty orderInfo.depositPayInfoNm}">${orderInfo.depositPayInfoNm} :: </c:if>${orderInfo.depositPayInfo}
							</td>
						</tr>
<!-- 						<tr> -->
<!-- 							<th scope="row">입금확인자</th> -->
<!-- 							<td> -->
<!-- 								나관리 -->
<!-- 							</td> -->
<!-- 							<th scope="row">주문일</th> -->
<!-- 							<td> -->
<!-- 								YYY.MM.DD -->
<!-- 							</td> -->
<!-- 							<th scope="row">입금확인일</th> -->
<!-- 							<td> -->
<!-- 								yYYYY.MM.DD-HH:MM:SS -->
<!-- 							</td> -->
<!-- 						</tr> -->
					</tbody>
				</table>
			</div>
			<!-- // table_type2 -->

				<h3>배송정보</h3>
			<div class="table_type2">
				<table>
					<caption>배송일자, 택배회사, 운송장번호, 받는사람, 전화번호1, 전화번호2, 배송지주소, 배송시요청사항, 운영자메모로 구성된 배송정보에 대한 테이블 입니다.</caption>
					<colgroup>
						<col style="width:10%;" />
						<col style="width:23%;" />
						<col style="width:10%;" />
						<col style="width:23%;" />
						<col style="width:10%;" />
						<col style="width:24%;" />
					</colgroup>
					<tbody>

						<tr>
							<th scope="row">배송접수일</th>
							<td>
								${orderInfo.orderSendDt}
							</td>
							<th scope="row">발송(패킹완료)일</th>
							<td>
								${orderInfo.orderPackingDt}
								<c:choose>
									<c:when test="${not empty orderInfo.orderPackingDt}">
										<a class="btn_type2" href="javascript:void(0)" onclick="pakingPop('${orderInfo.orderNo}','${orderInfo.orderPackingDtS}');">패킹</a>
									</c:when>
									<c:otherwise>
										<c:if test="${orderInfo.orderStatusCd eq 'OOS00003'}">
											<a class="btn_type2" id="orderPackingDt" href="javascript:void(0)">수동패킹등록</a>
										</c:if>
									</c:otherwise>
								</c:choose>
							</td>
							<th scope="row">배송완료일</th>
							<td>
								${orderInfo.orderDeliDt}
							</td>
						</tr>
						<tr>
							<th scope="row">택배회사</th>
							<td>
								우체국택배
							</td>
							<th scope="row">운송장번호</th>
							<td  colspan="3">
								<c:choose>
									<c:when test="${orderInfo.orderStatusCd eq 'OOS00002'}">
											<div style="float:left;line-height:30px;" title="송장번호 수동 등록"><input type="text" id="regiNoText" name="regiNoText" class="validation[numberOnly]" value=""/></div>
											<div style="float:left;margin-left:10px;line-height:30px;"><a class="btn_type2" id="regiNo" href="javascript:void(0)">송장번호 등록</a></div>
									</c:when>
									<c:otherwise>
										<a href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=${orderInfo.regiNo}&displayHeader=N" target="_blank" class="btn13" title="배송조회 상세보기">${orderInfo.regiNo}</a>
									</c:otherwise>
								</c:choose>
							</td>
						</tr>
						<tr>
							<th scope="row">받는사람</th>
							<td>
									<input type="text" name="receiptNm" id="receiptNm" style="width:60px;" value="${orderInfo.receiptNm}" <c:if test="${not empty orderInfo.orderSendDt}">disabled="disabled" </c:if> />
							</td>
							<th scope="row">휴대폰</th>
							<td>
								<div style="float:left;line-height:30px;">
									<input type="text" name="receiptMobile1" id="receiptMobile1" style="width:25px;" maxlength="3" value="${fn:split(orderInfo.receiptMobile,'-')[0]}" <c:if test="${not empty orderInfo.orderSendDt}">disabled="disabled" </c:if>/>&nbsp;-&nbsp;
								</div>
								<div style="float:left;line-height:30px;">
									<input type="text" name="receiptMobile2" id="receiptMobile2" style="width:35px;" maxlength="4" value="${fn:split(orderInfo.receiptMobile,'-')[1]}" <c:if test="${not empty orderInfo.orderSendDt}">disabled="disabled" </c:if>/>&nbsp;-&nbsp;
								</div>
								<div style="float:left;line-height:30px;">
									<input type="text" name="receiptMobile3" id="receiptMobile3" style="width:35px;" maxlength="4" value="${fn:split(orderInfo.receiptMobile,'-')[2]}"<c:if test="${not empty orderInfo.orderSendDt}">disabled="disabled" </c:if> />
								</div>
							</td>
							<th scope="row">전화번호</th>
							<td>
								<div style="float:left;line-height:30px;">
									<input type="text" name="receiptTel1" id="receiptTel1" style="width:30px;" maxlength="3" value="${fn:split(orderInfo.receiptTel,'-')[0]}"<c:if test="${not empty orderInfo.orderSendDt}">disabled="disabled" </c:if>  />&nbsp;-&nbsp;
								</div>
								<div style="float:left;line-height:30px;">
									<input type="text" name="receiptTel2" id="receiptTel2" style="width:40px;" maxlength="4" value="${fn:split(orderInfo.receiptTel,'-')[1]}" <c:if test="${not empty orderInfo.orderSendDt}">disabled="disabled" </c:if> />&nbsp;-&nbsp;
								</div>
								<div style="float:left;line-height:30px;">
									<input type="text" name="receiptTel3" id="receiptTel3" style="width:40px;" maxlength="4" value="${fn:split(orderInfo.receiptTel,'-')[2]}" <c:if test="${not empty orderInfo.orderSendDt}">disabled="disabled" </c:if> />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">배송지주소</th>
							<td colspan="5">
								<div style="float:left;line-height:30px;margin-right:10px;">
									<input type="text" name="receiptZipcode" id="receiptZipcode" style="width:60px;" value="${orderInfo.receiptZipcode}" <c:if test="${not empty orderInfo.orderSendDt}">disabled="disabled" </c:if>/>
								</div>
								<div style="float:left;line-height:30px;margin-right:10px;">
									<input type="text" name="receiptAddr" id="receiptAddr" style="width:300px;" value="${orderInfo.receiptAddr}" <c:if test="${not empty orderInfo.orderSendDt}">disabled="disabled" </c:if>/>
								</div>
								<div style="float:left;line-height:30px;margin-right:10px;">
									<input type="text" name="receiptAddrDtl" id="receiptAddrDtl" style="width:200px;" value="${orderInfo.receiptAddrDtl}" <c:if test="${not empty orderInfo.orderSendDt}">disabled="disabled" </c:if>/>
								</div>
								<div style="float:left;line-height:30px;margin-right:10px;">
                					  <a class="btn_type1 " id="addrSearch" href="javascript:;">주소검색</a>
                				</div>
								<div style="float:left;line-height:30px;">
									<a class="btn_type1 " id="addrSave" href="javascript:void(0)" >배송지 정보 수정</a>
                				</div>
							</td>
						</tr>
						<tr>
							<th scope="row">배송시요청사항</th>
							<td colspan="5">
								<div style="float:left;line-height:30px;">
									<input type="text" name="receiptDeliveryNoteText" id="receiptDeliveryNoteText" size="76" maxlength="90" value="${orderInfo.receiptReqCont}" <c:if test="${not empty orderInfo.orderSendDt}">disabled="disabled" </c:if>/>
								</div>
								<div style="float:right;line-height:30px;">
								<c:if test="${empty orderInfo.orderSendDt}">
									<a class="btn_type2 btn_icon5" id="receiptDeliveryNote" href="javascript:void(0)">배송요청사항 저장</a>
								</c:if>
									<a class="btn_type2 btn_icon5" id="receiptOperNote" href="javascript:void(0)">운영자 메모저장</a>
								</div>
							</td>

						</tr>
						<tr>
							<th scope="row">운영자메모</th>
							<td colspan="5">
								<div class="textarea_form">
									<textarea style="height:100px;" id="receiptOperNoteText" name="receiptOperNoteText" >${orderInfo.receiptOperNote}</textarea>
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- // align_area -->
			<div class="align_area">
					<h3>클레임정보</h3>
			</div>
			<!-- // align_area -->
			<c:choose>
				<c:when test="${orderInfo.claimYn eq 'N'}">
					<div class="table_type2">
						<table>
							<tr>
								<td>클레임 요청건이 아닙니다.</td>
							</tr>
						</table>
					</div>
				</c:when>
				<c:otherwise>
				      <div class="table_type2">
				        <table>
				              <colgroup>
				                <col style="width:200px;" />
				                <col style="width:*;" />
				              </colgroup>
				          <tbody>
				            <tr>
				              <th scope="row">처리이력</th>
				              <td>
				                <div class="dash_ul">
				                  <ul>
				                  <c:forEach items="${claimProcessHis}" var="claimProcessHisUit">
				                    <li>${claimProcessHisUit.cont}</li>
				                  </c:forEach>
				                  </ul>
				                </div>
				              </td>
				            </tr>
				          </tbody>
				        </table>
				      </div>
				</c:otherwise>
			</c:choose>

			<!-- // table_type2 -->
		</div>
		<!-- // member_detail_con -->
	</div>
	</div>
	<div class="btn_area">
		    <div class="center">
		      	<a class="btn_blue_line2" href="javascript:;" id="printDetail">인쇄</a>
		      	<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
		    </div>
		  </div>
	</div>
	<!-- // member_con -->
</body>
</html>
