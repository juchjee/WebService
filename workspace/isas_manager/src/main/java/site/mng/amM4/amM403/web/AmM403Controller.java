package site.mng.amM4.amM403.web;

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
import site.mng.amM4.amM403.service.impl.AmM403Service;

/**
 * SMS관리
 * @author vary
 *
 */
@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM4/amM403")
public class AmM403Controller extends BaseController {

	private static final String conUrl = MNG_URI + "amM4/amM403/";

	/** SMS관리 서비스 */
	@Resource(name = "AmM403Service")
    protected AmM403Service amM403Service;

	@RequestMapping(value = "amM403.do")
	public String amM403(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		return conUrl + "amM403";
	}

	@RequestMapping(value = "amM403.action")
	public String amM403A(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> outData = amM403Service.amM403(paramMap);

		model.addAttribute("outData", CommonUtil.listToJsonString(outData));
		return "common/out";
		
	}

	@RequestMapping(value = "amM403U.action")
	public String amM403U(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		model.addAttribute("smsInfo", amM403Service.amM403U(paramMap));
		model.addAttribute("msgVariableList", commService.msgVariableList(paramMap));
		return conUrl + "amM403U";
	}



	@RequestMapping(value = "amM403Save.action")
	public String amM403Save(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		amM403Service.amM403Save(paramMap);

		model.addAttribute("action", "parent.fnSearch && parent.fnSearch();");
		return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + "amM403U.action?msgRoleCd=" + paramMap.getString("MSG_ROLE_CD")+"&msgDivRc=" + paramMap.getString("MSG_DIV_RC"), model);
	}

}