package site.mng.amM7.amM701.web;

import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.Net;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.mng.amM7.amM701.service.impl.AmM701Service;

@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM7/amM701")
public class AmM701Controller extends BaseController {

	private static final String conUrl = MNG_URI + "amM7/amM701/";

	/** 설정 : 회사기본정보 설정 **/
	@Resource(name = "AmM701Service")
	private AmM701Service amM701Service;

	@RequestMapping(value = "amM701.do")
	public String amM7001(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("amM701Com", amM701Service.amM701Com(paramMap));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "amM701";
	}

	/** 설정 : 회사기본정보 등록 및 수정 **/
	@RequestMapping(value = "amM701Save.action")
	public String amM701SAVE(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		// 일반정보 등록 및 수정 처리 : paramMap
		String[] whereColumName = null;
		if(!CommonUtil.nvl(paramMap.get("COMPANY_REG_KEY")).equals("")){
			whereColumName = new String[]{"COMPANY_REG_KEY"};
		}
		commService.tableSaveData("ASW_S_COMPANY", paramMap, null, whereColumName , null, null);
		// 회사기본정보 리셋
		Net net = new Net();
		net.sendMessage(null, "resetCompany");
		return messageRedirect(egovMessageSource.getMessage("success.common.insert"), conUrl + "amM701.do", model);
	}

}
