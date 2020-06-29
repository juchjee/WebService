<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
<script type="text/javaScript" defer="defer">

	var contUrl = "${rootUri}${conUrl}amM203";
	/*----------------------------------------------------------------------------------------------
	 * 화면 load시 실행 함수 (onload)
	 *----------------------------------------------------------------------------------------------*/
	function init(){

		// 초기 그리드셋팅
		fnSearchInit();
		// 초기 데이터 셋팅 (대분류)
		fnSearch(0,'root');
	 	// 이벤트
		fnEvent();

	}


	function fnSearchInit(){
		/*----------------------------------------------------------------------------------------------
		 * Grid 초기값 셋팅 - 분류 / 이동이미지
		 *----------------------------------------------------------------------------------------------*/
		 _columns = [
				{ text: '분류', datafield: 'prodCategoryNm', cellclassname: cellclass, width: '80%', cellsalign: 'center', align: 'center'},
				{ text: '', dataField: 'sortUp', width: "10%"
					, cellsrenderer: function (row) {
		                return "<div class=\"sortUp\" style=\"text-align:center;\" ><img src=\'${rootUri}images/btn_green_box_up_arrow.png\' alt=\'\' style=\"margin-top:8px;cursor:pointer;text-align:center;\" /></div>";
		            }
		        },
		        { text: '', dataField: 'sortDown', width: "10%"
					, cellsrenderer: function (row) {
		                return "<div class=\"sortDown\" style=\"text-align:center;\" ><img src=\'${rootUri}images/btn_green_box_down_arrow.png\' alt=\'\' style=\"margin-top:8px;cursor:pointer;text-align:center;\"  /></div>";
		            }
		        },
		        { text: '상품코드', datafield: 'prodCategoryCd', hidden: true},
		        { text: '상품그룹코드', datafield: 'prodCategoryGrpCd', hidden: true}
			];

		 _datafields = [
			{ name: 'prodCategoryNm', type: 'string'},
			{ name: 'sortUp', type: 'image'},
			{ name: 'sortDown', type: 'image'},
			{ name: 'prodCategoryCd', type: 'string'},
			{ name: 'prodCategoryGrpCd', type: 'string'}
		];

		var prodCateUrl = "${rootUri}${conUrl}amM203MAjax.do";

	     var appearance = new Object();
	     	   appearance.selectionmode = "singlecell";
	     	   appearance.height = 235;
	     	   appearance.sortable = false;
	    	   appearance.altrows = true;
	    	   appearance.pageable = false;
	    	   appearance.columns = _columns;

		prodCateSource =
		  {
			datatype: "json"
			,type : "POST"
			,datafields: _datafields
			,id: "category"
			,url: prodCateUrl
		  };
		fnGridOption('category1',appearance);
		fnGridOption('category2',appearance);
		fnGridOption('category3',appearance);
	}

	function fnSearch(idx,paramData){
		var params = "";

		if(idx == 1){
		 	$('.category').eq(2).jqxGrid('clear');
		 	$("#prodCategoryCd2").val("");
		 	$("#prodCategoryCd3").val("");
		 	$("#prodCategoryGrpCd").val("");
		}
		$.extend(prodCateSource,{data:
			{
				prodCategoryCd: paramData
			}
		});

		dataAdapter = new $.jqx.dataAdapter(prodCateSource);
	    $(".category").eq(idx).jqxGrid({ source: dataAdapter, width: '100%'});
		fnResetGridEditData('category');

		return false;
	}

	function fnEvent(){
		  //카테고리 선택시 하위 연계  -- 선택시 이벤트

		$(".category").on('cellselect', function (event)
		{
			var args = event.args;
			var i = $(".category").index(this)+1;
			var row = args.rowindex;
			var datarow = $("#category"+i).jqxGrid('getrowdata', row);

			var item = datarow.prodCategoryCd;
			if(args.datafield == "prodCategoryNm"){

		 		if(i != 3){
		 			if (event.args) {
			        	if (item) {
			        		fnSearch(i,item);
			         	}
		 			}
		 		}
		 		$("#category"+i).val(item);
		 		$("#prodCategoryCd"+i).val(item);
		 		if(i==3){
		 			$("#prodCategoryGrpCd").val(datarow.prodCategoryGrpCd);
		 		}

			}

			if(args.datafield == "sortUp" || args.datafield == "sortDown"){

					var datainfo = $("#category"+i).jqxGrid('getdatainformation');
					var selectrow = row+1;
				 	var totrow = datainfo.rowscount;

					var params = {
							"prodCategoryGrpCd" : item,
							"sortType" : args.datafield,
							"selectRow": selectrow,
							"totRow" : totrow
						};

					var fnSortCheckSuccess =  function(data, dataType){

						var data = data.replace(/\s/gi,'');
						var returnData = "";

						if(data == "ng"){
							alert("이동에 실패하였습니다.");
						}else if(data == "firstData"){
							alert("해당 카테고리는 상위로 이동할 수 없습니다.");
						}else if(data == "lastData"){
							alert("해당 카테고리는 하위로 이동할 수 없습니다.");
						}else{
							alert("이동되었습니다.");
						}

						if(i == 1){
							returnData = "root";
						}else{
							returnData = datarow.prodCategoryGrpCd;
						}
							fnSearch(i-1,returnData)
						};

					fnAjax("sortMod.action", params, fnSortCheckSuccess, "post", "text", "false");

			}
		});


		$(".category").on("bindingcomplete", function (event) {
			$("#category1  strong").text("대분류");
			$("#category2  strong").text("중분류");
			$("#category3  strong").text("소분류");
		});

		$("#viewPage").fancybox({
			type: "iframe",
			maxWidth	: 600,
			maxHeight	: 300,
			width		: '100%',
			height		: '100%',
 			autoSize	: false
		});
// 		$(".fancybox1.big").attr("href","amM203.action?type="+type+"&mode="+mode);
	}

	/** 카테고리 등록 팝업창 **/
	function catePop(type,mode){
		if(mode=='regist'){
			if(type=='large'){
				$("#viewPage").attr("href","amM203.action?type="+type+"&mode="+mode);
				$("#viewPage").click();
			}
			if(type=='medium'){
				if($("#prodCategoryCd1").val()==""){
					alert("중분류 등록 시 해당 카테고리 대분류 제목을 선택해주세요");
					return false;
				}
				var prodCategoryCd = $("#prodCategoryCd1").val();

				$("#viewPage").attr("href","amM203.action?type="+type+"&mode="+mode+"&prodCategoryCd="+prodCategoryCd);
				$("#viewPage").click();
			}
			if(type=='small'){
				if($("#prodCategoryCd1").val()==""||$("#prodCategoryCd2").val()==""){
					alert("소분류 등록 시 해당 카테고리 대분류.중분류 제목을 선택해주세요");
					return false;
				}
				var prodCategoryCd = $("#prodCategoryCd2").val();
				$("#viewPage").attr("href","amM203.action?type="+type+"&mode="+mode+"&prodCategoryCd="+prodCategoryCd);
				$("#viewPage").click();
			}
		}
		else if(mode=='modify'){
			if(type=='large'){
				if($("#prodCategoryCd1").val()==""){
					alert("카테고리 대분류 제목을 선택해주세요");
					return false;
				}
				var prodCategoryCd = $("#prodCategoryCd1").val();
				$("#viewPage").attr("href","amM203.action?type="+type+"&mode="+mode+"&prodCategoryCd="+prodCategoryCd);
				$("#viewPage").click();
			}
			if(type=='medium'){
				if($("#prodCategoryCd2").val()==""){
					alert("카테고리 중분류 제목을 선택해주세요");
					return false;
				}
				var prodCategoryCd = $("#prodCategoryCd2").val();
				$("#viewPage").attr("href","amM203.action?type="+type+"&mode="+mode+"&prodCategoryCd="+prodCategoryCd);
				$("#viewPage").click();
			}
			if(type=='small'){
				if($("#prodCategoryCd3").val()==""){
					alert("카테고리 소분류 제목을 선택해주세요");
					return false;
				}
				var prodCategoryCd = $("#prodCategoryCd3").val();
				var prodCategoryGrpCd = $("#prodCategoryGrpCd").val();
				$("#viewPage").attr("href","amM203.action?type="+type+"&mode="+mode+"&prodCategoryCd="+prodCategoryCd+"&prodCategoryGrpCd="+prodCategoryGrpCd);
				$("#viewPage").click();
			}
		}
	};

	function cateDel(type){
		if(type=='large'){
			if($("#prodCategoryCd1").val()==""){
				alert("카테고리 대분류 제목을 선택해주세요");
				return false;
			}
		}
		else if(type=='medium'){
			if($("#prodCategoryCd2").val()==""){
				alert("카테고리 중분류 제목을 선택해주세요");
				return false;
			}
		}
		else if(type=='small'){
			if($("#prodCategoryCd3").val()==""){
				alert("카테고리 소분류 제목을 선택해주세요");
				return false;
			}
		}
		if(confirm("삭제하시겠습니까?")){
			$("#type").val(type);
    		var params = {"type" : type, "prodCategoryCd1" : $("#prodCategoryCd1").val() ,
    					  "prodCategoryCd2" : $("#prodCategoryCd2").val(), "prodCategoryCd3": $("#prodCategoryCd3").val()};
    		var fnDelSuccess =  function(data, dataType){
				var data = data.replace(/\s/gi,'');
				var returnData = "";
				if(data == "ng1"){
					alert("하위 분류가 존재합니다. 중분류/소분류를 먼저 삭제하세요.");
				}else if(data == "ng2"){
					alert("하위 분류가 존재합니다. 소분류를 먼저 삭제하세요.");
				}else{
					alert("정상적으로 삭제되었습니다.");
					location.reload();
				}
    		}
    		fnAjax("amM203D.action", params, fnDelSuccess, "post", "text", "false");
		} else {
			return false;
		}

	}

	<!--//-->
