<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />
	<!-- 게시판관리 : 공지사항 등록 -->

	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
<script type="text/javaScript" defer="defer">

	function init(){

		fnEvent();
		fnDataSetting();
		  
		$("#fancyboxImg").fancybox({
			beforeShow: function(){
				this.width = 550;
		        this.height = 350;
		    }
		});
	}



	function fnEvent(){
		$("#statBc").bind("change", function(){
			if($("#statBc").val() == "AS204800"){
				$("#custCd").val("");
				$("#custCd").attr("disabled", true);
				$("#reArea").val("");
				$("#reArea").attr("disabled", true);
			}else{
				$("#custCd").attr("disabled", false);
				$("#reArea").attr("disabled", false);
			}
		});
		
		$.attfileAdd = function(className,len){
			$("."+className).append("<div class=\"attfileAdd\" style=\"margin-top:5px;\">"+
				"	<div  class=\"fl\">"+
		        "		<input type=\"text\" name=\"dtlFileName\" class=\"fl verT marL5\" style=\"width:400px;\" /><a class=\"fl dtlImg btn_type1 marL10\" href=\"javascript:;\">파일찾기</a>"+
		        "		<a href=\"javascript:;\"  class=\"fl fileAdd btn_type4\">+</a>"+
		        "	</div>"+
	    		"</div>");


				$(".attfileAdd > div > .fileAdd").unbind("click");
				$(".attfileAdd > div > .fileAdd").bind("click",function() {

					if($(this).text() == "+"){
						/*popup update start*/
						var nowHeight = $(".noBg").css("height").replace(/\px/gi,'');
						$(".noBg").css("height", (parseInt(nowHeight)+33)+"px");
						parent.$.fancybox.update();
						/*popup update end*/

						$(this).removeClass("btn_type4");
						$(this).addClass("btn_type5");
						$(this).text("-");
						$.attfileAdd(className,$('.attfileAdd').length);
					}else if($(this).text() == "-"){

						/*popup update start*/
						var nowHeight = $(".noBg").css("height").replace(/\px/gi,'');
						$(".noBg").css("height", (parseInt(nowHeight)-33)+"px");
						parent.$.fancybox.update();
						/*popup update end*/

						var fileAddIdx = $(".attfileAdd > div > .fileAdd").index(this);
				 		var fileId = "dtlFilePath_"+fileAddIdx;
					 	$("form[name=workForm]").find("input[name=dtlFilePath_seq]").eq(fileAddIdx).remove();
					 	$("form[name=workForm]").find("input[class="+fileId+"]").remove();

					 	$(".attfileAdd").eq(fileAddIdx).remove();

						$("form[name=workForm]").find("input[name=dtlFilePath]").each(function(index, item){
							var reClassNameArr = $(this).attr("class").split("_");
				            var reClassName = reClassNameArr[0];

			            	var seqInput = $("form[name=workForm]").find("input[name=dtlFilePath_seq]");

				            if(reClassNameArr[1] > fileAddIdx){
					            var reClassIdx = (reClassNameArr[1]-1);
				            	$(this).attr("class",reClassName+"_"+reClassIdx);
				            	seqInput.eq(index).val(reClassIdx);
				            }
				        });
					}else{
						return false;
					}
				});

				$(".dtlImg").unbind("click");
				/*----------------------------- 상세이미지 - 파일 찾기 버튼 클릭 이벤트(소멸성이벤트) -----------------------------*/
				$(".dtlImg").bind("click",function() {
					//확장형 첨부일 경우 인덱스 인자 추가 전달
					var idx = $(".dtlImg").index(this);
					//파라메터 값 object 형
				  		var obj = new Object();
				  		obj.fileAttrName = "dtlFilePath"; //실제 전달할 파일 속성명
				  	   	obj.fileViewAttrName = "dtlFileName"; //현재 노출되는 속성명 name
				  	   	obj.form = "workForm"; //전송할 form name
				  	   	//obj.filetype = "image"; //파일 제한 종류 -- image (현재 이미지만 구현)
				  	   	obj.index = idx; //확장형 첨부파일일 경우 사용될 인덱스
					fileSearch(obj);
				});

				
		}
		
		
		/*고장증상*/
		$("#ascodeLev1").bind("change",function(){
			var codeTp = "";
			if($("#ascodeLev1").val() == ""){
				codeTp = "L";
				var data = $.lvalue;
			}else{
				codeTp = "M";
				data = $("#ascodeLev1").val();
			}
			fnAjax("ascodeList.action", {"codeTp":codeTp,"itmGubun":$.lvalue,"lvalue":data,"asBc":"100"},	//20190507 asBc 추가 [A/S증상대분류]
					function(data, dataType){
						if($("#ascodeLev1").val() == ""){
							$("#ascodeLev1").html("<option value=''>고장증상 대분류</option>");
							for (key in data) {
								if('${csInfo.ascodeLev1}' == data[key].value){
									$("#ascodeLev1").append("<option value='"+data[key].value+"' selected='selected'>"+data[key].label+"</option>");
								}else{
									$("#ascodeLev1").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
								}
							}
							if($("#ascodeLev1").val() != ""){
								$("#ascodeLev1").change();
							}
						}else{
							$("#ascodeLev2").html("<option value=''>고장증상 중분류 </option>");
							for (key in data) {
								if('${csInfo.ascodeLev2}' == data[key].value){
									$("#ascodeLev2").append("<option value='"+data[key].value+"' selected='selected'>"+data[key].label+"</option>");
								}else{
									$("#ascodeLev2").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
									
								}
							}
						}
					},"POST"
				);
		});
		
		
		
		
		$("#modelItemCd").bind("change", function(){
			if($(this).val() == 0 || $(this).val() == 1 || $(this).val() == 2 ){
// 				$.lvalue = "m1";
				$("#inpBc").val("AS110100");
			}else if($(this).val() == 4){
// 				$.lvalue = "m2";
				$("#inpBc").val("AS110200");
			}else{
// 				$.lvalue = "m3";
				$("#inpBc").val("AS110300");
			}
			
			if($(this).val() == 0){
				$.lvalue = "SDH0809";
			}else if($(this).val() == 1){
				$.lvalue = "SDH0817";
			}else if($(this).val() == 2){
				$.lvalue = "SDH0802";
			}else if($(this).val() == 3){
				$.lvalue = "SDH0818";
			}else if($(this).val() == 4){

				$.lvalue = "";
				$.itmGubunList();
				return;
			}
			
			$.itmGubunList();

// 			$("#modelItemCd").val($(this).index());
			$("#ascodeLev1").val("");
			$("#ascodeLev2").html("<option value=''>고장증상 중분류 </option>");
			$("#ascodeLev1").change();

			$.modelList();
		});
		
		/*품목 이벤트 - 이누스바스 선택시 */
		$("#itmGubun").bind("change",function(){
			$("#itmGubun").val($(this).val());
			$.lvalue = $(this).val();
			$("#ascodeLev1").change();
			$.modelList();
		});
		/*품목 리스트*/
		$.itmGubunList = function(){
			fnAjax("itmGubunList.action", {"itmGubun":$.lvalue},
					function(data, dataType){
						if(data.length > 1){
							$("#itmGubun").html("<option value=''>선택하세요!</option>");
						}else{
							$("#itmGubun").html("");
						}
						for (key in data) {
							if('${csInfo.itmGubun}' == data[key].value){
								$("#itmGubun").append("<option value='"+data[key].value+"' selected='selected'>"+data[key].label+"</option>");
								$.lvalue = data[key].value;
							}else{
								$("#itmGubun").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
							}
							
						}
						
						$.modelList();
						$("#ascodeLev1").val("");
						$("#ascodeLev2").html("<option value=''>고장증상 중분류 </option>");
						$("#ascodeLev1").change();

					},"POST"
				);
		}
		
		/*모델리스트*/
		$.modelList = function(){
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
            $("#model").jqxComboBox({ selectedIndex: -1, source: dataAdapter, displayMember: "label", valueMember: "value", width: "250px", height: 30,	promptText: "모델을 선택하세요!"});

            $("#model").jqxComboBox('selectItem','${csInfo.model}');
			
// 			fnAjax("modelList.action", {"itmGubun":$.lvalue},
// 				function(data, dataType){
// 					$("#model").html("<option value=''>선택하세요!</option>");
// 					for (key in data) {
// 						if('${csInfo.model}' == data[key].value){
// 							$("#model").append("<option value='"+data[key].value+"' selected='selected'>"+data[key].label+"</option>");
// 						}else{
// 							$("#model").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
// 						}
						
// 					}
// 				},"POST"
// 			);
		}
		
		
		/*대리점리스트*/
		$.custCdList = function(tabCd){
			var url = "custCd.action?tabCd="+tabCd;
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
            $("#custCd").jqxComboBox({ selectedIndex: -1, source: dataAdapter, displayMember: "label", valueMember: "value", width: "250px", height: 30,	promptText: "모델을 선택하세요!"});

            $("#custCd").jqxComboBox('selectItem','${csInfo.custCd}');			
			
			
// 			fnAjax("custCd.action", {"tabCd":tabCd},
// 					function(data, dataType){
// 						$("#custCd").html("<option value=''>선택하세요!</option>");
// 						for (key in data) {
// 							$("#custCd").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
// 						}

// 						$("#custCd").val("${csInfo.custCd}");
// 					},"POST"
// 				);
		}
		
		

		$.submit = function(){
			if($("#ascodeLev2").val() == ""){
				alert("고장증상 중분류는 필수값입니다.");
				$("#ascodeLev2").focus();
				return false;
			}
			if($("#statBc").val() == '0'){
				$("#workForm").submit();
			}else{
			fnSubmit("workForm","저장");
			}
		}

		$.dtlAttDel = function(attchCd,idx){
			if(confirm("삭제하시겠습니까?")){
				fnAjax("bbt00001FD.action", {"attchCd" : attchCd}, function(data, dataType){
					$(".nowDtlAtt").eq(idx).html("");
					var data = data.replace(/\s/gi,'');
					alert(data);
				},'POST','text');
			}
		}

		$(".popup_wrap > h2").text(parent.$("#tit_depths0").text()+" 접수");

		/** 주소 찾기 **/
		$("#addrBtn").click(function(){
			new daum.Postcode({
		        oncomplete: function(data) {
		        	// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var fullAddr = ''; // 최종 주소 변수
	                var extraAddr = ''; // 조합형 주소 변수
	                // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
	                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
	                    fullAddr = data.roadAddress;
	                } else { // 사용자가 지번 주소를 선택했을 경우(J)
	                    fullAddr = data.jibunAddress;
	                }
	                // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
	                if(data.userSelectedType === 'R'){
	                    //법정동명이 있을 경우 추가한다.
	                    if(data.bname !== ''){
//		                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
//		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
//		                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                    extraAddr = (extraAddr !== '' ? '('+ extraAddr +') ' : '');
	                }
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $('#mbrZipcode').val(data.zonecode); //5자리 새우편번호 사용
	                $('#mbrAddr').val(fullAddr);
	                // 커서를 상세주소 필드로 이동한다.
	                $('#mbrAddrDtl').val(extraAddr);
	                $('#mbrAddrDtl').focus();
		        }
		    }).open();
		});
		
		
		$("#statBc").bind("change", function(){
			if($(this).val() == 'AS204100'){
				$("input[name=smsCyn]").eq(0).attr("checked",true);
				$("input[name=smsDyn]").eq(0).attr("checked",true);
				
				//접수변경시 -- AS처리로 접수유형 자동 변경
				$("#reTy").val('AS200200');
				
			}else{
				$("input[name=smsCyn]").eq(1).attr("checked",true);
				$("input[name=smsDyn]").eq(1).attr("checked",true);
			}
		});
	}

	function fnDataSetting(){
		dateTimeInput("bookingDt", null, "${csInfo.bookingDt}");
		//$.attfileAdd("dtlfileAdd","0");
		
		$("#statBc").val('${csInfo.statBc}');
		$("#inpBc").val('${csInfo.inpBc}');
		$("#modelItemCd").val('${csInfo.modelItemCd}');
		
// 		alert('${csInfo.reArea}');
		$("#statBc").val('${csInfo.statBc}');
		$("#reArea").val('${csInfo.reArea}');
		<c:if test="${not empty csInfo.oemBc}">
			$("#oemBc").val('${csInfo.oemBc}');
		</c:if>
		
		$("#modelItemCd").change();
		$.custCdList();
		$("#statBc").change();
		$("#csTimeSeq").val('${csInfo.csTimeSeq}');

		<c:if test="${not empty csInfo.reTy}">
		$("#reTy").val('${csInfo.reTy}');
		</c:if>
		
		<c:if test="${not empty csInfo.reArea}">
		$("#reArea").val('${csInfo.reArea}');
		</c:if>
		
		<c:if test="${not empty csInfo.asAdv}">
		$("#asAdv").val('${csInfo.asAdv}');
		</c:if>
		
		<c:if test="${not empty csInfo.custCd}">
		$("#custCd").val('${csInfo.custCd}');
		</c:if>

	}

	function exDown(code){
		fnFileDownLoad(code);

	}
	
	function fnFancyboxImg(src){
		$("#fancyboxImg").attr("href",src);
		$("#fancyboxImg").click();
	}

