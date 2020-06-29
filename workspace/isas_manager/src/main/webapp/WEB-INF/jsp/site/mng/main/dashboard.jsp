<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<script type="text/javaScript" defer="defer">
<!--
function init(){
	fnEvent();
	fnBarchart();
	fnPieChart();
	//화면 기본 데이터 셋팅
	fnDataSetting();
}

function fnEvent(){
 	$.noticeView = function(boardSeq){
		$.fancybox.open({
			href: "/mng/bbt/bbt00001R.action?boardMstCd=BBM00001&boardSeq="+boardSeq,
			type: "iframe",
			maxWidth	: 1920,
			maxHeight	: 1100,
			width		: 1000,
			modal : false,
			autoSize	: true
		});
	}
 	$('#csDt').on('change', function (event)
 	{
 				fnAjax(	"csCountList.action",
 		 				{ csDt : $("input[name=csDt]").val() },
 		 				function(data, dataType){
 		 				$(".vt1").html(data.prevMonth+" "+data.todayKor+"요일<br/>(평균 VOC)");
 		 				$(".vt2").html(data.prevWeek+"("+data.todayKor+")<br/>(VOC건수)");
 		 				$(".vt3").html(data.todayWeek+"("+data.todayKor+")<br/>(VOC건수)");
 		 				$(".vt4").html("전월 "+data.todayKor+"요일 대비 증감율");
 		 				$(".vt5").html("전주 "+data.todayKor+"요일 대비 증감율");

 		 				$("#csList").html("");
						var csCountList = data.csCountList;
						$.monthCount = 0;
						$.weekCount = 0;
						$.todayCount = 0;
							for (key in csCountList) {
								var monthCount = setComma(parseInt(csCountList[key].monthCount));
								var weekCount = setComma(csCountList[key].weekCount);
								var todayCount = setComma(csCountList[key].todayCount);
								var monthAvg = "";
								var weekAvg = "";

								if(monthCount == undefined){
								 	monthCount = "0";
								}else{
									$.monthCount = parseInt($.monthCount)+parseInt(monthCount);
								}
								if(weekCount == undefined){
									weekCount = "0";
								}else{
									$.weekCount = parseInt($.weekCount)+parseInt(weekCount);
								}
								if(todayCount == undefined){
									todayCount = "0";
								}else{
									$.todayCount = parseInt($.todayCount)+parseInt(todayCount);
								}

								if(csCountList[key].monthAvg != undefined){
								 monthAvg = csCountList[key].monthAvg+"%";
								}

								if(csCountList[key].weekAvg != undefined){
								 weekAvg = csCountList[key].weekAvg+"%";
								}


								$("#csList").append( "<tr>"+
										"<th scope=\"row\">"+csCountList[key].csTypeNm+"</th>"+
										"<td class=\"txt_r td2\"><span >"+monthCount+"</span></td>"+
										"<td class=\"txt_r td2\"><span>"+weekCount+"</span></td>"+
										"<td class=\"txt_r td2\"><span>"+todayCount+"</span></td>"+
										"<td class=\"txt_r td2\"><span>"+monthAvg+"</span></td>"+
										"<td class=\"txt_r td2\"><span>"+weekAvg+"</span></td>"+
										"</tr>"
								);
							}
							var sumMonth =  parseInt(Math.round((($.todayCount-$.monthCount)/$.monthCount)*100));
							if(isNaN(sumMonth)){
								sumMonth = "";
							}else{
								sumMonth += "%";
							}

							var sumWeek =  parseInt(Math.round((($.todayCount-$.weekCount)/$.weekCount)*100));
							if(isNaN(sumWeek)){
								sumWeek = "";
							}else{
								sumWeek += "%";
							}

							$("#csList").append( "<tr><th style=\"background-color:#e2effa;\">상담유형합계</th>"+
									"<td class=\"txt_r td2\"  style=\"background-color:#e2effa;\"><span>"+$.monthCount+"</span></td>"+
									"<td class=\"txt_r td2\" style=\"background-color:#e2effa;\"><span>"+$.weekCount+"</span></td>"+
									"<td class=\"txt_r td2\" style=\"background-color:#e2effa;\"><span>"+$.todayCount+"</span></td>"+
									"<td class=\"txt_r td2\"style=\"background-color:#e2effa;\"><span>"+sumMonth+"</span></td>"+
									"<td class=\"txt_r td2\" style=\"background-color:#e2effa;\"><span>"+sumWeek+"</span></td>"+
									"</tr>");
 		 		},'POST','json');
 	});
}

