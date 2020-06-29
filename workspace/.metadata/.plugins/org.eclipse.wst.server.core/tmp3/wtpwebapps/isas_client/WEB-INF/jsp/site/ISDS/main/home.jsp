<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<!DOCTYPE HTML>
<html>
<head>
	<link rel="stylesheet" href="${rootUri}common/css/main.css" />
	<script type="text/javascript">

		function init(){
			fnEvent();
		}

		function fnEvent(){
			noticeView = function() {
				document.noticeForm.action = "/ISDS/bbt/bbt00001V.do";
			   	document.noticeForm.submit();
			}

		}

	</script>
</head>
<body>
	<form id="noticeForm" name="noticeForm" method="post">
			<input type="hidden" id="boardSeq" name="boardSeq" value="${mainNoticeList[0].boardSeq}" />
			<input type="hidden" id="pageCd" name="pageCd" value="BBM00067" />
			<input type="hidden" id="boardMstCd" name="boardMstCd" value="BBM00067" />
			<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${mainNoticeList[0].boardCateSeq}" />
			<input type="hidden" id="page" name="page" value="1"/>
	</form>
	<section class="cont">
	<c:choose>
		<c:when test="${isLogIn}">
			<div class="login_msg_bx after">
				<strong>${loginVO.custNm}</strong>
				<ul class="list_Box">
					<li class="one"><a href="/ISDS/repair/inusRepairState.do">당일접수<em>${workCount.todayAsCount}</em>건</a></li>
					<li class="two"><a href="/ISDS/repair/inusRepairState.do">미처리<em>${workCount.readyAsCount}</em>건</a></li>
				</ul>
			</div>
			<!--// login_msg_bx.after -->

		</c:when>
		<c:otherwise>
			<section class="login_msg_bx">
				<p>반갑습니다.<strong>inus 서비스센터</strong>입니다.<br>로그인을 하셔야 서비스를 이용하실 수 있습니다.</p>
				<div class="mt15">
					<a href="/ISDS/mm/acessLogin.do" class="btn_login mAuto">로그인</a>
				</div>
			</section>
			<!-- // login_msg_bx -->
		</c:otherwise>
	</c:choose>

		<div class="notice_bx">
			<p class="txt"><a href="javascript:;" onclick="noticeView();">${mainNoticeList[0].boardTitle}</a></p>
			<a href="/ISDS/bbt/bbt00001.do?boardMstCd=BBM00067" class="btn_more">이누스 공지사항 더 보기</a>
		</div>
		<!--// notice_bx -->
		<div class="quick_bx">
			<ul>
				<li class="mq01"><a href="/ISDS/repair/inusRepairState.do"><span class="txt">A/S 접수현황</span></a></li>
				<li class="mq02"><a href="/ISDS/repair/inusRepairStateFinish.do"><span class="txt">A/S 완료현황</span></a></li>
				<li class="mq03"><a href="/ISDS/repair/inusInstallAccept.do"><span class="txt">온라인 설치접수내역</span></a></li>
				<li class="mq04"><a href="/ISDS/repair/inusHandling.do"><span class="txt">A/S 수리내역 조회</span></a></li>
			</ul>
		</div>
		<!--// quick_bx -->
	</section>
	<!-- <a href="callto:01234567890" class="callBt">상담전화연결</a> -->
</body>
</html>