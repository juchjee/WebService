package site.mng.amM1.amM103.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.HtmlUtils;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.JsonHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.mng.amM1.amM102.service.impl.AmM102Service;
import site.mng.amM1.amM103.service.impl.AmM103Service;

/**
 * 회원관리
 * @author vary
 *
 */
@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM1/amM103") /* /mng/amM1/amM103 */
public class AmM103Controller extends BaseController{

	private static final String conUrl = MNG_URI + "amM1/amM103/";

	/** CbtsIaAmService */
	@Resource(name = "AmM103Service")
	private AmM103Service amM103Service;

	@Resource(name = "AmM102Service")
	private AmM102Service amM102Service;

	@RequestMapping(value = "amM103.do")
	public String cbtsIaAm1003(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("conUrl", conUrl);
		model.addAttribute("totalCount", amM103Service.hCount(paramMap));
		return conUrl + "amM103";
	}

	@RequestMapping(value = "amM103.action")
	public String cbtsIaAm1003a(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("conUrl", conUrl);
		List<?> list = amM103Service.amM103(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "amM103Del.action")
	public String amM103Del(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("conUrl", conUrl);
		String[] idArr = CommonUtil.toStringArray(paramMap.get("ID_ARR").toString(), ",");
		for(int i=0;i<idArr.length;i++){

			paramMap.put("MBR_ID", idArr[i]);
			String mbrId = paramMap.getString("MBR_ID");
			String[] whereColumName = null;
			whereColumName = new String[]{"MBR_ID"};

			Map<String, Object> userMap = amM102Service.userInfo(mbrId);
			paramMap.put("MBR_NM", userMap.get("mbrNm"));
			paramMap.put("MBR_SCORE", userMap.get("mbrScore"));
			paramMap.put("MBR_REC", userMap.get("mbrRec"));
			paramMap.put("MBR_JOIN_DT", userMap.get("mbrJoinDt"));
			Map<String, Object> matchingColumName = new HashMap<>();
			matchingColumName.put("MBR_RSG_DT", "$idate");
			commService.tableSaveData("M_RSG_MBR", paramMap, matchingColumName, whereColumName , null, null);
			commService.setGdataModHis("M_RSG_MBR", paramMap.getString("MBR_ID"), paramMap, INSERT);

			paramMap.put("MBR_LOGIN_STATUS_YHN", "N");
			commService.tableSaveData("M_MBR_LOGIN", paramMap, null, whereColumName , null, null);
			commService.setGdataModHis("M_MBR_LOGIN", paramMap.getString("MBR_ID"), paramMap, UPDATE);

			commService.tableDelete("M_MBR", null, "and MBR_ID ='"+paramMap.getString("MBR_ID")+"'");
			commService.setGdataModHis("M_MBR", paramMap.getString("MBR_ID"), paramMap, DELETE);
		}
		return messageRedirect(egovMessageSource.getMessage("success.common.delete"), conUrl + "amM103.do", model);
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "unlockMbr.action")
	public String unlockMbr(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model, commandMap);
		boolean testProc  = false;

		String jsonStr = HtmlUtils.htmlUnescape(CommonUtil.nvl(commandMap.get("data")));
		JSONArray jsonArr = new JSONArray(jsonStr);
		List<UnCamelMap<String, Object>> paramList = JsonHelper.toUnCamelList(jsonArr);

		String returnMsg = "";
		String returnFailMsg = "";

		for(UnCamelMap<String,Object> param : paramList){
			returnMsg = egovMessageSource.getMessage("success.common.insert");
			returnFailMsg = egovMessageSource.getMessage("fail.common.insert");

			testProc = amM103Service.unlockMbr(param);
		}

			if(testProc){
				model.addAttribute("outData", returnMsg);
			}else{
				model.addAttribute("outData", returnFailMsg);
			}
				return "common/out";
	}



}
