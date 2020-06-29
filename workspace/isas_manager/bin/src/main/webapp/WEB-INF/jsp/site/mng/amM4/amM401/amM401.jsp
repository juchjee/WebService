<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
<style>
div.jqx-item{cursor:pointer;}
</style>
<script type="text/javaScript" defer="defer">
<!--
	var contUrl = "${rootUri}${conUrl}amM401";
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){
		dateTimeInput("txtFromDt");
		dateTimeInput("txtToDt");

		fnSearchInit();
		fnSearch();
		fnEvent();

	}


	function fnSearchInit(){

		/*----------------------------------------------------------------------------------------------
		 * Grid 초기값 셋팅
		 *----------------------------------------------------------------------------------------------*/
		$.columns = [
		     { text: '번호', datafield: 'no', columntype: 'number', width: '4%', cellsalign: 'right', align: 'center'
		    	,cellsrenderer: function (row, column, value) {
		            return "<div style='margin:13px 5px 0px 0;text-align:right;'>" + (value + 1) + "</div>";
		        }
		     }
			,{ text: '이벤트구분', datafield: 'eventTpNm', cellclassname: cellclass, width: '8%', cellsalign: 'right', align: 'center'}
			,{ text: '이벤트제목', datafield: 'eventTitle', cellclassname: cellclass, width: '34%', cellsalign: 'left', align: 'center'}
			,{ text: '진행기간', datafield: 'eventDt', cellclassname: cellclass, width: '14%', cellsalign: 'center', align: 'center'}
			,{ text: '참여등급', datafield: 'mbrLevLimitNm', cellclassname: cellclass, width: '8%', cellsalign: 'center', align: 'center'}
			,{ text: '참여제한수', datafield: 'eventPartLimitCount', cellclassname: cellclass, width: '6%', cellsalign: 'center', align: 'center'}
			,{ text: '참여인원수', datafield: 'eventPartCount', cellclassname: cellclass, width: '6%', cellsalign: 'right', align: 'center'}
			,{ text: '당첨자지정', datafield: 'eventWinnersRankYn', cellclassname: cellclass, width: '6%', cellsalign: 'right', align: 'center'}
			,{ text: '당첨자발표', datafield: 'eventWinnersBtn', cellclassname: cellclass, width: '7%', cellsalign: 'center', align: 'center',
				columntype: 'button', cellsrenderer: function () {
	                return "당첨발표";
	             }, buttonclick: function (row) {
	                var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', row);
	                console.log(dataRecord.eventRankYn);
	                if(dataRecord.eventRankYn == 'Y'){
						$.fancybox.open({
							href: "/mng/amM4/amM401/amM401WR.action?eventSeq="+ dataRecord.eventSeq,
							type: "iframe",
							maxWidth	: 1200,
							maxHeight	: 750,
							width		: 1000,
							height		: 650,
							autoSize	: false
						});

	                }else{
	                	alert("당첨자를 지정할 수 없는 이벤트 입니다.");
	                }

	            }
			}
			,{ text: '수정', datafield: 'eventModBtn', cellclassname: cellclass, width: '7%', cellsalign: 'center', align: 'center',
				columntype: 'button', cellsrenderer: function () {
	                return "수정";
	             }, buttonclick: function (row) {
	                var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', row);


	                $.fancybox.open({
						href: "amM401U.action?eventSeq="+ dataRecord.eventSeq,
						type: "iframe",
			 			maxWidth	: 1300,
			 			maxHeight	: 900,
			 			width		: 1300,
			 			height		: 900,
			 			autoSize	: false,
			 			modal : false,
					    beforeClose : function(){
					    	fnSearch();
					    }
					});
// 	    			$("#amM401window").jqxWindow({title: dataRecord.eventTitle});
// 	    			$("#windowIframe").attr("src", encodeURI("amM401U.action?eventSeq="+ dataRecord.eventSeq ));

	            }
			}
			,{ text: '이벤트번호', datafield: 'eventSeq', hidden: true}
		];

		$.datafields = [
		     { name: 'no', type: 'string'}
			,{ name: 'eventTpNm', type: 'string'}
			,{ name: 'eventTitle', type: 'string'}
			,{ name: 'eventDt', type: 'string'}
			,{ name: 'mbrLevLimitNm', type: 'string'}
			,{ name: 'eventPartLimitCount', type: 'string'}
			,{ name: 'eventPartCount', type: 'string'}
			,{ name: 'eventRankYn', type: 'string'}
			,{ name: 'eventWinnersRankYn', type: 'string'}
			,{ name: 'eventWinnersBtn', type: 'string'}
			,{ name: 'eventSeq', type: 'string'}
		];

		fnGridOption('jqxgrid',{
	         height: 340
            ,altrows: true
	        ,columns: $.columns
	    });


// 		// iframe 팝업 설정
// 		var jqxWidget = $('.content_box');
// 	    var offset = jqxWidget.offset();
// 	    $('#amM401window').jqxWindow({
// 	    	position: {x:offset.left+50,y:offset.top} ,
// 	        showCollapseButton: true,
// 	        resizable: false,
// 	        maxWidth:995,
// 	        maxHeight:900
// 	    });

	}

	/*----------------------------------------------------------------------------------------------
	 * grid search
	 *----------------------------------------------------------------------------------------------*/
	function fnSearch(){

		var params = $("#searchForm").serialize();
		var dataAdapter = new $.jqx.dataAdapter({
    		datatype: "json",
            datafields: $.datafields,
            url: contUrl + ".action?"+params
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

	/*----------------------------------------------------------------------------------------------
	 * 페이지 이벤트 함수 모음
	 *----------------------------------------------------------------------------------------------*/
	function fnEvent(){

		$("#btn_Search").on('click', fnSearch);//추가

		// 셀 더블클릭
		$("#jqxgrid").on("celldoubleclick", function (event){
		    var args = event.args;
		    var rowBoundIndex = args.rowindex;
		    if(args.column.columntype != 'button'){
				var eventSeq = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "eventSeq");
				makeForm("${iConstant.get('MALL_URL')}mall/evn/evnDetail.do", {"pageCd":"SFM00301","eventSeq":eventSeq,"page":"1"}, false, "_blank");
				/* setTimeout(function(){
				$.fancybox.open({
					href: "amM401R.action?eventSeq="+eventSeq,
					type: "iframe",
		 			maxWidth	: 1200,
		 			maxHeight	: 900,
		 			width		: 1000,
		 			height		: 800,
		 			autoSize	: false
				});
				},200); */
		    }
		});
	}

	// iframe 팝업창 생성
	function fnBtnEventHandler(type){
		$.fancybox.open({
			href: "amM401I.action",
			type: "iframe",
 			maxWidth	: 1200,
 			maxHeight	: 900,
 			width		: 1000,
 			height		: 800,
 			autoSize	: false,
		    beforeClose : function(){
		    	fnSearch();
		    }
		});
	}

	// iframe 팝업에서 생성되면 해당 페이지에서 parent로 호출되는 함수
	function fnCallBackHandler(_width, _height){
// 		$("#windowIframe").height(_height);
// 		$("#windowIframe").width(_width);
// 		$('#amM401window').jqxWindow({width:_width + 25, height:_height + 50});
// 		$('#amM401window').jqxWindow('open');
	}

	function fnWindowCloseHandler(){
// 		$('#amM401window').jqxWindow('close');
	}


-->
</script>
</head>
<body>
	<div class="pageContScroll_st2">
		<div class="top_box">
			<div class="table_type">
			<form name="searchForm" id="searchForm">
				<table>
					<caption>이벤트에 대한 View 화면을 표시하는 레이어 입니다.</caption>
					<colgroup>
						<col style="width:135px;" />
						<col style="width:35%;" />
						<col style="width:135px;" />
						<col style="width:*" />
					</colgroup>
					<tbody>
						<tr>
							<th scope="row">이벤트구분</th>
							<td  style="min-width:370px">
								<html:selectList name='eventTp' id='eventTp' list='${eventList}' listValue='eventTpCd' listName='eventTpNm' optionValues="" optionNames="전체" script='style="width:120px;"'/>
							</td>
							<th scope="row">진행기간</th>
							<td>
								<div id='txtFromDt' style='float:left;'></div>
								<div style='float:left;line-height:28px;'>&nbsp;~&nbsp;</div>
								<div id='txtToDt'  style='float:left;'></div>
							</td>
						</tr>
						<tr>
							<th scope="row">이벤트제목</th>
							<td>
								<input id="eventTitle" name="eventTitle" type="text" style="width:200px;" onKeyDown="javascript:if (event.keyCode == 13) { fnSearch(); }" />
							</td>
							<th scope="row">참여등급</th>
							<td>
								<html:selectList name='mbrLevCd' id='mbrLevCd' list='${mbrLevList}' listValue='mbrLevCd' listName='mbrLevNm' optionValues="" optionNames="전체" script='style="width:144px;"'/> 이상
							</td>
						</tr>

					</tbody>
				</table>
				</form>
			</div>
			<!-- // table_type -->
		</div>

		<!-- // top_box -->
			<div class="btn_area marB35" >
			<div class="center">
				<a id="btn_Search" class="btn_blue_line2" href="javascript:;">검색</a>
			</div>
			<div class="right" style="line-height:40px;">
			<a class="btn_type2" href="javascript:fnBtnEventHandler('I');">이벤트 등록</a>
			<a class="btn_type2 btn_icon5" id="btnExcel"    style="margin-left:0px;" href="#" onclick="grideExportExcel('jqxgrid','이벤트목록');">엑셀다운로드</a>
			</div>
		</div>
	<!-- // top_box -->

	<div class="grid_type1">
		<div id="jqxgrid" ></div>
	</div>
	<div id='amM401window' style="display: none;">
       <div id="windowHeader"><span id="windowTitle">Header</span></div>
        <div>
            <div class="container">
                <iframe id="windowIframe" class="iframe-class" src=""></iframe>
            </div>
       	</div>
   	</div>
</div><!-- // pageContScroll_st2 -->

</body>