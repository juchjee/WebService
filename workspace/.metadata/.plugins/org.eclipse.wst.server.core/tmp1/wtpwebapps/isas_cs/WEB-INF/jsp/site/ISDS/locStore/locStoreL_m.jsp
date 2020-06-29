<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<script type="text/javascript">
	
		function init(){

			$("#pagingNavi").removeClass("al");
			
			/*  취급품목 SELECTBOX 선택 텍스트 */
			if("${boardCateSeq}" != ""){
				$("#mapStoreItem div div span").text("");
				$("#mapStoreItem div div span").text($("[name=mapStoreItem] option:selected").text());
			}
			
			/* 주소검색 SELECTBOX 변수*/
			var searchSum = 0;
			var searchSum2 = 0;
			
			/* 주소검색 SELECTBOX1 셋팅 */
			fnAjax("${rootUri}${conUrl}zipcodeSearch.action", {"addressLev1":$("#addressLev1").val()}, // selectbox1의 값으로 DB값 조회
					function(data, dataType){
						
						var selectSpan = $("#addressLev1Div div div span");
						var selectUl = $("#addressLev1Div ul");
						
						var selectSpan2 = $("#addressLev2Div div div span");
						var selectUl2 = $("#addressLev2Div ul");
				
						searchSum++;
						searchSum2++;
						
						$("#addressLev1").html("<option value=''>도/시 전체</option>");
						
						for (key in data) {
							var index = parseInt(key)+parseInt(1);
							if("${addressLev1}" == data[key].addressLev1){
								selectSpan.text("");
								selectSpan.text(data[key].addressLev1);
								selectUl.append("<li><a href='#' index='"+index+"' class='selected'>"+data[key].addressLev1+"</a></li>");
								$("#addressLev1").append("<option value='"+data[key].addressLev1+"' selected>"+data[key].addressLev1+"</option>");
								
								if($("#addressLev1").val() != ""){
									fnAjax("${rootUri}${conUrl}zipcodeSearch.action", {"addressLev1":$("#addressLev1").val()}, // selectbox1의 값으로 DB값 조회
											function(data, dataType){
												for (key in data) {
													var index2 = parseInt(key)+parseInt(1);
													if("${addressLev2}" == data[key].addressLev2){
														selectSpan2.text("");
														selectSpan2.text(data[key].addressLev2);
														selectUl2.append("<li><a href='#' index='"+index2+"' class='selected'>"+data[key].addressLev2+"</a></li>");
														$("#addressLev2").append("<option value='"+data[key].addressLev2+"' selected>"+data[key].addressLev2+"</option>");
													}else{
														selectUl2.append("<li><a href='#' index='"+index2+"'>"+data[key].addressLev2+"</a></li>");
														$("#addressLev2").append("<option value='"+data[key].addressLev2+"'>"+data[key].addressLev2+"</option>");
													}
												}
											}
									);
								}
								
							}else{
								$("#addressLev1Div ul").append("<li><a href='#' index='"+index+"'>"+data[key].addressLev1+"</a></li>");
								$("#addressLev1").append("<option value='"+data[key].addressLev1+"'>"+data[key].addressLev1+"</option>");
							}
						}
					},"POST" //function
			);//fnAjax
			
			
			/* 주소검색 SELECTBOX1 클릭 이벤트 */
			$("#addressLev1Div").bind("click", function(){ // selectbox1 클릭시

				if($("#addressLev1Div ul li a") != undefined){ // selectbox1의 option이라 볼 수 있는 것들이 존재한다면
					
					var selectSpan = $("#addressLev1Div div div span");
					var selectUl = $("#addressLev1Div ul");
					
					var selectSpan2 = $("#addressLev2Div div div span");
					var selectUl2 = $("#addressLev2Div ul");
					
					var addressLev1Original = $("#addressLev1").val();
					
					$("#addressLev1Div ul li a").bind("click", function(){ // selectbox1의 option이라 볼 수 있는 것들이 클릭 되었다면
						selectSpan.text("");
						selectSpan.text($(this).text());
						selectUl.attr("style","visibility: visible; display: none;");
						
						$("#addressLev1 option:contains('"+$(this).text()+"')").prop("selected", "selected");
						
						var addressLev1 = "";
						if(selectSpan.text() == "도/시 선택"){
						}else{
							addressLev1 = selectSpan.text();
						}
						
							if(selectSpan.text() != addressLev1Original){
								fnAjax("${rootUri}${conUrl}zipcodeSearch.action", {"addressLev1":addressLev1}, // selectbox1의 값으로 DB값 조회
									function(data, dataType){
										searchSum++;
										
										if(searchSum == 1){ //로딩 직후 : addressLev1,2 for문을 돌린다.
											searchSum2++;
											//addressLev1
											$("#addressLev1").html("<option value=''>도/시 전체</option>");
											for (key in data) {
												var index = parseInt(key)+parseInt(1);
												if("${addressLev1}" == data[key].addressLev1){
													selectUl.append("<li><a href='#' index='"+index+"' class='selected'>"+data[key].addressLev1+"</a></li>");
													$("#addressLev1").append("<option value='"+data[key].addressLev1+"' selected>"+data[key].addressLev1+"</option>");
												}else{
													selectUl.append("<li><a href='#' index='"+index+"'>"+data[key].addressLev1+"</a></li>");
													$("#addressLev1").append("<option value='"+data[key].addressLev1+"'>"+data[key].addressLev1+"</option>");
												}
											}
											//addressLev2
											if($("#addressLev1").val() != ""){
												for (key in data) {
													var index = parseInt(key)+parseInt(1);
													if("${addressLev2}" == data[key].addressLev2){
														selectSpan2.text("");
														selectSpan2.text(data[key].addressLev2);
														selectUl2.append("<li><a href='#' index='"+index+"' class='selected'>"+data[key].addressLev2+"</a></li>");
														$("#addressLev2").append("<option value='"+data[key].addressLev2+"' selected>"+data[key].addressLev2+"</option>");
													}else{
														selectSpan2.text("");
														selectSpan2.text("시/군/구 전체");
														selectUl2.append("<li><a href='#' index='"+index+"'>"+data[key].addressLev2+"</a></li>");
														$("#addressLev2").append("<option value='"+data[key].addressLev2+"'>"+data[key].addressLev2+"</option>");
													}
												}
											}
										}else{ //로딩 후 선택한 경우
											if($("#addressLev1").val() == ""){
												selectSpan2.text("");
												selectSpan2.text("시/군/구 전체");
												selectUl2.html("<li><a href='#' index='0' class='selected'>시/군/구 전체</a></li>");
												$("#addressLev2 option").remove();
												$("#addressLev2").html("<option value=''>시/군/구 전체</option>");
											}else{
												selectSpan2.text("");
												selectSpan2.text("시/군/구 전체");
												selectUl2.html("<li><a href='#' index='0' class='selected'>시/군/구 전체</a></li>");
												$("#addressLev2").html("<option value=''>시/군/구 전체</option>");
												for (key in data) {
													var index = parseInt(key)+parseInt(1);
													if(searchSum2 == 1){
														if("${addressLev2}" == data[key].addressLev2){
															selectSpan2.text("");
															selectSpan2.text(data[key].addressLev2);
															selectUl2.append("<li><a href='#' index='"+index+"' class='selected'>"+data[key].addressLev2+"</a></li>");
															$("#addressLev2").append("<option value='"+data[key].addressLev2+"' selected>"+data[key].addressLev2+"</option>");
														}else{
															selectSpan2.text("");
															selectSpan2.text("시/군/구 전체");
															selectUl2.append("<li><a href='#' index='"+index+"'>"+data[key].addressLev2+"</a></li>");
															$("#addressLev2").append("<option value='"+data[key].addressLev2+"'>"+data[key].addressLev2+"</option>");
														}
													}else{
														selectSpan2.text("");
														selectSpan2.text("시/군/구 전체");
														selectUl2.append("<li><a href='#' index='"+index+"'>"+data[key].addressLev2+"</a></li>");
														$("#addressLev2").append("<option value='"+data[key].addressLev2+"'>"+data[key].addressLev2+"</option>");
													}
												}
											}
											searchSum2++;
										}//else
									},"POST" //function
								);//fnAjax					
							}
				 	
					});//click
					
				}//if
					
			});//click

			/* 주소검색 SELECTBOX2 클릭 이벤트 */
			$("#addressLev2Div").bind("click", function(){ // selectbox2 클릭시
				$("#addressLev2Div ul li a").bind("click", function(){
					$("#addressLev2 option:contains('"+$(this).text()+"')").prop("selected", "selected");
					$("#addressLev2Div div div span").text("");
					$("#addressLev2Div div div span").text($(this).text());											
					$("#addressLev2Div ul").attr("style","visibility: visible; display: none;");
				});
			});
			
			
			var seq = $("#boardCateSeq").val();
			if(seq==""){
				$("#col1").addClass("on");
			}
			else{
				$("#col"+seq).addClass("on");
			}

		}
		
		function noticeCate(code){
			$("#page").val(1);
			var mapStoreItem = document.locStoreForm.mapStoreItem;
			if(mapStoreItem != undefined){
				$("#boardCateSeq").val(mapStoreItem.value);
				if(mapStoreItem.value == ""){
					$("[name=mapStoreItem]").remove();	
				}
			}
			document.locStoreForm.action = "locStoreL.do?pageCd=${boardMstCd}";
			document.locStoreForm.submit();
		}
		
		function fnPageCdChange(code){
			$("#page").val(1);
			var mapStoreItem = document.locStoreForm.mapStoreItem;
			if(mapStoreItem != undefined){
				$("#boardCateSeq").val(mapStoreItem.value);
				if(mapStoreItem.value == ""){
					$("[name=mapStoreItem]").remove();	
				}
			}
			document.locStoreForm.action = "locStoreL.do?pageCd="+code;
			document.locStoreForm.submit();
		}
		
		

		function noticeView(seq){
			$("#boardSeq").val(seq);
			document.locStoreForm.action = "bbt00001V.do?pageCd=${boardMstCd}";
		   	document.locStoreForm.submit();
		}
		
		function fnGoView(id){
			$("#mapStoreId").val(id);
			document.locStoreForm.action = "locStoreV.do?pageCd=${boardMstCd}";
		   	document.locStoreForm.submit();
		}

		function doPage(pageNum){
			var mapStoreItem = document.locStoreForm.mapStoreItem;
			if(mapStoreItem != undefined){
				if(mapStoreItem.value == ""){
					$("[name=mapStoreItem]").remove();	
				}
			}
			document.locStoreForm.page.value = pageNum;
	    	document.locStoreForm.action = "locStoreL.do?pageCd=${boardMstCd}";
	       	document.locStoreForm.submit();
		}
	
		
	</script>
