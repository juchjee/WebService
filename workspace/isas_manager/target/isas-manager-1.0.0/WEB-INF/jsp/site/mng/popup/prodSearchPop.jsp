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
			var url = "/mng/popup/prodSearchPopA.do";
			var srchKey = $("#srchKey").val();
			var source =
	        {
				datatype: "json",
	    		datafields: [
	    		                { name: 'prodTypeGsp' },
	    		                { name: 'prodTypeGspName' },
	    		                { name: 'prodQty' },
	    		                { name: 'prodCd' },
	               	 			{ name: 'prodNm' }
	            ],
	            id: 'id',
	            data:{srchKey: srchKey,
	            	      tp: "${param.tp}"},
	            url: url
	        };

	        var dataAdapter = new $.jqx.dataAdapter(source);
//			$("#listbox").jqxListBox({ source: dataAdapter, displayMember: "prodNm", valueMember: "prodCd", checkboxes: true,itemHeight: 30, width:358 , height: 150});

			$("#listbox").jqxGrid(
					{
		                editable: true,
					    source: dataAdapter,
					    columns: [
					        { text: '구성코드', datafield: 'prodTypeGsp', width: 40, hidden:true },
					        { text: '구성', datafield: 'prodTypeGspName', width: 40, align: 'center', cellsalign: 'center'},
					        { text: '상품코드', datafield: 'prodCd', align: 'center', cellsalign: 'center', width: 70 },
					        <c:if test='${param.tp == "set"}'>
					        { text: '수량', datafield: 'prodQty', align: 'center', cellsalign: 'center', width: 40  },
					        </c:if>
					        { text: '상품명', datafield: 'prodNm', align: 'center', cellsalign: 'left', width: 200 }
					    ],
		                selectionmode: 'checkbox',
		                width: 358,
		                height: 150
					});
			$('#listbox').on('rowselect', function (event) {
				var rowBoundIndex = event.args.rowindex;
				if($("#listbox").jqxGrid('getcelltext',rowBoundIndex,'prodTypeGsp') == 'S'){
					alert('세트상품은 세트상품으로 묶을수 없습니다.');
					$('#listbox').jqxGrid('unselectrow', rowBoundIndex);
				}
			});

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
				var ids = $("#listbox").jqxGrid('getselectedrowindexes', 'prodCd');
				var idArr = new Array();
				var cnt = 0;
				var setKind = false;
				for( var i=0; i<ids.length; i++){
					if($("#listbox").jqxGrid('getcelltext',ids[i],'prodTypeGsp') == 'S'){
						setKind = true;
					}else{
				        <c:if test='${param.tp == "set"}'>
						for(var j=0; j<$("#listbox").jqxGrid('getcelltext',ids[i],'prodQty'); j++){
						</c:if>
							var idVal = $("#listbox").jqxGrid('getcelltext',ids[i],'prodCd');
							var idTxt = $("#listbox").jqxGrid('getcelltext',ids[i],'prodNm');

							idArr.push(idVal + '|' + idTxt);
							cnt++;
				        <c:if test='${param.tp == "set"}'>
						}
						</c:if>
					}
				}
				if(cnt > 0){
					if(setKind){
						alert('세트상품은 세트상품으로 묶을수 없습니다.');
						setKind = false;
					}
					parent.fnGridCodeMpg('workForm','${param.tp}Mpg', idArr);
					parent.$.fancybox.close();
				}
			}
		}
	</script>
</head>

<body class="noBg">
	<div class="popup_wrap">
		<h2>상품명 조회</h2>
		<div class="top_box">
			<div class="text_type">
				<p><span class="colRed">세트상품구성과 연관상품 구성에 이용</span>하실 수 있습니다.<br />요건에 맞는 상품을 선택하시고 등록하시기 바랍니다.</p>
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
