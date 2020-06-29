package site.front.main.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.front.main.service.impl.MainService;

@Controller
@RequestMapping(value = IConstants.ISDS_URL + "main")
public class MainController extends BaseController{

	/** MmService */
	@Resource(name = "MainService")
	private MainService mainService;

	/**
	 * 메인화면
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("home.do")
	public String main(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model)  throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		@SuppressWarnings("unchecked")
		List<CamelMap<String, Object>> eBannerList = (List<CamelMap<String, Object>>) mainService.eBannerList();
		String eBannerListItemNm = "";
		List<CamelMap<String, Object>> eBannerTempList = null;
		for (CamelMap<String, Object> eBannerListMap : eBannerList) {
			String bannerLocalCd = eBannerListMap.getString("bannerLocalCd");
			if(!eBannerListItemNm.equals(bannerLocalCd)){
				eBannerListItemNm = bannerLocalCd;
				eBannerTempList = new ArrayList<>();
				model.addAttribute(bannerLocalCd, eBannerTempList);
			}
			eBannerTempList.add(eBannerListMap);
		}
		@SuppressWarnings("unchecked")
		List<CamelMap<String, Object>>  popupList = (List<CamelMap<String, Object>>) mainService.popupList(CommonUtil.nvl(paramMap.get("POPUP_SEQ")));
		for(CamelMap<String,Object> hideCookie: popupList){
			String isTrue = CommonUtil.getCookieValue(request, hideCookie.getString("popupSeq"));
			if(!"".equals(isTrue)){
				hideCookie.put("hidepop", "true");
			}
		}
		model.addAttribute("popupList", popupList);
		model.addAttribute("eBannerTempList", eBannerTempList);
		model.addAttribute("hidePopL", CommonUtil.getCookieValue(request, "hidePopL"));
		model.addAttribute("hideBanner", CommonUtil.getCookieValue(request, "hideBanner"));
		model.addAttribute("mainNoticeList", mainService.getMainNoticeList());
		model.addAttribute("mainFaqList", mainService.getMainFaqList());
		model.addAttribute("paramMap", paramMap);

		String uri="";
		if(CommonUtil.isMobile(request)){
			uri = "home_m";
		}else{
			uri = "home";
		}
		return ISDS_URL + "main/"+uri;
	}

	/**
	 * 팝업조회
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("popup.action")
	public String popup(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model)  throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("popupInfo", mainService.popupView(CommonUtil.nvl(paramMap.get("POPUP_SEQ"))));

		return ISDS_URL + "comm/popup";
	}

	/**
	 * 이벤트 동영상 팝업조회
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("eventMoviePopup.action")
	public String eventMoviePopup(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model)  throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("paramMap", paramMap);
		return ISDS_URL + "comm/eventMoviePopup";
	}
}
