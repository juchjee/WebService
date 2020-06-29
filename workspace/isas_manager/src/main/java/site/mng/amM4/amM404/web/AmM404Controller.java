package site.mng.amM4.amM404.web;

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
import site.mng.amM4.amM404.service.impl.AmM404Service;

/**
 * 팝업관리
 * @author vary
 *
 */
@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM4/amM404")
public class AmM404Controller extends BaseController {

	private static final String conUrl = MNG_URI + "amM4/amM404/";

	/** 팝업관리 서비스 */
	@Resource(name = "AmM404Service")
    protected AmM404Service amM404Service;

	@RequestMapping(value = "amM404.do")
	public String amM404(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		return conUrl + "amM404";
	}

	@RequestMapping(value = "amM404.action")
	public String amM404A(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> outData = amM404Service.amM404(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(outData));
		return "common/out";
	}

	@RequestMapping(value = "amM404U.action")
	public String amM404U(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		model.addAttribute("emailInfo", amM404Service.amM404U(paramMap));
		model.addAttribute("msgVariableList", commService.msgVariableList(paramMap));
		return conUrl + "amM404U";
	}



	@RequestMapping(value = "amM404Save.action")
	public String amM404Save(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		amM404Service.amM404Save(paramMap);

		model.addAttribute("action", "parent.fnSearch && parent.fnSearch();");
		return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + "amM404U.action?msgRoleCd=" + paramMap.getString("MSG_ROLE_CD")+"&msgDivRc=" + paramMap.getString("MSG_DIV_RC"), model);
	}
}
