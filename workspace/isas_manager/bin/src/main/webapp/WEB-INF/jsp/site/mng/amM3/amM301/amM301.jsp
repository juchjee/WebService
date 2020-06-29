<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 주문관리 : 영업정보관리 -->

<script type="text/javaScript" defer="defer">
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
	$("#finishing").bind("click",function(){
		var _options = {};
		_options.type = "GET";
		_options.url = "finiShing.action";
		_options.dataType = "text";
		_options.success = function(data, dataType){
			alert(data);
		};
		_options.error =  function(XMLHttpRequest, textStatus, errorThrown){
			alert('Error : ' + errorThrown);  //  Ajax가 실패한 경우 에러메시지출력
		};
		$.ajax(_options);
	});
}

</script>
</head>
<body>
	 <div class="pageContScroll_st2">


	<div class="btn_align_area">
			<div class="left btns">
				<h3>매출현황</h3>
			</div>
			<div class="right">
				<a id="finishing" class="btn_type2" href="javascript:;">일 마감 처리</a>
			</div>
		</div>
	<div class="table_type2">
		<table>
			<caption>게시판명, URL, 게시판유형, 상태, 분류구분, 기능설정, 최초 등록자, 최초 등록일, 최근 수정자, 최근 수정일로 구성된 게시판 등록에 대한 작성 테이블 입니다.</caption>
			<colgroup>
				<col style="width:150px;" />
				<col style="width:18%;" />
				<col style="width:15%;" />
				<col style="width:18%;" />
				<col style="width:15%;" />
				<col style="width:*;" />
			</colgroup>
			<thead>
