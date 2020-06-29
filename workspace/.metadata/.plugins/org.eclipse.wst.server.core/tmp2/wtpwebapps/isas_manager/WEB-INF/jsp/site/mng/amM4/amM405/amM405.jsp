<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>

	<!-- 이벤트관리 : 팝업관리 -->

<style>
div.jqx-item{cursor:pointer;}
</style>
<script type="text/javaScript" defer="defer">
	var contUrl = "${rootUri}${conUrl}amM405";

	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
	}

	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅
	 *----------------------------------------------------------------------------------------------*/
	var _columns = [
	 	 { text: '등록방식', datafield: 'popupRegTpFe',  width: '8%', cellsalign: 'center', align: 'center'}
		,{ text: '팝업제목', datafield: 'popupTitle',  width: '28%', cellsalign: 'left', align: 'center'}
		,{ text: '게시기간', datafield: 'popupDt',  width: '28%', cellsalign: 'center', align: 'center'}
		,{ text: '윈도우타입', datafield: 'popupOpenTpWlmNm',  width: '8%', cellsalign: 'center', align: 'center'}
		,{ text: '출력상태', datafield: 'popupStatusYn',  width: '8%', cellsalign: 'center', align: 'center'}
		,{ text: '등록자', datafield: 'regNm',   width: '8%',cellsalign: 'center', align: 'center'}
		,{ text: '등록일', datafield: 'regDt',   width: '12%', cellsalign: 'center', align: 'center'}
		,{ text: '시퀀스', datafield: 'popupSeq', hidden:true}
		,{ text: '윈도우타입코드', datafield: 'popupOpenTpWlm', hidden:true }
		,{ text: '창위치(TOP)', datafield: 'popupWinTop', hidden:true }
		,{ text: '창위치(LEFT)', datafield: 'popupWinLeft', hidden:true }
		,{ text: '창중앙정렬여부', datafield: 'popupCenterYesNo', hidden:true}
		,{ text: '창크기(X)', datafield: 'popupWinWidth', hidden:true }
		,{ text: '창크기(Y)', datafield: 'popupWinHeight', hidden:true }
		];

	var _datafields = [
		 { name: 'popupRegTpFe', type: 'string'}
		,{ name: 'popupTitle', type: 'string'}
		,{ name: 'popupDt', type: 'string'}
		,{ name: 'popupOpenTpWlmNm', type: 'string'}
		,{ name: 'popupStatusYn', type: 'string'}
		,{ name: 'regNm', type: 'string'}
		,{ name: 'regDt', type: 'string'}
		,{ name: 'popupSeq', type: 'string'}
		,{ name: 'popupOpenTpWlm', type: 'string'}
		,{ name: 'popupWinTop', type: 'number'}
		,{ name: 'popupWinLeft', type: 'number'}
		,{ name: 'popupCenterYesNo', type: 'string'}
		,{ name: 'popupWinWidth', type: 'number'}
		,{ name: 'popupWinHeight', type: 'number'}
	];

	function fnSearchInit(){
		dateTimeInput("popupDt", null);
		fnGridOption('jqxgrid',{
			height:335
	       ,columns: _columns
	       ,selectionmode: 'singlerow'
	    });
	}

	function fnSearch(){
		var params = $("#searchForm").serialize();

		var dataAdapter = new $.jqx.dataAdapter({
    		datatype: "json",
            datafields: _datafields,
            url: "amM405.action?"+params,
		});

		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

	function fnEvent(){

		$("#btn_Search").on('click', fnSearch);//추가

		$("#registBtn").click(function(){
			$("#registBtn").attr("href","amM405I.action");
		});

		$("#jqxgrid").on("celldoubleclick", function (event)
		{
			var args = event.args;
			var rowBoundIndex = args.rowindex;
			var popupSeq = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "popupSeq");

			var popupTitle = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "popupTitle");
			var popupWinTop = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "popupWinTop");
			var popupWinLeft = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "popupWinLeft");
			var popupWinWidth = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "popupWinWidth");
			var popupWinHeight = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "popupWinHeight");
			var popupCenterYesNo = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "popupCenterYesNo");

			var popupOpenTpWlm = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "popupOpenTpWlm");
				if(popupOpenTpWlm == "W"){
					showPopup("amM405R.action?popupSeq="+popupSeq, "pop", popupWinWidth,popupWinHeight,popupCenterYesNo,popupWinTop,popupWinLeft);
				}else if(popupOpenTpWlm == "L"){
					$("#viewPage").fancybox({
						autoSize	: false,
					    autoScale         : true,
					    autoDimensions    : true,
						nextEffect  : 'none',
				        prevEffect  : 'none',
				        padding     : 0,
				        margin      : [20, 60, 20, 60], // Increase left/right margin
					    fitToView: false,
						maxWidth	: popupWinWidth,
						maxHeight	: popupWinHeight,
						width		: popupWinWidth,
						height		: popupWinHeight
					});
					$("#viewPage").attr("href","amM405R.action?popupSeq="+popupSeq);
					setTimeout(function(){$("#viewPage").click()},200);
				}else if(popupOpenTpWlm == "M"){

					$("#windowIframe").css("width",popupWinWidth+"px");
						$("#windowIframe").css("height",(popupWinHeight-40)+"px");
		                $("#popM").jqxWindow({title: popupTitle});
						$("#windowIframe").attr("src", encodeURI("amM405R.action?popupSeq="+popupSeq));

					if(popupCenterYesNo == 'yes'){
						var windowWidth = $( window ).width();
			            var windowHeight = $( window ).height();
						popupWinTop = (windowWidth - popupWinWidth) / 2;
						popupWinLeft = (windowHeight - popupWinHeight) / 2;
					}
					$('#popM').jqxWindow({
		            	position: {x:popupWinTop,y:popupWinLeft} ,
		                showCollapseButton: false,
		                resizable: false,
		                width: popupWinWidth,
		                height: popupWinHeight
		            });
					$('#popM').jqxWindow('open');
				}else{
					return false;
				}

		});

		$("#modifyBtn").click(function(){
			var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
			if(rowindex > -1){
				var popupSeq = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "popupSeq");
				$("#modifyBtn").attr("href","amM405U.action?popupSeq="+popupSeq);
			}else{
				alert("선택된 팝업이 없습니다");
				return false;
			}
		});

		$("#registBtn,#modifyBtn").fancybox({
			maxWidth	: 900,
			maxHeight	: 1100,
			width		: 1200,
			height		: 1000,
			autoSize	: false
		});

	}