function fnBarchart(){
         // prepare chart data
          var dataStatCounter =
            [
			<c:forEach items="${mbrLevPercentList}" var="mbrLevPercent" varStatus="idx">
				<c:choose>
					<c:when test="${idx.last}" >
						{ lev: '${mbrLevPercent.mbrLevNm}', Share: ${mbrLevPercent.percentLev}, levCount:${mbrLevPercent.mbrLevCount} }
					</c:when>
					<c:otherwise>
						{ lev: '${mbrLevPercent.mbrLevNm}', Share: ${mbrLevPercent.percentLev} , levCount:${mbrLevPercent.mbrLevCount}},
					</c:otherwise>
				</c:choose>
			</c:forEach>
            ];
          var charts =  {  dataSource: dataStatCounter };

         var chartSettings = {
                 source: charts.dataSource,
                 title: '',
                 description: '',
                 enableAnimations: false,
                 showLegend: true,
                 showBorderLine: true,
                 colorScheme: 'scheme03',
                 seriesGroups: [
                     {
                         type: 'pie',
                         showLegend: true,
                         enableSeriesToggle: true,
                         series:
                             [
                                 {
                                     dataField: 'Share',
                                     displayText: 'lev',
                                     showLabels: true,
                                     labelRadius: 200,
                                     labelLinesEnabled: true,
                                     labelLinesAngles: true,
                                     labelsAutoRotate: false,
                                     initialAngle: 0,
                                     radius: 130,
                                     minAngle: 0,
                                     maxAngle: 180,
                                     centerOffset: 0,
                                     offsetY: 150,
                                     formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                         if (isNaN(value))
                                             return value;
                                         return value + '%';
                                     }
                                 }
                             ]
                     }
                 ]
             };
     	// setup the chart
       	$('#barChartContainer').jqxChart(chartSettings);
}
function fnPieChart(){
// 신규거래처	신규거래요청	시스템문의	이벤트문의	회원정보변경	클레임	주문관련문의	제품문의	기타문의
	var dataStatCounter =
        [
     	<c:forEach items="${csPie1}" var="csPie" varStatus="idx">
		<c:choose>
			<c:when test="${idx.last}" >
				{ lev: '${csPie.csTypeNm}', Share: ${csPie.precetAmt} }
			</c:when>
			<c:otherwise>
				{ lev: '${csPie.csTypeNm}', Share: ${csPie.precetAmt} },
			</c:otherwise>
		</c:choose>
		</c:forEach>
        ];
	var dataStatCounter2 =
		[
			<c:forEach items="${csPie2}" var="csPie" varStatus="idx">
			<c:choose>
				<c:when test="${idx.last}" >
					{ lev: '${csPie.csTypeNm}', Share: ${csPie.precetAmt} }
				</c:when>
				<c:otherwise>
					{ lev: '${csPie.csTypeNm}', Share: ${csPie.precetAmt} },
				</c:otherwise>
			</c:choose>
			</c:forEach>
     ];
	var dataStatCounter3 =
		[
			<c:forEach items="${csPie3}" var="csPie" varStatus="idx">
			<c:choose>
				<c:when test="${idx.last}" >
					{ lev: '${csPie.csTypeNm}', Share: ${csPie.precetAmt} }
				</c:when>
				<c:otherwise>
					{ lev: '${csPie.csTypeNm}', Share: ${csPie.precetAmt} },
				</c:otherwise>
			</c:choose>
			</c:forEach>
     ];
	var charts = [
	                { dataSource: dataStatCounter },
	                { dataSource: dataStatCounter2 },
	                {  dataSource: dataStatCounter3 }
	            ];


	 for (var i = 0; i < charts.length; i++) {
         var chartSettings = {
             source: charts[i].dataSource,
             title: '',
             description: '',

             enableAnimations: true,
             showLegend: false,
             showBorderLine: true,
             legendPosition: { left: 520, top: 140, width: 100, height: 100 },
             padding: { left: 5, top: 5, right: 5, bottom: 5 },
             titlePadding: { left: 0, top: 0, right: 0, bottom: 10 },
             colorScheme: 'scheme15',
             seriesGroups: [
                 {
                     type: 'pie',
                     showLegend: true,
                     enableSeriesToggle: true,
                     series:
                         [
                             {
                                 dataField: 'Share',
                                 displayText: 'lev',
                                 showLabels: true,
                                 labelRadius: 120,
                                 labelLinesEnabled: true,
                                 labelLinesAngles: true,
                                 labelsAutoRotate: false,
                                 initialAngle: 0,
                                 radius: 95,
                                 minAngle: 0,
                                 centerOffset: 0,
                                 offsetY: 120,
                                 formatFunction: function (value, itemIdx, serieIndex, groupIndex) {
                                     if (isNaN(value))
                                         return value;
                                     return value + '%';
                                 }
                             }
                         ]
                 }
             ]
         };
         // select container and apply settings
         var selector = '#chartContainer' + (i + 1);
         $(selector).jqxChart(chartSettings);
     } // for

}
function fnDataSetting(){
	  dateTimeInput("csDt", null, "${nowYmd}");
	  $('#csDt').change();

}
//-->
</script>
</head>

