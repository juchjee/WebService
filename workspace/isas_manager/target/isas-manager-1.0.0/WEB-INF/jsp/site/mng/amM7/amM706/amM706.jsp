<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 설정관리 : 게시판 설정 -->

<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM706";
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
		$(".fancybox.bis").fancybox({
			maxWidth	: 950,
			maxHeight	: 700,
			width		: '100%',
			height		: '100%'
		});
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅 - 선택, 제품명, 판매가, 할인가, 쿠폰, 적립금, 재고, 판매상태, PC노출, 모바일노출, 과세, 등록일, 관리
	 *----------------------------------------------------------------------------------------------*/
	var _columns = [
		 { text: '프로그램명', datafield: 'boardMstNm', cellclassname: cellclass, width: '22%', cellsalign: 'left', align: 'center'}
		,{ text: '프로그램유형', datafield: 'boardTpStyleNm', cellclassname: cellclass, width: '22%', cellsalign: 'center', align: 'center'}
		,{ text: '프로그램종류', datafield: 'boardTpNm', cellclassname: cellclass, width: '22%', cellsalign: 'left', align: 'center'}
		,{ text: '관리자메뉴명', datafield: 'admMenuNm', cellclassname: cellclass, width: '22%', cellsalign: 'center', align: 'center'}
		,{ text: '상태', datafield: 'boardStatusYn', cellclassname: cellclass, width: '12%', cellsalign: 'center', align: 'center'}
// 		,{ text: '상품연계', datafield: 'boardProdYn', cellclassname: cellclass, width: '15%', cellsalign: 'center', align: 'center'}
		,{ text: '게시판코드', datafield: 'boardMstCd', cellclassname: cellclass, cellsalign: 'right', align: 'center', hidden:true}];

	var _datafields = [
		 { name: 'boardMstNm', type: 'string'}
		,{ name: 'boardTpStyleNm', type: 'string'}
		,{ name: 'boardTpNm', type: 'string'}
		,{ name: 'admMenuNm', type: 'string'}
		,{ name: 'boardStatusYn', type: 'string'}
// 		,{ name: 'boardProdYn', type: 'string'}
		,{ name: 'boardMstCd', type: 'string'}
	];

	function fnSearchInit(){
		fnGridOption('jqxgrid',{
			height:285
	       ,columns: _columns
	       ,selectionmode: 'singlerow'
	    });
	}

	/*----------------------------------------------------------------------------------------------
	 * grid search
	 *----------------------------------------------------------------------------------------------*/
	function fnSearch(){
		var dataAdapter = new $.jqx.dataAdapter({
    		datatype: "json",
            datafields: _datafields,
            url: contUrl + ".action",
            data: {boardStatusYn: $("#boardStatusYn").val(),boardTpStyle: $("#boardTpStyle").val(),admMenuCd: $("#admMenuCd").val()}
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}
	/*----------------------------------------------------------------------------------------------
	 * 이벤트 Setting
	 *----------------------------------------------------------------------------------------------*/
	function fnEvent(){

		$("#jqxgrid").on('rowdoubleclick', function (event)
		{
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			var datarow = $('#jqxgrid').jqxGrid('getrowdata', rowindex);
			setTimeout(function(){
			$.fancybox.open({
				href: "amM706Pop.action?boardMstCd="+datarow.boardMstCd,
				type: "iframe",
				maxWidth	: 950,
				maxHeight	: 800,
				modal : false,
				autoSize	: true
			});
			},200);
		});

		$(".modifyBtn").click(function(){
			var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
			if(rowindex==-1){
				alert("수정할 게시판을 선택해주세요.");
				return false;
			}
			var datarow = $("#jqxgrid").jqxGrid('getrowdata', rowindex);
			$.fancybox.open({
				href: "amM706Pop.action?boardMstCd="+datarow.boardMstCd,
				type: "iframe",
				maxWidth	: 950,
				maxHeight	: 700,
				width		: '100%',
				height		: '100%',
				modal : false
			});
		});

		$(".delBtn").click(function(){
			var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindex');
			var datarow = $("#jqxgrid").jqxGrid('getrowdata', rowindex);
			$("#delCd").val(datarow.boardMstCd);
			$("#delForm").submit();
			$("#delCd").val("");
		});

		//검색 이벤트
		$("#boardStatusYn").on('change', fnSearch);
		$("#boardTpStyle").on('change', fnSearch);
		$("#admMenuCd").on('change', fnSearch); 

		 
	}

</script>
</head>
<body>
	<div class="pageContScroll_st2">
		<div class="top_box">
			<div class="table_type">
				<form id="delForm" name="delForm" action="amM706D.action" method="post">
					<input type="hidden" id="delCd" name="delCd" />
				</form>
				<table>
					<caption>신규발행여부로 구성된 마케팅관리 하위의 쿠폰관리에 대한 검색 테이블입니다.</caption>
					<colgroup>
						<col style="width: 15%;" />
						<col style="width: *;" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">프로그램유형</th>
							<td>
								<select id="boardTpStyle" name="boardTpStyle" style="width: 174px;">
									<option value="">전체</option>
									<option value="bbs">확장프로그램</option>
									<option value="uni">단일프로그램</option>
								</select>
							</td>
							<th scope="row">관리자메뉴명</th>
							<td>
								<select id="admMenuCd" name="admMenuCd" style="width: 174px;">
									<option value="">전체</option>
									<c:forEach items="${admMenuList}" var="admMenu">
									<option value="${admMenu.admMenuCd}" <c:if test="${admMenu.admMenuCd eq boardDetail.admMenuCd}">selected</c:if> >${admMenu.admMenuNm}</option>
									</c:forEach>
									<option value="N/A">프론트전용</option>
								</select>
							</td>
							<th scope="row">사용여부</th>
							<td>
								<select id="boardStatusYn" name="boardStatusYn" style="width: 174px;">
										<option value="">전체</option>
										<option value="Y" selected="selected">사용중</option>
										<option value="N">정지</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			<!-- // table_type -->
		</div>
		<div class="align_area">
		<div class="right">
			<a class="fancybox bis btn_type2" data-fancybox-type="iframe" href="amM706Pop.action">등록</a>
			<a class="modifyBtn btn_type2" href="javascript:;">수정</a>
			<a class="delBtn btn_type2" href="javascript:;">정지</a>
		</div>
	</div>
		<div class="grid_type1">
			<div id="jqxgrid"></div>
		</div>

	</div>

</body>