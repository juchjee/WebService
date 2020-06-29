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
  <style>
		.fs11{font-size:11px;}
		.fs12{font-size:12px;}
		.fw-b{font-weight:bold;}
		.blue {color:#16aece;}

		/* Common */
		h2 {font-family:NanumGothicWeb;font-size:18px;font-weight:bold;color:#343434;padding:10px 0;border-bottom:2px #737373 solid;}
		h2 .bar {font-size:18px;color:#ebebeb;}
		h2 .copy {font-size:12px;font-weight:normal;color:#636161;}
		h3 {font-family:NanumGothicWeb;font-size:17px;font-weight:bold;color:#343434;padding:10px 0;}
		h3 .title_img1 {display:inline-block;width:51px;height:17px;background:url(images/ttl01.gif) no-repeat;}
		h3 .left {display:block;float:left;}
		h3 .right {display:block;float:right;}
		.color23a9c2{color:#23a9c2;}
		.clearboth { display:block; clear:both; width:0 !important; height:0 !important; margin:0 !important; padding:0 !important; border:0 none; font-size:0px; line-height:0px; }
		.pagelist {width:100%;text-align:center;padding:.6em 0;}
		.em_h15 {width:100%;height:15px;}
		.em_h35 {width:100%;height:35px;}
		.banner {display:inline-block;width:90%;}
		.banner img {width:100%;}
		/* Layer */
		#duolac_map {
			font-family:NanumGothicWeb;
			width:100%;
			scrollbar-3dLight-Color: #fff;
			scrollbar-Face-Color: #fff;
			scrollbar-Track-Color: #fff;
			scrollbar-DarkShadow-Color: #e4e4e4;
			scrollbar-Highlight-Color: #e4e4e4;
			scrollbar-Shadow-Color: #fff
		}
		#duolac_map #map_holder {width:100%;border-top:1px #9e9e9e solid;border-bottom:1px #9e9e9e solid;}
		#duolac_map #map_holder #map {width:auto;float:right;border-left:1px #9e9e9e solid;border-right:1px #9e9e9e solid;}
		#duolac_map #map_holder #map #naver_map {padding:0;margin:0;border:0 none;}
		#duolac_map #map_holder #map_list_holder {width:205px;float:left;border:0px;border-right:1px #9e9e9e solid;}
		#duolac_map #map_holder #map_list_holder #map_list {margin:0px 0 0 0px;}
		#duolac_map #map_holder #map_list_holder #map_list h3 {font-family:NanumGothicWeb;font-size:13px;font-weight:bold;color:#343434;padding:5px 0;margin-right:10px;border-bottom:1px #d8d8d8 solid;}
		#duolac_map #map_holder #map_list_holder #map_list #map_list_scroll {margin-top:0px;height:500px;overflow-x:none;overflow-y:scroll;}
		#duolac_map #map_holder #map_list_holder #map_list #map_list_scroll ul {padding:5px;list-style:none;font-size:11px;color:#343434;}
		#duolac_map #map_holder #map_list_holder #map_list #map_list_scroll ul li {padding:.5em 0;padding-left:25px;}
		#duolac_map #map_holder #map_list_holder #map_list #map_list_scroll ul li .name {font-weight:bold;}
		#duolac_map #map_holder #map_list_holder #map_list #map_list_scroll .partner {padding-left:0px;}
		#duolac_map .list_holder {width:100%;margin:5px 0;}
		#duolac_map .list_holder h3 {font-size:14px;font-weight:bold;color:#3c3c3c;padding:10px 0;}
		#duolac_map .list_holder #list_ad {width:100%;border:1px #dfdfdf solid;padding:20px 0;}
		#duolac_map .list_holder #list_ad ul {list-style:none;}
		#duolac_map .list_holder #list_ad ul li {width:33%;float:left;font-size:12px;text-align:center;}
		#duolac_map .list_holder #list_ad ul li img {width:100%;margin-bottom:5px;}
		#duolac_map .list_holder #list_ad ul li .ad_item {display:inline-block;width:265px;text-align:left;line-height:18px;}
		#duolac_map .list_holder #list_ad ul li .name {font-weight:bold;color:#484848;}
		#duolac_map .list_holder #list_ad ul li .addr {color:#999;}
		#duolac_map .list_holder #list_ad ul li .price {color:#23a9c2;}
		#duolac_map .list_holder #list_ad ul li .btn_cafe {position:absolute;margin:190px 0 0 179px;width:86px;height:29px;background:url(images/btn_cafe.gif);font-size:0px;line-height:0px;}
		#duolac_map .list_holder #list_ad .bo_ri {border-right:1px #dfdfdf solid;}
		#duolac_map .list_holder #list_adall {width:100%;padding-top:20px;}
		#duolac_map .list_holder #list_adall ul {list-style:none;}
		#duolac_map .list_holder #list_adall ul li {width:140px;height:150px;margin-left:15px;float:left;font-size:12px;text-align:center;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;}
		#duolac_map .list_holder #list_adall ul li img {width:100%;margin-bottom:5px;}
		#duolac_map .list_holder #list_adall ul li .name {font-weight:bold;color:#484848;}
		#duolac_map .list_holder #list_adall ul li .addr {color:#999;}
		#duolac_map .list_holder .left_holder {width:50%;float:left;margin-right:-1px;text-align:left;}
		#duolac_map .list_holder .right_holder {width:50%;float:right;border-left:1px #e1e1e1 solid;text-align:right;}
		#duolac_map .list_holder .list_all {display:inline-block;width:90%;text-align:left;}
		#duolac_map .list_holder .list_all h3 {font-family:NanumGothicWeb;font-size:14px;font-weight:bold;color:#3c3c3c;padding:5px 0;margin-bottom:5px;border-bottom:1px #b6b6b6 solid;}
		#duolac_map .list_holder .list_all a {cursor:pointer;}
		#duolac_map .list_holder .list_all ul {list-style:none;}
		#duolac_map .list_holder .list_all ul li {height:75px;border-bottom:1px #e2e2e2 solid;}
		#duolac_map .list_holder .list_all ul li .left {margin:10px 0 0 10px;float:left;width:10%;}
		#duolac_map .list_holder .list_all ul li .left img {width:60px;height:48px;}
		#duolac_map .list_holder .list_all ul li .right {margin-top:8px;float:right;width:80%;line-height:17px;color:#888;}
		#duolac_map .list_holder .list_all ul li .name {font-weight:bold;color:#484848;}

		.window-no {
			display:block;padding:5px 10px;width:220px;line-height:18px;text-align:left;background:#fff;
			border:1px #aaa solid;
			box-shadow: 0px 3px 6px rgba(0,0,0,.3);
		}
		.window-no h6 {display:block;padding:0 0 3px 0;margin:0;font-size:13px;font-weight:bold;}
		.window-no .close {display:block;position:absolute;width:20px;margin:0 0 0 210px;font-size:14px;font-weight:bold;color:#888;cursor:pointer;}
		.window {
			display:block;width:300px;text-align:left;background:#fff;
			border:1px #aaa solid;
			box-shadow: 0px 3px 6px rgba(0,0,0,.3);
		}
		.window h5 {display:block;margin:0;padding:8px 0 5px 12px;font-size:14px;font-weight:bold;color:#fff;background:#222;}
		.window img {display:block;float:left;margin:10px 0 10px 12px;padding:0;width:60px;height:60px;border:1px #ccc solid;}
		.window ul {display:block;float:left;margin:10px 0 10px 12px;width:200px;height:60px;}
		.window ul li {display:block;margin:5px 0;text-overflow:ellipsis;overflow:hidden;white-space:nowrap;}
		.window .close {display:block;position:absolute;width:20px;margin:7px 0 0 280px;font-size:16px;font-weight:bold;color:#eee;cursor:pointer;}
		.window .link {display:block;padding:8px 0 5px 0;text-align:center;border-top:1px #ccc dashed;clear:both;}
		.window .link .bar {display:inline-block;padding:0 5px;font-size:11px;color:#aaa;}
	</style>
  	<script type="text/javascript" src="http://openapi.map.naver.com/openapi/v2/maps.js?clientId=sTZ7SVT7RZD8vIvvJi_L"></script>
  <script type="text/javascript">
	//변수 선언
	var oMarkerType = new Array();
	var oMarkerName = new Array();
	var oMarkerTel = new Array();
	var oMarkerAddr = new Array();
	var oMarkerTema = new Array();
	var oMarkerImage = new Array();
	var oMarkerUrl = new Array();
    function testPop(){
      window.open("mapUpList.action", "", "width=1200, height=800, scrollbars=yes");
    }

    function fnReset(){
      location.href="mapList.action";
    }

    function goSearch(){
      document.frmSearch.action = "mapList.action";
      document.frmSearch.submit();
    }

    function excelUpload(){
      document.excelForm.action = "upLoadExcelFile.action";
      document.excelForm.submit();
    }

	function keydown(seq) {
		  var keycode = '';
		  if(window.event) keycode = window.event.keyCode;
		 if(keycode == 13){
			 goSearch();
		 }
		  return false;
	}
	var infoWindow = null; // - info window 생성
	var oMap = null;
	var oCenterPoint = null;
	function init(){
		nhn.api.map.setDefaultPoint('LatLng');
		infoWindow = new nhn.api.map.InfoWindow(); // - info window 생성
		<c:if test="${empty firstMap}">
			oCenterPoint = new nhn.api.map.LatLng(37.492, 127.01);
		</c:if>
		<c:if test="${not empty firstMap}">
			oCenterPoint = new nhn.api.map.LatLng("${firstMap.pointY}","${firstMap.pointX}");
		</c:if>
		oMap = new nhn.api.map.Map('naver_map', {
					point : oCenterPoint,
					zoom : 10, // - 초기 줌 레벨은 10으로 둔다.
					enableWheelZoom : true,
					enableDragPan : true,
					enableDblClickZoom : false,
					mapMode : 0,
					activateTrafficMap : false,
					activateBicycleMap : false,
					minMaxLevel : [ 1, 14 ],
					size : new nhn.api.map.Size(800, 500)
		});
		var markerCount = 0;
		// 컨트롤 설정
		var mapZoom = new nhn.api.map.ZoomControl();
		mapTypeChangeButton = new nhn.api.map.MapTypeBtn(); // - 지도 타입 버튼 선언
		mapZoom.setPosition({left:10, top:40}); // - 줌 컨트롤 위치 지정.
		mapTypeChangeButton.setPosition({left:10, top:10}); // - 지도 타입 버튼 위치 지정
		oMap.addControl(mapZoom);
		oMap.addControl(mapTypeChangeButton);
		//마커 이미지, 사이즈 설정
		var oSizeNo = new nhn.api.map.Size(18, 23);
		var oOffsetNo = new nhn.api.map.Size(18, 23);
		var oIconNo = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSizeNo, oOffsetNo);
		var oSize = new nhn.api.map.Size(31, 38);
		var oOffset = new nhn.api.map.Size(31, 38);
		var oIconOn = new nhn.api.map.Icon('http://static.naver.com/maps2/icons/pin_spot2.png', oSize, oOffset);
		// 마커의 기본 표시 설정
		var oLabel = new nhn.api.map.MarkerLabel(); // - 마커 라벨 선언.
		oMap.addOverlay(oLabel); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.
		oMap.addOverlay(infoWindow); // - 마커 라벨 지도에 추가. 기본은 라벨이 보이지 않는 상태로 추가됨.

		infoWindow.attach('changeVisible', function(oCustomEvent) {
			if (oCustomEvent.visible) {
				oLabel.setVisible(false);
			}
		});

		oMap.attach('mouseenter', function(oCustomEvent) {
			var oTarget = oCustomEvent.target;
			// 마커위에 마우스 올라간거면
			if (oTarget instanceof nhn.api.map.Marker) {
				var oMarker = oTarget;
				oLabel.setVisible(true, oMarker); // - 특정 마커를 지정하여 해당 마커의 title을 보여준다.
			}
		});

		oMap.attach('mouseleave', function(oCustomEvent) {
			var oTarget = oCustomEvent.target;
			// 마커위에서 마우스 나간거면
			if (oTarget instanceof nhn.api.map.Marker) {
				oLabel.setVisible(false);
			}
		});
		<c:if test="${not empty mapList}">
			var index = 0;
			var oMarker = null;
			<c:forEach var="item" items="${mapList}" varStatus="status" >
				index = ${status.index};
				oMarker = new nhn.api.map.Marker(oIconOn, {"title":"${item.mapCustomerName}","zIndex":index});
				oMarker.setPoint(new nhn.api.map.LatLng("${item.pointY}","${item.pointX}"));
				oMap.addOverlay(oMarker);
				oMarkerType[index] = 'yes';
				oMarkerName[index] = '${item.mapCustomerName}';
				oMarkerTel[index] = '${item.mapCustomerPhone}';
				oMarkerAddr[index] = '${item.mapCustomerAddr}';
				oMarkerTema[index] = '${item.mapEtc}';
				oMarkerImage[index] = '';
				oMarkerUrl[index] = '${item.mapCustomerName}';
	    	</c:forEach>
	  	</c:if>

		oMap.attach('click', function(oCustomEvent) {
			var oTarget = oCustomEvent.target;
			var oMarkerTitle = oCustomEvent.target.getTitle();
			var oMarkerId;
			// 마커 클릭하면
			if (oTarget instanceof nhn.api.map.Marker) {
				// 겹침 마커 클릭한거면
				if (oCustomEvent.clickCoveredMarker) {
					return;
				}
				for(i=0; i<oMarkerName.length; i++){
					if(oMarkerName[i]==oMarkerTitle){
						oMarkerId=i;
						break;
					}
				}
				if(oMarkerType[oMarkerId]=='no'){
					oMap.setCenter(oTarget.getPoint());
					infoWindow.setContent('<div id="info'+oMarkerId+'" class="window-no">'+
					'<div class="close" onclick=\'javascript:document.getElementById("info'+oMarkerId+'").style.display="none";\'>×</div>'+
					'<h6>'+oMarkerTitle+'</h6>'+
					'A:'+oMarkerAddr[oMarkerId]+'<br>T:'+oMarkerTel[oMarkerId]+'</div>');
					infoWindow.setPoint(oTarget.getPoint());
					infoWindow.setVisible(true);
					infoWindow.setPosition({right : 5, top : 20});
					infoWindow.autoPosition();
				}else{
					oMap.setCenter(oTarget.getPoint());
					infoWindow.setContent('<div id="info'+oMarkerId+'" class="window">'+
					'<div class="close" onclick=\'javascript:document.getElementById("info'+oMarkerId+'").style.display="none";\'>×</div>'+
					'<h5>'+oMarkerTitle+'</h5>'+
					'<ul>'+
					'<li class="fs12">'+oMarkerAddr[oMarkerId]+'</li>'+
					'<li class="fs12 fw-b">'+oMarkerTel[oMarkerId]+'</li>'+
					'<li class="fs12 blue">취급품목 : '+oMarkerTema[oMarkerId]+'</li>'+
					'</ul>'+
					'<div class="link">'+
					'</div>'+
					'</div>');
					infoWindow.setPoint(oTarget.getPoint());
					infoWindow.setVisible(true);
					infoWindow.setPosition({right : 5, top : 20});
					infoWindow.autoPosition();
				}
				return;
			}
		});
	}

	//지도 목록 클릭시 활성화
	function list_onclick(on_id,on_x,on_y){
		var oPoint = new nhn.api.map.LatLng(on_x,on_y);
		oMap.setCenter(oPoint);
		infoWindow.setContent('<div id="info'+on_id+'" class="window">'+
		'<div class="close" onclick=\'javascript:document.getElementById("info'+on_id+'").style.display="none";\'>×</div>'+
		'<h5>'+oMarkerName[on_id]+'</h5>'+
		'<ul>'+
		'<li class="fs12">'+oMarkerAddr[on_id]+'</li>'+
		'<li class="fs12 fw-b">'+oMarkerTel[on_id]+'</li>'+
		'<li class="fs12 blue">취급품목 : '+oMarkerTema[on_id]+'</li>'+
		'</ul>'+
		'<div class="link">'+
		'</div>'+
		'</div>');
		infoWindow.setPoint(oPoint);
		infoWindow.setVisible(true);
		infoWindow.setPosition({right : 5, top : 20});
		infoWindow.autoPosition();
	}

  </script>

</head>
<body class="noBg">
  <div class="popup_wrap">
  <table cellpadding="0" cellspacing="0" border="1">
  <tr>
    <td>
      <table cellpadding="0" cellspacing="0" bgcolor="white" border="0">
        <tr>
          <td valign="top" style="padding-left:6px; padding-right:6px;">
            <form id="excelForm" name="excelForm" method="post" enctype="multipart/form-data">
                  <table class="tb" border="1" bordercolor="#e6e6e6" cellpadding="5" style="width: 100%; border-collapse: collapse;">
                <col width="300"/><col width="*"/>
                <tr>
                  <td><!-- 정보 엑셀 업로드<br>파일명은 영문< --></td>
                  <td>
<!--                     <input type="file" class="box" id="uploadInputBox" name="filexls" onKeyPress="blockKey(event)" onKeyDown="blockKey(event)"> -->
<!--                     엑셀 업로드 시 700라인 이하로 나눠서 올리세요. -->
                  </td>
                  <td>
<!--                     <button onclick="excelUpload();">등록</button> -->
<!--                     <button onclick="testPop();">TEST팝업</button> -->
                  </td>
                </tr>
              </table>
            </form>
          </td>
        </tr>
      </table>
      <table width="1000" cellpadding="0" cellspacing="0" bgcolor="white" border="0">
        <tr>
          <td valign="top" style="padding-left:6px; padding-right:6px;">
            <form name="frmSearch" method="post">
            <input type="hidden" name="keyword" value="1">
            <table class="tb" border="1" bordercolor="#e6e6e6" cellpadding="5" style="width: 100%; border-collapse: collapse;">
              <col width="300"/><col width="*"/>
              <tr>
                <td>
                  <input type="text" name="txtSearch" id="txtSearch" style="width:100px;" placeholder="검색어를 입력하세요."  value="${txtSearch}" onkeydown="keydown();" />
                  <button class="btn_type2" onclick="goSearch();">검색</button>
                  <a href="javascript:;" onclick="fnReset();">[초기화]</a>
                </td>
                <td>
                	<html:selectList name='Area' id='AreaSelectList' list='${mapList}' listValue='mapCustomerAddr' listName='mapCustomerAddr' optionNames="행정구역확인" optionValues="행정구역확인" defaultValue="행정구역확인"/>
                </td>
              </tr>
            </table>
            </form>
          </td>
        </tr>
        <tr><td height="15"></td></tr>
        <tr>
          <td valign="top" height="600" style="padding-left:6px; padding-right:6px;">
            <table width="100%" align="center" border="0" cellspacing="0" cellpadding="0">
              <tr>
                <td valign="top">
                  <div id="duolac_map">
                    <div id="map_holder">
                      <div id="map">
                        <div id="naver_map" style="width:800px;height:500px;"></div>
                      </div>
                      <div id="map_list_holder" style="width:340px;">
                        <div id="map_list">
                          <div id="map_list_scroll">
                            <ul>
                              <!-- 리스트 출력 -->
                              <c:forEach var="list" items="${mapList}" varStatus="status" >
                              	<c:if test="${list.pointY eq '0'}">
                              	<li class="partner" onclick="javascript:alert('좌표가 없습니다.');" style="cursor:pointer;">
                              	</c:if>
                                <c:if test="${list.pointY ne '0'}">
                              	<li class="partner" onclick="list_onclick('${status.index}','${list.pointY}','${list.pointX}');" style="cursor:pointer;">
                              	</c:if>
                                  <span class="name"><c:out value="${list.mapCustomerName}" /></span>
                                  <br/>
                                  <c:out value="${list.mapCustomerPhone}" />
                                  <br/>
                                  <c:out value="${list.mapCustomerAddr}" />
                                  <br/>
                                  <c:out value="${list.mapEtc}" />
                                </li>
                              </c:forEach>
                              <c:if test="${empty mapList}">
                                <li class="partner" >검색결과가 없습니다.</li>
                              </c:if>
                            </ul>
                          </div>
                        </div>

                      </div>
                      <div class="clearboth">&nbsp;</div>
                    </div>
                  </div>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr><td height="20"></td></tr>
      </table>

    </td>
  </tr>
</table>
</div>
</body>
</html>
