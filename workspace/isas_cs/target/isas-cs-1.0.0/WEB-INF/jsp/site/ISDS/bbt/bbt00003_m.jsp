<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"%>
<head>
	<script type="text/javascript" src="${rootUri}common/js/lightbox.js"></script>

	<script type="text/javascript">
	<!--
		var ord;
		var ord_data;
		$(document).ready(function(){

			var org_ordData = "<ul><li><a id='REG_DT_LINK' class='active' onClick=\"javascript:searchProdAfterList('ORD', 'REG_DT');\">최신순</a></li><li><a id='LIKE_HIT_LINK' style='display:none;' href=\"#\" onClick=\"javascript:searchProdAfterList('ORD', 'LIKE_HIT');\">공감순</a></li><li><a id='PROD_GRADE_LINK' style='display:none;' href=\"#\" onClick=\"javascript:searchProdAfterList('ORD', 'PROD_GRADE');\">만족도순</a></li></ul>";
	    	$("#orderDiv").html(org_ordData);

			var org_typeData = "<ul><li><a id='ALL_LINK' class='active' onClick=\"javascript:searchProdAfterList('TYPE', 'ALL');\">전체 보기</a></li><li><a id='IMAGE_LINK' style='display:none;' onClick=\"javascript:searchProdAfterList('TYPE', 'IMAGE');\">포토후기 보기</a></li><li><a id='TEXT_LINK' style='display:none;' onClick=\"javascript:searchProdAfterList('TYPE', 'TEXT');\">텍스트 후기보기</a></li></ul>";
		    $("#typeDiv").html(org_typeData);
		    setter();
		});

		function setter() {
			$("#REG_DT_LINK").click(function() {
				$("#LIKE_HIT_LINK").css("display","");
		    	$("#PROD_GRADE_LINK").css("display","");
		    });
		    $("#LIKE_HIT_LINK").click(function() {
		    	$("#REG_DT_LINK").css("display","");
		    	$("#PROD_GRADE_LINK").css("display","");
		    });
		    $("#PROD_GRADE_LINK").click(function() {
			    $("#LIKE_HIT_LINK").css("display","");
		    	$("#REG_DT_LINK").css("display","");
		    });

		    $("#ALL_LINK").click(function() {
			    $("#IMAGE_LINK").css("display","");
		    	$("#TEXT_LINK").css("display","");
		    });

		    $("#IMAGE_LINK").click(function() {
		    	$("#TEXT_LINK").css("display","");
		    	$("#ALL_LINK").css("display","");
		    });
		    $("#TEXT_LINK").click(function() {
		    	$("#ALL_LINK").css("display","");
		    	$("#IMAGE_LINK").css("display","");
		    });
		}

		function init(){
			fnEvent(ord);
 			setTimeout(function(){
				$.prodAfterList(1);
			},100);
		}

		function searchProdAfterList(type, value) {
			if (type == 'ORD') {
				$("#searchOrder").val(value);

 				$("#REG_DT_LINK").css("background-color","#f1f1f1");
				$("#REG_DT_LINK").css("color","black");
				$("#LIKE_HIT_LINK").css("background-color","#f1f1f1");
				$("#LIKE_HIT_LINK").css("color","black");
				$("#PROD_GRADE_LINK").css("background-color","#f1f1f1");
				$("#PROD_GRADE_LINK").css("color","black");

				$("#"+value+"_LINK").css("background-color","#4CAF50");
				$("#"+value+"_LINK").css("color","white");

				if (value == 'REG_DT') {
			    	$("#orderDiv").empty();
					var data =	"<ul><li><a id='REG_DT_LINK' class='active' >최신순</a></li><li><a id='LIKE_HIT_LINK' style='display:none;' onClick=\"javascript:searchProdAfterList('ORD', 'LIKE_HIT');\">공감순</a></li><li><a id='PROD_GRADE_LINK' style='display:none;' onClick=\"javascript:searchProdAfterList('ORD', 'PROD_GRADE');\">만족도순</a></li></ul>";
			    	$("#orderDiv").append(data);
			    	setter();

					$("#LIKE_HIT_LINK").css("display","none");
					$("#PROD_GRAD_LINK").css("display","none");
				}

				if (value == 'PROD_GRADE') {
			    	$("#orderDiv").empty();
			    	var data =	"<ul><li><a id='PROD_GRADE_LINK' class='active' >만족도순</a></li><li><a id='REG_DT_LINK'  style='display:none;' onClick=\"javascript:searchProdAfterList('ORD', 'REG_DT');\">최신순</a></li><li><a id='LIKE_HIT_LINK'  style='display:none;' onClick=\"javascript:searchProdAfterList('ORD', 'LIKE_HIT');\">공감순</a></li></ul>";
			    	$("#orderDiv").append(data);
			    	setter();

					$("#REG_DT_LINK").css("display","none");
					$("#LIKE_HIT_LINK").css("display","none");
				}

				if (value == 'LIKE_HIT') {

			    	$("#orderDiv").empty();
			    	var data =	"<ul><li><a id='LIKE_HIT_LINK' class='active' >공감순</a></li><li><a id='PROD_GRADE_LINK' style='display:none;' onClick=\"javascript:searchProdAfterList('ORD', 'PROD_GRADE');\">만족도순</a></li><li><a id='REG_DT_LINK'  style='display:none;' onClick=\"javascript:searchProdAfterList('ORD', 'REG_DT');\">최신순</a></li></ul>";
			        $("#orderDiv").append(data);
			    	setter();

					$("#REG_DT_LINK").css("display","none");
					$("#PROD_GRAD_LINK").css("display","none");
				}

			}

			if (type == 'TYPE') {
				$("#searchType").val(value);
				$("#ALL_LINK").css("background-color","#f1f1f1");
				$("#ALL_LINK").css("color","black");
				$("#IMAGE_LINK").css("background-color","#f1f1f1");
				$("#IMAGE_LINK").css("color","black");
				$("#TEXT_LINK").css("background-color","#f1f1f1");
				$("#TEXT_LINK").css("color","black");

				$("#"+value+"_LINK").css("background-color","#4CAF50");
				$("#"+value+"_LINK").css("color","white");

				if (value == 'ALL') {
			    	$("#typeDiv").empty();
			    	var data =	"<ul><li><a id='ALL_LINK' class='active'>전체 보기</a></li><li><a id='IMAGE_LINK' style='display:none;' onClick=\"javascript:searchProdAfterList('TYPE', 'IMAGE');\">포토후기 보기</a></li><li><a id='TEXT_LINK' style='display:none;' onClick=\"javascript:searchProdAfterList('TYPE', 'TEXT');\">텍스트 후기보기</a></li></ul>";
			    	$("#typeDiv").append(data);
			    	setter();

					$("#IMAGE_LINK").css("display","none");
					$("#TEXT_LINK").css("display","none");
				}

				if (value == 'IMAGE') {
			    	$("#typeDiv").empty();

			    	var data =	"<ul><li><a id='IMAGE_LINK' class='active'>포토후기 보기</a></li><li><a id='TEXT_LINK' style='display:none;' onClick=\"javascript:searchProdAfterList('TYPE', 'TEXT');\">텍스트후기 보기</a></li><li><a id='ALL_LINK'  style='display:none;' onClick=\"javascript:searchProdAfterList('TYPE', 'ALL');\">전체보기</a></li></ul>";
			    	$("#typeDiv").append(data);
			    	setter();

					$("#TEXT_LINK").css("display","none");
					$("#ALL_LINK").css("display","none");
				}

				if (value == 'TEXT') {
					$("#typeDiv").empty();
			    	var data =	"<ul><li><a id='TEXT_LINK' class='active'>텍스트후기 보기</a></li><li><a id='ALL_LINK'  style='display:none;' onClick=\"javascript:searchProdAfterList('TYPE', 'ALL');\">전체보기</a></li><li><a id='IMAGE_LINK'  style='display:none;' onClick=\"javascript:searchProdAfterList('TYPE', 'IMAGE');\">포토후기 보기</a></li></ul>";
			        $("#typeDiv").append(data);
			    	setter();

					$("#ALL_LINK").css("display","none");
					$("#IMAGE_LINK").css("display","none");
				}
			}

			fnEvent();
 			setTimeout(function(){
				$.prodAfterList(1);
			},100);
		}

		function setLikeIt(key, id, able) {
			if (!able) {
				alert('공감은 로그인이 필요합니다.');
				return false;
			}
			$("#HitImg_"+key).focus();
			fnAjax("/ISDS/store/feelEmpathy.do", { "boardMstCd" : $("#boardMstCd").val(), "id" : id}, function(data, dataType){
				var elementid = 'HitCol_'+key;
				var myElementid = 'myHitCol_'+key;
				var el = document.getElementById(elementid);
				var myEl = document.getElementById(myElementid);
				var dataValue = data;
				el.innerHTML = dataValue.hitCount;
				myEl.innerHTML = dataValue.hitCount;
				$("#HitImg_"+key).attr("src", "/common/img/icon/"+dataValue.likeStatus);
				$("#myHitImg_"+key).attr("src", "/common/img/icon/"+dataValue.likeStatus);
			},'POST', 'json', true);
			$("#HitImg_"+key).focus();
		}

		function doPage(pageNum){
	   		$.prodAfterList(pageNum);
		}

		//상품후기
		function fnEvent(){
			$.prodAfterList = function(page){
				fnAjax("/ISDS/store/prodAfterList.action", {"page" : page, "type" : $("#searchType").val(), "ord" : $("#searchOrder").val() }, function(data, dataType){
					var lockImg  ="";
					var currentPageNum = data.currentPageNum;
					var totalPages = data.totalPages;
					var totalCount = data.totalCount;

//					if("${param.prodCd}" == 'PPD00001'){
//						$(".product_view04_cnt").text("");
//					}else{
//						$(".product_view04_cnt").text("("+totalCount+")");
//					}
					$(".product_view04_cnt").text("("+totalCount+")");
					$("#ment_now_page").text(currentPageNum);
					$("#ment_total_page").text(totalPages);

					var prodAfterList = data.prodAfterList;

					$("#ment_list").html("");
					var idx =  0;
					for (key in prodAfterList) {
						var prodAfter_list = "";

						prodAfter_list = "<tr class='item2' style='cursor:pointer;'>";
						prodAfter_list += "<input type='text' value='prodAfterList[key].regId'/>";
						prodAfter_list += "<td>"+prodAfterList[key].boardSeq+"</td>";
						prodAfter_list += "<td style='text-align: left;'>";
						prodAfter_list += "<span>";
						prodAfter_list += " <table style='border:none; padding-left: 0px; margin-bottom:0px; padding-bottom:0px;''>";
						prodAfter_list += "  <tr>";
						prodAfter_list += "   <td rowspan='2' style='border:none; width:80px;'>";
						prodAfter_list += "<img src='${rootUri}"+prodAfterList[key].basicImg+"' width='60' height='60'>";
						prodAfter_list += "</td>";
						prodAfter_list += "   <td style='text-align:left;'>"+fnChkWord(prodAfterList[key].boardTitle);
						if(prodAfterList[key].attchFilePath != ''){
	                    	prodAfter_list += " <img src='/common/img/icon/camera.jpg' style='width: 17px;'/>";
	                    }
						prodAfter_list += "&nbsp;&nbsp;<img src='/common/img/icon/line08.png'> &nbsp; <img src='/common/img/icon/"+prodAfterList[key].likeStatus+"' height='9' id='HitImg_"+key+"'><font size='2'>&nbsp;(<span id='HitCol_"+key+"'>"+prodAfterList[key].likeHit+"</span>)</font>";
						prodAfter_list +="</td>"
						prodAfter_list += "  </tr>";
						prodAfter_list += "  <tr>";
						prodAfter_list += "   <td style='text-align:left; border:none;'>"+prodAfterList[key].prodNm+"</td>"
						prodAfter_list += "  </tr>";
						prodAfter_list += " </table>";
						prodAfter_list += "</span>";
						prodAfter_list +="</td>";
						prodAfter_list += "<td><div class='star_wrap'><span class=\"star"+prodAfterList[key].prodGrade+"\"><em>만족도</em>";
						prodAfter_list += "</span>";
						prodAfter_list += "</div></td>";
	                    prodAfter_list += "<td>"+ prodAfterList[key].regId.substring(0,4) +"***</td><td>"+prodAfterList[key].regDt+"</td></tr>";

	                    prodAfter_list += "<tr id='contAfter"+idx+"' class='hide 2' >";
	                    prodAfter_list += "<td colspan='6' style='text-align: left;'>";
	                    prodAfter_list += "<div style='border:none; padding-left: 0px; margin-bottom:0px; padding-bottom:0px;'>";
	 					if(prodAfterList[key].attchFilePath != ''){
							if("${iConstant.isMobile(pageContext.request)}" == 'false'){
		                    	prodAfter_list += "<span style='background:none'><img src='${rootUri}" + prodAfterList[key].attchFilePath + "' style='max-width: 500px;'></span>";
							}
		 					if("${iConstant.isMobile(pageContext.request)}" == 'true'){
	                    		prodAfter_list += "<span style='background:none'><img src='${rootUri}" + prodAfterList[key].attchFilePath + "' style='max-width: 250px;'></span>";
		 					}
	                    }
	 					prodAfter_list += "<span style='background:none' >"+fnChkWord(decodeTag(prodAfterList[key].boardCont));
	                    if(prodAfterList[key].boardReply != undefined){
	 						prodAfter_list += "<br/><br/><br/>"+decodeTag(prodAfterList[key].boardReply.replace(/\r\n/gi,'<br/>'));
	                    } else {
	                    	prodAfter_list += "<br/><br/><br/>";
	                    }
	 					prodAfter_list += "</span>";
	 					prodAfter_list += "<br/><br/><br/>";
	 					prodAfter_list += "<div width='100%' align='center'><a class='btn10' href=\"javascript:;\" onClick=\"setLikeIt('"+key+"', '"+prodAfterList[key].boardSeq+"',"+prodAfterList[key].likeButton+");\"><img src='/common/img/icon/"+prodAfterList[key].likeStatus+"' height='15'  id='myHitImg_"+key+"'>&nbsp;&nbsp;&nbsp;&nbsp;공감&nbsp;&nbsp;<span id='myHitCol_"+key+"' style='background-image: url();text-align:center;'>"+prodAfterList[key].likeHit+"</span></a></div>";
						prodAfter_list += "</div></td></tr>";

	                    $("#ment_list").html($("#ment_list").html()+prodAfter_list);
						idx++;
					}

					$('.paging').html("");
					$('.paging').append('<c:out value="' + data.pageTag + '" escapeXml="false" />');

					$(".item2").unbind("click");
					$(".item2").bind("click",function(){
						if($("#contAfter"+$(".item2").index(this)+"").prop("class") == "hide 2"){
							$(".show.2").prop("class","hide 2");
							$("#contAfter"+$(".item2").index(this)+"").prop("class","show 2");
						}else{
							$("#contAfter"+$(".item2").index(this)+"").prop("class","hide 2");
						}
					});
				},'POST','json');
			}
		}
	//-->
	</script>