<body>

<div class="pageContScroll_st2">
 	<div class="sec_fc">
					<div class="sec_fl">
						<div class="sec1">
							<div class="left">
								<h3 class="h3_1">회원현황</h3>
							</div>
							<div class="sec1_1 sec_info1">
								<ul>
									<li>오늘 가입 : <strong><span class="validation[number]">${total.todayJoin}</span></strong>명</li>
									<li>총회원 : <span class="validation[number]">${total.totalJoin}</span>명 (맴버쉽회원:<span class="validation[number]">${total.levJoin}</span>명)</li>
								</ul>
							</div>
							<div class="sec1_2 graph_wrap1">
								<div id="barChartContainer" style="width:450px; height:188px;"></div>
								<!-- 막대그래프 영역 -->
							</div>
						</div> <!-- // sec1 -->
						<div class="sec2 sec_info2">
							<div class="sec2_tit">
								<h3 class="h3_2">공지사항</h3>
								<a href="/mng/bbt/bbt00001.do?boardMstCd=BBM00001" class="btn_type6 fr">more</a>
							</div>
							<div class="sec2_1 table_type4">
								<table>
									<caption>NO, 제목, 날짜에 대한 공지사항 리스트 테이블 입니다.</caption>
									<colgroup>
										<col style="width:50px">
										<col style="width:*">
										<col style="width:80px">
									</colgroup>
									<thead>
										<tr>
											<th scope="col">NO</th>
											<th scope="col">제목</th>
											<th scope="col">날짜</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${noticeList}" var="notice" varStatus="idx">
										<tr>
											<td>${notice.boardSeq}</td>
											<td class="txt_ellip"><a id="registBtn" href="#notice1" onclick="$.noticeView('${notice.boardSeq}');" >${notice.boardTitle}</a></td>
											<td>${notice.regDt}</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div> <!-- // sec2 -->
					</div> <!-- // sec_fl -->
					<div class="sec_fr">
						<div class="sec3">
							<div class="left">
								<h3 class="h3_1">매출현황</h3>
							</div>
							<div class="sec3_1 sec_info1">
								<ul>
									<li>오늘 구매건 : <strong><span class="validation[number]"><fmt:formatNumber value="${total.todayOrder}"  pattern="#"/></span></strong>건</li>
									<li>금일 총매출 :  <span class="validation[number]"><fmt:formatNumber value="${total.sumOrder}"  pattern="#"/></span>원</li>
									<li>금일 순매출 :  <span class="validation[number]"><fmt:formatNumber value="${total.realSumOrder}"  pattern="#"/></span>원</li>
								</ul>
							</div> <!-- // sec3_1 -->
							<div class="sec3_2 table_type1">
								<table>
									<caption>구분, 건수, 금액, 비율로 구성된 매출현황에 대한 리스트 테이블 입니다.</caption>
									<colgroup>
										<col style="width:25%;" />
										<col style="width:25%;" />
										<col style="width:25%;" />
										<col style="width:25%;" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">구분</th>
											<th scope="col">건수</th>
											<th scope="col">금액</th>
											<th scope="col">비율</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${orderSumList}" var="orderSum" varStatus="idx">
										<tr>
											<th scope="row">${orderSum.sales}</th>
											<td class="txt_r td2"><span class="validation[number]" >${orderSum.orderCount}</span> 건</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderSum.orderAmount}"  pattern="#"/></span> 원</td>
											<td class="txt_r td2">${orderSum.precent}%</td>
										</tr>
										</c:forEach>
									</tbody>
								</table>
							</div> <!-- // sec3_2 -->
							<div class="sec3_3 table_type1">
								<table>
									<caption>입금대기, 입금확인, 발송으로 구성된 매출현황 테이블 입니다.</caption>
									<colgroup>
										<col style="width:25%;" />
										<col style="width:25%;" />
										<col style="width:25%;" />
										<col style="width:25%;" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">입금대기</th>
											<th scope="col">입금확인</th>
											<th scope="col">발송진행</th>
											<th scope="col">발송완료</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${cashStatusList[0].orderStatus1}"  pattern="#"/></span> 건</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${cashStatusList[0].orderStatus2}"  pattern="#"/></span> 건</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${cashStatusList[0].orderStatus3}"  pattern="#"/></span> 건</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${cashStatusList[0].orderStatus4}"  pattern="#"/></span> 건</td>
										</tr>
										<tr>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${cashStatusList[1].orderStatus1}"  pattern="#"/></span> 원</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${cashStatusList[1].orderStatus2}"  pattern="#"/></span> 원</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${cashStatusList[1].orderStatus3}"  pattern="#"/></span> 원</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${cashStatusList[1].orderStatus4}"  pattern="#"/></span> 원</td>
										</tr>
									</tbody>
								</table>
							</div> <!-- // sec3_3 -->
							<div class="sec3_4 table_type1">
								<table>
									<caption>취소/요청, 반품, 교환으로 구성된 매출현황 테이블 입니다.</caption>
									<colgroup>
										<col style="width:25%;" />
										<col style="width:25%;" />
										<col style="width:25%;" />
										<col style="width:25%;" />
									</colgroup>
									<thead>
										<tr>
											<th scope="col">취소/요청</th>
											<th scope="col">환불</th>
											<th scope="col">반품</th>
											<th scope="col">교환</th>
										</tr>
									</thead>
									<tbody>
										<tr>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${claimStatusList[0].claimStatus1}"   pattern="#" /></span> 건</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${claimStatusList[0].claimStatus2}"  pattern="#" /></span> 건</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${claimStatusList[0].claimStatus3}"  pattern="#" /></span> 건</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${claimStatusList[0].claimStatus4}"  pattern="#" /></span> 건</td>
										</tr>
										<tr>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${claimStatusList[1].claimStatus1}"  pattern="#"/></span> 원</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${claimStatusList[1].claimStatus2}"  pattern="#"/></span> 원</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${claimStatusList[1].claimStatus3}"  pattern="#"/></span> 원</td>
											<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${claimStatusList[1].claimStatus4}"  pattern="#" /></span> 원</td>
										</tr>
									</tbody>
								</table>
							</div> <!-- // sec3_4 -->
						</div> <!-- // sec3 -->
					</div> <!-- // sec_fr -->
				</div> <!-- // sec_fc -->
				<div class="sec8">
						<h3 class="h3_1">금일 상품별 판매현황</h3>
						<div class="table_type1">
							<table>
								<caption>상품명, 수량, 금액, 판매수량비율, 판매금액비율으로 구성된 유입경로에 대한 테이블 입니다.</caption>
								<colgroup>
									<col style="width:20%;" />
									<col style="width:20%;" />
									<col style="width:20%;" />
									<col style="width:20%;" />
									<col style="width:20%;" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">상품명</th>
										<th scope="col">수량</th>
										<th scope="col">금액</th>
										<th scope="col">판매수량비율</th>
										<th scope="col">판매금액비율</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${orderProdList}" var="orderProd" varStatus="idx">
									<tr>
										<td>${orderProd.prodNm}</td>
										<td class="txt_r td2"><span class="validation[number]">${orderProd.prodQty}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderProd.prodPrice}</span> 원</td>
										<td class="txt_r td2">${orderProd.precentQty} %</td>
										<td class="txt_r td2">${orderProd.precetAmt} %</td>
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div> <!-- // sec8 -->
				<div class="sec_fc">
					<div class="sec4">
						<h3 class="h3_1">연간매출현황</h3>
						<div class="table_type1">
							<table>
								<caption>1월, 2월, 3월, 4월, 5월, 6월, 7월, 8월, 9월, 10월, 11월, 12월로 구성된 연간매출현황 테이블 입니다.</caption>
								<colgroup>
									<col style="width:7%;" />
									<col style="width:7%;" />
									<col style="width:7%;" />
									<col style="width:7%;" />
									<col style="width:7%;" />
									<col style="width:7%;" />
									<col style="width:7%;" />
									<col style="width:7%;" />
									<col style="width:7%;" />
									<col style="width:7%;" />
									<col style="width:7%;" />
									<col style="width:7%;" />
									<col style="width:*;" />
								</colgroup>
								<tbody>
									<tr>
										<th>1월</th>
										<th>2월</th>
										<th>3월</th>
										<th>4월</th>
										<th>5월</th>
										<th>6월</th>
										<th>7월</th>
										<th>8월</th>
										<th>9월</th>
										<th>10월</th>
										<th>11월</th>
										<th>12월</th>
										<th class="th2">총계</th>
									</tr>
									<tr>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[0].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[1].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[2].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[3].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[4].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[5].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[6].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[7].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[8].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[9].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[10].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[11].orderCount}</span> 건</td>
										<td class="txt_r td2"><span class="validation[number]">${orderYearList[0].orderCount+orderYearList[1].orderCount+orderYearList[2].orderCount+orderYearList[3].orderCount+orderYearList[4].orderCount+orderYearList[5].orderCount+orderYearList[6].orderCount+orderYearList[7].orderCount+orderYearList[8].orderCount+orderYearList[9].orderCount+orderYearList[10].orderCount+orderYearList[11].orderCount}</span> 건</td>
									</tr>
									<tr>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[0].orderAmtSum}" pattern="#" /></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[1].orderAmtSum}"  pattern="#"/></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[2].orderAmtSum}"  pattern="#"/></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[3].orderAmtSum}"  pattern="#"/></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[4].orderAmtSum}"  pattern="#"/></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[5].orderAmtSum}"  pattern="#"/></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[6].orderAmtSum}"  pattern="#"/></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[7].orderAmtSum}"  pattern="#"/></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[8].orderAmtSum}"  pattern="#"/></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[9].orderAmtSum}"  pattern="#"/></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[10].orderAmtSum}"  pattern="#"/></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[11].orderAmtSum}"  pattern="#"/></span> 원</td>
										<td class="txt_r td2"><span class="validation[number]"><fmt:formatNumber value="${orderYearList[0].orderAmtSum+orderYearList[1].orderAmtSum+orderYearList[2].orderAmtSum+orderYearList[3].orderAmtSum+orderYearList[4].orderAmtSum+orderYearList[5].orderAmtSum+orderYearList[6].orderAmtSum+orderYearList[7].orderAmtSum+orderYearList[8].orderAmtSum+orderYearList[9].orderAmtSum+orderYearList[10].orderAmtSum+orderYearList[11].orderAmtSum}"  pattern="#"  /></span> 원</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div> <!-- // sec4 -->
					<div class="sec6">
						<h3 class="h3_1">VOC 현황</h3>
						<div class="sec6_1 sec_info2">
							<div class="graph2_wrap1">
								<ul>
									<li>오늘</li>
									<li>전주</li>
									<li>전월</li>
								</ul>
								<ul>
									<li ><div id='chartContainer1' style="width: 97%; height: 250px;"></div></li>
									<li><div id='chartContainer2' style="width: 97%; height: 250px;"></div></li>
									<li ><div id='chartContainer3' style="width: 97%; height: 250px;"></div></li>
								</ul>
							</div>
							<div class="graph2_wrap2">
								<ul>
									<li><span class="m1"></span> 제품문의</li>
									<li><span class="m2"></span> 구매처문의</li>
									<li><span class="m3"></span> 신규거래요청</li>
									<li><span class="m4"></span> 이벤트문의</li>
									<li><span class="m5"></span> 주문관련문의</li>
									<li><span class="m6"></span> 시스템문의</li>
									<li><span class="m7"></span> 회원정보변경</li>
									<li><span class="m8"></span> 클레임</li>
									<li><span class="m9"></span> 기타문의</li>
								</ul>
							</div>