</script>
</head>
<body class="noBg" style="height:788px;">
	<div class="popup_wrap">
		<h2></h2>
		<div class="pageContScroll_st4">
			<div class="table_type2">
			<form id="workForm" name="workForm" action="csSave.action" method="post" >
				<input type="hidden" name="asNo" id="asNo" value="${csInfo.asNo}" />
				<input type="hidden" name="csNo" id="csNo" value="${csInfo.csNo}" />
				<input type="hidden" name="tNm" id="tNm" value="${csInfo.tNm}" />
				<input type="hidden" name="seq" id="seq" value="${csInfo.seq}" />
				<input type="hidden" name="asTempNo" id="asTempNo" value="${csInfo.asTempNo}" />
				<input type="hidden" name="csType" id="csType" value="TEL" />
				
				<table>
					<caption>분류, 작성일, 제목, 내용, 첨부파일, 최초 등록자, 최초 등록일, 최근 수정자, 최근 수정일로 구성된 공지사항관리에 대한 등록 테이블 입니다.</caption>
					<colgroup>
						<col style="width:12%;">
						<col style="width:42%;">
						<col style="width:12%;">
						<col style="width:43%;">
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">신청/접수번호</th>
							<td>${csInfo.asTempNo}</td>
							<th scope="row">성명</th>
							<td>
								${csInfo.tNm}
							</td>
						</tr>
						<tr>
							<th scope="row">회원구분</th>
							<td>
								${csInfo.mbrTp}
							</td>
							<th scope="row">연락가능번호</th>
							<td>
								<input type="text" name="mbrMobile" id="mbrMobile" class="validation[required,telNo]" title="연락가능번호" value="${csInfo.tHp}" >
							</td>
						
						</tr>
						
						<tr>
							<th scope="row">주소</th>
							<td colspan="3">
								<input type="text" name="mbrZipcode" id="mbrZipcode" class="validation[required]" style="width:40px;" title="우편번호" value="${csInfo.tZipCd}" maxlength="5"> 
								<input type="text" name="mbrAddr" id="mbrAddr" class="validation[required]" style="width:250px;" title="주소" value="${csInfo.tAddr}" >
								<input type="text" name="mbrAddrDtl" id="mbrAddrDtl" class="validation[required]" style="width:250px;" title="상세주소" value="${csInfo.tAddr2}" >
								&nbsp;<a id="addrBtn" class="fieldBtn btn_type1" href="#">우편번호 찾기</a>
							</td>
						</tr>
						<tr>
							<th scope="row">진행상태</th>
							<td>
								<select id="statBc" name="statBc" style="width:100px;">
									<c:if test="${csInfo.statBc eq '0'}">
										<option value="0">처리대기</option>
									</c:if>
									<option value="AS204100">접수</option>
									<option value="AS204200">수리진행</option>
									<option value="AS204300">수리완료</option>
									<option value="AS204400">정산</option>
									<option value="AS204800">상담처리</option>
									<option value="AS204900">취소</option>
								</select>
							</td>
							<th scope="row">as입력구분</th>
							<td>
								<select id="inpBc" name="inpBc" class="validation[required]" title="as입력구분" style="width:150px;">
									<option value="AS110100">도기/수전/비데</option>
									<option value="AS110200">이누스바스</option>
									<option value="AS110300">블렌더</option>
								</select>
							</td>
							
						</tr>
						<tr>
							<th scope="row">접수유형</th>
							<td>
								<select id="reTy" name="reTy" class="validation[required]" title="접수유형" style="width:100px;">
									<option value="">선택</option>
									<option value="AS200100" selected="selected">상담처리</option>
									<option value="AS200200">A/S처리</option>
									<option value="AS200300">보상판매</option>
									<option value="AS200400">제품설치</option>
									<option value="AS200500">부품판매</option>
								</select>
							</td>
							<th scope="row">출장구역</th>
							<td>
								<select id="reArea" name="reArea" class="validation[required]" title="출장구역" style="width:150px;">
									<option value="">선택</option>
									<option value="AS201100">A구역</option>
									<option value="AS201200">B구역</option>
									<option value="AS201300">C구역</option>
									<option value="AS201400">내근지역</option>
									<option value="AS201500">동일지역</option>
									<option value="AS201600">예외지역</option>
									<option value="AS201610">비데교체</option>
									<option value="AS201620">세미리모델링</option>
									<option value="AS201700">도기교체(6만원)</option>
									<option value="AS201701">도기교체(7만원)</option>
									<option value="AS201702">도기교체(8만원)</option>
									<option value="AS201710">세면기교체</option>
									<option value="AS201720">수전기교체</option>
									<option value="AS201725">폽업교체</option>
									<option value="AS201730">도기탱크교체</option>
									<option value="AS201740">도기취소(환경적)</option>
									<option value="AS201900">0~20Km</option>
									<option value="AS201910">21~30Km</option>
									<option value="AS201920">31~40Km</option>
									<option value="AS201930">41~50Km</option>
									<option value="AS201940">51Km 이상</option>
								</select>
							</td>
							
						</tr>
						
						
						<tr>
							<th scope="row">예약일자</th>
							<td>
								<div id='bookingDt' name="bookingDt" style='float:left;'></div>
								&nbsp;
								<select id="csTimeSeq" name="csTimeSeq" style="width:120px;">
									<c:forEach items="${timeTableList}" var="timeTable" varStatus="status">
											<option value="${timeTable.csTimeSeq}">${timeTable.csTimeValue}</option>
									</c:forEach>
								</select>
							</td>
							<th scope="row">등록일</th>
							<td>
								${csInfo.regDt}
							</td>
						</tr>
						
						<tr>
							<th scope="row">제품</th>
							<td>
								<select id="modelItemCd" name="modelItemCd" class="validation[required]" title="제품" style="width:100px;">
									<option value="0">비데</option>
									<option value="1">위생도기</option>
									<option value="2">수전</option>
									<option value="3">블렌더</option>
									<option value="4">이누스바스</option>
								</select>
							</td>
							<th scope="row">OEM구분</th>
							<td>
								<select id="oemBc" name="oemBc" class="validation[required]" title="OEM구분" style="width:100px;">
									<option value="AS100100">이누스</option>
