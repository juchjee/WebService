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

		function init(){
			fnSearch();
			fnEvent();
		}

		function fnSearch(){
			var url = "/mng/popup/keywordPopA.do";
 			var srchKey = $("#srchKey").val();
			var source =
            {
				datatype: "json",
	    		datafields: [
                    { name: 'prodKeywordCd' },
                    { name: 'prodKeywordNm' }
                ],
                data:{srchKey: srchKey},
                id: 'id',
                url: url
            };

			//리스트 박스 셋팅 출력
            var dataAdapter = new $.jqx.dataAdapter(source);
			$("#listbox").jqxListBox({ source: dataAdapter, displayMember: "prodKeywordNm", valueMember: "prodKeywordCd", checkboxes: true,itemHeight: 30, width:358 , height: 150});
		}

		// 이벤트 (검색/전체보기)
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
				parent.fnCodeMpg('workForm','keywordMpg',items);
				parent.$.fancybox.close();
			}

		}


	</script>
</head>

<body class="noBg">
	<div class="popup_wrap">
		<h2>키워드 조회</h2>
		<div class="top_box">
			<div class="text_type">
				<p>키워드 등록의 제한은 없습니다.<br />시스템 운영편의를 위해 <span class="colRed">10개까지 등록을 추천</span>합니다.</p>
			</div>
			<!-- // text_type -->
		</div>
		<!-- // top_box -->
		<div class="align_area">

			<div class="left popbt">
				<input type="text" style="width:120px;" name="srchKey" id="srchKey">
				<a class="srchBtn btn_type1 " href="#">검색</a>
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
