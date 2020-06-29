<%@ page language="java" pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="ui" uri="http://egovframework.gov/ctl/ui"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
<script type="text/javaScript" defer="defer">
<!--
var contUrl = "${rootUri}${conUrl}amM202";
/*----------------------------------------------------------------------------------------------
 * 화면 load시 실행 함수 (onload)
 *----------------------------------------------------------------------------------------------*/
function init(){

  //이벤트 설정
  fnEvent();

  //화면 기본 데이터 셋팅
  fnDataSetting();


  //상품 카테고리 기본 셋팅
   fnProdCateInit();
}

/*----------------------------------------------------------------------------------------------
 * 카테고리 초기설정 함수
 *----------------------------------------------------------------------------------------------*/
function fnProdCateInit(){
	prodCateUrl = "${rootUri}${conUrl}prodCateSeach.action";  // prepare the data
	prodCateSource =
	  {
	       datatype: "json"
	      ,type : "POST"
	      ,datafields: [
	          { name: 'prodCategoryNm' },
	          { name: 'prodCategoryCd' }
	      ]
	      ,id: "category"
	      ,url: prodCateUrl
	  };
}

/*----------------------------------------------------------------------------------------------
 * 페이지 이벤트 함수 모음
 *----------------------------------------------------------------------------------------------*/