<!-- 									<option value="AS100200">애플젠</option> -->
<!-- 									<option value="AS100300">IS동서</option> -->
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">품목</th>
							<td colspan="3">
								<select id="itmGubun" name="itmGubun" class="validation[required]" title="품목" style="width:100px;"></select>
							</td>
						</tr>
						<tr>
							<th scope="row">모델</th>
							<td colspan="3">
								<div class="select_guide" id="modelSelectDiv">
									<div id='model' name="model"></div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">고장증상</th>
							<td colspan="3">
								<select name="ascodeLev1" id="ascodeLev1"  title="고장증상 대분류" class="validation[required]" >
									<option value=''>고장증상 대분류</option>
								</select>
								<select name="ascodeLev2" id="ascodeLev2" title="고장증상 중분류" class="twoPart validation[required]">
									<option value=''>고장증상 중분류</option>
								</select>
							</td>
						</tr>
						<tr>
							<th scope="row">이미지</th>
							<td colspan="3">
								<c:forEach items="${fileList}" var="fileList" varStatus="status">
									<div style="float:left;margin-right:10px;" onclick="fnFancyboxImg('${fileList.attchFilePath}');">
										<img src="${fileList.attchFilePath}" style="width:140px;height:94px;"/>
									</div>
								</c:forEach>
							</td>
							
						</tr>
						<tr>
							<th scope="row">고장증상상세</th>
							<td colspan="3">
								<textarea id="comment" name="comment" class="validation[required]" title="고장증상상세" style="width:100%;height:100px;">${csInfo.comment}</textarea>
							</td>
						</tr>
						
