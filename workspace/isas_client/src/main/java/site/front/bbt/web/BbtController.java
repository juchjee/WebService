package site.front.bbt.web;

import java.io.FileNotFoundException;
import java.io.IOException;
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

import devpia.dextupload.DEXTUploadException;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.FileDownLoad;
import egovframework.cmmn.util.PagingUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.front.bbt.service.impl.BbtService;

/**
 * @author taehoon_kil
 *
 */
@Controller
@RequestMapping(value = IConstants.ISDS_URL + "bbt")
public class BbtController extends BaseController{

	private static final String conUrl = ISDS_URL + "bbt/";

	/** EtcService */
	@Resource(name = "BbtService")
	private BbtService bbtService;

	/**
	 * 고객센터 : 공지사항 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00001.do")
	public String bbt00001(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			//String boardTpCd = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
			//paramMap.put("BOARD_MST_CD", boardTpCd);
			model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
			int allCnt = bbtService.allListCount(paramMap);
			model.addAttribute("allCnt",allCnt);
			int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
			model.addAttribute("page",page);
			int totalCnt = bbtService.totalListCount(paramMap);
			model.addAttribute("totalCnt",totalCnt);
			PagingUtil pageInfo = new PagingUtil(totalCnt, page);
			paramMap.put("startPageNum", pageInfo.getStartPageNum());
			paramMap.put("endPageNum", pageInfo.getEndPageNum());
			List<?> cateList = bbtService.cateList(paramMap);
			model.addAttribute("cateList",cateList);
			List<?> noticeList = bbtService.bbtList(paramMap);
			model.addAttribute("noticeList",noticeList);
			model.addAttribute("pageTag", pageInfo.getPagesStrTag());
			model.addAttribute("pageInfo",pageInfo);
			if(paramMap.size()==7){
				model.addAttribute("boardCateSeq",paramMap.get("BOARD_CATE_SEQ"));
			}
//			CommonUtil.isMobile(request);
			return conUrl + "bbt00001";

	}

	/**
	 * 고객센터 : 공지사항 상세조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00001V.do")
	public String bbt00001V(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00001");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		model.addAttribute("boardMstCd",CommonUtil.nvl(commandMap.get("pageCd")));
		if(bbtService.bbtAccessStatus(bbtAccessStatusMap) != 0){
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			
			int cnt = bbtService.bbtHitCnt(paramMap);
			String[] whereColumName = null;
			whereColumName = new String[]{"BOARD_SEQ"};
			
			UnCamelMap<String, Object> upMap = new UnCamelMap<>();
			upMap.put("BOARD_SEQ", paramMap.get("BOARD_SEQ"));
			upMap.put("BOARD_HIT", cnt);
			commService.tableSaveData("ASW_BOARD_BASE", upMap, null, whereColumName , null, null);
			
			Map<String, Object> noticeView = bbtService.bbt00001V(paramMap);
			model.addAttribute("noticeView",noticeView);
			model.addAttribute("page",paramMap.getString("PAGE"));
			model.addAttribute("pageCd", paramMap.getString("BOARD_MST_CD"));
			model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));

			return conUrl + "bbt00001V";
		}else{
			return  messageRedirect("", MAIN_PAGE, model);
		}
	}

	/**
	 * 고객센터 : 고객상담 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00002.do")
	public String bbt00002(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00002");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		if(bbtService.bbtAccessStatus(bbtAccessStatusMap) != 0){
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			String boardTpCd = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
			paramMap.put("BOARD_MST_CD", boardTpCd);
			model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
			model.addAttribute("mbrId",EgovUserDetailsHelper.getMbrId());
			String menuNm = bbtService.mstCdMenuNm(paramMap.getString("BOARD_MST_CD"));
			model.addAttribute("boardMstNm", menuNm);
			List<?> cateList = bbtService.cateList(paramMap);
			model.addAttribute("cateList",cateList);
			if(cateList.size()>1){
				int allCnt = bbtService.allListCount(paramMap);
				model.addAttribute("allCnt",allCnt);
				model.addAttribute("boardCateSeq",paramMap.get("BOARD_CATE_SEQ"));
			}
			int totalCnt = bbtService.bbt2MCount(paramMap);
			int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
			PagingUtil pageInfo = new PagingUtil(totalCnt, page);
			paramMap.put("startPageNum", pageInfo.getStartPageNum());
			paramMap.put("endPageNum", pageInfo.getEndPageNum());
//			List<?> mList = bbtService.bbt2MList(paramMap);
//			model.addAttribute("mList",mList);
			model.addAttribute("pageInfo",pageInfo);
			model.addAttribute("sval",paramMap.getString("SVAL"));

			model.addAttribute("pageTag", pageInfo.getPagesStrTag());

			return conUrl + "bbt00002";
		}else{
			return  messageRedirect("", MAIN_PAGE, model);
		}
	}

	/**
	 * 고객센터 : 생생고객후기
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00003.do")
	public String bbt00003(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00003");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		if(bbtService.bbtAccessStatus(bbtAccessStatusMap) != 0){
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			String boardTpCd = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
			paramMap.put("BOARD_MST_CD", boardTpCd);
			model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
			model.addAttribute("mbrId",EgovUserDetailsHelper.getMbrId());
			String menuNm = bbtService.mstCdMenuNm(paramMap.getString("BOARD_MST_CD"));
			model.addAttribute("boardMstNm", menuNm);
			List<?> cateList = bbtService.cateList(paramMap);
			model.addAttribute("cateList",cateList);
			if(cateList.size()>1){
				int allCnt = bbtService.allListCount(paramMap);
				model.addAttribute("allCnt",allCnt);
				model.addAttribute("boardCateSeq",paramMap.get("BOARD_CATE_SEQ"));
			}
			int totalCnt = bbtService.bbt2MCount(paramMap);
			int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
			PagingUtil pageInfo = new PagingUtil(totalCnt, page);
			paramMap.put("startPageNum", pageInfo.getStartPageNum());
			paramMap.put("endPageNum", pageInfo.getEndPageNum());
			List<?> mList = bbtService.bbt2MList(paramMap);
			model.addAttribute("mList",mList);
			model.addAttribute("pageInfo",pageInfo);
			model.addAttribute("sval",paramMap.getString("SVAL"));

			model.addAttribute("pageTag", pageInfo.getPagesStrTag());

			return conUrl + "bbt00003";
		}else{
			return  messageRedirect("", MAIN_PAGE, model);
		}
	}

	/**
	 * 고객센터 : 등록.수정.상세보기 아이디체크
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00002R.do")
	public String bbt00002R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00002");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		if(bbtService.bbtAccessStatus(bbtAccessStatusMap) != 0){
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			paramMap.put("BOARD_MST_CD", paramMap.getString("PAGE_CD"));
			model.addAttribute("boardMstCd",paramMap.getString("PAGE_CD"));
			model.addAttribute("mbrId",EgovUserDetailsHelper.getMbrId());
			List<?> cateList = bbtService.cateList(paramMap);
			model.addAttribute("cateList",cateList);
			String menuNm = bbtService.mstCdMenuNm(paramMap.getString("BOARD_MST_CD"));
			model.addAttribute("boardMstNm", menuNm);

			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);

			if(paramMap.size()==4){
				if(!paramMap.getString("BOARD_SEQ").isEmpty()){
					Map<String, Object> bbt2View = bbtService.bbt2View(paramMap);
					model.addAttribute("bbt2View",bbt2View);
					paramMap.put("OPEN_YN", bbt2View.get("openYn"));
					paramMap.put("REG_ID", bbt2View.get("regId"));
					paramMap.put("BOARD_STATE", bbt2View.get("boardState"));
					if(paramMap.getString("OPEN_YN").equals("N")){
						if(EgovUserDetailsHelper.getMbrId().equals(paramMap.getString("REG_ID"))){
		                    if(paramMap.getString("BOARD_STATE").equals("대기")){
		                    	// 비공개 : 아이디 같을 때 : 답변대기 - 수정가능
		                    	return conUrl + "bbt00002R";
		                    }else{
		                    	// 비공개 : 아이디 같을 때 : 답변완료 - 상세보기
		    					return conUrl + "bbt00002V";
		                    }
						}else{
							// 비공개 : 아이디 다를 때
							return messageRedirect(egovMessageSource.getMessage("본인이 작성한 글만 열람 할 수 있습니다."), conUrl + "bbt00002.do?pageCd="+paramMap.getString("BOARD_MST_CD"), model);
						}
					}else{
						if(EgovUserDetailsHelper.getMbrId().equals(paramMap.getString("REG_ID"))){
							if(paramMap.getString("BOARD_STATE").equals("대기")){
								// 공개 : 아이디 같을 때 : 대기 - 수정가능
		                    	return conUrl + "bbt00002R";
		                    }
		                    else{
		                    	// 공개 : 아이디 같을 때 : 완료 - 상세보기
		    					return conUrl + "bbt00002V";
		                    }
						}else{
							// 공개 : 아이디 다를 때 - 상세보기
							return conUrl + "bbt00002V";
						}
					}
				}else{
					// 로그인 상태 체크 후
					return conUrl + "bbt00002R";
				}
			}
			else{
			return conUrl + "bbt00002R";
			}
		}else{
			return  messageRedirect("", MAIN_PAGE, model);
		}
	}

	/**
	 * 고객센터 : 등록.수정 처리
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00002Save.action")
	public String bbt00002Save(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00002");
		//bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		//bbtAccessStatusMap.put("BOARD_MST_CD", paramMap.getString("BOARD_MST_CD"));
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("boardMstCd")));
		if(bbtService.bbtAccessStatus(bbtAccessStatusMap) != 0){
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			paramMap.put("BOARD_FIRST_YN", "N");
			paramMap.put("BOARD_STATUS_YN", "Y");
			paramMap.put("DATA_USER_TP_MA", "M");
			paramMap.put("BOARD_HIT", 0);
			paramMap.put("REG_IP", request.getRemoteAddr());
			paramMap.put("REG_AGENT", request.getHeader("User-Agent"));
			if(paramMap.getString("BOARD_SEQ").equals("")){
				paramMap.put("BOARD_SEQ", CommonUtil.nvl(getPrSeq("BOARD_SEQ")));
			}else{
				commService.setGdataModHis("ASW_BOARD_BASE", paramMap.getString("BOARD_SEQ"), paramMap, UPDATE);
			}
			String[] whereColumName = new String[]{"BOARD_SEQ"};
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			if(EgovUserDetailsHelper.getAuthenticatedUser() != null) matchingColumName.put("REG_ID", "$iui");
			matchingColumName.put("REG_DT", "$idate");
			commService.tableSaveData("ASW_BOARD_BASE", paramMap, matchingColumName, whereColumName , null, null);
			commService.tableSaveData("ASW_BOARD_TP_REPLY", paramMap, null, whereColumName , null, null);
			return messageRedirect(egovMessageSource.getMessage("success.common.insert"), conUrl + "bbt00002.do?pageCd="+paramMap.getString("BOARD_MST_CD") + "&page=" + paramMap.getString("PAGE"), model);
		}else{
			return  messageRedirect("", MAIN_PAGE, model);
		}
	}

	/**
	 * 고객센터 : 삭제 처리
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00002Del.action")
	public String myadviceDel(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("BOARD_STATUS_YN", "N");
		try{
			commService.tableUpdate("ASW_BOARD_BASE", paramMap, null, null, "AND BOARD_SEQ = '"+paramMap.getString("BOARD_SEQ")+"' and REG_ID ='"+EgovUserDetailsHelper.getMbrId()+"'", null);
			commService.setGdataModHis("ASW_BOARD_BASE", "BOARD_SEQ : "+paramMap.getString("BOARD_SEQ"), paramMap, DELETE);
		}catch(Exception e){
			model.addAttribute("outData", "ng");
		}
		return messageRedirect(egovMessageSource.getMessage("success.common.delete"), conUrl + "bbt00002.do?pageCd="+paramMap.getString("BOARD_MST_CD") + "&page=" + paramMap.getString("PAGE"), model);
	}

	@RequestMapping(value = "bbt00004.do")
	public String bbt00004(@RequestParam Map<String, Object> commandMap, ModelMap model,HttpServletRequest request) throws Exception {
		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00004");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		if(bbtService.bbtAccessStatus(bbtAccessStatusMap) != 0){
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);

			paramMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		List<?> cateList = bbtService.cateList(paramMap);
		model.addAttribute("cateList",cateList);


		if(paramMap.getString("BOARD_CATE_NM").equals("")){
			paramMap.put("BOARD_CATE_NM", "비데");
		}

		String boardTpCd = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
		paramMap.put("BOARD_MST_CD", boardTpCd);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		int allCnt = bbtService.allListCount(paramMap);
		model.addAttribute("allCnt",allCnt);
		int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
		int totalCnt = bbtService.totalListCount(paramMap);
		model.addAttribute("totalCnt",totalCnt);
		PagingUtil pageInfo = new PagingUtil(totalCnt, page);
		paramMap.put("startPageNum", pageInfo.getStartPageNum());
		paramMap.put("endPageNum", pageInfo.getEndPageNum());



		List<?> faqList = bbtService.bbtList(paramMap);
		model.addAttribute("faqList",faqList);
		model.addAttribute("boardCateNm",paramMap.getString("BOARD_CATE_NM"));
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("pageTag", pageInfo.getPagesStrTag());
		if(paramMap.size()==9){
			model.addAttribute("boardCateSeq",paramMap.get("BOARD_CATE_SEQ"));
		}
		String uri="";
		if(CommonUtil.isMobile(request)){
			uri = "bbt00004_m";
		}else{
			uri = "bbt00004";
		}

		return conUrl + uri;
		}else{
			return  messageRedirect("", MAIN_PAGE, model);
		}
	}


	/**
	 * FAQ형 상세조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00004V.do")
	public String bbt00004V(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			int cnt = bbtService.bbtHitCnt(paramMap);
			String[] whereColumName = null;
			whereColumName = new String[]{"BOARD_SEQ"};
			UnCamelMap<String, Object> upMap = new UnCamelMap<>();
			upMap.put("BOARD_SEQ", paramMap.get("BOARD_SEQ"));
			upMap.put("BOARD_HIT", cnt);
			commService.tableSaveData("ASW_BOARD_BASE", upMap, null, whereColumName , null, null);
			Map<String, Object> noticeView = bbtService.bbt00001V(paramMap);
			model.addAttribute("noticeView",noticeView);
//			Map<String, Object> preView = bbtService.bbt00001PV(paramMap);
//			Map<String, Object> nextView = bbtService.bbt00001NV(paramMap);
//			model.addAttribute("preView",preView);
//			model.addAttribute("nextView",nextView);

			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
			model.addAttribute("boardCateNm", paramMap.get("BOARD_CATE_NM"));


			return conUrl + "bbt00004V";
	}



	@RequestMapping(value = "bbt00005.do")
	public String bbt00005(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00005");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		if(bbtService.bbtAccessStatus(bbtAccessStatusMap) != 0){
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			String boardTpCd = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
			paramMap.put("BOARD_MST_CD", boardTpCd);
			List<?> cateList = bbtService.cateList(paramMap);
			model.addAttribute("cateList",cateList);
			int duoNewCount = bbtService.duoNewCount(paramMap);
			int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
			PagingUtil pageInfo = new PagingUtil(duoNewCount, page);
			pageInfo.setPageSize(9);
			paramMap.put("startPageNum", pageInfo.getStartPageNum());
			paramMap.put("endPageNum", pageInfo.getEndPageNum());
			List<?> duoNewList = bbtService.duoNewList(paramMap);
			model.addAttribute("duoNewList",duoNewList);
			model.addAttribute("pageTag", pageInfo.getPagesStrTag());
			model.addAttribute("pageInfo",pageInfo);
			model.addAttribute("boardCateSeq",paramMap.getString("BOARD_CATE_SEQ"));
			model.addAttribute("cateStatus",paramMap.get("CATE_STATUS"));
			return conUrl + "bbt00005";
		}else{
			return  messageRedirect("", MAIN_PAGE, model);
		}
	}

	/**
	 * 부품구매
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00007.do")
	public String bbt00007(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00011");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		if( bbtService.bbtAccessStatus(bbtAccessStatusMap)  != 0){
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			String boardTpCd = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
			paramMap.put("BOARD_MST_CD", boardTpCd);
			model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
			int allCnt = bbtService.allListCount(paramMap);
			model.addAttribute("allCnt",allCnt);
			int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
			int totalCnt = bbtService.totalListCount(paramMap);
			model.addAttribute("totalCnt",totalCnt);
			PagingUtil pageInfo = new PagingUtil(totalCnt, page);
			paramMap.put("startPageNum", pageInfo.getStartPageNum());
			paramMap.put("endPageNum", pageInfo.getEndPageNum());
			List<?> cateList = bbtService.cateList(paramMap);
			model.addAttribute("cateList",cateList);
			List<?> prodList = bbtService.bbt7List(paramMap);
			model.addAttribute("prodList",prodList);
			model.addAttribute("pageTag", pageInfo.getPagesStrTag());
			model.addAttribute("pageInfo",pageInfo);
			if(paramMap.size()==7){
				model.addAttribute("boardCateSeq",paramMap.get("BOARD_CATE_SEQ"));
			}
			return conUrl + "bbt00007";
		}else{
			return  messageRedirect("", MAIN_PAGE, model);
		}
	}

	@RequestMapping(value = "bbt00008.do")
	public String bbt00008(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00008");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
//		if(bbtService.bbtAccessStatus(bbtAccessStatusMap) != 0){
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);


			paramMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		List<?> cateList = bbtService.cateList(paramMap);
		model.addAttribute("cateList",cateList);

		if(paramMap.getString("BOARD_CATE_NM").equals("")){
			paramMap.put("BOARD_CATE_NM", "비데");
		}

		String boardTpCd = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
		paramMap.put("BOARD_MST_CD", boardTpCd);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		int allCnt = bbtService.allListCount(paramMap);
		model.addAttribute("allCnt",allCnt);
		int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
		int totalCnt = bbtService.totalListCount(paramMap);
		model.addAttribute("totalCnt",totalCnt);
		PagingUtil pageInfo = new PagingUtil(totalCnt, page);
		paramMap.put("startPageNum", pageInfo.getStartPageNum());
		paramMap.put("endPageNum", pageInfo.getEndPageNum());

		List<?> bbt8List = bbtService.bbt8List(paramMap);
		model.addAttribute("boardCateNm",paramMap.getString("BOARD_CATE_NM"));
		model.addAttribute("bbt8List",bbt8List);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("pageTag", pageInfo.getPagesStrTag());
		if(paramMap.size()==9){
			model.addAttribute("boardCateSeq",paramMap.get("BOARD_CATE_SEQ"));
		}
		return conUrl + "bbt00008";
//		}else{
//			return  messageRedirect("", MAIN_PAGE, model);
//		}
	}


	/**
	 * FAQ형 상세조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00008V.do")
	public String bbt00008V(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		model.addAttribute("boardMstCd",CommonUtil.nvl(commandMap.get("pageCd")));
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			int cnt = bbtService.bbtHitCnt(paramMap);
			String[] whereColumName = null;
			whereColumName = new String[]{"BOARD_SEQ"};
			UnCamelMap<String, Object> upMap = new UnCamelMap<>();
			upMap.put("BOARD_SEQ", paramMap.get("BOARD_SEQ"));
			upMap.put("BOARD_HIT", cnt);
			commService.tableSaveData("ASW_BOARD_BASE", upMap, null, whereColumName , null, null);
			Map<String, Object> noticeView = bbtService.bbt00001V(paramMap);
			model.addAttribute("noticeView",noticeView);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
			Map<String, Object> tpMov = bbtService.bbt00008TP(paramMap);
			model.addAttribute("tpMov", tpMov);


			model.addAttribute("boardCateNm", paramMap.get("BOARD_CATE_NM"));

			return conUrl + "bbt00008V";

	}

	@RequestMapping(value = "bbt00009.do")
	public String bbt00009(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00009");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
//		if(bbtService.bbtAccessStatus(bbtAccessStatusMap) != 0){
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);


			paramMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
			List<?> cateList = bbtService.cateList(paramMap);
			model.addAttribute("cateList",cateList);
			if(paramMap.getString("BOARD_CATE_NM").equals("")){
				paramMap.put("BOARD_CATE_NM", "비데");
			}


		String boardTpCd = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
		paramMap.put("BOARD_MST_CD", boardTpCd);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		int allCnt = bbtService.allListCount(paramMap);
		model.addAttribute("allCnt",allCnt);
		int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
		int totalCnt = bbtService.totalListCount(paramMap);
		model.addAttribute("totalCnt",totalCnt);
		PagingUtil pageInfo = new PagingUtil(totalCnt, page);
		paramMap.put("startPageNum", pageInfo.getStartPageNum());
		paramMap.put("endPageNum", pageInfo.getEndPageNum());

		List<?> bbt9List = bbtService.bbt9List(paramMap);
		model.addAttribute("boardCateNm",paramMap.getString("BOARD_CATE_NM"));
		model.addAttribute("bbt9List",bbt9List);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("pageTag", pageInfo.getPagesStrTag());
		if(paramMap.size()==9){
			model.addAttribute("boardCateSeq",paramMap.get("BOARD_CATE_SEQ"));
		}
		return conUrl + "bbt00009";
//		}else{
//			return  messageRedirect("", MAIN_PAGE, model);
//		}
	}


	/**
	 * 고객의소리 - 칭찬합시다
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00010.do")
	public String bbt00010(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {

		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00018");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		if( bbtService.bbtAccessStatus(bbtAccessStatusMap)  != 0){
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			String boardTpCd = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
			paramMap.put("BOARD_MST_CD", boardTpCd);
			model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));

			int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
			int totalCnt = bbtService.totalListCount(paramMap);
			model.addAttribute("totalCnt",totalCnt);
			List<?> cateList = bbtService.cateList(paramMap);
			model.addAttribute("cateList",cateList);
			if(cateList.size()>1){
				int allCnt = bbtService.allListCount(paramMap);
				model.addAttribute("allCnt",allCnt);
				model.addAttribute("boardCateSeq",paramMap.get("BOARD_CATE_SEQ"));
			}


			PagingUtil pageInfo = new PagingUtil(totalCnt, page);
			paramMap.put("startPageNum", pageInfo.getStartPageNum());
			paramMap.put("endPageNum", pageInfo.getEndPageNum());
			List<?> noticeList = bbtService.bbt10List(paramMap);
			model.addAttribute("noticeList",noticeList);
			model.addAttribute("pageTag", pageInfo.getPagesStrTag());
			model.addAttribute("pageInfo",pageInfo);
//			if(paramMap.size()==7){
				model.addAttribute("boardCateSeq",paramMap.get("BOARD_CATE_SEQ"));
//			}
			return conUrl + "bbt00010";
		}else{
			return  messageRedirect("", MAIN_PAGE, model);
		}
	}

	/**
	 * 고객센터 : 고객의소리 - 칭찬합시다 상세조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00010V.do")
	public String bbt00010V(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> bbtAccessStatusMap = new UnCamelMap<>();
		//bbtAccessStatusMap.put("BOARD_TP_CD", "BBT00010");
		bbtAccessStatusMap.put("BOARD_MST_CD", CommonUtil.nvl(commandMap.get("pageCd")));
		model.addAttribute("boardMstCd",CommonUtil.nvl(commandMap.get("pageCd")));
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			int cnt = bbtService.bbtHitCnt(paramMap);
			String[] whereColumName = null;
			whereColumName = new String[]{"BOARD_SEQ"};
			UnCamelMap<String, Object> upMap = new UnCamelMap<>();
			upMap.put("BOARD_SEQ", paramMap.get("BOARD_SEQ"));
			upMap.put("BOARD_HIT", cnt);
			commService.tableSaveData("ASW_BOARD_BASE", upMap, null, whereColumName , null, null);
			Map<String, Object> noticeView = bbtService.bbt00010V(paramMap);
			model.addAttribute("noticeView",noticeView);

			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);

			return conUrl + "bbt00010V";

	}

	/**
	 * 고객의소리 : 칭찬합시다 상세조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00010R.do")
	public String bbt00010R(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(commandMap,model);

			model.addAttribute("boardMstCd",CommonUtil.nvl(commandMap.get("pageCd")));

		if(!paramMap.getString("BOARD_SEQ").equals("")){

			int cnt = bbtService.bbtHitCnt(paramMap);
			String[] whereColumName = null;
			whereColumName = new String[]{"BOARD_SEQ"};
			UnCamelMap<String, Object> upMap = new UnCamelMap<>();
			upMap.put("BOARD_SEQ", paramMap.get("BOARD_SEQ"));
			upMap.put("BOARD_HIT", cnt);
			commService.tableSaveData("ASW_BOARD_BASE", upMap, null, whereColumName , null, null);
			Map<String, Object> noticeView = bbtService.bbt00010V(paramMap);
			model.addAttribute("noticeView",noticeView);

			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);

		}
			return conUrl + "bbt00010R";

	}




	/**
	 * 고객의소리 : 칭찬합시다 삭제
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00010Del.action")
	public String bbt00010Del(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("BOARD_STATUS_YN", "N");
		try{
			commService.tableUpdate("ASW_BOARD_BASE", paramMap, null, null, "AND BOARD_SEQ = '"+paramMap.getString("BOARD_SEQ")+"' and REG_ID ='"+EgovUserDetailsHelper.getMbrId()+"'", null);
			commService.setGdataModHis("ASW_BOARD_BASE", "BOARD_SEQ : "+paramMap.getString("BOARD_SEQ"), paramMap, DELETE);
		}catch(Exception e){
			logger.error(e.toString());
			return messageRedirect(egovMessageSource.getMessage("fail.common.save"), ROOT_URI +"main"+ "home.do", model);
		}
		return messageRedirect(egovMessageSource.getMessage("success.common.delete"), conUrl + "bbt00010.do?pageCd="+paramMap.getString("BOARD_MST_CD") + "&page=" + paramMap.getString("PAGE"), model);
	}


	/**
	 * 고객의소리 : 칭찬합시다 등록.수정 처리
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "bbt00010Save.action")
	public String bbt00010Save(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			paramMap.put("DATA_USER_TP_MA", "M");
			paramMap.put("REG_IP", request.getRemoteAddr());
			paramMap.put("REG_AGENT", request.getHeader("User-Agent"));
			paramMap.put("BOARD_FIRST_YN", "N");
			paramMap.put("BOARD_STATUS_YN", "Y");
			if(paramMap.getString("BOARD_SEQ").equals("")){
				paramMap.put("BOARD_SEQ", CommonUtil.nvl(getPrSeq("BOARD_SEQ")));
			}else{
				commService.setGdataModHis("ASW_BOARD_BASE", paramMap.getString("BOARD_SEQ"), paramMap, UPDATE);
			}
			String[] whereColumName = new String[]{"BOARD_SEQ"};
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			if(EgovUserDetailsHelper.getAuthenticatedUser() != null) matchingColumName.put("REG_ID", "$iui");
			matchingColumName.put("REG_DT", "$idate");
			commService.tableSaveData("ASW_BOARD_BASE", paramMap, matchingColumName, whereColumName , null, null);
			commService.tableSaveData("ASW_BOARD_TP_RECOM", paramMap, null, whereColumName , null, null);


			Map<String, String> dataMap = new CamelMap<>();
			dataMap.put("BOARD_SEQ", (String) paramMap.get("BOARD_SEQ"));
			model.addAttribute("dataMap", CommonUtil.mapToJsonString(dataMap));

			String pageParam = "";
			if(!paramMap.getString("PAGE").equals("")){
				pageParam = "&page=" + paramMap.getString("PAGE");
			}

			return messageRedirect(egovMessageSource.getMessage("success.common.insert"), conUrl + "bbt00010V.do?pageCd="+paramMap.getString("BOARD_MST_CD") + pageParam, model);

	}

	@RequestMapping(value = "editBox.action")
	public String cbtsIaAm1002(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("BOARD_MST_CD", "BBM00002");
		Map<String, Object> viewMap = bbtService.duoNewView(paramMap);
		model.addAttribute("viewMap", viewMap);
		return conUrl + "editBox";
	}

	@RequestMapping(value = "hitUpdate.action")
	public String hitUpdate(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		try{
			int cnt = bbtService.bbtHitCnt(paramMap);
			String[] whereColumName = null;
			whereColumName = new String[]{"BOARD_SEQ"};
			paramMap.put("BOARD_HIT", cnt);
			commService.tableSaveData("ASW_BOARD_BASE", paramMap, null, whereColumName , null, null);
			model.addAttribute("outData", cnt);
		}catch(Exception e){
			model.addAttribute("outData", "ng");
		}
		return "common/out";
	}


	/**
	 * 파일 다운 로드
	 * file downLoad
	 * @param request
	 * @param response
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "fileDownLoad.action")
	public String fileDownLoad(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(commandMap);
		try {
			@SuppressWarnings("unchecked")
			CamelMap<String, Object> attchMap = (CamelMap<String, Object>) commService.getGAttch(paramMap);
			FileDownLoad fileDownLoad = new FileDownLoad(request, response);
			fileDownLoad.runFileDownLoad(attchMap);
			return null;
		} catch (FileNotFoundException e) {
			logger.error("FileNotFoundException", e);
			setMessage("alert.message", "파일이 시스템에 존재하지 않습니다. 관리자에게 연락하여 주시면 감사하겠습니다.", "back", "true", model);
		} catch (DEXTUploadException e) {
			logger.error("DEXTUploadException", e);
			setMessage("alert.message", "파일이 존재하지 않습니다. 관리자에게 연락하여 주시면 감사하겠습니다.", "back", "true", model);
		} catch (IOException e) {
			logger.error("IOException", e);
			setMessage("alert.message", "파일이 시스템에 존재하지 않습니다. 관리자에게 연락하여 주시면 감사하겠습니다.", "back", "true", model);
		}catch (Exception e) {
			logger.error("Exception", e);
			setMessage("alert.message", "시스템에 에러 입니다. 관리자에게 연락하여 주시면 감사하겠습니다.", "back", "true", model);
		}
		return "common/messageRedirect";
	}
}
