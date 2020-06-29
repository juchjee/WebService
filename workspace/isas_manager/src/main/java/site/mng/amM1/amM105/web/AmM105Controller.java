package site.mng.amM1.amM105.web;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.mng.amM1.amM105.service.impl.AmM105Service;

/**
 * 회원관리
 * @author vary
 *
 */
@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM1/amM105") /* /mng/amM1/amM105/ */
public class AmM105Controller extends BaseController{

	private static final String conUrl = MNG_URI + "amM1/amM105/";

	/** AmM105Service */
	@Resource(name = "AmM105Service")
	private AmM105Service amM105Service;

	/**
	 * 회원관리 : 포인트정책관리 목록조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM105.do")
	public String cbtsIaAm1005(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		model.addAttribute("conUrl", conUrl);
		model.addAttribute("amM105List", amM105Service.amM105(null));
		return conUrl + "amM105";
	}

	/**
	 * 회원관리 : 포인트정책관리 이용해지 및 적용
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM105U.do")
	public String amM105U(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		String commTableNm = "ASW_M_MBR_PT_PLC";
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		String[] whereColumName = {"PT_CD"};
		if(paramMap.getString("USER_YN").equals("Y")){
			paramMap.put("PT_RFCT_YN", "N");
		}else if(paramMap.getString("USER_YN").equals("N")){
			paramMap.put("PT_RFCT_YN", "Y");
		}
		commService.tableSaveData(commTableNm, paramMap, null, whereColumName , null, null);
		commService.setGdataModHis(commTableNm, paramMap.get("PT_CD"), paramMap, UPDATE);
		return messageRedirect(egovMessageSource.getMessage("success.common.update"), conUrl + "amM105.do", model);
	}

	@RequestMapping(value = "amM105PU.do")
	public String amM105PU(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		String commTableNm = "ASW_M_MBR_PT_PLC";
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		String[] whereColumName = {"PT_CD"};
		commService.tableSaveData(commTableNm, paramMap, null, whereColumName , null, null);
		commService.setGdataModHis(commTableNm, paramMap.get("PT_CD"), paramMap, UPDATE);
		return messageRedirect(egovMessageSource.getMessage("success.common.update"), conUrl + "amM105.do", model);
	}
}
