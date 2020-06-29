package site.mng.bbt.web;

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

import site.mng.amM7.amM706.service.impl.AmM706Service;
import site.mng.bbt.service.impl.BbtService;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.FileUpLoad;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

/**
 * @author taehoon_kil
 *
 */
@Controller
@RequestMapping(value = IConstants.MNG_URI + "bbt")
public class BbtController extends BaseController {

	private static final String conUrl = MNG_URI + "bbt/";

	@Resource(name = "BbtService" )
	private BbtService bbtService;

	@Resource(name = "AmM706Service" )
	private AmM706Service amM706Service;


	/**
	 * 게시판관리 : 공지사항 화면조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00001.do")
	public String bbt00001(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00001";
	}

	/**
	 * 게시판관리 : 공지사항 목록조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00001.action")
	public String bbt00001Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);
		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);
		List<?> list = bbtService.bbt00001L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/**
	 * 게시판관리 : 공지사항 목록정지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00001D.action")
	public String bbt00001D(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		Map<String,Object> paramBoardMap = new HashMap<String, Object>();
    	for(int i=0; i < commandMap.size(); i++){
    		String boardSeq = CommonUtil.nvl(paramMap.get("DATA["+i+"]"));
    		paramBoardMap.put("BOARD_STATUS_YN", "N");
			commService.tableUpdate("ASW_BOARD_BASE", paramBoardMap, null, null, "AND BOARD_SEQ = '"+boardSeq+"'", null);
			commService.setGdataModHis("ASW_BOARD_BASE", "BOARD_SEQ : "+boardSeq, paramBoardMap, DELETE);
    	}
		model.addAttribute("outData", egovMessageSource.getMessage("success.common.delete"));
		return "common/out";
	}

	/**
	 * 게시판관리 : 공지사항 등록화면조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00001R.action")
	public String bbt00001R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		List<?> funcList = bbtService.selectFunc(paramMap);
		model.addAttribute("funcList", funcList);

		if(!paramMap.getString("BOARD_SEQ").equals("")){
			Map<String, Object> viewMap = bbtService.bbt00001V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("cateSeq", paramMap.getString("BOARD_CATE_SEQ"));
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00001R";
	}

	/**
	 * 게시판관리 : 공지사항 등록 및 수정 처리
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "bbt00001Save.action")
	public String bbt00001Save(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		init(model);

		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
		String savePath = "boardBBT1File";
		String[] uploadName ={"dtlFilePath"};
		UnCamelMap<String, Object>  param = fileUpLoad.docFileUpload(savePath,uploadName);

		String boardMstCd = "";
		try{
			String[] whereColumName = null;
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			String boardTitle = (String) param.getString("BOARD_TITLE");
			String boardFirstYn = (String) param.getString("BOARD_FIRST_YN");
			String boardCont = (String) param.getString("BOARD_CONT");
			String boardCateSeq = (String) param.getString("BOARD_CATE_SEQ");
//			String regDt = (String) param.getString("REG_DT");
			boardMstCd = (String) param.getString("BOARD_MST_CD");

			UnCamelMap<String, Object> bbt1Map = new UnCamelMap<>();
			if(param.getString("BOARD_SEQ").equals("")){
				bbt1Map.put("BOARD_SEQ", CommonUtil.nvl(commService.getPrSeq("BOARD_SEQ")));
				if(boardMstCd.equals("BBM00067")) {
					bbtService.bbsSmsSend(boardTitle);
				}
			}else{
				bbt1Map.put("BOARD_SEQ", param.getString("BOARD_SEQ"));
			}

			if(!boardTitle.equals("")){
				bbt1Map.put("BOARD_TITLE", boardTitle);
			}
				bbt1Map.put("BOARD_MST_CD", boardMstCd);
				if(!boardCont.equals("")){
				bbt1Map.put("BOARD_CONT", boardCont);
				}
				if(!boardCateSeq.equals("")){
				bbt1Map.put("BOARD_CATE_SEQ", boardCateSeq);
				}else{
					bbt1Map.put("BOARD_CATE_SEQ", "0");
				}
				if(!boardFirstYn.equals("")){
					bbt1Map.put("BOARD_FIRST_YN", "Y");
				}else{
					bbt1Map.put("BOARD_FIRST_YN", "N");
				}
				bbt1Map.put("BOARD_STATUS_YN", "Y");
				bbt1Map.put("DATA_USER_TP_MA", "A");
				bbt1Map.put("REG_IP", request.getRemoteAddr());
				bbt1Map.put("REG_AGENT", request.getHeader("User-Agent"));
				matchingColumName.put("REG_ID", "$iui");
				matchingColumName.put("REG_DT", "$idate");
				whereColumName = new String[]{"BOARD_SEQ"};
				commService.tableSaveData("ASW_BOARD_BASE", bbt1Map, matchingColumName, whereColumName , null, null);
				commService.setGdataModHis("ASW_BOARD_BASE", bbt1Map.get("BOARD_SEQ"), bbt1Map, INSERT);
			
			
				if(!param.getString("PROD_PRICE").equals("")){
					UnCamelMap<String, Object> prodMap = new UnCamelMap<>();
					prodMap.put("BOARD_SEQ", bbt1Map.getString("BOARD_SEQ"));
					prodMap.put("PROD_PRICE", param.getString("PROD_PRICE"));
					prodMap.put("PROD_PURCH", param.getString("PROD_PURCH"));
					prodMap.put("PROD_TEL", param.getString("PROD_TEL"));
					commService.tableSaveData("ASW_BOARD_TP_PROD", prodMap, null, whereColumName , null, null);
					commService.setGdataModHis("ASW_BOARD_TP_PROD", prodMap.get("BOARD_SEQ"), prodMap, UPDATE);
				}

				if(!param.getString("BOARD_REPLY").equals("&lt;p&gt;&amp;nbsp;&lt;/p&gt;") && !param.getString("BOARD_REPLY").equals("")){
					
					matchingColumName.put("REP_ID", "$iui");
					matchingColumName.put("REP_DT", "$idate");
					bbt1Map.put("BOARD_REPLY", param.getString("BOARD_REPLY"));

					if(param.getString("BBT_CD").equals("bbt00003")){
						if(param.getString("PROD_GRADE").equals("")){
							bbt1Map.put("PROD_GRADE", "1");
						}else{
							bbt1Map.put("PROD_GRADE", param.getString("PROD_GRADE"));
						}
					matchingColumName.put("REP_ID", "$iui");
					commService.tableSaveData("ASW_BOARD_TP_REVIEW", bbt1Map, matchingColumName, whereColumName , null, null);
					commService.setGdataModHis("ASW_BOARD_TP_REVIEW", bbt1Map.get("BOARD_SEQ"), bbt1Map, UPDATE);
					}else{
					bbt1Map.put("OPEN_YN", "Y");
					commService.tableSaveData("ASW_BOARD_TP_REPLY", bbt1Map, matchingColumName, whereColumName , null, null);
					commService.setGdataModHis("ASW_BOARD_TP_REPLY", bbt1Map.get("BOARD_SEQ"), bbt1Map, UPDATE);
					}
				}

			if(param.getArray("DTL_FILE_PATH") != null){

				List<?> list = (List<?>) param.get("DTL_FILE_PATH_LIST");
				
				if(list != null){
					UnCamelMap<String, Object> fileMap = new UnCamelMap<>();
					UnCamelMap<String, Object> fileAttMap = new UnCamelMap<>();
					for (int idx = 0; idx < list.size(); idx++) {
						Map<String, String> attchMap = (Map<String, String>) list.get(idx);
						// 게시판 첨부파일테이블
						fileMap.put("BOARD_SEQ",bbt1Map.get("BOARD_SEQ"));
						fileMap.put("ATTCH_CD",CommonUtil.nvl(commService.getPrCode("ATT")));
						commService.tableSaveData("ASW_BOARD_ATTCH", fileMap, null, null , null, null);
						// 첨부파일 저장
						fileAttMap.put("ATTCH_CD", fileMap.getString("ATTCH_CD"));
						fileAttMap.put("ATTCH_ID", savePath);
						fileAttMap.put("ATTCH_FILE_NM", attchMap.get("ATTCH_FILE_NM"));
						fileAttMap.put("ATTCH_REAL_FILE_NM", attchMap.get("ATTCH_REAL_FILE_NM"));
						fileAttMap.put("ATTCH_FILE_PATH", attchMap.get("ATTCH_FILE_PATH"));
						fileAttMap.put("ATTCH_ABSOLUTE_PATH", attchMap.get("ATTCH_ABSOLUTE_PATH"));
						fileAttMap.put("ATTCH_REAL_ABSOLUTE_PATH", attchMap.get("ATTCH_REAL_ABSOLUTE_PATH"));
						commService.tableSaveData("ASW_G_ATTCH", fileAttMap, null, null , null, null);
					}
				}
			}
			return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + param.getString("BBT_CD")+"R.action?boardMstCd="+boardMstCd+"&boardSeq="+bbt1Map.get("BOARD_SEQ"), model);
		}catch(Exception e){
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + conUrl + param.getString("BBT_CD")+"R.action?boardMstCd="+boardMstCd, model);
		}

	}


	/**
	 * 게시판관리 : 공지사항 등록 및 수정 처리
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00001NoFileSave.action")
	public String bbt00001NoFileSave(@RequestParam Map<String, Object> commandMap,  ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		init(model);
		UnCamelMap<String, Object> param = new UnCamelMap<>();
		param.putAll(commandMap);

		String boardMstCd = "";
		try{
			String[] whereColumName = null;
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			String boardTitle = (String) param.getString("BOARD_TITLE");
			String boardFirstYn = (String) param.getString("BOARD_FIRST_YN");
			String boardCont = (String) param.getString("BOARD_CONT");
			String boardCateSeq = (String) param.getString("BOARD_CATE_SEQ");
//			String regDt = (String) param.getString("REG_DT");
			boardMstCd = (String) param.getString("BOARD_MST_CD");

			UnCamelMap<String, Object> bbt1Map = new UnCamelMap<>();
			if(param.getString("BOARD_SEQ").equals("")){
				bbt1Map.put("BOARD_SEQ", CommonUtil.nvl(commService.getPrSeq("BOARD_SEQ")));
			}else{
				bbt1Map.put("BOARD_SEQ", param.getString("BOARD_SEQ"));
			}

			if(!boardTitle.equals("")){
				bbt1Map.put("BOARD_TITLE", boardTitle);
			}
				bbt1Map.put("BOARD_MST_CD", boardMstCd);
				if(!boardCont.equals("")){
				bbt1Map.put("BOARD_CONT", boardCont);
				}
				if(!boardCateSeq.equals("")){
				bbt1Map.put("BOARD_CATE_SEQ", boardCateSeq);
				}else{
					bbt1Map.put("BOARD_CATE_SEQ", "0");
				}
				if(!boardFirstYn.equals("")){
					bbt1Map.put("BOARD_FIRST_YN", "Y");
				}else{
					bbt1Map.put("BOARD_FIRST_YN", "N");
				}
				bbt1Map.put("BOARD_STATUS_YN", "Y");
				bbt1Map.put("DATA_USER_TP_MA", "A");
				bbt1Map.put("REG_IP", request.getRemoteAddr());
				bbt1Map.put("REG_AGENT", request.getHeader("User-Agent"));
				matchingColumName.put("REG_ID", "$iui");
				matchingColumName.put("REG_DT", "$idate");
				whereColumName = new String[]{"BOARD_SEQ"};
				commService.tableSaveData("ASW_BOARD_BASE", bbt1Map, matchingColumName, whereColumName , null, null);
				commService.setGdataModHis("ASW_BOARD_BASE", bbt1Map.get("BOARD_SEQ"), bbt1Map, INSERT);

				matchingColumName.clear();

				if(!param.getString("PROD_PRICE").equals("")){
					UnCamelMap<String, Object> prodMap = new UnCamelMap<>();
					prodMap.put("BOARD_SEQ", bbt1Map.getString("BOARD_SEQ"));
					prodMap.put("PROD_PRICE", param.getString("PROD_PRICE"));
					prodMap.put("PROD_PURCH", param.getString("PROD_PURCH"));
					prodMap.put("PROD_TEL", param.getString("PROD_TEL"));
					commService.tableSaveData("ASW_BOARD_TP_PROD", prodMap, null, whereColumName , null, null);
					commService.setGdataModHis("ASW_BOARD_TP_PROD", prodMap.get("BOARD_SEQ"), prodMap, UPDATE);
				}

				if(!param.getString("BOARD_REPLY").equals("&lt;p&gt;&amp;nbsp;&lt;/p&gt;")&&!param.getString("BOARD_REPLY").equals("")){

					matchingColumName.put("REP_ID", "$iui");
					matchingColumName.put("REP_DT", "$idate");
					bbt1Map.put("BOARD_REPLY", param.getString("BOARD_REPLY"));

					if(param.getString("BBT_CD").equals("bbt00003")){
						if(param.getString("PROD_GRADE").equals("")){
							bbt1Map.put("PROD_GRADE", "1");
						}else{
							bbt1Map.put("PROD_GRADE", param.getString("PROD_GRADE"));
						}
					matchingColumName.put("REP_ID", "$iui");
					commService.tableSaveData("ASW_BOARD_TP_REVIEW", bbt1Map, matchingColumName, whereColumName , null, null);
					commService.setGdataModHis("ASW_BOARD_TP_REVIEW", bbt1Map.get("BOARD_SEQ"), bbt1Map, UPDATE);
					}else{
					bbt1Map.put("OPEN_YN", "Y");
					commService.tableSaveData("ASW_BOARD_TP_REPLY", bbt1Map, matchingColumName, whereColumName , null, null);
					commService.setGdataModHis("ASW_BOARD_TP_REPLY", bbt1Map.get("BOARD_SEQ"), bbt1Map, UPDATE);
					}
				}

			return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + param.getString("BBT_CD")+"R.action?boardMstCd="+boardMstCd+"&boardSeq="+bbt1Map.get("BOARD_SEQ"), model);
		}catch(Exception e){
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + conUrl + param.getString("BBT_CD")+"R.action?boardMstCd="+boardMstCd, model);
		}

	}

	/**
	 * 게시판관리 : 모든 첨부파일 삭제(공통처리)
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00001FD.action")
	public String bbt00001FD(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		commService.tableDelete("ASW_BOARD_ATTCH", null,"and ATTCH_CD ='"+paramMap.getString("ATTCH_CD")+"'");
		commService.setGdataModHis("ASW_BOARD_ATTCH", paramMap.get("ATTCH_CD"), paramMap, DELETE);
		commService.tableDelete("ASW_G_ATTCH", null,"and ATTCH_CD ='"+paramMap.getString("ATTCH_CD")+"'");
		commService.setGdataModHis("ASW_G_ATTCH", paramMap.get("ATTCH_CD"), paramMap, DELETE);
		model.addAttribute("outData", egovMessageSource.getMessage("success.common.delete"));
		return "common/out";
	}

	/**
	 * 게시판관리 : 답변형 게시판 (고객상담 / 제품문의) 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00002.do")
	public String bbt00002(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00002";
	}

	/**
	 * 게시판관리 : 답변형 게시판 (고객상담 / 제품문의) 목록조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00002.action")
	public String bbt00002Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> list = bbtService.bbt00002L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/**
	 * 게시판관리 : 답변형 게시판 (고객상담 / 제품문의) 목록정지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00002D.action")
	public String bbt00002D(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		Map<String,Object> paramBoardMap = new HashMap<String, Object>();
    	for(int i=0; i < commandMap.size(); i++){
    		String boardSeq = CommonUtil.nvl(paramMap.get("DATA["+i+"]"));
    		paramBoardMap.put("BOARD_STATUS_YN", "N");
			commService.tableUpdate("ASW_BOARD_BASE", paramBoardMap, null, null, "AND BOARD_SEQ = '"+boardSeq+"'", null);
			commService.setGdataModHis("ASW_BOARD_BASE", "BOARD_SEQ : "+boardSeq, paramBoardMap, DELETE);
    	}
		model.addAttribute("outData", egovMessageSource.getMessage("success.common.delete"));
		return "common/out";
	}

	/**
	 * 게시판관리 : 답변형 게시판 (고객상담 / 제품문의) 등록화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00002R.action")
	public String bbt00002R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		List<?> funcList = bbtService.selectFunc(paramMap);
		model.addAttribute("funcList", funcList);

		if(!paramMap.getString("BOARD_SEQ").equals("")){
			Map<String, Object> viewMap = bbtService.bbt00001V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
			Map<String, Object> replyMap = bbtService.bbt00001RP(paramMap);
			model.addAttribute("replyMap", replyMap);
		}
		model.addAttribute("cateSeq", paramMap.getString("BOARD_CATE_SEQ"));
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00002R";
	}

//	@SuppressWarnings("unchecked")
//	@RequestMapping(value = "bbt00002Save.action")
//	public String bbt00002Save(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
//		init(model);
//
//		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
//		String savePath = "boardBBT2File";
//		String[] uploadName ={"dtlFilePath"};
//		UnCamelMap<String, Object>  param = fileUpLoad.docFileUpload(savePath,uploadName);
//
//		String boardMstCd = "";
//		try{
//			String[] whereColumName = null;
//			Map<String, Object> matchingColumName = new HashMap<String, Object>();
//			String boardTitle = (String) param.getString("BOARD_TITLE");
//			String boardCont = (String) param.getString("BOARD_CONT");
//			String boardCateSeq = (String) param.getString("BOARD_CATE_SEQ");
//			String regDt = (String) param.getString("REG_DT");
//			boardMstCd = (String) param.getString("BOARD_MST_CD");
//			String boardFirstYn = (String) param.getString("BOARD_FIRST_YN");
//
//			UnCamelMap<String, Object> bbt1Map = new UnCamelMap<>();
//
//			if(param.getString("BOARD_SEQ").equals("")){
//				bbt1Map.put("BOARD_MST_CD", boardMstCd);
//				bbt1Map.put("BOARD_SEQ", CommonUtil.nvl(commService.getPrSeq("BOARD_SEQ")));
//				bbt1Map.put("BOARD_TITLE", boardTitle);
//				bbt1Map.put("BOARD_CONT", boardCont);
//				bbt1Map.put("BOARD_CATE_SEQ", boardCateSeq);
//				bbt1Map.put("REG_DT", regDt);
//				bbt1Map.put("BOARD_FIRST_YN", "N");
//				bbt1Map.put("BOARD_STATUS_YN", "Y");
//				bbt1Map.put("DATA_USER_TP_MA", "A");
//
//				if(!boardFirstYn.equals("")){
//					bbt1Map.put("BOARD_FIRST_YN", boardFirstYn);
//				}
//				bbt1Map.put("BOARD_HIT", 0);
//				bbt1Map.put("REG_IP", request.getRemoteAddr());
//				bbt1Map.put("REG_AGENT", request.getHeader("User-Agent"));
//				matchingColumName.put("REG_ID", "$iui");
//				commService.tableSaveData("ASW_BOARD_BASE", bbt1Map, matchingColumName, whereColumName , null, null);
//				commService.setGdataModHis("ASW_BOARD_BASE", bbt1Map.get("BOARD_SEQ"), bbt1Map, INSERT);
//				matchingColumName.clear();
//				if(!param.getString("BOARD_REPLY").equals("&lt;p&gt;&amp;nbsp;&lt;/p&gt;")){
//					bbt1Map.put("BOARD_REPLY", param.getString("BOARD_REPLY"));
//					bbt1Map.put("OPEN_YN", "Y");
//					bbt1Map.put("REP_DT", regDt);
//					matchingColumName.put("REP_ID", "$iui");
//					commService.tableSaveData("ASW_BOARD_TP_REPLY", bbt1Map, matchingColumName, whereColumName , null, null);
//					commService.setGdataModHis("ASW_BOARD_BASE", bbt1Map.get("BOARD_SEQ"), bbt1Map, INSERT);
//				}
//			}else{
//				bbt1Map.put("BOARD_SEQ", param.getString("BOARD_SEQ"));
//
//				if(!boardTitle.equals("")){
//					bbt1Map.put("BOARD_TITLE", boardTitle);
//				}
//					bbt1Map.put("BOARD_CATE_SEQ", boardCateSeq);
//				if(!boardCont.equals("")){
//					bbt1Map.put("BOARD_CONT", boardCont);
//				}
//
//				if(!boardFirstYn.equals("")){
//					bbt1Map.put("BOARD_FIRST_YN", boardFirstYn);
//				}
//				whereColumName = new String[]{"BOARD_SEQ"};
//				commService.tableSaveData("ASW_BOARD_BASE", bbt1Map, null, whereColumName , null, null);
//				commService.setGdataModHis("ASW_BOARD_BASE", bbt1Map.get("BOARD_SEQ"), bbt1Map, UPDATE);
//				if(!param.getString("PROD_CD").equals("")){
//					UnCamelMap<String, Object> prodMap = new UnCamelMap<>();
//					prodMap.put("BOARD_SEQ", bbt1Map.getString("BOARD_SEQ"));
//					prodMap.put("PROD_CD", param.getString("PROD_CD"));
//					commService.tableSaveData("ASW_BOARD_TP_PROD", prodMap, null, whereColumName , null, null);
//					commService.setGdataModHis("ASW_BOARD_TP_PROD", prodMap.get("BOARD_SEQ"), prodMap, UPDATE);
//				}
//				if(!param.getString("BOARD_REPLY").equals("")){
//					bbt1Map.put("BOARD_REPLY", param.getString("BOARD_REPLY"));
//
//					bbt1Map.put("OPEN_YN", "Y");
//					bbt1Map.put("REP_DT", regDt);
//					matchingColumName.put("REP_ID", "$iui");
//					commService.tableSaveData("ASW_BOARD_TP_REPLY", bbt1Map, matchingColumName, whereColumName , null, null);
//					commService.setGdataModHis("ASW_BOARD_TP_REPLY", bbt1Map.get("BOARD_SEQ"), bbt1Map, UPDATE);
//				}
//			}
//
//			if(param.getArray("DTL_FILE_PATH") != null){
//
//				List<?> list = (List<?>) param.get("DTL_FILE_PATH_LIST");
//				UnCamelMap<String, Object> fileMap = new UnCamelMap<>();
//				UnCamelMap<String, Object> fileAttMap = new UnCamelMap<>();
//				for (int idx = 0; idx < list.size(); idx++) {
//					Map<String, String> attchMap = (Map<String, String>) list.get(idx);
//					// 게시판 첨부파일테이블
//					fileMap.put("BOARD_SEQ",bbt1Map.get("BOARD_SEQ"));
//					fileMap.put("ATTCH_CD",CommonUtil.nvl(commService.getPrCode("ATT")));
//					commService.tableSaveData("ASW_BOARD_ATTCH", fileMap, null, null , null, null);
//					// 첨부파일 저장
//					fileAttMap.put("ATTCH_CD", fileMap.getString("ATTCH_CD"));
//					fileAttMap.put("ATTCH_ID", savePath);
//					fileAttMap.put("ATTCH_FILE_NM", attchMap.get("ATTCH_FILE_NM"));
//					fileAttMap.put("ATTCH_REAL_FILE_NM", attchMap.get("ATTCH_REAL_FILE_NM"));
//					fileAttMap.put("ATTCH_FILE_PATH", attchMap.get("ATTCH_FILE_PATH"));
//					fileAttMap.put("ATTCH_ABSOLUTE_PATH", attchMap.get("ATTCH_ABSOLUTE_PATH"));
//					fileAttMap.put("ATTCH_REAL_ABSOLUTE_PATH", attchMap.get("ATTCH_REAL_ABSOLUTE_PATH"));
//					commService.tableSaveData("ASW_G_ATTCH", fileAttMap, null, null , null, null);
//				}
//			}
//			model.addAttribute("action", "parent.fnSearch && parent.fnSearch();");
//			return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + "bbt00002R.action?boardMstCd="+boardMstCd+"&boardSeq="+bbt1Map.get("BOARD_SEQ"));
//		}catch(Exception e){
//			logger.error(e.toString());
//			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + conUrl + "bbt00002R.action?boardMstCd="+boardMstCd);
//		}
//	}

	/**
	 * 게시판관리 : 제품후기 게시판 화면조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00003.do")
	public String bbt00003(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

//		List<?> cateList = amM706Service.amM706CL(paramMap);
//		model.addAttribute("cateList", cateList);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00003";
	}

	/**
	 * 게시판관리 : 제품후기 게시판 목록조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00003.action")
	public String bbt00003Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> list = bbtService.bbt00003L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "bbt00003D.action")
	public String bbt00003D(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		Map<String,Object> paramBoardMap = new HashMap<String, Object>();
    	for(int i=0; i < commandMap.size(); i++){
    		String boardSeq = CommonUtil.nvl(paramMap.get("DATA["+i+"]"));
    		paramBoardMap.put("BOARD_STATUS_YN", "N");
			commService.tableUpdate("ASW_BOARD_BASE", paramBoardMap, null, null, "AND BOARD_SEQ = '"+boardSeq+"'", null);
			commService.setGdataModHis("ASW_BOARD_BASE", "BOARD_SEQ : "+boardSeq, paramBoardMap, DELETE);

			commService.tableDelete("ASW_M_MBR_PT_LIST", null, " and BOARD_SEQ = '"+boardSeq+"'");
    		paramBoardMap.put("BOARD_SEQ", boardSeq);
			commService.setGdataModHis("ASW_M_MBR_PT_LIST", "BOARD_SEQ : "+boardSeq, paramBoardMap, DELETE);
    	}
		model.addAttribute("outData", egovMessageSource.getMessage("success.common.delete"));
		return "common/out";
	}

	/**
	 * 게시판관리 : 제품후기 게시판 수정 화면조회0
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00003R.action")
	public String bbt00003R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		List<?> funcList = bbtService.selectFunc(paramMap);
		model.addAttribute("funcList", funcList);

		if(!paramMap.getString("BOARD_SEQ").equals("")){
			Map<String, Object> viewMap = bbtService.bbt00001V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
			Map<String, Object> reviewMap = bbtService.bbt00003RV(paramMap);
			model.addAttribute("reviewMap", reviewMap);
		}
		model.addAttribute("cateSeq", paramMap.getString("BOARD_CATE_SEQ"));
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00003R";
	}

	/**
	 * 게시판관리 : 제품후기 게시판 수정 로직 (등록기능 없음)
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
//	@SuppressWarnings("unchecked")
//	@RequestMapping(value = "bbt00003Save.action")
//	public String bbt00003Save(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
//		init(model);
//
//		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
//		String savePath = "boardBBT3File";
//		String[] uploadName ={"dtlFilePath"};
//		UnCamelMap<String, Object>  param = fileUpLoad.docFileUpload(savePath,uploadName);
//		String boardMstCd = "";
//		try{
//			String[] whereColumName = null;
//			Map<String, Object> matchingColumName = new HashMap<String, Object>();
//			String boardTitle = (String) param.getString("BOARD_TITLE");
//			String boardCont = (String) param.getString("BOARD_CONT");
//			String boardCateSeq = (String) param.getString("BOARD_CATE_SEQ");
//
//			String boardFirstYn = (String) param.getString("BOARD_FIRST_YN");
//
//			String regDt = (String) param.getString("REG_DT");
//			boardMstCd = (String) param.getString("BOARD_MST_CD");
//			UnCamelMap<String, Object> bbt1Map = new UnCamelMap<>();
//			bbt1Map.put("BOARD_SEQ", param.getString("BOARD_SEQ"));
//			if(!boardTitle.equals("")){
//				bbt1Map.put("BOARD_TITLE", boardTitle);
//			}
//			if(!boardCont.equals("")){
//				bbt1Map.put("BOARD_CONT", boardCont);
//			}
//			if(!boardFirstYn.equals("")){
//				bbt1Map.put("BOARD_FIRST_YN", boardFirstYn);
//			}
//			bbt1Map.put("BOARD_CATE_SEQ", boardCateSeq);
//			whereColumName = new String[]{"BOARD_SEQ"};
//			commService.tableSaveData("ASW_BOARD_BASE", bbt1Map, null, whereColumName , null, null);
//			commService.setGdataModHis("ASW_BOARD_BASE", bbt1Map.get("BOARD_SEQ"), bbt1Map, UPDATE);
//			UnCamelMap<String, Object> prodMap = new UnCamelMap<>();
//			prodMap.put("BOARD_SEQ", bbt1Map.getString("BOARD_SEQ"));
//			prodMap.put("PROD_CD", param.getString("PROD_CD"));
//			commService.tableSaveData("ASW_BOARD_TP_PROD", prodMap, null, whereColumName , null, null);
//			commService.setGdataModHis("ASW_BOARD_TP_PROD", prodMap.get("BOARD_SEQ"), prodMap, UPDATE);
//			if(!param.getString("BOARD_REPLY").equals("&lt;p&gt;&amp;nbsp;&lt;/p&gt;")||!param.getString("BOARD_REPLY").equals("")){
//				bbt1Map.put("BOARD_REPLY", param.getString("BOARD_REPLY"));
//				bbt1Map.put("PROD_GRADE", param.getString("PROD_GRADE"));
//				bbt1Map.put("REP_DT", regDt);
//				matchingColumName.put("REP_ID", "$iui");
//				commService.tableSaveData("ASW_BOARD_TP_REVIEW", bbt1Map, matchingColumName, whereColumName , null, null);
//				commService.setGdataModHis("ASW_BOARD_TP_REVIEW", bbt1Map.get("BOARD_SEQ"), bbt1Map, UPDATE);
//			}
//			if(param.getArray("DTL_FILE_PATH") != null){
//				List<?> list = (List<?>) param.get("DTL_FILE_PATH_LIST");
//				UnCamelMap<String, Object> fileMap = new UnCamelMap<>();
//				UnCamelMap<String, Object> fileAttMap = new UnCamelMap<>();
//				for (int idx = 0; idx < list.size(); idx++) {
//					Map<String, String> attchMap = (Map<String, String>) list.get(idx);
//					fileMap.put("BOARD_SEQ",bbt1Map.get("BOARD_SEQ"));
//					fileMap.put("ATTCH_CD",CommonUtil.nvl(commService.getPrCode("ATT")));
//					commService.tableSaveData("ASW_BOARD_ATTCH", fileMap, null, null , null, null);
//					fileAttMap.put("ATTCH_CD", fileMap.getString("ATTCH_CD"));
//					fileAttMap.put("ATTCH_ID", savePath);
//					fileAttMap.put("ATTCH_FILE_NM", attchMap.get("ATTCH_FILE_NM"));
//					fileAttMap.put("ATTCH_REAL_FILE_NM", attchMap.get("ATTCH_REAL_FILE_NM"));
//					fileAttMap.put("ATTCH_FILE_PATH", attchMap.get("ATTCH_FILE_PATH"));
//					fileAttMap.put("ATTCH_ABSOLUTE_PATH", attchMap.get("ATTCH_ABSOLUTE_PATH"));
//					fileAttMap.put("ATTCH_REAL_ABSOLUTE_PATH", attchMap.get("ATTCH_REAL_ABSOLUTE_PATH"));
//					commService.tableSaveData("ASW_G_ATTCH", fileAttMap, null, null , null, null);
//				}
//			}
//			model.addAttribute("action", "parent.fnSearch && parent.fnSearch();");
//			return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + "bbt00003R.action?boardMstCd="+boardMstCd+"&boardSeq="+bbt1Map.get("BOARD_SEQ"));
//		}catch(Exception e){
//			logger.error(e.toString());
//			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + conUrl + "bbt00003R.action?boardMstCd="+boardMstCd);
//		}
//	}

	@RequestMapping(value = "bbt00004.do")
	public String bbt00004(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00004";
	}

	@RequestMapping(value = "bbt00004.action")
	public String bbt00004Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> list = bbtService.bbt00001L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "bbt00004D.action")
	public String bbt00004D(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		Map<String,Object> paramBoardMap = new HashMap<String, Object>();
    	for(int i=0; i < commandMap.size(); i++){
    		String boardSeq = CommonUtil.nvl(paramMap.get("DATA["+i+"]"));
    		paramBoardMap.put("BOARD_STATUS_YN", "N");
			commService.tableUpdate("ASW_BOARD_BASE", paramBoardMap, null, null, "AND BOARD_SEQ = '"+boardSeq+"'", null);
			commService.setGdataModHis("ASW_BOARD_BASE", "BOARD_SEQ : "+boardSeq, paramBoardMap, DELETE);
    	}
		model.addAttribute("outData", egovMessageSource.getMessage("success.common.delete"));
		return "common/out";
	}

	@RequestMapping(value = "bbt00004R.action")
	public String bbt00004R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		List<?> funcList = bbtService.selectFunc(paramMap);
		model.addAttribute("funcList", funcList);

		if(paramMap.getString("BOARD_SEQ").equals("")){
			int bbt1Cnt = bbtService.bbt00001C(paramMap);
			model.addAttribute("bbt1Cnt", bbt1Cnt);
		}else{
			Map<String, Object> viewMap = bbtService.bbt00001V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("cateSeq", paramMap.getString("BOARD_CATE_SEQ"));
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00004R";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "bbt00004Save.action")
	public String bbt00004Save(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		init(model);

		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
		String savePath = "boardBBT4File";
		String[] uploadName ={"dtlFilePath"};
		UnCamelMap<String, Object>  param = fileUpLoad.docFileUpload(savePath,uploadName);

		String boardMstCd = "";
		try{
			String[] whereColumName = null;
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			String boardTitle = (String) param.getString("BOARD_TITLE");
			String boardCont = (String) param.getString("BOARD_CONT");
			String boardCateSeq = (String) param.getString("BOARD_CATE_SEQ");
			String regDt = (String) param.getString("REG_DT");
			boardMstCd = (String) param.getString("BOARD_MST_CD");
			String boardFirstYn = (String) param.getString("BOARD_FIRST_YN");

			UnCamelMap<String, Object> bbt1Map = new UnCamelMap<>();

			if(param.getString("BOARD_SEQ").equals("")){
				bbt1Map.put("BOARD_MST_CD", boardMstCd);
				bbt1Map.put("BOARD_SEQ", CommonUtil.nvl(commService.getPrSeq("BOARD_SEQ")));
				bbt1Map.put("BOARD_TITLE", boardTitle);
				bbt1Map.put("BOARD_CONT", boardCont);
				bbt1Map.put("BOARD_CATE_SEQ", boardCateSeq);
				bbt1Map.put("REG_DT", regDt);

				if(!boardFirstYn.equals("")){
					bbt1Map.put("BOARD_FIRST_YN", boardFirstYn);
				}
				bbt1Map.put("BOARD_FIRST_YN", "N");
				bbt1Map.put("BOARD_STATUS_YN", "Y");
				bbt1Map.put("DATA_USER_TP_MA", "A");
				bbt1Map.put("BOARD_HIT", 0);
				bbt1Map.put("REG_IP", request.getRemoteAddr());
				bbt1Map.put("REG_AGENT", request.getHeader("User-Agent"));
				matchingColumName.put("REG_ID", "$iui");
				commService.tableSaveData("ASW_BOARD_BASE", bbt1Map, matchingColumName, whereColumName , null, null);
				commService.setGdataModHis("ASW_BOARD_BASE", bbt1Map.get("BOARD_SEQ"), bbt1Map, INSERT);
			}else{
				bbt1Map.put("BOARD_SEQ", param.getString("BOARD_SEQ"));
				bbt1Map.put("BOARD_TITLE", boardTitle);
				bbt1Map.put("BOARD_CONT", boardCont);
				bbt1Map.put("BOARD_CATE_SEQ", boardCateSeq);

				if(!boardFirstYn.equals("")){
					bbt1Map.put("BOARD_FIRST_YN", boardFirstYn);
				}
				whereColumName = new String[]{"BOARD_SEQ"};
				commService.tableSaveData("ASW_BOARD_BASE", bbt1Map, null, whereColumName , null, null);
				commService.setGdataModHis("ASW_BOARD_BASE", bbt1Map.get("BOARD_SEQ"), bbt1Map, UPDATE);
			}

			if(param.getArray("DTL_FILE_PATH") != null){

				List<?> list = (List<?>) param.get("DTL_FILE_PATH_LIST");
				UnCamelMap<String, Object> fileMap = new UnCamelMap<>();
				UnCamelMap<String, Object> fileAttMap = new UnCamelMap<>();
				for (int idx = 0; idx < list.size(); idx++) {
					Map<String, String> attchMap = (Map<String, String>) list.get(idx);
					// 게시판 첨부파일테이블
					fileMap.put("BOARD_SEQ",bbt1Map.get("BOARD_SEQ"));
					fileMap.put("ATTCH_CD",CommonUtil.nvl(commService.getPrCode("ATT")));
					commService.tableSaveData("ASW_BOARD_ATTCH", fileMap, null, null , null, null);
					// 첨부파일 저장
					fileAttMap.put("ATTCH_CD", fileMap.getString("ATTCH_CD"));
					fileAttMap.put("ATTCH_ID", savePath);
					fileAttMap.put("ATTCH_FILE_NM", attchMap.get("ATTCH_FILE_NM"));
					fileAttMap.put("ATTCH_REAL_FILE_NM", attchMap.get("ATTCH_REAL_FILE_NM"));
					fileAttMap.put("ATTCH_FILE_PATH", attchMap.get("ATTCH_FILE_PATH"));
					fileAttMap.put("ATTCH_ABSOLUTE_PATH", attchMap.get("ATTCH_ABSOLUTE_PATH"));
					fileAttMap.put("ATTCH_REAL_ABSOLUTE_PATH", attchMap.get("ATTCH_REAL_ABSOLUTE_PATH"));
					commService.tableSaveData("ASW_G_ATTCH", fileAttMap, null, null , null, null);
				}
			}
			return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + "bbt00004R.action?boardMstCd="+boardMstCd+"&boardSeq="+bbt1Map.get("BOARD_SEQ"), model);
		}catch(Exception e){
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + conUrl + "bbt00004R.action?boardMstCd="+boardMstCd, model);
		}
	}

	/**
	 *
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00005.do")
	public String bbt00005(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00005";
	}

	@RequestMapping(value = "bbt00005.action")
	public String bbt00005Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> list = bbtService.bbt00005L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "bbt00005D.action")
	public String bbt00005D(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		Map<String,Object> paramBoardMap = new HashMap<String, Object>();
    	for(int i=0; i < commandMap.size(); i++){
    		String boardSeq = CommonUtil.nvl(paramMap.get("DATA["+i+"]"));
    		paramBoardMap.put("BOARD_STATUS_YN", "N");
			commService.tableUpdate("ASW_BOARD_BASE", paramBoardMap, null, null, "AND BOARD_SEQ = '"+boardSeq+"'", null);
			commService.setGdataModHis("ASW_BOARD_BASE", "BOARD_SEQ : "+boardSeq, paramBoardMap, DELETE);
    	}
		model.addAttribute("outData", egovMessageSource.getMessage("success.common.delete"));
		return "common/out";
	}

	/**
	 *
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00005R.action")
	public String bbt00005R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		List<?> funcList = bbtService.selectFunc(paramMap);
		model.addAttribute("funcList", funcList);
		if(!paramMap.getString("BOARD_SEQ").equals("")){
			Map<String, Object> viewMap = bbtService.bbt00001V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
			Map<String, Object> tpMap = bbtService.bbt00005TP(paramMap);
			model.addAttribute("tpMap", tpMap);
		}
		model.addAttribute("cateSeq", paramMap.getString("BOARD_CATE_SEQ"));
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00005R";
	}

	@SuppressWarnings({ "unchecked" })
	@RequestMapping(value = "bbt00005Save.action")
	public String bbt00005Save(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		init(model);
		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
		String savePath = "boardBBT5Img";
		String[] uploadName ={"dtlImgPath"};
		UnCamelMap<String, Object>  param = fileUpLoad.imgFileUpload(savePath,uploadName);

		String boardMstCd = "";
		try{
			String[] whereColumName = null;
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			String boardTitle = (String) param.getString("BOARD_TITLE");
			String boardCont = (String) param.getString("BOARD_CONT");
			String boardCateSeq = (String) param.getString("BOARD_CATE_SEQ");
			String regDt = (String) param.getString("REG_DT");
			boardMstCd = (String) param.getString("BOARD_MST_CD");
			String boardFirstYn = (String) param.getString("BOARD_FIRST_YN");

			UnCamelMap<String, Object> bbt1Map = new UnCamelMap<>();

			if(param.getString("BOARD_SEQ").equals("")){
				bbt1Map.put("BOARD_MST_CD", boardMstCd);
				bbt1Map.put("BOARD_SEQ", CommonUtil.nvl(commService.getPrSeq("BOARD_SEQ")));
				bbt1Map.put("BOARD_TITLE", boardTitle);
				bbt1Map.put("BOARD_CONT", boardCont);
				bbt1Map.put("BOARD_CATE_SEQ", boardCateSeq);

				if(!boardFirstYn.equals("")){
					bbt1Map.put("BOARD_FIRST_YN", boardFirstYn);
				}
				bbt1Map.put("REG_DT", regDt);
				bbt1Map.put("BOARD_FIRST_YN", "N");
				bbt1Map.put("BOARD_STATUS_YN", "Y");
				bbt1Map.put("DATA_USER_TP_MA", "A");
				bbt1Map.put("BOARD_HIT", 0);
				bbt1Map.put("REG_IP", request.getRemoteAddr());
				bbt1Map.put("REG_AGENT", request.getHeader("User-Agent"));
				matchingColumName.put("REG_ID", "$iui");
				commService.tableSaveData("ASW_BOARD_BASE", bbt1Map, matchingColumName, whereColumName , null, null);
				commService.setGdataModHis("ASW_BOARD_BASE", bbt1Map.get("BOARD_SEQ"), bbt1Map, INSERT);
			}else{
				bbt1Map.put("BOARD_SEQ", param.getString("BOARD_SEQ"));
				bbt1Map.put("BOARD_TITLE", boardTitle);
				bbt1Map.put("BOARD_CONT", boardCont);
				bbt1Map.put("BOARD_CATE_SEQ", boardCateSeq);

				if(!boardFirstYn.equals("")){
					bbt1Map.put("BOARD_FIRST_YN", boardFirstYn);
				}
				whereColumName = new String[]{"BOARD_SEQ"};
				commService.tableSaveData("ASW_BOARD_BASE", bbt1Map, null, whereColumName , null, null);
				commService.setGdataModHis("ASW_BOARD_BASE", param.get("BOARD_SEQ"), param, UPDATE);
				bbt1Map.put("IMAGE_TP_LE", param.getString("CONT_STATE"));
				bbt1Map.put("IMAGE_WIDTH", param.getString("IMAGE_WIDTH"));
				bbt1Map.put("IMAGE_HEIGHT", param.getString("IMAGE_HEIGHT"));
				commService.tableSaveData("ASW_BOARD_TP_IMAGE", bbt1Map, null, whereColumName , null, null);
				commService.setGdataModHis("ASW_BOARD_TP_IMAGE", bbt1Map.get("BOARD_SEQ"), param, UPDATE);
			}

			if(param.getArray("DTL_IMG_PATH") != null){
				int[] imageArr = new int[]{314};
				List<?> list = (List<?>) param.get("DTL_IMG_PATH_LIST");
				Map<String, String> fileMap = (Map<String, String>) list.get(0);
				List<UnCamelMap<String, Object>> fileMaplist = fileUpLoad.setImageSize(fileMap, imageArr);
				if(imageArr.length > 0){
//					int i = 0;
					for(UnCamelMap<String, Object> ImgAttMap : fileMaplist){
						ImgAttMap.put("BOARD_SEQ",bbt1Map.getString("BOARD_SEQ"));
						commService.tableDelete("ASW_BOARD_ATTCH", null,"and BOARD_SEQ ='"+bbt1Map.getString("BOARD_SEQ")+"'");
						commService.setGdataModHis("ASW_BOARD_ATTCH", bbt1Map.getString("BOARD_SEQ"), bbt1Map, DELETE);
						ImgAttMap.put("ATTCH_CD",CommonUtil.nvl(commService.getPrCode("ATT")));
						commService.tableSaveData("ASW_BOARD_ATTCH", ImgAttMap, null, whereColumName , null, null);
						commService.setGdataModHis("ASW_BOARD_ATTCH", ImgAttMap.getString("BOARD_SEQ"), ImgAttMap, UPDATE);
						UnCamelMap<String, Object> ImgMap = new UnCamelMap<>();
						ImgMap.put("ATTCH_CD", ImgAttMap.getString("ATTCH_CD"));
						ImgMap.put("ATTCH_ID", savePath);
						ImgMap.put("ATTCH_FILE_NM", ImgAttMap.get("ATTCH_FILE_NM"));
						ImgMap.put("ATTCH_REAL_FILE_NM", ImgAttMap.get("ATTCH_REAL_FILE_NM"));
						ImgMap.put("ATTCH_FILE_PATH", ImgAttMap.get("ATTCH_FILE_PATH"));
						ImgMap.put("ATTCH_ABSOLUTE_PATH", ImgAttMap.get("ATTCH_ABSOLUTE_PATH"));
						ImgMap.put("ATTCH_REAL_ABSOLUTE_PATH", ImgAttMap.get("ATTCH_REAL_ABSOLUTE_PATH"));
						whereColumName = new String[]{"ATTCH_CD"};
						commService.tableSaveData("ASW_G_ATTCH", ImgMap, null, whereColumName , null, null);
						commService.setGdataModHis("ASW_G_ATTCH", ImgMap.getString("ATTCH_CD"), ImgMap, UPDATE);
						UnCamelMap<String, Object> dltImgMap = new UnCamelMap<>();
						dltImgMap.put("BOARD_SEQ", bbt1Map.get("BOARD_SEQ"));
						dltImgMap.put("IMAGE_TP_LE", param.getString("CONT_STATE"));
						dltImgMap.put("ATTCH_CD", ImgAttMap.getString("ATTCH_CD"));
						dltImgMap.put("IMAGE_WIDTH", param.getString("IMAGE_WIDTH"));
						dltImgMap.put("IMAGE_HEIGHT", param.getString("IMAGE_HEIGHT"));
						whereColumName = new String[]{"BOARD_SEQ"};
						commService.tableSaveData("ASW_BOARD_TP_IMAGE", dltImgMap, null, whereColumName , null, null);
						commService.setGdataModHis("ASW_BOARD_TP_IMAGE", dltImgMap.get("BOARD_SEQ"), ImgAttMap, UPDATE);
//						i++;
					}
				}
			}
			return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + "bbt00005R.action?boardMstCd="+boardMstCd+"&boardSeq="+bbt1Map.get("BOARD_SEQ"), model);
		}catch(Exception e){
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + conUrl + "bbt00005R.action?boardMstCd="+boardMstCd, model);
		}
	}

	@RequestMapping(value = "bbt00006.do")
	public String bbt00006(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00006";
	}

	@RequestMapping(value = "bbt00006.action")
	public String bbt00006Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> list = bbtService.bbt00002L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}
	
	@RequestMapping(value = "bbt00006V.do")
	public String bbt00006V(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		if(!paramMap.getString("BOARD_SEQ").equals("")){
			Map<String, Object> viewMap = bbtService.bbt00006V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00006V";
	}

	@RequestMapping(value = "bbt00006R.action")
	public String bbt00006R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		if(!paramMap.getString("BOARD_SEQ").equals("")){
			Map<String, Object> viewMap = bbtService.bbt00006V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00006R";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "bbt00006Save.action")
	public String bbt00006Save(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		init(model);

		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
		String savePath = "boardBBT2File";
		String[] uploadName ={"dtlFilePath"};
		UnCamelMap<String, Object>  param = fileUpLoad.docFileUpload(savePath,uploadName);

		String boardMstCd = "";
		try{
			String[] whereColumName = null;
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			boardMstCd = (String) param.getString("BOARD_MST_CD");

			UnCamelMap<String, Object> bbt1Map = new UnCamelMap<>();

			bbt1Map.put("BOARD_SEQ", param.getString("BOARD_SEQ"));

			whereColumName = new String[]{"BOARD_SEQ"};
			if(!param.getString("BOARD_REPLY").equals("&lt;p&gt;&amp;nbsp;&lt;/p&gt;")){
				bbt1Map.put("BOARD_REPLY", param.getString("BOARD_REPLY"));
				matchingColumName.put("REP_DT", "$udate");
				matchingColumName.put("REP_ID", "$uui");
				commService.tableSaveData("ASW_BOARD_TP_REPLY", bbt1Map, matchingColumName, whereColumName , null, null);
				commService.setGdataModHis("ASW_BOARD_TP_REPLY", bbt1Map.get("BOARD_SEQ"), bbt1Map, UPDATE);
			}
			if(param.getArray("DTL_FILE_PATH") != null){
				List<?> list = (List<?>) param.get("DTL_FILE_PATH_LIST");
				UnCamelMap<String, Object> fileMap = new UnCamelMap<>();
				UnCamelMap<String, Object> fileAttMap = new UnCamelMap<>();
				for (int idx = 0; idx < list.size(); idx++) {
					Map<String, String> attchMap = (Map<String, String>) list.get(idx);
					// 게시판 첨부파일테이블
					fileMap.put("BOARD_SEQ",bbt1Map.get("BOARD_SEQ"));
					fileMap.put("ATTCH_CD",CommonUtil.nvl(commService.getPrCode("ATT")));
					commService.tableSaveData("ASW_BOARD_ATTCH", fileMap, null, null , null, null);
					// 첨부파일 저장
					fileAttMap.put("ATTCH_CD", fileMap.getString("ATTCH_CD"));
					fileAttMap.put("ATTCH_ID", savePath);
					fileAttMap.put("ATTCH_FILE_NM", attchMap.get("ATTCH_FILE_NM"));
					fileAttMap.put("ATTCH_REAL_FILE_NM", attchMap.get("ATTCH_REAL_FILE_NM"));
					fileAttMap.put("ATTCH_FILE_PATH", attchMap.get("ATTCH_FILE_PATH"));
					fileAttMap.put("ATTCH_ABSOLUTE_PATH", attchMap.get("ATTCH_ABSOLUTE_PATH"));
					fileAttMap.put("ATTCH_REAL_ABSOLUTE_PATH", attchMap.get("ATTCH_REAL_ABSOLUTE_PATH"));
					commService.tableSaveData("ASW_G_ATTCH", fileAttMap, null, null , null, null);
				}
			}
			return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + "bbt00006R.action?boardMstCd="+boardMstCd+"&boardSeq="+bbt1Map.get("BOARD_SEQ"), model);
		}catch(Exception e){
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + conUrl + "bbt00006R.action?boardMstCd="+boardMstCd, model);
		}
	}

	@RequestMapping(value = "bbt00006D.action")
	public String bbt00006D(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		Map<String,Object> paramBoardMap = new HashMap<String, Object>();
    	for(int i=0; i < commandMap.size(); i++){
    		String boardSeq = CommonUtil.nvl(paramMap.get("DATA["+i+"]"));
    		paramBoardMap.put("BOARD_STATUS_YN", "N");
			commService.tableUpdate("ASW_BOARD_BASE", paramBoardMap, null, null, "AND BOARD_SEQ = '"+boardSeq+"'", null);
			commService.setGdataModHis("ASW_BOARD_BASE", "BOARD_SEQ : "+boardSeq, paramBoardMap, DELETE);
    	}
		model.addAttribute("outData", egovMessageSource.getMessage("success.common.delete"));
		return "common/out";
	}

	
	
	/**
	 * 부품구매 화면조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00007.do")
	public String bbt00007(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00007";
	}

	/**
	 * 부품구매 목록조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00007.action")
	public String bbt00007Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> list = bbtService.bbt00007L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}
	
	/**
	 * 부품구매 등록화면조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00007R.action")
	public String bbt00007R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		List<?> funcList = bbtService.selectFunc(paramMap);
		model.addAttribute("funcList", funcList);

		if(!paramMap.getString("BOARD_SEQ").equals("")){
			Map<String, Object> viewMap = bbtService.bbt00007V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);

			//이미지 경로처리 (페이크 페스가 아니고 드라이브부터 잡혀 있어서 자르기 처리)
//			ArrayList<HashMap<String, Object>> newfileList = new ArrayList<HashMap<String, Object>>();
//			for (int i = 0; i < fileList.size(); i++) {
//				HashMap<String, Object> fMap = (HashMap<String, Object>)fileList.get(i);
//				String fPath = (String)fMap.get("attchFilePath");
//				String[] fArr = fPath.split("upload");
//				fMap.put("attchFilePath", fArr[1]);
//				newfileList.add(fMap);
//			}
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("cateSeq", paramMap.getString("BOARD_CATE_SEQ"));
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00007R";
	}

	/**
	 *
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00008.do")
	public String bbt00008(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00008";
	}

	@RequestMapping(value = "bbt00008.action")
	public String bbt00008Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> list = bbtService.bbt00005L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/**
	 *
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00008R.action")
	public String bbt00008R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		List<?> funcList = bbtService.selectFunc(paramMap);
		model.addAttribute("funcList", funcList);
		if(!paramMap.getString("BOARD_SEQ").equals("")){
			Map<String, Object> viewMap = bbtService.bbt00001V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
			Map<String, Object> tpMap = bbtService.bbt00008TP(paramMap);
			model.addAttribute("tpMap", tpMap);
		}
		model.addAttribute("cateSeq", paramMap.getString("BOARD_CATE_SEQ"));
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00008R";
	}

	@RequestMapping(value = "bbt00008Save.action")
	public String bbt00008Save(@RequestParam Map<String, Object> commandMap,  ModelMap model, HttpServletRequest request, HttpServletResponse response) throws Exception {
		
	init(model);

	FileUpLoad fileUpLoad = new FileUpLoad(request, response);
	String savePath = "boardBBT8File";
	String[] uploadName ={"dtlFilePath"};
	UnCamelMap<String, Object>  param = fileUpLoad.imgFileUpload(savePath,uploadName);

	String boardMstCd = "";
	try{
		String[] whereColumName = null;
		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		String boardTitle = (String) param.getString("BOARD_TITLE");
		String boardCont = (String) param.getString("BOARD_CONT");
		String boardCateSeq = (String) param.getString("BOARD_CATE_SEQ");
		String regDt = (String) param.getString("REG_DT");
		boardMstCd = (String) param.getString("BOARD_MST_CD");

		UnCamelMap<String, Object> bbt1Map = new UnCamelMap<>();
		String regType = "";
		if(param.getString("BOARD_SEQ").equals("")){
			bbt1Map.put("BOARD_SEQ", CommonUtil.nvl(commService.getPrSeq("BOARD_SEQ")));
			bbt1Map.put("REG_DT", regDt);
			bbt1Map.put("REG_IP", request.getRemoteAddr());
			bbt1Map.put("REG_AGENT", request.getHeader("User-Agent"));
			matchingColumName.put("REG_ID", "$iui");
			regType = "I";
		}else{
			bbt1Map.put("BOARD_SEQ", param.getString("BOARD_SEQ"));
			regType = "U";
		}

		if(!boardTitle.equals("")){
			bbt1Map.put("BOARD_TITLE", boardTitle);
		}
			bbt1Map.put("BOARD_MST_CD", boardMstCd);
			if(!boardCont.equals("")){
			bbt1Map.put("BOARD_CONT", boardCont);
			}
			if(!boardCateSeq.equals("")){
			bbt1Map.put("BOARD_CATE_SEQ", boardCateSeq);
			}else{
				bbt1Map.put("BOARD_CATE_SEQ", "0");
			}
			
			bbt1Map.put("BOARD_FIRST_YN", "N");
			bbt1Map.put("BOARD_STATUS_YN", "Y");
			bbt1Map.put("DATA_USER_TP_MA", "A");
			bbt1Map.put("REG_IP", request.getRemoteAddr());
			bbt1Map.put("REG_AGENT", request.getHeader("User-Agent"));
			matchingColumName.put("REG_ID", "$iui");
			matchingColumName.put("REG_DT", "$idate");
			whereColumName = new String[]{"BOARD_SEQ"};
			commService.tableSaveData("ASW_BOARD_BASE", bbt1Map, matchingColumName, whereColumName , null, null);
			commService.setGdataModHis("ASW_BOARD_BASE", bbt1Map.get("BOARD_SEQ"), bbt1Map, INSERT);
			bbt1Map.put("MOV_WIDTH", param.getString("MOV_WIDTH"));
			bbt1Map.put("MOV_HEIGHT", param.getString("MOV_HEIGHT"));
			bbt1Map.put("YOUTUBE_LINK", param.getString("YOUTUBE_LINK"));
			commService.tableSaveData("ASW_BOARD_TP_YOUTUBE", bbt1Map, null, whereColumName , null, null);
			commService.setGdataModHis("ASW_BOARD_TP_YOUTUBE", bbt1Map.get("BOARD_SEQ"), param, regType);

			matchingColumName.clear();

		if(param.getArray("DTL_FILE_PATH") != null){
			if(!param.getString("ATTCH_CD").equals("")){
			commService.tableDelete("ASW_BOARD_ATTCH", null,"and ATTCH_CD ='"+param.getString("ATTCH_CD")+"'");
			commService.setGdataModHis("ASW_BOARD_ATTCH", param.get("ATTCH_CD"), param, DELETE);
			commService.tableDelete("ASW_G_ATTCH", null,"and ATTCH_CD ='"+param.getString("ATTCH_CD")+"'");
			commService.setGdataModHis("ASW_G_ATTCH", param.get("ATTCH_CD"), param, DELETE);
			}
			
			List<?> list = (List<?>) param.get("DTL_FILE_PATH_LIST");
			UnCamelMap<String, Object> fileMap = new UnCamelMap<>();
			UnCamelMap<String, Object> fileAttMap = new UnCamelMap<>();
			for (int idx = 0; idx < list.size(); idx++) {
				@SuppressWarnings("unchecked")
				Map<String, String> attchMap = (Map<String, String>) list.get(idx);
				// 게시판 첨부파일테이블
				fileMap.put("BOARD_SEQ",bbt1Map.get("BOARD_SEQ"));
				fileMap.put("ATTCH_CD",CommonUtil.nvl(commService.getPrCode("ATT")));
				commService.tableSaveData("ASW_BOARD_ATTCH", fileMap, null, null , null, null);
				// 첨부파일 저장
				fileAttMap.put("ATTCH_CD", fileMap.getString("ATTCH_CD"));
				fileAttMap.put("ATTCH_ID", savePath);
				fileAttMap.put("ATTCH_FILE_NM", attchMap.get("ATTCH_FILE_NM"));
				fileAttMap.put("ATTCH_REAL_FILE_NM", attchMap.get("ATTCH_REAL_FILE_NM"));
				fileAttMap.put("ATTCH_FILE_PATH", attchMap.get("ATTCH_FILE_PATH"));
				fileAttMap.put("ATTCH_ABSOLUTE_PATH", attchMap.get("ATTCH_ABSOLUTE_PATH"));
				fileAttMap.put("ATTCH_REAL_ABSOLUTE_PATH", attchMap.get("ATTCH_REAL_ABSOLUTE_PATH"));
				commService.tableSaveData("ASW_G_ATTCH", fileAttMap, null, null , null, null);
			}
		}
		return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl +"bbt00008R.action?boardMstCd="+boardMstCd+"&boardSeq="+bbt1Map.get("BOARD_SEQ"), model);
	}catch(Exception e){
		logger.error(e.toString());
		return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + conUrl + "bbt00008R.action?boardMstCd="+boardMstCd, model);
	}

}
	
	
	/**
	 * 게시판관리 : 첨부파일전용 화면조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00009.do")
	public String bbt00009(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00009";
	}

	/**
	 * 게시판관리 : 첨부파일전용 목록조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00009.action")
	public String bbt00009Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);
		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);
		List<?> list = bbtService.bbt00001L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/**
	 * 게시판관리 : 첨부파일전용 목록정지
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00009D.action")
	public String bbt00009D(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		Map<String,Object> paramBoardMap = new HashMap<String, Object>();
    	for(int i=0; i < commandMap.size(); i++){
    		String boardSeq = CommonUtil.nvl(paramMap.get("DATA["+i+"]"));
    		paramBoardMap.put("BOARD_STATUS_YN", "N");
			commService.tableUpdate("ASW_BOARD_BASE", paramBoardMap, null, null, "AND BOARD_SEQ = '"+boardSeq+"'", null);
			commService.setGdataModHis("ASW_BOARD_BASE", "BOARD_SEQ : "+boardSeq, paramBoardMap, DELETE);
    	}
		model.addAttribute("outData", egovMessageSource.getMessage("success.common.delete"));
		return "common/out";
	}

	/**
	 * 게시판관리 : 첨부파일전용 등록화면조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00009R.action")
	public String bbt00009R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		List<?> funcList = bbtService.selectFunc(paramMap);
		model.addAttribute("funcList", funcList);

		if(!paramMap.getString("BOARD_SEQ").equals("")){
			Map<String, Object> viewMap = bbtService.bbt00001V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("cateSeq", paramMap.getString("BOARD_CATE_SEQ"));
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00009R";
	}

	
	/**
	 * 게시판관리 : 공지사항 등록 및 수정 처리
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "bbt00009Save.action")
	public String bbt00009Save(HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		init(model);

		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
		String savePath = "boardBBT9File";
		String[] uploadName ={"dtlFilePath"};
		UnCamelMap<String, Object>  param = fileUpLoad.docFileUpload(savePath,uploadName);

		String boardMstCd = "";
		try{
			String[] whereColumName = null;
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			String boardTitle = (String) param.getString("BOARD_TITLE");
			String boardCont = (String) param.getString("BOARD_CONT");
			String boardCateSeq = (String) param.getString("BOARD_CATE_SEQ");
//			String regDt = (String) param.getString("REG_DT");
			boardMstCd = (String) param.getString("BOARD_MST_CD");

			UnCamelMap<String, Object> bbt1Map = new UnCamelMap<>();
			if(param.getString("BOARD_SEQ").equals("")){
				bbt1Map.put("BOARD_SEQ", CommonUtil.nvl(commService.getPrSeq("BOARD_SEQ")));
			}else{
				bbt1Map.put("BOARD_SEQ", param.getString("BOARD_SEQ"));
			}

			if(!boardTitle.equals("")){
				bbt1Map.put("BOARD_TITLE", boardTitle);
			}
				bbt1Map.put("BOARD_MST_CD", boardMstCd);
				if(!boardCont.equals("")){
				bbt1Map.put("BOARD_CONT", boardCont);
				}
				if(!boardCateSeq.equals("")){
				bbt1Map.put("BOARD_CATE_SEQ", boardCateSeq);
				}else{
					bbt1Map.put("BOARD_CATE_SEQ", "0");
				}

				bbt1Map.put("BOARD_FIRST_YN", "N");
				bbt1Map.put("BOARD_STATUS_YN", "Y");
				bbt1Map.put("DATA_USER_TP_MA", "A");
				bbt1Map.put("REG_IP", request.getRemoteAddr());
				bbt1Map.put("REG_AGENT", request.getHeader("User-Agent"));
				matchingColumName.put("REG_ID", "$iui");
				matchingColumName.put("REG_DT", "$idate");
				whereColumName = new String[]{"BOARD_SEQ"};
				commService.tableSaveData("ASW_BOARD_BASE", bbt1Map, matchingColumName, whereColumName , null, null);
				commService.setGdataModHis("ASW_BOARD_BASE", bbt1Map.get("BOARD_SEQ"), bbt1Map, INSERT);

				matchingColumName.clear();

			if(param.getArray("DTL_FILE_PATH") != null){
				if(!param.getString("ATTCH_CD").equals("")){
				commService.tableDelete("ASW_BOARD_ATTCH", null,"and ATTCH_CD ='"+param.getString("ATTCH_CD")+"'");
				commService.setGdataModHis("ASW_BOARD_ATTCH", param.get("ATTCH_CD"), param, DELETE);
				commService.tableDelete("ASW_G_ATTCH", null,"and ATTCH_CD ='"+param.getString("ATTCH_CD")+"'");
				commService.setGdataModHis("ASW_G_ATTCH", param.get("ATTCH_CD"), param, DELETE);
				}
				
				List<?> list = (List<?>) param.get("DTL_FILE_PATH_LIST");
				UnCamelMap<String, Object> fileMap = new UnCamelMap<>();
				UnCamelMap<String, Object> fileAttMap = new UnCamelMap<>();
				for (int idx = 0; idx < list.size(); idx++) {
					Map<String, String> attchMap = (Map<String, String>) list.get(idx);
					// 게시판 첨부파일테이블
					fileMap.put("BOARD_SEQ",bbt1Map.get("BOARD_SEQ"));
					fileMap.put("ATTCH_CD",CommonUtil.nvl(commService.getPrCode("ATT")));
					commService.tableSaveData("ASW_BOARD_ATTCH", fileMap, null, null , null, null);
					// 첨부파일 저장
					fileAttMap.put("ATTCH_CD", fileMap.getString("ATTCH_CD"));
					fileAttMap.put("ATTCH_ID", savePath);
					fileAttMap.put("ATTCH_FILE_NM", attchMap.get("ATTCH_FILE_NM"));
					fileAttMap.put("ATTCH_REAL_FILE_NM", attchMap.get("ATTCH_REAL_FILE_NM"));
					fileAttMap.put("ATTCH_FILE_PATH", attchMap.get("ATTCH_FILE_PATH"));
					fileAttMap.put("ATTCH_ABSOLUTE_PATH", attchMap.get("ATTCH_ABSOLUTE_PATH"));
					fileAttMap.put("ATTCH_REAL_ABSOLUTE_PATH", attchMap.get("ATTCH_REAL_ABSOLUTE_PATH"));
					commService.tableSaveData("ASW_G_ATTCH", fileAttMap, null, null , null, null);
				}
			}
			return messageRedirect(egovMessageSource.getMessage("success.common.save"), ROOT_URI + conUrl + param.getString("BBT_CD")+"R.action?boardMstCd="+boardMstCd+"&boardSeq="+bbt1Map.get("BOARD_SEQ"), model);
		}catch(Exception e){
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI + conUrl + param.getString("BBT_CD")+"R.action?boardMstCd="+boardMstCd, model);
		}

	}
	
	
	/**
	 * 게시판관리 : 추천게시판 화면조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00010.do")
	public String bbt00010(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00010";
	}

	/**
	 * 게시판관리 : 추천게시판 목록조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00010.action")
	public String bbt00010Ajax(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		init(model);
		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);
		List<?> list = bbtService.bbt00010L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	

	/**
	 * 게시판관리 : 추천게시판 등록화면조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00010R.action")
	public String bbt00010R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		paramMap.putAll(commandMap);

		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		List<?> funcList = bbtService.selectFunc(paramMap);
		model.addAttribute("funcList", funcList);

		if(!paramMap.getString("BOARD_SEQ").equals("")){
			Map<String, Object> viewMap = bbtService.bbt00001V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
		}
		model.addAttribute("cateSeq", paramMap.getString("BOARD_CATE_SEQ"));
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("conUrl", conUrl);
		return conUrl + "bbt00010R";
	}
	
	
	
}
