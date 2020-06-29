<!DOCTYPE html>
<html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="decorator" uri="http://www.opensymphony.com/sitemesh/decorator"%>
<%@ taglib prefix="page" uri="http://www.opensymphony.com/sitemesh/page" %>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<head>
<c:choose>
		<c:when test="${!isLogIn && empty nonLogin}">
			<script type="text/javascript">
				location.href="/ISDS/mm/acessLogin.do";
			</script>
		</c:when>
		<c:when test="${not empty nonLogin}">
			<c:set var="mbrNm" value="${nonLogin.name}"/>
			<c:choose>
				<c:when test="${fn:length(nonLogin.mbrMobile) == 11}">
				<c:set var="mbrMobile1" value="${fn:substring(nonLogin.mbrMobile,0,3)}"/>
				<c:set var="mbrMobile2" value="${fn:substring(nonLogin.mbrMobile,3,7)}"/>
				<c:set var="mbrMobile3" value="${fn:substring(nonLogin.mbrMobile,7,11)}"/>
				</c:when>
			<c:when test="${fn:length(nonLogin.mbrMobile) == 10}">
				<c:set var="mbrMobile1" value="${fn:substring(nonLogin.mbrMobile,0,3)}"/>
				<c:set var="mbrMobile2" value="${fn:substring(nonLogin.mbrMobile,3,6)}"/>
				<c:set var="mbrMobile3" value="${fn:substring(nonLogin.mbrMobile,6,10)}"/>
			</c:when>
			</c:choose>
			<c:set var="mbrDi" value="${nonLogin.mbrDi}"/>

		</c:when>
		<c:when test="${isLogIn}">
				<c:set var="mbrNm" value="${mbr.mbrNm}"/>
				<c:set var="mbrMobile1" value="${fn:split(mbr.mbrMobile,'-')[0]}"/>
				<c:set var="mbrMobile2" value="${fn:split(mbr.mbrMobile,'-')[1]}"/>
				<c:set var="mbrMobile3" value="${fn:split(mbr.mbrMobile,'-')[2]}"/>

				<c:set var="mbrZipcode" value="${mbr.mbrZipcode}"/>
				<c:set var="mbrAddr" value="${mbr.mbrAddr}"/>
				<c:set var="mbrAddrDtl" value="${mbr.mbrAddrDtl}"/>
		</c:when>
	</c:choose>

		<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<style>
		.y{cursor:pointer;}
		/* popup 2017-08-18 추가 */
		.visible{display:block;}
		.hidden{display:none;}

	</style>

	<script type="text/javascript">


	function fnfixSelect(selector) {
	    var i=$(selector).parent().find('div,ul').remove().css('zIndex');
	    $(selector).unwrap().removeClass('jqTransformHidden').jqTransSelect();
	    $(selector).parent().css('zIndex', i);
	}


	var m_oMonth = new Date();

	var nowYear = ${fn:split(iConstant.nowYmd(),'-')[0]};
	var nowMonth = ${fn:split(iConstant.nowYmd(),'-')[1]}-1;
	var nowDay = ${fn:split(iConstant.nowYmd(),'-')[2]};

	m_oMonth.setFullYear(nowYear) ;
	m_oMonth.setMonth(nowMonth);
	m_oMonth.setDate(nowDay);

	var todayDate = parseInt(m_oMonth.getDate());
	var todayYear = parseInt(m_oMonth.getFullYear());
	var todayMonth = parseInt(m_oMonth.getMonth()+1);
	var adLev1=0;
	var adLev2=0;

	m_oMonth.setDate(1);

	function init(){

		fnEvent();
		fnDataSetting();

	}

	function fnDataSetting(){

		$.attfileAdd("file_add","0");
		$.attfileAdd("file_add2","1");
		$.attfileAdd("file_add3","2");

		/* 첨부파일 버튼 : 첨부파일 web에 있는 functions.js 스크립트 사용으로 스타일이 깨져 mobile 첨부파일버튼 class 넣어줌  */
		$('.btn01Type').addClass("smBtn");

		printCalendar();
		$.renderCalendar();
		$.initEvent();
		$.lvalue = "SDH0809";
		$("#ascodeLev1").change();
		$("#inpBc").val("AS110100");
		$("#modelItemCd").val('0');
		$.modelList();

		<c:choose>
			<c:when test="${not empty nonLogin}">
				$(".l-conts").show();
				$(".l-conts-choose").hide();
			</c:when>
			<c:when test="${!isLogIn}">
			    layerPopUp('layers');
				$(".m-conts").show();
				$(".l-conts-choose").hide();

			</c:when>
			<c:when test="${isLogIn}">
				$(".l-conts").show();
				$(".l-conts-choose").show();
			</c:when>
	</c:choose>
	}

	function fnEvent(){

			$.attfileAdd = function(className,len){

			$("."+className).append("<input type='text' name='dtlImgName' class='input_txt1' style='margin-bottom:5px;'/><span class='btn01Type dtlImg' style='cursor:pointer;margin-bottom:5px;'>파일찾기</span>");
				$(".dtlImg").unbind("click");
				/*----------------------------- 상세이미지 - 파일 찾기 버튼 클릭 이벤트(소멸성이벤트) -----------------------------*/
				$(".dtlImg").bind("click",function() {
					//확장형 첨부일 경우 인덱스 인자 추가 전달
					var idx = $(".dtlImg").index(this);
					//파라메터 값 object 형
				  		var obj = new Object();
				  		obj.fileAttrName = "dtlImgPath"; //실제 전달할 파일 속성명
				  	   	obj.fileViewAttrName = "dtlImgName"; //현재 노출되는 속성명 name
				  	   	obj.form = "workForm"; //전송할 form name
				  	   	obj.filetype = "image"; //파일 제한 종류 -- image (현재 이미지만 구현)
				  	   	obj.index = idx; //확장형 첨부파일일 경우 사용될 인덱스
					fileSearch(obj);
				});

				$("input[name=mbr]").bind("change",function(){
					if($(this).val() == 1){
						$("#mbrZipcode").val("${mbrZipcode}");
						$("#mbrAddr").val("${mbrAddr}");
						$("#mbrAddrDtl").val("${mbrAddrDtl}");

						$("#mbrMobile1").val("${mbrMobile1}");
						$("#mbrMobile2").val("${mbrMobile2}");
						$("#mbrMobile3").val("${mbrMobile3}");

						//knits 버그수정
						$("#nameArea").show();
						$("#mbrNm").hide();
						
					}else if($(this).val() == 2){

						$("#mbrZipcode").val("");
						$("#mbrAddr").val("");
						$("#mbrAddrDtl").val("");

						$("#mbrMobile1").val("010");
						$("#mbrMobile2").val("");
						$("#mbrMobile3").val("");
						
						//knits 버그수정
						$("#mbrNm").val("");
						$("#nameArea").hide();
						$("#mbrNm").show();
					}else{
						return;
					}
				});
		}



			/*고장증상 로딩 시*/
			$("#ascodeLev1").bind("change",function(){
				var codeTp = "";
				if($("#ascodeLev1").val() == ""){
					codeTp = "L";
					var data = $.lvalue;
				}
				fnAjax("ascodeList.action", {"codeTp":codeTp,"itmGubun":$.lvalue,"lvalue":data},
						function(data, dataType){
							$("#ascodeLev1").html("<option value=''>선택하세요</option>");
							for (key in data) {
								//key = parseInt(key)+parseInt(1);
								key = parseInt(key);
								$("#ascodeSelectDiv ul").append("<li><a href='javascript:;' index='"+key+"'>"+data[key].label+"</a></li>");
								$("#ascodeLev1").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
							}
						},"POST"
					);
			});

			/*고장증상*/
			/*$("#ascodeLev1").bind("change",function(){
				var codeTp = "";
				if($("#ascodeLev1").val() == ""){
					codeTp = "L";
					var data = $.lvalue;
				}else{
					codeTp = "M";
					data = $("#ascodeLev1").val();
				}
				fnAjax("ascodeList.action", {"codeTp":codeTp,"lvalue":data},
						function(data, dataType){
							if($("#ascodeLev1").val() == ""){
								$("#ascodeLev1").html("<option value=''>고장증상 대분류</option>");
								for (key in data) {
									$("#ascodeLev1").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
								}
							}else{
								$("#ascodeLev2").html("<option value=''>고장증상 중분류 </option>");
								for (key in data) {
									$("#ascodeLev2").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
								}
							}
						},"POST"
					);

			});*/

			/*제품 변경 후 로딩 시*/
			$("#ctSelectDiv li a").click(function(){
				adLev1=0;
				var ctData = "";

				if($(this).html()=="이누스바스"){
					//ctData="m3";
					ctData="AS110300";
				}else if($(this).html()=="블렌더"){
					//ctData="m2";
					ctData="AS110200";
				}else{
					//ctData="m1";
					ctData="AS110100";
				}

				if($(this).html()=="비데"){
					$.lvalue = "SDH0809";
					$("#itmGubun").val("SDH0809");
				}else if($(this).html()=="위생도기"){
					$.lvalue = "SDH0817";
					$("#itmGubun").val("SDH0817");
				}else if($(this).html()=="수전"){
					$.lvalue = "SDH0802";
					$("#itmGubun").val("SDH0802");
				}else if($(this).html()=="블렌더"){
					$.lvalue = "SDH0818";
					$("#itmGubun").val("SDH0818");
				}else if($(this).html()=="이누스바스"){


					alert("선택하는 제품군은 제품별 AS조치처가 달라 "+
							"전화상담에약 서비스만 가능합니다.\n"+
							"출장서비스가 필요하신 경우 통화 중 상담사가"+
							"안내하여 드릴 것입니다.");

					if($.lvalue == "SDH0809"){
						retIdx = "0";
						retText = "비데";
					}
					if($.lvalue == "SDH0817"){
						retIdx = "1";
						retText = "위생도기";
					}
					if($.lvalue == "SDH0802"){
						retIdx = "2";
						retText = "수전";
					}
					if($.lvalue == "SDH0818"){
						retIdx = "3";
						retText = "블렌더";
					}

					$("[name=modelItemCd]").val(retIdx);

					$("#ctSelectDiv div div span").text(retText);

					$("#ctSelectDiv .select li a").removeClass("selected");
					$("#ctSelectDiv .select li a").eq(retIdx).addClass("selected");

					return;
				}


				var codeTp ="L";

				$("select#modelItemCd option").each(function(){
					if($(this).html()==$("#ctSelectDiv span").html()){
						$("#modelItemCd").children("[value='"+$(this).val()+"']").remove();
						$("#modelItemCd").append("<option value='"+$(this).val()+"' selected='selected'>"+$(this).html()+"</option>");
						//$(this).attr("selected","selected");
					}else{
						$("#modelItemCd").children("[value='"+$(this).val()+"']").remove();
						$("#modelItemCd").append("<option value='"+$(this).val()+"'>"+$(this).html()+"</option>");
					}
				});

// 				fnAjax("modelList.action", {"itmGubun":$.lvalue},
// 					function(data, dataType){
// 						$("#modelSelectDiv ul").html("<li><a href='javascript:;' index='0' class='selected'>선택하세요</a></li>");
// 						$("#model").html("<option value=''>선택하세요</option>");

// 						for (key in data) {
// 							$("#modelSelectDiv ul").append("<li><a href='javascript:;' index='"+key+"'>"+data[key].label+"</a></li>");
// 							$("#model").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
// 						}
// 						$("#modelSelectDiv div div span").html('선택하세요');
// 						$("#modelSelectDiv ul").attr("style","visibility: visible; display: none;");
// 					},"POST"
// 				);
				var url = "modelList.action?itmGubun="+$.lvalue;
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
	            $("#modelList").jqxComboBox({ selectedIndex: -1, source: dataAdapter, displayMember: "label", valueMember: "value", width: "100%", height: 30,	promptText: "모델을 선택하세요!"});



				fnAjax("ascodeList.action", {"codeTp":codeTp,"itmGubun":$.lvalue,"lvalue":ctData},
					function(data, dataType){
							$("#ascodeLev1").html("<option value=''>선택하세요</option>");
							$("#ascodeSelectDiv span").html('선택하세요');
							$("#ascodeSelectDiv ul").html("<li><a href='javascript:;' index='0' class='selected'>선택하세요</a></li>");
							$("#ascodeLev2").html("<option value=''>선택하세요</option>");
							$("#ascodeSelectDiv2 span").html('선택하세요');
							$("#ascodeSelectDiv2 ul").html("<li><a href='javascript:;' index='0' class='selected'>선택하세요</a></li>");
							$("#ascodeSelectDiv2 ul").attr("style","visibility: visible; display: none;");
							for (key in data) {
								//key = parseInt(key)+parseInt(1);
								key = parseInt(key);
								$("#ascodeSelectDiv ul").append("<li><a href='javascript:;' index='"+key+"'>"+data[key].label+"</a></li>");
								$("#ascodeLev1").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
							}
					},"POST"
				);
				adLev2=0;
				moCk=0;
			});

			// 고장증상(대) 선택시
			$("#ascodeSelectDiv").click(function(){
				if(adLev1==0){
					$("#ascodeSelectDiv ul li a").bind("click",function(){
						$("#ascodeSelectDiv span").html($(this).html());
						$("#ascodeSelectDiv ul li a").each(function(){
							if($(this).html()==$("#ascodeSelectDiv span").html()){
								$(this).attr("class","selected");
							}else{
								$(this).attr("class","");
							}
							$("#ascodeSelectDiv ul").attr("style","visibility: visible; display: none;");
						});
						//지우고 새로 선택
						$("select#ascodeLev1 option").each(function(){
							if($(this).html()==$("#ascodeSelectDiv span").html()){
								$("#ascodeLev1").children("[value='"+$(this).val()+"']").remove();
								$("#ascodeLev1").append("<option value='"+$(this).val()+"' selected='selected'>"+$(this).html()+"</option>");
								//$(this).attr("selected","selected");
							}else{
								$("#ascodeLev1").children("[value='"+$(this).val()+"']").remove();
								$("#ascodeLev1").append("<option value='"+$(this).val()+"'>"+$(this).html()+"</option>");
							}
						});

						if($("#ascodeSelectDiv span").html() == ""){
							codeTp = "L";
							var data = $.lvalue;
						}else{
							codeTp = "M";
							data = $("#ascodeLev1").val();
						}
						fnAjax("ascodeList.action", {"codeTp":codeTp,"itmGubun":$.lvalue,"lvalue":data},
								function(data, dataType){
										$("#ascodeLev2").html("<option value=''>선택하세요</option>");
										$("#ascodeSelectDiv2 span").html('선택하세요');
										$("#ascodeSelectDiv2 ul").html("<li><a href='javascript:;' index='0' class='selected'>선택하세요</a></li>");
										for (key in data) {
											//key = parseInt(key)+parseInt(1);
											key = parseInt(key);
											$("#ascodeSelectDiv2 ul").append("<li><a href='javascript:;' index='"+key+"'>"+data[key].label+"</a></li>");
											$("#ascodeLev2").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
											$("#ascodeSelectDiv2 ul").attr("style","visibility: visible; display: none;");
										}
								},"POST"
							);
					});
					adLev1++;
				}
				adLev2=0;
			});


			// 고장증상(중) 선택시
			$("#ascodeSelectDiv2").click(function(){
				if(adLev2==0){
					$("#ascodeSelectDiv2 ul li a").bind("click",function(){
						$("#ascodeSelectDiv2 span").html($(this).html());
						$("#ascodeSelectDiv2 ul li a").each(function(){
							if($(this).html()==$("#ascodeSelectDiv2 span").html()){
								$(this).attr("class","selected");
							}else{
								$(this).attr("class","");
							}
							$("#ascodeSelectDiv2 ul").attr("style","visibility: visible; display: none;");
						});
						//지우고 새로 선택
						$("select#ascodeLev2 option").each(function(){
							if($(this).html()==$("#ascodeSelectDiv2 span").html()){
								$("#ascodeLev2").children("[value='"+$(this).val()+"']").remove();
								$("#ascodeLev2").append("<option value='"+$(this).val()+"' selected='selected'>"+$(this).html()+"</option>");
								//$(this).attr("selected","selected");
							}else{
								$("#ascodeLev2").children("[value='"+$(this).val()+"']").remove();
								$("#ascodeLev2").append("<option value='"+$(this).val()+"'>"+$(this).html()+"</option>");
							}
						});
					});
					adLev2++;
				}
			});



			/*탭이벤트*/
			$('.list_goods a').bind("click",function(){
				$(this).addClass('active');
				$(this).siblings().removeClass('active');
				if($(this).index() == 0 || $(this).index() == 1 || $(this).index() == 2 ){
//	 				$.lvalue = "m1";
					$("#inpBc").val("AS110100");
				}else if($(this).index() == 4){
//	 				$.lvalue = "m2";
					$("#inpBc").val("AS110200");
				}else{
//	 				$.lvalue = "m3";
					$("#inpBc").val("AS110300");
				}

				if($(this).index() == 0){
					$.lvalue = "SDH0809";
					$("#itmGubun").val("SDH0809");
				}
				if($(this).index() == 1){
					$.lvalue = "SDH0817";
					$("#itmGubun").val("SDH0817");
				}
				if($(this).index() == 2){
					$.lvalue = "SDH0802";
					$("#itmGubun").val("SDH0802");
				}
				if($(this).index() == 3){
					$.lvalue = "SDH0818";
					$("#itmGubun").val("SDH0818");
				}
				if($(this).index() == 4){
					$.lvalue = $(this).val();
					$("#itmGubun").val($(this).val());
					$("#ascodeLev1").html("<option value=''>고장증상 대분류</option>");
					$("#ascodeLev2").html("<option value=''>고장증상 중분류 </option>");
					$.modelList();
					alert("선택하는 제품군은 제품별 AS조치처가 달라 "+
							"전화상담에약 서비스만 가능합니다.\n"+
							"출장서비스가 필요하신 경우 통화 중 상담사가"+
							"안내하여 드릴 것입니다.");
					return;
				}

				$("#modelItemCd").val($(this).index());
				$("#ascodeLev1").val("");
				$("#ascodeLev2").html("<option value=''>고장증상 중분류 </option>");
				$("#ascodeLev1").change();
				$.modelList();
			});

			/*모델리스트*/
			$.modelList = function(tabCd){
				var url = "modelList.action?itmGubun="+$.lvalue;
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
	            $("#modelList").jqxComboBox({ selectedIndex: -1, source: dataAdapter, displayMember: "label", valueMember: "value", width: "100%", height: 30,	promptText: "모델을 선택하세요!"});

// 				fnAjax("modelList.action", {"itmGubun":$.lvalue},
// 					function(data, dataType){
// 						for (key in data) {
// 							$("#modelSelectDiv ul").append("<li><a href='javascript:;' index='"+key+"'>"+data[key].label+"</a></li>");
// 							$("#model").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
// 						}
// 						$("#modelSelectDiv div div span").html('선택하세요');
// 					},"POST"
// 				);
			}

			var moCk=0;
			$("#modelSelectDiv").click(function(){
				if(moCk==0){
					$("#modelSelectDiv ul li a").click(function(){
						$("#modelSelectDiv span").html($(this).html());
						$("#modelSelectDiv ul li a").each(function(){
							if($(this).html()==$("#modelSelectDiv span").html()){
								$(this).attr("class","selected");
							}else{
								$(this).attr("class","");
							}
							$("#modelSelectDiv ul").attr("style","visibility: visible; display: none;");
						});
						$("select#model option").each(function(){
							if($(this).html()==$("#modelSelectDiv span").html()){
								$("#model").children("[value='"+$(this).val()+"']").remove();
								$("#model").append("<option value='"+$(this).val()+"' selected='selected'>"+$(this).html()+"</option>");
								//$(this).attr("selected","selected");
							}else{
								$("#model").children("[value='"+$(this).val()+"']").remove();
								$("#model").append("<option value='"+$(this).val()+"'>"+$(this).html()+"</option>");
							}
						});
					});
					moCk++;
				}
			});

			$.element_layer = document.getElementById('zipcodeLayer');

			$.closeDaumPostcode = function(){
				$.element_layer.style.display = 'none';
			}

			// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
		    // resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
		    // 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
		    $.initLayerPosition = function(){
		        var width = 300; //우편번호서비스가 들어갈 element의 width
		        var height = 400; //우편번호서비스가 들어갈 element의 height
		        var borderWidth = 5; //샘플에서 사용하는 border의 두께

		        // 위에서 선언한 값들을 실제 element에 넣는다.
		        $.element_layer.style.width = width + 'px';
		        $.element_layer.style.height = height + 'px';
		        $.element_layer.style.border = borderWidth + 'px solid';
		        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
		        $.element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
		        $.element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
		    }

			/** 주소 찾기 **/
			$("#addrBtn").click(function(){

				new daum.Postcode({
		            oncomplete: function(data) {
		                // 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

		                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
		                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
		                var fullAddr = data.address; // 최종 주소 변수
		                var extraAddr = ''; // 조합형 주소 변수

		                // 기본 주소가 도로명 타입일때 조합한다.
		                if(data.addressType === 'R'){
		                    //법정동명이 있을 경우 추가한다.
		                    if(data.bname !== ''){
		                        extraAddr += data.bname;
		                    }
		                    // 건물명이 있을 경우 추가한다.
		                    if(data.buildingName !== ''){
		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
		                    }
		                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
		                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
		                }

		                // 우편번호와 주소 정보를 해당 필드에 넣는다.
		                $('#mbrZipcode').val(data.zonecode); //5자리 새우편번호 사용
		                $('#mbrAddr').val(fullAddr);
		                // 커서를 상세주소 필드로 이동한다.
		                $('#mbrAddrDtl').val(extraAddr);
		                $('#mbrAddrDtl').focus();

		                // iframe을 넣은 element를 안보이게 한다.
		                // (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
		                $.element_layer.style.display = 'none';
		            },
		            width : '100%',
		            height : '100%',
		            maxSuggestItems : 5
		        }).embed($.element_layer);

		        // iframe을 넣은 element를 보이게 한다.
		        $.element_layer.style.display = 'block';

		        // iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
		        $.initLayerPosition();
			});

		/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 Start -----------------------------*/
		 $("#okBtn").bind("click",function(){
			 var item = $("#modelList").jqxComboBox('getSelectedItem');
				if(item == null){
					alert("모델을 선택해주세요!");
					$("#model").val("");
					return;
				}else{
					$("#model").val(item.value);
				}


			 	var mbrMobile = "";
				var mbrMobile1 = $("#mbrMobile").val().substring(0,3);
				var mbrMobile2 = $("#mbrMobile").val().substring(3,7);
				var mbrMobile3 = $("#mbrMobile").val().substring(7,11);
				mbrMobile = mbrMobile1 + mbrMobile2 + mbrMobile3;

				$("#mbrMobile").val(mbrMobile);
				$("#mbrMobile1").val(mbrMobile1);
				$("#mbrMobile2").val(mbrMobile2);
				$("#mbrMobile3").val(mbrMobile3);

			 	if(!$("input:checkbox[id=privteCk]").is(":checked")){
					alert('개인정보 수집 및 이용 동의를 해주세요.');
					return false;
				}
				if($("#modelSelectDiv span").html()=='선택하세요'){
					alert('모델을 선택해주세요.');
					return false;
				}
				if($("#ascodeSelectDiv span").html()=='선택하세요'){
					alert('고장증상을 선택해주세요.');
					return false;
				}
				if($("#mbrMobile").val()==''){
					alert('전화번호를 입력해주세요.');
					return false;
				}
				if($("#mbrZipcode").val()==''||$("#mbrAddr").val()==''||$("#mbrAddrDtl").val()==''){
					alert('주소를 입력해주세요.');
					return false;
				}
				if(!strLength($("#txtArea").val())){
					alert('1000byte를 넘을 수 없습니다.');
					return false;
				}
			
			$("#mbrNm").val(mbrNm.value);
			
			fnSubmit("workForm","예약신청");
		});
		/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 End -----------------------------*/
	}


	function strLength(str){
		var len = 0;
	    for (var i = 0; i < str.length; i++) {
	        if (escape(str.charAt(i)).length == 6) {
	            len++;
	        }
	        len++;
	    }
	    if(len>1000){
	    	return false;
	    }
	    return true;
	}

	function fnByteCheck(e, byteLength){
		var text = $(e).val();
		var textLength = 0;
		for(var i = 0; i < text.length; i++){
			/* if(escape(text.charAt(i)).length == 6){
				textLength++;
			}
			textLength++;
			*/
			if(encodeURIComponent(text.charAt(i)).length == 9){// 한글
				textLength += 2;
			}else if(encodeURIComponent(text.charAt(i)).length == 1){// 영문
				textLength += 1;
			}else{ //특수문자
				textLength += 2;
			}
		}
		var cutbyLenText = cutByLen(text, byteLength);
		if(textLength > byteLength){
			$("#txtArea").val("");
			$("#txtArea").val(cutbyLenText);
			$("#txtArea").html("");
			$("#txtArea").html(cutbyLenText);
			$('#chkByte').text("");
			$('#chkByte').text("1000/1000");
		}else{
			$('#chkByte').text("");
			$('#chkByte').text(textLength+"/1000");
		}
	}

	function cutByLen(str, maxByte) {
		 for(b=i=0;c=str.charCodeAt(i);) {
			 b+=c>>7?2:1;
			 if(b > maxByte){
				 break;
			 }
			 i++;
		 }
		 return str.substring(0,i);
	 }

	function spanText(day){

		var spanMonth = m_oMonth.getMonth()+1;
		if(spanMonth < 10){
			spanMonth = '0' + spanMonth;
		}

		if(day < 10){
			day = '0' + day;
		}

		$('.rsv td').removeClass('s');
		$("#"+day).addClass("s");


		var spanDay = $("#year").val()+"-"+spanMonth+"-"+day

		$("#bookingDt").val(spanDay);
		$("#selectText").text(spanDay);

	}

	function printCalendar() {

	    /* 달력 UI 생성 */
		$.renderCalendar = function() {

			var postData = $("#calendarFrm").serializeArray();
			$.ajax({
			    url : "calendar.action",
			    type: "POST",
			    data : postData,
			    success:function(data, textStatus, jqXHR)
			    {
			    	var joinMonth = parseInt($("#month").val());

					if($("#month").val() == ''){
						joinMonth = todayMonth;
						$("#year").val(todayYear);
						$("#month").val("0"+(todayMonth+1));
					}

					var arrTable = [];

					arrTable.push('<table class="rsv">');
					arrTable.push('<caption>달력</caption>');
					arrTable.push('<thead><tr>');

					var arrWeek = "일월화수목금토".split("");

					for(var i=0, len=arrWeek.length; i<len; i++) {
						arrTable.push('<th scope="col">' + arrWeek[i] + '</th>');
					}
					arrTable.push('</tr></thead>');
					arrTable.push('<tbody>');

					var oStartDt = new Date(m_oMonth.getTime());
			        // 1일에서 1일의 요일을 빼면 그 주 첫번째 날이 나온다.
					oStartDt.setDate(oStartDt.getDate() - oStartDt.getDay());


					for(var i=0; i<100; i++) {

						var dayValue = oStartDt.getDate();
						if(dayValue < 10){
							dayValue = '0' + dayValue;
						}

						if(i % 7 == 0) {
							arrTable.push('<tr>');
						}

						var sClass = '';
			            sClass += m_oMonth.getMonth() != oStartDt.getMonth() ? 'not-this-month ' : '';
						sClass += i % 7 == 0 ? 'sun' : '';
						sClass += i % 7 == 6 ? 'sat' : '';

						var notMonth = m_oMonth.getMonth() != oStartDt.getMonth() ? 'notMonth ' : '';

			            if(notMonth != ''){
			            	arrTable.push('<td></td>');
			            }else{
			            	var holly = "N";
							if(data.length > 0){
								for (key in data) {
									if(data[key].workDd == dayValue){
										holly = "Y";
										break;
									}
								}
							}

							if(i % 7 == 0 || i % 7 == 6){  //주말제외
								arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
							}else if(todayYear < $("#year").val()){
								if(holly == "N"){
									arrTable.push('<td id="'+dayValue+'" class="y" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '</td>');
									}else{
										arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
									}
							}else if(todayYear == $("#year").val() && todayMonth < joinMonth){
								if(holly == "N"){
									arrTable.push('<td id="'+dayValue+'" class="y" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '</td>');
									}else{
										arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
									}
							}else if(todayYear == $("#year").val() && todayMonth == joinMonth){
								if(todayDate < oStartDt.getDate() ){
									if(holly == "N"){
									arrTable.push('<td id="'+dayValue+'" class="y" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '</td>');
									}else{
										arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
									}
								}else{
									arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
								}
							}else{
								arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
							}
			            }
						oStartDt.setDate(oStartDt.getDate() + 1);

						if(i % 7 == 6) {
							arrTable.push('</tr>');
							if(m_oMonth.getMonth() != oStartDt.getMonth()) {
								break;
							}
						}
					}
					arrTable.push('</tbody></table>');

					$('#calendar').html(arrTable.join(""));
					$.changeMonth();

			    },
			    error: function(jqXHR, textStatus, errorThrown)
			    {
			    	alert("통신에 실패 하였습니다. 관리자에게 문의해 주세요.");
			    }
			}); // ajax





		}

		/* Next, Prev 버튼 이벤트 */
		$.initEvent = function() {
			$('#btnPrev').bind("click",function(){
				$.onPrevCalendar();
			});

			$('#btnNext').bind("click",function(){
				$.onNextCalendar();
			});
		}

	    /* 이전 달력 */
		$.onPrevCalendar = function() {
			m_oMonth.setMonth(m_oMonth.getMonth() - 1);
			var spanMonth = m_oMonth.getMonth()+1;
			if(spanMonth < 10){
				spanMonth = '0' + spanMonth;
			}
			$("#month").val(spanMonth);

			if($("#month").val() > 11){
				$("#year").val(m_oMonth.getFullYear());
			}

			$.renderCalendar();
		}

	    /* 다음 달력 */
		$.onNextCalendar = function() {
			m_oMonth.setMonth(m_oMonth.getMonth() + 1);

			var spanMonth = m_oMonth.getMonth()+1;
			if(spanMonth < 10){
				spanMonth = '0' + spanMonth;
			}
			$("#month").val(spanMonth);

			if($("#month").val() < 2){
				$("#year").val(m_oMonth.getFullYear());
			}

			$.renderCalendar();

		}

	    /* 달력 이동되면 상단에 현재 년 월 다시 표시 */
		$.changeMonth = function() {
			$('#currentDate').text($.getYearMonth(m_oMonth).substr(0,9));
		}

	    /* 날짜 객체를 년 월 문자 형식으로 변환 */
		$.getYearMonth = function(oDate) {
			var spanMonth = oDate.getMonth()+1;
			if(spanMonth < 10){
				spanMonth = '0' + spanMonth;
			}
			return oDate.getFullYear() + '년 ' + spanMonth + '월';
		}
	}

	function keydown(seq) {
		  var keycode = '';
		  if(window.event) keycode = window.event.keyCode;
		 if(keycode == 13){
			 if(seq == 1){
		 	 	actionLogin();
			 }
		 }
		  return false;
		}

	function keydownAjax(seq) {
		  var keycode = '';
		  if(window.event) keycode = window.event.keyCode;
		 if(keycode == 13){
			 if(seq == 1){
		 	 	actionLoginAjax();
			 }
		 }
		  return false;
		}


		function actionLogin() {
			var _mbrId = $(document.loginForm.mbrId).val().length;
			var _mbrPw = $(document.loginForm.mbrPw).val().length;
			if(_mbrId == 0){
				alert("아이디를 입력하세요");
				$(document.loginForm.mbrId).focus();
				return false;
			}else if (_mbrId.length < 4 || _mbrId.length > 16) {
				alert("아이디는 영문숫자조합 최소 4자에서 최대 16자까지 입력 가능합니다");
				$(document.loginForm.mbrId).focus();
				return false;
			}
			if(_mbrPw == 0){
				alert("비밀번호를 입력하세요");
				$(document.loginForm.mbrPw).focus();
				return false;
			}else if (_mbrPw.length < 4 || _mbrPw.length > 16) {
				alert("패스워드는 4~16자까지만 입력 가능합니다.");
				$(document.loginForm.mbrPw).focus();
				return false;
			}
	        document.loginForm.action="/ISDS/mm/actionLogin.action";
	        document.loginForm.submit();
		}


		function actionAjaxLogin() {
			var _mbrId = $("#mbrIdA").val().length;
			var _mbrPw = $("#mbrPwA").val().length;
			if(_mbrId == 0){
				alert("아이디를 입력하세요");
				$(document.workForm.mbrId).focus();
				return false;
			}else if (_mbrId.length < 4 || _mbrId.length > 16) {
				alert("아이디는 영문숫자조합 최소 4자에서 최대 16자까지 입력 가능합니다");
				$(document.workForm.mbrId).focus();
				return false;
			}
			if(_mbrPw == 0){
				alert("비밀번호를 입력하세요");
				$(document.workForm.mbrPw).focus();
				return false;
			}else if (_mbrPw.length < 4 || _mbrPw.length > 16) {
				alert("패스워드는 4~16자까지만 입력 가능합니다.");
				$(document.workForm.mbrPw).focus();
				return false;
			}

			fnAjax("/ISDS/mm/actionLoginAjax.action", {"mbrId":$("#mbrIdA").val(),"mbrPw":$("#mbrPwA").val(),"saveIdCookie":$("#saveIdCookieA").val()},
					function(data, dataType){
						if(data.status == "ok"){
							$(".l-conts").show();
							$(".m-conts").hide();
							$("#nameArea").text(data.mbrNm);
							$("#mbrNm").val(data.mbrNm);
							$("#mbrZipcode").val(data.mbrNm);
							$("#mbrAddr").val(data.mbrAddr);
							$("#mbrAddrDtl").val(data.mbrAddrDtl);

							$("#mbrMobile1").val(data.mbrMobile.split("-")[0]);
							$("#mbrMobile2").val(data.mbrMobile.split("-")[1]);
							$("#mbrMobile3").val(data.mbrMobile.split("-")[2]);

							$(".l-conts-choose").show();
						}else{
							$(".m-conts").show();
							$(".l-conts").hide();
							alert(data.msg);
						}
					},"POST"
			);

		}

		function fnPopup(val){
			if(val=="hp"){
				woh_open('checkPlusMain.action?param_r1=cs&certMet=M', 'popup','width=425, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}else{
				woh_open('checkPlusMain.action?param_r1=cs&certMet=P', 'popup', 'width=450, height=550, top=100, left=100, fullscreen=no, menubar=no, status=no, toolbar=no, titlebar=yes, location=no, scrollbar=no');
			}
		}

		function fnInfoChange(){
			var selectVal = $("#infoSelect option:selected").val();
			$(".exImg").hide();
			$(".exImg").eq(selectVal).show();
		};

	</script>
</head>
<body>
	<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
<div id="zipcodeLayer" style="display:none;position:fixed;position:absoluteoverflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
<img src="//t1.daumcdn.net/localimg/localimages/07/postcode/320/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;width:20px; height:20px; right:-3px;top:-3px;z-index:1" onclick="$.closeDaumPostcode()" alt="닫기 버튼">
</div>
	<form id="calendarFrm" name="calendarFrm" method="post">
		<input type="hidden" id="year" name="year" value="${fn:split(iConstant.nowYmd(),'-')[0]}"/>
		<input type="hidden" id="month" name="month" value="${fn:split(iConstant.nowYmd(),'-')[1]}"/>
	</form>

	<form id="workForm" name="workForm" action="csSave.action" method="post" enctype="multipart/form-data">
		<input type="hidden" name="mbrDi" id="mbrDi" value="${mbrDi}"/>
		<input type="hidden" name="bookingDt" id="bookingDt" class="validation[required]" title="예약날짜"/>
		<input type="hidden" name="csType" id="csType" value="SER" />
		<input type="hidden" name="inpBc" id="inpBc" value="" />
		<input type="hidden" name="itmGubun" id="itmGubun" value="SDH0809" />
		<input type="hidden" id="model" name="model" value=""/>

	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>출장서비스 예약</h2>
		</div>
		<!--// tit_bx -->
		<div class="ing_bx nobg">
			<div class="box">
				<div class="tit drop on">Step1.제품 증상 선택<span class="star">필수입력사항</span></div>
				<div class="cont">
					<dl class="type01 hr">
						<dt class="star">제품선택</dt>
						<dd>
							<div class="select_guide" id="ctSelectDiv">
								<select class="m_select select01" name="modelItemCd" id="modelItemCd">
									<option value="0">비데</option>
									<option value="1">위생도기</option>
									<option value="2">수전</option>
									<option value="3">블렌더</option>
									<option value="4">이누스바스</option>
								</select>
							</div>
							<!-- select_guide -->
						</dd>

						<dt class="star">모델선택</dt>
						<dd>
							<div class="select_guide" id="modelSelectDiv">
								<div id='modelList'></div>
<!-- 								<select class="m_select select01" name="model" id="model"> -->
<!-- 									<option value="">선택하세요</option> -->
<!-- 								</select> -->
							</div>
							<!-- select_guide -->
						</dd>
						<dt class="star">고장증상</dt>
						<dd>
							<div class="select_guide" id="ascodeSelectDiv">
								<select class="m_select select01" name="ascodeLev1" id="ascodeLev1">
									<option value="">선택하세요</option>
								</select>
							</div>
							<!-- select_guide -->
						</dd>
						<dt class="star">고장증상(중)</dt>
						<dd>
							<div class="select_guide" id="ascodeSelectDiv2">
								<select class="m_select select01" name="ascodeLev2" id="ascodeLev2">
									<option value="">선택하세요</option>
								</select>
							</div>
							<!-- select_guide -->
						</dd>

						<dt class="star">고장증상 상세</dt>
						<dd class="h140px ">
							<div class="txtArea pb10">
								<textarea id="txtArea" name="comment" value="" onkeyUp="fnByteCheck(this,'1000');"></textarea>
								<p></p>
								<span class="cur" id="chkByte">0/1000 byte</span>
							</div>
						</dd>
					</dl>
				</div>
				<!--// cont -->
			</div>
		</div>
		<!--// ing_bx (step1) -->
		<div class="ing_bx nobg">
			<div class="box">
				<div class="tit drop">Step2. 고객 정보 입력<span class="star">필수입력사항</span></div>
				<div class="cont">
					<div class="rdi_bx_wrap hr">
						<div class="rdibox">
							<input type="radio" id="sameif" class="" name="mbr" value="1" checked="checked"><i></i>
							<label for="sameif">회원정보와 동일</label>
						</div>
						<div class="rdibox">
							<input type="radio" id="newif" class="" name="mbr" value="2"><i class=""></i>
							<label for="newif">새로운 정보 입력</label>
						</div>
					</div>
					<dl class="type01 hr">
						<dt class="star">성명</dt>
						<dd >
							<span style="line-height:35px;" id="mbrNmSpn" name="mbrNmSpn" >${mbrNm}</span>
							<div class="input_txt_bx">
								<input type="text" id="mbrNm" name="mbrNm" value="${mbrNm}" class="validation[required]" title="성명" style="display: none;">
							</div>
						</dd>
						<dt class="star">연락가능번호</dt>
						<dd>
							<div class="input_txt_bx">
								<input type="text" name="mbrMobile" placeholder="-빼고 숫자만 입력" id="mbrMobile" value="${mbrMobile1}${mbrMobile2}${mbrMobile3}" class="" maxlength="11" />
								<input type="hidden" name="mbrMobile1" placeholder="-빼고 숫자만 입력" id="mbrMobile1" value="${mbrMobile1}" class=""/>
								<input type="hidden" name="mbrMobile2" placeholder="-빼고 숫자만 입력" id="mbrMobile2" value="${mbrMobile2}" class=""/>
								<input type="hidden" name="mbrMobile3" placeholder="-빼고 숫자만 입력" id="mbrMobile3" value="${mbrMobile3}" class=""/>
							</div>
						</dd>
						<dt class="star">주소</dt>
						<dd>
							<div class="input_txt_bx">
								<input type="text" name="mbrZipcode" id="mbrZipcode" value="${mbrZipcode}" class="smInput1" readonly="readonly"/>
								<a href="javascript:;" id="addrBtn" class="smBtn">우편번호</a>
							</div>
						</dd>
						<dt></dt>
						<dd>
							<div class="input_txt_bx">
								<input type="text" name="mbrAddr" id="mbrAddr" value="${mbrAddr}" class="" readonly="readonly"/>
							</div>
						</dd>
						<dt></dt>
						<dd>
							<div class="input_txt_bx">
								<input type="text" name="mbrAddrDtl" id="mbrAddrDtl" value="${mbrAddrDtl}" class=""/>
							</div>
						</dd>
						<!-- <dt class="star">첨부파일</dt> -->
						<dt>첨부파일</dt>
						<dd class="hauto">
							<div class="input_txt_bx file_add">
								<a href="#" class="smBtn w20">찾기</a>
							</div>
							<div class="input_txt_bx file_add2">
								<a href="#" class="smBtn w20">찾기</a>
							</div>
							<div class="input_txt_bx file_add3">
								<a href="#" class="smBtn w20">찾기</a>
							</div>
							<div class="ar"><span class="cur fs-11">0/50MB</span></div>
						</dd>

						<dd class="hauto">
							<div class="imgUpload">
								<p class="fs-13 fc-bold">이미지 업로드 가이드</p>
								<p class="fs-11 mb10">품목별 업로드 가이드를 확인하세요.</p>
								<div class="select_guide w100">
									<select class="m_select select01" id="infoSelect" onchange="fnInfoChange(this);">
										<option value="0">비데</option>
										<option value="1">위생도기</option>
										<option value="2">수전</option>
										<option value="3">블렌더</option>
										<option value="4">이누스바스</option>
									</select>
								</div>
								<!-- select_guide -->
								<div class="exImg" id="infoImg0">
									<span>예시)</span>
									<ul>
										<li><img src="/common/img_m/SS-365.png" alt=""/></li>
										<li><img src="/common/img_m/UB-FH6515.png" alt=""/></li>
									</ul>
									<p class="fs-11 fc-red pl10">모델명이 기재된 컨트롤 사진과 비데 전체사진을 업로드해주세요.<br>(약 45º각도에서 제품 전체가 보일 것)</p>
								</div>
								<div class="exImg" id="infoImg1" style="display:none;">
									<span>예시)</span>
									<ul>
										<li><img src="/common/img_m/C853.png" alt=""/></li>
									</ul>
									<p class="fs-11 fc-red pl10">모델명이 기재된 컨트롤 사진과 비데 전체사진을 업로드해주세요.<br>(약 45º각도에서 제품 전체가 보일 것)</p>
								</div>
								<div class="exImg" id="infoImg2" style="display:none;">
									<span>예시)</span>
									<ul>
										<li><img src="/common/img_m/G0110.png" alt=""/></li>
									</ul>
									<p class="fs-11 fc-red pl10">모델명이 기재된 컨트롤 사진과 비데 전체사진을 업로드해주세요.<br>(약 45º각도에서 제품 전체가 보일 것)</p>
								</div>
								<div class="exImg" id="infoImg3" style="display:none;">
									<span>예시)</span>
									<ul>
										<li><img src="/common/img_m/V38_1.png" alt=""/></li>
									</ul>
									<p class="fs-11 fc-red pl10">모델명이 기재된 컨트롤 사진과 비데 전체사진을 업로드해주세요.<br>(약 45º각도에서 제품 전체가 보일 것)</p>
								</div>
								<div class="exImg" id="infoImg4" style="display:none;">
									<span>예시)</span>
									<ul>
										<li><img src="/common/img_m/1.png" alt="" style="background-color:silver;"/></li>
										<li><img src="/common/img_m/2.png" alt=""/></li>
									</ul>
									<p class="fs-11 fc-red pl10">모델명이 기재된 컨트롤 사진과 비데 전체사진을 업로드해주세요.<br>(약 45º각도에서 제품 전체가 보일 것)</p>
								</div>
								<!--// exImg -->
							</div>
							<!--// imgUpload -->
						</dd>
						<dt class="star wauto fn">개인정보 수집 및 이용 동의</dt>
						<dd class="hauto pd0">
							<div class="info_bx mrl10">
								<em>inus 서비스센터 개인정보 취급방침</em>
								<p class="mt05">&#60;inus 서비스센터&#62;('http://cs.inusbath.com'이하 'inus 서비스센터 홈페이지')은(는) 개인정보보호법에 따라 이용자의 개인정보 보호 및 권익을 보호하고 개인정보와 관련한 이용자의 고충을 원활하게 처리할 수 있도록 다음과 같은 처리방침을 두고 있습니다.</p>
								<p class="mt05">&#60;inus 서비스센터&#62;('inus 서비스센터 홈페이지') 은(는) 회사는 개인정보처리방침을 개정하는 경우 웹사이트 공지사항(또는 개별공지)을 통하여 공지할 것입니다.</p>
								<p class="mt05">○ 본 방침은부터 2017년 10월 1일부터 시행됩니다.</p>
								<em class="mt20">1. 개인정보의 처리 목적</em>
								<p class="mt05">&#60;inus 서비스센터&#62;('http://cs.inusbath.com'이하 'inus 서비스센터 홈페이지')은(는) 개인정보를 다음의 목적을 위해 처리합니다. 처리한 개인정보는 다음의 목적 이외의 용도로는 사용되지 않으며 이용 목적이 변경될 시에는 사전동의를 구할 예정입니다.</p>
								<p class="mt05">가. 홈페이지 회원가입 및 관리</p>
								<p class="mt05">고충처리, 분쟁 조정을 위한 기록 보존 등을 목적으로 개인정보를 처리합니다.</p>
								<p class="mt05">나. 민원사무 처리</p>
								<p class="mt05">민원인의 신원 확인, 민원사항 확인, 사실조사를 위한 연락·통지, 처리결과 통보 등을 목적으로 개인정보를 처리합니다.</p>
								<p class="mt05">다. 재화 또는 서비스 제공</p>
								<p class="mt05">서비스 제공, 본인인증 등을 목적으로 개인정보를 처리합니다.</p>
								<em class="mt20">2. 개인정보 파일 현황</em>
								<p class="mt05">1. 개인정보 파일명 : 개인정보 수집 파일 현황</p>
								<p class="mt05">- 개인정보 항목 :이메일, 휴대전화번호, 비밀번호, 이름, 접속 로그, 쿠키</p>
								<p class="mt05">- 수집방법 : 홈페이지, 서면양식, 전화/팩스</p>
								<p class="mt05">- 보유근거 : 개인정보취급 방침</p>
								<p class="mt05">- 보유기간 : 3년</p>
								<p class="mt05">- 관련법령 : 소비자의 불만 또는 분쟁처리에 관한 기록 : 3년(전자상거래등에서의 소비자보호에 관한 법률) </p>
								<em class="mt20">3. 개인정보처리 위탁</em>
								<p class="mt05">① &#60;inus 서비스센터&#62;('inus 서비스센터 홈페이지')은(는) 원활한 개인정보 업무처리를 위하여 다음과 같이 개인정보 처리업무를 위탁하고 있습니다.</p>
								<p class="mt05">② &#60;inus 서비스센터&#62;('http://cs.inusbath.com'이하 'inus 서비스센터 홈페이지')은(는) 위탁계약 체결 시 개인정보 보호법 제25조에 따라 위탁업무 수행목적 외 개인정보 처리금지, 기술적․관리적 보호조치, 재위탁 제한, 수탁자에 대한 관리․감독, 손해배상 등 책임에 관한 사항을 계약서 등 문서에 명시하고, 수탁자가 개인정보를 안전하게 처리하는지를 감독하고 있습니다.</p>
								<p class="mt05">③ 위탁업무의 내용이나 수탁자가 변경될 경우에는 지체 없이 본 개인정보 처리방침을 통하여 공개하도록 하겠습니다.</p>
								<em class="mt20">4.정보주체의 권리,의무 및 그 행사방법 이용자는 개인정보주체로서 다음과 같은 권리를 행사할 수 있습니다.</em>
								<p class="mt05">① 정보주체는 inus 서비스센터(‘http://cs.inusbath.com’이하 ‘inus 서비스센터 홈페이지) 에 대해 언제든지 다음 각 호의 개인정보 보호 관련 권리를 행사할 수 있습니다.</p>
								<p class="mt05">1. 개인정보 열람요구</p>
								<p class="mt05">2. 오류 등이 있을 경우 정정 요구</p>
								<p class="mt05">3. 삭제요구</p>
								<p class="mt05">4. 처리정지 요구</p>
								<p class="mt05">② 제1항에 따른 권리 행사는 inus 서비스센터(‘http://cs.inusbath.com’이하 ‘inus 서비스센터 홈페이지) 에 대해 개인정보 보호법 시행규칙 별지 제8호 서식에 따라 서면, 전자우편, 모사전송(FAX) 등을 통하여 하실 수 있으며 &#60;기관/회사명&#62;(‘사이트URL’이하 ‘사이트명) 은(는) 이에 대해 지체 없이 조치하겠습니다.</p>
								<p class="mt05">③ 정보주체가 개인정보의 오류 등에 대한 정정 또는 삭제를 요구한 경우에는 &#60;기관/회사명&#62;(‘사이트URL’이하 ‘사이트명) 은(는) 정정 또는 삭제를 완료할 때까지 당해 개인정보를 이용하거나 제공하지 않습니다.</p>
								<p class="mt05">④ 제1항에 따른 권리 행사는 정보주체의 법정대리인이나 위임을 받은 자 등 대리인을 통하여 하실 수 있습니다.</p>
								<p class="mt05">이 경우 개인정보 보호법 시행규칙 별지 제11호 서식에 따른 위임장을 제출하셔야 합니다.</p>
								<em class="mt20">5. 처리하는 개인정보의 항목 작성</em>
								<p class="mt05">① &#60;inus 서비스센터&#62;('http://cs.inusbath.com'이하 'inus 서비스센터 홈페이지')은(는) 다음의 개인정보 항목을 처리하고 있습니다.</p>
								<p class="mt05">- 필수항목 : 이메일, 휴대전화번호, 이름, 접속 로그, 쿠키</p>
								<p class="mt05">② 추가정보 제공을 원하지 않는 경우 수집하지 않으며, 미동의로 인해 이용상의 어떤 불이익도 발생하지 않습니다.</p>
								<em class="mt20">6. 개인정보의 파기</em>
								<p class="mt05">&#60;inus 서비스센터&#62;('inus 서비스센터 홈페이지')은(는) 원칙적으로 개인정보 처리목적이 달성된 경우에는 지체 없이 해당 개인정보를 파기합니다. 파기의 절차, 기한 및 방법은 다음과 같습니다.</p>
								<p class="mt05">- 파기절차</p>
								<p class="mt05">이용자가 입력한 정보는 목적 달성 후 별도의 DB에 옮겨져(종이의 경우 별도의 서류) 내부 방침 및 기타 관련 법령에 따라 일정기간 저장된 후 혹은 즉시 파기됩니다. 이 때, DB로 옮겨진 개인정보는 법률에 의한 경우가 아니고서는 다른 목적으로 이용되지 않습니다.-파기기한이용자의 개인정보는 개인정보의 보유기간이 경과된 경우에는 보유기간의 종료일로부터 5일 이내에, 개인정보의 처리 목적 달성, 해당 서비스의 폐지, 사업의 종료 등 그 개인정보가 불필요하게 되었을 때에는 개인정보의 처리가 불필요한 것으로 인정되는 날로부터 5일 이내에 그 개인정보를 파기합니다. </p>
								<p class="mt05">- 파기방법</p>
								<p class="mt05">전자적 파일 형태의 정보는 기록을 재생할 수 없는 기술적 방법을 사용합니다.</p>
								<p class="mt05">종이에 출력된 개인정보는 분쇄기로 분쇄하거나 소각을 통하여 파기합니다. </p>
								<em class="mt20">7. 개인정보의 안전성 확보 조치</em>
								<p class="mt05">&#60;inus 서비스센터&#62;('inus 서비스센터 홈페이지')은(는) 개인정보보호법 제29조에 따라 다음과 같이 안전성 확보에 필요한 기술적/관리적 및 물리적 조치를 하고 있습니다.</p>
								<p class="mt05">1. 정기적인 자체 감사 실시</p>
								<p class="mt05">개인정보 취급 관련 안정성 확보를 위해 정기적(반기 1회)으로 자체 감사를 실시하고 있습니다</p>
								<p class="mt05">2. 개인정보 취급 직원의 최소화 및 교육</p>
								<p class="mt05">개인정보를 취급하는 직원을 지정하고 담당자에 한정시켜 최소화 하여 개인정보를 관리하는 대책을 시행하고 있습니다.</p>
								<p class="mt05">3. 내부관리계획의 수립 및 시행</p>
								<p class="mt05">개인정보의 안전한 처리를 위하여 내부관리계획을 수립하고 시행하고 있습니다.</p>
								<p class="mt05">4. 해킹 등에 대비한 기술적 대책</p>
								<p class="mt05">&#60;inus 서비스센터&#62;('inus 서비스센터 홈페이지')은 해킹이나 컴퓨터 바이러스 등에 의한 개인정보 유출 및 훼손을 막기 위하여 보안프로그램을 설치하고 주기적인 갱신·점검을 하며 외부로부터 접근이 통제된 구역에 시스템을 설치하고 기술적/물리적으로 감시 및 차단하고 있습니다</p>
								<p class="mt05">5. 접속기록의 보관 및 위,변조 방지</p>
								<p class="mt05">개인정보처리시스템에 접속한 기록을 최소 6개월 이상 보관, 관리하고 있으며, 접속 기록이 위,변조 및 도난, 분실되지 않도록 보안기능 사용하고 있습니다.</p>
								<p class="mt05">6. 개인정보에 대한 접근 제한</p>
								<p class="mt05">개인정보를 처리하는 데이터베이스시스템에 대한 접근권한의 부여,변경,말소를 통하여 개인정보에 대한 접근통제를 위하여 필요한 조치를 하고 있으며 침입차단시스템을 이용하여 외부로부터의 무단 접근을 통제하고 있습니다.</p>
								<p class="mt05">7. 문서보안을 위한 잠금 장치 사용</p>
								<p class="mt05">개인정보가 포함된 서류, 보조저장매체 등을 잠금 장치가 있는 안전한 장소에 보관하고 있습니다.</p>
								<p class="mt05">8. 비 인가자에 대한 출입 통제</p>
								<p class="mt05">개인정보를 보관하고 있는 물리적 보관 장소를 별도로 두고 이에 대해 출입통제 절차를 수립, 운영하고 있습니다.</p>
								<em class="mt20">8. 개인정보 보호책임자 작성</em>
								<p class="mt05">① inus 서비스센터(‘http://cs.inusbath.com’이하 ‘inus 서비스센터 홈페이지) 은(는) 개인정보 처리에 관한 업무를 총괄해서 책임지고, 개인정보 처리와 관련한 정보주체의 불만처리 및 피해구제 등을 위하여 아래와 같이 개인정보 보호책임자를 지정하고 있습니다.</p>
								<p class="mt05">▶ 개인정보 보호책임자</p>
								<p class="mt05">성명 :홍덕기</p>
								<p class="mt05">직급 :상무</p>
								<p class="mt05">연락처 :02-3218-6873, foreverkhm@isdongseo.co.kr, 02-512-5100</p>
								<p class="mt05">※ 개인정보 보호 담당부서로 연결됩니다.</p>
								<p class="mt05">▶ 개인정보 보호 담당부서</p>
								<p class="mt05">부서명 :경영개선팀</p>
								<p class="mt05">담당자 :김성욱</p>
								<p class="mt05">연락처 :02-3218-6836, 990029@isdongseo.co.kr , 02-512-5100</p>
								<p class="mt05">② 정보주체께서는 inus 서비스센터(‘http://cs.inusbath.com’이하 ‘inus 서비스센터 홈페이지) 의 서비스(또는 사업)을 이용하시면서 발생한 모든 개인정보 보호 관련 문의, 불만처리, 피해구제 등에 관한 사항을 개인정보 보호책임자 및 담당부서로 문의하실 수 있습니다. inus 서비스센터(‘http://cs.inusbath.com’이하 ‘inus 서비스센터 홈페이지) 은(는) 정보주체의 문의에 대해 지체 없이 답변 및 처리해드릴 것입니다</p>
								<em class="mt20">9. 개인정보 열람청구</em>
								<p class="mt05">① 정보주체는 개인정보 보호법 제35조에 따른 개인정보의 열람 청구를 아래의 부서에 할 수 있습니다. &#60;inus 서비스센터&#62;(‘http://cs.inusbath.com'이하 'inus 서비스센터 홈페이지')은(는) 정보주체의 개인정보 열람청구가 신속하게 처리되도록 노력하겠습니다.</p>
								<p class="mt05">▶ 개인정보 열람청구 접수·처리 부서</p>
								<p class="mt05">부서명 : 인사팀</p>
								<p class="mt05">담당자 : 이영렬</p>
								<p class="mt05">연락처 : 02-3218-6622, 202juno@isdongseo.co.kr, 02-512-5100</p>
								<p class="mt05">② 정보주체께서는 제1항의 열람청구 접수․처리부서 이외에, 행정안전부의 ‘개인정보보호 종합지원 포털’ 웹사이트(www.privacy.go.kr)를 통하여서도 개인정보 열람청구를 하실 수 있습니다</p>
								<p class="mt05">▶ 행정안전부 개인정보보호 종합지원 포털 → 개인정보 민원 → 개인정보 열람등 요구 (본인확인을 위하여 아이핀(I-PIN)이 있어야 함)</p>
								<em class="mt20">10.권익침해 구제방법</em>
								<p class="mt05">아래의 기관은 &#60;사업자/단체명&#62; 과는 별개의 기관으로서, &#60;inus 서비스센터&#62;(‘http://cs.inusbath.com'이하 'inus 서비스센터 홈페이지')의 자체적인 개인정보 불만처리, 피해구제 결과에 만족하지 못하시거나 보다 자세한 도움이 필요하시면 문의하여 주시기 바랍니다.</p>
								<p class="mt05">▶ 개인정보 침해신고센터 (한국인터넷진흥원 운영) </p>
								<p class="mt05">- 소관업무 : 개인정보 침해사실 신고, 상담 신청 </p>
								<p class="mt05">- 홈페이지 : privacy.kisa.or.kr </p>
								<p class="mt05">- 전화 : (국번없이) 118 </p>
								<p class="mt05">- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터 </p>
								<p class="mt05">▶ 개인정보 분쟁조정위원회 (한국인터넷진흥원 운영 </p>
								<p class="mt05">- 소관업무 : 개인정보 분쟁조정신청, 집단분쟁조정 (민사적 해결) </p>
								<p class="mt05">- 홈페이지 : privacy.kisa.or.kr </p>
								<p class="mt05">- 전화 : (국번없이) 118 </p>
								<p class="mt05">- 주소 : (138-950) 서울시 송파구 중대로 135 한국인터넷진흥원 개인정보침해신고센터 </p>
								<p class="mt05">▶ 대검찰청 사이버 범죄 수사단 : 02-3480-3573 (www.spo.go.kr)</p>
								<p class="mt05">▶ 경찰청 사이버 범죄 수사단 : 1566-0112 (www.netan.go.kr)</p>
								<em class="mt20">11. 개인정보 처리방침 변경</em>
								<p class="mt05">①이 개인정보처리방침은 시행일로부터 적용되며, 법령 및 방침에 따른 변경내용의 추가, 삭제 및 정정이 있는 경우에는 변경사항의 시행 7일 전부터 공지사항을 통하여 고지할 것입니다.</p>
							</div>
							<span class="chkbox pl10 mt10">
								<label class="label_txt">
									<input type="checkbox" value="" name="privteCk" id="privteCk" class="allChk">
									<span class="txt">동의</span>
								</label>
							</span>
						</dd>
					</dl>
				</div>
				<!--// cont -->
			</div>
		</div>
		<!--// ing_bx (step2) -->

		<div class="ing_bx nobg">
			<div class="box">
				<div class="tit drop">Step2. 고객 정보 입력<span class="star">필수입력사항</span></div>
				<div class="cont">
					<dl class="type02">
						<dt>예약날짜 선택</dt>
						<dd>
							<div class="dateWrap">
								<ul class="info_color">
									<li class="y">예약가능일</li>
									<li class="s">선택일</li>
								</ul>
								<div class="ymd">
									<a href="javascript:;" id="btnPrev" class="prev">이전</a>
									<span id="currentDate"></span>
									<a href="javascript:;" id="btnNext" class="next">다음</a>
								</div>
									<div class="month" id="calendar">
								</div>
							</div><!--// dateWrap -->
						</dd>
					</dl>
					<div class="choice_bx one">
						<dl>
							<dt>선택일 :</dt>
							<dd><span id="selectText" class="fc-blue">날짜를 선택하세요</span></dd>
						</dl>
					</div>
					<p class="mark">
						고객 센터 운영시간은 평일 9시~18시입니다.<br>
		                (단, 토/일,공휴일은 휴무 , 점심시간 12시~13시 제외)<br>
						전문 엔지니어가 확인 후 전화드리겠습니다.
		            </p>
				</div>
				<!--// cont -->
			</div>
		</div>
		<!--// ing_bx (step3) -->
		<div class="btnWrap wide pd15">
			<a href="#none" class="btn gray">예약취소</a>
			<a href="#none" id="okBtn" class="btn blue">예약신청</a>
		</div>
	</section>
	<!--// sub -->
	</form>
</body>
</html>
