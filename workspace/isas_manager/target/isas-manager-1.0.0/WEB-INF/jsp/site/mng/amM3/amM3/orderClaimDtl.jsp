<!DOCTYPE html>
<html lang="ko">
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>
<head>
  <c:import url="/WEB-INF/jsp/general/meta.jsp" />
  <title><spring:message code="eGov.title" /></title>
  <c:import url="/WEB-INF/jsp/general/lib_simple.jsp" />
  <c:import url="/WEB-INF/jsp/general/lib_jqx.jsp" />
  <script type="text/javascript">
  /*----------------------------------------------------------------------------------------------
   * 화면 load시 실행 함수 (onload)
   *----------------------------------------------------------------------------------------------*/
  function init(){
    fnEvent();
    fnDataSetting();

  }

  /*----------------------------------------------------------------------------------------------
   * 이벤트 Setting
   *----------------------------------------------------------------------------------------------*/
   function fnEvent(){

      $("#claimBasicInfoSaveBtn").click(function(){
        var paramData = new Object();
        var postData = new Array();
        var refundInstCdStr = $("select[name=refundInstCd]").val();
        var refundAccountNoStr = $("input[name=refundAccountNo]").val();
        var refundAccountHdStr = $("input[name=refundAccountHd]").val();

        var returnZipcodeStr = $("input[name=returnZipcode]").val();
        var returnAddrStr = $("input[name=returnAddr]").val();
        var returnAddrDtlStr = $("input[name=returnAddrDtl]").val();

        var claimReasonStr = $("textarea[name=claimReason]").val();


        var postDataJson = JSON.stringify(postData);
        if(confirm("기본 정보를 저장 하시겠습니까?")){
          fnAjax("claimBasicInfoSave.action"
            ,{
              orderNo : "${orderInfo.orderNo}"
             ,refundInstCd : refundInstCdStr
             ,refundAccountNo: refundAccountNoStr
             ,refundAccountHd: refundAccountHdStr
             ,returnZipcode: returnZipcodeStr
             ,returnAddr: returnAddrStr
             ,returnAddrDtl: returnAddrDtlStr
            ,claimReason: claimReasonStr
             }, function(data, dataType){
            var data = data.replace(/\s/gi,'');
            alert(data);
            location.reload();
          },'POST','text');
        }
      });



      $("#addrCopy").click(function(){
        if(confirm("수령지주소를 반송주소로 복사하시겠습니까?")){
          $('input[name=returnZipcode]').val("${orderInfo.receiptZipcode}");
                $('input[name=returnAddr]').val("${orderInfo.receiptAddr}");
                $('input[name=returnAddrDtl]').val("${orderInfo.receiptAddrDtl}");
        }
      });
      $("#chkReceiptYn").click(function(){
        if($("#chkReceiptYn").is(":checked")){
          $.chkReceipFlag("on");
        }else{
          $.chkReceipFlag("off");
        }
      });

      $.chkReceipFlag = function(flag){

        if(flag == "on"){
          $(".chkReceiptArea").show();
          $(".chkReceiptArea input").prop("disabled",false);
          $("input[name=chkReceipt]").eq(0).change();
        }else if(flag == "off"){
          $(".chkReceiptArea").hide();
          $(".chkReceiptArea input").prop("disabled",true);
        }
      }

      $.claimTpCdChangeFlag = function(flag){
        if(flag == "on"){
          $(".returnAddress").show();
          $(".returnAddress input").prop("disabled",false);
          $(".returnAddress select").prop("disabled",false);
        }else if(flag == "off"){
          $(".returnAddress").hide();
          $(".returnAddress input").prop("disabled",true);
          $(".returnAddress select").prop("disabled",true);
        }
      }

      $("input[name=claimTpCdChange]").bind("change",function(){

        var changeVal = $(this).val();
        if(changeVal == "OPS00005"){
          $.claimTpCdChangeFlag('on');
        }else{
          $.claimTpCdChangeFlag('off');
        }
      });


     /** 주소 찾기 **/
      $("#addrSearch").click(function(){
        var thisId = $(this).attr("id");
        new daum.Postcode({
              oncomplete: function(data) {
                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
                    // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                    // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                    var fullAddr = ''; // 최종 주소 변수
                    var extraAddr = ''; // 조합형 주소 변수
                    // 사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                    if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                        fullAddr = data.roadAddress;
                    } else { // 사용자가 지번 주소를 선택했을 경우(J)
                        fullAddr = data.jibunAddress;
                    }
                    // 사용자가 선택한 주소가 도로명 타입일때 조합한다.
                    if(data.userSelectedType === 'R'){
                        //법정동명이 있을 경우 추가한다.
                        if(data.bname !== ''){
                            extraAddr += data.bname;
                        }
                        // 건물명이 있을 경우 추가한다.
                        if(data.buildingName !== ''){
                            extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                        }
                        // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
                        extraAddr = (extraAddr !== '' ? '('+ extraAddr +') ' : '');
                    }
                    // 우편번호와 주소 정보를 해당 필드에 넣는다.
                      $('input[name=returnZipcode]').val(data.zonecode);
                      $('input[name=returnAddr]').val(fullAddr);
                      // 커서를 상세주소 필드로 이동한다.
                      $('input[name=returnAddrDtl]').val(extraAddr);
                      $('input[name=returnAddrDtl]').focus();
              }
          }).open();
      });

      $.claimProcSpecificSave = function(claimProcStatusCd,claimProcStatusNm){
          var qtyTestBoolean = true;
        if(fnValidation()){
          $("input[name=prodCd]:checked").each(function(){
            var prodCd = $(this).val();
            var returnQty = $("#"+prodCd+"ReturnQty").val();
            var prodQty = $("#"+prodCd+"ProdQty").val();
            if(parseInt(removeComma(returnQty)) == 0 || returnQty == ""){
              alert("선택 상품 반품 수량이 없습니다.");
              $("#"+prodCd+"ReturnQty").focus();
              return qtyTestBoolean = false;
            }

            if(parseInt(removeComma(returnQty)) > parseInt(removeComma(prodQty))){
              alert("구매수량보다 반품수량이 많습니다.");
              $("#"+prodCd+"ReturnQty").focus();
              return qtyTestBoolean = false;
            }
          });

          if(qtyTestBoolean){
            $("input[name=claimProcStatusCd]").val(claimProcStatusCd);
           if(claimProcStatusCd == 'OPS00000'){
        	   var claimProcStatusNm = "";
        	   if($('input:radio[name="claimTpCdChange"]:checked').val() == 'OCT00002'){
        		   claimProcStatusNm = "환불진행";
        	   }else if($('input:radio[name="claimTpCdChange"]:checked').val() == 'OCT00003'){
        		   claimProcStatusNm = "반품진행";
        	   }else if($('input:radio[name="claimTpCdChange"]:checked').val() == 'OCT00004'){
        		   claimProcStatusNm = "부분반품진행";
        	   }else if($('input:radio[name="claimTpCdChange"]:checked').val() == 'OCT00005'){
        		   claimProcStatusNm = "교환진행";
        	   }
               fnSubmit("workForm",claimProcStatusNm+" 처리");
           }else{
            fnSubmit("workForm",claimProcStatusNm+" 처리");
           }
          }
        }
      }

      $.claimSmsAccountPop = function(claimProcStatusCd, claimProcStatusNm, accountNo, receiptMoblie){
        $("input[name=claimProcStatusCd]").val(claimProcStatusCd);
        $("input[name=claimProcStatusNm]").val(claimProcStatusNm);
        $("#accountMsg").val($("select[name=orderAccount] option:selected").text());

        $("input[name=claimProcStatusCd]")
        $.fancybox.open({
          href: "/mng/amM3/amM3/claimSmsAccountPop.action",
          type: "iframe",
           maxWidth	: 450,
           maxHeight	:330,
           width		: 500,
           height		: 330,
           autoSize	: false,
           modal : false,
        });
      }

      $("input[name=chkReceipt]").bind("change", function(){
        if($(this).val() == "1"){
          $("#div_receipt_method1 input").prop("disabled",false);
          $("#div_receipt_method1").show();
          $("#div_receipt_method2 input").prop("disabled",true);
          $("#div_receipt_method2").hide();
        }else{
          $("#div_receipt_method1 input").prop("disabled",true);
          $("#div_receipt_method1").hide();
          $("#div_receipt_method2 input").prop("disabled",false);
          $("#div_receipt_method2").show();
        }
      });
  }
   /*----------------------------------------------------------------------------------------------
     * 화면 기본 데이터 셋팅
     *----------------------------------------------------------------------------------------------*/
    function fnDataSetting(){
      if($(".complete").length > 0){
        $("input").prop("disabled",true);
        $("select").prop("disabled",true);
        $("textarea").prop("disabled",true);
        $(".btn_type1").hide();
        $(".btn_type2").hide();
      }
      	<c:if test="${orderInfo.claimTpCd ne 'OCT00005'}">
     		 $.claimTpCdChangeFlag("off");
		</c:if>
        $.chkReceipFlag('off');
    }


  </script>
