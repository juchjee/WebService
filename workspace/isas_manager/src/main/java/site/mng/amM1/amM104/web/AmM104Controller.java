package site.mng.amM1.amM104.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.mng.amM1.amM104.service.impl.AmM104Service;

/**
 * 회원관리
 * @author vary
 *
 */
@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM1/amM104") /* /mng/amM1/amM104/ */
public class AmM104Controller extends BaseController{

	private static final String conUrl = MNG_URI + "amM1/amM104/";

	/** AmM104Service */
	@Resource(name = "AmM104Service")
	private AmM104Service amM104Service;

	@RequestMapping(value = "amM104.do")
	public String cbtsIaAm1004(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("conUrl", conUrl);
		model.addAttribute("totalCount", amM104Service.dCount(paramMap));
		return conUrl + "amM104";
	}

	@RequestMapping(value = "amM104.action")
	public String cbtsIaAm1004a(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("conUrl", conUrl);
		List<?> list = amM104Service.amM104(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

}
