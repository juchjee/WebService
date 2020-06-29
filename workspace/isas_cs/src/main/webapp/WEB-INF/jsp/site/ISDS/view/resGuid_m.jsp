<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
	<script type="text/javascript">
	<!--

		function init(){
			var seq = $("#boardCateSeq").val();
			if(seq==""){
				$("#col1").addClass("on");
			}
			else{
				$("#col"+seq).addClass("on");
			}
		}

		function noticeCate(code){
			$("#page").val(1);
			$("#boardCateSeq").val(code);
			document.faqForm.action = "bbt00004.do?pageCd=${boardMstCd}";
			document.faqForm.submit();
		}

		function noticeView(seq){
			$("#boardSeq").val(seq);
			document.faqForm.action = "bbt00004V.do?pageCd=${boardMstCd}";
		   	document.faqForm.submit();
		}

		function doPage(pageNum){
			document.faqForm.page.value = pageNum;
	    	document.faqForm.action = "bbt00004.do?pageCd=${boardMstCd}";
	       	document.faqForm.submit();
		}

		//태그 문자열을 디코딩 한다
		function decodeTag(str){
			return str && str.replace(/&quot;/g,"\"").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&nbsp;/g," ").replace(/&amp;/g,"&");
		}

	//-->
	</script>
</head>
<body>
	
	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>서비스 요금 안내</h2>
		</div>
		<!--// tit_bx -->
		<div class="">
			<p class="price al">서비스요금은 출장비 + 수리비 + 부품비의<br>합으로 청구됩니다.</p>
		</div>
		<!--// gray_bx -->

		<div class="info_bx hauto">
			<em class="tit blt">품질보증기간</em>
			<ul class="mb10">
				<li class="dot">제품의 품질보증기간은 제품의 인도(설치)날로부터<br>1년 이내의 기간을 말합니다.(판매조건에 따라<br>품질보증기간이 다를 수 있음)</li>
				<li class="dot">저희 이누스는 공정거래위원회에서 고시한<br>소비자분쟁해결기준을 준수 합니다.</li>
			</ul>
			<em class="tit blt">유/무상 수리의 기준</em>
			<dl>
				<dt class="fc-bold">무상수리</dt>
				<dd class="dot">제품의 품질보증기간내에 정상적인 사용 상태에서 발생한 품질, 성능 등의 고장인 경우</dd>
				<dd class="dot mb10">A/S 수리 후 3개월 이내 동일 부위 재 고장인 경우<br><em class="line">고장이 아닌 상태에서 출장서비스를 받으시는 경우 출장비용이 부과 되오니 자주하는질문 또는 간단조치를 잘 살펴보시길 바랍니다.</em></dd>
				<dt class="fc-bold">유상수리</dt>
				<dd class="dot">제품의 품질보증기간이 경과된 제품</dd>
				<dd class="dot">외부 환경이나 충격으로 인한 손상 또는 고장이<br>발생된 경우</dd>
				<dd class="dot">사용설명서 내의 주의사항을 지키지 않아 고장이<br>발생한 경우</dd>
				<dd class="dot">당사의 지정 서비스센터가 아닌 다른 사람이 수리하여<br>고장이 발생한 경우</dd>
				<dd class="dot">당사의 지정 부품이 아닌 부품을 가공 또는 수리하여<br>고장이 발생한 경우</dd>
				<dd class="dot">소모성 부품의 수명이 다하여 고장이 발생한 경우</dd>
				<dd class="dot">제품의 최초 설치 장소에서 이전을 요청 하는 경우</dd>
				<dd class="dot mb10">천재지변으로 인한(수해, 지진, 화재) 고장이 발생될<br>경우</dd>
			</dl>
			<em class="tit blt">요금 산정 기준</em>
			<dl>
				<dt class="fc-bold">유상 출장비</dt>
				<dd class="dot mb10">출장수리가 필요한 경우 11,000원 청구</dd>
				<dt class="fc-bold">수리비</dt>
				<dd class="dot mb10">수리가 필요한 경우 11,000원 청구</dd>
				<dt class="fc-bold">부품비</dt>
				<dd class="dot">수리에 필요한 부품 사용 시 부품비 청구</dd>
			</dl>
		</div>
		<!--// info_bx -->
	</section>
	<!--// sub -->

</body>