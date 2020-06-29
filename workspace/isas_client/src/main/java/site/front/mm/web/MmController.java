package site.front.mm.web;

import java.util.HashMap;
import java.util.Map;

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

import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.vo.LoginVO;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.front.mm.service.impl.MmService;
import site.front.user.service.impl.UserService;

@Controller
@RequestMapping(value = IConstants.ISDS_URL + "mm")/* ISDS/mm/ */
public class MmController extends BaseController{

	private static final String conUrl = ISDS_URL + "mm/";

	/** MmService */
	@Resource(name = "MmService")
	private MmService mmService;

	/** UserService */
	@Resource(name = "UserService")
	private UserService userService;

	/**
	 * 로그인 화면으로 들어간다
	 * @param vo - 로그인후 이동할 URL이 담긴 LoginVO
	 * @return 로그인 페이지
	 * @exception Exception
	 */
	@RequestMapping(value = "acessLogin.do")
	public String loginUsrView(@RequestParam MultiValueMap<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		if (isLogIn()) {
			return "redirect:" + ROOT_URI + MAIN_PAGE;
		}else{
			init(model);
			model.addAttribute("notForwardHistory", true);

			model.addAttribute("conUrl", ROOT_URI + conUrl);
			model.addAttribute("actionLoginUri", ROOT_URI + conUrl + "actionLogin.action");


			return conUrl + "acessLogin";
		}
	}



	/**
	 * 로그인
	 * @param vo - 아이디, 비밀번호가 담긴 LoginVO
	 * @param request - 세션처리를 위한 HttpServletRequest
	 * @return result - 로그인결과(세션정보)
	 * @exception Exception
	 */
	@RequestMapping(value = "agencyLogin.action")
	public String agencyLogin(@ModelAttribute("loginVO") LoginVO loginVO, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		init(model);
		model.addAttribute("notForwardHistory", true);
//		String loginMsg = null;
//		if(loginVO != null && loginVO.getMbrId() != null && !loginVO.getMbrId().equals("")){

//			loginMsg = loginProc(loginVO, resultVO, request, response, model);
//		}

			LoginVO resultVO = mmService.actionLogin(loginVO);
			request.getSession().setAttribute("loginVO", resultVO);


			return messageRedirect("", MAIN_PAGE, model);
	}
	/**
	 * 대리점아이디비번확
	 * @exception Exception
	 */
	@RequestMapping(value = "agencyLoginChk.action")
	public String agencyLoginChk(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		    String custCd = mmService.loginChk(paramMap);

			Map<String, Object> data = new HashMap<String, Object>();
		    if(!CommonUtil.nvl(custCd).equals("")){
		    	paramMap.put("CUST_CD", custCd);
		    	data.put("loginFlag", "Y");
		    	data.put("custNm", mmService.custNm(paramMap));
				data.put("agencyList", CommonUtil.listToJsonString(mmService.aSZ130List(paramMap)));
		    }else{
		    	data.put("loginFlag", "N");
		    }

			model.addAttribute("outData", CommonUtil.mapToJsonString(data));
			return "common/out";
	}



	/**
	 * 대리점기사리스트
	 * @exception Exception
	 */
	@RequestMapping(value = "ASZ130Ajax.action")
	public String ASZ130Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);

			model.addAttribute("outData", CommonUtil.listToJsonString(mmService.aSZ130List(paramMap)));
			return "common/out";
	}






	/**
	 * 로그아웃한다.
	 * @return String
	 * @exception Exception
	 */
	@RequestMapping(value = "actionLogSystem.out.action")
	public String actionLogout(ModelMap model) throws Exception {
		init(model);
		EgovUserDetailsHelper.removeAllAttribute();
		return messageRedirect("정상적으로 로그 아웃 되었습니다.", MAIN_PAGE, model);
	}

}
