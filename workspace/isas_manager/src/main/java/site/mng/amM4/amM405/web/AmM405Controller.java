package site.mng.amM4.amM405.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.FileUpLoad;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.mng.amM4.amM405.service.impl.AmM405Service;

/**
 * 배너관리
 * @author vary
 *
 */
@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM4/amM405")
public class AmM405Controller extends BaseController {

	private static final String conUrl = MNG_URI + "amM4/amM405/";

	/** 팝업관리 서비스 */
	@Resource(name = "AmM405Service")
    protected AmM405Service amM405Service;

	/**
	 * 팝업 관리 리스트 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM405.do")
	public String amM405(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		return conUrl + "amM405";
	}


	/**
	 * 팝업 관리 리스트 검색
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM405.action")
	public String amM405_action(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> list = amM405Service.amM405Search(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/**
	 * 팝업관리 등록 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM405I.action")
	public String amM405I(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		return conUrl + "amM405I";
	}

	/**
	 * 팝업관리 수정 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM405U.action")
	public String amM405U(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		model.addAttribute("popupInfo",amM405Service.amM405View(paramMap));
		return conUrl + "amM405U";
	}

	/**
	 * 팝업관리 미리보기
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("amM405R.action")
	public String amM405R(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model)  throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("popupInfo", amM405Service.amM405View(paramMap));
		return conUrl + "amM405R";
	}

	/**
	 * 팝업관리 등록/수정
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM405Save.action")
	public String amM405Save(HttpServletRequest request, HttpServletResponse response,  ModelMap model) throws Exception {
		init(model);
		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
		String savePath = "popupHtml";
		String[] uploadName ={"popHtmlPath"};
		UnCamelMap<String, Object>  param = fileUpLoad.popFileUpload(savePath,uploadName);

		amM405Service.amM405Save(param,savePath,uploadName);

		model.addAttribute("action", "parent.fnSearch && parent.fnSearch();");
		return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + "amM405U.action?popupSeq=" + param.getString("POPUP_SEQ"), model);
	}
}