function fnEvent(){

	 /*-----------------------------  카테고리 사이즈 조정 ---------------------------------------*/
	$.listBoxWidthResise = function(idx){
		  var windowWidth = ($( window ).width()/4.3)-140;
	        if(windowWidth > 130){
	        	if(idx == undefined){
	                $(".category").jqxListBox('width', windowWidth);
	        	}else{
	        		$(".category").eq(idx).jqxListBox('width', windowWidth);
	        	}
		}
	}
	 $( window ).resize(function() {
		 $.listBoxWidthResise();
     });
	 /*-----------------------------  카테고리 검색 함수 ---------------------------------------*/
	 $.fnProdCateSeach = function(idx,paramData){
		var params = "";
			//변동형 인자값 추가
			$.extend(prodCateSource,{data:
				{
					prodCategoryCd: paramData
				}
			});


		// jqx용 데이터 아답터 생성
		  var dataAdapter = new $.jqx.dataAdapter(prodCateSource);

		//jqxListBox 생성
	    $(".category").eq(idx).jqxListBox({ source: dataAdapter, displayMember: "prodCategoryNm", valueMember: "prodCategoryCd", width: '130px', height: '100px'});
	    $.listBoxWidthResise(idx);

	}

	/*----------------------------- 카테고리 선택시 하위 연계  -- 버튼 클릭 이벤트 -----------------------------*/
 	$(".category").bind('click', function (event) {
			var i = $(".category").index(this)+1;

		//소분류일때 이벤트 제한
 		if(i  != $(".category").length){

 			//대분류 선택일때 소분류 데이터 비우기
			$('.category').each(function(index, value){
 				var idxLoop = index+1;
 		 	 		if(i  < idxLoop){
 			 				$('.category').eq(idxLoop-1).jqxListBox('clear');
 		 			}
 			});
				//현재 선택 아이템 object 변수에 정의
 		    	var item = $(".category").eq(i-1).jqxListBox('getSelectedItem');

 		         if (item) {
 		        	 //카테고리 검색 함수 호출
 		         	$.fnProdCateSeach(i,item.value);
 		         }
	 	}

 		$.listBoxWidthResise(i);
	 });

	/*----------------------------- 상품분류 등록 - 버튼 클릭 이벤트 -----------------------------*/
	$( "#prodCateReg" ).bind("click",function() {
		var returnLabel = "";
		var returnValue = "";


		// 1 선택한 클래스 검색  (Loop)
		$('.category').each(function(index, value){
			var item = $(this).jqxListBox("getSelectedItem");

			if(item != undefined){
				if(index != 0){
					returnLabel += " > ";
				}
				returnLabel += item.label;
				returnValue = item.value;
			}
		});

		// 2 중복 카테고리 확인
		var overlapChk = true;
		$("input[name='categoryMpgArr']").each(function(index, value){
			if($(this).val() == returnValue){
				alert("이미 선택된 카테고리 입니다.");
				overlapChk = false;
			    return overlapChk;
			}
		});

		if(overlapChk == true){
			// 3. 저장될 카테고리 맵핑 데이터 input 추가
				// 3.1 빈 카테고리 도움말 삭제
				if($(".emptyText").length != 0){$(".emptyText").remove()};

				$("#workForm").append(makeInput("categoryMpgArr", returnValue));
				$("#categoryMpg").append("<li><div>"+returnLabel+"<a class=\"\" href=\"javascript:;\"><img src=\"${rootUri}images/btn_keyword_del.png\" alt=\"카테고리 삭제\"></a></div></li>");

			// 4. 카테고리 맵핑 데이터 생성된 엘리멘트 삭제 일회성 이벤트 생성

				//4-0 소멸 후 함수 재 생성
				$("#categoryMpg a").unbind("click");

				//4-0 소멸 후 함수 재 생성
				$("#categoryMpg a").bind("click",function() {

					//현재 인덱스를 변수에 정의
					var idx = $("#categoryMpg a").index(this);

					$("#workForm").find("input[name='categoryMpgArr']").eq(idx).remove();
					$("#categoryMpg > li").eq(idx).remove();

					//4-1 선택 카테고리 모두 삭제시 도움말 삽입
					if($("#categoryMpg > li").length == 0){
						$("#categoryMpg").append("<li class=\"emptyText\">선택된 카테고리가 없습니다.</li>");
					}
				});

		  }
	});

	/*----------------------------- 기본이미지 - 버튼 클릭 이벤트 Start -----------------------------*/
	$(".bisImg").bind("click",function() {
		fileSearch({fileAttrName:"prodBasicImgPath",fileViewAttrName:"prodBasicImgName",form:"workForm",filetype:'image'});
	});
	/*----------------------------- 기본이미지 - 버튼 클릭 이벤트 End-----------------------------*/

	$("input[name='prodBasicSizeBms']").bind("change",function() {

		var idx = $("input[name='prodBasicSizeBms']").index(this);

		var $fname = $("input[name='prodBasicSizeBmsPx']").eq(idx);

			if($(this).is(":checked")){
				$fname.css('background','#fff');
				$fname.attr("disabled",false);
			}else{
				$fname.css('background','#ccc');
				$fname.attr("disabled",true);
			}
	});


	/*----------------------------- 상세이미지 - 추가 버튼 클릭 이벤트 Start -----------------------------*/
	  $.attfileAdd = function(className,len){
		$("."+className).append("<div class=\"attfileAdd\">"+
	        "	<div  class=\"fl\">"+
	        "		<input type=\"text\" name=\"dtlImgName\" class=\"fl verT marL5 inputPx200\" readonly=\"readonly\" /><a class=\"fl dtlImg btn_type1 marL10\" href=\"javascript:;\">파일찾기</a>"+
	        "		<a href=\"javascript:;\"  class=\"fl fileAdd btn_type4\">+</a>"+
	        "		<input type=\"checkbox\" name=\"prodImgDisPcYn\" id=\"PC_view"+len+"\" class=\"marL30\" style=\"line-height:28px;\" value=\"Y\"  checked=\"checked\" /><label for=\"PC_view"+len+"\" style=\"line-height:28px;\" class=\"marL5\">PC 노출</label>"+
	        "		<input type=\"checkbox\" name=\"prodImgDisMobileYn\" id=\"mobile_view"+len+"\" style=\"line-height:28px;\" class=\"marL30\"  value=\"Y\" checked=\"checked\" /><label for=\"mobile_view"+len+"\" style=\"line-height:28px;\" class=\"marL5\">모바일 노출</label>"+
	        "	</div>"+
    	"</div>");


			$(".attfileAdd > div > .fileAdd").unbind("click");
			$(".attfileAdd > div > .fileAdd").bind("click",function() {
				if($(this).text() == "+"){
					$(this).removeClass("btn_type4");
					$(this).addClass("btn_type5");
					$(this).text("-");
					$.attfileAdd(className,$('.attfileAdd').length);
				}else if($(this).text() == "-"){
					var fileAddIdx = $(".attfileAdd > div > .fileAdd").index(this);
			 		var fileId = "dtlImgPath_"+fileAddIdx;
				 	$("form[name=workForm]").find("input[name=dtlImgPath_seq]").eq(fileAddIdx).remove();
				 	$("form[name=workForm]").find("input[class="+fileId+"]").remove();

				 	$(".attfileAdd").eq(fileAddIdx).remove();

					$("form[name=workForm]").find("input[name=dtlImgPath]").each(function(index, item){
						var reClassNameArr = $(this).attr("class").split("_");
			            var reClassName = reClassNameArr[0];

		            	var seqInput = $("form[name=workForm]").find("input[name=dtlImgPath_seq]");

			            if(reClassNameArr[1] > fileAddIdx){
				            var reClassIdx = (reClassNameArr[1]-1);
			            	$(this).attr("class",reClassName+"_"+reClassIdx);
			            	//alert(index);
			            	seqInput.eq(index).val(reClassIdx);
			            }
			        });
				}else{
					return false;
				}
			});

			$(".dtlImg").unbind("click");
			/*----------------------------- 상세이미지 - 파일 찾기 버튼 클릭 이벤트(소멸성이벤트) -----------------------------*/
			 $(".dtlImg").bind("click",function() {
					//확장형 첨부일 경우 인덱스 인자 추가 전달
					var idx = $(".dtlImg").index(this);
					//파라메터 값 object 형
			   		 var obj = new Object();
			   		obj.fileAttrName = "dtlImgPath"; //실제 전달할 파일 속성명
			   	   	obj.fileViewAttrName = "dtlImgName"; //현재 노출되는 속성명 name
			   	   	obj.form = "workForm"; //전송할 form name
			   	   	obj.filetype = "image"; //파일 제한 종류 -- image (현재 이미지만 구현)
			   	   	obj.index = idx; //확장형 첨부파일일 경우 사용될 인덱스
					fileSearch(obj);
				});
	}
		/*----------------------------- 상세이미지 - 추가 버튼 클릭 이벤트 End -----------------------------*/

		/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 Start -----------------------------*/
	 $.submit = function(){
		if($("#prodTypeGsp").val() != "P"){
			if($("#workForm").find("input[name='categoryMpgArr']").length == 0){
				alert("한개 이상 상품분류를 등록 해야 합니다.");
				$(".pageContScroll_st1").mCustomScrollbar("scrollTo","top",{   scrollInertia:500});
				return false;
			}
		}

		 if($("input[name=prodFormDt]").val() == ""){
			  alert(message(MESSAGES_VALID.REQUIRED,["판매시작일"]));
			  $("input[name=prodFormDt]").focus();
				return false;
		  }

			if($("input[name=prodPmntYn]").is(":checked") == false){
				  if($("input[name=prodToDt]").val() == ""){
					  alert(message(MESSAGES_VALID.REQUIRED,["판매종료일"]));
					  $("input[name=prodToDt]").focus();
						return false;
				  }
			}

			if($("#workForm").find("input[name='prodBasicImgPath']").length == 0){
				alert("기본이미지를 등록하세요!");
				$(".pageContScroll_st1").mCustomScrollbar("scrollTo","800px",{   scrollInertia:500});
				return false;
			}

			if($("#imgL").is(":checked") == false){
				if($("#workForm").find("input[name='dtlImgPath']").length == 0){
					alert("기본이미지의 대(상세이미지)를 미체크시 상세이미지를 등록 하셔야합니다.!");
					$(".pageContScroll_st1").mCustomScrollbar("scrollTo","850px",{   scrollInertia:500});
					return false;
				}
			}

			fnSubmit("workForm","저장");
	}
		/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 End -----------------------------*/


		/*----------------------------- 상품구성 -변경(일반,세트,포인트상품)시 화면구성 변경 이벤트 Start -----------------------------*/
	 $("#prodTypeGsp").bind("change",function() {
		 if($(this).val() == "P"){
			 $(".tpP").hide();
			 $("#prodSetBtn").hide();
			 $(".prodPriceNm").text("포인트상품가");
			 $(".prodUit").text("포인트");

			 $("#categoryLyout").hide();
			 $("input[name=prodWearingQty]").attr("disabled", false);
			 $(".wQty").show();
		 }else{
			 if($(this).val() == "S"){
				 $("input[name=prodWearingQty]").attr("disabled", true);
				 $(".wQty").hide();
			 }else{
				 $("input[name=prodWearingQty]").attr("disabled", false);
				 $(".wQty").show();
			 }
			 $(".tpP").show();
			 $(".prodPriceNm").text("판매정가");
			 $(".prodUit").text("원");
			 $("#categoryLyout").show();
			 if($(this).val() == "S"){
				 $("#prodSetBtn").show();
			 }else{
				 $("#prodSetBtn").hide();
			 }
		 }
	 });

		/*----------------------------- 상품구성 -변경(일반,세트,포인트상품)시 화면구성 변경 이벤트 End -----------------------------*/


		/*----------------------------- 판매기간 - 상시제품 여부에 따른 변경 이벤트 Start -----------------------------*/
		 $("input[name=prodPmntYn]").bind("click",function() {
			 var prodPmntYn = $(this).is(":checked");
			  $("#prodToDt").jqxDateTimeInput({ disabled: prodPmntYn});
		 });
			/*----------------------------- 판매기간 - 상시제품 여부에 따른 변경 이벤트 End -----------------------------*/


		 /*----------------------------- 상품종류변경시 추가정보,상세정보,고시사항 변경 이벤트 Start -----------------------------*/
			$("select[name=prodTpCd]").bind("change",function() {
				//초기화
				$("#prodAddInfo").html("");
				$("#prodNotif").html("");
				$("#prodRelated").html("");

				//-------------- 추가정보 변경
				fnAjax("prodAddInfoList.action", {"prodTpCd" : $("select[name=prodTpCd]").val()}, function(prodAddInfo, dataType){
					for (key in prodAddInfo) {
						$("#prodAddInfo").append("<tr>"+
						          "<th scope=\"row\">"+prodAddInfo[key].prodAddInfoNm+"</th>"+
						          "<td id="+prodAddInfo[key].prodAddInfoCd+">");

									$("#prodAddInfo").append("</td></tr>");

									if(prodAddInfo[key].prodAddTpSn == "S"){
										$("#"+prodAddInfo[key].prodAddInfoCd).html("<input type=\"text\"  name=\"prodAddInfoVal\" autocomplete=\"off\" style=\"width:600px\" value=\"\" />");
									}else if(prodAddInfo[key].prodAddTpSn == "N"){
										$("#"+prodAddInfo[key].prodAddInfoCd).html("<input type=\"text\"  name=\"prodAddInfoVal\" autocomplete=\"off\" class=\"alignR validation[number]\" style=\"width:50px\" placeholder=\"0\" value=\"\" />");
									}

									$("#"+prodAddInfo[key].prodAddInfoCd).append("&nbsp;"+nvl(prodAddInfo[key].prodAddSubText));
									  $("#"+prodAddInfo[key].prodAddInfoCd).append("<input type=\"hidden\"  name=\"prodAddInfoCd\" style=\"width:154px\" value=\""+prodAddInfo[key].prodAddInfoCd+"\" />");
							}
					$("input[name=prodAddInfoVal][class*=validation]").each(function(index, value){
						if($(this).attr("class").indexOf("number") > -1){
							$(this).val(setComma($(this).val()));

							$(this).bind("keyup",function() {
								$(this).val(setComma($(this).val()));
							});
						}
					});
					},'POST','json');

				//-------------- 상세정보변경
				fnAjax("prodRelatedList.action", {"prodTpCd" : $("select[name=prodTpCd]").val()}, function(prodRelated, dataType){
						for (key in prodRelated) {
							$("#prodRelated").append( "<tr>"+
				          "<th scope=\"row\" style='min-width:127px;width:127px;'>"+prodRelated[key].prodRelatedNm+
				          	"<div class=\"thInfo\"><a class=\"fancybox sme btn_type1\"  data-fancybox-type=\"iframe\" href=\"/mng/smartEditor.action?divName="+prodRelated[key].prodRelatedCd+"\">에디터호출</a></div>"+
				          	"<div class=\"thInfo\"><input type=\"checkbox\" id=\""+prodRelated[key].prodRelatedCd+"_chk\" name=\""+prodRelated[key].prodRelatedCd+"ContSave\" value=\"Y\" /><label for=\""+prodRelated[key].prodRelatedCd+"_chk\" class=\"marL5\">기본정보로 사용</label></div>"+
				          "</th>"+
				          "<td>"+
					          "<div class=\"editScroll\" ><div id=\""+prodRelated[key].prodRelatedCd+"\" class=\"edit_area\"></div>");

					          $("#prodRelated").append( "</div>");
					          $("#prodRelated").append( "<input type=\"hidden\" name=\"prodRelatedCd\" value=\""+prodRelated[key].prodRelatedCd+"\" />");
					          $("#prodRelated").append( "<textarea name=\"prodRelatedVal\" id=\""+prodRelated[key].prodRelatedCd+"_Text\" style=\"display:none;\" >"+nvl(prodRelated[key].prodRelatedVal)+"</textarea>");

					          if(nvl(prodRelated[key].prodRelatedVal) == ""){
					        	  $("#"+prodRelated[key].prodRelatedCd).html( "미리보기 -  내용이 없습니다.");
					          }else{
					        	  $("#"+prodRelated[key].prodRelatedCd).html(decodeTag(prodRelated[key].prodRelatedVal));
					          }
						}
						// 네이버 스마트 에디터 레이어 팝업 - 미리보기 스크롤 이벤트 디자인
						 $(".editScroll").mCustomScrollbar({
							    theme:"minimal-dark",
								scrollButtons:{
									enable:true,
									scrollType:"stepped"
								},
								axis:"yx",
								keyboard:{scrollAmount:50},
							    snapAmount:20,
							    mouseWheel:{deltaFactor:50},
							    scrollInertia:400

							});

					$(".fancybox.sme").fancybox({
						maxWidth	: 1350,
						maxHeight	: 550,
						width		: '100%',
						height		: '100%',
						autoSize	: false,
						openEffect	: 'none',
						closeEffect	: 'none',
					    iframe : { preload: false },
					    beforeClose : function(){
					    	var this_ifram = this.content.get(0).contentWindow;
					    	if(this_ifram){
					    		if(this_ifram.$_fancyboxIsAutoClose){
						    		if(confirm(message(MESSAGES_CFM.POPUP_CANCEL))){
						    			this_ifram.fnFancyboxClose();
										return true;
							    	}else{
							    		return false;
							    	}
						    	}
					    	}

					    },
					    afterClose : function(){
							$(".editScroll").mCustomScrollbar("update");
						}
					});
				},'POST','json');

				//-------------- 고시사항 변경
				fnAjax("prodNotifList.action", {"prodTpCd" : $("select[name=prodTpCd]").val()}, function(prodNotif, dataType){
						for (key in prodNotif) {
							$("#prodNotif").append("<tr>"+
					          "<th scope=\"row\">"+prodNotif[key].prodNotifNm+"</th><td>"+
					          "	<input type=\"hidden\" name=\"prodNotifCd\" value=\""+prodNotif[key].prodNotifCd+"\" />"+
					          "<input type=\"text\"  name=\"prodNotifVal\" autocomplete=\"off\" style=\"width:96%;\" value=\""+nvl(prodNotif[key].prodNotifVal)+"\" />"+
					          "</td>"+
					          "<th scope=\"row\"><input type=\"checkbox\" id=\""+prodNotif[key].prodNotifCd+"_chk\" name=\""+prodNotif[key].prodNotifCd+"ContSave\" value=\"Y\" /><label for=\""+prodNotif[key].prodNotifCd+"_chk\" class=\"marL5\">기본정보로 사용</label>"+
					          "</th>"+
					          "</tr>");
						}

				},'POST','json');


			});
			/*----------------------------- 상품종류변경시 추가정보,상세정보,고시사항 변경 이벤트 End -----------------------------*/
}

