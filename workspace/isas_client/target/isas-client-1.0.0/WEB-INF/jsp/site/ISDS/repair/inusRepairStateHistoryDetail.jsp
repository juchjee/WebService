<%@ page language="java" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<head>
	<style type="text/css">
		.access .input_box > input[type="button"] {width:29%;}
		.btn02Type, .btn03Type{height:100%}
	</style>
	<script type="text/javascript" defer="defer">
	<!--
		function init(){
			fnEvent();
			fnDataSetting();
		}

		function fnEvent(){

		}

		function fnDataSetting(){
			//var sum = ${repairStateView.repAmt}+${repairStateView.btAmt}+${repairStateView.insAmt}+${repairStateView.regAmt};
			var sum = ${repairStateView.repAmt == null ? 0 : repairStateView.repAmt }+${repairStateView.btAmt == null ? 0 : repairStateView.btAmt}+${repairStateView.insAmt == null ? 0 : repairStateView.insAmt}+${repairStateView.regAmt == null ? 0 : repairStateView.regAmt};

			if("${repairStateView.amtTyCd}" == "AS215100"){
				$("#custAmt").html(0);
				$("#tot").html(setComma(sum));
			}else{
				var tempCustAmt = ${repairStateView.custAmt == null ? 0 : repairStateView.custAmt};
				sum = sum + tempCustAmt;
				$("#custAmt").html(setComma(tempCustAmt));
				$("#tot").html(setComma(sum));
			}

			$("#repAmt").html(setComma("${repairStateView.repAmt}"));
			$("#btAmt").html(setComma("${repairStateView.btAmt}"));
			$("#insAmt").html(setComma("${repairStateView.insAmt}"));
			$("#regAmt").html(setComma("${repairStateView.regAmt}"));
		}
	//-->
	</script>
</head>
<body>
	<section class="sub cont">
		<div class="tit_bx">
			<a href="javascript:" onclick="window.history.go(-1); return false;" class="btn_prev">이전 화면</a>
			<h2>History내역 상세</h2>
		</div>
		<!--// tit_bx -->
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">A/S접수 현황</div>
				<dl class="situ2">
					<dt>접수번호</dt>
					<dd>${repairStateView.asNo}</dd>
				</dl>
				<dl class="situ2">
					<dt>접수일자</dt>
					<dd>${repairStateView.insDt}</dd>
				</dl>
				<dl class="situ2">
					<dt>고객명</dt>
					<dd>${repairStateView.tNm}</dd>
				</dl>
				<dl class="situ2">
					<dt>핸드폰번호</dt>
					<dd><div class="call"><a href="tel:${repairStateView.tHp}">${repairStateView.tHp}</a></div></dd>
				</dl>
				<dl class="situ2">
					<dt>주소</dt>
					<dd class="lheight">${repairStateView.tAddrNm}</dd>
				</dl>
				<dl class="situ2">
					<dt>제품</dt>
					<dd>${repairStateView.itmNm}<c:if test="${not empty repairStateView.modelItemCd}">(${repairStateView.modelItemCd})</c:if></dd>
				</dl>
				<dl class="situ2">
					<dt>품목코드/품목명</dt>
					<dd class="lheight">${repairStateView.itmId} / ${repairStateView.itmNm}</dd>
				</dl>
				<dl class="situ2">
					<dt>접수증상대분류</dt>
					<dd>${repairStateView.reBcNm}</dd>
				</dl>
				<dl class="situ2">
					<dt>접수증상중분류</dt>
					<dd>${repairStateView.re2BcNm}</dd>
				</dl>
				<dl class="situ2 bdn">
					<dt>증상상세</dt>
					<dd class="lheight">${repairStateView.reNm}</dd>
				</dl>
			</div>
		</div>
		<!--// ing_bx(A/S접수) -->
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">수리내역 현황</div>
				<dl class="situ2">
					<dt>처리일자</dt>
					<dd>${repairStateView.reqDt}</dd>
				</dl>
				<dl class="situ2">
					<dt>제조번호</dt>
					<dd>${repairStateView.lotNo}</dd>
				</dl>
				<dl class="situ2">
					<dt>구입년월</dt>
					<dd>${repairStateView.buyDt}</dd>
				</dl>
				<dl class="situ2">
					<dt>수리유형</dt>
					<dd>${repairStateView.asTy}</dd>
				</dl>
				<dl class="situ2">
					<dt>A/S 증상코드</dt>
					<dd>${repairStateView.as1Bc} &gt; ${repairStateView.as2Bc}</dd>
				</dl>
				<dl class="situ2">
					<dt>처리방법</dt>
					<dd>${repairStateView.actBc}</dd>
				</dl>
				<dl class="situ2">
					<dt>비용구분(유/무)</dt>
					<dd>${repairStateView.amtTy}</dd>
				</dl>
				<dl class="situ2">
					<dt>수리비</dt>
					<dd id="repAmt">${repairStateView.repAmt}</dd>
				</dl>
				<dl class="situ2">
					<dt>출장비</dt>
					<dd id="btAmt">${repairStateView.btAmt}</dd>
				</dl>
				<dl class="situ2">
					<dt>지역출장비</dt>
					<dd id="regAmt">${repairStateView.regAmt}</dd>
				</dl>
				<dl class="situ2">
					<dt>설치비</dt>
					<dd id="insAmt">${repairStateView.insAmt}</dd>
				</dl>
				<dl class="situ2">
					<dt>유상부품비</dt>
					<dd id="custAmt">0</dd>
				</dl>
				<dl class="situ2">
					<dt>합계</dt>
					<dd id="tot">0</dd>
				</dl>
				<dl class="situ2 bdn">
					<dt>기타</dt>
					<dd class="lheight">${repairStateView.rmks}</dd>
				</dl>
			</div>
		</div>
		<!--// ing_bx(수리내역) -->
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">자재등록 현황</div>
				<div class="tblType01 in">
					<table>
						<caption>자재등록 현황표</caption>
						<thead>
							<tr>
								<th scope="col" class="bunho">번호</th>
								<th scope="col" class="code">품목코드</th>
								<th scope="col" class="name">품목명</th>
								<th scope="col" class="unit">수량</th>
								<th scope="col" class="price">소비자가</th>
							</tr>
						</thead>
						<tbody>
						<c:forEach items="${repairPartList}" var="repairPart" varStatus="loop">
							<tr>
								<td class="bunho">${repairPart.sqNo}</td>
								<td class="code">ERP 프로세스</td>
								<td class="name">확인필요</td>
								<td class="unit">${repairPart.qty}</td>
								<td class="price">${repairPart.custAmt}</td>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
		<!--// ing_bx(자재등록) -->
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">사진등록</div>
				<div class="pd10">
					<div class="photo_bx">
						<c:forEach items="${fileList}" var="fileList" varStatus="status">
							<div class="file_add_img">
								<div class="photo" style="width:47%;height:125px;"><img src="${fileList.attchFilePath}"/></div>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
		<!--// ing_bx(사진등록) -->
		<div class="ing_bx view">
			<div class="box">
				<div class="tit">고객서명</div>
				<div class="pd10">
					<div class="sign_bx"><c:if test="${not empty asSign.asSign}"><img src="${asSign.asSign}" /></c:if></div>
				</div>
			</div>
		</div>
		<!--// ing_bx(고객서명) -->
	</section>
	<!--// sub -->
</body>