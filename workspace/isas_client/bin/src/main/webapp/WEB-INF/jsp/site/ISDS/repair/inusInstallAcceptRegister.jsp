<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<style>
#ui-datepicker-div{ z-index:1000 }
table.ui-datepicker-calendar { display:none; }

.ea{width:20px;text-align:right;padding:3px;}
</style>
<!--[if lt IE 9]>
	<script type="text/javascript" src="${rootUri}common/js/flashcanvas.js"></script>
	<![endif]-->
	<script src="${rootUri}common/js/jSignature.min.js"></script>

	<style type="text/css">
		.access .input_box > input[type="button"] {width:29%;}
		.btn02Type, .btn03Type{height:100%}
	</style>

	<script type="text/javascript" defer="defer">
	<!--
		function init(){
			fnEvent();
			fnDataSetting();
		}

		function fnEvent(){

			$("#signCls").bind("click", function(){
				$("#signature").jSignature("clear");
			});



			$.idx = 0;

			$(".more_btn").bind("click", function(){
				$("#take-picture"+$.idx).click();
				if($.idx == 0){
					$.idx = 1;
				}else{
					$.idx = 0;
				}
			});

			$("input[type=number]").bind("click", function(){
				$.thisNum = $(this).val();
				$(this).val("");
			});
			$("input[type=number]").bind("focusout", function(){
				if($(this).val() == ""){
					$(this).val($.thisNum);
				}
			});




			 $("#okBtn").bind("click",function(){
					$("#signData").val($('#signature').jSignature('getData'));
					fnSubmit("workForm","설치접수내역을 등록");
			});
		}


		function fnDataSetting(){
	        $("#signature").jSignature({width:"100%",height:"158px"});
		}
		function getThumbnailPrivew(html, $target) {
		    if (html.files && html.files[0]) {
		        var reader = new FileReader();
		        reader.onload = function (e) {
		            $target.attr("src" ,e.target.result);
		        }
		        reader.readAsDataURL(html.files[0]);
		    }
		}
	//-->
</script>


</head>
<body>
	<form id="workForm" name="workForm" action="installSave.action" method="post" enctype="multipart/form-data">
	<input type="hidden" name="insNo" id="insNo" class="validation[required]" value="${param.insNo}" />
	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:" onclick="window.history.go(-1); return false;" class="btn_prev">이전 화면</a>
			<h2>설치접수내역 등록</h2>
		</div>
		<!--// tit_bx -->
		<div class="ing_bx">
			<div class="box">
				<div class="tit">설치등록</div>
								<dl class="type01">
									<dt>제조번호</dt>
									<dd>
											<div class="input_txt_bx">
												<input type="text" name="insNumber" id="insNumber" value="${installAcceptView.insNumber}" class=""/>
											</div>
									</dd>
									<dt>제조년월</dt>
									<dd>
										<div class="calender_bx">
											<div class="cal_input">
												<input type="text" name="insYm" id="insYm"  onclick="f_datepickerM(this);"  class="validation[required]" value="${installAcceptView.insYm}" title="제조년월" />
											</div>
										</div>
									</dd>
									<dt>처리일</dt>
									<dd>
										<div class="calender_bx">
											<div class="cal_input">
												<input type="text" name="insYmd" id="insYmd" class=""  onclick="f_datepicker(this);" value="${installAcceptView.insYmd}"/>
											</div>
										</div>
									</dd>
									<dt>진행상태</dt>
									<dd>
										<div class="select_guide">
											<select class="m_select select01" name="insStateCd" id="insStateCd">
												<option value="AS410100" <c:if test="${installAcceptView.insStateCd eq 'AS204100'}">selected</c:if>>접수</option>
												<option value="AS410200" <c:if test="${installAcceptView.insStateCd eq 'AS410200'}">selected</c:if>>대기</option>
												<option value="AS410300" <c:if test="${installAcceptView.insStateCd eq 'AS410300'}">selected</c:if>>완료</option>
												<option value="AS410400" <c:if test="${installAcceptView.insStateCd eq 'AS410400'}">selected</c:if>>취소</option>
												<option value="AS410500" <c:if test="${installAcceptView.insStateCd eq 'AS410500'}">selected</c:if>>정산</option>
												<option value="AS410600" <c:if test="${installAcceptView.insStateCd eq 'AS410600'}">selected</c:if>>취소(환경적)</option>
											</select><!-- m_select -->
										</div><!-- select_guide -->
									</dd>
									<dt>비고</dt>
									<dd>
										<div class="input_txt_bx">
											<input type="text" name="rmks" id="rmks" value="${installAcceptView.rmks}" />
										</div>
									</dd>
								</dl>
			</div>
		</div>
		<c:if test="${empty installAcceptView.insYmd}">
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">사진등록</div>
				<div class="pd10">
					<div class="photo_bx">
						<div class="photo"><img src="about:blank" alt="" id="show-picture0"></div>
						<div class="photo last"><img src="about:blank" alt="" id="show-picture1"></div>
						<a href="javascript:;" class="more_btn">사진 더 등록하기</a>
					</div>
	                    <input type="file" name="dtlImgPath" id="take-picture0"  accept="image/*" onchange="getThumbnailPrivew(this,$('#show-picture0'))" style="display:none;">
	                    <input type="file" name="dtlImgPath" id="take-picture1"  accept="image/*" onchange="getThumbnailPrivew(this,$('#show-picture1'))" style="display:none;">
				</div>
			</div>
		</div>
		<!--// ing_bx(사진등록) -->

		<input type="hidden" name="signData" id="signData" class="validation[required]" value="" />
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">고객서명</div>
				<div class="pd10">
				<div id="signature" class="sign_bx" ></div>
					<div class="btnWrap wide">
						<a href="javascript:;" id="signCls" class="btn gray">서명 삭제</a>
					</div>
				</div>
			</div>
		</div>
		<!--// ing_bx(고객서명) -->
		</c:if>

		<div class="btnBox pd15">
			<a href="javascript:;" id="okBtn" class="btn">저장</a>
		</div>
	</section>
	<!--// sub -->
	<!-- <a href="callto:01234567890" class="callBt">상담전화연결</a> -->

	</form>
</body>