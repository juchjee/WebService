<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<c:import url="/WEB-INF/jsp/general/meta.jsp" />
	<title><spring:message code="eGov.title" /></title>
	<c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
	<c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />
	<script type="text/javascript">

		var str = true;

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
			     { text: '번호', datafield: 'no', columntype: 'number', width: '8%', cellsalign: 'right', align: 'center'
			    	,cellsrenderer: function (row, column, value) {
			            return "<div style='margin:13px 5px 0px 0;text-align:right;'>" + (value + 1) + "</div>";
			        }
			     }
				,{ text: '메시지롤명', datafield: 'msgRoleNm', cellclassname: cellclass, width: '92%',  cellsalign: 'left', align: 'center'}
				,{ text: '메시지노출', datafield: 'msgRoleYn', hidden: true}
				,{ text: '메시지롤타입', datafield: 'msgRoleTpAsm', hidden: true}
				,{ text: '메시지롤코드', datafield: 'msgRoleCd', hidden: true}
				,{ text: '메시지상태', datafield: 'msgRoleSt', hidden: true}
			];

			$.datafields = [
			     { name: 'no', type: 'string'}
				,{ name: 'msgRoleNm', type: 'string'}
				,{ name: 'msgRoleYn', type: 'string'}
				,{ name: 'msgRoleTpAsm', type: 'string'}
				,{ name: 'msgRoleCd', type: 'string'}
				,{ name: 'msgRoleSt', type: 'string'}
			];

			var appearance = new Object();
	     	   appearance.editable= true;
	     	   appearance.selectionmode = "singlecell";
	     	   appearance.editmode = 'selectedcell';
	     	   appearance.height = 279;
	     	   appearance.sortable = false;
	    	   appearance.altrows = true;
	    	   appearance.pageable = false;
	    	   appearance.columns = $.columns;

				fnGridOption('jqxgrid',appearance);

		}

		function fnSearch(){
			var url = "/mng/popup/msgRollMgtPopA.do?msgRoleTpAsm=${param.msgRoleTpAsm}";
			var source =
            {
				datatype: "json",
	    		datafields: $.datafields,
                id: 'id',
                addrow: function (rowid, rowdata, position, commit) {
                    commit(true);
                    //현재 생성된 row로 이동
               	     $("#jqxgrid").jqxGrid('ensurerowvisible', rowid);
                },
                deleterow: function (rowid, commit) {
    		        commit(true);
    		    },
                url: url
            };
			// 그리드 셋팅
        	var dataAdapter = new $.jqx.dataAdapter(source);
        	$("#jqxgrid").jqxGrid({source: dataAdapter});
		}

		// 이벤트
		function fnEvent(){

			$("#jqxgrid").on("bindingcomplete", function (event) {
				var datainformation = $(this).jqxGrid('getdatainformation');
				var rowscount = datainformation.rowscount;
				if(rowscount >= "5"){
					var size = rowscount-4;
					var nowHeight = $(".noBg").css("height").replace(/\px/gi,'');

					$("#jqxgrid").jqxGrid('height', 279+(size*40));

					$(".noBg").css("height", (parseInt(nowHeight)+(size*40))+"px");
					parent.$.fancybox.update();
				}
			});

			/** 그리드 셀 추가 이벤트 **/
			$("#btnAddNew").click(function(){
					$("#jqxgrid").jqxGrid('addrow', null, {msgRoleTpAsm:'${param.msgRoleTpAsm}',msgRoleYn:'Y'});

			});


			/** 등록 및 수정 처리 로직 **/
			$("#saveBtn").click(function(){
				var fnIAddSuccess =  function(data, dataType){
					var data = data.replace(/\s/gi,'');
					var returnData = "";
					if(data == "ng"){
						alert("저장에 실패하였습니다.");
						return false;
					}else if(data == "ok"){
						alert("정상적으로 저장되었습니다.");
						fnResetGridEditData('jqxgrid');
						fnSearch();
						parent.fnSearch();
					}
				};
				fnSaveConfirm('msgRollSave.action', 'jqxgrid' ,fnIAddSuccess);
			});

			/** 삭제 처리 로직 **/
			$("#btnDel").bind("click",function(event){
				fnDeleteConfirm("msgRollDelete.action","jqxgrid","msgRoleCd", function(){
					alert("정상적으로 삭제되었습니다.");
					fnSearch();
					parent.fnSearch();
				});
			});
		}




	</script>
</head>

<body class="noBg" style="height:472px;">
	<div class="popup_wrap">
		<h2>메시지 롤 관리</h2>
		<div class="pageContScroll_st4">
		<div class="top_box">
			<div class="text_type">
				<p>키워드 등록의 제한은 없습니다.</p>
			</div>
			<!-- // text_type -->
		</div>
		<!-- // top_box -->
		<div class="align_area">
			<div class="right popbt">
				<a id="btnAddNew" class="srchBtn btn_type1 " href="#">추가</a>
				<a id="btnDel" class="srchBtn btn_type1 " href="#">삭제</a>
				<a id="saveBtn"  class="srchBtn btn_type1" href="#">저장</a>
			</div>
		</div>
		<!-- // align_area -->
		<div class="grid_type1">
			<div id="jqxgrid" ></div>
		</div>
		</div>
		<div class="btn_area">
			<div class="center">
				<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
			</div>
		</div>
		<!-- // btn_area -->
	</div>
	<!-- // popup_wrap -->
</body>
</html>
