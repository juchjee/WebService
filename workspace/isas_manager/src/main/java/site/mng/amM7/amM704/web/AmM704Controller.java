package site.mng.amM7.amM704.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.mng.amM7.amM704.service.impl.AmM704Service;
import site.mng.sa.service.EgovFileScrty;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM7/amM704")
public class AmM704Controller extends BaseController {

	private static final String conUrl = MNG_URI + "amM7/amM704/";

	@Resource(name = "AmM704Service" )
	private AmM704Service amM704Service;

	@RequestMapping(value = "amM704.do")
	public String amM7004(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);

		List<?> authList = amM704Service.amM704A(paramMap);
		List<?> positionList = amM704Service.amM704P(paramMap);
		model.addAttribute("authList", authList);
		model.addAttribute("positionList", positionList);
		model.addAttribute("conUrl", conUrl);
		return conUrl + "amM704";
	}

	@RequestMapping(value = "amM704.action")
	public String amM7004Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> list = amM704Service.amM704(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/**
	 * 관리자 관리 : 담당자 팝업
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping(value = "amM704Pop.action")
	public String amM7004Pop(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		List<?> authList = amM704Service.amM704A(paramMap);
		List<?> positionList = amM704Service.amM704P(paramMap);
		if(!paramMap.equals("")){
			Map<String, Object> admMap = amM704Service.amM704PD(paramMap);
			model.addAttribute("admDetail", admMap);
		}
		model.addAttribute("authList", authList);
		model.addAttribute("positionList", positionList);
		return conUrl + "amM704Pop";
	}

	@RequestMapping(value = "amM704IC.action")
	public String amM7004IC(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> list = amM704Service.amM704(paramMap);
		if(list.size()>0){
			model.addAttribute("outData", "ng");
		}else if(list.size()==0){
			model.addAttribute("outData", "ok");
		}
		return "common/out";
	}

	/**
	 * 관리자 관리 : 담당자 등록 및 수정
	 * @param model
	 * @return String
	 * @throws Exception
	 */
	@RequestMapping(value = "amM704PSave.action")
	public String amM7004PSave(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);

		String enAdmPw = EgovFileScrty.encryptPassword(paramMap.getString("ADM_ID") + paramMap.getString("ADM_PW"), paramMap.getString("ADM_ID"));
		paramMap.put("ADM_PW", enAdmPw);

		String[] whereColumName = null;
		whereColumName = new String[]{"ADM_ID"};
		commService.tableSaveData("ASW_S_ADM", paramMap, null, whereColumName , null, null);

		return messageAction(egovMessageSource.getMessage("success.common.save"), "parent.$.fancybox.close(); parent.location.reload(true); ", model);
	}

}
