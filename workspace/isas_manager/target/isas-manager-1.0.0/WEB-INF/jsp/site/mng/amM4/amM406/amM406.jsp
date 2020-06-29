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
	var contUrl = "${rootUri}${conUrl}amM406";
	function init(){
		fnSearchInit();
		fnSearch();
		fnEvent();
	}
	/*----------------------------------------------------------------------------------------------
	 * Grid 초기값 셋팅
	 *----------------------------------------------------------------------------------------------*/
	var _columns = [
		 	 { text: '배너위치', datafield: 'bannerLocalNm',  width: '12%', cellsalign: 'left', align: 'center'}
			,{ text: '배너제목', datafield: 'bannerTitle',  width: '40%', cellsalign: 'left', align: 'center'}
			,{ text: '게시기간', datafield: 'bannerDt',  width: '16%', cellsalign: 'center', align: 'center'}
			,{ text: '노출상태', datafield: 'bannerStatusNm',  width: '8%', cellsalign: 'center', align: 'center'}
			,{ text: '등록자', datafield: 'regNm',  width: '8%', cellsalign: 'center', align: 'center'}
			,{ text: '등록일', datafield: 'regDt',  width: '8%', cellsalign: 'center', align: 'center', cellsformat: 'yyyy-MM-dd'}
			,{ text: '관리', datafield: 'popButton',  width: '8%', cellsalign: 'center', align: 'center',
				columntype: 'button', cellsrenderer: function () {
	                return "수정";
	             }, buttonclick: function (row) {
	                var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', row);

	            	$.fancybox.open({
						href: "amM406P.action?bannerCd="+dataRecord.bannerCd,
						type: "iframe",
						maxWidth	: 920,
						maxHeight	: 665,
						width		: 900,
						height		: 665,
						autoSize	: false
					});
	            }
			}
			,{ text: 'bannerCd', datafield: 'bannerCd', hidden:true}
			,{ text: 'bannerLocalCd', datafield: 'bannerLocalCd', hidden:true}
			,{ text: 'attchFilePath', datafield: 'attchFilePath', hidden:true}
			,{ text: 'attchMobileFilePath', datafield: 'attchMobileFilePath', hidden:true}
			,{ text: 'attchCd', datafield: 'attchCd', hidden:true}
			,{ text: 'attchMobileCd', datafield: 'attchMobileCd', hidden:true}
			,{ text: 'bannerLink', datafield: 'bannerLink', hidden:true}
			,{ text: 'bannerStartDt', datafield: 'bannerStartDt', hidden:true}
			,{ text: 'bannerEndDt', datafield: 'bannerEndDt', hidden:true}
			,{ text: 'bannerWidthSize', datafield: 'bannerWidthSize', hidden:true }
			,{ text: 'bannerHeightSize', datafield: 'bannerHeightSize', hidden:true }
			,{ text: 'bannerMobileWidthSize', datafield: 'bannerMobileWidthSize', hidden:true }
			,{ text: 'bannerMobileHeightSize', datafield: 'bannerMobileHeightSize', hidden:true }
			,{ text: 'bannerStatus', datafield: 'bannerStatus', hidden:true }
			,{ text: 'regId', datafield: 'regId', hidden:true }
			,{ text: 'backgRoundColor', datafield: 'backgRoundColor', hidden:true }
		];

	var _datafields = [
			 { name: 'bannerLocalNm', type: 'string'}
			,{ name: 'bannerTitle', type: 'string'}
			,{ name: 'bannerDt', type: 'string'}
			,{ name: 'bannerStatusNm', type: 'string'}
			,{ name: 'regNm', type: 'string'}
			,{ name: 'regDt', type: 'date'}
			,{ name: 'bannerCd', type: 'string'}
			,{ name: 'bannerLocalCd', type: 'string'}
			,{ name: 'attchFilePath', type: 'string'}
			,{ name: 'attchMobileFilePath', type: 'string'}
			,{ name: 'attchCd', type: 'string'}
			,{ name: 'attchMobileCd', type: 'string'}
			,{ name: 'bannerLink', type: 'string'}
			,{ name: 'bannerStartDt', type: 'date'}
			,{ name: 'bannerEndDt', type: 'date'}
			,{ name: 'bannerWidthSize', type: 'string'}
			,{ name: 'bannerHeightSize', type: 'string'}
			,{ name: 'bannerMobileWidthSize', type: 'string'}
			,{ name: 'bannerMobileHeightSize', type: 'string'}
			,{ name: 'bannerStatus', type: 'string'}
			,{ name: 'backgRoundColor', type: 'string'}
		];

	function fnSearchInit(){
		dateTimeInput("bannerDt");
		fnGridOption('jqxgrid',{
			height:365
	       ,columns: _columns
	       ,selectionmode: 'none'
	    });
	}

	function fnSearch(){
		var data = {};
		$("#searchForm").serializeArray().map(function(x){data[x.name] = x.value;});
		var dataAdapter = new $.jqx.dataAdapter({
    		datatype: "json",
            datafields: _datafields,
            type: "POST",
            data: data,
            url: "amM406.action",
		});

		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');
		return false;
	}

	var fancybox = {
		width		: 900,
		height		: 600,
		autoSize	: false,
		helpers	: {
			title	: {
				type: 'outside'
			},
			thumbs	: {
				width	: 50,
				height	: 50
			}
		}
	};

	function fnEvent(){
		$("#btn_Search").on('click', fnSearch);//검색
		$("#jqxgrid").on("celldoubleclick", function (event){
			$("#popGallery").html("");
			var args = event.args;
			var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', args.rowindex);
			var imgArr = [{href : dataRecord.attchFilePath, title : '[PC] ' + dataRecord.bannerTitle}];
			if(dataRecord.attchMobileCd){
				imgArr[1] = {href : dataRecord.attchMobileFilePath, title : '[MOBILE] ' + dataRecord.bannerTitle}
			}
			setTimeout(function(){
			$.fancybox(imgArr, fancybox);
			},200);
		});
		$("#registBtn, #modifyBtn").fancybox({
			type: "iframe",
			maxWidth	: 920,
			maxHeight	: 665,
			width		: 900,
			height		: 665,
			autoSize	: false
		});
	}

	function fnFancyboxCloseHandler(){
		$('a.fancybox-item.fancybox-close').click()
	}

