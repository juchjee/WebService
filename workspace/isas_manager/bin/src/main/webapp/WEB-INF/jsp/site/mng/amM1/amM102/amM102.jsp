<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM102";
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/

	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
		fnDataSetting();
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅
	 *----------------------------------------------------------------------------------------------*/
		var _columns = [
			//{ text: '선택', datafield: 'test1', columntype: 'checkbox', width: '6%', align: 'center'},
			{ text: '번호', datafield: 'rowNum', cellclassname: cellclass, width: '4%', cellsalign: 'center', align: 'center'}
			,{ text: '아이디', datafield: 'mbrId', cellclassname: cellclass, width: '7%', cellsalign: 'center', align: 'center'}
			,{ text: '성명', datafield: 'mbrNm', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
			//,{ text: '성별', datafield: 'mbrSexMw', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
			//,{ text: '나이', datafield: 'mbrAge', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
			//,{ text: '가입일', datafield: 'mbrJoinDt', cellclassname: cellclass, width: '9%', cellsalign: 'center', align: 'center'}
			,{ text: '휴대폰번호', datafield: 'mbrMobile', cellclassname: cellclass, width: '18.5%', cellsalign: 'center', align: 'center'}
			,{ text: '전화번호', datafield: 'mbrPhone', cellclassname: cellclass, width: '18.5%', cellsalign: 'center', align: 'center'}
			,{ text: '이메일', datafield: 'mbrEmail', cellclassname: cellclass, width: '18.5%', cellsalign: 'center', align: 'center'}
			,{ text: '가입일', datafield: 'mbrJoinDt', cellclassname: cellclass, width: '18.5%', cellsalign: 'center', align: 'center'}
			//,{ text: '포인트', datafield: 'mbrPtScore', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
// 			,{ text: '쿠폰', datafield: 'mbrCopnCnt', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center'}
			//,{ text: '등급', datafield: 'mbrLevNm', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
			//,{ text: '분류', datafield: 'mbrTpBte', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
			//,{ text: '접속', datafield: 'loginCnt', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
			//,{ text: '구매', datafield: 'orderCnt', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
			,{ text: '상세', datafield: 'dtl', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center',
				columntype: 'button', cellsrenderer: function (row) {
	                return '상세';
	            } , buttonclick: function (row) {
	       				var datarow = $('#jqxgrid').jqxGrid('getrowdata', row);
    					window.open("/mng/amM1/amM102/amM1021F.pop?mbrId="+datarow.mbrId, "mbrDtl", "width=1070, height=875, scrollbars=yes");
	            } 
			}
			/* ,{ text: 'DM', datafield: 'dm', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center',
				cellsrenderer: function (row) {
					return '<div style="text-align:center; margin-top:5px;"><a class="btn_type1" onclick="goDm('+row+');"><img src="${rootUri}images/ico_dm.png"/></a></div>';
	            }
			}
			,{ text: 'SMS', datafield: 'sms', cellclassname: cellclass, width: '5%', cellsalign: 'center', align: 'center',
				cellsrenderer: function (row) {
					return '<div style="text-align:center; margin-top:5px;"><a class="btn_type1" onclick="goSms('+row+');"><img src="${rootUri}images/ico_sms.png"/></a></div>';
	            }
			} */
		];

		var _datafields = [
			//{ name: 'test1', type: 'bool'},
			{ name: 'rowNum', type: 'string'}
			,{ name: 'mbrId', type: 'string'}
			,{ name: 'mbrNm', type: 'string'}
			//,{ name: 'mbrSexMw', type: 'string'}
			//,{ name: 'mbrAge', type: 'string'}
			//,{ name: 'mbrJoinDt', type: 'string'}
			,{ name: 'mbrMobile', type: 'string'}
			,{ name: 'mbrPhone', type: 'string'}
			,{ name: 'mbrEmail', type: 'string'}
			,{ name: 'mbrJoinDt', type: 'string'}
			//,{ name: 'mbrPtScore', type: 'string'}
// 			,{ name: 'mbrCopnCnt', type: 'string'}
			//,{ name: 'mbrLevNm', type: 'string'}
			//,{ name: 'mbrTpBte', type: 'string'}
			//,{ name: 'loginCnt', type: 'string'}
			//,{ name: 'orderCnt', type: 'string'}
			,{ name: 'dtl', type: 'image'}
			//,{ name: 'dm', type: 'image'}
			//,{ name: 'sms', type: 'image'}
		];

	function fnSearchInit(){
		var nowTimeArr = "${nowYmd}".split("-");
		dateTimeInput("txtFromDt");
		dateTimeInput("txtToDt");
		fnGridOption('jqxgrid',{
	       	columns: _columns
	       	//,selectionmode: 'singlerow'
	       	,selectionmode: 'checkbox'
	    });
		$("#jqxgrid").on("bindingcomplete", function (event) {
			if(setComma($("#jqxgrid").jqxGrid('getdatainformation').rowscount) != undefined){
	   	  		$("#searchCnt").text(setComma($("#jqxgrid").jqxGrid('getdatainformation').rowscount));
			}else{
				$("#searchCnt").text("0");
			}
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
	        data: {
	           mbrLoginStatusYhn:"1" ,//mbrLoginStatusYhn 1(상태:정상,홀드),2(상태:탈퇴)	        	
	           searchType:$("#searchType").val() ,
         	   searchTxt:$("#searchTxt").val() ,
         	   txtFromDt:$("#txtFromDt").val() ,
         	   txtToDt:$("#txtToDt").val() 
         	}
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

	/*----------------------------------------------------------------------------------------------
	 * 이벤트 Setting
	 *----------------------------------------------------------------------------------------------*/
	function fnEvent(){

		$('#searchTxt').bind('keyup',function(e){
			if(e.keyCode == 13){
				fnSearch();
			}
		});

		$("#btn_Search").on('click', fnSearch);
// 		$("#mbrTpBte").on('change', fnSearch);
// 		$("#orderCnt").on('change', fnSearch);
// 		$("#mbrLevCd").on('change', fnSearch);
		//$("input:radio[name='mbrSexMw']").on('change', fnSearch);

		$("#btnExcel").on('click', function(){
			grideExportExcel('jqxgrid','회원목록');
		});
		/*
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

		
		$("#smsSend").bind("click", function(e){
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			if(rowindex==-1){
				alert("회원을 선택해주세요.");
				return false;
			}
			var ids = $("#jqxgrid").jqxGrid('getselectedrowindexes', 'mbrId');
			var idArr = [];
			var nmArr = [];
			for( var i=0; i<ids.length; i++){
				var idtext = $("#jqxgrid").jqxGrid('getcelltext',ids[i],'mbrId');
				var nmtext = $("#jqxgrid").jqxGrid('getcelltext',ids[i],'mbrNm');
				idArr.push(idtext);
				nmArr.push(nmtext);
				if(i > 100){
					alert("SMS발송은 회원100명까지 발송 가능합니다.");
					return false;
				}
			}
			$("#smsSend").attr("href","/mng/popup/mbrSmsSendPop.do?idArr="+idArr+"&nmArr="+nmArr+"&msgRoleCd=C");
		});

		$("#mmsSend").bind("click", function(e){
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			if(rowindex==-1){
				alert("회원을 선택해주세요.");
				return false;
			}
			var ids = $("#jqxgrid").jqxGrid('getselectedrowindexes', 'mbrId');
			var idArr = [];
			var nmArr = [];
			for( var i=0; i<ids.length; i++){
				var idtext = $("#jqxgrid").jqxGrid('getcelltext',ids[i],'mbrId');
				var nmtext = $("#jqxgrid").jqxGrid('getcelltext',ids[i],'mbrNm');
				idArr.push(idtext);
				nmArr.push(nmtext);
				if(i > 100){
					alert("MMS발송은 회원100명에게 발송 가능합니다.");
					return false;
				}
			}
			$("#mmsSend").attr("href","/mng/popup/mbrMmsSendPop.do?idArr="+idArr+"&nmArr="+nmArr+"&msgRoleCd=C");
		});

		$("#emailSend").bind("click", function(e){

			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			if(rowindex==-1){
				alert("회원을 선택해주세요.");
				return false;
			}
			var ids = $("#jqxgrid").jqxGrid('getselectedrowindexes', 'mbrId');
			var idArr = [];
			var nmArr = [];
			for( var i=0; i<ids.length; i++){
				var idtext = $("#jqxgrid").jqxGrid('getcelltext',ids[i],'mbrId');
				var nmtext = $("#jqxgrid").jqxGrid('getcelltext',ids[i],'mbrNm');
				idArr.push(idtext);
				nmArr.push(nmtext);
				if(i > 100){
					alert("이메일발송은 회원100명에게 발송 가능합니다.");
					return false;
				}
			}
			$("#emailSend").attr("href","/mng/popup/mbrEmailSendPop.do?idArr="+idArr+"&nmArr="+nmArr+"&msgRoleCd=C");
		});

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
				document.delForm.action = "amM102Del.action";
				document.delForm.submit();
			}else{
				return false;
			}
		});

		 $("#smsSend").fancybox({
			maxWidth : 800,
			width : 800,
			height : 1000,
			autoSize : false,
		    afterClose : function(){
				$('#jqxgrid').jqxGrid('clearselection');
			}
		});

		$("#mmsSend").fancybox({
			maxWidth : 800,
			width : 800,
			height : 1000,
			autoSize : false,
		    afterClose : function(){
				$('#jqxgrid').jqxGrid('clearselection');
			}
		});

		$("#emailSend").fancybox({
			maxWidth : 800,
			width : 800,
			height : 1000,
			autoSize : false,
		    afterClose : function(){
				$('#jqxgrid').jqxGrid('clearselection');
			}
		});

		$("#oneSms").fancybox({
			maxWidth : 800,
			width : 800,
			height : 1000,
			autoSize : false,
		    afterClose : function(){
				$('#jqxgrid').jqxGrid('clearselection');
			}
		});

		$("#oneEmail").fancybox({
			maxWidth : 800,
			width : 800,
			height : 1000,
			autoSize : false,
		    afterClose : function(){
				$('#jqxgrid').jqxGrid('clearselection');
			}
		}); 
		*/

	}

	function fnDataSetting(){
		$("input[name=mbrSexMw]").eq(0).attr("checked",true);
	}

	function nowSearch(){
		$("#txtFromDt").val("${nowYmd}");
		$("#txtToDt").val("${nowYmd}");
		fnSearch();
	}

	function goDm(row){
		var datarow = $("#jqxgrid").jqxGrid('getrowdata', row);
		$("#oneEmail").attr("href","/mng/popup/mbrEmailSendPop.do?idArr="+datarow.mbrId+"&nmArr="+datarow.mbrNm+"&msgRoleCd=C");
		$("#oneEmail").click();
	}

	function goSms(row){
		var datarow = $("#jqxgrid").jqxGrid('getrowdata', row);
		$("#oneSms").attr("href","/mng/popup/mbrSmsSendPop.do?idArr="+datarow.mbrId+"&nmArr="+datarow.mbrNm+"&msgRoleCd=C");
		$("#oneSms").click();
	}

</script>
</head>

<body>
<div id="oneSms" data-fancybox-type="iframe"></div>
<div id="oneEmail" data-fancybox-type="iframe"></div>
<div class="pageContScroll_st2">
	<div class="top_box">
		<div class="table_type">
			<table>
				<caption>아이디, 성명, 휴대폰번호, 이메일로 구성된 회원목록에 대한 검색 테이블입니다.</caption>
				<colgroup>
					<col style="width: 10%;" />
					<col style="width: *;" />
					<col style="width: 10%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">검색</th>
						<td>
							<select id="searchType" style="width: 134px;">
								<option value="1">아이디</option>
								<option value="2">성명</option>
								<option value="3">휴대폰번호</option>
								<option value="4">이메일</option>
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
				</tbody>
			</table>
		</div>
	</div>

	<div class="btn_area marB35">
		<div class="center">
			<a class="btn_blue_line2" id="btn_Search" href="#">검색</a>
		</div>
	</div>

	<form name="delForm" id="delForm" method="post">
		<input type="hidden" name="idArr" id="idArr" />
	</form>

	<div class="align_area">
		<div class="left">
			<p>검색 인원수 : <span id="searchCnt" style="margin-left:0px;"></span>명  <span>${nowYmd} 가입자 : 총 ${nowCount}명</span></p>
			<a class="btn_type2 btn_icon1" href="javascript:;" onclick="nowSearch();">당일가입회원</a>
		</div>
		<div class="right">
			<!-- <a id="smsSend" data-fancybox-type="iframe" class="btn_type2 btn_icon2" href="javascript:;">SMS</a>
			<a id="mmsSend" data-fancybox-type="iframe" class="btn_type2 btn_icon2" href="javascript:;">MMS</a>
			<a id="emailSend" data-fancybox-type="iframe" class="btn_type2 btn_icon3" href="javascript:;">이메일</a>
			<a id="userDel" class="btn_type2 btn_icon4" href="javascript:;">강제탈퇴</a> -->
			<a class="btn_type2 btn_icon5" id="btnExcel" href="javascript:;" onclick="grideExportExcel('jqxgrid','회원목록');">엑셀다운로드</a>
		</div>
	</div>

	<div class="grid_type1">
		<div id="jqxgrid"></div>
	</div>

</div>
</body>