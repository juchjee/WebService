<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
	<script src="http://maps.googleapis.com/maps/api/js"></script>
	<script type="text/javascript">
	
		
		function init(){
			mapView();

		}
		
		function mapView() {
			
			var mapPointX = $("#pointX").val();
			var mapPointY = $("#pointY").val();

			var mapLocation = new google.maps.LatLng(mapPointX, mapPointY); // 지도에서 가운데로 위치할 위도와 경도
	        var markLocation = new google.maps.LatLng(mapPointX, mapPointY); // 마커가 위치할 위도와 경도
			
	        var mapOptions = {
	          center: mapLocation, // 지도에서 가운데로 위치할 위도와 경도(변수)
	          zoom: 14, // 지도 zoom단계
	          mapTypeId: google.maps.MapTypeId.ROADMAP
	        };
	        var map = new google.maps.Map(document.getElementById("map"), // id: map-canvas, body에 있는 div태그의 id와 같아야 함
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
	      
	</script>
</head>

<body>
		
		<section class="sub">
			<input type="hidden" name="pointX" id="pointX" value="${mapView.pointX}" />
			<input type="hidden" name="pointY" id="pointY" value="${mapView.pointY}" />
			<div class="tit_bx">
				<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
				<c:choose>
					<c:when test="${boardMstCd eq 'BBM00057'}">
						<h2>전시장 찾기 상세</h2>
					</c:when>
					<c:when test="${boardMstCd eq 'BBM00058'}">
						<h2>A/S센터 찾기 상세</h2>
					</c:when>
					<c:when test="${boardMstCd eq 'BBM00059'}">
						<h2>대리점 상세</h2>	
					</c:when>
					<c:otherwise>
						<h2></h2>
					</c:otherwise>
				</c:choose>
			</div>
			<!--// tit_bx -->
			<div class="content">
				<div class="boardView">
					<em class="tit">${mapView.mapStoreTitle}</em>
					<c:if test="${boardMstCd eq 'BBM00058' || boardMstCd eq 'BBM00059'}">
					<dl>
						<dt>취급품목</dt>
						<dd>${mapView.boardCateNm}</dd>
					</dl>
					</c:if>
					<dl>
						<dt>전화번호</dt>
						<dd><a href="tel:${mapView.mapStorePhone}">${mapView.mapStorePhone}</a></dd>
					</dl>
					<dl>
						<dt>주소</dt>
						<dd class="pl70">${mapView.mapStoreAddr}</dd>
					</dl>
					<dl>
						<dt>안내</dt>
						<dd class="pl70">${mapView.mapEtc}</dd>
					</dl>					
					<div class="map" id="map"></div>
				</div>
				<!--// boardView -->
			</div>
		</section>
		<!--// sub -->
		
</body>