</head>

<body>
		<section class="sub">
		
		<form id="locStoreForm" name="locStoreForm" method="post">
			<input type="hidden" id="boardSeq" name="boardSeq" />
			<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
			<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${boardCateSeq}" />
			<input type="hidden" id="mapStoreId" name="mapStoreId" value="" />
			<input type="hidden" id="page" name="page" value="${param.page}"/>
		
			<div class="tit_bx">
				<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
				<c:choose>
				<c:when test="${boardMstCd eq 'BBM00057'}">
					<h2>전시장 찾기</h2>
				</c:when>
				<c:when test="${boardMstCd eq 'BBM00058'}">
					<h2>A/S센터 찾기</h2>
				</c:when>
				<c:when test="${boardMstCd eq 'BBM00059'}">
					<h2>대리점</h2>	
				</c:when>
				<c:otherwise>
					<h2></h2>
				</c:otherwise>
			</c:choose>
			</div>
			<!--// tit_bx -->
			<div class="sch_area type01">
				<c:if test="${fn:length(cateList) > 1}">
					<div class="select_guide w100" id="mapStoreItem">
						<select class="m_select select01" name="mapStoreItem" id="ct_select">
							<option value="">취급품목 선택</option>
							<c:forEach items="${cateList}" var="cateList" varStatus="loop">
								<option value="${cateList.boardCateSeq}" <c:if test="${cateList.boardCateSeq eq boardCateSeq}">selected</c:if> >${cateList.boardCateNm}</option>
							</c:forEach>
						</select>
					</div>
				</c:if>
				<div class="twoSelect">
					<div class="select_guide" id="addressLev1Div">
						<select class="m_select select01" name="addressLev1" id="addressLev1">
							<option value="">도/시 선택</option>
						</select>
					</div>
					<div class="select_guide" id="addressLev2Div">
						<select class="m_select select01" name="addressLev2" id="addressLev2">
							<option value="">시/군/구 선택</option>
						</select>
					</div>
				</div>
				<div class="btnWrap">
					<a href="#" class="btn blue" onclick="noticeCate('');">검색</a>
				</div>
			</div>
			<!-- //sch_area -->
			<div class="content">
				<div class="board_area">
					<div class="box_tit">
						<p class="tit">전체<span>${totalCnt}</span>건</p>
						<div class="select_guide w30">
							<select class="m_select select01" name="pageCd" id="pageCd" onchange="fnPageCdChange(this.value);">
								<option value="BBM00057" <c:if test="${param.pageCd eq 'BBM00057'}">selected</c:if> >전시장</option>
								<option value="BBM00058" <c:if test="${param.pageCd eq 'BBM00058'}">selected</c:if> >A/S센터</option>
								<option value="BBM00059" <c:if test="${param.pageCd eq 'BBM00059'}">selected</c:if> >대리점</option>
							</select>
						</div>
					</div>
					<div class="board">
						<table>
							<caption>전시장 검색결과 목록</caption>
							<tbody>
								<c:forEach items="${mapList}" var="mapList" varStatus="loop">
									<tr>
										<td class="subject">
											<a href="#" class="tit" onclick="fnGoView('${mapList.mapStoreId}');">
												<p>${mapList.mapStoreTitle}</p>
												<span class="addr">${mapList.mapStoreAddr}</span>
											</a>
										</td>
									</tr>
								</c:forEach>
								<c:if test="${empty mapList}">
									<tr>
										<td class="subject">
							                <p>내용이 없습니다.</p>
							            </td>
						           	</tr>
					            </c:if>
							</tbody>
						</table>
					</div>
					<!-- //board -->
				</div>
				<!-- //board_area -->
	
			</div>
	
		<c:out value="${pageTag}" escapeXml="false" />
	
		</form>
	
		</section>
		<!--// sub -->
</body>

