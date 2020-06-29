<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib  prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="html" uri="/WEB-INF/tld/html.tld"  %>

<head>
	<script type="text/javascript">
	<!--

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

	//-->
	</script>
</head>
<body>
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
					<li><a href="#"><span class="home"><span class="hidden">home</span></span></a></li>
					<li><a href="#">서비스예약</a></li>
					<li class="last"><a href="#">전화상담 예약</a></li>
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
			<a href="#" class="gd01 active">비데</a>
			<a href="#" class="gd02">위생도기</a>
			<a href="#" class="gd03">수전</a>
			<a href="#" class="gd04">블렌더</a>
			<a href="#" class="gd05 last">이누스바스</a>
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
						<a href="#" class="prev">이전</a>
						<span>2017.07</span>
						<a href="#" class="next">다음</a>
					</div>
					<div class="month">
						<table class="rsv">
							<caption>달력</caption>
							<thead>
								<tr>
									<th scope="col">일</th>
									<th scope="col">월</th>
									<th scope="col">화</th>
									<th scope="col">수</th>
									<th scope="col">목</th>
									<th scope="col">금</th>
									<th scope="col">토</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td class="sun"></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td class="sat">1</td>
								</tr>
								<tr>
									<td class="sun">2</td>
									<td>3</td>
									<td>4</td>
									<td>5</td>
									<td>6</td>
									<td>7</td>
									<td class="sat">8</td>
								</tr>
								<tr>
									<td class="sun">9</td>
									<td>10</td>
									<td class="s">11</td>
									<td>12</td>
									<td>13</td>
									<td>14</td>
									<td class="sat">15</td>
								</tr>
								<tr>
									<td class="sun">16</td>
									<td>17</td>
									<td>18</td>
									<td>19</td>
									<td>20</td>
									<td>21</td>
									<td class="sat">22</td>
								</tr>
								<tr>
									<td class="sun">23</td>
									<td>24</td>
									<td>25</td>
									<td>26</td>
									<td>27</td>
									<td>28</td>
									<td class="sat">29</td>
								</tr>
								<tr>
									<td class="sun">30</td>
									<td>31</td>
									<td></td>
									<td></td>
									<td></td>
									<td></td>
									<td class="sat"></td>
								</tr>
							</tbody>
						</table>
					</div>
				</div><!--// body -->
				<div class="btm">선택일 : <span class="fc-blue">2017-07-11</span></div><!--// date_btm -->
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
								<li><a href="#">09:00 ~ 09:30</a></li>
								<li><a href="#">09:30 ~ 10:00</a></li>
								<li><a href="#">10:00 ~ 10:30</a></li>
								<li><a href="#">10:30 ~ 11:00</a></li>
								<li><a href="#">11:00 ~ 11:30</a></li>
								<li><a href="#">11:30 ~ 12:00</a></li>
							</ul>
						</dd>
					</dl>
					<dl class="pm">
						<dt>오후</dt>
						<dd>
							<ul class="pm_bx">
								<li class="s"><a href="#">13:00 ~ 13:30</a></li>
								<li><a href="#">13:30 ~ 14:00</a></li>
								<li><a href="#">14:00 ~ 14:30</a></li>
								<li><a href="#">14:30 ~ 15:00</a></li>
								<li><a href="#">15:00 ~ 15:30</a></li>
								<li><a href="#">15:30 ~ 16:00</a></li>
								<li><a href="#">16:00 ~ 16:30</a></li>
								<li><a href="#">16:30 ~ 17:00</a></li>
								<li><a href="#">17:00 ~ 17:30</a></li>
								<li><a href="#">17:30 ~ 18:00</a></li>
							</ul>
						</dd>
					</dl>
				</div><!--// body -->
				<div class="btm">선택시간 : <span class="fc-blue">13:00 ~ 13:30</span></div><!--// date_btm -->
			</div>
		</div>
		<!--// rsv_wrap_bx -->
		<p class="mark">선택하신 예약시간보다 전문상담사의 전화가 다소 늦어질 수 있습니다.</p>
		<div class="btnArea">
			<button class="left">예약취소</button>
			<button class="right">예약신청</button>
		</div>

	</div>
	<!--// sub -->

</body>