package site.front.cs.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.front.cs.service.impl.CsService;
import site.front.mm.service.impl.MmService;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.FileUpLoad;
import egovframework.cmmn.util.PagingUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;


@Controller
@RequestMapping(value = IConstants.ISDS_URL + "cs")
public class CsController extends BaseController{

	private static final String conUrl = ISDS_URL + "cs/";

	/** EtcService */
	@Resource(name = "CsService")
	private CsService csService;

	/** MmService */
	@Resource(name = "MmService")
	private MmService mmService;

	@RequestMapping(value = "telCsI.do")
	public String talCsI(@RequestParam Map<String, Object> commandMap, ModelMap model, HttpServletRequest request) throws Exception {
		init(model);
		if(isLogIn()){
			model.addAttribute("mbr", mmService.actionLogin(getLoginVO()));
		}else{
			commandMap.put("referUrl", CommonUtil.getWebUrl("cs/telCsI.do"));
			EgovUserDetailsHelper.setAttribute("loginParams", commandMap);
			@SuppressWarnings("unchecked")
			HashMap<String, String> nonLoginMap = (HashMap<String, String>) EgovUserDetailsHelper.getAttribute("nonLogin");
			if(nonLoginMap == null){
				if(!CommonUtil.isMobile(request)){
					return conUrl + "telCs_non";
				}
			}
		}


		model.addAttribute("itmGubunList", csService.itmGubunList(null));
		model.addAttribute("timeTableList", csService.csTimeTableList());

		String uri="";
		if(CommonUtil.isMobile(request)){
			uri = "telCsI_m";
		}else{
			uri = "telCsI";
		}

		return conUrl + uri;
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

	@RequestMapping(value = "modelList.action")
	public String modelList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap);
		List<?> modelList = csService.modelList(paramMap);

		model.addAttribute("outData", CommonUtil.listToJsonString(modelList));