<!-- 						<tr> -->
<!-- 							<th scope="row">상담원</th> -->
<!-- 							<td colspan="3"> -->
								
<!-- 							</td> -->
<!-- 						</tr> -->
						<tr>
							<th scope="row">상담결과</th>
							<td colspan="3">
								<textarea id="asAdv" name="asAdv" class="validation[required]" title="상담결과" style="width:100%;height:100px;">${csInfo.asAdv}</textarea>
							</td>
						</tr>
						<tr>
							<th scope="row">대리점지정</th>
							<td colspan="3">
								<div class="select_guide" id="custCdSelectDiv">
									<div id='custCd' name="custCd"></div>
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row">SMS(고객)</th>
							<td colspan="3">
							
								<input type="radio" id="smsCy" name="smsCyn" ><label for="smsCy">발송</label> 
								<input type="radio" id="smsCn" name="smsCyn"><label for="smsCn">미발송</label> 
							</td>
						</tr>
						<tr>
							<th scope="row">SMS(대리점)</th>
							<td colspan="3">
								<input type="radio" id="smsDy" name="smsDyn"  value="Y"><label for="smsDy">발송</label> 
								<input type="radio" id="smsDn" name="smsDyn" value="N" ><label for="smsDn">미발송</label> 
							</td>
						</tr>
						<tr>
							<th scope="row">자동접수내역</th>
							<td colspan="3">
								<textarea style="width:100%;height:50px;">${csInfo.rejectMsg}</textarea>
							</td>
						</tr>
					</tbody>
				</table>
				</form>
			</div>
	</div>
	<div class="btn_area">
		<div class="center">
			<a class="btn_blue_line2" href="javascript:parent.$.fancybox.close();">닫기</a>
			<a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">완료</a>
		</div>
	</div>
	<a id="fancyboxImg" href="javascript:;"></a>
	</div>
	<!-- // table_type2 -->

</body>
</html>