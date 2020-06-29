package site.front.main.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.vo.LoginVO;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.front.main.service.impl.MainService;

@Controller
@RequestMapping(value = IConstants.ISDS_URL + "main")
public class MainController extends BaseController{

	/** MmService */
	@Resource(name = "MainService")
	private MainService mainService;

	/**
	 * 메인화면
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("home.do")
	public String main(@RequestParam Map<String, Object> commandMap,  ModelMap model)  throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);

		model.addAttribute("workCount", mainService.getWorkCount(EgovUserDetailsHelper.getCustCd()));


		model.addAttribute("mainNoticeList", mainService.getMainNoticeList());
		model.addAttribute("paramMap", paramMap);

		return ISDS_URL + "main/home";
	}

	/**
	 * 팝업조회
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("popup.action")
	public String popup(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model)  throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("popupInfo", mainService.popupView(CommonUtil.nvl(paramMap.get("POPUP_SEQ"))));

		return ISDS_URL + "comm/popup";
	}

	/**
	 * 이벤트 동영상 팝업조회
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("eventMoviePopup.action")
	public String eventMoviePopup(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model)  throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("paramMap", paramMap);
		return ISDS_URL + "comm/eventMoviePopup";
	}
}
