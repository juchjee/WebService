<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<script src="http://maps.googleapis.com/maps/api/js"></script>
	<script type="text/javascript">
	
		
		function init(){
			mapView();

			var searchSum = 0;
			var searchSum2 = 0;
			$("#addressLev1").bind("change",function(){
				fnAjax("${rootUri}${conUrl}zipcodeSearch.action", {"addressLev1":$("#addressLev1").val()},
					function(data, dataType){
						searchSum++;
					
						if(searchSum == 1){ //로딩 직후 : addressLev1,2 for문을 돌린다.
							searchSum2++;
							//addressLev1
							$("#addressLev1").html("<option value=''>도/시 전체</option>");
							for (key in data) {
								if("${addressLev1}" == data[key].addressLev1){
									$("#addressLev1").append("<option value='"+data[key].addressLev1+"' selected>"+data[key].addressLev1+"</option>");
								}else{
									$("#addressLev1").append("<option value='"+data[key].addressLev1+"'>"+data[key].addressLev1+"</option>");
								}
							}
							//addressLev2
							if($("#addressLev1").val() != ""){
								$("#addressLev1").trigger("change");
								for (key in data) {
									if("${addressLev2}" == data[key].addressLev2){
										$("#addressLev2").append("<option value='"+data[key].addressLev2+"' selected>"+data[key].addressLev2+"</option>");
									}else{
										$("#addressLev2").append("<option value='"+data[key].addressLev2+"'>"+data[key].addressLev2+"</option>");
									}
								}
							}
						}else{ //로딩 후 선택한 경우
							if($("#addressLev1").val() == ""){
								$("#addressLev2 option").remove();
								$("#addressLev2").html("<option value=''>시/군/구 전체</option>");
							}else{
								$("#addressLev2").html("<option value=''>시/군/구 전체</option>");
								for (key in data) {
									if(searchSum2 == 1){
										if("${addressLev2}" == data[key].addressLev2){
											$("#addressLev2").append("<option value='"+data[key].addressLev2+"' selected>"+data[key].addressLev2+"</option>");
										}else{
											$("#addressLev2").append("<option value='"+data[key].addressLev2+"'>"+data[key].addressLev2+"</option>");
										}
									}else{
										$("#addressLev2").append("<option value='"+data[key].addressLev2+"'>"+data[key].addressLev2+"</option>");
									}
								}
							}
							searchSum2++;
						}//else
					},"POST" //function
				);//fnAjax					
			});
 

			$("#addressLev1").change();
			
			
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
				var mapStoreItems = "";
				for (var i = 0; i < mapStoreItem.length; i++) {
					if(mapStoreItem[i].checked == true){
						if(mapStoreItems != ""){
							mapStoreItems += ","+mapStoreItem[i].value;
						}else{
							mapStoreItems += mapStoreItem[i].value;
						}
					}
				}
				$("#boardCateSeq").val(mapStoreItems);
			}
			document.locStoreForm.action = "locStoreL.do?pageCd=${boardMstCd}";
			document.locStoreForm.submit();
		}

		function noticeView(seq){
			$("#boardSeq").val(seq);
			document.locStoreForm.action = "bbt00001V.do?pageCd=${boardMstCd}";
		   	document.locStoreForm.submit();
		}

		function doPage(pageNum){
			document.locStoreForm.page.value = pageNum;
	    	document.locStoreForm.action = "locStoreL.do?pageCd=${boardMstCd}";
	       	document.locStoreForm.submit();
		}
	
		function mapView(mapPoint) {
			
			var mapPointX = "";
			var mapPointY = "";
			if(mapPoint != undefined){
				mapPointX = $("#mapPointX"+mapPoint).val();
				mapPointY = $("#mapPointY"+mapPoint).val();
				
				//구글맵 상단 타이틀
				if($('#mapStoreTitleOriginal_'+mapPoint+'').length > 0){
					$('#mapStoreTitle').text("");
					$('#mapStoreTitle').text($('#mapStoreTitleOriginal_'+mapPoint+'').text());
				}
				
			}else{
				mapPointX = $("#mapPointX0").val();
				mapPointY = $("#mapPointY0").val();
			}
			
			var mapLocation = new google.maps.LatLng(mapPointX, mapPointY); // 지도에서 가운데로 위치할 위도와 경도
	        var markLocation = new google.maps.LatLng(mapPointX, mapPointY); // 마커가 위치할 위도와 경도
			
	        var mapOptions = {
	          center: mapLocation, // 지도에서 가운데로 위치할 위도와 경도(변수)
	          zoom: 14, // 지도 zoom단계
	          /* 임시테스트 START */
	           //1. 현재 mapLocation 의 데이터는 있지만 위도, 경도가 지도상에 없는 위도 경도여서 안나오는 것이다
	           //https://jsfiddle.net/api/post/library/pure/ 에서 테스트
	          // 2. 맵의 버튼이 제대로 나오지 않는 문제 : */
        	  /* 임시테스트 END */
	          mapTypeId: google.maps.MapTypeId.ROADMAP
	        };
	        var map = new google.maps.Map(document.getElementById("preview"), // id: map-canvas, body에 있는 div태그의 id와 같아야 함
	            mapOptions);

	        var size_x = 60; // 마커로 사용할 이미지의 가로 크기
	        var size_y = 60; // 마커로 사용할 이미지의 세로 크기

	        // 마커로 사용할 이미지 주소
	        var image = new google.maps.MarkerImage( 'http://www.larva.re.kr/home/img/boximage3.png',
	                            new google.maps.Size(size_x, size_y),
	                            '',
	                            '',
	                            new google.maps.Size(size_x, size_y));

	        var marker;
	        marker = new google.maps.Marker({
	               position: markLocation, // 마커가 위치할 위도와 경도(변수)
	               map: map,
	               icon: image, // 마커로 사용할 이미지(변수)
//	             info: '말풍선 안에 들어갈 내용',
	               title: '' // 마커에 마우스 포인트를 갖다댔을 때 뜨는 타이틀
	        });

	        var content = ""; // 말풍선 안에 들어갈 내용

	        // 마커를 클릭했을 때의 이벤트. 말풍선
	        var infowindow = new google.maps.InfoWindow({ content: content});

	        google.maps.event.addListener(marker, "click", function() {
	            infowindow.open(map,marker);
	        });


	        
	      }//
	      
	      $(document).ready(function(){
				/* 검색 - 취급품목선택 CHECKBOX CHECKED */
				var mapStoreItem = document.locStoreForm.mapStoreItem;
				if(mapStoreItem != undefined){
					if('${boardCateSeq}' != "" || '${boardCateSeq}' != null){
						var boardCateSeq = '${boardCateSeq}';
						boardCateSeq = boardCateSeq.split(',');
						for (var i = 0; i < mapStoreItem.length; i++) {
							for (var j = 0; j < boardCateSeq.length; j++) {
								if(boardCateSeq[j] == mapStoreItem[i].value){
									mapStoreItem[i].checked = true;
									mapStoreItem[i].parentNode.parentNode.classList.add("on");
								}
							}
						}
					}	
				}
				
				//구글맵 상단 타이틀
				if($('#mapStoreTitleOriginal_0').length > 0){
					$('#mapStoreTitle').text("");
					$('#mapStoreTitle').text($('#mapStoreTitleOriginal_0').text());
				}
				
				
			});//
		
	</script>
