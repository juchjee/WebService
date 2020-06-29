<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
<script type="text/javascript">
	$(document).ready(function() {
		var obj = $(".gnb > ul >li > a")[0];
		$(obj).addClass("on");
	});


</script>
</head>
	<div class="member_detail_con">
		<h2>회원 정보</h2>
		<div class="pageContScroll_st2">
		<!-- <div class="align_area">
			<div class="left">
				<h3>회원 정보</h3>
			</div>
		</div> -->
		<!-- // align_area -->
		<div class="table_type2">
			<table>
				<caption>아이디, 성명, 휴대폰번호, 전화번호, 주소, 이메일, 회원가입일, 최근로그인 으로 구성된 회원 정보에 대한 상세 테이블 입니다.</caption>
				<colgroup>
					<col style="width:20%;" />
					<col style="width:80%;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">아이디</th>
						<td>
							${userInfo.mbrId}
						</td>
					</tr>
					<tr>
						<th scope="row">성명</th>
						<td>
							${userInfo.mbrNm}
						</td>
					</tr>
					<tr>
						<th scope="row">휴대폰번호</th>
						<td>
							${userInfo.mbrMobile}
						</td>
					<tr>
						<th scope="row">전화번호</th>
						<td>
							${userInfo.mbrPhone}
						</td>
					</tr>
					<tr>
						<th scope="row">주소</th>
						<td colspan="3">
							${userInfo.mbrAddr}&nbsp;${userInfo.mbrAddrDtl}
						</td>
					</tr>
					<tr>
						<th scope="row">이메일</th>
						<td>
							${userInfo.mbrEmail}
						</td>
					</tr>
					<tr>
						<th scope="row">회원가입일</th>
						<td>
							${userInfo.mbrJoinDt}
						</td>
					</tr>
					<tr>
						<th scope="row">최근로그인</th>
						<td>
							${userInfo.mbrLoginDt}
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		</div> <!-- // pageContScroll_st2 -->
	</div>	<!-- // member_detail_con -->