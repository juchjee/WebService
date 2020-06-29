package site.front.locStore.web;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.PagingUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.front.bbt.service.impl.BbtService;
import site.front.locStore.service.impl.LocStoreService;

/**
 * @author 
 *
 */
@Controller
@RequestMapping(value = IConstants.ISDS_URL + "locStore")
public class LocStoreController extends BaseController{

	private static final String conUrl = ISDS_URL + "locStore/";

	/** LocStoreService */
	@Resource(name = "LocStoreService")
	private LocStoreService locStoreService;
	
	/** BbtService */
	@Resource(name = "BbtService")
	private BbtService bbtService;

	/**
	 * 매장찾기
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "locStoreL.do")
	public String locStoreL(@RequestParam Map<String, Object> commandMap, ModelMap model,@RequestParam MultiValueMap<String, Object> multiValueMap, HttpServletRequest request) throws Exception {

		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00012");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		
		if( bbtService.bbtAccessStatus(bbtAccessStatusMap)  != 0){
			init(model);
			
			UnCamelMap<String, Object> paramMap = init(commandMap,model);
			String boardTpCd = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
			paramMap.put("BOARD_MST_CD", boardTpCd);
			model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
			
			List<?> cateList = bbtService.cateList(paramMap);
			model.addAttribute("cateList",cateList);
			
			List<Object> mapStoreItem = multiValueMap.get("mapStoreItem");
			if(mapStoreItem!=null){
				paramMap.put("mapStoreItem", mapStoreItem);
			}
			
			int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
			int totalCnt = locStoreService.totalMapListCount(paramMap);
			model.addAttribute("totalCnt",totalCnt);
			
			PagingUtil pageInfo = new PagingUtil(totalCnt, page);
			if(CommonUtil.isMobile(request)){
				paramMap.put("startPageNum", pageInfo.getStartPageNum());
				paramMap.put("endPageNum", pageInfo.getEndPageNum());
			}else{
				paramMap.put("startPageNum", pageInfo.getStartMapPageNum());
				paramMap.put("endPageNum", pageInfo.getEndMapPageNum());
			}
			
			List<?> mapList = locStoreService.selectMapList(paramMap);
			model.addAttribute("mapList", mapList);
			
			if(CommonUtil.isMobile(request)){
				model.addAttribute("pageTag", pageInfo.getPagesStrTag());
			}else{
				model.addAttribute("pageTag", pageInfo.getMapPagesStrTag());
			}
			
			model.addAttribute("pageInfo",pageInfo);
			model.addAttribute("conUrl",conUrl);
			model.addAttribute("addressLev1",paramMap.get("ADDRESS_LEV1"));
			model.addAttribute("addressLev2",paramMap.get("ADDRESS_LEV2"));
			model.addAttribute("txtSearch",paramMap.get("TXT_SEARCH"));
			
			if(cateList.size()>1){
//				int allCnt = bbtService.allListCount(paramMap);
//				model.addAttribute("allCnt",allCnt);
				model.addAttribute("boardCateSeq",paramMap.get("BOARD_CATE_SEQ"));
			}
			
			String uri="";
			if(CommonUtil.isMobile(request)){
				uri = "locStoreL_m";
			}else{
				uri = "locStoreL";
			}
			
			
			return conUrl + uri;
		}else{
			return  messageRedirect("", MAIN_PAGE, model);
		}
		
	}
	
	@RequestMapping("zipcodeSearch.action")
	public String zipcodeSearch(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		
		List<?> list = null;
		if(paramMap.getString("ADDRESS_LEV1").equals("")){
			list = locStoreService.zipcodeSearchLev1();
		}else if(!paramMap.getString("ADDRESS_LEV1").equals("")){
			list = locStoreService.zipcodeSearchLev2(paramMap);
		}else{
			throw new Exception();  
		}
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}
	
	/**
	 * 매장찾기 보기
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "locStoreV.do")
	public String locStoreV(@RequestParam Map<String, Object> commandMap, ModelMap model,@RequestParam MultiValueMap<String, Object> multiValueMap, HttpServletRequest request) throws Exception {

		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00012");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		
		if( bbtService.bbtAccessStatus(bbtAccessStatusMap)  != 0){
			init(model);
			
			UnCamelMap<String, Object> paramMap = init(commandMap,model);
			String boardTpCd = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
			paramMap.put("BOARD_MST_CD", boardTpCd);
			model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
			
			Map<String, Object> mapView = locStoreService.selectMapView(paramMap);
			model.addAttribute("mapView", mapView);
			
			model.addAttribute("conUrl",conUrl);
			
			String uri="";
			if(CommonUtil.isMobile(request)){
				uri = "locStoreV_m";
			}else{
				uri = "locStoreV";
			}
			
			return conUrl + uri;
		}else{
			return  messageRedirect("", MAIN_PAGE, model);
		}
		
	}

}
