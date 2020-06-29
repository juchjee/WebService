<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<style>
#ui-datepicker-div{ z-index:1000 }
/* table.ui-datepicker-calendar { display:none; } */

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

		function init(){
			fnEvent();
			fnDataSetting();

			/* 방문일자 Default today */
// 			if($('#actDt').val().length <= 0 || $('#actDt').val() == "" || $('#actDt').val() == "0"){
				$('#actDt').val('${iConstant.nowYmd()}');
// 			}

		}

		function fnEvent(){
			$.numberIn = function (){
				$("input[class*=validation]").each(function(index, value){
					if($(this).attr("class").indexOf("number") > -1){
						$(this).val(removeComma($(this).val()));
					}
				});
			}

			$.numberOut = function (){
				$("input[class*=validation]").each(function(index, value){
					if($(this).attr("class").indexOf("number") > -1){
						$(this).val(setComma($(this).val()));
					}
				});
			}

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

			$("input[class*=number]").bind("click", function(){
				if($(this).attr("readonly") != "readonly"){
					$.thisNum = $(this).val();
					$(this).val("");
				}
			});
			$("input[class*=number]").bind("focusout", function(){
				if($(this).attr("readonly") != "readonly"){
					if($(this).val() == ""){
						$(this).val($.thisNum);
					}
				}
			});


			$("#amtTy div.jqTransformSelectWrapper  a").click(function(){

				$.numberIn();
				 var value = $(this).parent().index();
				 
			     $("[name=amtTy]").attr('selectedIndex', value);
			     if($("[name=amtTy]").attr('selectedIndex', value).val() == 'AS215100'){
			    	 
			    	 if (value == 0) {
					     $("[name=repAmt]").val(0);
				    	 $("[name=btAmt]").val(0);
				    	 
				    	// 지역출장비 추가 - ksh. 2018.06.11
				    	 $("[name=regAmt]").val(0);		    		 
			    	 }
			    	 else {
			    		 // 블렌더 추가 (SDH0818) - ksh 2018.06.12
			    		 var itmGubun = '${itmGubun}';
			    		 
			    		 var btAmt = ${asz120Pay};
			    		 
					     if (value == 1) {
					    	 if (itmGubun == 'SDH0818') {
					    		 $("[name=repAmt]").val(0);
							     $("[name=btAmt]").val(btAmt);
							     $("[name=regAmt]").val(0);
					    	 }
					    	 else {
					    		 $("[name=repAmt]").val(11000);
							     $("[name=btAmt]").val(11000);
							     $("[name=regAmt]").val(0);
					    	 }
					     }
					     else {
				    		 $("[name=repAmt]").val(0);
					    	 $("[name=btAmt]").val(0);
					    	 $("[name=regAmt]").val(0);
					     }
			    	 }
			    	 
				     /*
				     $("[name=repAmt]").attr("readonly",true);
				     $("[name=btAmt]").attr("readonly",true);
				     $("[name=insAmt]").attr("readonly",true);

				     $("[name=repAmt]").css("background","#eee");
				     $("[name=btAmt]").css("background","#eee");
				     $("[name=insAmt]").css("background","#eee");
 					 */
				 }else{
					 var btAmt = ${asz120Pay};
					 
					 if (value == 0) {
					     $("[name=repAmt]").val(0);
				    	 $("[name=btAmt]").val(0);
				    	 $("[name=regAmt]").val(0);
					 }
					 else {
			    		 // 블렌더 추가 (SDH0818) - ksh 2018.06.12
			    		 var itmGubun = '${itmGubun}';

						 if(value == 1){
					    	 if (itmGubun == 'SDH0818') {
					    		 $("[name=repAmt]").val(0);
							     $("[name=btAmt]").val(btAmt);
							     $("[name=regAmt]").val(0);
					    	 }
					    	 else {
					    		 $("[name=repAmt]").val(11000);
							     $("[name=btAmt]").val(11000);
							     $("[name=regAmt]").val(0);
					    	 }
					     }else{
							 $("[name=repAmt]").val(0);
					    	 $("[name=btAmt]").val(0);
					    	 //$("[name=btAmt]").val(btAmt);
					    	 
					    	 $("[name=regAmt]").val(btAmt);
					     }
					 }
					 
				     /*
				     $("[name=repAmt]").attr("readonly",false);
				     $("[name=btAmt]").attr("readonly",false);
				     $("[name=insAmt]").attr("readonly",false);
				     $("[name=repAmt]").css("background","#ffffff");
				     $("[name=btAmt]").css("background","#ffffff");
				     $("[name=insAmt]").css("background","#ffffff");
				     */
				 }
				 $.sumPlace();

				 $.numberOut();
			});


			$.sumPlace = function(){
				$.numberIn();
				$.pordSum = 0;
				$("input[name=itmCid]:checked").each(function() {
					var keyCd = $(this).val();
					$.pordSum += parseInt(nvl($("input[name=csUp"+keyCd).val(),0))*parseInt(nvl($("input[name=ea"+keyCd).val(),1));
				});

				if($("[name=amtTy]").val() == "AS215100"){

					var sum = parseInt(nvl($.pordSum,0))+parseInt(nvl($("input[name=repAmt]").val(),0))+parseInt(nvl($("input[name=btAmt]").val(),0))+parseInt(nvl($("input[name=insAmt]").val(),0));
					$("input[name=tot]").val($.pordSum);

					$("input[name=tot2]").val(sum);
					$("input[name=tot3]").val(0);
				}else{
					//var sum = parseInt(nvl($("input[name=repAmt]").val(),0))+parseInt(nvl($("input[name=btAmt]").val(),0))+parseInt(nvl($("input[name=insAmt]").val(),0));
					var sum = parseInt(nvl($("input[name=repAmt]").val(),0))+parseInt(nvl($("input[name=regAmt]").val(),0))+parseInt(nvl($("input[name=insAmt]").val(),0));
					$("input[name=tot]").val(0);
					$("input[name=tot2]").val(sum);
					$("input[name=tot3]").val($.pordSum);

				}
				$.numberOut();
			}

			$("input[class*=number]").bind("keyup", function(){
				$.sumPlace();
			});

			 $('#pllistPut').click(function(e){
					$("#pllist").html("");
					var num = 1;
					$.pordSum = 0;
					$("input[name=itmCid]:checked").each(function() {
						var keyCd = $(this).val();
						$("#pllist").append("<tr>");
						$("#pllist").append("<td class='bunho'>"+num+"</td>");
						$("#pllist").append("<td class='code'>"+$(".itmCd"+keyCd).text()+"</td>");
						$("#pllist").append("<td class='name'>"+$(".itmNm"+keyCd).text()+"</td>");
						$("#pllist").append("<td class='unit'><input type='number' class='ea' name='ea"+keyCd+"' value='1' maxlength='2'/></td>");
						$("#pllist").append("<td class='price'>"+setComma($("input[name=csUp"+keyCd).val())+"</td>");
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
			      /*
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
			      */

			      return false;
			   });
			 
			 $("#modelList").on('focusout', function (event){
				 
				 var item = $("#modelList").jqxComboBox('getSelectedItem');
				 
				 if(item && item.value){
					 fnAjax("getModelPartItemList.action", {"itmId":item.value},
						function(data, dataType){
		    	 			
						 	$("#plTable > tbody").empty();
						 	
						 	if( data && data.length > 0 ){
						 		for(var i=0; i < data.length; i++){
						 			
						 			$('#plTable tbody').append('<tr><td class="choose" style="min-width:50px;">' 
									+ '<span class="chkbox no_txt">'
									+ '<label class="label_txt">'
									+ '<input type="checkbox" name="itmCid" value="'+ data[i].itmCid +'"><span class="blind"></span>'
									+ '</label>'
									+ '</span>'
									+ '<input type="hidden" name="csUp'+ data[i].itmCid +'" value="'+ data[i].csUp +'">'
									+ '<input type="hidden" name="up'+data[i].itmCid +'" value="' +data[i].up +'">'
									+ '</td>'
								    + '<td class="code itmCd'+ data[i].itmCid +'" >'+ data[i].itmCd +'</td>'
								    + '<td class="name itmNm'+ data[i].itmCid +'" >'+ data[i].itmNm +'</td></tr>');
						 		}
						 		
								$( ".chkbox" ).on( "click", function() {
									if( $( this ).find('input').is(':checked')){
										$( this ).addClass('on');
									}else{
										$( this ).removeClass('on');
									}
								});
						 	}
							
						},"POST"
					);
				 }
 			 }); 


			 $("#okBtn").bind("click",function(){
					$("#signData").val($('#signature').jSignature('getData'));

					var item = $("#modelList").jqxComboBox('getSelectedItem');
					if(item == null){
						alert("모델을 선택해주세요!");
						$("#model").val("");
						return;
					}else{
						$("#model").val(item.value);
					}

					fnSubmit("workForm","수리내역을 등록");
			});

		}


		function fnDataSetting(){
	        $("#signature").jSignature({width:"100%",height:"158px"});


	        var url = "modelList.action?asNo=${param.asNo}";
            // prepare the data
            var source =
            {
                datatype: "json",
                datafields: [
                    { name: 'label' },
                    { name: 'value' }
                ],
                url: url,
                async: false
            };
            var dataAdapter = new $.jqx.dataAdapter(source);
            // Create a jqxComboBox
            $("#modelList").jqxComboBox({ selectedIndex: -1, source: dataAdapter, displayMember: "label", valueMember: "value", width: 300, height: 36,	promptText: "모델을 선택하세요!"});

            var item = $("#modelList").jqxComboBox('getItemByValue', '${param.itmId}');
            $("#modelList").jqxComboBox('selectItem', '${param.itmId}');

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

</script>


</head>
<body>
	<form id="workForm" name="workForm" action="repairSave.action" method="post" enctype="multipart/form-data">
	<input type="hidden" name="asNo" id="asNo" class="validation[required]" value="${param.asNo}" />
	<input type="hidden" name="oemBc" id="oemBc" class="validation[required]" value="AS100100" />
	<input type="hidden" name="signData" id="signData" class="validation[required]" value="" />
	<input type="hidden" name="statBc" value="AS204300">
	<input type="hidden" id="model" name="model" value=""/>
	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:" onclick="window.history.go(-1); return false;" class="btn_prev">이전 화면</a>
			<h2>A/S 접수현황 등록</h2>
		</div>
		<!--// tit_bx -->
		<div class="ing_bx">
			<div class="box">
				<div class="tit">A/S 접수현황 등록</div>
				<dl class="type01">
					<dt>방문일자</dt>
					<dd>
						<div class="calender_bx">
							<div class="cal_input ty1">
								<input type="text" name="actDt" id="actDt"  onclick="$('table.ui-datepicker-calendar').show();f_datepicker(this);" value="${actDt}" />
							</div>
						</div>
					</dd>
<!-- 					<dt>처리일자</dt> -->
<!-- 					<dd> -->
<!-- 						<div class="calender_bx"> -->
<!-- 							<div class="cal_input"> -->
<!-- 								<input type="text" name="regDt" id="regDt"  onclick="f_datepicker(this);" /> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</dd> -->
					<dt>제조번호</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" name="lotNo" id="lotNo" class="validation[required]" title="제조번호" /> <!-- 2017-09-06 수정 -->
						</div>
					</dd>
<!-- 					<dt>제조년월</dt> -->
<!-- 					<dd> -->
<!-- 						<div class="calender_bx"> -->
<!-- 							<div class="cal_input"> -->
<!-- 								<input type="text" name="lotDt" id="lotDt"  onclick="f_datepicker(this);" /> -->
<!-- 							</div> -->
<!-- 						</div> -->
<!-- 					</dd> -->
					<dt>구입년월</dt>
					<dd>
						<div class="calender_bx">
							<div class="cal_input ty2">
								<input type="text" name="buyDt" id="buyDt"  onclick="f_datepickerM(this);"  class="validation[required]" title="구입년월" />
							</div>
						</div>
					</dd>
					<dt>모델</dt>
					<dd>
						<div class="select_guide">
							<div id='modelList'></div>
						</div><!-- select_guide -->
					</dd>
<!-- 					<dt>보증구분</dt> -->
<!-- 					<dd> -->
<!-- 						<div class="select_guide"> -->
<!-- 							<select class="m_select select01" name="lotYn" id="ct_select"> -->
<!-- 								<option value="#">보증(1)</option> -->
<!-- 								<option value="#">미보증(0)</option> -->
<!-- 							</select>m_select -->
<!-- 						</div>select_guide -->
<!-- 					</dd> -->


<!-- 					<dt>필터사용</dt> -->
<!-- 					<dd> -->
<!-- 						<div class="select_guide"> -->
<!-- 							<select class="m_select select01" name="filYn" id="ct_select"> -->
<!-- 								<option value="#">미사용(0)</option> -->
<!-- 								<option value="#">사용(1)</option> -->
<!-- 							</select>m_select -->
<!-- 						</div>select_guide -->
<!-- 					</dd> -->


<!-- 					<dt>필터타입</dt> -->
<!-- 					<dd> -->
<!-- 						<div class="select_guide"> -->
<!-- 							<select class="m_select select01" name="filTy" id="ct_select"> -->
<!-- 								<option value="AS214100">AS214100</option> -->
<!-- 							</select>m_select -->
<!-- 						</div>select_guide -->
<!-- 					</dd> -->

					<dt>수리유형</dt>
					<dd>
						<div class="select_guide">
							<select class="m_select select01 validation[required]" name="asTy" id="ct_select" title="수리유형">
								<option value="">선택하세요!</option>
								<c:forEach items="${asTyList}" var="asTy" varStatus="loop">
								<option value="${asTy.baseCd}">${asTy.title}</option>
								</c:forEach>
							</select><!-- m_select -->
						</div><!-- select_guide -->
					</dd>
					<dt>A/S증상(대)</dt>
					<dd id="as1Bc">
						<div class="select_guide">
							<select class="m_select select01 validation[required]" name="as1Bc" id="ct_select_01"  title="A/S증상(대)">
								<option value="">선택하세요!</option>
								<c:forEach items="${as1BcList}" var="as1Bc" varStatus="loop">
								<option value="${as1Bc.baseCd}">${as1Bc.title}</option>
								</c:forEach>
							</select><!-- m_select -->
						</div><!-- select_guide -->
					</dd>
					<dt>A/S증상(중)</dt>
					<dd id="as2Bc">
						<div class="select_guide">
							<select class="m_select select01 validation[required]" name="as2Bc" id="ct_select_01" title="A/S증상(중)">
								<option value="">선택하세요!</option>
							</select><!-- m_select -->
						</div><!-- select_guide -->
					</dd>
					<dt>처리방법</dt>
					<dd>
						<div class="select_guide">
							<select class="m_select select01 validation[required]" name="actBc" id="ct_select_02" title="처리방법">
								<option value="">선택하세요!</option>
									<c:forEach items="${actBcList}" var="actBc" varStatus="loop">
								<option value="${actBc.baseCd}">${actBc.title}</option>
								</c:forEach>
							</select><!-- m_select -->
						</div><!-- select_guide -->
					</dd>
					<dt>부위코드</dt>
					<dd id="partBc">
						<div class="select_guide">
							<select class="m_select select01 validation[required]" name="partBc" id="ct_select_03" title="부위코드">
								<option value="">선택하세요!</option>
								<c:forEach items="${partBcList}" var="partBc" varStatus="loop">
									<option value="${partBc.baseCd}">${partBc.title}</option>
								</c:forEach>
							</select>
						</div>
					</dd>
					<!-- <dt>부위코드(중)</dt>
					<dd id="partBc2">
						<div class="select_guide">
							<select class="m_select select01" name="partBc2" id="ct_select_04">
								<option value="">선택하세요!</option>
							</select>
						</div>
					</dd> -->
					<dt>비용구분(유/무)</dt>
					<dd id="amtTy">
						<div class="select_guide">
							<select class="m_select select01 validation[required]" name="amtTy" id="ct_select_04" title="비용구분(유/무)">
									<option value="">선택하세요!</option>
								<c:forEach items="${amtTyList}" var="amtTy" varStatus="loop">
									<option value="${amtTy.baseCd}">${amtTy.title}</option>
								</c:forEach>
							</select><!-- m_select -->
						</div><!-- select_guide -->
					</dd>
					<dt>수리비</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" name="repAmt" id="repAmt" style="background:#eee;text-align:right" class="validation[required,number]" title="수리비" value="0" readonly="readonly"/>
						</div>
					</dd>
					<dt>출장비</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" name="btAmt" id="btAmt" style="background:#eee;text-align:right" class="validation[required,number]" title="출장비"  value="0" readonly="readonly"/>
						</div>
					</dd>
					<dt>지역출장비</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" name="regAmt" id="regAmt" style="background:#eee;text-align:right" class="validation[required,number]" title="지역출장비"  value="0" readonly="readonly"/>
						</div>
					</dd>
					<dt>설치비</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" name="insAmt" id="insAmt" style="background:#eee;text-align:right" class="validation[required,number]" title="설치비"  value="0" readonly="readonly"/>
						</div>
					</dd>
<!-- 					<dt>지역출장비</dt> -->
<!-- 					<dd> -->
<!-- 						<div class="input_txt_bx"> -->
<!-- 							<input type="text" name="regAmt" id="regAmt" value="" /> -->
<!-- 						</div> -->
<!-- 					</dd> -->


					<dt>유상부품비</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" name="tot" style="background:#eee;text-align:right;" class="validation[number]" value="0" readonly="readonly"/>
						</div>
					</dd>

					<dt>무상부품비</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" name="tot3" style="background:#eee;text-align:right;" class="validation[number]" value="0" readonly="readonly"/>
						</div>
					</dd>
					<dt>청구합계</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" name="tot2" style="background:#eee;text-align:right;" class="validation[number]" value="0" readonly="readonly" />
						</div>
					</dd>

<!-- 					<dt>접수진행상태</dt> -->
<!-- 					<dd> -->
<!-- 						<div class="select_guide"> -->
<!-- 							<select class="m_select select01 validation[required]" name="statBc" id="ct_select_04" title="접수진행상태"> -->
<!-- 									<option value="">선택하세요!</option> -->
<!-- 									<option value="AS204200">수리진행</option> -->
<!-- 									<option value="AS204300">수리완료</option> -->
<!-- 									<option value="AS204400">정산</option> -->
<!-- 									<option value="AS204800">상담처리</option> -->
<!-- 									<option value="AS204900">취소</option> -->
<!-- 							</select> -->
<!-- 						</div> -->
<!-- 					</dd> -->
					<dt>기타</dt>
					<dd>
						<div class="input_txt_bx">
							<input type="text" name="rmks" id="rmks" value="" />
						</div>
					</dd>
				</dl>
			</div>
		</div>
		<!--// ing_bx -->
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">자재등록 현황</div>
				<div class="tblType01 in">
					<table>
						<caption>자재등록 현황표</caption>
						<thead>
							<tr>
								<th scope="col" class="bunho">번호</th>
								<th scope="col" class="code">품목코드</th>
								<th scope="col" class="name">품목명</th>
								<th scope="col" class="unit">수량</th>
								<th scope="col" class="price">소비자가</th>
							</tr>
						</thead>
						<tbody id="pllist">
							<tr>
								<td colspan="5">등록된 자재가 없습니다.</td>
							</tr>

						</tbody>
					</table>
				</div>
				<a href="javascript:;" class="btn line pop" onclick="layerPopUp('layer2'); return false;">P/L 검색</a>
			</div>
		</div>
		<!--// ing_bx(자재등록현황)-->

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

		<div class="btnBox pd10">
			<a href="javascript:;" id="okBtn" class="btn">저장</a>
		</div>
	</section>
	<!--// sub -->
	<!-- <a href="callto:01234567890" class="callBt">상담전화연결</a> -->
	<div class="layer">
		<div class="bg"></div>
		<div id="layer2" class="pop-layer">
			<div class="pop-container">
				<div class="pop-conts">
					<div class="layer_top">
						<h1>품목 P/L 선택</h1>
					</div>

					<div class="layer_body">
						<div class="layer_tblType01 fs-small mt10">
							<table id="plTable">
								<caption></caption>

								<thead>
									<tr>
										<th scope="col" class="choose">선택</th>
										<th scope="col" class="code">품목코드</th>
										<th scope="col" class="name">품목명</th>
<!-- 										<th scope="col" class="unit">기준<br>단위</th> -->
<!-- 										<th scope="col" class="price">소비<br>자가</th> -->
									</tr>
								</thead>
								<tbody>
									<c:forEach items="${partItemList}" var="partItem" varStatus="loop">
									<tr>
										<td class="choose" style="min-width:50px;">
											<span class="chkbox no_txt">
												<label class="label_txt">
													<input type="checkbox" name="itmCid" value="${partItem.itmCid}"><span class="blind"></span>
												</label>
											</span>
											<input type="hidden" name="csUp${partItem.itmCid}" value="${partItem.csUp}">
											<input type="hidden" name="up${partItem.itmCid}" value="${partItem.up}">
										</td>
										<td class="code itmCd${partItem.itmCid}" >${partItem.itmCd}</td>
										<td class="name itmNm${partItem.itmCid}" >${partItem.itmNm}</td>
<!-- 										<td class="unit">획인</td> -->
<!-- 										<td class="price">확인</td> -->
									</tr>
									</c:forEach>
								</tbody>
							</table>
						</div>
					</div>


					<div style="margin-top:30px;"><a href="javascript:;" id="pllistPut" class="btn line2 pop" >P/L 적용</a></div>
					<a href="javascript:;" class="close_btn">Close</a>
				</div>
				<!--// pop_conts -->
			</div>
		</div>
		<!--// pop-layer -->
	</div>
	</form>
</body>