</script>
</head>
<body>
	<div class="pageContScroll_st2">
		<div class="top_box">
			<form name="searchForm" id="searchForm">
				<div class="table_type">
					<table>
						<caption>등록일 검색으로 구성된 팝업 목록에 대한 검색 테이블입니다.</caption>
						<colgroup>
							<col style="width: 135px;" />
							<col style="width: 35%;" />
							<col style="width: 135px;" />
							<col style="width: *" />
						</colgroup>
						<tbody>
							<tr>
								<th scope="row">게시기간</th>
								<td style="min-width: 370px">
									<div id='bannerDt' name="bannerDt"></div>
								</td>
								<th scope="row">배너명</th>
								<td><input name="bannerTitle" type="text" style="width: 200px;" /></td>
							</tr>
							<tr>
								<th scope="row">배너위치</th>
								<td>
									<html:selectList name="bannerLocalCd" optionNames="전체" optionValues=""
									list='${eBanner}' listValue='bannerLocalCd' listName='bannerLocalNm' script='style="width: 120px;"'/>
								</td>
								<th scope="row">노출상태</th>
								<td><select name='bannerStatus' style="width: 120px;">
										<option value=''>전체</option>
										<option value='Y' selected="selected">노출</option>
										<option value='N'>비노출</option>
								</select></td>
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
				<a id="registBtn" class="btn_type2" data-fancybox-type="iframe" href="amM406P.action">신규등록</a>
			<a class="btn_type2 btn_icon5" id="btnExcel" style="margin-left:0px;"  href="javascript:;" onclick="grideExportExcel('jqxgrid','배너관리목록');">엑셀다운로드</a>
			</div>
		</div>
	<!-- // top_box -->


		<div class="grid_type1">
			<div id="jqxgrid"></div>
		</div>
	</div>
</body>