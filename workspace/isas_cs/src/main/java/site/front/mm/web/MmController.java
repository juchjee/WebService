package site.front.mm.web;

import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import Kisinfo.Check.IPINClient;
import NiceID.Check.CPClient;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.EgovFileScrty;
import egovframework.cmmn.vo.LoginVO;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.front.mm.service.MmStatic;
import site.front.mm.service.impl.MmService;
import site.front.user.service.impl.UserService;

@Controller
@RequestMapping(value = IConstants.ISDS_URL + "mm") /* ISDS/mm/ */
public class MmController extends BaseController {

	private static final String conUrl = ISDS_URL + "mm/";

	/** MmService */
	@Resource(name = "MmService")
	private MmService mmService;

	/** UserService */
	@Resource(name = "UserService")
	private UserService userService;

	/** SmsService */
	/*@Resource(name = "SmsService")
	private SmsService smsService;*/

	/**
	 * 로그인 화면으로 들어간다
	 * 
	 * @param vo
	 *        - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "acessLogin.do")
	public String loginUsrView(@RequestParam MultiValueMap<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {

		String uri = "";

		if (isLogIn()) {

			if (CommonUtil.isMobile(request)) {
				return messageRedirect("", MAIN_PAGE, model);
			}
			else {
				return "redirect:" + ROOT_URI + MAIN_PAGE;
			}

		}
		else {
			init(model);
			model.addAttribute("notForwardHistory", true);
			String mbrId = CommonUtil.nvl(CommonUtil.getCookieValue(request, "mbrId"));
			if (!"".equals(mbrId)) {
				model.addAttribute("mbrId", mbrId);
			}
			String mbrPA = CommonUtil.nvl(CommonUtil.getCookieValue(request, "mbrPA"));
			if (!"".equals(mbrPA)) {
				model.addAttribute("mbrPA", mbrPA);
			}
			model.addAttribute("conUrl", ROOT_URI + conUrl);
			model.addAttribute("actionLoginUri", ROOT_URI + conUrl + "actionLogin.action");
			model.put("actionGuestLoginUri", ROOT_URI + conUrl + "actionGuestLogin.action");

			if (CommonUtil.isMobile(request)) {
				uri = "acessLogin_m";
			}
			else {
				uri = "acessLogin";
			}

			return conUrl + uri;
		}
	}

	/**
	 * 로그인
	 * 
	 * @param vo
	 *        - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request
	 *        - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value = "actionLogin.action")
	public String actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		init(model);
		EgovUserDetailsHelper.removeAttribute("nonLogin");
		model.addAttribute("notForwardHistory", true);
		String loginMsg = null;
		if (loginVO != null && loginVO.getMbrId() != null && !loginVO.getMbrId().equals("")) {
			if ("on".equals(loginVO.getSaveIdCookie())) {
				CommonUtil.setCookie(response, "mbrId", loginVO.getMbrId(), 60 * 60 * 24 * 30);
			}
			else {
				CommonUtil.removeCookie(request, response, "mbrId");
			}
			if ("on".equals(loginVO.getAutoLoginCookie())) {
				CommonUtil.setCookie(response, "mbrPA", "-1");
			}
			else {
				CommonUtil.removeCookie(request, response, "mbrPA");
			}

			LoginVO resultVO = mmService.actionLogin(loginVO);

			loginMsg = loginProc(loginVO, resultVO, request, response, model);
		}
		if ("".equals(loginMsg)) {
			return messageRedirect(egovMessageSource.getMessage("fail.common.login"), LOGIN_PAGE, model);
		}
		else {
			return loginMsg;
		}
	}

	/**
	 * 로그인
	 * 
	 * @param vo
	 *        - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request
	 *        - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value = "actionLoginAjax.action")
	public String actionLoginAjax(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		init(model);
		model.addAttribute("notForwardHistory", true);
		CamelMap<String, String> loginMsg = null;
		if (loginVO != null && loginVO.getMbrId() != null && !loginVO.getMbrId().equals("")) {
			if ("on".equals(loginVO.getSaveIdCookie())) {
				CommonUtil.setCookie(response, "mbrId", loginVO.getMbrId(), 60 * 60 * 24 * 30);
			}
			else {
				CommonUtil.removeCookie(request, response, "mbrId");
			}
			LoginVO resultVO = mmService.actionLogin(loginVO);
			loginMsg = loginProcAjax(loginVO, resultVO, request, response, model);
			model.addAttribute("outData", CommonUtil.mapToJsonString(loginMsg));
		}
		if ("".equals(loginMsg)) {
			return messageRedirect(egovMessageSource.getMessage("fail.common.login"), LOGIN_PAGE, model);
		}
		else {

			return "common/out";
		}
	}

	/**
	 * 로그인
	 * 
	 * @param vo
	 *        - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request
	 *        - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value = "autoLoginChk.action")
	public String autoLoginChk(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		init(model);
		model.addAttribute("notForwardHistory", true);
		CamelMap<String, String> loginMsg = null;
		if (loginVO != null && loginVO.getMbrId() != null && !loginVO.getMbrId().equals("")) {
			if ("on".equals(loginVO.getSaveIdCookie())) {
				CommonUtil.setCookie(response, "mbrId", loginVO.getMbrId(), 60 * 60 * 24 * 30);
			}
			else {
				CommonUtil.removeCookie(request, response, "mbrId");
			}
			LoginVO resultVO = mmService.actionLogin(loginVO);
			loginMsg = loginProcAjax(loginVO, resultVO, request, response, model);
			model.addAttribute("outData", CommonUtil.mapToJsonString(loginMsg));
		}
		if ("".equals(loginMsg)) {
			return messageRedirect(egovMessageSource.getMessage("fail.common.login"), LOGIN_PAGE, model);
		}
		else {

			return "common/out";
		}
	}

	/**
	 * 로그인을 처리한다
	 * 
	 * @param loginVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private String loginProc(LoginVO loginVO, LoginVO resultVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		if (resultVO.getMbrId() != null && !resultVO.getMbrId().equals("")) {
			//MBR_LOGIN_STATUS_YHN 회원상태(Y- 정상 H-홀드 N-탈퇴)
			String mbrLoginStatusYhn = resultVO.getMbrLoginStatusYhn();
			if ("Y".equals(mbrLoginStatusYhn)) {//회원 상태가 정상
				if (loginVO.getMbrPw().equals(resultVO.getMbrPw())) {// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.

					resultVO.setMbrLoginIp(request.getRemoteAddr());
					// 2-1. 로그인 정보를 세션에 저장
					request.getSession().setAttribute("loginVO", resultVO);
					// 2-2. 로그인 히스토리 저장
					String commTableNm = "ASW_M_MBR_LOGIN_HIS";
					UnCamelMap<String, Object> hisMap = new UnCamelMap<>(CommonUtil.converObjectToMap(resultVO));
					Map<String, Object> matchingColumName = new HashMap<String, Object>();
					matchingColumName.put("MBR_LOGIN_DT", "$idate");
					commService.tableInatall(commTableNm, hisMap, matchingColumName);
					Map<String, Object> loginParams = (Map<String, Object>) EgovUserDetailsHelper.getAttribute("loginParams");

					if (loginParams == null) {
						return messageRedirect("", MAIN_PAGE, model);
					}
					else {
						String referUrl = CommonUtil.getWebUrl(CommonUtil.objectToString(loginParams.get("referUrl")));
						if ("".equals(referUrl)) {
							return messageRedirect("", MAIN_PAGE, model);
						}
						else {
							JSONObject loginObject = new JSONObject(loginParams);
							model.addAttribute("dataMap", loginObject.toString());
							// 페이지 코드
							String pageCd = CommonUtil.getStrArrToFirstStr(CommonUtil.objectToString(loginParams.get("pageCd")));
							if (!"".equals(pageCd) && referUrl.indexOf("?") == -1) {
								referUrl += "?pageCd=" + pageCd;
							}
							EgovUserDetailsHelper.removeAttribute("loginParams");
							return messageRedirect("", ISDS_URL + referUrl, model);
						}
					}

				}
			}
			else if ("H".equals(mbrLoginStatusYhn)) {//회원 상태가 홀드
				EgovUserDetailsHelper.setAttributeString("mbrId", resultVO.getMbrId());
				return messageRedirect(egovMessageSource.getMessage("fail.user.lockLogin") + "\n" + egovMessageSource.getMessage("common.user.unLockLogin.msg"), conUrl + "unLockLogin.do", model);
			}
		}
		return messageRedirect(egovMessageSource.getMessage("fail.common.login"), LOGIN_PAGE, model);
	}

	/**
	 * 로그인을 처리한다
	 * 
	 * @param loginVO
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	private CamelMap<String, String> loginProcAjax(LoginVO loginVO, LoginVO resultVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		CamelMap<String, String> returnMap = new CamelMap<String, String>();
		if (resultVO.getMbrId() != null && !resultVO.getMbrId().equals("")) {
			//MBR_LOGIN_STATUS_YHN 회원상태(Y- 정상 H-홀드 N-탈퇴)
			String mbrLoginStatusYhn = resultVO.getMbrLoginStatusYhn();
			if ("Y".equals(mbrLoginStatusYhn)) {//회원 상태가 정상
				if (loginVO.getMbrPw().equals(resultVO.getMbrPw())) {// 2. 아이디와 암호화된 비밀번호가 DB와 일치하는지 확인한다.

					resultVO.setMbrLoginIp(request.getRemoteAddr());
					// 2-1. 로그인 정보를 세션에 저장
					request.getSession().setAttribute("loginVO", resultVO);
					// 2-2. 로그인 히스토리 저장
					String commTableNm = "ASW_M_MBR_LOGIN_HIS";
					UnCamelMap<String, Object> hisMap = new UnCamelMap<>(CommonUtil.converObjectToMap(resultVO));
					Map<String, Object> matchingColumName = new HashMap<String, Object>();
					matchingColumName.put("MBR_LOGIN_DT", "$idate");
					commService.tableInatall(commTableNm, hisMap, matchingColumName);
					Map<String, Object> loginParams = (Map<String, Object>) EgovUserDetailsHelper.getAttribute("loginParams");

					if (loginParams == null) {
						returnMap.put("status", "ng");
						returnMap.put("msg", "입력이 잘못되었습니다.");
						return returnMap;
					}
					else {
						String referUrl = CommonUtil.getWebUrl(CommonUtil.objectToString(loginParams.get("referUrl")));
						if ("".equals(referUrl)) {
							returnMap.put("status", "ng");
							returnMap.put("msg", "입력이 잘못되었습니다.");
							return returnMap;
						}
						else {
							JSONObject loginObject = new JSONObject(loginParams);
							model.addAttribute("dataMap", loginObject.toString());
							// 페이지 코드
							String pageCd = CommonUtil.getStrArrToFirstStr(CommonUtil.objectToString(loginParams.get("pageCd")));
							if (!"".equals(pageCd) && referUrl.indexOf("?") == -1) {
								referUrl += "?pageCd=" + pageCd;
							}
							returnMap.put("MBR_NM", resultVO.getMbrNm());
							returnMap.put("MBR_ZIPCODE", resultVO.getMbrZipcode());
							returnMap.put("MBR_ADDR", resultVO.getMbrAddr());
							returnMap.put("MBR_ADDR_DTL", resultVO.getMbrAddrDtl());
							returnMap.put("MBR_MOBILE", resultVO.getMbrMobile());
							returnMap.put("status", "ok");

							EgovUserDetailsHelper.removeAttribute("loginParams");
							return returnMap;
						}
					}

				}
			}
			else if ("H".equals(mbrLoginStatusYhn)) {//회원 상태가 홀드
				EgovUserDetailsHelper.setAttributeString("mbrId", resultVO.getMbrId());
				returnMap.put("status", "ng");
				returnMap.put("msg", egovMessageSource.getMessage("fail.user.lockLogin") + "\n" + egovMessageSource.getMessage("common.user.unLockLogin.msg"));
				return returnMap;
			}
		}

		returnMap.put("status", "ng");
		returnMap.put("msg", egovMessageSource.getMessage("fail.common.login"));
		return returnMap;
	}

	/**
	 * 휴면계정 해제 페이지 표출.
	 * 
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "unLockLogin.do")
	public String unLockLogin(ModelMap model) throws Exception {

		model.addAttribute("notForwardHistory", true);
		init(model);
		String mbrId = EgovUserDetailsHelper.getAttributeString("mbrId");
		if (mbrId == null || "".equals(mbrId)) {
			return messageRedirect(egovMessageSource.getMessage("fail.common.connect.msg"), MAIN_PAGE, model);
		}
		else {
			model.addAttribute("mbrId", mbrId);
			return conUrl + "unLockLogin";
		}
	}

	/**
	 * 휴면계정을 해제 후 로그인
	 * 
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "unlockLoginProc.do")
	public String unlockLoginProc(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		model.addAttribute("notForwardHistory", true);
		init(model);
		String loginMsg = "";
		if (loginVO != null && loginVO.getMbrId() != null && !loginVO.getMbrId().equals("")) {
			LoginVO resultVO = mmService.actionLogin(loginVO);
			if (resultVO.getMbrId() != null && !resultVO.getMbrId().equals("")) {
				if (loginVO.getMbrPw().equals(resultVO.getMbrPw())) {
					Map<String, Object> param = new HashMap<>();
					param.put("MBR_LOGIN_STATUS_YHN", "Y");
					String strQuery = "AND MBR_ID = '" + resultVO.getMbrId() + "'";
					commService.tableUpdate("ASW_M_MBR_LOGIN", param, null, null, strQuery, null);
					resultVO.setMbrLoginStatusYhn("Y");
					loginMsg = loginProc(loginVO, resultVO, request, response, model);
				}
			}
		}
		if ("".equals(loginMsg)) {
			return messageRedirect(egovMessageSource.getMessage("fail.common.login"), LOGIN_PAGE, model);
		}
		else {
			return loginMsg;
		}
	}

	/**
	 * 로그아웃한다.
	 * 
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "actionLogSystem.out.action")
	public String actionLogout(ModelMap model) throws Exception {

		init(model);
		EgovUserDetailsHelper.removeAllAttribute();
		return messageRedirect("정상적으로 로그 아웃 되었습니다.", MAIN_PAGE, model);
	}

	/**
	 * 회원 가입 프로세서
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "join.do")
	public String join(@RequestParam Map<String, Object> commandMap, ModelMap model, HttpServletRequest request) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("conUrl", conUrl);

		int joinStep = 0;
		String message = "";
		String MBR_DI = CommonUtil.nvl(paramMap.get("MBR_DI"));

		model.addAttribute("notForwardHistory", true);
		//AUTH_TYPE:인증 수단, NAME:이름, BIRTHDATE:생일, GENDER:성별, NATIONALINFO:내/외국인정보

		if (!"".equals(MBR_DI)) {
			HashMap<String, String> sessionMap = (HashMap<String, String>) EgovUserDetailsHelper.getAttribute("niceCheckMap");

			joinStep = CommonUtil.nvlInt(sessionMap.get("joinStep"));
			if (joinStep == 1) {//인증 수단을 거처서 들어 온 경우
				model.addAttribute("mbrNm", sessionMap.get("NAME"));
				model.addAttribute("mbrId", sessionMap.get("MBR_ID"));
				model.addAttribute("phoneNo", sessionMap.get("PHONE_NO"));

			}
			else if (joinStep == 2) {
				model.addAttribute("mbrNm", sessionMap.get("NAME"));
				model.addAttribute("mbrId", sessionMap.get("MBR_ID"));
				EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
				EgovUserDetailsHelper.removeAttribute("niceCheckMap");
			}
			else {
				message = egovMessageSource.getMessage("fail.common.connect.msg");
			}

		}
		else if (joinStep != 0) {
			message = egovMessageSource.getMessage("fail.common.connect.msg");
		}
		else {
			String termsChk = paramMap.getString("TERMS_CHK");
			if (!termsChk.equals("ok")) {
				joinStep = 3;
			}
		}
		if (!"".equals(message)) {
			EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
			EgovUserDetailsHelper.removeAttribute("niceCheckMap");
			return messageRedirect(message, conUrl + MmStatic.getJoinUrl(0, request) + ".do", model);
		}
		return conUrl + MmStatic.getJoinUrl(joinStep, request);
	}

	/**
	 * 회원가입
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "joinI.do")
	public String joinI(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("notForwardHistory", true);
		HashMap<String, String> sessionMap = (HashMap<String, String>) EgovUserDetailsHelper.getAttribute("niceCheckMap");
		/*
		 * 개발 : 본인 인증이 안되서 임시 코딩
				서버 올릴때 삭제 요망 START
		String MBR_ID = paramMap.getString("MBR_ID");
		String MBR_DI = paramMap.getString("MBR_DI")+paramMap.getString("MBR_ID");
		String S_MBR_ID = paramMap.getString("MBR_ID");
		String S_MBR_DI = paramMap.getString("MBR_DI")+paramMap.getString("MBR_ID");
		String S_JOIN_STEP = "1";
		 */
		/*
		 * 개발 : 본인 인증이 안되서 임시 코딩
				서버 올릴때 삭제 요망 END
		*/

