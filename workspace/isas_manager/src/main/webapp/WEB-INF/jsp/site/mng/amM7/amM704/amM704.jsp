<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 설정관리 : 관리자관리 : 관리자 목록 및 등록.수정 -->

<script type="text/javaScript" defer="defer">
	var contUrl = "${rootUri}${conUrl}amM704";
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){

		fnSearchInit();
		fnSearch();
		fnEvent();

		$(".fancybox.big").fancybox({
			maxWidth	: 800,
			maxHeight	: 440,
			width		: '100%',
			height		: '100%'
		});

	}

	var _columns = [{ text: '아이디', datafield: 'admId', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
	                { text: '성명', datafield: 'admName', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
	                { text: '전화번호', datafield: 'admTel', cellclassname: cellclass, width: '20%', cellsalign: 'center', align: 'center'},
	                { text: '입사일', datafield: 'admJobDt', cellsformat: 'yyyy-MM-dd', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
	                { text: '등록일', datafield: 'admRegDt', cellsformat: 'yyyy-MM-dd', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
	                { text: '이메일', datafield: 'admEmail', cellclassname: cellclass, width: '20%', cellsalign: 'center', align: 'center'},
	                { text: '권한', datafield: 'admAuthNm', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'},
	                { text: '직급', datafield: 'admPositionNm', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}];

	var _datafields = [{ name: 'admId', type: 'string'},
	                   { name: 'admName', type: 'string'},
	                   { name: 'admTel', type: 'string'},
	                   { name: 'admJobDt', type: 'date'},
	                   { name: 'admRegDt', type: 'date'},
	                   { name: 'admEmail', type: 'string'},
	                   { name: 'admAuthNm', type: 'string'},
	                   { name: 'admPositionNm', type: 'string'}];

	function fnSearchInit(){
		fnGridOption('adminList',{
	        selectionmode: 'singlerow'
	        ,height: 325
	        ,columns: _columns
	        ,pageable: true
	    });
	}

	function fnSearch(){
		var dataAdapter = new $.jqx.dataAdapter({
    		datatype: "json",
            datafields: _datafields,
            data:{useFlagYn: $("#useFlagYn").val(),
            	  admId: $("#admId").val(),
            	  admName: $("#admName").val(),
            	  admAuthCd:$("#admAuthCd").val(),
            	  admPosition:$("#admPositionCd").val()},
            url: contUrl + ".action"
		});
		$("#adminList").jqxGrid({ source: dataAdapter });
	}


	function fnEvent(){
		$("#btn_Search").on('click', fnSearch);//추가
		$("#useFlagYn").on('change', fnSearch);

		$("#adminList").on('rowdoubleclick', function (event)
		{
			var rowindex = $('#adminList').jqxGrid('getselectedrowindex');
			var datarow = $('#adminList').jqxGrid('getrowdata', rowindex);

			setTimeout(function(){
			$.fancybox.open({
				href: "amM704Pop.action?admId="+datarow.admId,
				type: "iframe",
				maxWidth	: 800,
				maxHeight	: 440,
				width		: '100%',
				height		: '100%',
				modal : false
			});
			},200);
		});
	}


</script>
</head>
<body>

	<div class="top_box">
		<div class="table_type">
			<table>
				<caption>키워드검색, 가입일, 회원분류, 회원등급, 구매이력, 성별로 구성된 회원목록에 대한
					검색 테이블입니다.</caption>
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: *;" />
					<col style="width: 10%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">아이디</th>
						<td><input type="text" name="admId" id="admId" style="width: 134px;" /></td>
						<th scope="row">권한</th>
						<td>
							<select id="admAuthCd" name="admAuthCd" style="width: 174px;">
									<option value="">전체</option>
								<c:forEach items="${authList}" var="authList">
									<option value="${authList.admAuthCd}">${authList.admAuthNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">이름</th>
						<td><input type="text" name="admName" id="admName" style="width: 134px;" /></td>
						<th scope="row">직급</th>
						<td>
							<select id="admPositionCd" id="admPositionCd" style="width: 174px;">
								<option value="">전체</option>
								<c:forEach items="${positionList}" var="positionList">
									<option value="${positionList.admPositionCd}">${positionList.admPositionNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>

	<div class="btn_area marB35" >
					<div class="center">
						<a id="btn_Search" class="btn_blue_line2" href="javascript:" >검색</a>
					</div>
					<div class="right" style="line-height:40px;"><select name="useFlagYn" id="useFlagYn" style="width: 100px;">
							<option value="">전체</option>
							<option value="Y" selected="selected">재직</option>
							<option value="N">퇴사</option>
						</select>
						<a class="fancybox big btn_type1" style="margin-left:0px;" data-fancybox-type="iframe" href="amM704Pop.action">등록</a>
					</div>
	</div>
	<div class="table_type1">
		<div id="adminList"></div>
	</div>

</body>