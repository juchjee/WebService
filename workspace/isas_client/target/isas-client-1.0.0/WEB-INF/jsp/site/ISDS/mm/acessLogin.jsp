<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<style type="text/css">
		.access .input_box > input[type="button"] {width:29%;}
		.btn02Type, .btn03Type{height:100%}
	</style>
	<script type="text/javascript" defer="defer">
	<!--
		function init(){
			fnEvent();
		}

		function fnEvent(){
			$.agencyLogin = function(drvNo,custCd){
				$("#drvNo").val(drvNo);
				$("#custCd").val(custCd);
				$("#workForm").submit();
			}


			$("div.jqTransformSelectWrapper ul li a").click(function(){



			      var value = $(this).parent().index();
			      $("[name=custCdList]").attr('selectedIndex', value);
				if($("[name=custCdList]").val() != ""){
			      fnAjax("/ISDS/mm/ASZ130Ajax.action", {"custCd":$("[name=custCdList]").val()},
							function(data, dataType){
		    			    	$("#custTit").text($("[name=custCdList] option:selected").text());
			    	  			$("#asz130body").html("");
								for (key in data) {
									$("#asz130body").append("<tr><td>"+data[key].drvNo+"</td><td>"+data[key].drvNm+"</td><td><a href='javascript:;' class='btn blue' onclick=\"$.agencyLogin('"+data[key].drvNo+"','"+data[key].custCd+"');\">선택</a></td></tr>");
								}

							},"POST"
					);
				}else{
					$("#custTit").text("");
					$("#asz130body").html("");
				}
			      return false;
			   });

			 $(".layerBtn").bind("click",function(){
					//fnSubmit("workForm","예약신청");


					if(fnValidation()){
						 fnAjax("/ISDS/mm/agencyLoginChk.action", {"asId":$("[name=asId]").val(),"asPw":$("[name=asPw]").val()},
									function(data, dataType){
							 			if(data.loginFlag == 'Y'){
					    			    	$("#custTit").text(data.custNm);
						    	  			$("#asz130body").html("");

						    	  			var agencyList = JSON.parse(data.agencyList);
											for (key in agencyList) {
												$("#asz130body").append("<tr><td>"+agencyList[key].drvNo+"</td><td>"+agencyList[key].drvNm+"</td><td><a href='javascript:;' class='btn blue' onclick=\"$.agencyLogin('"+agencyList[key].drvNo+"','"+agencyList[key].custCd+"');\">선택</a></td></tr>");
											}
											layerPopUp('layer1'); return false;
							 			}else if(data.loginFlag == 'N'){
							 				alert("아이디 또는 비밀번호가 잘못되었습니다.");
							 				return;
							 			}else{
							 				return;
							 			}
									},"POST"
							);
					}

				});

		}
		
		function keydown(seq) {
			var keycode = '';
			if(window.event) keycode = window.event.keyCode;
			if(keycode == 13){
				if(seq == 1){
					//$('#workForm').submit();
					if(fnValidation()){
						 fnAjax("/ISDS/mm/agencyLoginChk.action", {"asId":$("[name=asId]").val(),"asPw":$("[name=asPw]").val()},
									function(data, dataType){
							 			if(data.loginFlag == 'Y'){
					    			    	$("#custTit").text(data.custNm);
						    	  			$("#asz130body").html("");

						    	  			var agencyList = JSON.parse(data.agencyList);
											for (key in agencyList) {
												$("#asz130body").append("<tr><td>"+agencyList[key].drvNo+"</td><td>"+agencyList[key].drvNm+"</td><td><a href='javascript:;' class='btn blue' onclick=\"$.agencyLogin('"+agencyList[key].drvNo+"','"+agencyList[key].custCd+"');\">선택</a></td></tr>");
											}
											layerPopUp('layer1'); return false;
							 			}else if(data.loginFlag == 'N'){
							 				alert("아이디 또는 비밀번호가 잘못되었습니다.");
							 				return;
							 			}else{
							 				return;
							 			}
									},"POST"
							);
					}
				}
			}
			return false;
		}

	//-->
</script>

</head>
<body>
	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:" onclick="location.href=document.referrer;" class="btn_prev">이전 화면</a>
			<h2>로그인</h2>
		</div>
		<!--// tit_bx -->
		<div class="intro">
			<div class="logo">
				<strong><span class="blind">inus</span>서비스센터</strong>
				<p>대리점/기사용</p>
			</div>
			<div class="login_bx">
				<dl class="usr_id">
					<dt><label for="userID">이름</label></dt>
					<dd><input type="text" name="asId" placeholder="아이디" class="usrID validation[required]" id="userID" onkeydown="keydown(1);"/></dd>
				</dl>
<!-- 				// user ID -->
				<dl class="usr_pw mt15">
					<dt><label for="userPW">비밀번호</label></dt>
					<dd><input type="password" name="asPw" placeholder="비밀번호" class="usrPW validation[required]" id="userPW" onkeydown="keydown(1);"/></dd>
				</dl>
<!-- 				// user PW -->
				<div class="mt15">
					<a href="javascript:;" class="btn_login layerBtn">로그인</a>
				</div>
			</div>
		</div>
		<!--// intro -->
	</section>
	<!--// sub -->
	<!-- <a href="callto:01234567890" class="callBt">상담전화연결</a> -->
	<div class="layer">
		<div class="bg"></div>
		<div id="layer1" class="pop-layer">
			<div class="pop-container">
				<div class="pop-conts">
					<div class="layer_top">
						<h1>기사리스트</h1>
					</div>
					<div class="layer_body">
						<h2 id="custTit" class="tit"></h2>
						<div class="layer_tblType01 mt10">
							<form id="workForm" name="workForm" action="agencyLogin.action" method="post">
								<input type="hidden" name="drvNo" id="drvNo" />
								<input type="hidden" name="custCd" id="custCd" />

								<table>
									<caption></caption>
									<thead>
										<tr>
											<th scope="col">A/S<br>기사코드</th>
											<th scope="col">A/S<br>기사명</th>
											<th scope="col">선택</th>
										</tr>
									</thead>
									<tbody id="asz130body">

									</tbody>
								</table>
							</form>
						</div>
					</div>
					<a href="javascript:;" class="close_btn">Close</a>
				</div>
				<!--// pop_conts -->
			</div>
		</div>
		<!--// pop-layer -->
	</div>
</body>