</head>

<body>
	<form id="locStoreForm" name="locStoreForm" method="post">
	<div class="sub">
		<input type="hidden" id="boardSeq" name="boardSeq" />
		<input type="hidden" id="boardMstCd" name="boardMstCd" value="${boardMstCd}" />
		<input type="hidden" id="boardCateSeq" name="boardCateSeq" value="${boardCateSeq}" />
		<input type="hidden" id="page" name="page" value="${param.page}"/>

		<div class="box_guide">
			<c:choose>
				<c:when test="${boardMstCd eq 'BBM00057'}">
					<h2 class="tit">전시장 찾기</h2>
					<p class="desc">이누스 전국 전시장을 소개합니다.</p>
				</c:when>
				<c:when test="${boardMstCd eq 'BBM00058'}">
					<h2 class="tit">A/S센터 찾기</h2>
					<p class="desc">이누스 전국 A/S센터를 소개합니다.</p>
				</c:when>
				<c:when test="${boardMstCd eq 'BBM00059'}">
					<h2 class="tit">대리점</h2>	
					<p class="desc">이누스 전국 대리점을 소개합니다.</p>
				</c:when>
				<c:otherwise>
					<h2 class="tit"></h2>
				</c:otherwise>
			</c:choose>
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">매장찾기</a></li>
					<c:choose>
						<c:when test="${boardMstCd eq 'BBM00057'}">
							<li class="last"><a href="#"><span id="kkk"></span>전시장 찾기</a></li>
						</c:when>
						<c:when test="${boardMstCd eq 'BBM00058'}">
							<li class="last"><a href="#"><span id="kkk"></span>A/S센터 찾기</a></li>
						</c:when>
						<c:when test="${boardMstCd eq 'BBM00059'}">
							<li class="last"><a href="#"><span id="kkk"></span>대리점</a></li>
						</c:when>
						<c:otherwise>
							<li class="last"><a href="#"><span id="kkk"></span></a></li>
						</c:otherwise>
					</c:choose>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<div class="sch_bx">
			<fieldset>
				<legend>공지사항내 검색</legend>
				<div class="tblType01 in_sch_bx goods">
					<table>
						<caption>A/S센터 찾기(취급품목,지역선택)</caption>
						<tbody>
							<c:if test="${fn:length(cateList) > 1}">
								<tr>
									<th scope="row"><label for="">취급품목 선택</label></th>
									<td>
										<div>
											<c:forEach items="${cateList}" var="cateList" varStatus="loop">
												<span class="chkbox mr50">
													<label class="label_txt">
														<input type="checkbox" id="cate${loop.index}" name="mapStoreItem" value="${cateList.boardCateSeq}" />
														<span class="txt">${cateList.boardCateNm}</span>
													</label>
												</span>
											</c:forEach>
										</div>
									</td>
								</tr>
							</c:if>

							<tr>
								<th scope="row"><label for="">조건 검색</label></th>
								<td>
									<div>
										<select name="addressLev1" id="addressLev1"  title="관할지역(도/시)" class="">
											<option value="">도/시 전체</option>
										</select>
										<select name="addressLev2" id="addressLev2" title="관할지역(시/군/구)" class="twoPart">
											<option value="">시/군/구 전체</option>
										</select>
										<input type="text" name="txtSearch" id="txtSearch" value="${txtSearch}" class="sctInput"/>
									</div>
									<a href="#none" class="btn02Type" onclick="noticeCate('');">검색</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</fieldset>
		</div>
		<!--// sch_bx -->
		<div class="tblType02">
			<div class="box_tit">
				<c:choose>
					<c:when test="${boardMstCd eq 'BBM00057'}">
						<p id="kjyxz"class="tit">전체 전시장 <span>${totalCnt}</span>개
					</c:when>
					<c:when test="${boardMstCd eq 'BBM00058'}">
						<p id="kjyxz"class="tit">전체 A/S센터 <span>${totalCnt}</span>개
					</c:when>
					<c:when test="${boardMstCd eq 'BBM00059'}">
						<p id="kjyxz"class="tit">전체 대리점 <span>${totalCnt}</span>개
					</c:when>
					<c:otherwise>
						<p id="kjyxz"class="tit">전체 <span>${totalCnt}</span>개
					</c:otherwise>
				</c:choose>
					
				</p>
				
				
			</div>
			<div class="store_bx">
				<div class="list_bx">
					<c:forEach items="${mapList}" var="mapList" varStatus="loop">
						<input type="hidden" id="mapPointX${loop.index}" name="mapPointX${loop.index}" value="${mapList.pointX}"/>
						<input type="hidden" id="mapPointY${loop.index}" name="mapPointY${loop.index}" value="${mapList.pointY}"/>

						<div class="lst">
							<div class="tbox">
								<strong id="mapStoreTitleOriginal_${loop.index}">[${mapList.mapStoreTitle}]</strong>
								<p>${mapList.mapStoreAddr}</p>
								<p>${mapList.mapEtc}</p>
								<c:if test="${(boardMstCd eq 'BBM00058') or (boardMstCd eq 'BBM00059')}">
									<p class="f_bold">취급품목 : ${mapList.mapStoreItem}</p>
								</c:if>
							</div>
							<div class="rbox">
								<span>${mapList.mapStorePhone}</span>
								<a href="#none" class="btn01Type" onClick="mapView('${loop.index}');">지도보기</a>
							</div>
						</div>
					</c:forEach>
					<c:if test="${empty mapList}">
						<div class="lst">
			                <p>내용이 없습니다.</p>
			            </div>
		            </c:if>
				</div>
				<!--// list_bx -->
				<div class="mapView">
					<strong id="mapStoreTitle"></strong>
					<!-- 지도대체 이미지 ,삭제될 예정 -->
					<div class="preview" id="preview">map</div>
				</div>
			</div>
		</div>

		<c:out value="${pageTag}" escapeXml="false" />

	</div>
	<!--// sub -->
	</form>
</body>

