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
	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">서비스요금 안내</h2>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">서비스예약</a></li>
					<li class="last"><a href="#">서비스요금 안내</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<div class="msg_bx fee">
			<strong>서비스요금은 출장비 + 수리비 + 부품비의 합으로 청구됩니다.</strong>
		</div>

		<div class="cont_bx">
			<h3>품질보증기간</h3>
			<ul>
				<li>저희 이누스는 공정거래위원회에서 고시한 소비자분쟁해결기준을 준수 합니다.</li>
				<li>제품의 품질보증기간은 제품의 인도(설치)날로부터 1년 이내의 기간을 말합니다. (판매조건에 따라 품질보증기간이 다를 수 있음)</li>
			</ul>
		</div>
		<!--// 품질보증기간 -->
		<div class="cont_bx">
			<h3>유/무상 수리의 기준</h3>
			<dl>
				<dt>무상수리</dt>
				<dd>제품의 품질보증기간내에 정상적인 사용 상태에서 발생한 품질, 성능 등의 고장인 경우</dd>
				<dd>A/S 수리 후 3개월 이내 동일 부위 재 고장인 경우</dd>
				<dd class="bgx">고장이 아닌 상태에서 출장서비스를 받으시는 경우 출장비용이 부과 되오니 자주하는질문 또는 간단조치를 잘 살펴보시길 바랍니다.</dd>
			</dl>
			<dl>
				<dt>유상수리</dt>
				<dd>제품의 품질보증기간이 경과된 제품</dd>
				<dd>외부 환경이나 충격으로 인한 손상 또는 고장이 발생된 경우</dd>
				<dd>사용설명서 내의 주의사항을 지키지 않아 고장이 발생한 경우</dd>
				<dd>당사의 지정 서비스센터가 아닌 다른 사람이 수리하여 고장이 발생한 경우</dd>
				<dd>당사의 지정 부품이 아닌 부품을 가공 또는 수리하여 고장이 발생한 경우</dd>
				<dd>소모성 부품의 수명이 다하여 고장이 발생한 경우</dd>
				<dd>제품의 최초 설치 장소에서 이전을 요청 하는 경우</dd>
				<dd>천재지변으로 인한(수해, 지진, 화재) 고장이 발생될 경우</dd>
			</dl>
		</div>
		<!--// 유/무상 수리의 기준 -->
		<div class="cont_bx">
			<h3>요금 산정 기준</h3>
			<dl>
				<dt>유상 출장비</dt>
				<dd>출장수리가 필요한 경우 11,000원 청구</dd>
			</dl>
			<dl>
				<dt>수리비</dt>
				<dd>수리가 필요한 경우 11,000원 청구</dd>
			</dl>
			<dl>
				<dt>부품비</dt>
				<dd>수리에 필요한 부품 사용 시 부품비 청구</dd>
			</dl>
		</div>
		<!--// 요금 산정 기준 -->
	</div>
	<!--// sub -->
	

</body>