</script>
</head>

<body>
<div class="pageContScroll_st2">
	<a id="viewPage"  data-fancybox-type="iframe" href="javascript:;"></a>
	<div class="multi_table_area">
		<form id="largeFrm" name="largeFrm" method="post">
			<input type="hidden" id="prodCategoryCd1" name="prodCategoryCd1" />
			<input type="hidden" id="prodCategoryCd2" name="prodCategoryCd2" />
			<input type="hidden" id="prodCategoryCd3" name="prodCategoryCd3" />
			<input type="hidden" id="prodCategoryGrpCd" name="prodCategoryGrpCd" />
			<input type="hidden" id="type" name="type" />
		</form>
		<div style="text-align:right">
			<a class="btn_type1"  href="javascript:;" onclick="catePop('large','regist')">&nbsp;추가&nbsp;</a>
			<a class="btn_type1"  href="javascript:;" onclick="catePop('large','modify')">&nbsp;수정&nbsp;</a>
			<a class="btn_type1" href="#" onclick="cateDel('large')">&nbsp;삭제&nbsp;</a>
			<!-- // table_type1 -->
		</div>
		<!-- // -->
		<div style="text-align:right">
			<a class="btn_type1"  href="javascript:;" onclick="catePop('medium','regist')">&nbsp;추가&nbsp;</a>
			<a class="btn_type1"  href="javascript:;" onclick="catePop('medium','modify')">&nbsp;수정&nbsp;</a>
			<a class="btn_type1" href="#" onclick="cateDel('medium')">&nbsp;삭제&nbsp;</a>
			<!-- // table_type1 -->
		</div>
		<!-- // -->
		<div style="text-align:right">
			<a class=" btn_type1"   href="javascript:;" onclick="catePop('small','regist')">&nbsp;추가&nbsp;</a>
			<a class="btn_type1"  href="javascript:;" onclick="catePop('small','modify')">&nbsp;수정&nbsp;</a>
			<a class="btn_type1" href="#" onclick="cateDel('small')">&nbsp;삭제&nbsp;</a>
			<!-- // table_type1 -->
		</div>
		<div style="text-align:right">

			<div  style="margin-top:5px;">
				<!-- 대분류 그리드 -->
				<div class="category" id="category1"></div>
			</div>
			<!-- // table_type1 -->
		</div>
		<!-- // -->
		<div style="text-align:right">

			<div style="margin-top:5px;">
				<!-- 중분류 그리드 -->
				<div class="category" id="category2"></div>
			</div>
			<!-- // table_type1 -->
		</div>
		<!-- // -->
		<div style="text-align:right">
			<div style="margin-top:5px;">
				<!-- 소분류 그리드 -->
				<div class="category" id="category3"></div>
			</div>
			<!-- // table_type1 -->
		</div>
		<!-- // -->
	</div>
</div>
</body>