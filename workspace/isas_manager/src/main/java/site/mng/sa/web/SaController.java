package site.mng.sa.web;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.vo.LoginVO;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.mng.sa.service.impl.SaService;

@Controller
@RequestMapping(value = IConstants.MNG_URI + "sa")// mng/sa/
public class SaController extends BaseController{

	private static final String conUrl = MNG_URI + "sa/";

	/** SaService */
	@Resource(name = "SaService")
	private SaService saService;

	/**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "egovLoginUsr.action")
	public String loginUsrView(ModelMap model, RedirectAttributes redirectAttributes) throws Exception {
		init(model);
		if (isLogIn()) {
			//return messageRedirect("이미 로그인 중입니다!", ROOT_URI + SA_MAIN_PAGE, model);
			return messageRedirect(null, ROOT_URI + SA_MAIN_PAGE, model);
		}else{
			return conUrl + "egovLoginUsr";
		}
	}

	/**
	 * 일반(세션) 로그인을 처리한다
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value = "actionLogin.action")
	public String actionLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		// 1. 일반 로그인 처리
		LoginVO resultVO = saService.actionLogin(loginVO);
		if (resultVO != null && !CommonUtil.nvl(resultVO.getAdmId()).equals("")) {
			String commTableNm = "ASW_S_ADM_LOGIN_HIS";
			if(!CommonUtil.nvl(resultVO.getUseFlagYn()).equals("Y")){//사용 권한이 없는 경우
				return messageRedirect(egovMessageSource.getMessage("fail.user.id"), MAIN_PAGE, model);
			}
			if(CommonUtil.nvl(resultVO.getAdmAuthCd()).equals("")){//사용자 그룹 권한이 없는 경우
				return messageRedirect(egovMessageSource.getMessage("fail.user.id"), MAIN_PAGE, model);
			}
			resultVO.setAdmLoginIp(request.getRemoteAddr());
			resultVO.setLogInDate(CommonUtil.getDate2Str("yyyy년 MM월 dd일 HH시 mm분 로그인", new Date()));
			// 2-1. 로그인 정보를 세션에 저장
			request.getSession().setAttribute("loginVO", resultVO);

			// 2-2. 로그인 정보 저장
			UnCamelMap<String, Object> paramMap = init(CommonUtil.converObjectToMap(resultVO));
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			matchingColumName.put("ADM_LOGIN_DT", "$idate");
			commService.tableInatall(commTableNm, paramMap, matchingColumName);

			return messageRedirect(null, SA_MAIN_PAGE, model);
		} else {
			return messageRedirect(egovMessageSource.getMessage("fail.common.login"), MAIN_PAGE, model);
		}
	}

	/**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "actionLogout.do")
	public String actionLogout(ModelMap model) throws Exception {
		init(model);
		EgovUserDetailsHelper.removeAllAttribute();
		return messageRedirect("정상적으로 로그 아웃 되었습니다.", MAIN_PAGE, model);
	}

	@RequestMapping(value = "EgovContent.do")
	public String EgovContent(HttpServletRequest request, ModelMap model) throws Exception {
		logger.info("EgovContent");
		return "";
	}

	/**
	 * 아이디/비밀번호 찾기 화면으로 들어간다
	 * @param
	 * @return 아이디/비밀번호 찾기 페이지
	 * @exception Exception
	 */
	/*@RequestMapping(value = "/uat/uia/egovIdPasswordSearch.do")
	public String idPasswordSearchView(ModelMap model) throws Exception {

		// 1. 비밀번호 힌트 공통코드 조회
		ComDefaultCodeVO vo = new ComDefaultCodeVO();
		vo.setCodeId("COM022");
		List<?> code = cmmUseService.selectCmmCodeDetail(vo);
		model.addAttribute("pwhtCdList", code);

		return "egovframework/com/uat/uia/EgovIdPasswordSearch";
	}*/

	/**
	 * 아이디를 찾는다.
	 * @param vo - 이름, 이메일주소, 사용자구분이 담긴 LoginVO
	 * @return result - 아이디
	 * @exception Exception
	 */
	/*@RequestMapping(value = "/uat/uia/searchId.do")
	public String searchId(@ModelAttribute("loginVO") LoginVO loginVO, ModelMap model) throws Exception {

		if (loginVO == null || loginVO.getName() == null || loginVO.getName().equals("") && loginVO.getEmail() == null || loginVO.getEmail().equals("")
				&& loginVO.getUserSe() == null || loginVO.getUserSe().equals("")) {
			return "egovframework/com/cmm/egovError";
		}

		// 1. 아이디 찾기
		loginVO.setName(loginVO.getName().replaceAll(" ", ""));
		LoginVO resultVO = loginService.searchId(loginVO);

		if (resultVO != null && resultVO.getId() != null && !resultVO.getId().equals("")) {

			model.addAttribute("resultInfo", "아이디는 " + resultVO.getId() + " 입니다.");
			return "egovframework/com/uat/uia/EgovIdPasswordResult";
		} else {
			model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.idsearch"));
			return "egovframework/com/uat/uia/EgovIdPasswordResult";
		}
	}*/

	/**
	 * 비밀번호를 찾는다.
	 * @param vo - 아이디, 이름, 이메일주소, 비밀번호 힌트, 비밀번호 정답, 사용자구분이 담긴 LoginVO
	 * @return result - 임시비밀번호전송결과
	 * @exception Exception
	 */
	/*@RequestMapping(value = "/uat/uia/searchPassword.do")
	public String searchPassword(@ModelAttribute("loginVO") LoginVO loginVO, ModelMap model) throws Exception {

		if (loginVO == null || loginVO.getId() == null || loginVO.getId().equals("") && loginVO.getName() == null || loginVO.getName().equals("") && loginVO.getEmail() == null
				|| loginVO.getEmail().equals("") && loginVO.getPasswordHint() == null || loginVO.getPasswordHint().equals("") && loginVO.getPasswordCnsr() == null
				|| loginVO.getPasswordCnsr().equals("") && loginVO.getUserSe() == null || loginVO.getUserSe().equals("")) {
			return "egovframework/com/cmm/egovError";
		}

		// 1. 비밀번호 찾기
		boolean result = loginService.searchPassword(loginVO);

		// 2. 결과 리턴
		if (result) {
			model.addAttribute("resultInfo", "임시 비밀번호를 발송하였습니다.");
			return "egovframework/com/uat/uia/EgovIdPasswordResult";
		} else {
			model.addAttribute("resultInfo", egovMessageSource.getMessage("fail.common.pwsearch"));
			return "egovframework/com/uat/uia/EgovIdPasswordResult";
		}
	}*/
}
