package site.front.repair.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.front.repair.service.impl.RepairService;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.FileUpLoad;
import egovframework.cmmn.util.PagingUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Controller
@RequestMapping(value = IConstants.ISDS_URL + "repair")
public class RepairController extends BaseController {

	private static final String conUrl = ISDS_URL + "repair/";

	/** EtcService */
	@Resource(name = "RepairService")
	private RepairService repairService;

	@RequestMapping(value = "inusRepairState.do")
	public String inusRepairState(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);

		paramMap.put("custCd", EgovUserDetailsHelper.getCustCd());
		int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
		model.addAttribute("page", page);
		int totalCnt = repairService.totalListCount(paramMap);
		model.addAttribute("totalCnt", totalCnt);
		PagingUtil pageInfo = new PagingUtil(totalCnt, page);
		paramMap.put("startPageNum", pageInfo.getStartPageNum());
		paramMap.put("endPageNum", pageInfo.getEndPageNum());

		if (paramMap.getString("SEARCH_TYPE").equals("")) {
			paramMap.put("SEARCH_TYPE", "2");
		}

		List<?> repairStateList = repairService.repairStateList(paramMap);

		model.addAttribute("repairStateList", repairStateList);

		model.addAttribute("pageTag", pageInfo.getPagesStrTag());
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("searchType", paramMap.getString("SEARCH_TYPE"));

		model.addAttribute("searchType", paramMap.getString("SEARCH_TYPE"));
		model.addAttribute("txtFromDt", paramMap.getString("TXT_FROM_DT"));
		model.addAttribute("txtToDt", paramMap.getString("TXT_TO_DT"));
		model.addAttribute("searchTxt", paramMap.getString("SEARCH_TXT"));
		model.addAttribute("searchTxt2", paramMap.getString("SEARCH_TXT2"));
		model.addAttribute("searchTxt3", paramMap.getString("SEARCH_TXT3"));
		model.addAttribute("dateFlag", paramMap.getString("DATE_FLAG"));

		return conUrl + "inusRepairState";
	}

	@RequestMapping(value = "inusRepairStateDetail.do")
	public String inusRepairStateDetail(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);

		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("custCd", EgovUserDetailsHelper.getCustCd());
		//inusRepairStateDetail();

		model.addAttribute("repairStateView", repairService.repairStateView(paramMap));

		return conUrl + "inusRepairStateDetail";
	}

	@RequestMapping(value = "inusRepairStateRegister.do")
	public String inusRepairStateRegister(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);

		model.addAttribute("asTyList", repairService.getCodeInfo("AS206")); //수리유형
		paramMap.put("AS_BC", "100");
		model.addAttribute("as1BcList", repairService.ascodeList(paramMap)); //A/S증상(대)
		paramMap.put("AS_BC", "300");
//		model.addAttribute("partBcList", repairService.getCodeInfo("AS210")); // 부위코드(대)
		model.addAttribute("partBcList", repairService.ascodeList(paramMap)); // 부위코드(대)
		model.addAttribute("actBcList", repairService.getCodeInfo("AS207")); //처리방법
		model.addAttribute("amtTyList", repairService.getCodeInfo("AS215")); //비용구분

		// 20190524 품목구분 추가
