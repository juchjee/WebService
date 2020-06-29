<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
<script type="text/javaScript" defer="defer">
<!--
	var contUrl = "${rootUri}${conUrl}amM103";

	function init(){
		fnSearchInit();
		//fnSearch();
		fnEvent();
		fnDataSetting();
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅
	 *----------------------------------------------------------------------------------------------*/
	var _columns = [
		{ text: 'NO', datafield: 'rowNum', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: 'ID', datafield: 'mbrId', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '성명', datafield: 'mbrNm', cellclassname: cellclass, width: '8%', cellsalign: 'center', align: 'center'}
		,{ text: '성별', datafield: 'mbrSexMw', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
		,{ text: '나이', datafield: 'mbrAge', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '가입일', datafield: 'mbrJoinDt' , cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '휴면일', datafield: 'test2', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '전화', datafield: 'mbrMobile', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
		,{ text: '포인트', datafield: 'mbrPtScore', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '쿠폰', datafield: 'mbrCopnCnt', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
		,{ text: '등급', datafield: 'mbrLevNm', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
		,{ text: '분류', datafield: 'mbrTpBte', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
		,{ text: '접속', datafield: 'loginCnt', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center'}
		,{ text: '구매', datafield: 'orderCnt', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center'}
	];

	var _datafields = [
		 { name: 'rowNum', type: 'string'}
		,{ name: 'mbrId', type: 'string'}
		,{ name: 'mbrNm', type: 'string'}
		,{ name: 'mbrSexMw', type: 'string'}
		,{ name: 'mbrAge', type: 'string'}
		,{ name: 'mbrJoinDt', type: 'string'}
		,{ name: 'mbrMobile', type: 'string'}
		,{ name: 'mbrPtScore', type: 'string'}
		,{ name: 'mbrCopnCnt', type: 'string'}
		,{ name: 'mbrLevNm', type: 'string'}
		,{ name: 'mbrTpBte', type: 'string'}
		,{ name: 'orderCnt', type: 'string'}
		,{ name: 'loginCnt', type: 'string'}
		,{ name: 'orderCnt', type: 'string'}
	];

	function fnSearchInit(){
		dateTimeInput("txtFromDt");
		dateTimeInput("txtToDt");
		fnGridOption('jqxgrid',{
	       	columns: _columns
	       	,selectionmode: 'checkbox'
	    });
	}

	function fnSearch(){
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + ".action",
	        data: {
	           searchType:$("#searchType").val() ,
         	   searchTxt:$("#searchTxt").val() ,
         	   txtFromDt:$("#txtFromDt").val() ,
         	   txtToDt:$("#txtToDt").val() ,
         	   mbrTpBte:$("#mbrTpBte").val() ,
         	   mbrLevCd:$("#mbrLevCd").val() ,
         	   orderCnt:$("#orderCnt").val() ,
         	   mbrSexMw:$("input:radio[name='mbrSexMw']:checked").val()
         	}
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

	function fnEvent(){

		$("#searchTxt").bind("keyup",function(e){
			if(e.keyCode == 13){
				fnSearch();
			}
		});

		$("#btn_Search").on('click', fnSearch);
		$("#mbrTpBte").on('change', fnSearch);
		$("#orderCnt").on('change', fnSearch);
		$("#mbrLevCd").on('change', fnSearch);
		$("input:radio[name='mbrSexMw']").on('change', fnSearch);

		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid','휴면회원목록');
		});

		$("#unlockMbr").bind("click",function(){
				var rowindex = $("#jqxgrid").jqxGrid('getselectedrowindexes');
				if(rowindex == ""){
					alert("휴면상태를 해지할 대상을 선택해주세요.");
					return false;
				}

				var postData = new Array();
				for(key in rowindex){
					 var paramData = new Object();
					paramData["mbrId"] =  $('#jqxgrid').jqxGrid('getcellvalue',rowindex[key], "mbrId");
					postData.push(paramData);
				}

				var postDataJson = JSON.stringify(postData);
				if(confirm("해당 휴면회원 휴면상태를 해지 하시겠습니까?")){
					fnAjax("unlockMbr.action",{data : postDataJson}, function(data, dataType){
						var data = data.replace(/\s/gi,'');
						alert(data);
						$('#jqxgrid').jqxGrid('clearselection');
						fnSearch();
					},'POST','text');
				}
		});

		<c:choose>
		<c:when test='${not empty isCrm}'>
			$("#jqxgrid").on('celldoubleclick', function (event){
				var args = event.args;
				var row = args.rowindex;
				var datarow = $('#jqxgrid').jqxGrid('getrowdata', row);
			    if(args.datafield != 'dtl' && args.datafield != 'dm' && args.datafield != 'sms'){
					window.open("/mng/crm/softPhone/SoftPhone.pop?admId=${admId}&mbrId="+datarow.mbrId, "mbrId", "width=1366, height=875, scrollbars=yes");
				}
			});
	   </c:when>
       <c:otherwise>
	       	$("#jqxgrid").on('celldoubleclick', function (event){
				var args = event.args;
				var row = args.rowindex;
				var datarow = $('#jqxgrid').jqxGrid('getrowdata', row);
			    if(args.datafield != 'dtl' && args.datafield != 'dm' && args.datafield != 'sms'){
					window.open("/mng/amM1/amM102/amM1021F.pop?mbrId="+datarow.mbrId, "mbrId", "width=1070, height=875, scrollbars=yes");
				}
			});
	    </c:otherwise>
	</c:choose>

		$("#userDel").bind("click", function(e){
			if(confirm('<spring:message code="common.delete.msg"/>')){
				var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
				if(rowindex==-1){
					alert("강제탈퇴 회원을 선택해주세요.");
					return false;
				}
				var ids = $("#jqxgrid").jqxGrid('getselectedrowindexes', 'mbrId');
				var idArr = [];
				for( var i=0; i<ids.length; i++){
					var idtext = $("#jqxgrid").jqxGrid('getcelltext',ids[i],'mbrId');
					idArr.push(idtext);
				}
				$("#idArr").val(idArr);
				document.delForm.action = "amM103Del.action";
				document.delForm.submit();
			}else{
				return false;
			}
		});

	}

	function fnDataSetting(){
		$("input[name=mbrSexMw]").eq(0).attr("checked",true);
	}

//-->
</script>
</head>

<body>
<div class="pageContScroll_st2">
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
						<th scope="row">키워드검색</th>
						<td>
							<select id="searchType" style="width: 134px;">
								<option value="1">회원명</option>
								<option value="2">아이디</option>
								<option value="3">전화번호</option>
								<option value="4">추천인</option>
								<option value="5">이메일</option>
							</select>
							<input type="text" id="searchTxt" style="width: 134px;" />
						</td>
						<th scope="row">가입일</th>
						<td>
							<div id='txtFromDt' name="txtFromDt" style='float:left;'></div>
							<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
							<div id='txtToDt' name="txtToDt"  style='float:left;'></div>
						</td>
					</tr>
					<tr>
						<th scope="row">회원분류</th>
						<td>
							<select id="mbrTpBte" style="width: 174px;">
								<option value="">전체</option>
								<option value="B">일반회원</option>
								<option value="T">전화회원</option>
								<option value="E">임직원</option>
							</select>
						</td>
						<th scope="row">회원등급</th>
						<td>
							<select id="mbrLevCd" style="width: 174px;">
								<option value="">전체</option>
								<c:forEach items="${plicyList}" var="plicyList">
									<option value="${plicyList.mbrLevCd}">${plicyList.mbrLevNm}</option>
								</c:forEach>
							</select>
						</td>
					</tr>
					<tr>
						<th scope="row">구매이력</th>
						<td>
							<select id="orderCnt" style="width: 174px;">
								<option value="">전체</option>
								<option value="1">있음</option>
								<option value="2">없음</option>
							</select>
						</td>
						<th scope="row">성별</th>
						<td>
							<div class="option_ul">
								<ul>
									<li><input type="radio" id="secMW" class="type1" value="" name="mbrSexMw" /><label for="secM">전체</label></li>
									<li><input type="radio" id="secM" class="type1" value="M" name="mbrSexMw" /><label for="secM">남</label></li>
									<li><input type="radio" id="secW" class="type1" value="W" name="mbrSexMw" /><label for="secW">여</label></li>
								</ul>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- // table_type -->
	</div>
	<!-- // top_box -->
	<div class="btn_area marB35">
		<div class="center">
			<a class="btn_blue_line2" id="btn_Search" href="#">검색</a>
		</div>
	</div>

	<form name="delForm" id="delForm" method="post">
		<input type="hidden" name="idArr" id="idArr" />
	</form>

	<!-- // btn_area -->
	<div class="align_area">
		<div class="left">
			<p id="">대상회원 : 총 ${totalCount}명</p>
		</div>
		<div class="right">
			<a id="unlockMbr" class="btn_type2 marL10" href="javascript:;" >휴면해지</a>
			<a id="userDel" class="btn_type2 btn_icon4" href="javascript:;">강제탈퇴</a>
			<a class="btn_type2 btn_icon5" href="javascript:;" id="btnExcel">엑셀다운로드</a>
		</div>
	</div>
	<!-- // align_area -->
	<div class="grid_type1">
		<div id="jqxgrid"></div>
	</div>

</div>
</body>