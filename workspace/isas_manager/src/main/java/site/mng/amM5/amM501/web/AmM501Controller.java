package site.mng.amM5.amM501.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.mng.amM5.amM501.service.impl.AmM501Service;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM5/amM501")
public class AmM501Controller extends BaseController {

	private static final String conUrl = MNG_URI + "amM5/amM501/";

	@Resource(name = "AmM501Service")
	private AmM501Service amM501Service;

	@RequestMapping(value = "amM501.do")
	public String amM5001(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> funnelList = amM501Service.amM501FL(paramMap);
		model.addAttribute("funnelList", funnelList);
		List<?> typeList = amM501Service.amM501TL(paramMap);
		model.addAttribute("typeList", typeList);
		model.addAttribute("conUrl", conUrl);
		return conUrl + "amM501";
	}

	@RequestMapping(value = "amM501.action")
	public String amM5001Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> list = amM501Service.amM501L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "amM501R.action")
	public String amM5001R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		Map<String, Object> viewMap = amM501Service.amM501R(paramMap);
		model.addAttribute("viewMap", viewMap);
		return conUrl + "amM501R";
	}

	/**
	 * 상담내역 수정
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM501S.action")
	public String amM501S(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		String csNo = paramMap.getString("CS_NO");
		/*String mbrId = paramMap.getString("MBR_ID");
		if(mbrId.equals("")){
			mbrId = "guest";
		}*/

		try{
			String[] whereColumName = new String[]{"CS_NO"};
			commService.tableSaveData("ASW_M_CS", paramMap, null, whereColumName);
			commService.setGdataModHis("ASW_M_CS", csNo, paramMap, UPDATE);
			/*if( paramMap.getString("MBR_SCORE").length() > 0	){
				Map<String, Object> mbrMap = new HashMap<String, Object>();
				whereColumName = new String[]{"MBR_ID"};

				if(!mbrId.equals("guest")){
				mbrMap.put("MBR_ID", mbrId);
				mbrMap.put("MBR_SCORE", paramMap.get("MBR_SCORE"));
				commService.tableSaveData("ASW_M_MBR", mbrMap, null, whereColumName , null, null);
				}
				commService.setGdataModHis("ASW_M_MBR", csNo, mbrMap, UPDATE);
			}*/
		}catch(Exception e){
			logger.error("상담내역 수정", e);
			return messageRedirect(egovMessageSource.getMessage("fail.common.insert"), conUrl + "amM501R.action?csNo=" + csNo, model);
		}
		return messageRedirect(egovMessageSource.getMessage("success.common.insert"), conUrl + "amM501R.action?csNo=" + csNo, model);
	}


	/**
	 * 고객상담 : 삭제
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM501D.action")
	public String bbt00001D(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		Map<String,Object> paramBoardMap = new HashMap<String, Object>();
    	for(int i=0; i < commandMap.size(); i++){
    		String csNo = CommonUtil.nvl(paramMap.get("DATA["+i+"]"));
			commService.tableDelete("ASW_M_CS", null, "AND CS_NO = '"+csNo+"'");
			commService.setGdataModHis("ASW_M_CS", "CS_NO : "+csNo, paramBoardMap, DELETE);
    	}
		model.addAttribute("outData", egovMessageSource.getMessage("success.common.delete"));
		return "common/out";
	}

}