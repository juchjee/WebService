<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">

		function init(){
			fnEvent();
		}

		function fnEvent(){
			$("#listBtn").bind("click",function(){
				var param = "";
				if("${param.page}" != ""){
					 param = "&page=${page}";
				}
				location.href="bbt00001.do?boardMstCd=${boardMstCd}"+param;
			});

		}

	</script>
</head>
<body>


	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:" onclick="location.href=document.referrer;" class="btn_prev">이전 화면</a>
			<h2>공지사항 상세</h2>
		</div>
		<!--// tit_bx -->
		<div class="ntc_detail">
			<div class="ntc_top">
				<div class="tit">
					<p>${noticeView.boardTitle}</p>
					<ul>
						<li>등록일 ${noticeView.regDt}</li>
					</ul>
				</div>
			</div>
			<!--// nct_top -->
			<div class="ntc_cont">
				<p id="boardCont" class="txt">${noticeView.boardCont}</p>
				<script type="text/javascript">
	            	$("#boardCont").html(decodeTag($("#boardCont").html()));
		        </script>
			</div>
			<!--// nct_cont -->
			<div class="btnWrap pd15">
				<a href="javascript:" class="btn gray" id="listBtn">목록</a>
			</div>
		</div>
		<!--// nct_detail -->
	</section>
	<!--// sub -->

</body>