function fnDataSetting(){
	 // root 카테고리 초기로
	 	setTimeout(function(){
			  $.fnProdCateSeach(0,'root');
	 	},10);

	  // datepicker 정의
	  dateTimeInput("prodFormDt", null, "${nowYmd}");
	  dateTimeInput("prodToDt");


	  //초기화 기본 데이터
	  $("input[name=prodDisPcYn]").eq(0).attr("checked",true);  //PC Web 노출
	  $("input[name=prodDisMobileYn]").eq(0).attr("checked",true);  //모바일 웹노출
	  $("input[name=prodStatusCd]").eq(0).attr("checked",true);  //판매상태
	  $("input[name=prodBasicSizeBms]").attr("checked",true);  //기본이미지분류(대중소) - 전체 체크
	  $("input[name=prodTaxTpTf]").eq(0).attr("checked",true);  //과세구분(T :  과세 , F : 면세)

	//   $("input[name=prodPmntYn]").attr("checked",true);
	  $("input[name=prodPmntYn]").click();

	  //상세이미지 초기셋팅
	  $.attfileAdd("dtlimgAdd","0");

      $("select[name=prodTpCd]").change();
}
//-->
</script>
<style>
</style>
</head>

<body>
	 <div class="pageContScroll_st1">
	 	<form id="workForm" name="workForm" action="amM202Save.action" method="post" enctype="multipart/form-data">
	 	<div id="categoryLyout">
			  <h3>상품전시카테고리 등록</h3>
			  <div class="top_box" style="margin-bottom:0px;">
			    <div class="text_type">
			      <p>등록하려는 상품의 해당분류(카테고리)를 지정해주는 기능입니다. 다중분류지정이 가능합니다.<br />1차분류부터 클릭하여 해당분류를 등록하세요. (하나의 상품이 여러개의 분류를 갖는 것을 다중분류라고 합니다.)</p>
			      <div>
			        <div class="serach_type group_choice_type">
			          <ul>
			            <li>
			              <div class="group_choice">
			                <p>대분류 선택</p>
			                <div class="category"></div>
			              </div>
			              <!-- // group_choice -->
			            </li>
			            <li>
			              <div class="group_choice">
			                <p>중분류 선택</p>
			                <div class="category"></div>
			              </div>
			              <!-- // group_choice -->
			            </li>
			            <li>
			              <div class="group_choice">
			                <p>소분류 선택</p>
			                <div class="category"></div>
			              </div>
			              <!-- // group_choice -->
			            </li>
			            <li>
			              <div id="prodCateReg" class="btn_blue_line" >상품분류 등록</div>
			            </li>
			          </ul>
			        </div>
			      </div>
			    </div>
			    <!-- // text_type -->
			  </div>
			  <!-- // top_box -->
			  <div class="group_choice_result">
			    <div class="add_field">
			      <div class="field_ul">
			        <ul id="categoryMpg"><li class="emptyText">선택된 카테고리가 없습니다.</li></ul>
			      </div>
			      <!-- // field_ul -->
			    </div>
			    <!-- // add_field -->
			  </div>
		  </div>
		  <!-- // group_choice_result -->
		  <h3>상품 기본정보 등록</h3>
		  <div class="table_type2">
		    <table>
		      <caption>상품구성, 상품번호, 바코드(상품코드), 상품명, 보조상품명, 분류 키워드, 연관상품, 섭취기간, 제품분류코드, 간략설명으로 구성된 상품 기본정보 등록에 대한 작성 테이블 입니다.</caption>
		      <colgroup>
		        <col style="width:140px;">
		        <col style="width:*">
		      </colgroup>
		      <tbody>
		        <tr>
		          <th scope="row">상품구성</th>
		          <td colspan="3">
		            <div class="add_field">
		              <select id="prodTypeGsp" name="prodTypeGsp" style="width:154px;">
		                <option value="G" selected="selected">일반상품</option>
		                <option value="S">세트상품</option>
		                <option value="P">포인트상품</option>
		              </select>
		              <a id="prodSetBtn" class="fancybox bis btn_type1" data-fancybox-type="iframe" href="/mng/popup/prodSearchPop.do?tp=set">세트묶음선택</a>
		              <div class="field_ul">
		                <ul id="setMpg"></ul>
		              </div>
		              <!-- // field_ul -->
		            </div>
		            <!-- // add_field -->
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">상품번호</th>
		          <td>
		           	${prodTempCd} (생성예정 상품번호)
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">상품명</th>
		          <td>
		            <input type="text" id="prodNm" name="prodNm"  class="validation[required]" title="상품명" style="width:600px" />
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">상품종류</th>
		          <td>
		          	<select style="width:154px;" name="prodTpCd" class="marR10">
		      			<c:forEach items="${prodTpList}" var="prodTp">
		              		<option value="${prodTp.prodTpCd}">${prodTp.prodTpNm}</option>
		              	</c:forEach>
		            </select>
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">보조상품명</th>
		          <td>
		            <div class="add_field">
		              <a class="fancybox bis btn_type1" data-fancybox-type="iframe" href="amM202Sec.action">보조상품검색</a>
		              <div class="field_ul">
		                <ul id="secMpg"></ul>
		              </div>
		              <!-- // field_ul -->
		            </div>
		            <!-- // add_field -->
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">분류 키워드</th>
		          <td>
		            <div class="add_field">
		              <a class="fancybox bis btn_type1" data-fancybox-type="iframe" href="/mng/popup/keywordPop.do">키워드검색</a>
		              <div class="field_ul">
		                <ul id="keywordMpg"></ul>
		              </div>
		              <!-- // field_ul -->
		            </div>
		            <!-- // add_field -->
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">연관상품</th>
		          <td>
		            <div class="add_field">
		              <a class="fancybox bis btn_type1" data-fancybox-type="iframe" href="/mng/popup/prodSearchPop.do?tp=prod">상품검색</a>
		              <div class="field_ul">
		                <ul id="prodMpg"></ul>
		              </div>
		              <!-- // field_ul -->
		            </div>
		            <!-- // add_field -->
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">간략설명</th>
		          <td>
		            <input type="text" id="prodDesc" name="prodDesc" style="width:600px" />
		          </td>
		        </tr>
		      </tbody>
		    </table>
		  </div>

		   <!-- // group_choice_result -->
		  <h3 class="fl">상품 추가정보 등록</h3>
