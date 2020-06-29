package site.front.mm.service;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;

public class MmStatic implements IConstants{

	private static String sPlainDataEnd = null;

	/**
	 * @return the reurl
	 */
	public static String getJoinUrl(int index) {
		if(index == 1){
			return "join";
		}else if(index == 2){
			return "joinEnd";
		}else if(index == 3){
			return "joinTerms";
		}else{
			return "joinClause";
		}
	}

	public static String getMsg(int iReturn){
		String sMessage;
		if( iReturn == -1){
	        sMessage = "복호화 시스템 에러입니다.";
		}else if( iReturn == -2){
	        sMessage = "암호화 처리오류입니다.";
		}else if( iReturn == -3){
	        sMessage = "암호화 데이터 오류입니다.";
	    }else if( iReturn == -4){
	        sMessage = "복호화 처리오류입니다.";
	    }else if( iReturn == -5){
	        sMessage = "복호화 해쉬 오류입니다.";
	    }else if( iReturn == -6){
	        sMessage = "복호화 데이터 오류입니다.";
	    }else if( iReturn == -9){
	        sMessage = "입력 데이터 오류입니다.";
	    }else if( iReturn == -12){
	        sMessage = "사이트 패스워드 오류입니다.";
	    }else{
	        sMessage = "알수 없는 에러 입니다. ERROR CODE : " + iReturn;
	    }
		return sMessage;
	}

	public static String getIPINMsg(int iRtn){
		String sRtnMsg;
		if (iRtn == -1 || iRtn == -2 || iRtn == -4){
			sRtnMsg = "배포해 드린 서비스 모듈 중, 귀사 서버환경에 맞는 모듈을 이용해 주시기 바랍니다.\n귀사 서버환경에 맞는 모듈이 없다면 ..\n iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.";
		}else if (iRtn == -6){
			sRtnMsg = "당사는 한글 charset 정보를 euc-kr로 처리하고 있으니, euc-kr에 대해서 허용해 주시기 바랍니다.\n한글 charset 정보가 명확하다면 ..\n iRtn 값, 서버 환경정보를 정확히 확인하여 메일로 요청해 주시기 바랍니다.";
		}else if (iRtn == -9){
			sRtnMsg = "입력값 오류 : fnRequest 함수 처리시, 필요한 4개의 파라미터값의 정보를 정확하게 입력해 주시기 바랍니다.";
		}else if (iRtn == -12){
			sRtnMsg = "CP 비밀번호 불일치 : IPIN 서비스 사이트 패스워드를 확인해 주시기 바랍니다.";
		}else if (iRtn == -13){
			sRtnMsg = "CP 요청번호 불일치 : 세션에 넣은 sCPRequest 데이타를 확인해 주시기 바랍니다.";
		}else{
			sRtnMsg = "iRtn 값 확인 후, NICE평가정보 개발 담당자에게 문의해 주세요.";
		}
		return sRtnMsg;
	}

	public static String getSPlainData(String conUrl, String checkPlusSiteCode, boolean isMobile){
		if(sPlainDataEnd == null){
	    	String sAuthType = "M";      	// 없으면 기본 선택화면, M: 핸드폰, C: 신용카드, X: 공인인증서
		   	String popgubun 	= "Y";		//Y : 취소버튼 있음 / N : 취소버튼 없음
		    // CheckPlus(본인인증) 처리 후, 결과 데이타를 리턴 받기위해 다음예제와 같이 http부터 입력합니다.
		    String sReturnUrl = ROOT_URI + conUrl + "checkPlusSuccess.action";      // 성공시 이동될 URL
		    String sErrorUrl = ROOT_URI + conUrl + "checkPlusFail.action";          // 실패시 이동될 URL
	    	sPlainDataEnd = "9:AUTH_TYPE" + sAuthType.getBytes().length + ":" + sAuthType +
                    "7:RTN_URL" + sReturnUrl.getBytes().length + ":" + sReturnUrl +
                    "7:ERR_URL" + sErrorUrl.getBytes().length + ":" + sErrorUrl +
                    "11:POPUP_GUBUN" + popgubun.getBytes().length + ":" + popgubun;
	    }
		String customize 	= "";		//없으면 기본 웹페이지 / Mobile : 모바일페이지
		if(isMobile){
			customize = "Mobile";
		}
		return "8:SITECODE" + checkPlusSiteCode.getBytes().length + ":" + checkPlusSiteCode
				+ sPlainDataEnd + "9:CUSTOMIZE" + customize.getBytes().length + ":" + customize;
	}

	public static String getIpinReturnURL(String conUrl){
		return ROOT_URI + conUrl + "checkIpinProcess.action";
	}

	public static String requestReplace(Object paramValue, String gubun) {
		return requestReplace(CommonUtil.nvl(paramValue), gubun);
	}

	public static String requestReplace(String paramValue, String gubun) {
        String result = "";
        if (paramValue != null) {
        	paramValue = paramValue.replaceAll("<", "&lt;").replaceAll(">", "&gt;");
        	paramValue = paramValue.replaceAll("\\*", "");
        	paramValue = paramValue.replaceAll("\\?", "");
        	paramValue = paramValue.replaceAll("\\[", "");
        	paramValue = paramValue.replaceAll("\\{", "");
        	paramValue = paramValue.replaceAll("\\(", "");
        	paramValue = paramValue.replaceAll("\\)", "");
        	paramValue = paramValue.replaceAll("\\^", "");
        	paramValue = paramValue.replaceAll("\\$", "");
        	paramValue = paramValue.replaceAll("'", "");
        	paramValue = paramValue.replaceAll("@", "");
        	paramValue = paramValue.replaceAll("%", "");
        	paramValue = paramValue.replaceAll(";", "");
        	paramValue = paramValue.replaceAll(":", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll("#", "");
        	paramValue = paramValue.replaceAll("--", "");
        	paramValue = paramValue.replaceAll("-", "");
        	paramValue = paramValue.replaceAll(",", "");
        	if(gubun != "encodeData"){
        		paramValue = paramValue.replaceAll("\\+", "");
        		paramValue = paramValue.replaceAll("/", "");
        		paramValue = paramValue.replaceAll("=", "");
        	}
        	result = paramValue;
        }
        return result;
	}
}
