package site.mng.crm.map.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import site.comm.service.impl.CommStatic;
import site.mng.amM7.amM706.service.impl.AmM706Service;
import site.mng.crm.map.service.impl.MapService;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Controller
@RequestMapping(value = IConstants.MNG_URI + "locStore")
public class MapController extends BaseController {

	private static final String conUrl = MNG_URI + "locStore/";

	/** MapService */
	@Resource(name = "MapService")
	private MapService mapService;

	/** AmM706Service */
	@Resource(name = "AmM706Service" )
	private AmM706Service amM706Service;
	/**
	 * 설정 : 매장관리리스트화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "locStoreL.do")
	public String locationStore(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(model, commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "locStoreL";
	}

	/**
	 * 설정 : 매장관리리스트 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "locStoreL.action")
	public String locationStoreLAjax(@RequestParam MultiValueMap<String, Object> multiValueMap, ModelMap model, HttpServletRequest request) throws Exception{
	
		UnCamelMap<String, Object> paramMap = init(model, multiValueMap);
		paramMap.put("BOARD_MST_CD", paramMap.getString("BOARD_MST_CD"));
		paramMap.put("ADDRESS_LEV1", paramMap.getString("ADDRESS_LEV1"));
		paramMap.put("ADDRESS_LEV2", paramMap.getString("ADDRESS_LEV2"));
		paramMap.put("SEARCH_TYPE", paramMap.getString("SEARCH_TYPE"));
		paramMap.put("SEARCH_TXT", paramMap.getString("SEARCH_TXT"));
		
		List<?> selectMapList = mapService.selectMapList(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(selectMapList));
		return "common/out";
	}

	/* 매장찾기관리 - 삭제 */
	@RequestMapping(value = "locStoreD.action")
	public String locStoreD(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			for (int i = 0; i < commandMap.size(); i++) {
				String mapStroeId = CommonUtil.nvl(paramMap.get("DATA[" + i + "]"));
				commService.tableDelete("ASW_M_STORE_MAP", null, " and MAP_STORE_ID = '" + mapStroeId + "'");
				map.put("MAP_STORE_ID", mapStroeId);
				commService.setGdataModHis("ASW_M_STORE_MAP", "MAP_STORE_ID : " + mapStroeId, map, DELETE);

				commService.tableDelete("ASW_M_STORE_CATE_MPG", null, " and MAP_STORE_ID = '" + mapStroeId + "'");
				map.put("MAP_STORE_ID", mapStroeId);
				commService.setGdataModHis("ASW_M_STORE_CATE_MPG", "MAP_STORE_ID : " + mapStroeId, map, DELETE);

				commService.tableDelete("ASW_M_STORE_ZC_MPG", null, " and MAP_STORE_ID = '" + mapStroeId + "'");
				map.put("MAP_STORE_ID", mapStroeId);
				commService.setGdataModHis("ASW_M_STORE_ZC_MPG", "MAP_STORE_ID : " + mapStroeId, map, DELETE);
			}
			return messageRedirect(egovMessageSource.getMessage("success.common.delete"), ROOT_URI + conUrl + "locStoreL.do", model);
		} catch (Exception e) {
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + "main" + "home.do", model);
		}
	}
	/**
	 * 설정 : 매장관리등록수정화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "locStoreS.action")
	public String locationStoreSave(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(model, commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		if(!paramMap.getString("MAP_STORE_ID").equals("")){
			Map<String, String> selectMapObj = mapService.selectMapObj(paramMap);

			List<?> addressmpgList = mapService.addressmpgList(paramMap);
			List<?> storeCateList = mapService.storeCateList(paramMap);
			

			model.addAttribute("storeCateList", storeCateList);
			model.addAttribute("addressmpgList", addressmpgList);
			model.addAttribute("viewMap", selectMapObj);
		}
		
		
		model.addAttribute("cateList", cateList);
		model.addAttribute("conUrl", conUrl);
		return conUrl + "locStoreS";
	}
	
	
	@RequestMapping(value = "mapdel.action")
	public String mapdel(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		
		String[] addressLevArr = paramMap.getString("ADDRESS_LEV").split(",");
		
		String commTableNm = "ASW_M_STORE_ZC_MPG";
		commService.tableDelete(commTableNm, null, "AND MAP_STORE_ID = '"+paramMap.getString("MAP_STORE_ID")+"' AND ADDRESS_LEV_1 ='"+addressLevArr[0]+"' AND ADDRESS_LEV_2 ='"+addressLevArr[1]+"'");
		
		commService.setGdataModHis(commTableNm, paramMap.get("MAP_STORE_ID"), paramMap, DELETE);
		CommStatic.getResetCategoryList();
		return messageRedirect(egovMessageSource.getMessage("success.common.delete"), conUrl + "locStoreS.action", model);
	}
	

	@RequestMapping(value="mapSave.action")
	public String mapSave(@RequestParam MultiValueMap<String, Object> multiValueMap,  ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, multiValueMap);
		@SuppressWarnings("unused")
		String msg = "";
		try {
			mapService.mapSave(paramMap);
		} catch (Exception e) {
			msg = egovMessageSource.getMessage("fail.common.save") + "\n" + e.getMessage();
		}
		return messageAction(egovMessageSource.getMessage("success.common.save"), "parent.$.fancybox.close(); parent.location.reload(true); ", model);
	}


	@RequestMapping("zipcodeSearch.action")
	public String zipcodeSearch(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		
		List<?> list = null;
		if(paramMap.getString("ADDRESS_LEV1").equals("")){
			list = mapService.zipcodeSearchLev1();
		}else if(!paramMap.getString("ADDRESS_LEV1").equals("")){
			list = mapService.zipcodeSearchLev2(paramMap);
		}else{
			throw new Exception();  
		}
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}
	

}
