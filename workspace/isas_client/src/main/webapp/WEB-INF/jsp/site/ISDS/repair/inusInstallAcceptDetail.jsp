<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<style type="text/css">
		.access .input_box > input[type="button"] {width:29%;}
		.btn02Type, .btn03Type{height:100%}
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


			$("#amtTy div.jqTransformSelectWrapper  a").click(function(){
				 var value = $(this).parent().index();
			     $("[name=amtTy]").attr('selectedIndex', value);
			     if($("[name=amtTy]").attr('selectedIndex', value).val() == 'AS215100'){
				     $("[name=repAmt]").val(15000);
				     $("[name=btAmt]").val(15000);
				 }else{
					 $("[name=repAmt]").val(0);
				     $("[name=btAmt]").val(0);
				 }
				 $.sumPlace();
			});


			$.sumPlace = function(){
				$.pordSum = 0;
				$("input[name=itmCid]:checked").each(function() {
					var keyCd = $(this).val();
					$.pordSum += parseInt(nvl($("input[name=csUp"+keyCd).val(),0))*parseInt(nvl($("input[name=ea"+keyCd).val(),1));
				});

				if($("[name=amtTy]").val() == "AS215100"){

					$("input[name=tot]").val($.pordSum);

					var sum = parseInt(nvl($.pordSum,0))+parseInt(nvl($("input[name=repAmt]").val(),0))+parseInt(nvl($("input[name=btAmt]").val(),0))+parseInt(nvl($("input[name=insAmt]").val(),0));
					$("input[name=tot2]").val(sum);
					$("input[name=tot3]").val(0);
				}else{
					$("input[name=tot]").val(0);
					$("input[name=tot2]").val(0);
					$("input[name=tot3]").val($.pordSum);

				}
			}

			$("input[type=number]").bind("keyup", function(){
				$.sumPlace();
			});

			 $('#pllistPut').click(function(e){
					$("#pllist").html("");
					var num = 1;
					$.pordSum = 0;
					$("input[name=itmCid]:checked").each(function() {
						var keyCd = $(this).val();
						$("#pllist").append("<tr>");
						$("#pllist").append("<td class=\"bunho\">"+num+"</td>");
						$("#pllist").append("<td class=\"code\">"+$(".itmCd"+keyCd).text()+"</td>");
						$("#pllist").append("<td class=\"name\">"+$(".itmNm"+keyCd).text()+"</td>");
						$("#pllist").append("<td class=\"unit\"><input type='number' class='ea' name='ea"+keyCd+"' value='1' maxlength='2'/></td>");
						$("#pllist").append("<td class=\"price\">"+setComma($("input[name=csUp"+keyCd).val())+"</td>");
						$("#pllist").append("</tr>");
						//$.pordSum += parseInt(nvl($("input[name=csUp"+keyCd).val(),0))*parseInt(nvl($("input[name=ea"+keyCd).val(),1));
					});

					$.sumPlace();

					$(".ea").unbind("click");
					$(".ea").unbind("focusout");
					$(".ea").bind("click", function(){
						$.thisEa = $(this).val();
						$(this).val("");

					});
					$(".ea").bind("focusout", function(){
						if($(this).val() == ""){
							$(this).val($.thisEa);
						}

						$.sumPlace();
					});


			      $('.layer').fadeOut();
			 });


			 $("#as1Bc div.jqTransformSelectWrapper  a").click(function(){


			     var value = $(this).parent().index();
			      $("[name=as1Bc]").attr('selectedIndex', value);

				if($("[name=as1Bc]").val() != ""){
			      fnAjax("ascodeList.action", {"asNo":'${param.asNo}',"subCd":$("[name=as1Bc]").val()},
							function(data, dataType){
			    	 			$("[name=as2Bc]").html("<option value=''>선택하세요!</option>");
								for (key in data) {
									$("[name=as2Bc]").append("<option value='"+data[key].baseCd+"'>"+data[key].title+"</option>");
								}

								fnfixSelect("[name=as2Bc]");
							},"POST"
					);
				}else{

				}

			      return false;
			   });

			 $("#partBc div.jqTransformSelectWrapper  a").click(function(){
			     var value = $(this).parent().index();
			      $("[name=partBc]").attr('selectedIndex', value);
			      if($("[name=partBc]").val() != ""){
				      fnAjax("getPartItemList.action", {"subCd":$("[name=partBc]").val()},
								function(data, dataType){
				    	 			$("[name=partBc2]").html("<option value=''>선택하세요!</option>");
									for (key in data) {
										$("[name=partBc2]").append("<option value='"+data[key].baseCd+"'>"+data[key].title+"</option>");
									}

									fnfixSelect("[name=partBc2]");
								},"POST"
						);
					}else{
//
					}

			      return false;
			   });


			 $("#okBtn").bind("click",function(){
					$("#signData").val($('#signature').jSignature('getData'));
					fnSubmit("workForm","수리내역을 등록");
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
	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:" onclick="location.href=document.referrer;" class="btn_prev">이전 화면</a>
			<h2>설치접수내역 상세</h2>
		</div>
		<!--// tit_bx -->
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">설치정보</div>
				<dl class="situ2">
					<dt>접수번호</dt>
					<dd>${installAcceptView.insNo}</dd>
				</dl>
				<dl class="situ2">
					<dt>접수일자</dt>
					<dd>${installAcceptView.insDt}</dd>
				</dl>
				<dl class="situ2">
					<dt>고객번호</dt>
					<dd>${installAcceptView.csNo}</dd>
				</dl>
				<dl class="situ2">
					<dt>고객명</dt>
					<dd>${installAcceptView.csNm}</dd>
				</dl>
				<dl class="situ2">
					<dt>핸드폰번호</dt>
					<dd><div class="call">${installAcceptView.hp}</div></dd>
				</dl>
				<dl class="situ2">
					<dt>집전화</dt>
					<dd><div class="call">${installAcceptView.phone}</div></dd>
				</dl>
				<dl class="situ2">
					<dt>우편번호</dt>
					<dd>${installAcceptView.zipCd}</dd>
				</dl>
				<dl class="situ2">
					<dt>주소</dt>
					<dd class="lheight">${installAcceptView.addr} ${installAcceptView.addrS}</dd>
				</dl>
				<dl class="situ2 bdn">
					<dt>비고</dt>
					<dd class="lheight">${installAcceptView.note}</dd>
				</dl>
			</div>
		</div>
		<!--// ing_bx(설치정보) -->
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">접수정보</div>
				<dl class="situ2">
					<dt>품목코드</dt>
					<dd>${installAcceptView.itmCd} / ${installAcceptView.itmNm}</dd>
				</dl>
				<dl class="situ2">
					<dt>접수코드</dt>
					<dd>${installAcceptView.insCd} / ${installAcceptView.insNm}</dd>
				</dl>
				<dl class="situ2">
					<dt>설치비용</dt>
					<dd><span class="validation[number]">${installAcceptView.insAmt}</span>원</dd>
				</dl>
				<dl class="situ2 bdn">
					<dt>수량</dt>
					<dd>${installAcceptView.qty}개</dd>
				</dl>
			</div>
		</div>

		<!--// ing_bx(접수정보) -->


		<div class="ing_bx view">
			<div class="box">
				<div class="tit">설치등록</div>
				<dl class="situ2">
					<dt>제조번호</dt>
					<dd>${installAcceptView.insNumber}</dd>
				</dl>
				<dl class="situ2">
					<dt>제조년월</dt>
					<dd>${installAcceptView.insYm}</dd>
				</dl>
				<dl class="situ2">
					<dt>처리일</dt>
					<dd>${installAcceptView.insYmd}</dd>
				</dl>
				<dl class="situ2">
					<dt>진행상태</dt>
					<dd>${installAcceptView.insStateNm}</dd>
				</dl>
				<dl class="situ2 bdn">
					<dt>비고</dt>
					<dd>${installAcceptView.rmks}</dd>
				</dl>
				<a href="inusInstallAcceptRegister.do?insNo=${installAcceptView.insNo}" class="btn line pop">설치등록 <c:choose><c:when test="${empty installAcceptView.insYmd}">입력</c:when><c:otherwise>수정</c:otherwise></c:choose></a>
			</div>
		</div>
		<!--// ing_bx(설치등록) -->

		<div class="ing_bx view">
			<div class="box">
				<div class="tit">사진등록</div>
				<div class="pd10">
					<div class="photo_bx">
						<c:forEach items="${fileList}" var="fileList" varStatus="status">
							<div class="file_add_img">
								<div class="photo" style="width:47%;height:125px;"><img src="${fileList.attchFilePath}"/></div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<!--// ing_bx(사진등록) -->
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">고객서명</div>
				<div class="pd10">
					<div class="sign_bx"><c:if test="${not empty asSign.asSign}"><img src="${asSign.asSign}" /></c:if></div>
				</div>
			</div>
		</div>
		<!--// ing_bx(고객서명) -->
	</section>
	<!--// sub -->
	<!-- <a href="callto:01234567890" class="callBt">상담전화연결</a> -->

</body>



