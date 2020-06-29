<%@ page language="java" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<script type="text/javascript">
function init(){
}

function goTab(uri){
	if("${mbrId}"){
		var popUrl = uri;
		$("#popUrl").val(uri);
		$("#frmCsInfo").attr("action", popUrl);
		$("#frmCsInfo").submit();
	}else{
		alert("회원을 선택 하셔야 사용 가능 합니다.");
	}
}


</script>
<div class="top_info">
	<div>
		<dl>
			<dt>고객정보</dt>
			<dd style="margin-right: 10px;">
				<p class="user">${mbrNm}</p>
			</dd>
		</dl>
	</div>
</div>
<!-- // top_info -->
<div class="gnb">
	<ul>
		<li>
			<a href="javascript:;" onclick="javascript:goTab('amM1021.pop');return false;">회원 종합 정보</a>
		</li>
		<li>
			<a href="javascript:;" onclick="javascript:goTab('amM1022.pop');return false;">회원정보수정</a>
		</li>
		<li>
			<a href="javascript:;" onclick="javascript:goTab('amM1029.pop');return false;">1:1문의</a>
		</li>
	</ul>
</div>
<!-- // gnb -->