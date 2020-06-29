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

<script type="text/javaScript" defer="defer">
<!--
var contUrl = "${rootUri}${conUrl}amM201";
/*----------------------------------------------------------------------------------------------
 * 화면 load시 실행 함수 (onload)
 *----------------------------------------------------------------------------------------------*/
function init(){
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
  //초기 데이터 셋팅
  fnDataSetting();
}

/*----------------------------------------------------------------------------------------------
 * 초기화 기본 데이터 셋팅
 *----------------------------------------------------------------------------------------------*/
function fnDataSetting(){
	  //--------------------------------------------------- 초기화 기본 데이터 Start --------------------------------------------------

		$("input").attr("readonly","readonly");
	  // datepicker 정의
	  dateTimeInput("prodFormDt", null,"${prod.prodFormDt}");
	  dateTimeInput("prodToDt", null,"${prod.prodToDt}");

	  $("#prodFormDt").jqxDateTimeInput({ disabled: true });
	  $("#prodToDt").jqxDateTimeInput({ disabled: true });

	  $("select[name=prodTypeGsp]").val("${prod.prodTypeGsp}").attr("selected", "selected"); //상품구성
	  $("input[name=prodDisPcYn]:radio[value='${prod.prodDisPcYn}']").attr("checked",true);  //PC Web 노출
	  $("input[name=prodDisMobileYn]:radio[value='${prod.prodDisMobileYn}']").attr("checked",true);  //모바일 웹노출
	  $("input[name=prodStatusCd]:radio[value='${prod.prodStatusCd}']").attr("checked",true);  //판매상태
	  $("input[name=prodBasicSizeBms]").attr("checked",true);  //기본이미지분류(대중소) - 전체 체크

	  $("select[name=prodTpCd]").val("${prod.prodTpCd}").attr("selected", "selected"); //상품종류


		//기본이미지 초기설정
	  <c:forEach items="${prodBasicImgMpgSize}" var="prodBasicImgMpgS">
		 $("input[name=prodBasicSizeBmsView]:checkbox[value='${prodBasicImgMpgS.prodBasicSizeBms}']").attr("checked",true); //현재 상세이미지분류(대중소)
		 <c:if test="${prodBasicImgMpgS.prodBasicSizeBms eq 'S'}">
		 	$(".sImg").html("<img src='${prodBasicImgMpgS.attchFilePath}' />");
		 </c:if>
	 </c:forEach>

	  <c:choose>
		  <c:when test="${prod.prodTypeGsp ne 'P'}">  //-----일반/셋트상품일때

			  $("input[name=prodPrice]").val("${prodFi.prodPrice}"); //판매정가
			  $("input[name=prodSalePrice]").val("${prodFi.prodSalePrice}"); //할인가
			  $("input[name=prodRetailPrice]").val("${prodFi.prodRetailPrice}"); //소비자가격
			  $("input[name=prodPurchasePrice]").val("${prodFi.prodPurchasePrice}"); //매입가격
			  $("input[name=prodSupplyPrice]").val("${prodFi.prodSupplyPrice}"); //공급가격
			  $("input[name=prodResvFund]").val("${prodFi.prodResvFund}"); //적립금
			  $("input[name=prodPtInScore]").val("${prodFi.prodPtInScore}"); //적립포인트
//	 		  $("#prodFormDt").val("${prodFi.prodFormDt}"); //판매시작일
//	 		  $("#prodToDt").val("${prodFi.prodToDt}"); //판매종료일
			  $("select[name=prodDeliPlicyCd]").val("${prodFi.prodDeliPlicyCd}").attr("selected", "selected"); //현재 배송정책상태
		  </c:when>
		  <c:otherwise>  //-----포인트상품일때
		     $(".tpP").hide();
		 	 $("#prodSetBtn").hide();
			 $("#categoryLyout").hide();
			 $(".prodPriceNm").text("포인트상품가");
			 $(".prodUit").text("포인트");
			 $("input[name=prodPrice]").val("${prodPt.prodPtOutScore}"); //포인트상품가
			 $("select[name=prodDeliPlicyCd]").val("${prodDeliPlicy.prodDeliPlicyCd}").attr("selected", "selected"); //현재 배송정책상태
		  </c:otherwise>
	  </c:choose>
	  $("#inventoryQty").text(setComma("${prodInventory.inventoryQty}")+" 개"); //총재고수량
	  $("#prodSusQty").text(setComma("${prodInventory.prodSusQty}")+" 개"); //판매수량
	  $("#prodProgressQty").text(setComma("${prodInventory.prodProgressQty}")+" 개"); //판매진행수



		  //--------------------------------------------------- 초기화 기본 데이터 End --------------------------------------------------
}

