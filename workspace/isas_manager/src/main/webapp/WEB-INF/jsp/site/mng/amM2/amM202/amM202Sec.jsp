<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />
	<script type="text/javascript">
	<!--
		function init(){
			fnSearch();
			fnEvent();
		}

		function fnSearch(){
			var url = "/mng/amM2/amM202/amM202SecA.action";
			var srchKey = $("#srchKey").val();
			var source =
	        {
				datatype: "json",
	    		datafields: [
	                { name: 'secProdCd' },
	                { name: 'secProdNm' }
	            ],
	            id: 'id',
	            data:{srchKey: srchKey},
	            url: url
	        };
	        var dataAdapter = new $.jqx.dataAdapter(source);
			$("#listbox").jqxListBox({ source: dataAdapter, displayMember: "secProdNm", valueMember: "secProdCd",checkboxes: true,itemHeight: 30, width:358 , height: 150});
		}

		function fnEvent(){
			$(".srchBtn").click(function(){
				var idx = $(".srchBtn").index(this);
				if(idx == 1){
					$("#srchKey").val("");
				}
				fnSearch();
			});


			//선택 맵핑
			$.codeMpg = function(){
				var items = $("#listbox").jqxListBox('getCheckedItems');
				parent.fnCodeMpg('workForm','secMpg',items);
				parent.$.fancybox.close();
			}
		}
		//-->
	</script>
</head>

<body class="noBg">
	<div class="popup_wrap">
		<h2>보조상품명 조회</h2>
		<div class="top_box">
			<div class="text_type">
				<p>보조상품명은 상품명 위에 작게 표시되는 상품 분류 입니다. <span class="colRed">최대 1개만 등록 가능 합니다.</span></p>
			</div>
			<!-- // text_type -->
		</div>
		<!-- // top_box -->
		<div class="align_area">
			<div class="left">
				<input type="text" style="width:150px;" name="srchKey" id="srchKey">
				<a class="srchBtn btn_type1" href="#">검색</a>
				<a class="srchBtn btn_type1" href="#">전체보기</a>
			</div>
		</div>
		<!-- // align_area -->
		<div class="table_type2 overH175">

			<div id="listbox"></div>

		</div>
		<!-- // table_type2 -->
		<div class="btn_area">
			<div class="center">
				<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
				<a class="btn_blue_line2" href="javascript:;" onclick="$.codeMpg();">선택등록</a>
			</div>
		</div>
		<!-- // btn_area -->
	</div>
	<!-- // popup_wrap -->
</body>
</html>
