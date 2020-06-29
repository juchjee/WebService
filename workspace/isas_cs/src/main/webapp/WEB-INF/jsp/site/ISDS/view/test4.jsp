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
			<h2 class="tit">예약 취소</h2>
			<p class="desc">서비스예약을 취소할 수 있습니다.</p>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">서비스예약</a></li>
					<li class="last"><a href="#">예약 취소</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<div class="tblType02">
			<table>
				<caption>예약 취소 목록</caption>
				<thead>
					<tr>
						<th scope="col" class="num1">번호</th>
						<th scope="col" class="num2">접수번호</th>
						<th scope="col" class="part">구분</th>
						<th scope="col" class="obj">제품</th>
						<th scope="col" class="reP">신청일</th>
						<th scope="col" class="reD">예약일</th>
						<th scope="col" class="ing">진행상태</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td class="num1">2</td>
						<td class="num2">00000000000</td>
						<td class="part">전화상담</td>
						<td class="obj">비데</td>
						<td class="reP">2017-07-11</td>
						<td class="reD">2017-07-11</td>
						<td class="accept">접수</td>
					</tr>
					<tr>
						<td class="num1">1</td>
						<td class="num2">00000000000</td>
						<td class="part">출장서비스</td>
						<td class="obj">비데</td>
						<td class="reP">2017-07-11</td>
						<td class="reD">2017-07-11</td>
						<td class="accept">접수</td>
					</tr>
				</tbody>
			</table>
		</div>

		<div class="boardBttm">
			<div id="pagingNavi" class="paging">
			<span class="first">	<a href="#">처음페이지 이동</a></span>
			<span class="prev"><a href="#">이전페이지 이동</a></span>
			<a class="current" >1</a>
			<a href="#">2</a>
			<a href="#">3</a>
			<a href="#">4</a>
			<a href="#">5</a>
			<a href="#">6</a>
			<a href="#">7</a>
			<a href="#">8</a>
			<a href="#">9</a>
			<a href="#">10</a>
			<span class="next"><a href="#">다음페이지 이동</a></span>
			<span class="last"><a href="#">마지막페이지 이동</a></span>
			</div>
		</div>
	</div>
	<!--// sub -->

</body>