<!-- 				<tr> -->
<!-- 					<th rowspan="2" class="alignC">구분</th> -->
<!-- 					<th colspan="2" class="alignC">오늘</th> -->
<!-- 					<th  colspan="2" class="alignC">당월</th> -->
<!-- 					<th rowspan="2" class="alignC">바로가기</th> -->
<!-- 				</tr> -->
				<tr>
					<th class="alignC">구분</th>
					<th class="alignC">오늘(금액)</th>
					<th class="alignC">오늘(건수)</th>
					<th class="alignC">당월(금액)</th>
					<th class="alignC">당월(건수)</th>
					<th class="alignC">바로가기</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row" >총 주문금액 (건수)</th>
					<td class="alignR">
						<span class="validation[number]">${salesResults.totOrderDaySum}</span> 원
					</td>
					<td class="alignR">
						<span class="validation[number]">${salesResults.totOrderDayCount}</span> 건
					</td>
						<td class="alignR">
						<span class="validation[number]">${salesResults.totOrderMonthSum}</span> 원
					</td>
					<td class="alignR">
						<span class="validation[number]">${salesResults.totOrderMonthCount}</span> 건
					</td>
					<td class="alignC">
						<a class="btn_type1" href="/mng/amM3/amM306/amM306.do">전체주문조회</a>
					</td>
				</tr>
				<tr>
					<th scope="row" >총 결제예정금액 (건수)</th>
					<td class="alignR">
						<span class="validation[number]">${salesResults.waitOrderDaySum}</span> 원
					</td>
					<td class="alignR">
						<span class="validation[number]">${salesResults.waitOrderDayCount}</span> 건
					</td>
						<td class="alignR">
						<span class="validation[number]">${salesResults.waitOrderMonthSum}</span> 원
					</td>
					<td class="alignR">
						<span class="validation[number]">${salesResults.waitOrderMonthCount}</span> 건
					</td>
					<td class="alignC">
						<a class="btn_type1" href="/mng/amM3/amM302/amM302.do">입금대기조회</a>
					</td>
				</tr>
				<tr>
					<th scope="row" >총 실 결제금액 (건수)</th>
					<td class="alignR">
						<span class="validation[number]">${salesResults.realOrderDaySum}</span> 원
					</td>
					<td class="alignR">
						<span class="validation[number]">${salesResults.realOrderDayCount}</span> 건
					</td>
						<td class="alignR">
						<span class="validation[number]">${salesResults.realOrderMonthSum}</span> 원
					</td>
					<td class="alignR">
						<span class="validation[number]">${salesResults.realOrderMonthCount}</span> 건
					</td>
					<td class="alignC">
						<a class="btn_type1" href="/mng/amM3/amM303/amM303.do">입금확인조회</a>
					</td>
				</tr>
				<tr>
					<th scope="row" >총 환불 금액 (건수)</th>
					<td class="alignR">
						<span class="validation[number]">${salesResults.refundOrderDaySum}</span> 원
					</td>
					<td class="alignR">
						<span class="validation[number]">${salesResults.refundOrderDayCount}</span> 건
					</td>
						<td class="alignR">
						<span class="validation[number]">${salesResults.refundOrderMonthSum}</span> 원
					</td>
					<td class="alignR">
						<span class="validation[number]">${salesResults.refundOrderMonthCount}</span> 건
					</td>
					<td class="alignC">
						<a class="btn_type1" href="/mng/amM3/amM307/amM307.do">주문취소조회</a>
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<!-- // table_type2 -->
	<h3>업무 프로세스 (${nowYmd})</h3>
	<h4> - 현재 주문상태 목록</h4>
	<div class="align_area">
			입금대기, 상품 준비중, 배송 준비중, 배송중의 현재 접수된 내역을 표시합니다.
	</div>
	<!-- // align_area -->
	<div class="table_type2">
		<table>
			<caption>게시판명, URL, 게시판유형, 상태, 분류구분, 기능설정, 최초 등록자, 최초 등록일, 최근 수정자, 최근 수정일로 구성된 게시판 등록에 대한 작성 테이블 입니다.</caption>
			<colgroup>
				<col style="width:150px;" />
				<col style="width:*;" />
			</colgroup>
			<thead>
				<tr>
					<th class="alignC">구분</th>
					<th class="alignC">입금전</th>
					<th class="alignC">입금확인</th>
					<th class="alignC">상품 준비중</th>
					<th class="alignC">배송 준비중</th>
					<th class="alignC">배송중</th>
				</tr>
			</thead>
			<tbody>
				<tr>
					<th scope="row" class="alignC">현재처리예정</th>
					<td class="alignR">
					<span class="validation[number]">${bizOrderProcResults.depoWaitCount}</span> 건
					</td>
					<td class="alignR">
					<span class="validation[number]">${bizOrderProcResults.depoOkCount}</span> 건
					</td>
					<td class="alignR">
					<span class="validation[number]">${bizOrderProcResults.prodReadyCount}</span> 건
					</td>
					<td class="alignR">
					<span class="validation[number]">${bizOrderProcResults.deilReadyCount}</span> 건
					</td>
					<td class="alignR">
					<span class="validation[number]">${bizOrderProcResults.deilStatusCount}</span> 건
					</td>
				</tr>
			</tbody>
		</table>
	</div>
	<h4> - 현재 주문취소 진행 상태</h4>
	<div class="align_area">
			취소, 교환, 반품/환불의 (접수/완료)된 내역을 표시합니다.
	</div>
	<!-- // align_area -->
	<div class="table_type2">
		<table>
			<caption>게시판명, URL, 게시판유형, 상태, 분류구분, 기능설정, 최초 등록자, 최초 등록일, 최근 수정자, 최근 수정일로 구성된 게시판 등록에 대한 작성 테이블 입니다.</caption>
			<colgroup>
				<col style="width:*;" />
				<col style="width:18%;" />
				<col style="width:18%;" />
				<col style="width:18%;" />
				<col style="width:18%;" />
				<col style="width:18%;" />
			</colgroup>
			<thead>
				<tr>
					<th class="alignC">구분</th>
					<th class="alignC">주문취소접수</th>
					<th class="alignC">환불진행</th>
					<th class="alignC">반품진행</th>
					<th class="alignC">부분반품진행</th>
					<th class="alignC">교환진행</th>
				</tr>

			</thead>
			<tbody>
				<tr>
					<th scope="row" class="alignC">현재주문취소진행</th>
					<td class="alignR"><span class="validation[number]">${bizOrderCancelProcResults.prodCancelCount1}</span> 건</td>
					<td class="alignR"><span class="validation[number]">${bizOrderCancelProcResults.prodCancelCount2}</span> 건</td>
					<td class="alignR"><span class="validation[number]">${bizOrderCancelProcResults.prodCancelCount3}</span> 건</td>
					<td class="alignR"><span class="validation[number]">${bizOrderCancelProcResults.prodCancelCount4}</span> 건</td>
					<td class="alignR"><span class="validation[number]">${bizOrderCancelProcResults.prodCancelCount5}</span> 건</td>
				</tr>
			</tbody>
		</table>
	</div>
</div>
</body>