</head>

<body class="noBg">
  <div class="popup_wrap" style="background:#fff">
  <h2>환불/반품 프로세스</h2>
  <div class="member_con">

   <div class="pageContScroll_st4">
    <div>
      <div class="align_area" >
        <div class="left">
          <h3>주문내역</h3>
        </div>
        <div class="right">
          <span class="font16 lineH28">주문번호 : <b>${orderInfo.orderNo}</b> (${orderInfo.orderDtFull})</span>
        </div>
      </div>
      <!-- // align_area -->
      <div class="table_type1" >
        <table>
          <caption>선택, 주문상품, 결제금액, 상태, 문서관련으로 구성된 주문내역에 대한 상세 테이블 입니다.</caption>
          <colgroup>
            <col style="width:40%;" />
            <col style="width:30%;" />
            <col style="width:15%;" />
            <col style="width:15%;" />
          </colgroup>
          <thead>
            <tr>
              <th scope="col">주문상품</th>
              <th scope="col">결제금액</th>
              <th scope="col">상태</th>
              <th scope="col">업무</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td class="alignL">
                <c:forEach items="${orderInfo.prodInfoList}" var="prodInfo" varStatus="idx">
                  <div style="margin:5px 0 5px 10px;">
                      <div class="fl">${prodInfo.prodNm}<c:if test="${prodInfo.prodTypeGsp eq 'P'}"><span class="ptText">(포인트상품)</span></c:if></div>
                      <div >(수량 : <span class="validation[number]">${prodInfo.prodQty}</span>)</div>
                  </div>
                  <c:if test="${!idx.last}"><center><div style="width:96%;height:1px;margin-bottom:5px;border-top:#ccc 1px dotted;"></div></center></c:if>
                </c:forEach>
              </td>
              <td>
                <div class="price_list_area">
                  <div class="price_list">
                    <ul>
                      <li>
                        <dl>
                          <dt>상품금액</dt>
                          <dd><span class="validation[number]">${orderInfo.orderAmt}</span>&nbsp;원</dd>
                        </dl>
                      </li>
                      <li>
                        <dl>
                          <dt>상품할인</dt>
                          <dd><div style="color:red;">-&nbsp;<span class="validation[number]">${orderInfo.orderSaleAmt}</span>&nbsp;원</div></dd>
                        </dl>
                      </li>
                      <li>
                        <dl>
                          <dt>쿠폰할인</dt>
                          <dd><div style="color:red;">-&nbsp;<span class="validation[number]">${orderInfo.orderCopnAmt}</span>&nbsp;원</div></dd>
                        </dl>
                      </li>
                      <li>
                        <dl>
                          <dt>적립금사용</dt>
                          <dd><div style="color:red;">-&nbsp;<span class="validation[number]">${orderInfo.orderResvAmt}</span>&nbsp;원</div></dd>
                        </dl>
                      </li>
                      <li>
                        <dl>
                          <dt>배송비</dt>
                          <dd>
                            <c:choose>
                              <c:when test="${orderInfo.orderDeliCharge == 0}">
                                <div>무료배송</div>
                              </c:when>
                              <c:otherwise>
                                <div><span class="validation[number]">${orderInfo.orderDeliCharge}</span>&nbsp;원</div>
                              </c:otherwise>
                            </c:choose>
                          </dd>
                        </dl>
                      </li>
                    </ul>
                  </div>
                  <!-- // price_list -->
                  <div class="price_total" >
                    <dl>
                      <dt>결제금액</dt>
                      <dd style="margin-top:0px;"><span class="validation[number]">${orderInfo.orderSum}</span>&nbsp;원</dd>
                    </dl>
                  </div>
                  <!-- // price_list_area -->
                </div>
                <!-- // price_list_area -->
              </td>
              <td><span style="color:red">${orderInfo.claimTpNm}</span>
                  <c:if test="${not empty orderInfo.orderCashNm}">
                    <br/>결재 : ${orderInfo.orderCashNm}
                  </c:if>
                  <c:if test="${orderInfo.claimYn eq 'Y'}">
                    <br/>주문상태 : ${orderInfo.orderStatusNm}
                  </c:if>
                  <c:if test="${not empty orderInfo.regiNo}">
                      <br />(우체국택배)
                      <div class="marT10"><a class="btn_type2" href="https://service.epost.go.kr/trace.RetrieveDomRigiTraceList.comm?sid1=${orderInfo.regiNo}&displayHeader=N" >배송추적</a></div>
                  </c:if>
              </td>
              <td>
                  <c:set var="forLoop" value="true"/>
                  <c:forEach items="${claimProcessList}" var="claimProcess" varStatus="idx">
                    <c:if test="${forLoop}">
                      <c:if test="${claimProcess.claimProcWp eq 'W'}">
                        <b>현재 ${claimProcess.claimProcStatusNm}<br/>진행중</b>
                        <c:set var="forLoop" value="false"/>
                      </c:if>
                    </c:if>
                    <c:if test="${idx.last}">
                      <c:if test="${claimProcess.claimProcWp eq 'P'}">
                        <b>${claimProcess.claimProcStatusNm}</b>
                      </c:if>
                    </c:if>
                  </c:forEach>
              </td>
            </tr>
          </tbody>

        </table>
      </div>
      <!-- // table_type1 -->
      <div class="align_area" >
        <div class="left">
          <h3>환불/반품 기본정보</h3>
        </div>
        <div class="right">
          <a id="claimBasicInfoSaveBtn" class="btn_type2" href="javascript:;">기본정보 저장</a>
        </div>
      </div>
       <form id="workForm" name="workForm" action="claimProcSpecificSave.action" method="post">
       <input type="hidden" id="claimTpCd" name="claimTpCd" value="${orderInfo.claimTpCd}" />
       <input type="hidden" id="orderNo" name="orderNo" value="${orderInfo.orderNo}" />
       <input type="hidden" id="claimDeliCharge" name="claimDeliCharge" value="${orderInfo.claimDeliCharge}" />
       <input type="hidden" id="receiptMoblie" name="receiptMoblie" value="${orderInfo.receiptMobile}"/>
       <input type="hidden" id="orderCashCd" name="orderCashCd" value="${orderInfo.orderCashCd}"/>
       <input type="hidden" id="claimProcStatusCd" name="claimProcStatusCd" />
       <input type="hidden" id="claimProcStatusNm" name="claimProcStatusNm" />
       <input type="hidden" id="accountMsg" name="accountMsg" />
       <input type="hidden" id="senderMoblie" name="senderMoblie" />

      <div class="table_type2">
        <table>
              <colgroup>
                <col style="width:200px" />
                <col style="width:*;" />
              </colgroup>
          <tbody>
            <tr>
              <th scope="row">환불계좌 정보입력</th>
              <td>
                <div class="fl_td">
                  <html:selectList name='refundInstCd' id='refundInstCd' list='${accountInst}' listValue='accountInstCd' listName='accountInstNm' defaultValue="${orderInfo.refundInstCd}"  script=' style="width:150px;"'/>
                </div>
                <div class="fl_td">
                  <input type="text" name="refundAccountNo" title="계좌번호" style="width:200px;" placeholder="계좌번호" value="${orderInfo.refundAccountNo}"/>
                </div>
                <div class="fl_td">
                  <input type="text" name="refundAccountHd" title="예금주명" style="width:100px;" placeholder="예금주명" value="${orderInfo.refundAccountHd}"/>
                </div>
              </td>
            </tr>
            <tr class="returnAddress">
              <th scope="row">기존수령지주소</th>
              <td>
                <div style="float:left;line-height:28px;margin-right:5px;">
                  (${orderInfo.receiptZipcode})
                </div>
                <div style="float:left; line-height:28px;margin-right:5px;">
                  ${orderInfo.receiptAddr}
                </div>
                <div style="float:left;line-height:28px;margin-right:5px;">
                  ${orderInfo.receiptAddrDtl}
                </div>
                <a class="btn_type1 marL10" id="addrCopy" href="javascript:;">교환수령지로 주소복사</a>
              </td>
            </tr>
            <tr class="returnAddress">
              <th scope="row">교환수령지</th>
              <td>
                <div class="fl_td">
                  <input type="text" name="returnZipcode" style="width:60px;" class="validation[required]" title="우편번호" placeholder="우편번호" value="${orderInfo.returnZipcode}" readonly="readonly"/>
                </div>
                <div style="float:left; line-height:28px;margin-right:10px;">
                  <input type="text" name="returnAddr"  style="width:300px;" class="validation[required]"  title="주소"  placeholder="주소" value="${orderInfo.returnAddr}" readonly="readonly"/>
                </div>
                <div style="float:left;line-height:28px;margin-right:5px;">
                  <input type="text" name="returnAddrDtl" style="width:150px;" placeholder="주소상세" value="${orderInfo.returnAddrDtl}"/>
                </div>
                <div class="fl_td">
                  <a class="btn_type1 marL10" id="addrSearch" href="javascript:;">주소검색</a>
                </div>
              </td>
            </tr>
            <tr>
              <th scope="row">현금영수증</th>
              <td>
                <div style="width:100%;height:1px;margin:0px 0 6px 0;"></div>
                <div>
                  <label for="chkReceiptYn" >발급 여부&nbsp;</label><input type="checkbox" id="chkReceiptYn" name="chkReceiptYn" value="Y" >
                </div>
                <div style="width:100%;height:1px;margin:0px 0 6px 0;"></div>
                <div class="chkReceiptArea">
                    <div style="width:100%;height:1px;margin:0px 0 10px 0;"></div>
                    <span class="di_pc">
                      <input type="radio" id="cashDeduct"  name="chkReceipt" class="pay_bor validation[choose]" value="1" checked="checked"  />
                      <label for="cashDeduct" class="card">소득공제용(일반개인용)</label>
                    </span>
                    <span class="di_pc">
                      <input type="radio" id="cashProof" name="chkReceipt" class="pay_bor validation[choose]" value="2"  />
                      <label for="cashProof" class="card">지출증빙용(사업자용)</label>
                    </span>
                  <div style="width:100%;height:1px;margin:0px 0 10px 0;"></div>
                    <div class="call" id="div_receipt_method1">
                      <span class="tit">휴대폰 번호</span>
                      <span id="cash_phone" class="di_pc">
                        <input type="text" name="chkPhone1" size="4" class="validation[required]" title="휴대폰 첫째자리" maxlength="3"><span class="etc_text">-</span>
                        <input type="text" name="chkPhone2" size="5" class="validation[required]" title="휴대폰 둘째자리" maxlength="4"><span class="etc_text">-</span>
                        <input type="text" name="chkPhone3" size="5" class="validation[required]" title="휴대폰 셋째자리" maxlength="4">
                      </span>
                    </div>
                    <div class="call"  id="div_receipt_method2" style="display: none;">
                      <span class="tit">사업자등록번호</span>
                      <span id="cash_receipt">
                        <input type="text" name="receiptSsn1" size="4" class="validation[required]" title="사업자번호 첫째자리" maxlength="3"><span class="etc_text">-</span>
                        <input type="text" name="receiptSsn2" size="3" class="validation[required]" title="사업자번호 첫째자리" maxlength="2"><span class="etc_text">-</span>
                        <input type="text" name="receiptSsn3" size="6" class="validation[required]" title="사업자번호 첫째자리" maxlength="5">
                      </span>
                    </div>
                </div>
              </td>
            </tr>
            <tr>
              <th scope="row">사유</th>
              <td>
                <div class="textarea_form">
                  <textarea name="claimReason" style="height:60px;" class="validation[required]" title="사유" ><c:choose><c:when test="${empty orderInfo.claimReason}">${orderInfo.claimProcCont} </c:when><c:otherwise>${orderInfo.claimReason}</c:otherwise></c:choose></textarea>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>   
      <div class="align_area" >
          <h3>환불/반품 프로세스</h3>
      </div>

      <div style="margin-bottom:5px;"><c:if test="${orderInfo.claimTpCd eq 'OCT00004'}"><b style="color:red">※부분반품시 결재건들은 전액 환불 후 무통장으로 차액을 뺀 금액을 입금 받은 후 진행해야합니다.</b></c:if></div>
      <div class="table_type2">
        <table>
          <caption>주문취소접수일, 반송비부담, 배송비가상계좌발급, 취소유형, 택배비입금, 배송실반품확인, 주문취소확정, 환불금, 환불완료, 환불계좌 정보입력, 반송주소, 사유, 처리이력로 구성된 주문취소접수에 대한 상세 테이블 입니다.</caption>
          <colgroup>
            <col style="width:200px" />
            <col style="width:*;" />
          </colgroup>
          <tbody>
            <c:forEach items="${claimProcessList}" var="claimProcess" varStatus="idx">
              <c:choose>
                <c:when test="${claimProcess.claimProcStatusCd eq 'OPS00000'}">
                  <tr>
                    <th scope="row">${claimProcess.claimProcStatusNm}</th>
                    <td>
                      <c:choose>
                        <c:when test="${claimProcess.prevStep eq 'P'}">
                          <c:choose>
                            <c:when test="${claimProcess.claimProcWp eq 'W'}">
                            	<c:if test="${orderInfo.orderCashCd eq 'Online'}">
                                <div class="fl_td"><input type="radio" id="OCT00002" class="validation[choose]" name="claimTpCdChange" title="${claimProcess.claimProcStatusNm}" value="OCT00002" /><label for="OCT00002">환불진행</label></div>
                                </c:if>
                                <div class="fl_td"><input type="radio" id="OCT00003" class="validation[choose]" name="claimTpCdChange" title="${claimProcess.claimProcStatusNm}" value="OCT00003" /><label for="OCT00003">반품진행</label></div>
                                <div class="fl_td"><input type="radio" id="OCT00004" class="validation[choose]" name="claimTpCdChange" title="${claimProcess.claimProcStatusNm}" value="OCT00004" /><label for="OCT00004">부분반품진행</label></div>
                                <div class="fl_td"><input type="radio" id="OCT00005" class="validation[choose]" name="claimTpCdChange" title="${claimProcess.claimProcStatusNm}" value="OCT00005" /><label for="OCT00005">교환진행</label></div>
                                <div class="fl_td">
                                  <a class="btn_type2" href="javascript:;" onclick="$.claimProcSpecificSave('${claimProcess.claimProcStatusCd}','${claimProcess.claimProcStatusNm}');">확인처리</a>
                                </div>
                            </c:when>
                            <c:when test="${claimProcess.claimProcWp eq 'P'}">
                              <b>${claimProcess.claimProcInfo}</b>
                            </c:when>
                          </c:choose>
                        </c:when>
                        <c:otherwise>
                            선행 작업 진행 후 진행 가능합니다.
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:when>
                <c:when test="${claimProcess.claimProcStatusCd eq 'OPS00001'}">
                  <tr>
                    <th scope="row">${claimProcess.claimProcStatusNm}</th>
                    <td>
                      <c:choose>
                        <c:when test="${claimProcess.prevStep eq 'P'}">
                          <c:choose>
                            <c:when test="${claimProcess.claimProcWp eq 'W'}">
                              <div style="width:100%;height:1px;margin:10px 0 10px 0;border-top:#ccc 1px dotted;"></div>
                                <c:forEach items="${orderInfo.prodInfoList}" var="prodInfo" varStatus="idx">
                                  <c:if test="${prodInfo.prodTypeGsp ne 'P'}">
                                    <input type="hidden" name="${prodInfo.prodCd}ProdQty" id="${prodInfo.prodCd}ProdQty"  value="${prodInfo.prodQty}" />
                                    <input type="hidden" name="${prodInfo.prodCd}ProdInfoRegNo" id="${prodInfo.prodCd}ProdInfoRegNo"  value="${prodInfo.prodInfoRegNo}" />
									<c:choose>
                               			<c:when test="${orderInfo.claimTpCd eq 'OCT00004'}">
                               				 <div><input type="checkbox" name="prodCd"  id="${prodInfo.prodCd}" class="validation[choose]"  title="반품상품 선택" style="margin-right:5px;" value="${prodInfo.prodCd}" />
				                                    <label for="${prodInfo.prodCd}">${prodInfo.prodNm}
				                                    (상품금액 : <span class="validation[number]"><c:choose><c:when test="${prodInfo.prodSalePrice == 0}">${prodInfo.prodPrice}</c:when><c:otherwise>${prodInfo.prodSalePrice}</c:otherwise></c:choose></span>
				                                    원  구매 수량 : ${prodInfo.prodQty}&nbsp;개) </label>
				                                    - <b>반품 수량 :</b> <input type="text" class="validation[number]" style="width:40px;" name="${prodInfo.prodCd}ReturnQty" id="${prodInfo.prodCd}ReturnQty"  value="${prodInfo.prodQty}" />&nbsp;개</div>
				                                    <div style="width:100%;height:1px;margin:10px 0 10px 0;border-top:#ccc 1px dotted;"></div>

                               			</c:when>
                               			<c:when test="${orderInfo.claimTpCd eq 'OCT00005'}">
                               				 <div><input type="checkbox" name="prodCd"  id="${prodInfo.prodCd}" class="validation[choose]"  title="교환상품 선택" style="margin-right:5px;" value="${prodInfo.prodCd}" />
				                                    <label for="${prodInfo.prodCd}">${prodInfo.prodNm}
				                                   : 수량 : ${prodInfo.prodQty}&nbsp;개 </label>
				                                    - <b>교환 수량 :</b> <input type="text" class="validation[number]" style="width:40px;" name="${prodInfo.prodCd}ReturnQty" id="${prodInfo.prodCd}ReturnQty"  value="${prodInfo.prodQty}" />&nbsp;개</div>
				                                    <div style="width:100%;height:1px;margin:10px 0 10px 0;border-top:#ccc 1px dotted;"></div>
                               			</c:when>
									</c:choose>

                                  </c:if>
                                </c:forEach>
                                <div style="margin-bottom:5px;"><a class="btn_type2" href="javascript:;" onclick="$.claimProcSpecificSave('${claimProcess.claimProcStatusCd}','${claimProcess.claimProcStatusNm}');">확인처리</a></div>
                            </c:when>
                            <c:when test="${claimProcess.claimProcWp eq 'P'}">
                              <div style="width:100%;height:1px;margin:0px 0 10px 0;"></div>
                              <b>${claimProcess.claimProcInfo}</b>

                              <div style="width:100%;height:1px;margin:10px 0 10px 0;border-top:#ccc 1px dotted;"></div>
                                <c:set var="sumPrice" value="0"/>


                                <c:forEach items="${orderInfo.prodReturnList}" var="prodInfo" varStatus="idx">
                                  <c:choose>
                                    <c:when test="${prodInfo.prodSalePrice == 0}"><c:set var="rearPrice" value="${prodInfo.prodPrice}"/></c:when>
                                    <c:otherwise><c:set var="rearPrice" value="${prodInfo.prodSalePrice}"/></c:otherwise>
                                  </c:choose>
                                     ${prodInfo.prodNm} (상품금액 : <span class="validation[number]">${rearPrice}</span> 원  구매 수량 : ${prodInfo.prodQty}&nbsp;개)
                                    - <b>반품 수량 :</b> <span class="validation[number]">${prodInfo.prodQty}</span>&nbsp;개
                                    <div style="width:100%;height:1px;margin:10px 0 10px 0;border-top:#ccc 1px dotted;"></div>
                                    <c:set var="sumPrice" value="${sumPrice+rearPrice}" />
                                </c:forEach>

                               <c:if test="${orderInfo.claimTpCd eq 'OCT00004'}">
                              <b>반품 상품 합산 금액 : <span class="sum validation[number]">${sumPrice}</span>&nbsp;원 </b>
                              <div style="width:100%;height:1px;margin:0px 0 10px 0;"></div>
                              <b>반품비</b>(구매상품 + 반품상품) = <b><span class="total validation[number]">${orderInfo.orderSum - sumPrice}</span>&nbsp;원</b>
                              (<span class="total validation[number]">${orderInfo.orderSum}</span>원-<span class="total validation[number]">${sumPrice}</span>원)
                              <div style="width:100%;height:1px;margin:0px 0 10px 0;"></div>
                              </c:if>
                            </c:when>
                          </c:choose>
                        </c:when>
                        <c:otherwise>
                            선행 작업 진행 후 진행 가능합니다.
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:when>
                <c:when test="${claimProcess.claimProcStatusCd eq 'OPS00002'}">
                  <tr>
                    <th scope="row">${claimProcess.claimProcStatusNm}</th>
                    <td>
                      <c:choose>
                        <c:when test="${claimProcess.prevStep eq 'P'}">
                          <c:choose>
                            <c:when test="${claimProcess.claimProcWp eq 'W'}">
                              <div class="fl_td">
                               <c:if test="${orderInfo.claimTpCd eq 'OCT00004'}">
                                (반품비 + 반품 배송비) : <b><span class="validation[number]">${orderInfo.orderSum - sumPrice}</span> 원+</b>
                                </c:if>
                                <select name="claimDeliChargeConf" style="width:150px">
                                	<c:choose>
                                		<c:when test="${orderInfo.claimTpCd eq 'OCT00005'}">
				                                  <option value="4000">고객부담 (4,000원)</option>
                                		</c:when>
                                		<c:otherwise>
			                                  <option value="<c:choose><c:when test="${orderInfo.orderDeliCharge == 0}">4000</c:when><c:otherwise>2000</c:otherwise></c:choose>">
			                                  고객부담 (<c:choose><c:when test="${orderInfo.orderDeliCharge == 0}">4,000</c:when><c:otherwise>2,000</c:otherwise></c:choose>원)
                                			  </option>
                                		</c:otherwise>
                                	</c:choose>
                                  <option value="0">회사부담 (무료)</option>
                                </select>
                                <input type="hidden" name="receivedCharge" value="${orderInfo.orderSum - sumPrice}" />
                              </div>
                              <div class="fl_td">
                                <a class="btn_type2" href="javascript:;" onclick="$.claimProcSpecificSave('${claimProcess.claimProcStatusCd}','${claimProcess.claimProcStatusNm}');">확인처리</a>
                              </div>
                            </c:when>
                            <c:when test="${claimProcess.claimProcWp eq 'P'}">
                                <b>${claimProcess.claimProcInfo}</b>
                            </c:when>
                          </c:choose>
                        </c:when>
                        <c:otherwise>
                            선행 작업 진행 후 진행 가능합니다.
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:when>
                <c:when test="${claimProcess.claimProcStatusCd eq 'OPS00003'}">
                  <tr>
                    <th scope="row">${claimProcess.claimProcStatusNm}</th>
                    <td>
                    <c:choose>
                      <c:when test="${claimProcess.prevStep eq 'P'}">
                        <c:choose>
                          <c:when test="${claimProcess.claimProcWp eq 'W'}">
                            <div class="fl_td">
                              <select id="orderAccount" name="orderAccount" >
                                <c:forEach var="orderAccount" items="${orderAccountList}" varStatus="nStatus">
                                  <option value="${orderAccount.accountNo}">${orderAccount.accountNm} :: ${orderAccount.accountNo}</option>
                                </c:forEach>
                              </select>
                            </div>
                            <div class="fl_td">
                               <input type="hidden" id="receivedCharge" name="receivedCharge" value="${orderInfo.receivedCharge}" />
                              <a class="btn_type2" href="javascript:;" onclick="$.claimSmsAccountPop('${claimProcess.claimProcStatusCd}','${claimProcess.claimProcStatusNm}');">문자발송(확인처리)</a>
                            </div>
                          </c:when>
                          <c:when test="${claimProcess.claimProcWp eq 'P'}">
                              <b>${claimProcess.claimProcInfo}</b>
                          </c:when>
                        </c:choose>
                      </c:when>
                      <c:otherwise>
                          선행 작업 진행 후 진행 가능합니다.
                      </c:otherwise>
                    </c:choose>
                    </td>
                  </tr>
                </c:when>
                <c:when test="${claimProcess.claimProcStatusCd eq 'OPS00004'}">
                  <tr>
                    <th scope="row">${claimProcess.claimProcStatusNm}</th>
                    <td>
                      <c:choose>
                        <c:when test="${claimProcess.prevStep eq 'P'}">
                          <c:choose>
                            <c:when test="${claimProcess.claimProcWp eq 'W'}">
                              <div class="fl_td">
                              <c:choose>
                             	 <c:when test="${orderInfo.claimTpCd eq 'OCT00004'}">
                                	<input type="text" class="validation[number]" name="claimDeliChargeConf" id="claimDeliChargeConf" value="${orderInfo.receivedCharge+orderInfo.claimDeliCharge}" />
                             	 </c:when>
                             	 <c:otherwise>
                                	<input type="text" class="validation[number]" name="claimDeliChargeConf" id="claimDeliChargeConf" value="${orderInfo.claimDeliCharge}" />
                             	 </c:otherwise>
                              </c:choose>
                              </div>
                              <div class="fl_td">
                                <a class="btn_type2" href="javascript:void(0)" onclick="$.claimProcSpecificSave('${claimProcess.claimProcStatusCd}','${claimProcess.claimProcStatusNm}');">확인처리</a>
                              </div>
                            </c:when>
                            <c:when test="${claimProcess.claimProcWp eq 'P'}">
                                  <b>${claimProcess.claimProcInfo}</b>
                            </c:when>
                          </c:choose>
                        </c:when>
                        <c:otherwise>
                          선행 작업 진행 후 진행 가능합니다.
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:when>
                <c:when test="${claimProcess.claimProcStatusCd eq 'OPS00005'}">
                  <tr>
                    <th scope="row">${claimProcess.claimProcStatusNm}</th>
                    <td>
                      <c:choose>
                          <c:when test="${claimProcess.prevStep eq 'P'}">
                            <c:choose>
                              <c:when test="${claimProcess.claimProcWp eq 'W'}">
                                <div class="fl_td">
                                  반품확인 내역이 없습니다.
                                </div>
                              </c:when>
                              <c:when test="${claimProcess.claimProcWp eq 'P'}">
                                  <b>${claimProcess.claimProcInfo}</b>
                              </c:when>
                            </c:choose>
                        </c:when>
                        <c:otherwise>
                          선행 작업 진행 후 진행 가능합니다.
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:when>
                <c:when test="${claimProcess.claimProcStatusCd eq 'OPS00006'}">
                  <tr>
                    <th scope="row">${claimProcess.claimProcStatusNm}</th>
                    <td>
                      <c:choose>
                        <c:when test="${claimProcess.prevStep eq 'P'}">
                          <c:choose>
                            <c:when test="${claimProcess.claimProcWp eq 'W'}">
                              <div class="fl_td">
                                 (무통장입금(일반) - 외의 PG사 연동 건 들은 예정시 자동 환불 처리됨니다.)<br/>
                              <c:choose>
                                 <c:when test="${orderInfo.claimTpCd eq 'OCT00004'}">
                                 ${orderInfo.orderCashNm} - 환불 예정 금액 : <c:choose>
                                 																		<c:when test="${orderInfo.orderCashCd eq 'Online'}"><input type="text" class="validation[number]" name="refundCharge" id="refundCharge" value="${orderInfo.orderSum}" /></c:when>
                                 																		<c:otherwise><span class="validation[number]">${orderInfo.orderSum}</span></c:otherwise>
                                 																	</c:choose>
                                </c:when>
                                <c:otherwise>
                                환불 예정 금액 :
                                <c:choose>
                                 	<c:when test="${orderInfo.orderCashCd eq 'Online'}"><input type="text" class="validation[number]" name="refundCharge" id="refundCharge" value="${orderInfo.orderSum - sumPrice}" /></c:when>
                                 	<c:otherwise><span class="validation[number]">${orderInfo.orderSum - sumPrice}</span></c:otherwise>
                                </c:choose>
                                </c:otherwise>
                              </c:choose><a class="btn_type2" href="javascript:void(0)" onclick="$.claimProcSpecificSave('${claimProcess.claimProcStatusCd}','${claimProcess.claimProcStatusNm}');">확정처리</a>
                              </div>

                            </c:when>
                            <c:when test="${claimProcess.claimProcWp eq 'P'}">
                              <b>${claimProcess.claimProcInfo}</b>
                            </c:when>
                          </c:choose>
                        </c:when>
                        <c:otherwise>
                          선행 작업 진행 후 진행 가능합니다.
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:when>
                <c:when test="${claimProcess.claimProcStatusCd eq 'OPS00007'}">
                  <tr>
                    <th scope="row">${claimProcess.claimProcStatusNm}</th>
                    <td>
                      <c:choose>
                        <c:when test="${claimProcess.prevStep eq 'P'}">
                          <c:choose>
                            <c:when test="${claimProcess.claimProcWp eq 'W'}">
  								<c:choose>
                             	 <c:when test="${orderInfo.claimTpCd eq 'OCT00005'}">
                             	 	  교환배송은 수동으로 배송처리해야합니다. <a class="btn_type2" href="javascript:;" onclick="$.claimProcSpecificSave('${claimProcess.claimProcStatusCd}','${claimProcess.claimProcStatusNm}');">완료처리</a>
                             	 </c:when>
                             	 <c:otherwise>
                              		<input type="hidden" name="refundCharge" id="refundCharge" value="${orderInfo.refundCharge}" />
                             	 	   환불완료 금액 : (<span class="validation[number]">${orderInfo.refundCharge}</span>원)
                             	 	   <a class="btn_type2" href="javascript:void(0)" onclick="$.claimProcSpecificSave('${claimProcess.claimProcStatusCd}','${claimProcess.claimProcStatusNm}');">완료처리</a>
                             	 </c:otherwise>
                              </c:choose>
                            </c:when>
                            <c:when test="${claimProcess.claimProcWp eq 'P'}">
                              <b class="complete" style="color:blue">${claimProcess.claimProcInfo}</b>
                            </c:when>
                          </c:choose>
                        </c:when>
                        <c:otherwise>
                          선행 작업 진행 후 진행 가능합니다.
                        </c:otherwise>
                      </c:choose>
                    </td>
                  </tr>
                </c:when>
              </c:choose>
            </c:forEach>
          </tbody>
        </table>
      </div>
      </form>
      <div class="align_area" >
          <h3>처리이력</h3>
      </div>
      <div class="table_type2">
        <table>
              <colgroup>
                <col style="width:200px;" />
                <col style="width:*;" />
              </colgroup>
          <tbody>
            <tr>
              <th scope="row">처리이력</th>
              <td>
                <div class="dash_ul">
                  <ul>
                  <c:forEach items="${claimProcessHis}" var="claimProcessHisUit">
                    <li>${claimProcessHisUit.cont}</li>
                  </c:forEach>
                  </ul>
                </div>
              </td>
            </tr>
          </tbody>
        </table>
      </div>

      <!-- // table_type2 -->
    </div>
    <!-- // member_detail_con -->
  </div>
  </div>
  <div class="btn_area">
        <div class="center">
            <a class="btn_blue_line2" href="javascript:;" onclick="parent.$.fancybox.close();">닫기</a>
        </div>
      </div>
  </div>
  <!-- // member_con -->
</body>
</html>