<!-- 							<div class="fl" style="line-height: 28px;">검색 일자 :&nbsp;</div> -->
						</div> <!-- 막대그래프 영역 -->
						<div style="padding-top:20px;"></div>
						<h3 class="h3_1 fl" style="line-height: 28px;margin-right:10px;">VOC 통계</h3><div id='csDt' class="fl"  ></div>
						<div style="clear: both;"></div>
						<div class="table_type1">
							<table>
								<caption>구분, 신규거래처, 신규거래요청, 시스템문의, 이벤트문의, 회원정보변경, 클레임, 주문관련문의, 제품문의, 기타문의로 구성된 VOC 현황에 대한 테이블 입니다.</caption>
								<colgroup>
									<col style="width:19%;" />
									<col style="width:15%;" />
									<col style="width:15%;" />
									<col style="width:15%;" />
									<col style="width:18%;" />
									<col style="width:18%;" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col" >상담 유형</th>
										<th scope="col" class="vt1"></th>
										<th scope="col" class="vt2"></th>
										<th scope="col" class="vt3"></th>
										<th scope="col" class="vt4" style="background-color:#31869b;color:#fff"></th>
										<th scope="col" class="vt5" style="background-color:#31869b;color:#fff"></th>
									</tr>
								</thead>
								<tbody id="csList">

								</tbody>
							</table>
						</div> <!-- // table_type1 -->
					</div> <!-- // sec6 -->
					<div class="sec5">
						<h3 class="h3_1">금일 전화상담 통계</h3>
						<div>
						<div class="table_type1"  style="width:49%; float: left;">
							<table>
								<caption>쇼핑몰, 약국병원, 암웨이, 신문, TV광고, 인터넷/블로그, 기타, 총합으로 구성된 유입경로에 대한 테이블 입니다.</caption>
								<colgroup>
									<col style="width:50%;" />
									<col style="width:50%;" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">유입경로명</th>
										<th scope="col">건수</th>
									</tr>
								</thead>
								<tbody>
									<tr>
										<th scope="row"  >쇼핑몰</th>
										<td class="txt_r td2"><fmt:formatNumber value="${csFunnelList[0].mcf00001}"  pattern="#" /></td>
									</tr>
									<tr>
										<th scope="row" >약국병원</th>
										<td class="txt_r td2"><fmt:formatNumber value="${csFunnelList[0].mcf00002}"  pattern="#" /></td>
									</tr>
									<tr>
										<th scope="row" >암웨이</th>
										<td class="txt_r td2"><fmt:formatNumber value="${csFunnelList[0].mcf00003}"  pattern="#" /></td>
									</tr>
									<tr>
										<th scope="row" >신문</th>
										<td class="txt_r td2"><fmt:formatNumber value="${csFunnelList[0].mcf00004}"  pattern="#" /></td>
									</tr>
									<tr>
										<th scope="row" >TV광고</th>
										<td class="txt_r td2"><fmt:formatNumber value="${csFunnelList[0].mcf00005}"  pattern="#" /></td>
									</tr>
									<tr>
										<th scope="row" >인터넷/블로그</th>
										<td class="txt_r td2"><fmt:formatNumber value="${csFunnelList[0].mcf00006}"  pattern="#" /></td>
									</tr>
									<tr>
										<th scope="row" >기타</th>
										<td class="txt_r td2"><fmt:formatNumber value="${csFunnelList[0].mcf00007}"  pattern="#" /></td>
									</tr>
									<tr>
										<th scope="row" style="background-color:#e2effa;" >유입경로합계</th>
										<td class="txt_r td2"><fmt:formatNumber value="${csFunnelList[0].funnelSum}"  pattern="#" /></td>
									</tr>
								</tbody>
							</table>
						</div> <!-- // table_type1 -->
						</div>
						<div>
						<div class="table_type1" style="width:49%; float: right; ">
							<table>
								<caption>상담유형, 건수로 구성된 오늘 문의현황에 대한 리스트 테이블 입니다.</caption>
								<colgroup>
									<col style="width:50%;" />
									<col style="width:50%;" />
								</colgroup>
								<thead>
									<tr>
										<th scope="col">상담유형</th>
										<th scope="col">건수</th>
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${todayCsList}" var="todayCs" varStatus="idx">
									<c:choose>
										<c:when test="${idx.last}">
											<tr>
												<th scope="row" style="background-color:#e2effa;" >${todayCs.csName}</th>
												<td class="txt_r td2">${todayCs.csReq}</td>
											</tr>
										</c:when>
										<c:otherwise>
											<tr>
												<th scope="row">${todayCs.csName}</th>
												<td class="txt_r td2">${todayCs.csReq}</td>
											</tr>
										</c:otherwise>
									</c:choose>
									</c:forEach>
								</tbody>
							</table>
						</div>
						</div>
					</div> <!-- // sec7 -->
				</div> <!-- // sec_fc -->
			</div>

</body>