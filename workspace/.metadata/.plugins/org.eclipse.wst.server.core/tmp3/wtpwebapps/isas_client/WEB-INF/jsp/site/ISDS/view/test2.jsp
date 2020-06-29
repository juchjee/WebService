<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>

	<script type="text/javascript">
	
	<!--
	
	var that = this;   
	var m_oMonth = new Date();
	var todayDate = parseInt(m_oMonth.getDate());
	var todayYear = parseInt(m_oMonth.getFullYear());
	var todayMonth = parseInt(m_oMonth.getMonth()+1);
	
	m_oMonth.setDate(1);
	
	$(document).ready(function() {
	
		printCalendar();
		
	});
	
	function init(){
		var seq = $("#boardCateSeq").val();
		if(seq==""){
			$("#col1").addClass("on");
		}
		else{
			$("#col"+seq).addClass("on");
		}
	}

	function noticeCate(code){
		$("#page").val(1);
		$("#boardCateSeq").val(code);
		document.faqForm.action = "bbt00004.do?pageCd=${boardMstCd}";
		document.faqForm.submit();
	}

	function noticeView(seq){
		$("#boardSeq").val(seq);
		document.faqForm.action = "bbt00004V.do?pageCd=${boardMstCd}";
	   	document.faqForm.submit();
	}

	function doPage(pageNum){
		document.faqForm.page.value = pageNum;
    	document.faqForm.action = "bbt00004.do?pageCd=${boardMstCd}";
       	document.faqForm.submit();
	}

	//태그 문자열을 디코딩 한다
	function decodeTag(str){
		return str && str.replace(/&quot;/g,"\"").replace(/&lt;/g,"<").replace(/&gt;/g,">").replace(/&nbsp;/g," ").replace(/&amp;/g,"&");
	}

	function spanText(day){
		$('.rsv td').removeClass('s');
		$("#"+day).addClass("s");
		
		var spanMonth = m_oMonth.getMonth()+1;
		if(spanMonth < 10){
			spanMonth = '0' + spanMonth;
		}
		var spanDay = $("#year").val()+"-"+spanMonth+"-"+day
		$("#selectText").text(spanDay);
	}
	
	function printCalendar() {
	
		this.init = function() {
			that.renderCalendar();
			that.initEvent();
		}
	
	    /* 달력 UI 생성 */
		this.renderCalendar = function() {
			    	
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
	            	
					if(i % 7 == 0 || i % 7 == 6){  //주말제외 
						arrTable.push('<td id="'+dayValue+'" class="'+sClass+'">' + oStartDt.getDate() + '</td>');
					}else if(todayYear < $("#year").val()){
						arrTable.push('<td id="'+dayValue+'" class="y" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '</td>');
					}else if(todayYear == $("#year").val() && todayMonth < joinMonth){
						arrTable.push('<td id="'+dayValue+'" class="y" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '</td>');
					}else if(todayYear == $("#year").val() && todayMonth == joinMonth){
						if(todayDate < oStartDt.getDate()){
							arrTable.push('<td id="'+dayValue+'" class="y" onclick="spanText('+oStartDt.getDate()+')"">' + oStartDt.getDate() + '</td>');
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
			that.changeMonth();
		}
		
		/* Next, Prev 버튼 이벤트 */
		this.initEvent = function() {
			$('#btnPrev').click(that.onPrevCalendar);
			$('#btnNext').click(that.onNextCalendar);
		}
		
	    /* 이전 달력 */
		this.onPrevCalendar = function() {
			m_oMonth.setMonth(m_oMonth.getMonth() - 1);
			var spanMonth = m_oMonth.getMonth()+1;
			if(spanMonth < 10){
				spanMonth = '0' + spanMonth;
			}
			$("#month").val(spanMonth);
			
			if($("#month").val() > 11){
				$("#year").val(m_oMonth.getFullYear());
			}
			
			var postData = $("#calendarFrm").serializeArray();
			
			$.ajax({
			    url : "/ISDS/view/calendar.action",
			    type: "POST",
			    data : postData,
			    success:function(data, textStatus, jqXHR)
			    {
			    	that.renderCalendar();
			    },
			    error: function(jqXHR, textStatus, errorThrown)
			    {
			    	alert("통신에 실패 하였습니다. 관리자에게 문의해 주세요.");
			    }
			}); // ajax
		}
	
	    /* 다음 달력 */
		this.onNextCalendar = function() {
			m_oMonth.setMonth(m_oMonth.getMonth() + 1);
			
			var spanMonth = m_oMonth.getMonth()+1;
			if(spanMonth < 10){
				spanMonth = '0' + spanMonth;
			}
			$("#month").val(spanMonth);
			
			if($("#month").val() < 2){
				$("#year").val(m_oMonth.getFullYear());
			}
			
			var postData = $("#calendarFrm").serializeArray();
			$.ajax({
				url : "/ISDS/view/calendar.action",
			    type: "POST",
			    data : postData,
			    success:function(data, textStatus, jqXHR)
			    {
					that.renderCalendar();
			    	for (key in data) {
			    		$("#"+data[key].workDd).removeAttr("onclick");
			    		$("#"+data[key].workDd).removeClass("y");
					}
			    },
			    error: function(jqXHR, textStatus, errorThrown)
			    {
			    	alert("통신에 실패 하였습니다. 관리자에게 문의해 주세요.");
			    }
			}); // ajax
			
		}
	
	    /* 달력 이동되면 상단에 현재 년 월 다시 표시 */
		this.changeMonth = function() {
			$('#currentDate').text(that.getYearMonth(m_oMonth).substr(0,9));
		}
	
	    /* 날짜 객체를 년 월 문자 형식으로 변환 */
		this.getYearMonth = function(oDate) {
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
		<input type="hidden" id="year" name="year"/>
		<input type="hidden" id="month" name="month"/>
	</form>
	
	<div class="sub">
		<div class="box_guide">
			<h2 class="tit">출장서비스 예약</h2>
			<div class="txt_bx">
				<p class="mark">출장서비스를 예약하시면 전문 엔지니어가 확인 후 전화 드리겠습니다.</p>
				<p>출장날짜와 시간은 담당 엔지니어를 통해 조정 가능합니다.<br>원활한 출장서비스를 위해 상담사와 통화 후 출장서비스를 진행 할 수 있습니다.<br>전화상담 예약을 원하실 경우 [홈 > 서비스 예약 > 전화상담] 메뉴를 이용해주시기 바랍니다.</p>
				<a href="view.do?pageCd=test3" class="svn btn01Type">서비스요금 안내</a>
			</div>
	
			<div class="page_location">
				<ul>
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">서비스예약</a></li>
					<li class="last"><a href="#">출장서비스 예약</a></li>
				</ul>
			</div>
		</div>
		<!--// box_guide -->
		<div class="guide_btn_list">
			<a href="#" class="fap"><strong class="hv">자주하는 질문</strong><span>유사한 증상 찾아보기</span></a>
			<a href="#" class="mtd"><strong class="hv">간단 조치 방법</strong><span>제품별 간단 조치 방법</span></a>
			<a href="#" class="mvi"><strong class="hv">동영상 가이드</strong><span>쉽고 간단한 영상 조치방법</span></a>
		</div>
		<!--// guide_btn_list -->
		<div class="step_bx st01"><h3>제품 증상 선택<span>필수 입력사항</span></h3></div>
		<!--// step01 title -->
		<div class="list_goods">
			<a href="#none" class="gd01 active">비데</a>
			<a href="#none" class="gd02">위생도기</a>
			<a href="#none" class="gd03">수전</a>
			<a href="#none" class="gd04">블렌더</a>
			<a href="#none" class="gd05 last">이누스바스</a>
		</div>
		<!--// 탭메뉴 리스트 -->
		<div class="tblType01 mt30">
			<table>
				<caption>제품선택,고장증상 작성</caption>
				<tbody>
					<tr>
						<th scope="row" class="star"><label for="model">모델선택</label></th>
						<td>
							<div class="select_bx">
								<select name="" id="model">
									<option selected="selected">선택</option>
									<option value="">부품결함</option>
									<option value="">부품결함</option>
									<option value="">부품결함</option>
									<option value="">부품결함</option>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="sct01">고장증상</label></th>
						<td>
							<div class="select_bx">
								<select name="" id="sct01" class="mr10">
									<option selected="selected">선택</option>
									<option value="">부품결함</option>
									<option value="">부품결함</option>
									<option value="">부품결함</option>
									<option value="">부품결함</option>
								</select>
								<select name="" id="sct02">
									<option selected="selected">선택</option>
									<option value="">부품결함</option>
									<option value="">부품결함</option>
									<option value="">부품결함</option>
									<option value="">부품결함</option>
								</select>
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="txtArea">고장증상 상세</label></th>
						<td>
							<div class="txtArea pb10">
								<textarea id="txtArea" name="trouble" value="">고장증상에 대한 상세내용을 입력하시면 더욱 신속히 처리해 드리겠습니다.<br>예) 비데 불이 깜빡거려요</textarea>
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
							<div class="input_bx"><input type="text" id="" value="" name=""></div>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="call">연락가능번호</label></th>
						<td>
							<div class="call_bx">
								<select name="" id="call">
									<option selected="selected">전국번호</option>
									<option value="">02</option>
									<option value="">031</option>
									<option value="">000</option>
									<option value="">555</option>
								</select>
								<div class="centerNum">
									<input type="text" id="" value="" name="">
								</div>
								<input type="text" id="" value="" name="">
							</div>
							<span>* 통화가 되지 않을 경우 예약이 취소될 수 있으니 전화번호를 정확하게 입력해주세요.</span>
						</td>
					</tr>
					<tr>
						<th scope="row" class="star"><label for="adrs">주소</label></th>
						<td>
							<div class="adrs_bx">
								<div class="post">
									<input type="text" id="" name="" class="">
									<a href="#" class="btn01Type ml10">우편번호 찾기</a>
								</div>
								<input type="text" id="" name="" class="">
								<input type="text" id="" name="" class="">
							</div>
						</td>
					</tr>
					<tr>
						<th scope="row"><label for="file">첨부파일</label></th>
						<td>
							<div class="multi_file">
								<div class="file_add">
									<input type="text" name="#" class="input_txt1"/>
									<input type="file" name="#" class="input_file"/>
									<span class="btn01Type">파일찾기</span><br>
								</div>
								<div class="file_ex">
								<span>* 이미지 첨부만 가능.</span><span>0/50 MB</span>
								</div>
								<div class="file_lst">
								    <div class="file_lst_bx">
										<!-- <div class="view_img_bx"></div> -->
										<span class="input_txt">&nbsp;</span>
										<button class="btn_del"><span class="blind">파일삭제</span></button>
									</div>
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
		<div class="person_info_agree mt30">
			<span class="star">개인정보 수집 및 이용 동의</span>
			<p>약관내용노출</p>
			<div class="chkbox mt10">
				<input type="checkbox" id="psnAgree" name="psnAgree1" class="" title=""><i class="checked"></i>
				<label for="psnAgree">개인정보 수집 및 이용에 동의합니다.</label>
			</div>
		</div><!--// 동의 -->
		<div class="step_bx st03"><h3>예약 일정 입력<span>필수 입력사항</span></h3></div>
		<!--// step03 title -->
		<div class="rsv_wrap_bx">
			<div class="rsv_date_bx w100">
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
				
				
				<div class="btm">선택일 : <span id="selectText" class="fc-blue"></span></div><!--// date_btm -->
			</div>
			<!--// rsv_date_bx -->
		</div>
		<!--// rsv_wrap_bx -->
		<p class="mark">전문 엔지니어가 확인 후 전화 드리겠습니다.</p>
		<div class="btnArea">
			<button class="left">예약취소</button>
			<button class="right">예약신청</button>
		</div>
	
	</div>

</body>