package site.mng.amM7.amM705.web;

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

import site.comm.service.impl.CommStatic;
import site.mng.amM7.amM705.service.impl.AmM705Service;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.JsonHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

/**
 * 설정 : 관리자 권한 설정
 *
 */
@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM7/amM705")
public class AmM705Controller extends BaseController {

	private static final String conUrl = MNG_URI + "amM7/amM705/";

	@Resource(name = "AmM705Service" )
	private AmM705Service amM705Service;


	/**
	 * 설정 : 권한설정 화면 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM705.do")
	public String amM7005(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		model.addAttribute("conUrl", conUrl);
		return conUrl + "amM705";
	}

	/**
	 * 설정 : 권한설정 권한조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM705.action")
	public String amM7005Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> list = amM705Service.amM705L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/**
	 * 설정 : 권한설정 등록 및 수정
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "amM705IUD.action")
	public String amM7005IU(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		try{
			UnCamelMap<String, Object> paramMap = init(model, commandMap);
			if(CommonUtil.nvl(commandMap.get("type")).equals("del")){
				String jsonDtr = HtmlUtils.htmlUnescape(CommonUtil.nvl(commandMap.get("data")));
				JSONObject jason = new JSONObject(jsonDtr);
				paramMap = JsonHelper.toUnCamelMap(jason);
				paramMap.put("ADM_AUTH_CD", paramMap.get("KEY_VALUE"));
				paramMap.put("USE_FLAG_YN", "N");
				String[] whereColumName = null;
				whereColumName = new String[]{"ADM_AUTH_CD"};
				commService.tableSaveData("ASW_S_ADM_AUTH", paramMap, null, whereColumName , null, null);
			}
			// 그룹 등록 및 수정
			else{
				String jsonStr = HtmlUtils.htmlUnescape(CommonUtil.nvl(commandMap.get("data")));
				JSONArray jasonArr = new JSONArray(jsonStr);
				List<Map<String, Object>> saveList = JsonHelper.toUnCamelList(jasonArr);
				String[] whereColumName = null;
				whereColumName = new String[]{"ADM_AUTH_CD"};
				for(Map<String, Object> map : saveList){
					if(CommonUtil.nvl(map.get("ADM_AUTH_CD")).equals("")){
						map.put("ADM_AUTH_CD", CommonUtil.nvl(commService.getPrCode("SAA")));
						int grpCnt = amM705Service.amM705Count(map);
						map.put("ADM_AUTH_SORT", CommonUtil.nvl(grpCnt));
						map.put("USE_FLAG_YN", "Y");
					}
					commService.tableSaveData("ASW_S_ADM_AUTH", map, null, whereColumName , null, null);
				}
			}
			model.addAttribute("outData", "ok");
		}catch(Exception e){
			model.addAttribute("outData", "ng");
		}
		return "common/out";
	}

	/**
	 * 설정 : 권한에 대한 메뉴조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM705ML.action")
	public String amM7005ML(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> list = amM705Service.amM705ML(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/**
	 * 설정 : 권한에 대한 메뉴등록(존재 시 삭제 후 등록)
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "amM705MIU.action")
	public String amM7005MIU(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		try{
			UnCamelMap<String, Object> paramMap = init(model, commandMap);

			// 삭제
			String ADM_AUTH_CD = paramMap.getString("ADM_AUTH_CD");
			commService.tableDelete("ASW_S_ADM_AUTH_MENU", null, "and ADM_AUTH_CD ='"+ADM_AUTH_CD+"'");
			// 삭제이력
			String commTableNm = "ASW_S_ADM_AUTH_MENU";
			commService.setGdataModHis(commTableNm, paramMap.get("ADM_AUTH_CD"), paramMap, DELETE);

			String jsonStr = HtmlUtils.htmlUnescape(CommonUtil.nvl(commandMap.get("data")));
			JSONArray jasonArr = new JSONArray(jsonStr);
			List<Map<String, Object>> saveList = JsonHelper.toUnCamelList(jasonArr);
			String tempStr = "";

			for(Map<String, Object> resultMap : saveList){

				Map<String, Object> matchingColumName = new HashMap<>();

				resultMap.put("ADM_AUTH_CD", paramMap.get("ADM_AUTH_CD"));

				if(!resultMap.get("ADM_MENU_GROUP").equals("root")){
					if(!tempStr.equals(resultMap.get("ADM_MENU_GROUP"))){
						UnCamelMap<String, Object> rootMap = new UnCamelMap<>();
						rootMap.put("ADM_AUTH_CD", resultMap.get("ADM_AUTH_CD"));
						rootMap.put("ADM_MENU_CD", resultMap.get("ADM_MENU_GROUP"));
						commService.tableInatall(commTableNm, rootMap, matchingColumName);

					}else{
						resultMap.put("ADM_MENU_CD", resultMap.get("ADM_MENU_CD"));

					}
					tempStr = (String) resultMap.get("ADM_MENU_GROUP");
				}else{
					resultMap.put("ADM_MENU_CD", resultMap.get("ADM_MENU_CD"));
					tempStr = (String) resultMap.get("ADM_MENU_CD");
				}
				commService.tableInatall(commTableNm, resultMap, matchingColumName);
			}
			CommStatic.getResetCategoryList();
			model.addAttribute("outData", "ok");
		}catch(Exception e){
			model.addAttribute("outData", "ng");
		}
		return "common/out";
	}

}
