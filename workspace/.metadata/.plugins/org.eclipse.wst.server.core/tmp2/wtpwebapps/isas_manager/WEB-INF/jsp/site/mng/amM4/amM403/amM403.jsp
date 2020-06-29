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
  <!-- 마케팅관리 : SMS관리 -->

<script type="text/javaScript" defer="defer">

<!--
/*----------------------------------------------------------------------------------------------
 * 화면 load시 실행 함수 (onload)
 *----------------------------------------------------------------------------------------------*/
function init(){
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
    ,{ text: '구분', datafield: 'msgDivRcNm', cellclassname: cellclass, width: '10%', cellsalign: 'center', align: 'center'}
    ,{ text: '제목(상황)', datafield: 'msgRoleNm', cellclassname: cellclass, width: '20%', cellsalign: 'left', align: 'center'}
    ,{ text: '문자', datafield: 'smsCont', cellclassname: cellclass, width: '66%', cellsalign: 'left', align: 'center'}

    ,{ text: '메시지롤코드', datafield: 'msgRoleCd', hidden: true}
    ,{ text: '메시지구분', datafield: 'msgDivRc', hidden: true}
  ];

  $.datafields = [
       { name: 'no', type: 'string'}
    ,{ name: 'msgDivRcNm', type: 'string'}
    ,{ name: 'msgRoleNm', type: 'string'}
    ,{ name: 'smsCont', type: 'string'}
    ,{ name: 'msgRoleCd', type: 'string'}
    ,{ name: 'msgDivRc', type: 'string'}
  ];

  fnGridOption('jqxgrid',{
         height: 285
        ,altrows: true
        ,columns: $.columns
    });




}

/*----------------------------------------------------------------------------------------------
 * grid search
 *----------------------------------------------------------------------------------------------*/
function fnSearch(){

  var dataAdapter = new $.jqx.dataAdapter({
    datatype: "json",
        datafields: $.datafields,
        url: "amM403.action",
       data: {msgDivRc: $("#msgDivRc").val()}
  });
  $("#jqxgrid").jqxGrid({source: dataAdapter});
  fnResetGridEditData('jqxgrid');
  return false;
}


function fnFancyboxCloseHandler(){
  $('a.fancybox-item.fancybox-close').click()
}

/*----------------------------------------------------------------------------------------------
 * 페이지 이벤트 함수 모음
 *----------------------------------------------------------------------------------------------*/
function fnEvent(){

	$("#msgDivRc").on('change', fnSearch);//추가


  $("#btn_Search").on('click', fnSearch);//추가


  // 셀 더블클릭
  $("#jqxgrid").on("celldoubleclick", function (event){
      var args = event.args;
      var rowBoundIndex = args.rowindex;
      if(args.column.columntype != 'button'){
      var msgRoleCd = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "msgRoleCd");
      var msgDivRc = $('#jqxgrid').jqxGrid('getcellvalue', rowBoundIndex, "msgDivRc");

	      setTimeout(function(){
	    	$.fancybox.open({
				href: "amM403U.action?msgRoleCd="+msgRoleCd+"&msgDivRc="+msgDivRc,
				type: "iframe",
			    maxWidth	: 700,
			    width		: 700,
			    autoSize	: true
			});
	      },200);
      }
  });

  $("#msgRollMgtBtn").bind("click", function(e){
    $("#msgRollMgtBtn").attr("href","/mng/popup/msgRollMgtPop.do?msgRoleTpAsm=S");
  });

  $("#smsSend").bind("click", function(e){

    var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
    if(rowindex > -1){
      var msgDivRc = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "msgDivRc");
      if(msgDivRc == "C"){

      var msgRoleCd = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "msgRoleCd");
      $("#smsSend").attr("href","/mng/popup/smsSendPop.do?msgRoleCd="+msgRoleCd+"&msgDivRc="+msgDivRc);
      }else{
        alert("수동 형식만 SMS 발송이 가능 합니다!");
        return false;

      }

    }else{
      alert("발송할 문자를 선택해 주세요!");
      return false;
    }
  });

  $("#mmsSend").bind("click", function(e){

	    var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
	    if(rowindex > -1){
	      var msgDivRc = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "msgDivRc");
	      if(msgDivRc == "C"){
	      var msgRoleCd = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "msgRoleCd");
	      $("#mmsSend").attr("href","/mng/popup/mmsSendPop.do?msgRoleCd="+msgRoleCd+"&msgDivRc="+msgDivRc);
	      }else{
	        alert("수동 형식만 MMS 발송이 가능 합니다!");
	        return false;
	      }
	    }else{
	      alert("발송할 문자를 선택해 주세요!");
	      return false;
	    }
	  });

  $("#msgModify").bind("click", function(e){
	  var rowindex = $('#jqxgrid').jqxGrid('getselectedrowindex');
	    if(rowindex > -1){
	      var msgDivRc = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "msgDivRc");
	      var msgRoleCd = $('#jqxgrid').jqxGrid('getcellvalue', rowindex, "msgRoleCd");

	      $("#msgModify").attr("href","amM403U.action?msgRoleCd="+msgRoleCd+"&msgDivRc="+msgDivRc);
	    }else{
	      alert("수정할 문자를 선택해 주세요!");
	      return false;
	    }
  });

  $("#msgRollMgtBtn").fancybox({
    maxWidth	: 700,
    width		: 700,
    autoSize	: true
  });

  $("#smsSend").fancybox({
    maxWidth	: 700,
    width		: 700,
    autoSize	: true
  });

  $("#mmsSend").fancybox({
    maxWidth	: 700,
    width		: 700,
    autoSize	: true
  });

  $("#msgModify").fancybox({
	    maxWidth	: 700,
	    width		: 700,
	    autoSize	: true
	  });

}
-->
</script>
</head>
<body>
 <div class="pageContScroll_st2">
	<div class="top_box">
		<div class="table_type">
			<table>
				<caption>신규발행여부로 구성된 마케팅관리 하위의 쿠폰관리에 대한 검색 테이블입니다.</caption>
				<colgroup>
					<col style="width: 15%;" />
					<col style="width: *;" />
				</colgroup>
				<tbody>
					<tr>
						<th scope="row">구분</th>
						<td>
							<select id="msgDivRc" name="msgDivRc" style="width: 174px;">
									<option value="">전체</option>
									<option value="R">시스템</option>
									<option  value="C"  selected="selected">수동</option>
							</select>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!-- // table_type -->
	</div>
	<!-- // top_box -->
  <div class="align_area">
		<div class="left">
			<a class="btn_type2 btn_icon5" id="btnExcel" style="margin-left:0px;"  href="javascript:;" onclick="grideExportExcel('jqxgrid','SMS관리목록');">엑셀다운로드</a>
		</div>
    <div class="right">
      <a id="smsSend" data-fancybox-type="iframe" class="btn_type2" href="javascript:;">SMS발송</a>
      <a id="mmsSend" data-fancybox-type="iframe" class="btn_type2" href="javascript:;">MMS발송</a>
      <a id="msgRollMgtBtn" data-fancybox-type="iframe" class="btn_type2" href="javascript:;">문자템플릿관리</a>
      <a id="msgModify" data-fancybox-type="iframe" class="btn_type2" href="#">수정</a>
    </div>
  </div>
  <!-- // align_area -->
  <div class="grid_type1">
    <div id="jqxgrid" ></div>
  </div>
</div>
</body>