		/*
		 *	★서버 올릴때 : 개발시 niceCheckMap 인증을 받을 수 없으니 하드코딩해서 주석처리함
		 *			    서버올릴때 주석 제거요망
		 */
		String MBR_ID = paramMap.getString("MBR_ID");
		String MBR_DI = paramMap.getString("MBR_DI");
		String S_MBR_ID = sessionMap.get("MBR_ID");
		String S_MBR_DI = sessionMap.get("mbrDi");
		String S_JOIN_STEP = sessionMap.get("joinStep");

		if (MBR_ID.equals(S_MBR_ID) && MBR_DI.equals(S_MBR_DI) && "1".equals(S_JOIN_STEP)) {
			try {
				Object mbrAddrDtl = paramMap.get("MBR_ADDR_DTL");
				if (mbrAddrDtl == null || "".equals(CommonUtil.nvlTrim(mbrAddrDtl))) {
					paramMap.remove("MBR_ADDR_DTL");
				}

				mmService.joinI(MBR_ID, paramMap);

				sessionMap.put("joinStep", "2");
				Map<String, String> dataMap = new CamelMap<>();
				dataMap.put("MBR_DI", MBR_DI);
				model.addAttribute("dataMap", CommonUtil.mapToJsonString(dataMap));
				model.addAttribute("MBR_DI", MBR_DI);

				// 가입완료 EMAIL
				//				UnCamelMap<String, Object> mailMap = new UnCamelMap<String, Object>();
				//				mailMap.put("MBR_ID", MBR_ID);
				//				mailMap.put("MSG_SEND_SEQ", CommonUtil.nvl(getPrSeq("MSG_SEND_SEQ")));
				//				mailMap.put("MSG_ROLE_CD", "EMR00009");
				//				mailMap.put("MSG_DIV_RC", "R");
				//				Map<String,Object> mailMsgRole = commService.mbrMailCont(mailMap);
				//				mailMap.put("MAIL_TITLE", mailMsgRole.get("mailTitle"));
				//				mailMap.put("MAIL_CONT", mailMsgRole.get("mailCont"));
				//				mailMap.put("MAIL_FOOTER_CONT", mailMsgRole.get("mailFooterCont"));

				return messageRedirect("", conUrl + "join.do?MBR_DI=" + MBR_DI, model);
			}
			catch (Exception e) {
				EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
				EgovUserDetailsHelper.removeAttribute("niceCheckMap");
				return messageRedirect(e.getMessage(), conUrl + "join.do", model);
			}
		}
		else {
			return messageRedirect(egovMessageSource.getMessage("fail.common.connect.msg"), conUrl + "join.do", model);
		}
	}

	/**
	 * 한국모바일인증정보 - CheckPlus 안심본인인증
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "checkPlusMain.action")
	public String checkPlusMain(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		//		CamelMap<String, Object> siteCode = commService.getGSiteCode("SITE_NM", "NICE");
		//날짜 생성
		Calendar today = Calendar.getInstance();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String day = sdf.format(today.getTime());

		java.util.Random ran = new Random();
		//랜덤 문자 길이
		int numLength = 6;
		String randomStr = "";

		for (int i = 0; i < numLength; i++) {
			//0 ~ 9 랜덤 숫자 생성
			randomStr += ran.nextInt(10);
		}

		//tr_cert 데이터 변수 선언 ---------------------------------------------------------------
		String tr_cert = "";
		String cpId = "ISDM1001"; //웹사이트 코드(12자리) MSSTM1001000        // 회원사ID
		String urlCode = "010001"; // URL코드
		String certNum = day + randomStr; // 요청번호
		String date = day; // 요청일시
		String certMet = CommonUtil.nvl(commandMap.get("certMet"), "M"); // 본인인증방법
		String name = ""; // 성명
		String phoneNo = ""; // 휴대폰번호
		String phoneCorp = ""; // 이동통신사
		String birthDay = ""; // 생년월일
		String gender = ""; // 성별
		String nation = ""; // 내외국인 구분
		String plusInfo = CommonUtil.nvl(commandMap.get("param_r1"), "0") + "#" + CommonUtil.nvl(commandMap.get("param_r2"), "0") + "#" + CommonUtil.nvl(commandMap.get("param_r3"), "0"); // 추가DATA정보
		String extendVar = "0000000000000000"; // 확장변수
		//End-tr_cert 데이터 변수 선언 ---------------------------------------------------------------

		//String tr_url     = request.getParameter("tr_url");         // 본인인증서비스 결과수신 POPUP URL
		//String tr_add     = "Y";         // IFrame사용여부

		/**
		 * certNum 주의사항
		 * **************************************************************************************
		 * 1. 본인인증 결과값 복호화를 위한 키로 활용되므로 중요함.
		 * 2. 본인인증 요청시 중복되지 않게 생성해야함. (예-시퀀스번호)
		 * 3. certNum값은 본인인증 결과값 수신 후 복호화키로 사용함.
		 * tr_url값에 certNum값을 포함해서 전송하고, (tr_url = tr_url + "?certNum=" + certNum;)
		 * tr_url에서 쿼리스트링 형태로 certNum값을 받으면 됨. (certNum = request.getParameter("certNum"); )
		 *
		 ***********************************************************************************************************/

		//01. 한국모바일인증(주) 암호화 모듈 선언
		com.icert.comm.secu.IcertSecuManager seed = new com.icert.comm.secu.IcertSecuManager();

		//02. 1차 암호화 (tr_cert 데이터변수 조합 후 암호화)
		String enc_tr_cert = "";
		tr_cert = cpId + "/" + urlCode + "/" + certNum + "/" + date + "/" + certMet + "/" + birthDay + "/" + gender + "/" + name + "/" + phoneNo + "/" + phoneCorp + "/" + nation + "/" + plusInfo + "/" + extendVar;
		enc_tr_cert = seed.getEnc(tr_cert, "");

		//03. 1차 암호화 데이터에 대한 위변조 검증값 생성 (HMAC)
		String hmacMsg = "";
		hmacMsg = seed.getMsg(enc_tr_cert);

		//04. 2차 암호화 (1차 암호화 데이터, HMAC 데이터, extendVar 조합 후 암호화)
		tr_cert = seed.getEnc(enc_tr_cert + "/" + hmacMsg + "/" + extendVar, "");

		model.addAttribute("tr_cert", tr_cert);
		//model.addAttribute("tr_url", tr_url);
		//model.addAttribute("tr_add", tr_add);

		EgovUserDetailsHelper.setAttribute("REQ_SEQ", certNum);// 해킹등의 방지를 위하여 세션에 요청번호를 넣는다.
		return conUrl + "checkPlusMain";
	}

	boolean b = true;

	String regex = "";

	public Boolean paramChk(String patn, String param) {

		Pattern pattern = Pattern.compile(patn);
		Matcher matcher = pattern.matcher(param);
		b = matcher.matches();
		return b;
	}

	/**
	 * NICE평가정보 - CheckPlus 안심본인인증 성공
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "checkPlusSuccess.action")
	public String checkPlusSuccess(HttpServletRequest request, ModelMap model) throws Exception {

		init(model);
		// 변수선언 --------------------------------------------------------------------------------------------------------
		String rec_cert = ""; // 결과수신DATA

		String k_certNum = ""; // 파라미터로 수신한 요청번호
		String certNum = ""; // 요청번호
		String date = ""; // 요청일시
		String CI = ""; // 연계정보(CI)
		String DI = ""; // 중복가입확인정보(DI)
		String phoneNo = ""; // 휴대폰번호
		String phoneCorp = ""; // 이동통신사
		String birthDay = ""; // 생년월일
		String gender = ""; // 성별
		String nation = ""; // 내국인
		String name = ""; // 성명
		String M_name = ""; // 미성년자 성명
		String M_birthDay = ""; // 미성년자 생년월일
		String M_Gender = ""; // 미성년자 성별
		String M_nation = ""; // 미성년자 내외국인
		String result = ""; // 결과값

		String certMet = ""; // 인증방법
		String ip = ""; // ip주소
		String plusInfo = "";

		String encPara = "";
		String encMsg1 = "";
		String encMsg2 = "";
		String msgChk = "";

		String sMessage = "";
		//-----------------------------------------------------------------------------------------------------------------

		// Parameter 수신 --------------------------------------------------------------------
		rec_cert = request.getParameter("rec_cert").trim();
		k_certNum = request.getParameter("certNum").trim();
		//01. 암호화 모듈 (jar) Loading
		com.icert.comm.secu.IcertSecuManager seed = new com.icert.comm.secu.IcertSecuManager();

		//02. 1차 복호화
		//수신된 certNum를 이용하여 복호화
		rec_cert = seed.getDec(rec_cert, k_certNum);

		//03. 1차 파싱
		int inf1 = rec_cert.indexOf("/", 0);
		int inf2 = rec_cert.indexOf("/", inf1 + 1);

		encPara = rec_cert.substring(0, inf1); //암호화된 통합 파라미터
		encMsg1 = rec_cert.substring(inf1 + 1, inf2); //암호화된 통합 파라미터의 Hash값

		//04. 위변조 검증
		encMsg2 = seed.getMsg(encPara);

		if (encMsg2.equals(encMsg1)) {
			msgChk = "Y";
		}

		if (msgChk.equals("N")) {
			//alert("비정상적인 접근입니다.!!<%=msgChk%>");
			return null;
		}

		//05. 2차 복호화
		rec_cert = seed.getDec(encPara, k_certNum);

		//06. 2차 파싱
		int info1 = rec_cert.indexOf("/", 0);
		int info2 = rec_cert.indexOf("/", info1 + 1);
		int info3 = rec_cert.indexOf("/", info2 + 1);
		int info4 = rec_cert.indexOf("/", info3 + 1);
		int info5 = rec_cert.indexOf("/", info4 + 1);
		int info6 = rec_cert.indexOf("/", info5 + 1);
		int info7 = rec_cert.indexOf("/", info6 + 1);
		int info8 = rec_cert.indexOf("/", info7 + 1);
		int info9 = rec_cert.indexOf("/", info8 + 1);
		int info10 = rec_cert.indexOf("/", info9 + 1);
		int info11 = rec_cert.indexOf("/", info10 + 1);
		int info12 = rec_cert.indexOf("/", info11 + 1);
		int info13 = rec_cert.indexOf("/", info12 + 1);
		int info14 = rec_cert.indexOf("/", info13 + 1);
		int info15 = rec_cert.indexOf("/", info14 + 1);
		int info16 = rec_cert.indexOf("/", info15 + 1);
		int info17 = rec_cert.indexOf("/", info16 + 1);
		int info18 = rec_cert.indexOf("/", info17 + 1);

		certNum = rec_cert.substring(0, info1);
		date = rec_cert.substring(info1 + 1, info2);
		CI = rec_cert.substring(info2 + 1, info3);
		phoneNo = rec_cert.substring(info3 + 1, info4);
		phoneCorp = rec_cert.substring(info4 + 1, info5);
		birthDay = rec_cert.substring(info5 + 1, info6);
		gender = rec_cert.substring(info6 + 1, info7);
		nation = rec_cert.substring(info7 + 1, info8);
		name = rec_cert.substring(info8 + 1, info9);
		result = rec_cert.substring(info9 + 1, info10);
		certMet = rec_cert.substring(info10 + 1, info11);
		ip = rec_cert.substring(info11 + 1, info12);
		M_name = rec_cert.substring(info12 + 1, info13);
		M_birthDay = rec_cert.substring(info13 + 1, info14);
		M_Gender = rec_cert.substring(info14 + 1, info15);
		M_nation = rec_cert.substring(info15 + 1, info16);
		plusInfo = rec_cert.substring(info16 + 1, info17);
		DI = rec_cert.substring(info17 + 1, info18);

		//07. CI, DI 복호화
		CI = seed.getDec(CI, k_certNum);
		DI = seed.getDec(DI, k_certNum);

		if (certNum.length() == 0 || certNum.length() > 40) {
			sMessage += "요청번호 비정상#";
			model.addAttribute("action", "self.close();");
		}

		regex = "[0-9]*";
		if (date.length() != 14 || !paramChk(regex, date)) {
			sMessage += "요청일시 비정상#";
			model.addAttribute("action", "self.close();");
		}

		regex = "[A-Z]*";
		if (certMet.length() != 1 || !paramChk(regex, certMet)) {
			sMessage += "본인인증방법 비정상" + certMet + "#";
			model.addAttribute("action", "self.close();");
		}

		regex = "[0-9]*";
		if ((phoneNo.length() != 10 && phoneNo.length() != 11) || !paramChk(regex, phoneNo)) {
			sMessage += "휴대폰번호 비정상#";
			model.addAttribute("action", "self.close();");
		}

		regex = "[A-Z]*";
		if (phoneCorp.length() != 3 || !paramChk(regex, phoneCorp)) {
			sMessage += "이동통신사 비정상#";
			model.addAttribute("action", "self.close();");
		}

		regex = "[0-9]*";
		if (birthDay.length() != 8 || !paramChk(regex, birthDay)) {
			sMessage += "생년월일 비정상#";
			model.addAttribute("action", "self.close();");
		}

		regex = "[0-9]*";
		if (gender.length() != 1 || !paramChk(regex, gender)) {
			sMessage += "성별 비정상#";
			model.addAttribute("action", "self.close();");
		}

		regex = "[0-9]*";
		if (nation.length() != 1 || !paramChk(regex, nation)) {
			sMessage += "내/외국인 비정상 비정상#";
			model.addAttribute("action", "self.close();");
		}

		regex = "[\\sA-Za-z가-힣.,-]*";
		if (name.length() > 60 || !paramChk(regex, name)) {
			sMessage += "성명 비정상#";
			model.addAttribute("action", "self.close();");
		}

		regex = "[A-Z]*";
		if (result.length() != 1 || !paramChk(regex, result)) {
			sMessage += "결과값 비정상#";
			model.addAttribute("action", "self.close();");
		}

		regex = "[\\sA-Za-z가-?.,-]*";
		if (M_name.length() != 0) {
			if (M_name.length() > 60 || !paramChk(regex, M_name)) {
				sMessage += "미성년자 성명 비정상#";
				model.addAttribute("action", "self.close();");
			}
		}

		regex = "[0-9]*";
		if (M_birthDay.length() != 0) {
			if (M_birthDay.length() != 8 || !paramChk(regex, M_birthDay)) {
				sMessage += "미성년자 생년월일 비정상#";
				model.addAttribute("action", "self.close();");
			}
		}

		regex = "[0-9]*";
		if (M_Gender.length() != 0) {
			if (M_Gender.length() != 1 || !paramChk(regex, M_Gender)) {
				sMessage += "미성년자 성별 비정상#";
				model.addAttribute("action", "self.close();");
			}
		}

		regex = "[0-9]*";
		if (M_nation.length() != 0) {
			if (M_nation.length() != 1 || !paramChk(regex, M_nation)) {
				sMessage += "미성년자 내/외국인 비정상#";
				model.addAttribute("action", "self.close();");
			}
		}
		// End 파라미터 유효성 검증 --------------------------------------------

		// Start - 수신내역 유효성 검증(사설망의 사설 IP로 인해 미사용, 공용망의 경우 확인 후 사용) *********************/
		// 1. date 값 검증
		SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss", Locale.KOREAN); // 현재 서버 시각 구하기
		String strCurrentTime = formatter.format(new Date());

		Date toDate = formatter.parse(strCurrentTime);
		Date fromDate = formatter.parse(date);
		long timediff = toDate.getTime() - fromDate.getTime();

		if (timediff < -30 * 60 * 1000 || 30 * 60 * 100 < timediff) {
			sMessage += "비정상적인 접근입니다. (요청시간경과)";
			model.addAttribute("action", "self.close();");
		}

		// 2. ip 값 검증
		String client_ip = request.getHeader("HTTP_X_FORWARDED_FOR"); // 사용자IP 구하기
		if (client_ip != null) {
			if (client_ip.indexOf(",") != -1)
				client_ip = client_ip.substring(0, client_ip.indexOf(","));
		}
		if (client_ip == null || client_ip.length() == 0) {
			client_ip = request.getRemoteAddr();
		}

		if (!client_ip.equals(ip)) {
			sMessage += "비정상적인 접근입니다. (IP불일치)";
			model.addAttribute("action", "self.close();");
		}

		model.addAttribute("sMessage", sMessage);

		// End - 수신내역 유효성 검증(사설망의 사설 IP로 인해 미사용, 공용망의 경우 확인 후 사용) ***********************/

		String session_sRequestNumber = EgovUserDetailsHelper.getAttributeString("REQ_SEQ");// 세션에 전장된 요청 번호
		if (certNum.equals(session_sRequestNumber)) {//보안을 위한 확인

			//				        // 데이타를 추출합니다. 데이타를 추출합니다. REQ_SEQ : 요청 번호, ERR_CODE : 인증 결과코드, AUTH_TYPE : 인증 수단
			Map<String, String> niceCheckMap = new HashMap<String, String>();
			Map<String, Object> chkMap = new HashMap<>();
			chkMap.put("DI", DI.substring(0, DI.length() - 1));
			CamelMap<String, String> reMap = mmService.searchId(chkMap);

			String[] plusInfoArr = plusInfo.split("#");
			String param_r1 = MmStatic.requestReplace(plusInfoArr[0], "");

			if ("join".equals(param_r1)) {
				if (reMap == null) {//기존 가입 이력이 없거나 탈퇴 회원 일 경우
					niceCheckMap.put("joinStep", "1");
					niceCheckMap.put("name", name);
					niceCheckMap.put("mbrMobile", phoneNo);
					niceCheckMap.put("mbrSexMw", gender);

					niceCheckMap.put("param_r1", param_r1);
					niceCheckMap.put("mbrDi", DI);
					niceCheckMap.put("param_r2", MmStatic.requestReplace(plusInfoArr[1], ""));
					niceCheckMap.put("param_r3", MmStatic.requestReplace(plusInfoArr[2], ""));
					EgovUserDetailsHelper.setAttribute("niceCheckMap", niceCheckMap);
					return conUrl + "checkPlusSuccess";
				}
				else {//기존 가입 이력 있음
					String mbrLoginStatusYhn = reMap.getString("mbrLoginStatusYhn");
					if ("Y".equals(mbrLoginStatusYhn)) {//기존 가입되어 있는 정보가 있을 경우
						sMessage += egovMessageSource.getMessage("common.user.rejoin.msg");
					}
					else if ("H".equals(mbrLoginStatusYhn)) {//휴면 상태일 경우
						EgovUserDetailsHelper.setAttribute("mbrId", reMap.getString("mbrId"));
						sMessage += egovMessageSource.getMessage("fail.user.lockLogin") + "\n" + egovMessageSource.getMessage("common.user.unLockLogin.msg");
					}
					else {
						sMessage += egovMessageSource.getMessage("fail.common.connect.msg");
					}
					model.addAttribute("action", "self.close();");
				}
			}
			else if ("id".equals(param_r1) || "pwd".equals(param_r1)) {
				if (reMap == null) {
					if ("id".equals(param_r1)) {
						sMessage += egovMessageSource.getMessage("fail.common.idsearch");
					}
					else if ("pwd".equals(param_r1)) {
						sMessage += egovMessageSource.getMessage("fail.common.pwsearch");
					}
					model.addAttribute("action", "self.close();");
				}
				else {
					niceCheckMap.put("param_r1", param_r1);
					niceCheckMap.put("param_r2", MmStatic.requestReplace(plusInfoArr[1], ""));
					niceCheckMap.put("param_r3", MmStatic.requestReplace(plusInfoArr[2], ""));
					niceCheckMap.put("mbrDi", DI);
					niceCheckMap.put("name", name);
					if (reMap != null) {
						niceCheckMap.put("mbrId", reMap.getString("mbrId"));
					}
					EgovUserDetailsHelper.setAttribute("niceCheckMap", niceCheckMap);
					model.addAttribute("mbrDi", DI);
					model.addAttribute("param_r1", param_r1);
					model.addAttribute("param_r2", MmStatic.requestReplace(plusInfoArr[1], ""));

					return conUrl + "checkPlusSuccess";
				}
			}
			else if ("cs".equals(param_r1)) {

				niceCheckMap.put("name", name);
				niceCheckMap.put("mbrMobile", phoneNo);
				niceCheckMap.put("mbrSexMw", gender);
				niceCheckMap.put("mbrDi", DI);

				EgovUserDetailsHelper.setAttribute("nonLogin", niceCheckMap);
				model.addAttribute("param_type", param_r1);
				model.addAttribute("param_r2", MmStatic.requestReplace(plusInfoArr[1], ""));

				return conUrl + "checkPlusSuccess";

			}
			else {
				sMessage += egovMessageSource.getMessage("fail.common.connect.msg");
				model.addAttribute("action", "self.close();");
			}
		}
		else {
			sMessage += egovMessageSource.getMessage("fail.common.connect.msg");
			model.addAttribute("action", "self.close();");
		}

		EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
		EgovUserDetailsHelper.removeAttribute("niceCheckMap");

		model.addAttribute("sMessage", sMessage);
		return conUrl + "checkPlusSuccess";
	}
	/**
	 * NICE평가정보 - CheckPlus 안심본인인증
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	//	@RequestMapping(value = "checkPlusMain.action")
	//	public String checkPlusMain(HttpServletRequest request, ModelMap model) throws Exception {
	//		CamelMap<String, Object> siteCode = commService.getGSiteCode("SITE_NM", "NICE");
	//		String checkPlusSiteCode = siteCode.getString("siteId");
	//		String checkPlusSitePassword = siteCode.getString("sitePw");
	//		CPClient niceCheck = new CPClient();
	//	    String sRequestNumber = niceCheck.getRequestNO(checkPlusSiteCode);// 요청 번호, 이는 성공/실패후에 같은 값으로 되돌려주게 되므로 입력될 plain 데이타를 만든다.
	//	    boolean isMobile = CommonUtil.isMobile(request);
	//	    String sPlainData = "7:REQ_SEQ" + sRequestNumber.getBytes().length + ":" + sRequestNumber + MmStatic.getSPlainData(conUrl, checkPlusSiteCode, isMobile);
	//	    int iReturn = niceCheck.fnEncode(checkPlusSiteCode, checkPlusSitePassword, sPlainData);
	//	    if( iReturn == 0 ){
	//	    	EgovUserDetailsHelper.setAttribute("REQ_SEQ" , sRequestNumber);// 해킹등의 방지를 위하여 세션에 요청번호를 넣는다.
	//	    	String sEncData = niceCheck.getCipherData();
	//	        model.addAttribute("sEncData", sEncData);
	//	    }else{
	//	    	EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
	//	    	String sMessage = MmStatic.getMsg(iReturn);
	//	    	model.addAttribute("sMessage", sMessage);
	//	    }
	//		return conUrl + "checkPlusMain";
	//	}

	/**
	 * NICE평가정보 - CheckPlus 안심본인인증 성공
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	//	@SuppressWarnings("unchecked")
	//	@RequestMapping(value = "checkPlusSuccess.action")
	//	public String checkPlusSuccess(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
	//		init(model);
	//		CPClient niceCheck = new  CPClient();
	//	    String EncodeData = MmStatic.requestReplace(commandMap.get("EncodeData"), "encodeData");
	//	    String sMessage = "";
	//	    CamelMap<String, Object> siteCode = commService.getGSiteCode("SITE_NM", "NICE");
	//		String CHECK_PLUS_SITE_CODE = siteCode.getString("siteId");
	//		String CHECK_PLUS_SITE_PASSWORD = siteCode.getString("sitePw");
	//	    int iReturn = niceCheck.fnDecode(CHECK_PLUS_SITE_CODE, CHECK_PLUS_SITE_PASSWORD, EncodeData);
	//	    if( iReturn == 0 ){
	//	    	String sPlainData = niceCheck.getPlainData();
	//	        // 데이타를 추출합니다. 데이타를 추출합니다. REQ_SEQ : 요청 번호, ERR_CODE : 인증 결과코드, AUTH_TYPE : 인증 수단
	//			Map<String, String> niceCheckMap = niceCheck.fnParse(sPlainData);
	//			String sRequestNumber  = (String) niceCheckMap.get("REQ_SEQ");// 요청 번호
	//	        String session_sRequestNumber = EgovUserDetailsHelper.getAttributeString("REQ_SEQ");// 세션에 전장된 요청 번호
	//	        if(sRequestNumber.equals(session_sRequestNumber)){//보안을 위한 확인
	//	        	String DI = niceCheckMap.get("DI");
	//	        	Map<String, Object> chkMap = new HashMap<>();
	//	        	chkMap.put("DI", DI.substring(0, DI.length() - 1));
	//	        	CamelMap<String, String> reMap = mmService.searchId(chkMap);
	//	        	String param_r1 = MmStatic.requestReplace(commandMap.get("param_r1"), "");
	//	        	if("join".equals(param_r1)){
	//	        		if(reMap == null){//기존 가입 이력이 없거나 탈퇴 회원 일 경우
	//		        		model.addAttribute("mbrDi", DI);
	//		        		niceCheckMap.put("joinStep", "1");
	//		        		niceCheckMap.put("param_r1", param_r1);
	//		        		niceCheckMap.put("param_r2", MmStatic.requestReplace(commandMap.get("param_r2"), ""));
	//		        		niceCheckMap.put("param_r3", MmStatic.requestReplace(commandMap.get("param_r3"), ""));
	//			        	EgovUserDetailsHelper.setAttribute("niceCheckMap" , niceCheckMap);
	//			     	    return conUrl + "checkPlusSuccess";
	//		        	}else{//기존 가입 이력 있음
	//		        		String mbrLoginStatusYhn = reMap.getString("mbrLoginStatusYhn");
	//		        		if("Y".equals(mbrLoginStatusYhn)){//기존 가입되어 있는 정보가 있을 경우
	//		        			sMessage += egovMessageSource.getMessage("common.user.rejoin.msg");
	//		        		}else if("H".equals(mbrLoginStatusYhn)){//휴면 상태일 경우
	//		        			EgovUserDetailsHelper.setAttribute("mbrId", reMap.getString("mbrId"));
	//		        			sMessage += egovMessageSource.getMessage("fail.user.lockLogin") + "\n" + egovMessageSource.getMessage("common.user.unLockLogin.msg");
	//		        		}else{
	//		        			sMessage += egovMessageSource.getMessage("fail.common.connect.msg");
	//		        		}
	//		        		model.addAttribute("action", "self.close();");
	//		        	}
	//	        	}else if("id".equals(param_r1) || "pwd".equals(param_r1)){
	//	        		if(reMap == null){
	//	        			if("id".equals(param_r1)){
	//	        				sMessage += egovMessageSource.getMessage("fail.common.idsearch");
	//	        			}else if("pwd".equals(param_r1)){
	//	        				sMessage += egovMessageSource.getMessage("fail.common.pwsearch");
	//	        			}
	//	    	        	model.addAttribute("action", "self.close();");
	//	        		}else{
	//		        		niceCheckMap.put("param_r1", param_r1);
	//		        		niceCheckMap.put("param_r2", MmStatic.requestReplace(commandMap.get("param_r2"), ""));
	//		        		niceCheckMap.put("param_r3", MmStatic.requestReplace(commandMap.get("param_r3"), ""));
	//		        		if(reMap != null){
	//		        			niceCheckMap.put("mbrId", reMap.getString("mbrId"));
	//		        		}
	//			        	EgovUserDetailsHelper.setAttribute("niceCheckMap" , niceCheckMap);
	//			        	model.addAttribute("mbrDi", DI);
	//		        		return conUrl + "checkPlusSuccess";
	//	        		}
	//	        	}else{
	//		        	sMessage += egovMessageSource.getMessage("fail.common.connect.msg");
	//		        	model.addAttribute("action", "self.close();");
	//		        }
	//	        }else{
	//	        	sMessage += egovMessageSource.getMessage("fail.common.connect.msg");
	//	        	model.addAttribute("action", "self.close();");
	//	        }
	//	    }else{
	//	    	sMessage += MmStatic.getMsg(iReturn);
	//	    	model.addAttribute("action", "self.close();");
	//	    }
	//	    EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
	//	    EgovUserDetailsHelper.removeAttribute("niceCheckMap");
	//	    model.addAttribute("sMessage", sMessage);
	//		return conUrl + "checkPlusSuccess";
	//	}

	/**
	 * NICE평가정보 - CheckPlus 안심본인인증 샐패
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "checkPlusFail.action")
	public String checkplusFail(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		CamelMap<String, Object> siteCode = commService.getGSiteCode("SITE_NM", "NICE");
		String CHECK_PLUS_SITE_CODE = siteCode.getString("siteId");
		String CHECK_PLUS_SITE_PASSWORD = siteCode.getString("sitePw");
		CPClient niceCheck = new CPClient();
		String sEncodeData = MmStatic.requestReplace(commandMap.get("EncodeData"), "encodeData");
		String sMessage = "본인인증이 실패하였습니다 : ";
		int iReturn = niceCheck.fnDecode(CHECK_PLUS_SITE_CODE, CHECK_PLUS_SITE_PASSWORD, sEncodeData);
		if (iReturn == 0) {
			String sPlainData = niceCheck.getPlainData();
			// 데이타를 추출합니다. REQ_SEQ : 요청 번호, ERR_CODE : 인증 결과코드, AUTH_TYPE : 인증 수단
			HashMap<String, String> mapresult = niceCheck.fnParse(sPlainData);
			sMessage += mapresult.get("ERR_CODE");
		}
		else
			sMessage += MmStatic.getMsg(iReturn);
		EgovUserDetailsHelper.removeAttribute("niceCheckMap");
		EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
		return messageAction(sMessage, "self.close();", model);
	}

	/**
	 * NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
	 * 서비스명 : 가상주민번호서비스 (IPIN) 서비스
	 * 페이지명 : 가상주민번호서비스 (IPIN) 호출 페이지
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "checkIpinMain.action")
	public String checkIpinMain(ModelMap model) throws Exception {

		init(model);
		CamelMap<String, Object> siteCode = commService.getGSiteCode("SITE_NM", "IPIN");
		String IPIN_SITE_CODE = siteCode.getString("siteId");
		String IPIN_SITE_PW = siteCode.getString("sitePw");
		// 객체 생성
		IPINClient pClient = new IPINClient();
		// 앞서 설명드린 바와같이, CP 요청번호는 배포된 모듈을 통해 아래와 같이 생성할 수 있습니다.
		String reqSeq = pClient.getRequestNO(IPIN_SITE_CODE);
		// Method 결과값(iRtn)에 따라, 프로세스 진행여부를 파악합니다.
		int iRtn = pClient.fnRequest(IPIN_SITE_CODE, IPIN_SITE_PW, reqSeq, MmStatic.getIpinReturnURL(conUrl));
		// Method 결과값에 따른 처리사항
		if (iRtn == 0) {
			// CP 요청번호를 세션에 저장합니다.
			// 현재 예제로 저장한 세션은 ipin_result.jsp 페이지에서 데이타 위변조 방지를 위해 확인하기 위함입니다.
			// 필수사항은 아니며, 보안을 위한 권고사항입니다.
			EgovUserDetailsHelper.setAttribute("REQ_SEQ", reqSeq);
			// fnRequest 함수 처리시 업체정보를 암호화한 데이터를 추출합니다.
			// 추출된 암호화된 데이타는 당사 팝업 요청시, 함께 보내주셔야 합니다.
			String sEncData = pClient.getCipherData();//암호화 된 데이타
			model.addAttribute("sEncData", sEncData);
		}
		else {
			EgovUserDetailsHelper.removeAttribute("REQ_SEQ");
			String sMessage = MmStatic.getIPINMsg(iRtn);
			model.addAttribute("sMessage", sMessage);
		}
		return conUrl + "checkIpinMain";
	}

	/**
	 * * NICE평가정보 Copyright(c) KOREA INFOMATION SERVICE INC. ALL RIGHTS RESERVED
	 * 서비스명 : 가상주민번호서비스 (IPIN) 서비스
	 * 페이지명 : 가상주민번호서비스 (IPIN) 조회 후 처리
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "checkIpinProcess.action")
	public String checkIpinProcess(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		CamelMap<String, Object> siteCode = commService.getGSiteCode("SITE_NM", "IPIN");
		String IPIN_SITE_CODE = siteCode.getString("siteId");
		String IPIN_SITE_PW = siteCode.getString("sitePw");
		String sResponseData = MmStatic.requestReplace(commandMap.get("enc_data"), "encodeData");
		String reqSeq = EgovUserDetailsHelper.getAttributeString("REQ_SEQ");
		IPINClient pClient = new IPINClient();
		int iRtn = pClient.fnResponse(IPIN_SITE_CODE, IPIN_SITE_PW, sResponseData, reqSeq);
		String sRtnMsg = ""; // 처리결과 메세지
		if (iRtn == 1) {
			String DI = pClient.getDupInfo();
			Map<String, Object> chkMap = new HashMap<>();
			chkMap.put("DI", DI.substring(0, DI.length() - 1));
			CamelMap<String, String> reMap = mmService.searchId(chkMap);
			String param_r1 = MmStatic.requestReplace(commandMap.get("param_r1"), "");
			if ("join".equals(param_r1)) {
				if (reMap == null) {//기존 가입 이력이 없거나 탈퇴 회원 일 경우
					Map<String, String> niceCheckMap = new HashMap<String, String>();
					niceCheckMap.put("REQ_SEQ", reqSeq);
					niceCheckMap.put("NAME", pClient.getName());
					niceCheckMap.put("BIRTHDATE", pClient.getBirthDate());
					niceCheckMap.put("GENDER", pClient.getGenderCode());
					niceCheckMap.put("DI", DI);
					niceCheckMap.put("joinStep", "1");
					niceCheckMap.put("param_r1", MmStatic.requestReplace(commandMap.get("param_r1"), ""));
					niceCheckMap.put("param_r2", MmStatic.requestReplace(commandMap.get("param_r2"), ""));
					niceCheckMap.put("param_r3", MmStatic.requestReplace(commandMap.get("param_r3"), ""));
					EgovUserDetailsHelper.setAttribute("niceCheckMap", niceCheckMap);
					model.addAttribute("mbrDi", DI);
					return conUrl + "checkIpinProcess";
				}
				else {//기존 가입 이력 있음
					String mbrLoginStatusYhn = reMap.getString("mbrLoginStatusYhn");
					if ("Y".equals(mbrLoginStatusYhn)) {//기존 가입되어 있는 정보가 있을 경우
						sRtnMsg += egovMessageSource.getMessage("common.user.rejoin.msg");
					}
					else if ("H".equals(mbrLoginStatusYhn)) {//휴면 상태일 경우
						EgovUserDetailsHelper.setAttribute("mbrId", reMap.getString("mbrId"));
						sRtnMsg += egovMessageSource.getMessage("fail.user.lockLogin") + "\n" + egovMessageSource.getMessage("common.user.unLockLogin.msg");
					}
					else {
						sRtnMsg += egovMessageSource.getMessage("fail.common.connect.msg");
					}
					model.addAttribute("action", "self.close();");
				}
			}
			else if ("id".equals(param_r1) || "pwd".equals(param_r1)) {
				if (reMap == null) {
					if ("id".equals(param_r1)) {
						sRtnMsg += egovMessageSource.getMessage("fail.common.idsearch");
					}
					else if ("pwd".equals(param_r1)) {
						sRtnMsg += egovMessageSource.getMessage("fail.common.pwsearch");
					}
					model.addAttribute("action", "self.close();");
				}
				else {
					Map<String, String> niceCheckMap = new HashMap<String, String>();
					niceCheckMap.put("DI", DI);
					niceCheckMap.put("param_r1", param_r1);
					niceCheckMap.put("param_r2", MmStatic.requestReplace(commandMap.get("param_r2"), ""));
					niceCheckMap.put("param_r3", MmStatic.requestReplace(commandMap.get("param_r3"), ""));
					niceCheckMap.put("NAME", pClient.getName());
					niceCheckMap.put("MBR_ID", reMap.getString("mbrId"));
					EgovUserDetailsHelper.setAttribute("niceCheckMap", niceCheckMap);
					model.addAttribute("mbrDi", DI);
					return conUrl + "checkIpinProcess";
				}
			}
			else {
				sRtnMsg += egovMessageSource.getMessage("fail.common.connect.msg");
				model.addAttribute("action", "self.close();");
			}
		}
		else {
			sRtnMsg = MmStatic.getIPINMsg(iRtn);
			model.addAttribute("action", "self.close();");
		}
		EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
		EgovUserDetailsHelper.removeAttribute("niceCheckMap");
		model.addAttribute("sMessage", sRtnMsg);
		return conUrl + "checkIpinProcess";
	}

	/**
	 * 아이디 중복 체크
	 * 
	 * @param
	 * @return
	 * @exception Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "joinChkId.action")
	public String joinChkId(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		String FLAG = paramMap.getString("FLAG");
		String MBR_ID = paramMap.getString("MBR_ID");
		String message = "";
		JSONObject jObj = new JSONObject();
		if ("id".equals(FLAG)) {//회원 아이디 체크
			CamelMap<String, String> reMap = mmService.searchId(paramMap);
			HashMap<String, String> sessionMap = (HashMap<String, String>) EgovUserDetailsHelper.getAttribute("niceCheckMap");
			jObj.put("mbrId", MBR_ID);
			if (reMap == null || "".equals(reMap.getString("mbrId"))) {
				/* ★서버 올릴때 : 본인인증 로직 확인을 못하니 임시 주석처리, 서버 올릴때 주석제거 START */
				sessionMap.put("MBR_ID", MBR_ID);
				/* ★서버 올릴때 : 본인인증 로직 확인을 못하니 임시 주석처리, 서버 올릴때 주석제거 END */
				message = egovMessageSource.getMessage("success.user.available", new String[] { MBR_ID });
				jObj.put("passChk", true);
			}
			else {
				/* ★서버 올릴때 : 본인인증 로직 확인을 못하니 임시 주석처리, 서버 올릴때 주석제거 START */
				sessionMap.remove("MBR_ID");
				/* ★서버 올릴때 : 본인인증 로직 확인을 못하니 임시 주석처리, 서버 올릴때 주석제거 END */
				message = egovMessageSource.getMessage("fail.user.already", new String[] { MBR_ID });
				jObj.put("passChk", false);
			}
		}
		else if ("rec".equals(FLAG)) {//추천인 아이디 체크
			String MBR_REC = paramMap.getString("MBR_REC");
			HashMap<String, String> sessionMap = (HashMap<String, String>) EgovUserDetailsHelper.getAttribute("niceCheckMap");
			String S_MBR_ID = sessionMap.get("MBR_ID");
			if (MBR_ID.equals(S_MBR_ID)) {//중복 확인한 아이디와 같은지 체크
				if (MBR_ID.equals(MBR_REC)) {//신청아이디와 추천인 아이디가 다른지 체크
					message = egovMessageSource.getMessage("fail.user.recommender");
					jObj.put("passChk", false);
				}
				else {
					Map<String, Object> params = new HashMap<>();
					params.put("MBR_ID", MBR_REC);
					CamelMap<String, String> reMap = mmService.searchId(params);//추천인 아이디 체크
					if (reMap == null || "".equals(reMap.getString("mbrId"))) {//추천인 사용 불가능
						message = egovMessageSource.getMessage("fail.user.join", new String[] { MBR_REC });
						jObj.put("passChk", false);
					}
					else {//추천인 사용 가능
						message = egovMessageSource.getMessage("success.user.recommender", new String[] { MBR_REC });
						jObj.put("passChk", true);
					}
					jObj.put("mbrId", MBR_ID);
				}
			}
			else {
				message = egovMessageSource.getMessage("fail.common.connect.msg");
				jObj.put("passChk", false);
			}
		}
		jObj.put("message", message);
		model.addAttribute("outData", jObj.toString());
		return "common/out";
	}

	/**
	 * 아이디를 찾는다.
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "searchId.do")
	public String searchId(ModelMap model, HttpServletRequest request) throws Exception {

		init(model);
		EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
		EgovUserDetailsHelper.removeAttribute("niceCheckMap");

		String uri = "";
		if (CommonUtil.isMobile(request)) {
			uri = "searchId_m";
		}
		else {
			uri = "searchId";
		}

		return conUrl + uri;
	}

	/**
	 * 비밀번호를 찾는다.
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "searchPassword.do")
	public String searchPassword(ModelMap model, HttpServletRequest request) throws Exception {

		init(model);
		EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
		EgovUserDetailsHelper.removeAttribute("niceCheckMap");

		String uri = "";
		if (CommonUtil.isMobile(request)) {
			uri = "searchPassword_m";
		}
		else {
			uri = "searchPassword";
		}

		return conUrl + uri;
	}

	/**
	 * 찾은 아이디 / 페스워드를 처리 한다.
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "searchEnd.do")
	public String searchEnd(@RequestParam Map<String, Object> commandMap, ModelMap model, HttpServletRequest request) throws Exception {

		init(model);
		/*
		 * START
		 * ★ 운영올릴때 주석제거 : 본인인증을 할 수 없어 임시 주석처리
		 */
		HashMap<String, String> sessionMap = (HashMap<String, String>) EgovUserDetailsHelper.getAttribute("niceCheckMap");
		String param_r1 = CommonUtil.nvl(sessionMap.get("param_r1"));
		String param_r2 = CommonUtil.nvl(sessionMap.get("param_r2"));
		String DI = sessionMap.get("mbrDi");
		Map<String, String> chkMap = new HashMap<>();
		chkMap.put("DI", DI.substring(0, DI.length() - 1));
		CamelMap<String, String> reMap = mmService.searchId(chkMap);
		if (reMap != null) {
			EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
			EgovUserDetailsHelper.removeAttribute("niceCheckMap");
			model.addAttribute("mbrNm", sessionMap.get("name"));
			model.addAttribute("mbrId", CommonUtil.nvl(sessionMap.get("mbrId"), sessionMap.get("mbrId")));
			if ("H".equals(reMap.get("mbrLoginStatusYhn"))) {
				EgovUserDetailsHelper.setAttribute("mbrId", reMap.getString("mbrId"));
				model.addAttribute("loginStatusURL", "unLockLogin.do");
				model.addAttribute("loginStatusH", true);
			}
			else {
				model.addAttribute("loginStatusURL", ROOT_URI + LOGIN_PAGE);
				model.addAttribute("loginStatusH", false);
			}
		}
		/*
		 * ★ 운영올릴때 주석제거 : 본인인증을 할 수 없어 임시 주석처리
		 *END
		 */

		/*
		 * START
		 *★ 로컬에서 테스트 : 본인인증을 할 수 없어 임시하드코딩
		 *
		UnCamelMap<String, Object> paramMap = init(commandMap);
		String param_r1 = paramMap.getString("PARAM_R1");
		String param_r2 = "";
		String DI = "MC0GCCqGSIb3DQIJAyEANbXnW4fHzVcM1CEod8QStYZl43CTaJUdl+NpvvTMYxI=";
		Map<String, String> chkMap = new HashMap<>();
		chkMap.put("DI", DI.substring(0, DI.length() - 1));
		CamelMap<String, String> reMap = mmService.searchId(chkMap);
		if (reMap != null) {
			EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
			EgovUserDetailsHelper.removeAttribute("niceCheckMap");
			model.addAttribute("mbrNm", "박보경");
			model.addAttribute("mbrId", reMap.getString("mbrId"));
			if ("H".equals(reMap.get("mbrLoginStatusYhn"))) {
				EgovUserDetailsHelper.setAttribute("mbrId", reMap.getString("mbrId"));
				model.addAttribute("loginStatusURL", "unLockLogin.do");
				model.addAttribute("loginStatusH", true);
			}
			else {
				model.addAttribute("loginStatusURL", ROOT_URI + LOGIN_PAGE);
				model.addAttribute("loginStatusH", false);
			}
		}
		* END
		 * ★ 로컬에서 테스트 : 본인인증을 할 수 없어 임시하드코딩
		 */

		model.addAttribute("param_r1", param_r1);
		model.addAttribute("param_r2", param_r2);
		EgovUserDetailsHelper.removeAttribute("REQ_SEQ");// 해킹등의 방지를 위한 요청번호를 지운다.
		EgovUserDetailsHelper.removeAttribute("niceCheckMap");

		String uri = "";
		if (CommonUtil.isMobile(request)) {
			uri = "searchEnd_m";
		}
		else {
			uri = "searchEnd";
		}
		return conUrl + uri;
	}

	/**
	 * 비밀번호 찾기 : 비밀번호 수정
	 * 
	 * @param commandMap
	 *        회원정보가 담긴 map
	 * @param model
	 * @return 아이디/비밀번호 찾기 완료 페이지
	 * @throws Exception
	 */
	@RequestMapping(value = "newPwSave.action")
	public String newPwSave(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		UnCamelMap<String, Object> userInfo = new UnCamelMap<>();
		JSONObject jObj = new JSONObject();

		/* 값 셋팅 : ASW_M_MBR_LOGIN */
		userInfo.put("MBR_ID", paramMap.getString("MBR_ID"));
		if (paramMap.getString("MBR_PW_NEW") != null && paramMap.getString("MBR_PW_NEW") != "") {

			String mbrPwNew = URLDecoder.decode(paramMap.getString("MBR_PW_NEW"), "UTF-8");
			String mbrPwNewR = URLDecoder.decode(paramMap.getString("MBR_PW_NEW_R"), "UTF-8");

			// 새 비밀번호가 서로 다르다.
			/*if (!paramMap.getString("MBR_PW_NEW").equals(paramMap.getString("MBR_PW_NEW_R"))) {
				jObj.put("message", egovMessageSource.getMessage("fail.user.passwordUpdate2"));
				jObj.put("updateYn", "N");
				model.addAttribute("outData", jObj.toString());
				return "common/out";
			}*/
			if (!mbrPwNew.equals(mbrPwNewR)) {
				jObj.put("message", egovMessageSource.getMessage("fail.user.passwordUpdate2"));
				jObj.put("updateYn", "N");
				model.addAttribute("outData", jObj.toString());
				return "common/out";
			}

			// 새 비밀번호가 같으니 수정
			//userInfo.put("MBR_PW", EgovFileScrty.encryptPassword(paramMap.getString("MBR_ID") + paramMap.getString("MBR_PW_NEW"), paramMap.getString("MBR_ID")));
			userInfo.put("MBR_PW", EgovFileScrty.encryptPassword(paramMap.getString("MBR_ID") + mbrPwNew, paramMap.getString("MBR_ID")));
			String[] whereColumName = new String[] { "MBR_ID" };
			commService.tableSaveData("ASW_M_MBR_LOGIN", userInfo, null, whereColumName, null, null);
			commService.setGdataModHis("ASW_M_MBR_LOGIN", userInfo.getString("MBR_ID"), userInfo, UPDATE);
			jObj.put("message", egovMessageSource.getMessage("success.common.update"));
			jObj.put("updateYn", "Y");

		}
		else {
			jObj.put("message", egovMessageSource.getMessage("errors.required"));
			jObj.put("updateYn", "N");
		}

		model.addAttribute("outData", jObj.toString());
		return "common/out";
	}

	/**
	 * 고객 비밀번호 암호화(초기값 셋팅을 위한 로직)
	 * 
	 * @param model
	 * @return
	 * @throws Exception
	 */
	/*	@SuppressWarnings("unchecked")
		@RequestMapping("encryptPassword.action")
		public String encryptPassword(ModelMap model) throws Exception {
			List<Map<String, Object>> list = (List<Map<String, Object>>) mmService.selectEncryptPassword();
			for (Map<String, Object> map : list) {
				String MBR_ID = CommonUtil.nvl(map.get("MBR_ID"));
				map.put("MBR_PW", EgovFileScrty.encryptPassword(MBR_ID + map.get("MBR_PW_TEMP"), MBR_ID));
				map.remove("MBR_ID");
				map.remove("MBR_PW_TEMP");
				commService.tableUpdate("ASW_M_MBR_LOGIN", map, null, null, "AND MBR_ID = '" + MBR_ID + "' AND MBR_PW_TEMP IS NOT NULL ", null);
			}
			model.addAttribute("outData", "암호화 완료!!!");
			return "common/httpOut";
		}
	*/ /**
		 * 고객 비밀번호 암호화(초기값 셋팅을 위한 로직)
		 * 
		 * @param model
		 * @return
		 * @throws Exception
		 */
	/*	@SuppressWarnings("unchecked")
		@RequestMapping("encryptPassword2.action")
		public String encryptPassword2(ModelMap model) throws Exception {
			List<Map<String, Object>> list = (List<Map<String, Object>>) mmService.selectEncryptPassword2();
			for (Map<String, Object> map : list) {
				String orderNo = CommonUtil.nvl(map.get("ORDER_NO"));
				map.put("NON_MBR_PW", EgovFileScrty.encryptPassword(orderNo + map.get("NON_MBR_PW"), orderNo));
				map.remove("ORDER_NO");
				commService.tableUpdate("O_NON_MBR_PW", map, null, null, "AND ORDER_NO = '" + orderNo + "' AND NON_MBR_PW IS NOT NULL ", null);
			}
	
			model.addAttribute("outData", "암호화 완료!!!");
			return "common/httpOut";
		}
	*/
}