		return "common/out";
	}

	@RequestMapping(value = "tserviceI.do")
	public String tserviceI(@RequestParam Map<String, Object> commandMap, ModelMap model, HttpServletRequest request) throws Exception {
		init(model);
		if(isLogIn()){
			model.addAttribute("mbr", mmService.actionLogin(getLoginVO()));
		}else{
			commandMap.put("referUrl", CommonUtil.getWebUrl("cs/tserviceI.do"));
			EgovUserDetailsHelper.setAttribute("loginParams", commandMap);
			@SuppressWarnings("unchecked")
			HashMap<String, String> nonLoginMap = (HashMap<String, String>) EgovUserDetailsHelper.getAttribute("nonLogin");
			if(nonLoginMap == null){
				if(!CommonUtil.isMobile(request)){
					return conUrl + "tservice_non";
				}
			}
		}

		String uri="";
		if(CommonUtil.isMobile(request)){
			uri = "tserviceI_m";
		}else{
			uri = "tserviceI";
		}

		return conUrl + uri;
	}


	@RequestMapping(value = "csSave.action")
	public String tserviceSave(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		init(model);
		try{

			FileUpLoad fileUpLoad = new FileUpLoad(request, response);
			String savePath = "csImg";
			String[] uploadName ={"dtlImgPath"};
			UnCamelMap<String, Object>  param = fileUpLoad.imgFileUpload(savePath,uploadName);

			param.put("REG_IP", request.getRemoteAddr());
			param.put("REG_AGENT", request.getHeader("User-Agent"));
			String asTempNo = csService.tserviceSave(param, fileUpLoad, savePath, uploadName, isLogIn());

			System.out.println("asTempNo : " + asTempNo);
			String returnUrl = "";
			if(param.getString("CS_TYPE").equals("TEL")){
				returnUrl = "telCsV";
			}else if(param.getString("CS_TYPE").equals("SER")){
				returnUrl = "tserviceV";
			};
			return messageRedirect(egovMessageSource.getMessage("success.common.insert"), ROOT_URI + conUrl + returnUrl+".do?asTempNo="+asTempNo, model);
		}catch(Exception e){
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI +"main"+ "home.do", model);
		}
	}

	@RequestMapping(value = "telCsV.do")
	public String talCsV(@RequestParam Map<String, Object> commandMap,  ModelMap model, HttpServletRequest request) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap,model);
		model.addAttribute("csInfo", csService.csInfo(paramMap));
		List<?> fileList = csService.csFileList(paramMap);
		model.addAttribute("fileList", fileList);

		String uri="";
		if(CommonUtil.isMobile(request)){
			uri = "telCsV_m";
		}else{
			uri = "telCsV";
		}

		return conUrl + uri;
	}

	@RequestMapping(value = "tserviceV.do")
	public String tserviceV(@RequestParam Map<String, Object> commandMap,  ModelMap model, HttpServletRequest request) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap,model);
		model.addAttribute("csInfo", csService.csInfo(paramMap));
		List<?> fileList = csService.csFileList(paramMap);
		model.addAttribute("fileList", fileList);

		String uri="";
		if(CommonUtil.isMobile(request)){
			uri = "tserviceV_m";
		}else{
			uri = "tserviceV";
		}

		return conUrl + uri;
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
	public String cssearch(@RequestParam Map<String, Object> commandMap, ModelMap model, HttpServletRequest request) throws Exception {
		init(model);
		EgovUserDetailsHelper.getAttribute("nonLogin");
		if(! isLogIn() && EgovUserDetailsHelper.getAttribute("nonLogin") == null){
			commandMap.put("referUrl", CommonUtil.getWebUrl("cs/cssearch.do"));
			EgovUserDetailsHelper.setAttribute("loginParams", commandMap);
			if(!CommonUtil.isMobile(request)){
			return "forward:cssearch_v.do";
			}
		}

		String uri="";
		if(CommonUtil.isMobile(request)){
			uri = "cssearch_m";
		}else{
			uri = "cssearch";
		}

		UnCamelMap<String, Object> paramMap = init(commandMap);
		if(isLogIn()){

			paramMap.put("mbrId", getLoginVO().getMbrId());

			int totalCnt = csService.csInfoListCount(paramMap);
			model.addAttribute("totalCnt",totalCnt);

			int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
			PagingUtil pageInfo = new PagingUtil(totalCnt, page);

			paramMap.put("startPageNum", pageInfo.getStartPageNum());
			paramMap.put("endPageNum", pageInfo.getEndPageNum());

			List<?> csInfoList = csService.csInfoList(paramMap);
			model.addAttribute("csInfoList",csInfoList);
			model.addAttribute("pageTag", pageInfo.getPagesStrTag());
			model.addAttribute("pageInfo",pageInfo);
			model.addAttribute("skey",paramMap.getString("SKEY"));

			return conUrl + uri;
		}else{
			@SuppressWarnings("unchecked")
			HashMap<String, String> nonLoginMap = (HashMap<String, String>) EgovUserDetailsHelper.getAttribute("nonLogin");
			if(nonLoginMap != null){
			paramMap.put("mbrDi", nonLoginMap.get("mbrDi"));
			int totalCnt = csService.csInfoListCount(paramMap);
			model.addAttribute("totalCnt",totalCnt);

			int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
			PagingUtil pageInfo = new PagingUtil(totalCnt, page);

			paramMap.put("startPageNum", pageInfo.getStartPageNum());
			paramMap.put("endPageNum", pageInfo.getEndPageNum());

			List<?> csInfoList = csService.csInfoList(paramMap);
			model.addAttribute("csInfoList",csInfoList);
			model.addAttribute("pageTag", pageInfo.getPagesStrTag());
			model.addAttribute("pageInfo",pageInfo);
				return conUrl + uri;
			}else{
				return conUrl + uri;

			}

		}

	}
	@RequestMapping(value = "cssearch_v.do")
	public String cssearch_v(@RequestParam Map<String, Object> commandMap,  ModelMap model, HttpServletRequest request) throws Exception {
//		UnCamelMap<String, Object> paramMap = init(commandMap,model);
		model.addAttribute("referUrl", CommonUtil.getWebUrl("cs/cssearch.do"));
		return conUrl + "cssearch_v";
	}

	@RequestMapping(value = "cssearchV.do")
	public String cssearchV(@RequestParam Map<String, Object> commandMap,  ModelMap model, HttpServletRequest request) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap,model);
		model.addAttribute("csInfo", csService.csInfo(paramMap));
		List<?> fileList = csService.csFileList(paramMap);
		model.addAttribute("fileList", fileList);

		String uri="";
		if(CommonUtil.isMobile(request)){
			uri = "cssearchV_m";
		}else{
			uri = "cssearchV";
		}

		return conUrl + uri;
	}

	@RequestMapping(value = "csCancel.action")
	public String csCancel(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("STAT_BC", "C");
		try{
			commService.tableUpdate("ASW_CS_MST", paramMap, null, null, "AND AS_TEMP_NO = '"+paramMap.getString("AS_TEMP_NO")+"'", null);
			commService.setGdataModHis("ASW_CS_MST", "AS_TEMP_NO : "+paramMap.getString("AS_TEMP_NO"), paramMap, DELETE);

			return messageRedirect(egovMessageSource.getMessage("success.common.cancel"), ROOT_URI + conUrl + "cssearch.do", model);
		}catch(Exception e){
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI +"main"+ "home.do", model);
		}

	}



	@RequestMapping(value = "emailRule.do")
	public String emailRule(@RequestParam Map<String, Object> commandMap,  ModelMap model, HttpServletRequest request) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap,model);
		model.addAttribute("csInfo", csService.csInfo(paramMap));

		String uri="";
		if(CommonUtil.isMobile(request)){
			uri = "emailRule_m";
		}else{
			uri = "emailRule";
		}

		return conUrl + uri;
	}
	@RequestMapping(value = "privateRule.do")
	public String privateRule(@RequestParam Map<String, Object> commandMap,  ModelMap model, HttpServletRequest request) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap,model);
		model.addAttribute("csInfo", csService.csInfo(paramMap));

		String uri="";
		if(CommonUtil.isMobile(request)){
			uri = "privateRule_m";
		}else{
			uri = "privateRule";
		}

		return conUrl + uri;
	}
	@RequestMapping(value = "termsRule.do")
	public String termsRule(@RequestParam Map<String, Object> commandMap,  ModelMap model, HttpServletRequest request) throws Exception {
		UnCamelMap<String, Object> paramMap = init(commandMap,model);
		model.addAttribute("csInfo", csService.csInfo(paramMap));

		String uri="";
		if(CommonUtil.isMobile(request)){
			uri = "termsRule_m";
		}else{
			uri = "termsRule";
		}

		return conUrl + uri;
	}
}
