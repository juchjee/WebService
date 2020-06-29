<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js"></script>
	<style>
		.y{cursor:pointer;}
	</style>
	<script type="text/javascript">

	<!--

	var m_oMonth = new Date();

	var nowYear = ${fn:split(iConstant.nowYmd(),'-')[0]};
	var nowMonth = ${fn:split(iConstant.nowYmd(),'-')[1]}-1;
	var nowDay = ${fn:split(iConstant.nowYmd(),'-')[2]};

	m_oMonth.setFullYear(nowYear) ;
	m_oMonth.setMonth(nowMonth);
	m_oMonth.setDate(nowDay);

	var todayDate = parseInt(m_oMonth.getDate());
	var todayYear = parseInt(m_oMonth.getFullYear());
	var todayMonth = parseInt(m_oMonth.getMonth()+1);

	m_oMonth.setDate(1);

	function init(){

		fnEvent();
		fnDataSetting();
	}

	function fnDataSetting(){

		$.attfileAdd("file_add","0");

		printCalendar();
		$.renderCalendar();
		$.initEvent();
		$.lvalue = "m1";
		$("#ascodeLev1").change();
	}


	function fnEvent(){

			$.attfileAdd = function(className,len){

			$("."+className).append("<input type='text' name='dtlImgName' class='input_txt1'/><span class='btn01Type dtlImg' style='cursor:pointer;'>파일찾기</span>");
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


		/*고장증상*/
		$("#ascodeLev1").bind("change",function(){
			var codeTp = "";
			if($("#ascodeLev1").val() == ""){
				codeTp = "L";
				var data = $.lvalue;
			}else{
				codeTp = "M";
				data = $("#ascodeLev1").val();
			}
			fnAjax("ascodeList.action", {"codeTp":codeTp,"lvalue":data},
					function(data, dataType){
						if($("#ascodeLev1").val() == ""){
							$("#ascodeLev1").html("<option value=''>고장증상 대분류</option>");
							for (key in data) {
								$("#ascodeLev1").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
							}
						}else{
							$("#ascodeLev2").html("<option value=''>고장증상 중분류 </option>");
							for (key in data) {
								$("#ascodeLev2").append("<option value='"+data[key].value+"'>"+data[key].label+"</option>");
							}
						}
					},"POST"
				);


		});

		/*탭이벤트*/
		$('.list_goods a').bind("click",function(){
			$(this).addClass('active');
			$(this).siblings().removeClass('active');
			if($(this).index() == 0 || $(this).index() == 1 || $(this).index() == 2 ){
				$.lvalue = "m1";
			}else if($(this).index() == 4){
				$.lvalue = "m2";
			}else{
				$.lvalue = "m3";
			}
			$("#ascodeLev1").val("");
			$("#ascodeLev2").html("<option value=''>고장증상 중분류 </option>");
			$("#ascodeLev1").change();
		});

		/** 주소 찾기 **/
		$("#addrBtn").click(function(){
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
//		                        extraAddr += data.bname;
	                    }
	                    // 건물명이 있을 경우 추가한다.
	                    if(data.buildingName !== ''){
//		                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                    }
	                    // 조합형주소의 유무에 따라 양쪽에 괄호를 추가하여 최종 주소를 만든다.
//		                    fullAddr += (extraAddr !== '' ? ' ('+ extraAddr +')' : '');
	                    extraAddr = (extraAddr !== '' ? '('+ extraAddr +') ' : '');
	                }
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                $('#mbrZipcode').val(data.zonecode); //5자리 새우편번호 사용
	                $('#mbrAddr').val(fullAddr);
	                // 커서를 상세주소 필드로 이동한다.
	                $('#mbrAddrDtl').val(extraAddr);
	                $('#mbrAddrDtl').focus();
		        }
		    }).open();
		});

		$(".rsv li").bind("click", function(){
			var idx =  $(".rsv li").index(this);

			if($(this).attr("class") != "f"){
				$('.rsv li').removeClass('s');
				$(this).addClass("s");


				$("#csTimeSeq").val($(this).attr("value"));
				$("#selectTimeText").text($(this).text());
			}else{
				alert("선택하신 시간은 예약할 수 없습니다.");
			}
		});


		/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 Start -----------------------------*/
		 $("#okBtn").bind("click",function(){
			fnSubmit("workForm","예약신청");
		});
		/*----------------------------- 전송이벤트 - 저장버튼 클릭 이벤트 End -----------------------------*/
	}



	function spanText(day){

		var spanMonth = m_oMonth.getMonth()+1;
		if(spanMonth < 10){
			spanMonth = '0' + spanMonth;
		}

		if(day < 10){
			day = '0' + day;
		}

		$('.rsv td').removeClass('s');
		$("#"+day).addClass("s");


		var spanDay = $("#year").val()+"-"+spanMonth+"-"+day

		$("#bookingDt").val(spanDay);
		$("#selectText").text(spanDay);


		fnAjax("csTimeMpgList.action", {"bookingDt":spanDay},
				function(data, dataType){
					$('.rsv li').removeClass('f');
					for (key in data) {
						if(data[key].csTimeLimit == 'N'){
							$(".rsv li[value="+data[key].csTimeSeq+"]").addClass("f");
						}

						$(".rsv li[value="+data[key].csTimeSeq+"]").html(data[key].csTimeValue);
					}

					$("#selectTimeText").text("시간을 선택하세요");
				},"POST"
			);

	}

	function printCalendar() {

	    /* 달력 UI 생성 */
		$.renderCalendar = function() {

			var postData = $("#calendarFrm").serializeArray();
			$.ajax({
			    url : "calendar.action",
			    type: "POST",
			    data : postData,
			    success:function(data, textStatus, jqXHR)
			    {
			    	var joinMonth = parseInt($("#month").val());

					if($("#month").val() == ''){
						joinMonth = todayMonth;
						$("#year").val(todayYear);
						$("#month").val("0"+(todayMonth+1));
					}

					var arrTable = [];

					arrTable.push('<table class="rsv">');
					arrTable.push('<caption>달력</caption>');
					arrTable.push('<thead><tr>');

					var arrWeek = "일월화수목금토".split("");

					for(var i=0, len=arrWeek.length; i<len; i++) {
						arrTable.push('<th scope="col">' + arrWeek[i] + '</th>');
					}
					arrTable.push('</tr></thead>');
					arrTable.push('<tbody>');

					var oStartDt = new Date(m_oMonth.getTime());
			        // 1일에서 1일의 요일을 빼면 그 주 첫번째 날이 나온다.
					oStartDt.setDate(oStartDt.getDate() - oStartDt.getDay());


					for(var i=0; i<100; i++) {

						var dayValue = oStartDt.getDate();
						if(dayValue < 10){
							dayValue = '0' + dayValue;
						}

						if(i % 7 == 0) {
							arrTable.push('<tr>');
						}

						var sClass = '';
			            sClass += m_oMonth.getMonth() != oStartDt.getMonth() ? 'not-this-month ' : '';
						sClass += i % 7 == 0 ? 'sun' : '';
						sClass += i % 7 == 6 ? 'sat' : '';

						var notMonth = m_oMonth.getMonth() != oStartDt.getMonth() ? 'notMonth ' : '';

			            if(notMonth != ''){
			            	arrTable.push('<td></td>');
			            }else{
			            	var holly = "N";
							if(data.length > 0){
								for (key in data) {
									if(data[key].workDd == dayValue){
										holly = "Y";
										break;
									}
								}
							}

							if(i % 7 == 0 || i % 7 == 6){  //주말제외
								arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
							}else if(todayYear < $("#year").val()){
								if(holly == "N"){
									arrTable.push('<td id="'+dayValue+'" class="y" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '</td>');
									}else{
										arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
									}
							}else if(todayYear == $("#year").val() && todayMonth < joinMonth){
								if(holly == "N"){
									arrTable.push('<td id="'+dayValue+'" class="y" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '</td>');
									}else{
										arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
									}
							}else if(todayYear == $("#year").val() && todayMonth == joinMonth){
								if(todayDate < oStartDt.getDate() ){
									if(holly == "N"){
									arrTable.push('<td id="'+dayValue+'" class="y" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '</td>');
									}else{
										arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
									}
								}else{
									arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
								}
							}else{
								arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
							}
			            }
						oStartDt.setDate(oStartDt.getDate() + 1);

						if(i % 7 == 6) {
							arrTable.push('</tr>');
							if(m_oMonth.getMonth() != oStartDt.getMonth()) {
								break;
							}
						}
					}
					arrTable.push('</tbody></table>');

					$('#calendar').html(arrTable.join(""));
					$.changeMonth();

			    },
			    error: function(jqXHR, textStatus, errorThrown)
			    {
			    	alert("통신에 실패 하였습니다. 관리자에게 문의해 주세요.");
			    }
			}); // ajax

		}

		/* Next, Prev 버튼 이벤트 */
		$.initEvent = function() {
			$('#btnPrev').bind("click",function(){
				$.onPrevCalendar();
			});

			$('#btnNext').bind("click",function(){
				$.onNextCalendar();
			});
		}

	    /* 이전 달력 */
		$.onPrevCalendar = function() {
			m_oMonth.setMonth(m_oMonth.getMonth() - 1);
			var spanMonth = m_oMonth.getMonth()+1;
			if(spanMonth < 10){
				spanMonth = '0' + spanMonth;
			}
			$("#month").val(spanMonth);

			if($("#month").val() > 11){
				$("#year").val(m_oMonth.getFullYear());
			}

			$.renderCalendar();
		}

	    /* 다음 달력 */
		$.onNextCalendar = function() {
			m_oMonth.setMonth(m_oMonth.getMonth() + 1);

			var spanMonth = m_oMonth.getMonth()+1;
			if(spanMonth < 10){
				spanMonth = '0' + spanMonth;
			}
			$("#month").val(spanMonth);

			if($("#month").val() < 2){
				$("#year").val(m_oMonth.getFullYear());
			}

			$.renderCalendar();

		}

	    /* 달력 이동되면 상단에 현재 년 월 다시 표시 */
		$.changeMonth = function() {
			$('#currentDate').text($.getYearMonth(m_oMonth).substr(0,9));
		}

	    /* 날짜 객체를 년 월 문자 형식으로 변환 */
		$.getYearMonth = function(oDate) {
			var spanMonth = oDate.getMonth()+1;
			if(spanMonth < 10){
				spanMonth = '0' + spanMonth;
			}
			return oDate.getFullYear() + '년 ' + spanMonth + '월';
		}
	}

	-->
	</script>
</head>
<body>
	<form id="calendarFrm" name="calendarFrm" method="post">
		<input type="hidden" id="year" name="year" value="${fn:split(iConstant.nowYmd(),'-')[0]}"/>
		<input type="hidden" id="month" name="month" value="${fn:split(iConstant.nowYmd(),'-')[1]}"/>
	</form>

	<form id="workForm" name="workForm" action="csSave.action" method="post" enctype="multipart/form-data">
	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">전화상담 예약</h2>
			<div class="txt_bx">
				<p class="mark">예약하신 시간에 맞춰 전문 상담사가 전화 드리겠습니다.</p>
				<p>신속한 답변을 위해 정확한 전화번호를 기재해주시기 바랍니다.<br>고객님께서 등록하신 상담문의 사항은 마이페이지에서 확인하실 수 있습니다.</p>
				<a href="view.do?pageCd=test3" class="svn btn01Type">서비스요금 안내</a>
			</div>

			<div class="page_location">
				<ul>
					<li><a href="javascript:;"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="javascript:;">서비스예약</a></li>
					<li class="last"><a href="javascript:;">전화상담 예약</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<div class="guide_btn_list">
			<a href="javascript:;" class="fap"><strong class="hv">자주하는 질문</strong><span>유사한 증상 찾아보기</span></a>
			<a href="javascript:;" class="mtd"><strong class="hv">간단 조치 방법</strong><span>제품별 간단 조치 방법</span></a>
			<a href="javascript:;" class="mvi"><strong class="hv">동영상 가이드</strong><span>쉽고 간단한 영상 조치방법</span></a>
		</div>
		<!--// guide_btn_list -->
		<div class="step_bx st01"><h3>제품 증상 선택<span>필수 입력사항</span></h3></div>
		<!--// step01 title -->
		<div class="list_goods">
			<a href="javascript:;" class="gd01 active">비데</a>
			<a href="javascript:;" class="gd02">위생도기</a>
			<a href="javascript:;" class="gd03">수전</a>
			<a href="javascript:;" class="gd04">블렌더</a>
			<a href="javascript:;" class="gd05 last">이누스바스</a>
		</div>
		<!--// 탭메뉴 리스트 -->
		<!--// 탭메뉴 리스트 -->
		<div class="tblType01 mt30">
			<table>
				<caption>제품선택,고장증상 작성</caption>
				<tbody>
					<tr>
						<th scope="row" class="star"><label for="model">모델선택</label></th>
						<td>
							<div class="select_bx">
								<select name="model" id="model">
									<option selected="selected">선택</option>
									<option value="1">부품결함1</option>
									<option value="2">부품결함2</option>
									<option value="3">부품결함3</option>
									<option value="4">부품결함4</option>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="sct01">고장증상</label></th>
						<td>
							<div class="select_bx">
								<select name="ascodeLev1" id="ascodeLev1"  title="고장증상 대분류" class="validation[required]" >
									<option value=''>고장증상 대분류</option>
								</select>
								<select name="ascodeLev2" id="ascodeLev2" title="고장증상 중분류" class="twoPart validation[required]">
									<option value=''>고장증상 중분류</option>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="txtArea">고장증상 상세</label></th>
						<td>
							<div class="txtArea pb10">
								<textarea id="txtArea" name="comment" class="validation[required]" title="고장증상 상세">고장증상에 대한 상세내용을 입력하시면 더욱 신속히 처리해 드리겠습니다.\n예) 비데 불이 깜빡거려요</textarea>
								<div>
									<span class="info">* 최대 1000byte(한글 500자, 영문 1000자)까지 가능</span>
									<span class="cur">0/1000 byte</span>
								</div>
							</div>
						</td>
					</tr>
				</tbody>
			</table>
		</div>
		<!--// step01 content -->
		<div class="step_bx st02"><h3>고객 정보 입력<span>필수 입력사항</span></h3></div>
		<!--// step02 title -->
		<div>
			<div class="rdi_bx_wrap">
				<div class="rdibox">
					<input type="radio" id="sameif" class="" name="info" value=""><i></i>
					<label for="sameif">회원정보와 동일</label>
				</div>
				<div class="rdibox">
					<input type="radio" id="newif" class="" name="info" value=""><i></i>
					<label for="newif">새로운 정보 입력</label>
				</div>
			</div><!--// rdi_bx_wrap -->

			<div class="tblType01">
				<table>
					<caption>고객 정보 입력란</caption>
					<tbody>
						<tr>
							<th scope="row" class="star"><label for="model">성명</label></th>
							<td>
								${mbr.mbrNm}
								<input type="hidden" name="mbrNm" value="${mbr.mbrNm}" class="validation[required]" title="성명">
							</td>
						</tr>
						<tr>
							<th scope="row" class="star"><label for="call">연락가능번호</label></th>
							<td>
								<div class="call_bx">
									<html:selectList name='mbrMobile1' id='mbrMobile1'  selectedValue="010" optionValues='|010|011|016|017|018|019' optionNames='선택|010|011|016|017|018|019' script='class="pay_input_size07"'/>
									<div class="centerNum">
									<input type="text" id="mbrMobile2" name="mbrMobile2" class="validation[numberOnlyLeft,required]" title="연락가능번호" maxlength="4">
									</div>
									<input type="text" id="mbrMobile3" name="mbrMobile3" class="validation[numberOnlyLeft,required]" title="연락가능번호" maxlength="4">
								</div>
								<span>* 통화가 되지 않을 경우 예약이 취소될 수 있으니 전화번호를 정확하게 입력해주세요.</span>
							</td>
						</tr>
						<tr>
							<th scope="row" class="star"><label for="adrs">주소</label></th>
							<td>
								<div class="adrs_bx">
									<div class="post">
										<input type="text" name="mbrZipcode" id="mbrZipcode" maxlength="7" class="validation[required]" title="우편번호" readonly="readonly"/>
										<a href="javascript:;" id="addrBtn" class="btn01Type ml10">우편번호 찾기</a>
									</div>
									<input type="text" id="mbrAddr" name="mbrAddr" class="validation[required]" title="주소" readonly="readonly"/>
									<input type="text" id="mbrAddrDtl" name="mbrAddrDtl" />
								</div>
							</td>
						</tr>
						<tr>
							<th scope="row"><label for="file">첨부파일</label></th>
							<td>
								<div class="multi_file">
									<div class="file_add">

									</div>
									<div class="file_ex">
									<span>* 이미지 첨부만 가능.</span><span>0/50 MB<br/></span>
									<br/><br/>
									</div>
									<div class="file_lst">
									<c:forEach items="${fileList}" var="fileList" varStatus="status">
										<div class="file_lst_bx">
											<span class="input_txt" onclick="exDown('${fileList.attchCd}');"  style="cursor:pointer"><c:out value="${fileList.attchFileNm}" /></span>
<!-- 											<button class="btn_del"><span class="blind" >파일삭제</span></button> -->
										</div>
					          		</c:forEach>

									</div>


								</div><!-- fileUpload -->
								<dl class="img_file_guide">
									<dt>이미지 업로드 가이드</dt>
									<dd><p>품목별 업로드 가이드를 확인하세요.</p>
										<div class="rdi_bx_wrap">
											<div class="rdibox">
												<input type="radio" id="goods01" class="" name="info" value=""><i></i>
												<label for="goods01">비데</label>
											</div>
											<div class="rdibox">
												<input type="radio" id="goods02" class="" name="info" value=""><i></i>
												<label for="goods02">위생도기</label>
											</div>
											<div class="rdibox">
												<input type="radio" id="goods03" class="" name="info" value=""><i></i>
												<label for="goods03">수전</label>
											</div>
											<div class="rdibox">
												<input type="radio" id="goods04" class="" name="info" value=""><i></i>
												<label for="goods04">블렌더</label>
											</div>
											<div class="rdibox">
												<input type="radio" id="goods05" class="" name="info" value=""><i></i>
												<label for="goods05">이누스바스</label>
											</div>
										</div><!--// rdi_bx_wrap -->
										<div class="ex_img_bx">
											<span>예시)</span>
											<p>모델명이 기재된 컨트롤 사진과 비데 전체사진을 업로드해주세요.<br>(약 45˚각조에서 제품 전체가 보일것)</p>
										</div>
									</dd>
								</dl>
							</td>
						</tr>
					</tbody>
				</table>
			</div>
		</div>
		<div class="person_info_agree mt30">
			<span class="star">개인정보 수집 및 이용 동의</span>
			<p>약관내용노출</p>
			<span class="chkbox red mt10">
				<label class="label_txt"><input type="checkbox" value="" name="" id="" /><span class="txt">개인정보 수집 및 이용에 동의합니다.</span></label>
			</span>
		</div><!--// 동의 -->
		<div class="step_bx st03"><h3>예약 일정 입력<span>필수 입력사항</span></h3></div>
		<!--// step03 title -->
		<div class="rsv_wrap_bx">
			<div class="rsv_date_bx">
				<div class="top">
					<p class="tit">예약날짜 선택</p>
					<ul class="info_color">
						<li class="y">예약가능일</li>
						<li class="s">선택일</li>
					</ul>
				</div><!--// top -->
				<div class="body">
					<div class="ymd">
						<a href="javascript:;" id="btnPrev" class="prev">이전</a>
						<span id="currentDate"></span>
						<a href="javascript:;" id="btnNext" class="next">다음</a>
					</div>
					<div class="month" id="calendar">
					</div>
				</div><!--// body -->
				<div class="btm">선택일 : <span id="selectText" class="fc-blue">날짜를 선택하세요</span></div><!--// date_btm -->
			</div>
			<!--// rsv_date_bx -->
			<div class="rsv_time_bx">
				<div class="top">
					<p class="tit">예약시간 선택</p>
					<ul class="info_color">
						<li class="y">예약가능시간</li>
						<li class="s">선택시간</li>
					</ul>
				</div><!--// top -->
				<div class="body rsv">
					<dl class="am">
						<dt>오전</dt>
						<dd>
							<ul class="am_bx">
							<c:forEach items="${timeTableList}" var="timeTable" varStatus="status">
								<c:if test="${timeTable.csTimeTp eq 'AM'}">
									<li class="f" value="${timeTable.csTimeSeq}">${timeTable.csTimeValue}</li>
								</c:if>
							</c:forEach>
							</ul>
						</dd>
					</dl>
					<dl class="pm">
						<dt>오후</dt>
						<dd>
							<ul class="pm_bx">
								<c:forEach items="${timeTableList}" var="timeTable" varStatus="status">
									<c:if test="${timeTable.csTimeTp eq 'PM'}">
										<li class="f" value="${timeTable.csTimeSeq}">${timeTable.csTimeValue}</li>
									</c:if>
								</c:forEach>
							</ul>
						</dd>
					</dl>
				</div><!--// body -->
				<div class="btm">선택시간 : <span id="selectTimeText" class="fc-blue">시간을 선택하세요</span></div><!--// date_btm -->
			</div>
		</div>
		<!--// rsv_wrap_bx -->
		<p class="mark">선택하신 예약시간보다 전문상담사의 전화가 다소 늦어질 수 있습니다.</p>
		<div class="btnArea">
			<button type="button" id="okBtn" class="right">예약신청</button>
		</div>

	</div>
	<!--// sub -->
	<input type="hidden" name="bookingDt" id="bookingDt" class="validation[required]" title="예약날짜"/>
	<input type="hidden" name="csTimeSeq" id="csTimeSeq" class="validation[required]" title="예약시간"/>
	<input type="hidden" name="csType" id="csType" value="TEL" />
	</form>

</body>