<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--

		function formCheck() {

				var obj=document.f;
				if($("input:checkbox[name='agree01']").is(":checked") != true){
					alert('유의사항 및 탈퇴동의 후 탈퇴 할 수 있습니다');
					$("input:checkbox[name='agree01']").focus();
					return;
				}
				if(f.mbrPw.value == ""){
					alert('비밀번호를 입력하세요');
					f.mbrPw.focus();
					return;
				}
				if(fnValidation()){
					layer_open('layer');
				}
		}

		function do_ok() {

			var obj=document.f;
			obj.chk_info.value="y";
			obj.action="memberOut.action";
			obj.submit();
		}

	//-->
	</script>
</head>
<body>

<!--=============== #CONTAINER ===============-->
<div id="container" class="user">
  	<!--=============== #CONNTENTS ===============-->

	<div id="contents" class="inner">
		<h3><img src="/common/images/tit/h3_tit8_2.png" alt="회원탈퇴"></h3>

		<div class="my_info">
			<div class="text_box">
				<span><em>${userMap.mbrNm}</em>님 안녕하세요!<br />듀오락과 함께 좋은 하루되세요.</span>
			</div>

			<ul class="info_box">
				<!--
				<li class="col1">
					<span>
						<span>보유 적립금</span>
						<span><em>0</em>원</span>
					</span>
				</li>
				-->
				<li class="col2">
					<span>
						<span>보유 포인트</span>
						<span><em>${userMap.prodPtOutScore}</em>점</span>
					</span>
				</li>
				<li class="col3">
					<span>
						<span>보유 보유 쿠폰</span>
						<span><em>${userMap.copnCount}</em>장</span>
					</span>
				</li>
			</ul>
		</div>

		<div class="secede">
			<div class="info_cont">
				<strong class="title_text">유의사항 및 탈퇴동의</strong>
				<div class="info_text">
					<span>주문 진행중인 내역이 있을 경우 회원탈퇴가 불가능합니다.</span>
					전자 상거래 등에서의 소비자 보호에 관한 법률 제 6조(거래기록의 보전 등)에 의거, 주문정보는 5년간 데이터로만 보관하며(다른 용도로 절대사용불가) 이후 파기되오니 이점 유의하여 주시기 바랍니다.<br />
					회원탈퇴 시 고객님 ID에 등록된 적립금 및 포인트는 상실되며, 재가입후에도 복구되지 않습니다.
				</div>
				<input type="checkbox" name="agree01" id="yes01" value="1" /><label for="yes01">안내사항을 모두 확인하였으며, 데이터 복구가 불가함에 동의합니다.</label>
			</div>

			<form name="f" method="post" >
			<input type="hidden" name="chk_info" value="n">
			<div class="cont">
				<strong class="title_text">탈퇴사유를 남겨주시면 보완하여 더 나은 듀오락으로 찾아뵙겠습니다.</strong>
				<table class="tsytle" summary="가족인원 및 가족구성">
					<tbody>
						<tr>
							<th>아이디</th>
							<td>${mbr.mbrId}</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>${mbr.mbrNm}</td>
						</tr>
						<tr>
							<th>비밀번호</th>
							<td><input type="password" name="mbrPw" id="mbrPw" maxlength="20" value=""></td>
						</tr>
						<tr>
							<th>탈퇴사유</th>
							<td class="secede_choice">
								<span>쎌바이오텍 쇼핑몰을 이용하던 중 불편하셨던 점이나, 회원탈퇴 사유를 선택해 주시기 바랍니다 (중복선택가능)</span>
								<ul>
									<li><input type="checkbox" name="contMbr" id="leavel_id" title="탈퇴사유" class="validation[groupChoose:'(contMbr)']" value="아이디 변경"/><label for="leavel_id">아이디 변경</label></li>
									<li><input type="checkbox" name="contMbr" id="leave_free" title="탈퇴사유" class="validation[groupChoose:'(contMbr)']" value="무료회원 가입 후, 실질적 혜택 부족"/><label for="leave_free">무료회원 가입 후, 실질적 혜택 부족</label></li>
									<li><input type="checkbox" name="contMbr" id="leave_site" title="탈퇴사유" class="validation[groupChoose:'(contMbr)']" value="사이트 사용이 어려움"/><label for="leave_site">사이트 사용이 어려움</label></li>
									<li><input type="checkbox" name="contMbr" id="leave_nouse" title="탈퇴사유" class="validation[groupChoose:'(contMbr)']" value="자주 사용하지 않음"/><label for="leave_nouse">자주 사용하지 않음</label></li>
									<li><input type="checkbox" name="contMbr" id="leave_dissatis" title="탈퇴사유" class="validation[groupChoose:'(contMbr)']" value="서비스 불만족"/><label for="leave_dissatis">서비스 불만족</label></li>
									<li><input type="checkbox" name="contMbr" id="leave_prize " title="탈퇴사유" class="validation[groupChoose:'(contMbr)']" value="상품 불만"/><label for="leave_prize">상품 불만</label></li>
									<li><input type="checkbox" name="contMbr" id="leave_swap" title="탈퇴사유" class="validation[groupChoose:'(contMbr)']" value="교환,환불,배송 등의 불만"/><label for="leave_swap">교환,환불,배송 등의 불만</label></li>
									<li><input type="checkbox" name="contMbr" id="leave_spill" title="탈퇴사유" class="validation[groupChoose:'(contMbr)']" value="개인정보 유출 우려"/><label for="leave_spill">개인정보 유출 우려</label></li>
									<li class="etc">
									<label for="leave_reason">※&nbsp;기타(상세한 탈퇴사유를 입력해 주세요. 서비스 개선에 도움이 됩니다.)</label></li>
									<li><div tabindex="0"><textarea rows="5" class="validation[groupChoose:'(contMbr)']" title="탈퇴사유" name="mbrContDt" id="mbrContDt"></textarea></div></li>
								</ul>
							</td>
						</tr>
					</tbody>
				</table>
				<div class="layer">
					<div class="bg"></div>
					<div id="layer" class="pop-layer">
						<div class="pop-container">
							<div class="pop-cont">
								<div class="title">
									<strong>회원탈퇴</strong>
									<a href="#" class="cbtn">Close</a>
								</div>
								<div class="pcont">
									<span class="secede_text">
										탈퇴하시면 고객님의<br /><em>모든 정보가 완전히 삭제</em>됩니다.<br />
										정말로 탈퇴하시겠습니까?
									</span>
									<p class="popup_btnbox">
										<a href="#" onclick="do_ok();"><img src="${rootUri}common/img/icon/secede_btn1.png" alt="예"></a>
										<a href="#" onclick="$('.cbtn').trigger('click');"><img src="${rootUri}common/img/icon/secede_btn2.png" alt="아니오"></a>
									</p>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
			</form>
			<div class="btn_wrap">
				<a href="#" onclick="formCheck();" class="btn01">회원탈퇴</a>
				<a class="btn01_1" href="/ISDS/user/mypage.do" >취소</a>
			</div>
		</div>
	</div>
	<!--=============== #CONNTENTS ===============-->
</div>
<!--=============== #CONTAINER ===============-->

</body>