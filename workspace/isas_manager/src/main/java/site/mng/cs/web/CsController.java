package site.mng.cs.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.mng.cs.service.impl.CsService;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;


@Controller


@RequestMapping(value = IConstants.MNG_URI + "cs")
public class CsController extends BaseController{
	private static final String conUrl = MNG_URI + "cs/";

	/** EtcService */
	@Resource(name = "CsService")
	private CsService csService;

	
	
	/**
	 * 예약관리 > 근무일 콜 설정 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "scheduler.do")
	public String scheduler(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "scheduler";
	}

	
	
	
	/**
	 * 예약관리 > 근무일 콜 설정 : 팝업 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "schedulerP1.action")
	public String schedulerP1(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);
		
		model.addAttribute("workDt", paramMap.getString("WORK_DT"));
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "schedulerP1";
	}
	
	
	
	
	/**
	 * 예약관리 > 근무일 콜 설정 : 팝업 수정
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "schedulerP1Save.action")
	public String schedulerP1Save(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		
		String[] whereColumName = new String[]{"PLAN_DT"};
		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("PLAN_DT", paramMap.getString("PLAN_DT"));
		map.put("FLAG_ON_OFF", paramMap.getString("FLAG_ON_OFF"));
		
		Map<String, Object> listMap = new HashMap<String, Object>();
		listMap.put("PLAN_DT", paramMap.getString("PLAN_DT"));
		int listSize = commService.getTableList("ASW_PLAN_SWITCH", listMap, null).size();
		String dataModTp = INSERT;
		if(listSize > 0){
			dataModTp = UPDATE;
		}
		
		commService.tableSaveData("ASW_PLAN_SWITCH", map, matchingColumName, whereColumName , null, null);
		commService.setGdataModHis("ASW_PLAN_SWITCH", paramMap.getString("PLAN_DT"), map, dataModTp);

		model.addAttribute("workDt", paramMap.getString("PLAN_DT"));
		
		return messageRedirect(egovMessageSource.getMessage("success.common.update"), conUrl + "schedulerP1.action?workDt="+paramMap.getString("PLAN_DT"), model);
	}
	
	
	
	
	
	/**
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "telCsL.do")
	public String telCsL(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "telCsL";
	}
	
	@RequestMapping(value = "itmGubunList.action")
	public String itmGubunList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap);
		List<?> itmGubunList = csService.itmGubunList(paramMap);

		model.addAttribute("outData", CommonUtil.listToJsonString(itmGubunList));

		return "common/out";
	}
	
	
	/**
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "telCsL.action")
	public String telCsLAjax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("conUrl", conUrl);
		paramMap.put("CS_TYPE", "TEL");
		List<?> csInfoList = csService.csInfoList(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(csInfoList));
		return "common/out";
	}

	/**
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "telCsR.action")
	public String telCsR(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		Map<String, Object> viewMap = csService.csInfo(paramMap);
		model.addAttribute("csInfo", viewMap);
		model.addAttribute("timeTableList", csService.csTimeTableList());

		List<?> fileList = csService.csFileList(paramMap);
		model.addAttribute("fileList", fileList);
		model.addAttribute("conUrl", conUrl);
		return conUrl + "telCsR";
	}
	
	/**
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "tserviceL.do")
	public String tserviceL(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "tserviceL";
	}

	
	/**
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "tserviceR.action")
	public String tserviceR(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		Map<String, Object> viewMap = csService.csInfo(paramMap);
		model.addAttribute("csInfo", viewMap);

		List<?> fileList = csService.csFileList(paramMap);
		model.addAttribute("fileList", fileList);
		model.addAttribute("conUrl", conUrl);
		return conUrl + "tserviceR";
	}
	
	
	/**
	 * 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "tserviceL.action")
	public String tserviceLAjax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("conUrl", conUrl);
		paramMap.put("CS_TYPE", "SER");
		List<?> csInfoList = csService.csInfoList(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(csInfoList));
		return "common/out";
	}

	

	@RequestMapping(value = "ascodeList.action")
	public String ascodeList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap);
		List<?> ascodeList = csService.ascodeList(paramMap);

		model.addAttribute("outData", CommonUtil.listToJsonString(ascodeList));

		return "common/out";
	}

	@RequestMapping(value = "csTimeMpgList.action")
	public String csTimeMpgList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap);
		List<?> csTimeMpgList = csService.csTimeMpgList(paramMap);

		model.addAttribute("outData", CommonUtil.listToJsonString(csTimeMpgList));

		return "common/out";
	}



	@RequestMapping(value = "csSave.action")
	public String tserviceSave(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> param = init(commandMap);
		try{

			String asTempNo = csService.tserviceSave(param);

			String returnUrl = "";
			if(param.getString("CS_TYPE").equals("TEL")){
				returnUrl = "telCsR";
			}else if(param.getString("CS_TYPE").equals("SER")){
				returnUrl = "tserviceR";
			};
			return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + returnUrl+".action?asTempNo="+asTempNo, model);
		}catch(Exception e){
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI +"main"+ "home.do", model);
		}
	}




	@RequestMapping("calendar.action")
	public String calendar(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);

		String year = CommonUtil.nvl(commandMap.get("year"));
		String month = CommonUtil.nvl(commandMap.get("month"));

		String CALENDAR_DT = null;
		List<?> calendarlist = null;
		if(CommonUtil.isNotNull(year) && CommonUtil.isNotNull(month)){
			CALENDAR_DT = year+month;
			paramMap.put("CALENDAR_DT", CALENDAR_DT);
			calendarlist = csService.calendarList(paramMap);
		}

		model.addAttribute("year", commandMap.get("year"));
		model.addAttribute("month", commandMap.get("month"));
		model.addAttribute("message", "ok");
		model.addAttribute("outData", CommonUtil.listToJsonString(calendarlist));
		return "common/out";
	}

	@RequestMapping(value = "cssearch.do")
	public String cssearch(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		if(isLogIn()){
//			UnCamelMap<String, Object> paramMap = init(commandMap);
//
//			int totalCnt = csService.csInfoListCount(paramMap);
//			model.addAttribute("totalCnt",totalCnt);
//
//			int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
//			PagingUtil pageInfo = new PagingUtil(totalCnt, page);
//
//			paramMap.put("startPageNum", pageInfo.getStartPageNum());
//			paramMap.put("endPageNum", pageInfo.getEndPageNum());
//
//			List<?> csInfoList = csService.csInfoList(paramMap);
//			model.addAttribute("csInfoList",csInfoList);
//			model.addAttribute("pageTag", pageInfo.getPagesStrTag());
//			model.addAttribute("pageInfo",pageInfo);


			return conUrl + "cssearch";
		}else{
			return conUrl + "cssearch";
		}

	}

	@RequestMapping(value = "cssearchV.do")
	public String cssearchV(@RequestParam Map<String, Object> commandMap,  ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("csInfo", csService.csInfo(paramMap));
		return conUrl + "cssearchV";
	}

	@RequestMapping(value = "csCancel.action")
	public String csCancel(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("STATUS", "C");
		try{
			commService.tableUpdate("ASW_CS_MST", paramMap, null, null, "AND AS_TEMP_NO = '"+paramMap.getString("AS_TEMP_NO")+"'", null);
			commService.setGdataModHis("ASW_CS_MST", "AS_TEMP_NO : "+paramMap.getString("AS_TEMP_NO"), paramMap, DELETE);

			return messageRedirect(egovMessageSource.getMessage("success.common.cancel"), ROOT_URI + conUrl + "cssearch.do", model);
		}catch(Exception e){
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI +"main"+ "home.do", model);
		}

	}
	
	/*
	 * 2019. 03. 13. ryul 전화상담예약/출장서비스 [담당자취소]
	 */
	@RequestMapping(value = "csAdmCancel.action")
	public String csAdmCancel(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			for (int i = 0; i < commandMap.size(); i++) {
				String asTempNo = CommonUtil.nvl(paramMap.get("DATA[" + i + "]"));
				commService.tableDelete("ASW_CS_MST", null, " and AS_TEMP_NO = '" + asTempNo + "'");
				map.put("AS_TEMP_NO", asTempNo);
				commService.setGdataModHis("ASW_CS_MST", "AS_TEMP_NO : " + asTempNo, map, DELETE);
			}

			return messageRedirect(egovMessageSource.getMessage("success.common.delete"), ROOT_URI + conUrl + "cssearch.do", model);
		} catch (Exception e) {
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + "main" + "home.do", model);
		}
	}

	@RequestMapping(value = "modelList.action")
	public String modelList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap);
		List<?> modelList = csService.modelList(paramMap);

		model.addAttribute("outData", CommonUtil.listToJsonString(modelList));

		return "common/out";
	}
	
	@RequestMapping(value = "custCd.action")
	public String custCdList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap);
		List<?> modelList = csService.custCdList(paramMap);

		model.addAttribute("outData", CommonUtil.listToJsonString(modelList));

		return "common/out";
	}
	
}