</script>
</head>
<body>
		<div id='popM' style="display:none">
			<div id="windowHeader"><span id="windowTitle"></span></div>
			<div style='overflow:hidden;'>
	            <div class="container">
	                <iframe id="windowIframe" style="border:0px;" class="iframe-class" src=""></iframe>
	            </div>
			</div>
		</div>
	<a  id="viewPage" class="fancybox fancybox.iframe" rel="popup" href="javascript:;" ></a>

	<div class="pageContScroll_st2">
		<div class="top_box">
			<form name="searchForm" id="searchForm">

			<div class="table_type">
				<table>
					<caption>등록일 검색으로 구성된 팝업 목록에 대한 검색 테이블입니다.</caption>
					<colgroup>
						<col style="width:135px;" />
						<col style="width:35%;" />
						<col style="width:135px;" />
						<col style="width:*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">게시기간</th>
							<td  style="min-width:370px">
								<div id='popupDt' name="popupDt"></div>
							</td>
							<th scope="row">팝업명</th>
							<td>
								<input name="popupTitle" id="popupTitle" type="text" style="width:200px;" />
							</td>
						</tr>
						<tr>
							<th scope="row">윈도우타입</th>
							<td>
								<select name='popupOpenTpWlm' id='popupOpenTpWlm' style="width:120px;">
									<option value=''>전체</option>
									<option value='W'>일반윈도우</option>
									<option value='L'>고정레이어</option>
									<option value='M'>이동레이어</option>
								</select>
							</td>
							<th scope="row">출력상태</th>
							<td>
								<select name='popupStatusYn' id='popupStatusYn' style="width:120px;">
									<option value=''>전체</option>
									<option value='Y'>출력</option>
									<option value='N'>미출력</option>
								</select>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
			</form>
		</div>

		<!-- // top_box -->
			<div class="btn_area marB35" >
			<div class="center">
				<a id="btn_Search" class="btn_blue_line2" href="javascript:;">검색</a>
			</div>
			<div class="right" style="line-height:40px;">
				<a id="registBtn" class="btn_type2" data-fancybox-type="iframe" href="javascript:;">등록</a>
				<a id="modifyBtn" class="btn_type2"  style="margin-left:0px;" data-fancybox-type="iframe" href="javascript:;">수정</a>
			</div>
		</div>
	<!-- // top_box -->

		<div class="grid_type1">
			<div id="jqxgrid"></div>
		</div>

	</div>

</body>