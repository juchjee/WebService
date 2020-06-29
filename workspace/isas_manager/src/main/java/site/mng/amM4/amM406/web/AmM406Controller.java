package site.mng.amM4.amM406.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.JsonHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.FileUpLoad;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.mng.amM4.amM406.service.impl.AmM406Service;

@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM4/amM406")
public class AmM406Controller extends BaseController {

	private static final String conUrl = MNG_URI + "amM4/amM406/";

	/** 배너관리 서비스 */
	@Resource(name = "AmM406Service")
    protected AmM406Service amM406Service;

	/**
	 * 배너관리 리스트 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM406.do")
	public String amM406(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		List<?> eBanner = amM406Service.eBanner(null);
		model.addAttribute("eBanner", eBanner);
		return conUrl + "amM406";
	}
	
	/**
	 * 배너관리 리스트 검색
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM406.action")
	public String amM406Action(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> eBannerList = amM406Service.eBannerList(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(eBannerList));
		return "common/out";
	}
	
	/**
	 * 배너관리 등록/수정 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "amM406P.action")
	public String amM406P(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		String returnUrl = conUrl + "amM406N";
		String bannerCd = paramMap.getString("BANNER_CD");
		List<Map<String, Object>> eBanner = null;
		if("".equals(bannerCd)){
			Map<String, Object> whereMap = new HashMap<>();
			whereMap.put("BANNER_LOCAL_CD", "EBR00001");
			eBanner = (List<Map<String, Object>>) amM406Service.eBanner(whereMap);
		}else{
			eBanner = (List<Map<String, Object>>) amM406Service.eBanner(null);
			CamelMap<String, Object> eBannerListMap = amM406Service.eBannerListMap(paramMap);
			JSONObject eBannerListMapJson = (JSONObject) JsonHelper.toJSON(eBannerListMap);
			model.addAttribute("eBannerListMap", eBannerListMapJson.toString());
			returnUrl = conUrl + "amM406U";
		}
		model.addAttribute("eBanner", eBanner);
		HashMap<String, Map<String, Object>> eBannerMap = CommonUtil.listmapToHashmapMap(eBanner, "bannerLocalCd");
		JSONObject eBannerJson = (JSONObject) JsonHelper.toJSON(eBannerMap);
		model.addAttribute("eBannerObj", eBannerJson.toString());
		return returnUrl;
	}
	
	/**
	 * 배너관리 등록/수정
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "amM406S.action")
	public String amM406S(HttpServletRequest request, HttpServletResponse response,  ModelMap model) throws Exception {
		init(model);
		String transInfo = null;
		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
		String savePath = "bannerImg";
		String[] uploadName ={"bannerImg", "bannerMobileImg"};
		UnCamelMap<String, Object> paramMap = fileUpLoad.imgFileUpload(savePath, uploadName);
		String bannerCd = paramMap.getString("BANNER_CD");
		UnCamelMap<String, String> bannerImgMap = (UnCamelMap<String, String>) CommonUtil.getFirstMapFromList((List<Map<String, Object>>) paramMap.get("BANNER_IMG_LIST"));
		UnCamelMap<String, String> bannerMobileImg = (UnCamelMap<String, String>) CommonUtil.getFirstMapFromList((List<Map<String, Object>>) paramMap.get("BANNER_MOBILE_IMG_LIST"));
		if("".equals(bannerCd)){
			transInfo = INSERT;
			if(bannerImgMap == null || bannerImgMap.size() <= 0){
				model.addAttribute("back", "Y");
				return messageRedirect(egovMessageSource.getMessage("fail.common.save") + "\n" + egovMessageSource.getMessage("fail.file.upload.msg"), ROOT_URI + conUrl + "amM406P.action", model);
			}
		}else{
			transInfo =UPDATE;
		}
		int imageMaxWidthOrHeight = Math.max(CommonUtil.nvlInt(paramMap.getString("BANNER_HEIGHT_SIZE")), CommonUtil.nvlInt(paramMap.getString("BANNER_WIDTH_SIZE")));
		int imageMobileMaxWidthOrHeight = Math.max(CommonUtil.nvlInt(paramMap.getString("BANNER_MOBILE_WIDTH_SIZE")), CommonUtil.nvlInt(paramMap.getString("BANNER_MOBILE_HEIGHT_SIZE")));
		UnCamelMap<String, Object> newParamMap = CommonUtil.mapArrayItemToMapObjectItem(paramMap);
		UnCamelMap<String, Object> newBannerImgMap = null;
		UnCamelMap<String, Object> newBannerMobileImg = null;
		if(bannerImgMap != null){
			newBannerImgMap = (UnCamelMap<String, Object>) CommonUtil.getFirstMapFromList(fileUpLoad.setImageSize(bannerImgMap, imageMaxWidthOrHeight));
		}
		if(bannerMobileImg != null){
			newBannerMobileImg = (UnCamelMap<String, Object>) CommonUtil.getFirstMapFromList(fileUpLoad.setImageSize(bannerMobileImg, imageMobileMaxWidthOrHeight));
		}
		bannerCd = amM406Service.amM406S(newParamMap, newBannerImgMap, newBannerMobileImg, savePath, transInfo, bannerCd);
		JSONObject dataMap = new JSONObject();
		dataMap.put("BANNER_CD", bannerCd);
		dataMap.put("action", "if(parent.fnSearch) parent.fnSearch();");
		model.addAttribute("dataMap", dataMap.toString());
		return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + "amM406P.action", model);
	}
	
	/**
	 * 배너 미리보기
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM406R.action")
	public String amM406R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model, commandMap);
		return conUrl + "amM406R";
	}
	
	
}
