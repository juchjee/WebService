<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
	<script type="text/javascript">
	<!--
	//-->
	</script>
</head>
<body>
			<div id="container">
				<div class="why_section">
					<div class="svisb">
						<img src="${rootUri}common/images/why/etc1_vis1.jpg" alt="우리 가족 장 건강은 세계특허 듀오락, 프로바이오틱스, 단백질 코팅, 다당류 코팅" />
					</div>
					<div class="only_content">
						<dl class="only_tit">
							<dt>
								<img class="pt" src="${rootUri}common/images/why/etc1_tit1.png" alt="왜 Only One
								듀오락인가?" />
								<div class="hid_txt">왜 Only One 듀오락인가?</div>
							</dt>
							<dd>살아있는 유산균을 장까지 안전하게 </dd>
						</dl>
						<ul class="only_list">
							<li class="li1">
								<a href="#">
									<dl>
										<dt><img src="${rootUri}common/images/why/only_step1.png" alt="" /></dt>
										<dd>
											<p class="tit"><strong>세계특허 프로바이오틱스</strong></p>
											<ul class="con">
												<li><span>-</span>중요한 것은 유산균수가 아니라 장까지 살아가게 <br />만드는 코팅기술력</li>
												<li><span>-</span>듀오락은 세계특허 듀얼코팅기술로 세계에서 이미 <br />인정받고 있습니다.</li>
												<li><span>-</span>한국,미국,유럽,일본,중국 등 세계특허 취득</li>
											</ul>
										</dd>
									</dl>
								</a>
							</li>
							<li class="li2">
								<a href="#">
									<dl>
										<dt><img src="${rootUri}common/images/why/only_step2.png" alt="" /></dt>
										<dd>
											<p class="tit line2">안전성이 검증된 한국형  <br /><strong>프로바이오틱스</strong></p>
											<ul class="con">
												<li><span>-</span>한국인에게는 한국인 대상으로 안전성이 검증된 <br />유산균이 중요합니다.</li>
												<li><span>-</span>듀오락은 한국에서 얻은 검증된 유산균만을 <br />사용하였으며, 한국인 대상 다수의 인체시험 <br />특허를 보유하고 있습니다.</li>
											</ul>
										</dd>
									</dl>
								</a>
							</li>
						</ul>
						<ul class="only_list">
							<li class="li1">
								<a href="#">
									<dl>
										<dt><img src="${rootUri}common/images/why/only_step3.png" alt="" /></dt>
										<dd>
											<p class="tit"><strong>맞춤형 복합균주 구성</strong></p>
											<ul class="con">
												<li><span>-</span>듀오락만의 균주칵테일 기술로 한국인의 대장, <br />소장 속 환경과 균주의 성장속도까지 고려하며 <br />만듭니다.</li>
												<li><span>-</span>듀오락은 비피더스균 등 주요균주의 함량을 <br />소비자가 알기쉽게 표시하고 있습니다.</li>
											</ul>
										</dd>
									</dl>
								</a>
							</li>
							<li class="li2">
								<a href="#">
									<dl>
										<dt><img src="${rootUri}common/images/why/only_step4.png" alt="" /></dt>
										<dd>
											<p class="tit"><strong>원스탑 솔루션</strong></p>
											<ul class="con">
												<li><span>-</span>세계적인 기술력의 유산균 종균개발부터 <br />완제품생산, 고객만족 서비스까지 글로벌 <br />스탠다드 기준에 의해 엄격히 관리하며, 고객 <br />만족을 위해 최선을 다하고 있습니다.</li>
											</ul>
										</dd>
									</dl>
								</a>
							</li>
						</ul>
						<ul class="only_list last">
							<li class="li1">
								<a href="#">
									<dl>
										<dt><img src="${rootUri}common/images/why/only_step5.png" alt="" /></dt>
										<dd>
											<p class="tit">자랑스런 <strong>글로벌브랜드 듀오락</strong></p>
											<ul class="con">
												<li><span>-</span>유산균 종주국 덴마크를 비롯하여 전 세계 40여개 <br />국가에 수출되고 있는 자랑스런 글로벌 브랜드 <br />(수출 1위*)</li>
												<li><span>-</span>2017 한국 무역의 날 기념 2000만불 수출탑 수상 <br />(쎌바이오텍)</li>
												<li class="fr"><span>※</span> 2014년 기준, 2015년 식품의약품통계연보 및 <br />   한국무역협회 자료 기준</li>
											</ul>
										</dd>
									</dl>
								</a>
							</li>
						</ul>
					</div>
				</div>
				<!-- // why_section -->
			</div>

			<script type="text/javascript">
			$('.only_list > li.li1').each(function(){
				var d1 = $(this).find('dl'),
					 d2 = $(this).next().find('dl');
				if(d1 >= d2){
					d2.css('height', d1.height());
				}else{
					d1.css('height', d2.height());
				}
			});
			$(window).resize(function(){
				$('.only_list > li.li1').each(function(){
					var d1 = $(this).find('dl'),
						 d2 = $(this).next().find('dl');
					if(d1 >= d2){
						d2.css('height', d1.height());
					}else{
						d1.css('height', d2.height());
					}
				});
			});
			</script>
</body>