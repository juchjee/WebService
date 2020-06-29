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
	<!--
		function init(){
			fnSearch();
			fnEvent();

			 $("#colorPicker").on('colorchange', function (event) {
                 $("#dropDownButton").jqxDropDownButton('setContent', getTextElementByColor(event.args.color));
             });
			  $("#colorPicker").jqxColorPicker({ color: "FFFFFF", colorMode: 'hue', width: 220, height: 220});
              $("#dropDownButton").jqxDropDownButton({ width: 85, height: 26});
              $("#dropDownButton").jqxDropDownButton('setContent', getTextElementByColor(new $.jqx.color({ hex: "FFFFFF" })));
		}



		/*----------------------------------------------------------------------------------------------
		 * 아이콘 검색 함수
		 *----------------------------------------------------------------------------------------------*/
		function fnSearch(){
			var url = "/mng/amM2/amM202/amM202IconA.action";
			var source =
            {
				datatype: "json",
	    		datafields: [
                    { name: 'prodIconNm' },
                    { name: 'prodIconAttr' },
                    { name: 'prodIconCd' }
                ],
                id: 'id',
                url: url
            };
			//리스트 박스 셋팅 출력
            var dataAdapter = new $.jqx.dataAdapter(source);
			$("#listbox").jqxListBox({ source: dataAdapter, displayMember: "prodIconAttr", valueMember: "prodIconCd",
				renderer: function (index, label, value) {
                		var labelArr = label.split("_");
                    var labels = "<div class=\"product_icon\"><label style=\"background:#"+labelArr[1]+"\">"+labelArr[0]+"</label></div>";
                    return labels;
                },

				checkboxes:false,itemHeight: 24, width:358 , height: 150});
		}

		/*----------------------------------------------------------------------------------------------
		 * 페이지 이벤트 함수 모음
		 *----------------------------------------------------------------------------------------------*/

		function fnEvent(){
			$('#listbox').on('select', function (event) {
			    var args = event.args;
			    if (args) {
			        var item = args.item;
			        var label = item.label;

            		var labelArr = label.split("_");
    				$("#iconName").val(labelArr[0]);
    				$("#colorPicker").val(labelArr[1]);

    				var item = $("#listbox").jqxListBox('getSelectedItem');

    				if(item.value == 'PPI00001' || item.value == 'PPI00002' ){
							$("#iconName").attr("disabled", true);
							$("#del").attr("onclick", "alert('신상품,베스트는 삭세 할 수 없습니다.');");
    				}else{
						$("#iconName").attr("disabled", false);
						$("#del").attr("onclick", "$.IconSave('del');");

    				}
			    }
			});



			getTextElementByColor = function (color) {
	            if (color == 'transparent' || color.hex == "") {
	                return $("<div style='text-shadow: none; position: relative; margin:2px 0 2px 0; line-height:22px;'>transparent</div>");
	            }
	            var element = $("<div style='text-shadow: none; position: relative; margin:2px 0 2px 0;  line-height:22px;'>#" + color.hex + "</div>");
	            var nThreshold = 105;
	            var bgDelta = (color.r * 0.299) + (color.g * 0.587) + (color.b * 0.114);
	            var foreColor = (255 - bgDelta < nThreshold) ? 'Black' : 'White';
	            element.css('color', foreColor);
	            element.css('background', "#" + color.hex);
	            element.addClass('jqx-rc-all');
	            return element;
	        }


			$.IconSave = function(type){

				if($("#iconName").val() == ""){
					alert("추가할 아이콘명을 입력해주세요!");
				    return false;
				}

				if($("#colorPicker").val() == "#FFFFFF"){
					alert("추가할 아이콘 색상을 선택해주세요!");
				    return false;
				}

				var prodIconColor = $("#colorPicker").val().replace(/\#/gi,'');

				var item = $("#listbox").jqxListBox('getSelectedItem');
				var ival = "";
				if(item != null){
					ival = item.value;
				}
					var params = {
							"prodIconNm" : $("#iconName").val(),
							"prodIconColor" : prodIconColor,
							"prodIconCd" : ival,
							"prodIconTrnTp" : type
						};

				fnAjax("iconSave.action", params, function(data, dataType){
						if(data){
							alert("정상적으로 아이콘이 저장 되었습니다.");
					    	fnSearch();
						}else{
							alert("아이콘 추가에 실패하였습니다.");
						}
					},"POST","text");

				$("#listbox").off('bindingComplete');
				$("#listbox").on('bindingComplete', function (event) {

					   var items = $("#listbox").jqxListBox('getItems');

						parent.$("#iconMpg > li").remove();
					   $.each(items, function (index) {
							var labelArr = this.label.split("_");
						   parent.$("#iconMpg").append("<li><input type=\"checkbox\" id=\""+this.value+"\" name=\"prodIcon\"  value=\""+this.value+"\" />"+
						   "<label style=\"background:#"+labelArr[1]+"\" for=\""+this.value+"\">"+labelArr[0]+"</label></li>");
				      });
					   parent.$("#iconMpg").append("<li class=\"marL30\"><a class=\"fancybox bis btn_type1\" data-fancybox-type=\"iframe\" href=\"amM202Icon.action\">아이콘추가</a></li>");
				});
			}


		}
	//-->
	</script>
</head>

<body class="noBg">
	<div class="popup_wrap">
		<h2>아이콘 조회</h2>
		<div class="top_box">
			<div class="text_type">
				<p><span class="colRed">본화면에서 아이콘명과 색상 입력 후 추가 가능합니다.</span><br />아이콘은 등록 후 선택하여 추가 등록 하십시오</p>
			</div>
			<!-- // text_type -->
		</div>
		<!-- // top_box -->
		<div class="align_area" style="margin:10px 0 10px 0; padding:0 0 0 0">
			<input type="text" id="iconName" name="iconName" style="width:70px;float: left;"  placeholder="아이콘 명" />
				 <div style=" float: left;margin-left:5px;" id="dropDownButton"><div id="colorPicker"></div>
	            </div><a class="btn_type1" style="float: left;margin-left:5px " href=javascript:; onclick="$.IconSave('ins');">추가</a>
	            <a id="mod" class="btn_type1" style="float: left;margin-left:5px " href=javascript:; onclick="$.IconSave('udp');">수정</a>
	            <a id="del" class="btn_type1" style="float: left;margin-left:5px " href=javascript:; onclick="$.IconSave('del');">삭제</a>
		</div>
		<!-- // align_area -->
		<div class="table_type2 overH175">
			<div id="listbox"></div>
		</div>
		<!-- // table_type2 -->
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