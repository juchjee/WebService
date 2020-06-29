package site.mng.amM7.amM706.web;

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
import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM7/amM706")
public class AmM706Controller extends BaseController {

	private static final String conUrl = MNG_URI + "amM7/amM706/";

	@Resource(name = "AmM706Service" )
	private AmM706Service amM706Service;

	/**
	 * 설정 : 게시판설정 화면조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM706.do")
	public String amM7006(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		List<?> admMenuList = amM706Service.admMenuList();
		model.addAttribute("admMenuList", admMenuList);
		model.addAttribute("conUrl", conUrl);
		return conUrl + "amM706";
	}

	/**
	 * 설정 : 게시판설정 목록조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM706.action")
	public String amM7006Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> list = amM706Service.amM706L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}
	
	
	

	/**
	 * 설정 : 게시판설정 등록화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM706Pop.action")
	public String amM7006R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);

		List<?> skillList = amM706Service.amM706SL(paramMap);
		List<?> admMenuList = amM706Service.admMenuList();
		
		if(!paramMap.getString("BOARD_MST_CD").equals("")){
			Map<String, Object> boardMap = amM706Service.amM706BD(paramMap);
			model.addAttribute("boardDetail", boardMap);
			List<?> skillmpg = amM706Service.amM706SML(paramMap);
			model.addAttribute("skillmpg",skillmpg);
			List<?> catempg = amM706Service.amM706CL(paramMap);
			model.addAttribute("catempg",catempg);
		}
		model.addAttribute("TYPE", paramMap.get("TYPE"));
		model.addAttribute("skillList", skillList);
		model.addAttribute("admMenuList", admMenuList);
		model.addAttribute("conUrl", conUrl);
		return conUrl + "amM706Pop";
	}

	@RequestMapping(value = "boardTpCdSearch.action")
	public String boardTpCdSearchAjax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> typeList = amM706Service.amM706TL(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(typeList));
		return "common/out";
	}
	/**
	 * 설정 : 게시판설정 등록 및 수정 로직처리
	 * @param multiValueMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM706PSave.action")
	private String amM402PSave(@RequestParam MultiValueMap<String, Object> multiValueMap, HttpServletRequest request, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, multiValueMap);
		@SuppressWarnings("unused")
		String msg = "";
		try {
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			String[] whereColumName = null;
			paramMap.put("BOARD_MST_CD", paramMap.getString("BOARD_MST_CD"));
			paramMap.put("BOARD_MST_NM", paramMap.getString("BOARD_MST_NM"));
			paramMap.put("BOARD_TP_CD", paramMap.getString("BOARD_TP_CD"));
			paramMap.put("ADM_MENU_CD", paramMap.getString("ADM_MENU_CD"));
			paramMap.put("BOARD_STATUS_YN", paramMap.getString("BOARD_STATUS_YN"));

			if(paramMap.getString("BOARD_MST_CD").equals("")){
				int grpCnt = amM706Service.amM706Count(paramMap);
				paramMap.put("BOARD_MST_CD", CommonUtil.nvl(commService.getPrCode("BBM")));
				paramMap.put("BOARD_SORT", grpCnt);
				paramMap.put("BOARD_PROD_YN", paramMap.getString("BOARD_PROD_YN"));
				matchingColumName.put("REG_ID", "$iui");
				matchingColumName.put("REG_DT", "$idate");
				if(!paramMap.getString("FUNC_CD").equals("N")){
					String[] skillArr = paramMap.getArray("BOARD_FUNC_CD");
					UnCamelMap<String, Object> skillMap = new UnCamelMap<>();
					for(String skillMpg : skillArr){
						skillMap.put("BOARD_MST_CD", paramMap.getString("BOARD_MST_CD"));
						skillMap.put("BOARD_FUNC_CD", skillMpg);
						commService.tableSaveData("ASW_BOARD_FUNC_MPG", skillMap, null, whereColumName, null, null);
					}
				}
				String[] cateArr = paramMap.getArray("CATE_MPG_ARR");
				UnCamelMap<String, Object> cateMap = new UnCamelMap<>();
				for(String cateArrMpg : cateArr){
					cateMap.put("BOARD_MST_CD", paramMap.getString("BOARD_MST_CD"));
					cateMap.put("BOARD_CATE_SEQ", CommonUtil.nvl(commService.getPrSeq("BOARD_CATE_SEQ")));
					cateMap.put("BOARD_CATE_NM", cateArrMpg);
					int cateCnt = amM706Service.amM706CC(cateMap);
					cateMap.put("BOARD_CATE_SORT", cateCnt);
					commService.tableSaveData("ASW_BOARD_CATE", cateMap, null, whereColumName, null, null);
				}
			}else{
				String BOARD_MST_CD = paramMap.getString("BOARD_MST_CD");
				commService.tableDelete("ASW_BOARD_FUNC_MPG", null, "and BOARD_MST_CD ='"+BOARD_MST_CD+"'");
				if(!paramMap.getString("FUNC_CD").equals("N")){
					String[] skillArr = paramMap.getArray("BOARD_FUNC_CD");
					UnCamelMap<String, Object> skillMap = new UnCamelMap<>();
					for(String skillMpg : skillArr){
						skillMap.put("BOARD_MST_CD", paramMap.getString("BOARD_MST_CD"));
						skillMap.put("BOARD_FUNC_CD", skillMpg);
						commService.tableSaveData("ASW_BOARD_FUNC_MPG", skillMap, null, whereColumName, null, null);
						commService.setGdataModHis("ASW_BOARD_FUNC_MPG", paramMap.getString("BOARD_MST_CD"), paramMap, UPDATE);
					}
				}
				String[] cateArr = paramMap.getArray("CATE_MPG_ARR");
				UnCamelMap<String, Object> cateMap = new UnCamelMap<>();
				if(cateArr!=null){
					for(String cateArrMpg : cateArr){
						cateMap.put("BOARD_MST_CD", paramMap.getString("BOARD_MST_CD"));
						cateMap.put("BOARD_CATE_SEQ", CommonUtil.nvl(commService.getPrSeq("BOARD_CATE_SEQ")));
						cateMap.put("BOARD_CATE_NM", cateArrMpg);
						int cateCnt = amM706Service.amM706CC(cateMap);
						cateMap.put("BOARD_CATE_SORT", cateCnt);
						commService.tableSaveData("ASW_BOARD_CATE", cateMap, null, whereColumName, null, null);
						commService.setGdataModHis("ASW_BOARD_CATE", paramMap.getString("BOARD_MST_CD"), cateMap, UPDATE);
					}
				}
//				if(paramMap.getString("BOARD_MST_CD").equals("BBM00005")||paramMap.getString("BOARD_MST_CD").equals("BBM00006")){
//					paramMap.put("BOARD_PROD_YN", paramMap.getString("BOARD_PROD_YN"));
//				}
			}
			whereColumName = new String[]{"BOARD_MST_CD"};
			commService.tableSaveData("ASW_BOARD_MST", paramMap, matchingColumName, whereColumName, null, null);
			CommStatic.getResetCategoryList();
			model.addAttribute("action", "parent.fnSearch && parent.fnSearch();");
		} catch (Exception e) {
			msg = egovMessageSource.getMessage("fail.common.save") + "\n" + e.getMessage();
		}
		return messageAction(egovMessageSource.getMessage("success.common.save"), "parent.$.fancybox.close(); parent.location.reload(true); ", model);
	}

	/**
	 * 설정 : 게시판설정 삭제
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM706D.action")
	public String amM7006D(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		paramMap.put("BOARD_MST_CD", paramMap.get("DEL_CD"));
		paramMap.put("BOARD_STATUS_YN", "N");
		String[] whereColumName = null;
		whereColumName = new String[]{"BOARD_MST_CD"};
		commService.tableSaveData("ASW_BOARD_MST", paramMap, null, whereColumName , null, null);
		String commTableNm = "ASW_BOARD_MST";
		commService.setGdataModHis(commTableNm, paramMap.get("BOARD_MST_CD"), paramMap, DELETE);
		CommStatic.getResetCategoryList();
		return messageRedirect(egovMessageSource.getMessage("success.common.delete"), conUrl + "amM706.do", model);
	}

	@RequestMapping(value = "amM706CD.action")
	public String amM706CD(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		try{
			UnCamelMap<String, Object> paramMap = init(model,commandMap);
			String[] whereColumName = null;
			whereColumName = new String[]{"BOARD_CATE_SEQ"};
			paramMap.put("BOARD_CATE_USE_YN", "N");
			commService.tableSaveData("ASW_BOARD_CATE", paramMap, null, whereColumName , null, null, true);
			String commTableNm = "ASW_BOARD_CATE";
			commService.setGdataModHis(commTableNm, paramMap.get("BOARD_CATE_SEQ"), paramMap, DELETE);
			model.addAttribute("outData", "ok");
		}catch(Exception e){
			model.addAttribute("outData", "ng");
		}
		return "common/out";
	}

}