</head>
<body>
<style>
@media screen and (max-width: 640px) {
	.bostyle01 .tbl_res1 col:nth-child(2), .bostyle01 .tbl_res1 th:nth-child(2), .bostyle01 .tbl_res1 td:nth-child(2) { width:70% !important; white-space:inherit; }
	/* .bostyle01 .tbl_res1 td:nth-child(2) span  { display:block; width:100%; text-overflow:ellipsis; white-space:nowrap; overflow:hidden; } */
	.bostyle01 .tbl_res1 col:nth-child(3), .bostyle01 .tbl_res1 th:nth-child(3), .bostyle01 .tbl_res1 td:nth-child(3) { width:30% !important; white-space:inherit; }
	.bostyle01 .tbl_res1 col:nth-child(6), .bostyle01 .tbl_res1 th:nth-child(6), .bostyle01 .tbl_res1 td:nth-child(6) { display:none; white-space:inherit; }
}
.likeThisOn {
	width:27px;
	height:25px;
	margin: 0px 0 0px;
	background:url(/common/img/icon/heart_set.png) no-repeat;
	vertical-align:baseline;
	background-position:-29px 0;
}
#orderDiv  {
	position : relative;
	float : left;
}
#orderDiv ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    width: 100px;
    background-color: #f1f1f1;
}
#orderDiv ul li a {
    display: block;
    color: #000;
    padding: 8px 16px;
    text-decoration: none;
}
#orderDiv ul li a.active {
    background-color: #4CAF50;
    color: white;
}
#orderDiv  ul li a:hover:not(.active) {
    background-color: #555;
    color: white;
}
#typeDiv  {
	position : relative;
	float : left;
}
#typeDiv ul {
    list-style-type: none;
    margin: 0;
    padding: 0;
    width: 140px;
    background-color: #f1f1f1;
}
#typeDiv ul li a {
    display: block;
    color: #000;
    padding: 8px 16px;
    text-decoration: none;
}
#typeDiv ul li a.active {
    background-color: #4CAF50;
    color: white;
}
#typeDiv  ul li a:hover:not(.active) {
    background-color: #555;
    color: white;
}
</style>

