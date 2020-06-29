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
</head>
<style type="text/css">
	.popup_wrap {padding: 5px 17px 0px}
	.member_con .member_detail_con {padding: 0px 0px;}
	body {font-size: 11px;}
 	.printFontN {font-size: 11px; height: 15px;}
 	.printFontB {font-size: 14px;}
 	.table_type1 table th, .table_type1 table td {padding: 3px 0 3px;}
 	.table_type2 table th, .table_type2 table td {height: 15px;}
 	.price_total {height: 15px;}
 	.member_con .member_detail_con .table_type1, .member_con .member_detail_con .table_type2 {margin-bottom: 5px; top-margin: 0px}
 	.align_area {margin-top : 0px; margin-bottom: 20px; overflow: visible;}
 	h2 {margin-top : 0px; margin-bottom: 10px;}
 	h3 {margin-bottom: 10px;}
 	.order_status > p span {color: #000}
</style>
<body class="noBg" style="width: 800px;">
	<div class="popup_wrap" style="background:#fff">
	<h2>상세주문관리</h2>
	<div class="member_con">
		<div class="member_detail_con">
			<div class="align_area" >
				<div class="left">
					<h3>주문내역</h3>
				</div>
				<div class="right">
					<span class="printFontB lineH28">주문번호 : <b>${orderInfo.orderNo}</b> (${orderInfo.orderDtFull})</span>
				</div>
			</div>
			<!-- // align_area -->
			<div class="table_type1" >
				<table>
					<caption>선택, 주문상품, 결제금액, 상태, 문서관련으로 구성된 주문내역에 대한 상세 테이블 입니다.</caption>
					<colgroup>
						<col style="width:40%;" />
						<col style="width:30%;" />
						<col style="width:20%;" />
						<col style="width:10%;" />
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
													<dt><span class="printFontN">상품금액</span></dt>
													<dd><span class="printFontN validation[number]">${orderInfo.orderAmt}</span>&nbsp;<span class="printFontN">원</span></dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt><span class="printFontN">상품할인</span></dt>
													<dd><div style="color:red;" class="printFontN">-&nbsp;<span class="printFontN validation[number]">${orderInfo.orderSaleAmt}</span>&nbsp;원</div></dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt><span class="printFontN">쿠폰할인</span></dt>
													<dd><div style="color:red;" class="printFontN">-&nbsp;<span class="printFontN validation[number]">${orderInfo.orderCopnAmt}</span>&nbsp;원</div></dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt><span class="printFontN">적립금사용</span></dt>
													<dd><div style="color:red;" class="printFontN">-&nbsp;<span class="printFontN validation[number]">${orderInfo.orderResvAmt}</span>&nbsp;원</div></dd>
												</dl>
											</li>
											<li>
												<dl>
													<dt><span class="printFontN">배송비</span></dt>
													<dd>
														<c:choose>
															<c:when test="${orderInfo.orderDeliCharge == 0}">
																<div><span class="printFontN">무료배송</span></div>
															</c:when>
															<c:otherwise>
																<div class="printFontN"><span class="printFontN validation[number]">${orderInfo.orderDeliCharge}</span>&nbsp;원</div>
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
											<dt><span class="printFontN">결제금액</span></dt>
											<dd style="margin-top:0px;"><div class="printFontN"><span class="printFontN validation[number]">${orderInfo.orderSum}</span>&nbsp;원</div></dd>
										</dl>
									</div>
									<!-- // price_list_area -->
								</div>
								<!-- // price_list_area -->
							</td>
							<td>
								<div class="printFontN">
								${orderInfo.orderStatusNm}
								<c:if test="${orderInfo.claimYn eq 'Y'}">
									<br/><span class="printFontN" style="color:red">클레임 주문건 : ${orderInfo.claimTpNm}</span>
								</c:if>
								<c:if test="${not empty orderInfo.regiNo}">
									<br /><span class="printFontN">(우체국택배)</span>
								</c:if>
								</div>
							</td>
							<td>
								-
							</td>
						</tr>
					</tbody>

				</table>
				<div class="align_area">
					<div class="right">
						<div class="order_status">
							<p><span class="printFontN">결제방법 :</span> <span class="printFontN">${orderInfo.orderCashNm}</span></p>
							<p><span class="printFontN">적립포인트 :</span> <span class="printFontN validation[number]">${orderInfo.prodPtInScore}</span> <span class="printFontN">P</span></p>
							<p><span class="printFontN">적립금 :</span> <span class="printFontN validation[number]">${orderInfo.prodResvFund}</span><span class="printFontN">원</span></p>
						</div>
					</div>
				</div>
			</div>
			<!-- // table_type1 -->

			<h3>구매자정보</h3>
			<div class="table_type2">
				<table>
					<caption>아이디, 이름, 생일/성별, 회원등급, 회원분류, 추천인, 휴대폰번호, 유선전화, 이메일, 우편번호, 주소, 보유적립금, 적립금사용, 보유포인트로 구성된 구매자정보에 대한 상세 테이블 입니다.</caption>
					<colgroup>
						<col style="width:14%;" />
						<col style="width:19%;" />
						<col style="width:14%;" />
						<col style="width:19%;" />
						<col style="width:14%;" />
						<col style="width:20%;" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">아이디</th>
							<td>
								${orderInfo.mbrId}
							</td>
							<th scope="row">이름</th>
							<td>
								${orderInfo.mbrNm}
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
						<col style="width:14%;" />
						<col style="width:19%;" />
						<col style="width:14%;" />
						<col style="width:19%;" />
						<col style="width:14%;" />
						<col style="width:20%;" />
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
					</tbody>
				</table>
			</div>
			<!-- // table_type2 -->

			<h3>배송정보</h3>
			<div class="table_type2">
				<table>
					<caption>배송일자, 택배회사, 운송장번호, 받는사람, 전화번호1, 전화번호2, 배송지주소, 배송시요청사항, 운영자메모로 구성된 배송정보에 대한 테이블 입니다.</caption>
					<colgroup>
						<col style="width:14%;" />
						<col style="width:19%;" />
						<col style="width:15%;" />
						<col style="width:18%;" />
						<col style="width:14%;" />
						<col style="width:20%;" />
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
								${orderInfo.receiptNm}
							</td>
							<th scope="row">휴대폰</th>
							<td>
								<div style="float:left;">
									${fn:split(orderInfo.receiptMobile,'-')[0]}
								</div>
								<div style="float:left;">
									${fn:split(orderInfo.receiptMobile,'-')[1]}
								</div>
								<div style="float:left;">
									${fn:split(orderInfo.receiptMobile,'-')[2]}
								</div>
							</td>
							<th scope="row">전화번호</th>
							<td>
								<div style="float:left;">
									${fn:split(orderInfo.receiptTel,'-')[0]}
								</div>
								<div style="float:left;">
									${fn:split(orderInfo.receiptTel,'-')[1]}
								</div>
								<div style="float:left;">
									${fn:split(orderInfo.receiptTel,'-')[2]}
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">배송지주소</th>
							<td colspan="5">
								<div style="float:left; margin-right:10px;">
									${orderInfo.receiptZipcode}
								</div>
								<div style="float:left; margin-right:10px;">
									${orderInfo.receiptAddr}
								</div>
								<div style="float:left; margin-right:10px;">
									${orderInfo.receiptAddrDtl}
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">배송시요청사항</th>
							<td colspan="5">
								<div style="float:left;">
									${orderInfo.receiptReqCont}
								</div>
							</td>

						</tr>
						<tr>
							<th scope="row">운영자메모</th>
							<td colspan="5">
								${orderInfo.receiptOperNote}
							</td>
						</tr>
					</tbody>
				</table>
			</div>

			<!-- // align_area -->
			<h3>클레임정보</h3>
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
	</div>
	<!-- // member_con -->
</body>
</html>
