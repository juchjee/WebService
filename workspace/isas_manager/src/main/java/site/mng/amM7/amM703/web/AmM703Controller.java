package site.mng.amM7.amM703.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.util.HtmlUtils;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.JsonHelper;
import egovframework.cmmn.util.CamelCasting;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.mng.amM7.amM703.service.impl.AmM703Service;

@SuppressWarnings("unchecked")
@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM7/amM703")
public class AmM703Controller extends BaseController {

	private static final String conUrl = MNG_URI + "amM7/amM703/";

	@Resource(name = "AmM703Service" )
	private AmM703Service amM703Service;

	@RequestMapping(value = "amM703.do")
	public String amM7003(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		model.addAttribute("conUrl", conUrl);
		
		return conUrl + "amM703";
	}

	/** 1차.2차.3차 메뉴조회 **/
	@RequestMapping(value = "amM703.action")
	public String amM7003Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> list = amM703Service.amM703L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/** 1차 메뉴 등록.수정.삭제 처리 **/
	@RequestMapping(value = "amM703IUD.action")
	public String amM7003IUD(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		try{
			UnCamelMap<String, Object> paramMap = init(model, commandMap);

			// 삭제
			if(CommonUtil.nvl(commandMap.get("type")).equals("del")){
				// 삭제 처리
				String jsonDtr = HtmlUtils.htmlUnescape(CommonUtil.nvl(commandMap.get("data")));
				JSONObject jason = new JSONObject(jsonDtr);
				paramMap = JsonHelper.toUnCamelMap(jason);
				paramMap.put("FRONT_MENU_CD", paramMap.get("KEY_VALUE"));
				paramMap.put("FRONT_USE_YN", "N");
				//paramMap.put("FRONT_SORT", 0);
				String[] whereColumName = null;
				whereColumName = new String[]{"FRONT_MENU_CD"};
				commService.tableSaveData("ASW_S_FRONT_MENU", paramMap, null, whereColumName , null, null);
				// 삭제 후 삭제한 레코드 기준으로 순서 수정
				paramMap.put("FRONT_SORT", commandMap.get("rownum"));
				paramMap.put("FRONT_MENU_GROUP", "root");
				

				// 삭제 레코드 기준 조회
				List<?> list = amM703Service.amM703SList(paramMap);
				Map<String,Object> subMap = new HashMap<String, Object>();
				for(int i=0; i<list.size(); i++){
					// 조회된 레코드 업데이트
					subMap = (Map<String, Object>) list.get(i);
					subMap = CamelCasting.getUnCamelCasting(subMap);
					amM703Service.amM703SU(subMap);
				}
			}
			// 등록.수정
			else{
				String jsonStr = HtmlUtils.htmlUnescape(CommonUtil.nvl(commandMap.get("data")));
				JSONArray jasonArr = new JSONArray(jsonStr);
				List<Map<String, Object>> saveList = JsonHelper.toUnCamelList(jasonArr);
				String type = "";
		    	for(Map<String, Object> map : saveList){
		    		if(CommonUtil.nvl(map.get("FRONT_MENU_CD")).equals("")){
		    			map.put("FRONT_MENU_GROUP", "root");
		    			map.put("FRONT_PAGE_CD", "root");
		    			map.put("FRONT_MENU_CD", CommonUtil.nvl(commService.getPrCode("SFM")));
		    			map.put("FRONT_MENU_TP", paramMap.get("FRONT_MENU_TP"));
		    			int grpCnt = amM703Service.amM703Count(map);
		    			
						map.put("FRONT_SORT", CommonUtil.nvl(grpCnt));
						type = "insert";
		    		}
					String[] whereColumName = null;
					if(!type.equals("insert")){
						whereColumName = new String[]{"FRONT_MENU_CD"};
					}
					commService.tableSaveData("ASW_S_FRONT_MENU", map, null, whereColumName , null, null);
		    	}
			}
			model.addAttribute("outData", commandMap.get("idx"));
		}catch(Exception e){
			model.addAttribute("outData", "2");
		}
		commService.resetFrontCategory();
		return "common/out";
	}

	/** 2.3차 메뉴 등록.수정.삭제 처리 **/
	@RequestMapping(value = "amM703MIUD.action")
	public String amM7003MIUD(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		try{
			UnCamelMap<String, Object> paramMap = init(model,commandMap);
			// 삭제
			if(CommonUtil.nvl(commandMap.get("type")).equals("del")){
				// 삭제 처리
				String jsonDtr = HtmlUtils.htmlUnescape(CommonUtil.nvl(commandMap.get("data")));
				JSONObject jason = new JSONObject(jsonDtr);
				paramMap = JsonHelper.toUnCamelMap(jason);
				paramMap.put("FRONT_MENU_CD", paramMap.get("KEY_VALUE"));
				paramMap.put("FRONT_USE_YN", "N");
				//paramMap.put("FRONT_SORT", 0);
				String[] whereColumName = null;
				whereColumName = new String[]{"FRONT_MENU_CD"};
				commService.tableSaveData("ASW_S_FRONT_MENU", paramMap, null, whereColumName , null, null);
				// 삭제 후 삭제한 레코드 기준으로 순서 수정
				paramMap.put("FRONT_SORT", commandMap.get("rownum"));
				paramMap.put("FRONT_MENU_GROUP", commandMap.get("frontMenuGroup"));
				List<?> list = amM703Service.amM703SList(paramMap);
				Map<String,Object> subMap = new HashMap<String, Object>();
				for(int i=0; i<list.size(); i++){
					// 조회된 레코드 업데이트
					subMap = (Map<String, Object>) list.get(i);
					subMap = CamelCasting.getUnCamelCasting(subMap);
					amM703Service.amM703SU(subMap);
				}
			}
			// 등록.수정
			else{
				String jsonStr = HtmlUtils.htmlUnescape(CommonUtil.nvl(commandMap.get("data")));
				JSONArray jasonArr = new JSONArray(jsonStr);
				List<Map<String, Object>> saveList = JsonHelper.toUnCamelList(jasonArr);
				String type = "";
		    	for(Map<String, Object> map : saveList){
		    		if(CommonUtil.nvl(map.get("FRONT_MENU_CD")).equals("")){
		    			map.put("FRONT_MENU_CD", CommonUtil.nvl(commService.getPrCode("SFM")));
		    			int grpCnt = amM703Service.amM703Count(map);
						map.put("FRONT_SORT", CommonUtil.nvl(grpCnt));
						type = "insert";
		    		}
					String[] whereColumName = null;
					if(!type.equals("insert")){
						whereColumName = new String[]{"FRONT_MENU_CD"};
					}
					commService.tableSaveData("ASW_S_FRONT_MENU", map, null, whereColumName , null, null);
		    	}
			}
			model.addAttribute("outData", commandMap.get("idx"));
		}catch(Exception e){
			model.addAttribute("outData", "2");
		}
		commService.resetFrontCategory();
		return "common/out";
	}

	/** 순서이동 처리 **/
	@RequestMapping(value = "sortMod.action")
	public String sortMod(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception  {
			UnCamelMap<String, Object> paramMap = init(model,commandMap);
			String returnStatus = amM703Service.sortMod(paramMap);
			commService.resetFrontCategory();
			model.addAttribute("outData", returnStatus);
			return "common/out";
	}
	

	@RequestMapping(value = "bbsProgList.action")
	public String bbsProgList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		List<?> list = amM703Service.bbsProgList(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}
	
}