<section class="sub">
		<div class="tit_bx">
			<a href="javascript:history.back();" class="btn_prev">이전 화면</a>
			<h2>칭찬합시다</h2>
		</div>
		<!--// tit_bx -->
		<div class="sch_area">
			<div class="select_guide">
				<select class="m_select select01" name="#" id="ct_select">
					<option value="#">전체</option>
					<option value="#">제목</option>
					<option value="#">내용</option>
				</select>
			</div>
			<div class="input_txt_bx">
				<input type="text" name="" id="" value="" class="" />
			</div>
			<div class="btnWrap">
				<a href="#" class="btn blue">검색</a>
			</div>
		</div>
		<!-- //sch_area -->
		<div class="content">
			<div class="board_area">
				<div class="box_tit">
					<p class="tit">전체<span>100</span>건</p>
					<div class="btnWrap">
						<a href="#none" class="btn gray">나의글보기</a>
						<a href="#none" class="btn blue">글쓰기</a>
					</div>
				</div>
				<div class="board mt10">
					<table>
						<caption>is 동서 칭찬합시다 목록</caption>
						<tbody>
							<tr>
								<td class="subject">
									<a href="#" class="tit">
										<p>비데 탈부착하는 방법에 대해 알려드립니다.</p>
										<ul>
											<li class="writer">홍길동</li>
											<li class="date">2017-05-31</li>
											<li class="hit">조회수 <i>1,000</i></li>
										</ul>
									</a>
								</td>
							</tr>
							<tr>
								<td class="subject">
									<a href="#" class="tit">
										<p>비데 탈부착하는 방법에 대해 알려드립니다.</p>
										<ul>
											<li class="writer">홍길동</li>
											<li class="date">2017-05-31</li>
											<li class="hit">조회수 <i>1,000</i></li>
										</ul>
									</a>
								</td>
							</tr>
							<tr>
								<td class="subject">
									<a href="#" class="tit">
										<p>비데 탈부착하는 방법에 대해 알려드립니다.</p>
										<ul>
											<li class="writer">홍길동</li>
											<li class="date">2017-05-31</li>
											<li class="hit">조회수 <i>1,000</i></li>
										</ul>
									</a>
								</td>
							</tr>
							<tr>
								<td class="subject">
									<a href="#" class="tit">
										<p>비데 탈부착하는 방법에 대해 알려드립니다.</p>
										<ul>
											<li class="writer">홍길동</li>
											<li class="date">2017-05-31</li>
											<li class="hit">조회수 <i>1,000</i></li>
										</ul>
									</a>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- //board -->
			</div>
			<!-- //board_area -->

		</div>
	</section>
	<!--// sub -->

</body>