//		paramMap.put("SUB_CD", "1");
//		model.addAttribute("itmList", repairService.getCodeInfo("SDH08")); // 품목구분

		model.addAttribute("partItemList", repairService.getPartItemList(paramMap));

		model.addAttribute("asz120Pay", CommonUtil.nvl(repairService.getAsz120Pay(paramMap), "0"));

		model.addAttribute("actDt", CommonUtil.nvl(repairService.getActDt(paramMap), "0"));

		// itmGubun 추가 - ksh 2018.06.12
		model.addAttribute("itmGubun", paramMap.getString("ITM_GUBUN"));

		return conUrl + "inusRepairStateRegister";
	}

	@RequestMapping(value = "getModelPartItemList.action")
	public String getModelPartItemList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		UnCamelMap<String, Object> paramMap = init(commandMap);

		List<?> modelPartItemList = repairService.getPartItemList(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(modelPartItemList));
		return "common/out";
	}

	@RequestMapping(value = "repairSave.action")
	public String repairSave(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		init(model);
		try {

			FileUpLoad fileUpLoad = new FileUpLoad(request, response);
			String savePath = "repairImg";
			String[] uploadName = { "dtlImgPath" };
			UnCamelMap<String, Object> param = fileUpLoad.imgFileUpload(savePath, uploadName);
			param.put("DRV_NO", getLoginVO().getDrvNo());
			
			String asTempNo = repairService.repairSave(param, fileUpLoad, savePath, uploadName);

			String returnUrl = "inusRepairStateFinishDetail";

			return messageRedirect(egovMessageSource.getMessage("success.common.insert"), ROOT_URI + conUrl + returnUrl + ".do?asNo=" + asTempNo, model);
		}
		catch (Exception e) {
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + "main" + "home.do", model);
		}
	}

	@RequestMapping(value = "ascodeList.action")
	public String ascodeList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		UnCamelMap<String, Object> paramMap = init(commandMap);
		List<?> ascodeList = (List<?>) repairService.ascodeList(paramMap);

		model.addAttribute("outData", CommonUtil.listToJsonString(ascodeList));

		return "common/out";
	}

	@RequestMapping(value = "getPartItemList.action")
	public String getPartItemList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		UnCamelMap<String, Object> paramMap = init(commandMap);
		List<?> ascodeList = (List<?>) repairService.getCodeInfo("AS211", paramMap.getString("SUB_CD"));

		model.addAttribute("outData", CommonUtil.listToJsonString(ascodeList));

		return "common/out";
	}

	@RequestMapping(value = "inusRepairStateFinish.do")
	public String inusRepairStateFinish(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);

		paramMap.put("custCd", EgovUserDetailsHelper.getCustCd());
		int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
		model.addAttribute("page", page);
		int totalCnt = repairService.repairStateFinishListCount(paramMap);
		model.addAttribute("totalCnt", totalCnt);
		PagingUtil pageInfo = new PagingUtil(totalCnt, page);
		paramMap.put("startPageNum", pageInfo.getStartPageNum());
		paramMap.put("endPageNum", pageInfo.getEndPageNum());

		if (paramMap.getString("SEARCH_TYPE").equals("")) {
			paramMap.put("SEARCH_TYPE", "2");
		}

		List<?> repairStateFinishList = repairService.repairStateFinishList(paramMap);

		model.addAttribute("repairStateFinishList", repairStateFinishList);

		model.addAttribute("pageTag", pageInfo.getPagesStrTag());
		model.addAttribute("pageInfo", pageInfo);

		model.addAttribute("searchType", paramMap.getString("SEARCH_TYPE"));
		model.addAttribute("txtFromDt", paramMap.getString("TXT_FROM_DT"));
		model.addAttribute("txtToDt", paramMap.getString("TXT_TO_DT"));
		model.addAttribute("searchTxt", paramMap.getString("SEARCH_TXT"));
		model.addAttribute("dateFlag", paramMap.getString("DATE_FLAG"));

		return conUrl + "inusRepairStateFinish";
	}

	@RequestMapping(value = "inusRepairStateFinishDetail.do")
	public String inusRepairStateFinishDetail(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);

		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("custCd", EgovUserDetailsHelper.getCustCd());
		model.addAttribute("repairStateView", repairService.repairStateView(paramMap));

		model.addAttribute("repairPartList", repairService.repairPartList(paramMap));

		List<?> fileList = repairService.repairFileList(paramMap);

		model.addAttribute("fileList", fileList);
		model.addAttribute("asSign", repairService.asSign(paramMap));

		return conUrl + "inusRepairStateFinishDetail";
	}

	@RequestMapping(value = "inusInstallAccept.do")
	public String inusInstallAccept(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("custCd", EgovUserDetailsHelper.getCustCd());

		int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
		model.addAttribute("page", page);
		paramMap.put("DRV_NO", getLoginVO().getDrvNo());

		int totalCnt = repairService.installAcceptListCount(paramMap);
		model.addAttribute("totalCnt", totalCnt);
		PagingUtil pageInfo = new PagingUtil(totalCnt, page);
		paramMap.put("startPageNum", pageInfo.getStartPageNum());
		paramMap.put("endPageNum", pageInfo.getEndPageNum());

		model.addAttribute("installAcceptList", repairService.installAcceptList(paramMap));

		model.addAttribute("pageTag", pageInfo.getPagesStrTag());
		model.addAttribute("pageInfo", pageInfo);

		model.addAttribute("searchType", paramMap.getString("SEARCH_TYPE"));
		model.addAttribute("txtFromDt", paramMap.getString("TXT_FROM_DT"));
		model.addAttribute("txtToDt", paramMap.getString("TXT_TO_DT"));
		model.addAttribute("searchTxt", paramMap.getString("SEARCH_TXT"));
		model.addAttribute("dateFlag", paramMap.getString("DATE_FLAG"));
		model.addAttribute("statBc", paramMap.getString("STAT_BC"));
		model.addAttribute("insStateCd", paramMap.getString("INS_STATE_CD"));

		return conUrl + "inusInstallAccept";
	}

	@RequestMapping(value = "inusInstallAcceptDetail.do")
	public String inusInstallAcceptDetailR(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("installAcceptView", repairService.installAcceptView(paramMap));
		paramMap.put("AS_NO", paramMap.get("INS_NO"));
		List<?> fileList = repairService.repairFileList(paramMap);

		model.addAttribute("fileList", fileList);
		model.addAttribute("asSign", repairService.asSign(paramMap));

		return conUrl + "inusInstallAcceptDetail";
	}

	@RequestMapping(value = "inusInstallAcceptRegister.do")
	public String inusInstallAcceptRegister(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("installAcceptView", repairService.installAcceptView(paramMap));

		return conUrl + "inusInstallAcceptRegister";
	}

	@RequestMapping(value = "installSave.action")
	public String installSave(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

		init(model);
		try {

			FileUpLoad fileUpLoad = new FileUpLoad(request, response);
			String savePath = "installImg";
			String[] uploadName = { "dtlImgPath" };
			UnCamelMap<String, Object> param = fileUpLoad.imgFileUpload(savePath, uploadName);
			String insNo = repairService.installSave(param, fileUpLoad, savePath, uploadName);

			String returnUrl = "inusInstallAcceptDetail";

			return messageRedirect(egovMessageSource.getMessage("success.common.insert"), ROOT_URI + conUrl + returnUrl + ".do?insNo=" + insNo, model);
		}
		catch (Exception e) {
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + "main" + "home.do", model);
		}
	}

	@RequestMapping(value = "inusInstallAcceptDetailM.do")
	public String inusInstallAcceptDetailM(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		return conUrl + "inusInstallAcceptDetailM";
	}

	@RequestMapping(value = "inusHandling.do")
	public String inusHandling(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);

		paramMap.put("custCd", EgovUserDetailsHelper.getCustCd());
		int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
		model.addAttribute("page", page);

		if (paramMap.getString("SEARCH_TYPE").equals("")) {
			paramMap.put("SEARCH_TYPE", "2");
		}

		if (paramMap.getString("STAT_BC").equals("")) {
			paramMap.put("STAT_BC", "AS204200");
		}
		else if (paramMap.getString("STAT_BC").equals("ALL")) {
			paramMap.put("STAT_BC", "");
		}

		int totalCnt = repairService.handlingListCount(paramMap);
		model.addAttribute("totalCnt", totalCnt);
		PagingUtil pageInfo = new PagingUtil(totalCnt, page);
		paramMap.put("startPageNum", pageInfo.getStartPageNum());
		paramMap.put("endPageNum", pageInfo.getEndPageNum());

		/*if (paramMap.getString("SEARCH_TYPE").equals("")) {
			paramMap.put("SEARCH_TYPE", "2");
		}*/

		/*
		if (paramMap.getString("STAT_BC").equals("")) {
			paramMap.put("STAT_BC", "AS204200");
		}
		else if (paramMap.getString("STAT_BC").equals("ALL")) {
			paramMap.put("STAT_BC", "");
		}
		*/

		List<?> handlingList = repairService.handlingList(paramMap);

		model.addAttribute("handlingList", handlingList);

		model.addAttribute("pageTag", pageInfo.getPagesStrTag());
		model.addAttribute("pageInfo", pageInfo);

		model.addAttribute("searchType", paramMap.getString("SEARCH_TYPE"));
		model.addAttribute("txtFromDt", paramMap.getString("TXT_FROM_DT"));
		model.addAttribute("txtToDt", paramMap.getString("TXT_TO_DT"));
		model.addAttribute("searchTxt", paramMap.getString("SEARCH_TXT"));
		model.addAttribute("searchTxt2", paramMap.getString("SEARCH_TXT2"));
		model.addAttribute("searchTxt3", paramMap.getString("SEARCH_TXT3"));
		model.addAttribute("dateFlag", paramMap.getString("DATE_FLAG"));
		model.addAttribute("statBc", paramMap.getString("STAT_BC"));

		return conUrl + "inusHandling";
	}

	@RequestMapping(value = "inusHandlingDetail.do")
	public String inusHandlingDetail(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);

		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("custCd", EgovUserDetailsHelper.getCustCd());
		model.addAttribute("repairStateView", repairService.repairStateView(paramMap));

		model.addAttribute("repairPartList", repairService.repairPartList(paramMap));

		List<?> fileList = repairService.repairFileList(paramMap);

		model.addAttribute("fileList", fileList);
		model.addAttribute("asSign", repairService.asSign(paramMap));
		return conUrl + "inusHandlingDetail";
	}

	@RequestMapping(value = "inusRepairStateHistory.do")
	public String inusRepairStateHistory(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);

		UnCamelMap<String, Object> paramMap = init(commandMap);

		paramMap.put("custCd", EgovUserDetailsHelper.getCustCd());
		int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
		model.addAttribute("page", page);
		int totalCnt = repairService.repairStateHistoyListCount(paramMap);
		model.addAttribute("totalCnt", totalCnt);
		PagingUtil pageInfo = new PagingUtil(totalCnt, page);
		paramMap.put("startPageNum", pageInfo.getStartPageNum());
		paramMap.put("endPageNum", pageInfo.getEndPageNum());

		if (paramMap.getString("SEARCH_TYPE").equals("")) {
			paramMap.put("SEARCH_TYPE", "2");
		}
		List<?> repairStateHistoyList = repairService.repairStateHistoyList(paramMap);

		model.addAttribute("repairThisHistoyNm", repairService.repairThisHistoyNm(paramMap));
		model.addAttribute("repairStateHistoyList", repairStateHistoyList);

		model.addAttribute("pageTag", pageInfo.getPagesStrTag());
		model.addAttribute("pageInfo", pageInfo);

		model.addAttribute("searchType", paramMap.getString("SEARCH_TYPE"));
		model.addAttribute("txtFromDt", paramMap.getString("TXT_FROM_DT"));
		model.addAttribute("txtToDt", paramMap.getString("TXT_TO_DT"));
		model.addAttribute("searchTxt", paramMap.getString("SEARCH_TXT"));
		model.addAttribute("dateFlag", paramMap.getString("DATE_FLAG"));
		return conUrl + "inusRepairStateHistory";
	}

	@RequestMapping(value = "inusRepairStateHistoryDetail.do")
	public String inusRepairStateHistoryDetail(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("custCd", EgovUserDetailsHelper.getCustCd());
		model.addAttribute("repairStateView", repairService.repairStateView(paramMap));

		model.addAttribute("repairPartList", repairService.repairPartList(paramMap));

		List<?> fileList = repairService.repairFileList(paramMap);

		model.addAttribute("fileList", fileList);
		model.addAttribute("asSign", repairService.asSign(paramMap));
		return conUrl + "inusRepairStateHistoryDetail";
	}

	@RequestMapping(value = "modelList.action")
	public String modelList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		UnCamelMap<String, Object> paramMap = init(commandMap);
		List<?> modelList = repairService.modelList(paramMap);

		model.addAttribute("outData", CommonUtil.listToJsonString(modelList));

		return "common/out";
	}

	@RequestMapping(value = "itmList.action")
	public String itmList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("MAIN_CD", "SDH08");
		paramMap.put("SUB_CD", "1");

		List<?> itmList = repairService.itmList(paramMap);

		model.addAttribute("outData", CommonUtil.listToJsonString(itmList));

		return "common/out";
	}

	@RequestMapping(value = "smsSend.action")
	public String smsSend(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		UnCamelMap<String, Object> paramMap = init(commandMap);
		String smsStatus = repairService.smsSend(paramMap);

		model.addAttribute("outData", smsStatus);

		return "common/out";
	}

}