//-->
</script>
<style>
</style>
</head>

<body class="noBg">
	<div class="popup_wrap" style="background:#fff">
		<h2>${prodNm}</h2>
	 <div class="pageContScroll_st2">
	 	<div id="categoryLyout">
		  <h3>상품전시카테고리 정보</h3>

		  <!-- // top_box -->
		  <div class="group_choice_result" style="border-top:#a1b0c2 1px solid;">
		    <div class="add_field">
		      <div class="field_ul">
		        <ul id="categoryMpg">
		      		<c:forEach items="${prodCateMpgList}" var="prodCateMpg">
		        		<li>
		        			<div>${prodCateMpg.prodCategoryNm}</div>
		        		</li>
		        	</c:forEach>
		        </ul>
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
		              <c:choose>
		              	<c:when test="${prod.prodTypeGsp eq 'G'}">일반상품</c:when>
		              	<c:when test="${prod.prodTypeGsp eq 'S'}">세트상품</c:when>
		              	<c:when test="${prod.prodTypeGsp eq 'P'}">포인트상품</c:when>
		              </c:choose>

		            </div>
		            <!-- // add_field -->
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">상품번호</th>
		          <td>
		           	${prod.prodCd}
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">상품명</th>
		          <td>${prod.prodNm}</td>
		        </tr>
		        <tr>
		          <th scope="row">상품종류</th>
		          <td>
		      			<c:forEach items="${prodTpList}" var="prodTp">
		      			 <c:if test="${prodTp.prodTpCd eq prod.prodTpCd}">${prodTp.prodTpNm}</c:if>
		              	</c:forEach>
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">보조상품명</th>
		          <td>
		            <div class="add_field">
		              <div class="field_ul">
		                <ul id="secMpg">
		                	<c:forEach items="${secProdMpgList}" var="secMpg">
				        		<li>
				        			<div>${secMpg.secProdNm}</div>
				        		</li>
		        			</c:forEach>
		                </ul>
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
		              <div class="field_ul">
		                <ul id="keywordMpg">
		                	<c:forEach items="${keywordMpgList}" var="keywordMpg">
				        		<li>
				        			<div>${keywordMpg.prodKeywordNm}</div>
				        		</li>
		        			</c:forEach>
		                </ul>
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
		              <div class="field_ul">
		                <ul id="prodMpg">
		                	<c:forEach items="${prodMpgList}" var="prodMpg">
				        		<li>
				        			<div>${prodMpg.prodNm}</div>
				        		</li>
		        			</c:forEach>
		                </ul>
		              </div>
		              <!-- // field_ul -->
		            </div>
		            <!-- // add_field -->
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">간략설명</th>
		          <td>${prod.prodDesc}</td>
		        </tr>
		      </tbody>
		    </table>
		  </div>

		   <!-- // group_choice_result -->
		  <h3 class="fl">상품 추가정보 등록</h3>
		  <div class="table_type2">
		    <table>
		      <caption>추가 정보</caption>
		      <colgroup>
		        <col style="width:140px;">
		        <col style="width:*">
		      </colgroup>
		      <tbody  id="prodAddInfo">
		         <c:forEach items="${prodAddInfoList}" var="prodAddInfo">
		          <tr>
			          <th scope="row">${prodAddInfo.prodAddInfoNm} ${prodAddInfo.index}</th>
			          <td>
						${prodAddInfo.prodAddInfoVal}
						${prodAddInfo.prodAddSubText}
			          </td>
		       	  </tr>
		        </c:forEach>
		      </tbody>
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
		          	<c:choose>
		              	<c:when test="${prod.prodDisPcYn eq 'Y'}">노출</c:when>
		              	<c:when test="${prod.prodDisPcYn eq 'N'}">노출 안함</c:when>
		              </c:choose>
		          </td>
		          <th scope="row">모바일 웹노출</th>
		          <td>
		          	<c:choose>
		              	<c:when test="${prod.prodDisMobileYn eq 'Y'}">노출</c:when>
		              	<c:when test="${prod.prodDisMobileYn eq 'N'}">노출 안함</c:when>
		              </c:choose>
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">표시아이콘</th>
		          <td colspan="3" style="padding-left:5px;">
		            <div class="product_icon">
		              <div id="iconMpg">
		      			<c:forEach items="${prodIconList}" var="prodIcon">
							  <c:forEach items="${prodIconMpgList}" var="prodIconMpg">
							 	 <c:if test="${prodIconMpg.prodIconCd eq  prodIcon.prodIconCd}">
							 	 <label style="background:#${prodIcon.prodIconColor}" for="${prodIcon.prodIconCd }">${prodIcon.prodIconNm}</label>
							 	 </c:if>
							  </c:forEach>
		                 </c:forEach>
		              </div>
		            </div>
		            <!-- // product_icon -->
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">판매상태</th>
		          <td colspan="3">
			      	  <c:forEach items="${prodStatusList}" var="prodStatus">
			      		<c:if test="${prodStatus.prodStatusCd eq prod.prodStatusCd}">
			      		<b>${prodStatus.prodStatusNm}</b>
			      		</c:if>
			          </c:forEach>
		          </td>
		        </tr>
		        <tr>
		          <th scope="row">기본이미지</th>
		          <td colspan="3">
		          	<div id="prodBasicImgNameView">
		          		<div style="line-height:80px;">
		          		          <span class="sImg"></span>
		          				  <span><a class="attchDown" href="javascript:;" onclick="fnFileDownLoad('${prodBasicImg.attchFileCd}')">${prodBasicImg.attchFileNm}</a></span>
		          				  <input type="checkbox" id="imgL" name="prodBasicSizeBmsView" class="marL30"   value="B" disabled="disabled"/><label for="imgL" class="marL5">상세이미지</label>
						          <input type="checkbox" id="imgM" name="prodBasicSizeBmsView" class="marL30"  value="M" disabled="disabled"  /><label for="imgM" class="marL5">리스트이미지</label>
						          <input type="checkbox" id="imgS" name="prodBasicSizeBmsView" class="marL30"  value="S" disabled="disabled" /><label for="imgS" class="marL5">주문리스트이미지</label>
		          		</div>
		          	</div>
		          </td>
		        </tr>
		        <c:if test="${not empty prodDtlImg}">
		        <tr>
		          <th scope="row">상세이미지</th>
		          <td colspan="3">
		      		<c:forEach items="${prodDtlImg}" var="prodDtlImgMpg" varStatus="status">
		      			<div class="nowDtlImg">
			      			<div>
				          		<a class="attchDown" href="javascript:;" onclick="fnFileDownLoad('${prodDtlImgMpg.attchCd}')">${prodDtlImgMpg.attchFileNm}</a>
				          	</div>
				          	<div>
					          	<input type="checkbox" name="prodDtlImgView" class="marL30"   value="B" <c:if test="${prodDtlImgMpg.prodImgDisPcYn eq 'Y'}">checked="checked"</c:if> disabled="disabled"/><label  class="marL5">PC 노출</label>
								<input type="checkbox" name="prodDtlImgView" class="marL30"  value="M" <c:if test="${prodDtlImgMpg.prodImgDisMobileYn eq 'Y'}">checked="checked"</c:if> disabled="disabled"  /><label class="marL5">모바일 노출</label>
							</div>
						</div>
					</c:forEach>
		        </tr>
		        </c:if>

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
		            <input type="text"  name="prodPrice" class="marR5 alignR validation[number,required]" placeholder="0"   title="판매정가" /> <span class="prodUit">원</span>
		          </td>
		          <th scope="row">배송료</th>
		          <td>
		      			<c:forEach items="${prodDeliPlicyList}" var="prodDeliPlicy">
		      				<c:choose>
			      			  <c:when test="${prod.prodTypeGsp ne 'P'}">
			      			 	<c:if test="${prodDeliPlicy.prodDeliPlicyCd eq prodFi.prodDeliPlicyCd}">${prodDeliPlicy.prodDeliPlicyNm}</c:if>
			      			 </c:when>
			      			 <c:otherwise>
			      			 	<c:if test="${prodDeliPlicy.prodDeliPlicyCd eq prodPt.prodDeliPlicyCd}">${prodDeliPlicy.prodDeliPlicyNm}</c:if>
			      			 </c:otherwise>
			      			 </c:choose>
		              	</c:forEach>
		          </td>
		        </tr>
		        <tr class="tpP">
		        <th scope="row">할인가</th>
		          <td>
		            <input type="text" name="prodSalePrice" class="marR5 alignR validation[number]" placeholder="0" /> 원
		          </td>
		          <th scope="row">과세구분</th>
		          <td>
		          <c:choose>
		          	<c:when test="${prodFi.prodTaxTpTf eq 'T'}">과세</c:when>
		          	<c:when test="${prodFi.prodTaxTpTf eq 'F'}">면세</c:when>
		          </c:choose>
		          </td>
		        </tr>
		        <tr class="tpP">
		         <th scope="row">소비자가격</th>
		          <td>
		            <input type="text" id="prodRetailPrice" name="prodRetailPrice" class="marR5 alignR validation[number]" placeholder="0" /> 원
		          </td>
 					<th scope="row">적립포인트</th>
		           <td>
		           	 <input type="text" id="prodPtInScore" name="prodPtInScore" class="marR5 alignR validation[number]" placeholder="0" /> 원
		           </td>
		        </tr>
		        <tr class="tpP">
		          <th scope="row">매입가격</th>
		          <td>
		            <input type="text" id="prodPurchasePrice" name="prodPurchasePrice" class="marR5 alignR validation[number]" placeholder="0" /> 원
		          </td>
		          <th scope="row">적립금</th>
		          <td>
		            <input type="text" id="prodResvFund" name="prodResvFund" class="marR5 alignR validation[number]" placeholder="0" /> 원
		          </td>
		        </tr>
		        <tr  class="tpP">
		           <th scope="row">공급가격</th>
		          <td colspan="3">
		            <input type="text" id="prodSupplyPrice" name="prodSupplyPrice" class="marR5 alignR validation[number]" placeholder="0" /> 원
		          </td>
		        </tr>
		         <tr>
		          <th scope="row">총재고수량</th>
		          <td id="inventoryQty" colspan="3"></td>
		        </tr>
		        <tr>
		          <th scope="row">판매수량</th>
		          <td id="prodSusQty"></td>
		          <th scope="row">판매진행수</th>
		          <td id="prodProgressQty"></td>
		        </tr>
		        <tr>
		        <th scope="row">판매기간</th>
		          <td colspan="3">
						<div id='prodFormDt'  class="fl"  title="판매시작일"></div>
						<div class="fl" style="line-height:28px;">&nbsp;~&nbsp;</div>
						<div id='prodToDt' class="fl"  title="판매종료일"></div>
		           		<div class="fl" style="line-height:28px;">
		           			<c:choose>
		           			  <c:when test="${prod.prodPmntYn eq 'Y'}">
								 <input type="checkbox" id="prodPmntYn" name="prodPmntYn" class="marL30" value="Y"  checked="checked" disabled="disabled" />
							 </c:when>
							 <c:otherwise>
								 <input type="checkbox" id="prodPmntYn" name="prodPmntYn" class="marL30" value="Y"  disabled="disabled" />
							 </c:otherwise>
						</c:choose>

		           		<label for="prodPmntYn" class="marL5">상시제품</label></div>
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

		      <tbody  id="prodRelated">
		      	<c:forEach items="${prodRelatedList}" var="prodRelated">
		          <tr>
			          <th scope="row" style="width:127px; min-width:127px;">${prodRelated.prodRelatedNm}
			          </th>
			          <td>
				          <div class="editScroll" >
				            <textarea name="prodRelatedVal" id="${prodRelated.prodRelatedCd}_Text" style="display:none;" ><c:if test="${not empty prodRelated.prodRelatedVal}">${prodRelated.prodRelatedVal}</c:if></textarea>
					            <c:choose>
				            		<c:when test="${empty prodRelated.prodRelatedVal}">
				            		 <div id="${prodRelated.prodRelatedCd}" class="edit_area">미리보기 -  내용이 없습니다.</div>
				            		</c:when>
				            		<c:otherwise>
				            		<div id="${prodRelated.prodRelatedCd}" class="edit_area"></div>
				            		<script type="text/javascript">
		            					$("#${prodRelated.prodRelatedCd}").html(decodeTag($("#${prodRelated.prodRelatedCd}_Text").html()));
				            		</script>
				            		</c:otherwise>
			            		</c:choose>
				            </div>
			          </td>
			        </tr>
		        </c:forEach>
		      </tbody>
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
		      </colgroup>
		      <tbody  id="prodNotif">
		      	<c:forEach items="${prodNotifList}" var="prodNotif">
		          <tr>
			          <th scope="row">${prodNotif.prodNotifNm}</th><td>
			             ${prodNotif.prodNotifVal}
			          </td>
			        </tr>
		        </c:forEach>
		      </tbody>
		    </table>
		  </div>
	  </div>
		  <!-- // table_type2 -->
		  <div class="btn_area" style="margin-top:20px;">
		    <div class="center">
				<a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
		    </div>
		  </div>
		  </div>
</body>
</html>