<!-- 		  <div class="fr"><a class="fancybox bis btn_type1" data-fancybox-type="iframe" href="prodAddInfo.action?tp=set">상품 추가정보 편집</a></div> -->
		  <div class="table_type2">
		    <table>
		      <caption>추가 정보</caption>
		      <colgroup>
		        <col style="width:140px;">
		        <col style="width:*">
		      </colgroup>
		      <tbody  id="prodAddInfo"></tbody>
		    </table>
		  </div>

		  <!-- // table_type2 -->
		  <h3>상품 전시정보 등록</h3>
		  <div class="table_type2">
		    <table>
		      <caption>PC Web 노출, 모바일 웹노출, 표시아이콘, 판매상태, 기본이미지, 상세이미지로 구성된 상품 전시정보 등록에 대한 작성 테이블 입니다.</caption>
		      <colgroup>
		        <col style="width:140px;">
		        <col style="width:*">
		        <col style="width:140px;">
		        <col style="width:*">
		      </colgroup>
		      <tbody>
		        <tr>
		          <th scope="row">PC Web 노출</th>
		          <td>
		            <input type="radio" id="view_pc" name="prodDisPcYn" class="marR5" value="Y"  /><label for="view_pc" class="marR15">노출</label>
		            <input type="radio" id="noview_pc" name="prodDisPcYn" class="marR5" value="N"/><label for="noview_pc">노출 안함</label>
		          </td>
		          <th scope="row">모바일 웹노출</th>
		          <td>
		            <input type="radio" id="view_mobile" name="prodDisMobileYn" class="marR5" value="Y" /><label for="view_mobile" class="marR15">노출</label>
		            <input type="radio" id="noview_mobile" name="prodDisMobileYn" class="marR5" value="N" /><label for="noview_mobile">노출 안함</label>
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">표시아이콘</th>
		          <td colspan="3">
		            <div class="product_icon">
		              <ul id="iconMpg">
		      			<c:forEach items="${prodIconList}" var="prodIcon">
		                <li><input type="checkbox" id="${prodIcon.prodIconCd }" name="prodIcon"  value="${prodIcon.prodIconCd }" /><label style="background:#${prodIcon.prodIconColor}" for="${prodIcon.prodIconCd }">${prodIcon.prodIconNm}</label></li>
		                 </c:forEach>
		                <li class="marL30"><a class="fancybox bis btn_type1" data-fancybox-type="iframe" href="amM202Icon.action">아이콘추가</a></li>
		              </ul>
		            </div>
		            <!-- // product_icon -->
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">판매상태</th>
		          <td colspan="3">

		      	<c:forEach items="${prodStatusList}" var="prodStatus">
		            <input type="radio" id="${prodStatus.prodStatusCd}" name="prodStatusCd" class="marR5" value="${prodStatus.prodStatusCd}"/><label for="${prodStatus.prodStatusCd}" class="marR15">${prodStatus.prodStatusNm}</label>
		         </c:forEach>
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">기본이미지</th>
		          <td colspan="3">
		            (5:5) 이미지<input type="text" name="prodBasicImgName" class="verT marL5 inputPx200" style="width:200px" readonly="readonly" />
		            <a class="bisImg btn_type1  marL10" href="javascript:;">파일찾기</a>
		            <input type="checkbox" id="imgL" name="prodBasicSizeBms" class="marL25" value="B" /><label for="imgL" class="marL5">대</label>
		            <input type="checkbox" id="imgM" name="prodBasicSizeBms" class="marL25" value="M"  /><label for="imgM" class="marL5">중</label>
		            <input type="checkbox" id="imgS" name="prodBasicSizeBms" class="marL25" value="S"  /><label for="imgS" class="marL5">소</label>
		            <div class="marT10">※ 대형 사이즈 이미지를 업로드 하면 대(상세화면), 중(리스트화면), 소(기타-주문화면등) 이미지는 자동으로 생성됩니다. 사용할 이미지를 체크하십시오.</div>
		            <div class="marT10">
		              <span>※ 가로/세로 픽셀 정의시 비율로 생성</span>
		              <span class="marL30">대형<input type="text" name="prodBasicSizeBmsPx" class="marLR10 alignR validation[number]" style="width:55px;"  value="607" />픽셀</span>
		              <span class="marL30">중형<input type="text"  name="prodBasicSizeBmsPx"  class="marLR10 alignR validation[number]" style="width:55px;" value="607" />픽셀</span>
		              <span class="marL30">소형<input type="text" name="prodBasicSizeBmsPx" class="marLR10 alignR validation[number]" style="width:55px;" value="105" />픽셀</span>
		            </div>
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">상세이미지</th>
		          <td colspan="3" class="dtlimgAdd"></td>
		        </tr>
		      </tbody>
		    </table>
		  </div>
		  <!-- // table_type2 -->
		  <h3>상품 구매정보 등록</h3>
		  <div class="table_type2">
		    <table>
		      <caption>판매정가, 할인가, 과세구분, 배송료, 총재고수량, 신규입고, 판매수량, 판매진행수, 적립금, 소비자가, 매입가격, 공급가격, 판매기간으로 구성된 상품 구매정보 등록에 대한 작성 테이블 입니다.</caption>
		      <colgroup>
		        <col style="width:140px;">
		        <col style="width:*">
		        <col style="width:140px;">
		        <col style="width:*">
		      </colgroup>
		      <tbody>
		       <tr>
		          <th class="prodPriceNm" scope="row">판매정가</th>
		          <td>
		            <input type="text"  name="prodPrice" class="marR5 alignR validation[number,required]" title="판매정가" placeholder="0"   /> <span class="prodUit">원</span>
		          </td>
		          <th scope="row">배송료</th>
		          <td>
		            <select style="width:154px;" name="prodDeliPlicyCd" class="marR10">
		      			<c:forEach items="${prodDeliPlicyList}" var="prodDeliPlicy">
		              		<option value="${prodDeliPlicy.prodDeliPlicyCd}">${prodDeliPlicy.prodDeliPlicyNm}</option>
		              	</c:forEach>
		            </select>
		          </td>
		        </tr>
		        <tr class="tpP">
		        <th scope="row">할인가</th>
		          <td>
		            <input type="text" name="prodSalePrice" class="marR5 alignR validation[number]" placeholder="0" /> 원
		          </td>
		          <th scope="row">과세구분</th>
		          <td>
		            <input type="radio" id="tax1" name="prodTaxTpTf"  value="T" /><label for="tax1">과세</label><input type="radio" id="tax2" name="prodTaxTpTf" class="marL30" value="F"  /><label for="tax2">면세</label>
		          </td>
		        </tr>
		        <tr class="tpP">
		         <th scope="row">소비자가격</th>
		          <td>
		            <input type="text" id="prodRetailPrice" name="prodRetailPrice" class="marR5 alignR validation[number]"  title="소비자가격" placeholder="0" /> 원
		          </td>
 					<th scope="row">적립포인트</th>
		           <td>
		           	 <input type="text" id="prodPtInScore" name="prodPtInScore" class="marR5 alignR validation[number]" title="적립포인트" placeholder="0" /> P
		           </td>
		        </tr>
		        <tr class="tpP">
		          <th scope="row">매입가격</th>
		          <td>
		            <input type="text" id="prodPurchasePrice" name="prodPurchasePrice" class="marR5 alignR validation[number]" title="매입가격" placeholder="0" /> 원
		          </td>
		          <th scope="row">적립금</th>
		          <td>
		            <input type="text" id="prodResvFund" name="prodResvFund" class="marR5 alignR validation[number]" title="적립금" placeholder="0" /> 원
		          </td>
		        </tr>
		        <tr  class="tpP">
		           <th scope="row">공급가격</th>
		          <td colspan="3">
		            <input type="text" id="prodSupplyPrice" name="prodSupplyPrice" class="marR5 alignR validation[number]" title="공급가격" placeholder="0" /> 원
		          </td>
		        </tr>
		         <tr class="wQty">
		          <th scope="row">신규입고</th>
		          <td colspan="3">
		            <input type="text" name="prodWearingQty" class="marR5 alignR validation[number,required]" title="신규입고" placeholder="0" /> 개
		          </td>
		        </tr>
		        <tr>
		        <th scope="row">판매기간</th>
		          <td colspan="3">
						<div id='prodFormDt' class="fl"></div>
						<div class="fl" style="line-height:28px;">&nbsp;~&nbsp;</div>
						<div id='prodToDt' class="fl"></div>
		           		<div class="fl" style="line-height:28px;"><input type="checkbox" id="prodPmntYn" name="prodPmntYn" class="marL30" value="Y"  /><label for="prodPmntYn" class="marL5">상시제품</label></div>
		          </td>
		         </tr>
		      </tbody>
		    </table>
		  </div>
		  <!-- // table_type2 -->
		  <h3>상품 상세정보 등록</h3>
		  <div class="table_type2">
		    <table>
		      <caption>상세설명 (PC WEB), 상세설명 (Mobile WEB), 성분 (PC WEB), 성분 (Mobile WEB)으로 구성된 상품 상세정보 등록에 대한 작성 테이블 입니다.</caption>
		      <colgroup>
		        <col style="width:*">
		      </colgroup>
		      <tbody  id="prodRelated"></tbody>
		    </table>
		  </div>
		  <!-- // table_type2 -->
		  <h3>전자상거래에 관련 상품정보 제공에 관한 고시사항</h3>
		  <div class="table_type2">
		    <table>
		      <caption>식품의 유형, 생산자 및 소재지(수입자), 제조연월/유통기한 또는 품질유지기한, 용량/중량/수량, 원재료명 및 함량, 영양성분, 유전자 재조합 식품, 표시광고 심의여부, 수입식품 여부, 소비자상담 관련 전화번호로 구성된 전자상거래에 관련 상품정보 제공에 관한 고시사항에 대한 작성 테이블 입니다.</caption>
		      <colgroup>
		        <col style="width:175px;">
		        <col style="width:*">
		        <col style="width:140px;">
		      </colgroup>
		      <tbody  id="prodNotif"></tbody>
		    </table>
		  </div>
		</form>
	  </div>
		  <!-- // table_type2 -->
		  <div class="btn_area">
		    <div class="center">
		     	 <a class="btn_blue_line2" href="/mng/amM2/amM201/amM201.do" >목록</a><a class="btn_blue_line2" href="javascript:;" onclick="$.submit();">등록</a>
		    </div>
		  </div>
</body>
