<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<script type="text/javascript">
	var contUrl = "${rootUri}${conUrl}amM1024";

	function init(){

		var obj = $(".gnb > ul >li > a")[3];
		$(obj).addClass("on");

		fnSearchInit();
		fnSearch();
		fnEvent();
	}

	var _columns = [
	                /*
		{ text: '선택', datafield: 'test1', columntype: 'checkbox', width: '10%', align: 'center'}
	                */
		 { text: '발생일', datafield: 'mbrPtAccDt' , cellclassname: cellclass, width: '15%', cellsalign: 'center', align: 'center'}
		,{ text: '발생포인트', datafield: 'mbrPtScore', cellclassname: cellclass, width: '15%', cellsalign: 'center', align: 'center'}
		,{ text: '발생내역', datafield: 'ptNm', cellclassname: cellclass, width: '55%', cellsalign: 'center', align: 'center'}
		,{ text: '상태', datafield: 'aState', cellclassname: cellclass, width: '15%', cellsalign: 'center', align: 'center'}
		/*
		,{ text: '관리', datafield: 'test4', cellclassname: cellclass, width: '13%', cellsalign: 'center', align: 'center',
			cellsrenderer: function (row) {
				return '<a class="btn_type1" href="#">삭제</a>';
            }
		}
		*/
	];

	var _datafields = [
   		{ name: 'test1', type: 'bool'}
   		,{ name: 'mbrPtAccDt', type: 'string'}
   		,{ name: 'mbrPtScore', type: 'string'}
   		,{ name: 'ptNm', type: 'string'}
   		,{ name: 'aState', type: 'string'}
   		,{ name: 'test4', type: 'image'}
   	];

	function fnSearchInit(){
		fnGridOption('jqxgrid',{
			height: 390
	       	,columns: _columns
	       	,selectionmode: 'singlerow'
	    });
	}

	function fnSearch(){
		var dataAdapter = new $.jqx.dataAdapter({
			datatype: "json",
	        datafields: _datafields,
	        url: contUrl + ".action",
	        data: {mbrId : '${mbrId}', mbrNm : '${mbrNm}'}
		});
		$("#jqxgrid").jqxGrid({source: dataAdapter});
		fnResetGridEditData('jqxgrid');

		fnAjax(	"amM1024Cnt.action",
				{mbrId : '${mbrId}', mbrNm : '${mbrNm}'},
				function(data, dataType){
					$("#inScore").html(data.inScore);
					$("#outScore").html(data.outScore);
					$("#miScore").html(data.miScore);
				},'POST','json');

		return false;
	}

	// 포인트 적립
	function fnSavePoint(){
		if($("#ptScore").val() == ""){
			alert("적립할 포인트를 입력 해 주세요.");
			return;
		}
		$.ajax({
	        url : "amM1024SavePoint.action",
	        type: "POST",
	        data : {
	        		mbrId : '${mbrId}'
	        	,	ptCd : $("#selectPtCd").val()
				,	mbrPtScore : $("#ptScore").val()
	        },
	        success:function(response, data, result)
	        {
				if( response.result == "success"){
					alert("등록되었습니다.");
					fnSearch();
				}else{
					alert("저장에 실패 하였습니다. 관리자에게 문의해 주세요.");
				}
	        },
	        error: function(jqXHR, textStatus, errorThrown)
	        {
	        	alert("통신에 실패 하였습니다. 관리자에게 문의해 주세요.");
	        }
	   	}); // ajax
	}

	function fnEvent(){

	}

	</script>

	<div class="member_detail_con">
		<h2>포인트내역</h2>
		<div class="member_detail_info">
			<ul>
				<li>
					<dl>
						<dt>회원이름</dt>
						<dd><span>${mbrNm} (${mbrId})</span></dd>
					</dl>
				</li>
				<li>
					<dl>
						<dt>총 발생포인트 : </dt>
						<dd>
							<span id="inScore"></span>
						</dd>
						<dt>총 차감포인트 : </dt>
						<dd>
							<span id="outScore"></span>
						</dd>
						<dt>총 잔여포인트 : </dt>
						<dd>
							<span id="miScore"></span>
						</dd>
					</dl>
				</li>
			</ul>
		</div>
		<!-- // -->
		<div class="top_box">
			<div class="text_type">
				<p>포인트 강제차감 시에는 “-100” 과 같이 입력하시기 바랍니다</p>
				<div>
					<div class="serach_type">
						<ul>
							<li>
								<select id="selectPtCd" style="width:208px;">
									<c:forEach items="${plicyList}" var="plicyList">
										<option value="${plicyList.ptCd}">${plicyList.ptNm}</option>
									</c:forEach>
								</select>
							</li>
							<li>
								<input type="text" class="alignC" id="ptScore" style="width:59px;" /> P
							</li>
							<li>
								<a class="btn_blue_line" href="javascript:fnSavePoint()">등록</a>
							</li>
						</ul>
					</div>
				</div>
			</div>
			<!-- // text_type -->
		</div>
		<!-- // top_box -->
		<!--
		<div class="align_area">
			<div class="right">
				<a class="btn_type2 btn_icon6" href="#">선택삭제</a>
			</div>
		</div>
 -->
		<!-- // align_area -->
		<div class="grid_type1" style="margin-top:30px;">
			<div id="jqxgrid"></div>
		</div>

	</div>
