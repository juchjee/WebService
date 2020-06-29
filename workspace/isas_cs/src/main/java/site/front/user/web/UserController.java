package site.front.user.web;

import java.util.ArrayList;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import egovframework.cmmn.DomXmlHelper;
import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.EgovFileScrty;
import egovframework.cmmn.util.FileUpLoad;
import egovframework.cmmn.util.PagingUtil;
import egovframework.cmmn.vo.LoginVO;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.front.bbt.service.impl.BbtService;
import site.front.mm.service.impl.MmService;
import site.front.user.service.impl.UserService;


/**
 * @author taehoon_kil
 *
 */
@Controller
@RequestMapping(value = IConstants.ISDS_URL + "user")
public class UserController extends BaseController{

	private static final String conUrl = ISDS_URL + "user/";

	/** UserService */
	@Resource(name = "UserService")
	private UserService userService;

	@Resource(name = "BbtService")
	private BbtService bbtService;

	/** MmService */
	@Resource(name = "MmService")
	private MmService mmService;

	@RequestMapping(value = "MYP.do")
	public String cbtsIaAm1001(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		String url = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));
		return conUrl + url;
	}

	@RequestMapping(value = "mypage.do")
	public String mypage(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
		model.addAttribute("userMap", userService.mypageUser(paramMap));
		model.addAttribute("cntMap", userService.mypageOrderCnt(paramMap));
		List<Map<String, Object>> orderList = userService.mypageOrder(paramMap);
		if(orderList.size() != 0){
			for(Map<String, Object> orderProd : orderList){
				if(CommonUtil.nvl(orderProd.get("claimTpCd")).equals("OCT00006")
						|| CommonUtil.nvl(orderProd.get("claimTpCd")).equals("OCT00007")
						|| CommonUtil.nvl(orderProd.get("claimTpCd")).equals("OCT00008")
						|| CommonUtil.nvl(orderProd.get("claimTpCd")).equals("OCT00009")
						|| CommonUtil.nvl(orderProd.get("claimTpCd")).equals("OCT00010")){
						orderProd.put("PROD_INFO_LIST", userService.claimInfoList(CommonUtil.nvl(orderProd.get("orderNo")))); //클레임 완료시 O_ORDER_PROD_RETURN 테이블참조

					}else{
						orderProd.put("PROD_INFO_LIST", userService.prodInfoList(CommonUtil.nvl(orderProd.get("orderNo"))));
					}
			}
		}
		model.addAttribute("orderList", orderList);
		List<?> list = userService.mypageAdvice(paramMap);
		model.addAttribute("adviceList", list);
		model.addAttribute("afterMap", userService.mypageAfter(paramMap));
		return conUrl + "mypage";
	}

	@RequestMapping(value = "orderCancel.action")
	public String orderCancel(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		return conUrl + "orderCancel";
	}

	@RequestMapping(value = "orderAddr.action")
	public String orderAddr(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("orderInfo",  userService.orderAddr(paramMap.getString("ORDER_NO")));
		return conUrl + "orderAddr";
	}


	@RequestMapping(value = "orderAddtProc.action")
	public String orderAddtProc(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		String returnMsg = "";
			boolean testProc  = false;
			testProc = userService.addrSave(paramMap);

			if(testProc){
				returnMsg = "정상적으로 변경되었습니다.";
				return messageAction(returnMsg, "parent.$.fancybox.close();", model);
			}else{
				returnMsg = "이미 배송중은 상품입니다. \n변경을 요청시 고객센타(080-668-6108)로 \n연락 부탁드립니다.";
				return messageAction(returnMsg, "parent.$.fancybox.close(); parent.location.reload(true);", model);
			}

	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "order.do")
	public String order(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
		String nowYmd = CommonUtil.getNumberByPattern("yyyy-MM-dd");
		String[] nowArr = nowYmd.split("-");
		String now = nowArr[0]+nowArr[1]+nowArr[2];
		int monthNo = 0;
		String termDate = "";

		if(paramMap.getString("M_TYPE").equals("N")){
			model.addAttribute("sDate", paramMap.getString("S_DATE"));
			model.addAttribute("eDate", paramMap.getString("E_DATE"));
		}else{
			monthNo = -1;
			termDate = CommonUtil.toOcsDateFormat(CommonUtil.getDateAddMonth(now, monthNo));
			model.addAttribute("sDate", termDate);
			model.addAttribute("eDate", nowYmd);
		}

		List<Map<String, Object>> list = userService.mypageOrder(paramMap);
		if(list.size() != 0){
			for(Map<String, Object> orderProd : list){
				if(CommonUtil.nvl(orderProd.get("claimTpCd")).equals("OCT00006")
						|| CommonUtil.nvl(orderProd.get("claimTpCd")).equals("OCT00007")
						|| CommonUtil.nvl(orderProd.get("claimTpCd")).equals("OCT00008")
						|| CommonUtil.nvl(orderProd.get("claimTpCd")).equals("OCT00009")
						|| CommonUtil.nvl(orderProd.get("claimTpCd")).equals("OCT00010")){
						orderProd.put("PROD_INFO_LIST", userService.claimInfoList(CommonUtil.nvl(orderProd.get("orderNo")))); //클레임 완료시 O_ORDER_PROD_RETURN 테이블참조
					}else{
						orderProd.put("PROD_INFO_LIST", userService.prodInfoList(CommonUtil.nvl(orderProd.get("orderNo"))));
					}
			}
		}
		Map<String, Object> xmlMap = new HashMap<>();
		if(CommonUtil.getSize(list) > 0){//배송 조회를 위한 로직
			 for (Map<String, Object> map : list) {
				String regiNo = CommonUtil.nvl(map.get("regiNo"));
				if(!"".equals(regiNo)){
					try {
						xmlMap.put("QUERY", regiNo);
						DomXmlHelper domXmlHelper = new DomXmlHelper(commService);
						domXmlHelper.contXmlHelper(1, xmlMap);
						domXmlHelper.getObjct();
						Map<String, Object>  tempMap = (Map<String, Object>) xmlMap.get("recvMapObj");
						tempMap = (Map<String, Object>) tempMap.get("trace");
						if(tempMap != null){
							tempMap = (Map<String, Object>) tempMap.get("itemlist");
							Object items = tempMap.get("item");
							if(items != null){
								if(items instanceof Map){
									List<Map<String, Object>> mapList = new ArrayList<>();
									mapList.add((Map<String, Object>) items);
									model.addAttribute("traceList", mapList);
								}else{
									model.addAttribute("traceList", items);
								}
								break;
							}
						}
					} catch (Exception e) {
						logger.error(e.getMessage());
					}
				}
			}
		}
		model.addAttribute("orderList", list);
		model.addAttribute("nowYmd", nowYmd);
		model.addAttribute("termMode", paramMap.getString("TERM_MODE"));
		model.addAttribute("mType", paramMap.getString("M_TYPE"));

		GregorianCalendar today = new GregorianCalendar ( );
		int year = today.get ( GregorianCalendar.YEAR );
		paramMap.put("YEAR", year);

		model.addAttribute("year", year);
		model.addAttribute("totalAmt", userService.getOrderTotalAmt(paramMap));

		return conUrl + "order";
	}

	@RequestMapping(value = "wishList.do")
	public String wishlist(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
		List<?> list = userService.mypageWishList(paramMap);
		model.addAttribute("wishList", list);
		return conUrl + "wishlist";
	}

	@RequestMapping(value = "wishListDel.action")
	public String wishDelAction(@RequestParam MultiValueMap<String, Object> multiValueMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(multiValueMap);
		String[] prodArr = paramMap.getArray("PROD_CD");
		UnCamelMap<String, Object> prodMap = new UnCamelMap<>();
		for(String prodArrMpg : prodArr){
			prodMap.put("PROD_CD", prodArrMpg);
			prodMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
			commService.tableDelete("O_WISHLIST", null, "and PROD_CD ='"+prodMap.getString("PROD_CD")+"' and MBR_ID ='"+prodMap.getString("MBR_ID")+"'");
			commService.setGdataModHis("O_WISHLIST", prodMap.getString("PROD_CD"), paramMap, DELETE);
		}
		return messageRedirect(null, conUrl + "wishList.do", model);
	}

	@RequestMapping(value = "cash.do")
	public String cash(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		String nowYmd = CommonUtil.getNumberByPattern("yyyy-MM-dd");
		paramMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
		model.addAttribute("userMap", userService.mypageUser(paramMap));
		model.addAttribute("nowYmd", nowYmd);
		int totalAmt = userService.totalAmt(paramMap);
		model.addAttribute("totalAmt", totalAmt);
		return conUrl + "cash";
	}

	@RequestMapping(value = "point.do")
	public String point(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
		model.addAttribute("userMap", userService.mypageUser(paramMap));
		int totalCnt = userService.mypagePointCnt(paramMap);
		int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
		model.addAttribute("totalCnt",totalCnt);
		PagingUtil pageInfo = new PagingUtil(totalCnt, page);
		paramMap.put("startPageNum", pageInfo.getStartPageNum());
		paramMap.put("endPageNum", pageInfo.getEndPageNum());
		List<?> list = userService.mypagePoint(paramMap);
		model.addAttribute("pointList", list);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("pageTag", pageInfo.getPagesStrTag());
		return conUrl + "point";
	}

	@RequestMapping(value = "coupon.do")
	public String coupon(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		String nowYmd = CommonUtil.getNumberByPattern("yyyy-MM-dd");
		paramMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
		model.addAttribute("userMap", userService.mypageUser(paramMap));
		List<?> list = userService.mypageCoupon(paramMap);
		model.addAttribute("couponList", list);
		model.addAttribute("nowYmd", nowYmd);
		return conUrl + "coupon";
	}

	/**
	 * 마이페이지 : 나의문의내역 : 제품문의
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "product.do")
	public String product(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("REG_ID", EgovUserDetailsHelper.getMbrId());
		List<?> bbt2List = bbtService.mstTpBoard(paramMap);
		model.addAttribute("bbt2List",bbt2List);
		int qnaCnt = bbtService.bbt26Count(paramMap);
		int qnaPage = CommonUtil.nvl(paramMap.getString("QNA_PAGE"), 1);
		PagingUtil qnaPageInfo = new PagingUtil(qnaCnt, qnaPage);
		paramMap.put("qnaStartPageNum", qnaPageInfo.getStartPageNum());
		paramMap.put("qnaEndPageNum", qnaPageInfo.getEndPageNum());
		List<?> prodQnaList = bbtService.bbt26List(paramMap);
		model.addAttribute("prodQnaList", prodQnaList);
		model.addAttribute("qnaPageInfo",qnaPageInfo);
		return conUrl + "product";
	}

	/**
	 * 마이페이지 : 나의문의내역 : 고객상담 목록조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "myadvice.do")
	public String myadvice(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("REG_ID", EgovUserDetailsHelper.getMbrId());
		int totalCnt = bbtService.bbtMyCount(paramMap);
		int page = CommonUtil.nvl(paramMap.getString("PAGE"), 1);
		PagingUtil pageInfo = new PagingUtil(totalCnt, page);
		paramMap.put("startPageNum", pageInfo.getStartPageNum());
		paramMap.put("endPageNum", pageInfo.getEndPageNum());
		List<?> bbtNmList = bbtService.bbtNmList(paramMap);
		List<?> bbtMyList = bbtService.bbtMyList(paramMap);
		model.addAttribute("bbtNmList",bbtNmList);
		model.addAttribute("bbtMyList",bbtMyList);
		model.addAttribute("pageInfo",pageInfo);
		model.addAttribute("boardMstCd", paramMap.getString("BOARD_MST_CD"));
		model.addAttribute("pageTag", pageInfo.getPagesStrTag());
		return conUrl + "myadvice";
	}

	/**
	 * 마이페이지 : 나의문의내역 : 고객상담 등록화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "myadvice_write.do")
	public String myadvice_write(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("BOARD_MST_CD",paramMap.getString("PAGE_CD"));
		model.addAttribute("mbrId",EgovUserDetailsHelper.getMbrId());
		model.addAttribute("boardMstCd",paramMap.getString("BOARD_MST_CD"));
		List<?> cateList = bbtService.cateList(paramMap);
		model.addAttribute("cateList",cateList);
		if(paramMap.size()==3){
			Map<String, Object> bbt2View = bbtService.bbt2View(paramMap);
			model.addAttribute("bbt2View",bbt2View);
			paramMap.put("BOARD_STATE", bbt2View.get("boardState"));
			if(paramMap.getString("BOARD_STATE").equals("대기")){
            	return conUrl + "myadvice_write";
            }
            else{
				return conUrl + "myadvice_view";
            }
		}else{
			return conUrl + "myadvice_write";
		}
	}

	/**
	 * 마이페이지 : 나의문의내역 : 고객상담 저장 로직처리(등록 및 수정)
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "myadviceSave.action")
	public String myadviceSave(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		String regUpd = ""; // 포인트 적립을 위해 등록과 수정을 구분하기 위한 변수
		paramMap.put("BOARD_FIRST_YN", "N");
		paramMap.put("BOARD_STATUS_YN", "Y");
		paramMap.put("DATA_USER_TP_MA", "M");
		paramMap.put("BOARD_HIT", 0);
		paramMap.put("REG_IP", request.getRemoteAddr());
		paramMap.put("REG_AGENT", request.getHeader("User-Agent"));
		if(paramMap.getString("BOARD_SEQ").equals("")){
			paramMap.put("BOARD_SEQ", CommonUtil.nvl(getPrSeq("BOARD_SEQ")));
			regUpd = "reg";
		}else{
			commService.setGdataModHis("ASW_BOARD_BASE", paramMap.getString("BOARD_SEQ"), paramMap, UPDATE);
			regUpd = "upd";
		}
		String[] whereColumName = new String[]{"BOARD_SEQ"};
		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("REG_ID", "$iui");
		matchingColumName.put("REG_DT", "$idate");
		commService.tableSaveData("ASW_BOARD_BASE", paramMap, matchingColumName, whereColumName , null, null);
		commService.tableSaveData("ASW_BOARD_TP_REPLY", paramMap, null, whereColumName , null, null);
		if( "reg".equals(regUpd) ){ // 등록인 경우만 포인트 적립(수정X)
			Map<String, Object> params	= new HashMap<String, Object>();
			params.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
			params.put("PT_CD", "MPP00003");
			params.put("BOARD_SEQ", paramMap.get("BOARD_SEQ"));
			commService.stackPoints(params);
		}
		return messageRedirect(egovMessageSource.getMessage("success.common.insert"), conUrl + "myadvice.do", model);
	}



	/**
	 * 마이페이지 : 나의문의내역 : 고객상담 저장 로직처리(삭제)
	 * @param commandMap
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "myadviceDel.action")
	public String myadviceDel(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramBoardMap = init(commandMap);
		paramBoardMap.put("BOARD_STATUS_YN", "N");

		try{
			commService.tableUpdate("ASW_BOARD_BASE", paramBoardMap, null, null, "AND BOARD_SEQ = '"+paramBoardMap.getString("BOARD_SEQ")+"' and REG_ID ='"+EgovUserDetailsHelper.getMbrId()+"'", null);
			commService.setGdataModHis("ASW_BOARD_BASE", "BOARD_SEQ : "+paramBoardMap.getString("BOARD_SEQ"), paramBoardMap, DELETE);
		}catch(Exception e){
			model.addAttribute("outData", "ng");
		}

		return messageRedirect(egovMessageSource.getMessage("success.common.delete"), conUrl + "myadvice.do", model);
	}

	/**
	 * 마이페이지 : 나의제품후기 : 나의제품후기쓰기
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "review.do")
	public String review(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("BOARD_MST_CD", "BBM00005");
		paramMap.put("REG_ID", EgovUserDetailsHelper.getMbrId());
		int totalCnt = bbtService.payProdCount(paramMap);
		List<?> payProdList = bbtService.payProdList(paramMap);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("payProdList", payProdList);
		List<?> cateList = bbtService.cateList(paramMap);
		model.addAttribute("cateList",cateList);

		if(!paramMap.getString("BOARD_SEQ").equals("")){
			Map<String, Object> viewMap = bbtService.bbt00001V(paramMap);
			model.addAttribute("viewMap", viewMap);
			List<?> fileList = bbtService.bbt00001F(paramMap);
			model.addAttribute("fileList", fileList);
		}
		return conUrl + "review";
	}

	@RequestMapping(value = "reviewSave.action")
	public String reviewSave(@RequestParam Map<String, Object> commandMap, HttpServletResponse response, HttpServletRequest request, ModelMap model) throws Exception {
		FileUpLoad fileUpLoad = new FileUpLoad(request, response);
		String savePath = "reviewImg";
		String[] uploadName ={"dtlFilePath"};
		UnCamelMap<String, Object>  param = fileUpLoad.imgFileUpload(savePath,uploadName);
		String[] whereColumName = null;
		Map<String, Object> matchingColumName = new HashMap<String, Object>();

		String boardTitle = (String) param.getString("BOARD_TITLE");
		String boardCont = (String) param.getString("BOARD_CONT");
		String boardCateSeq = (String) param.getString("BOARD_CATE_SEQ");

		UnCamelMap<String, Object> paramMap = new UnCamelMap<>();
		if(param.getString("BOARD_SEQ").equals("")){
			paramMap.put("BOARD_SEQ", CommonUtil.nvl(commService.getPrSeq("BOARD_SEQ")));
		}else{
			paramMap.put("BOARD_SEQ", param.getString("BOARD_SEQ"));
		}
		paramMap.put("BOARD_TITLE", boardTitle);
		paramMap.put("BOARD_CONT", boardCont);
		paramMap.put("BOARD_CATE_SEQ", boardCateSeq);

		paramMap.put("BOARD_MST_CD", "BBM00005");
		paramMap.put("BOARD_FIRST_YN", "N");
		paramMap.put("BOARD_STATUS_YN", "Y");
		paramMap.put("DATA_USER_TP_MA", "M");
		paramMap.put("BOARD_HIT", 0);
		paramMap.put("REG_IP", request.getRemoteAddr());
		paramMap.put("REG_AGENT", request.getHeader("User-Agent"));
		whereColumName = new String[]{"BOARD_SEQ"};
		matchingColumName.put("REG_ID", "$iui");
		matchingColumName.put("REG_DT", "$idate");
		commService.tableSaveData("ASW_BOARD_BASE", paramMap, matchingColumName, whereColumName , null, null);
		commService.setGdataModHis("ASW_BOARD_BASE", paramMap.get("BOARD_SEQ"), paramMap, INSERT);

		matchingColumName.clear();

		if(!param.getString("PROD_CD").equals("")){
			UnCamelMap<String, Object> prodMap = new UnCamelMap<>();
			prodMap.put("BOARD_SEQ", paramMap.getString("BOARD_SEQ"));
			prodMap.put("PROD_CD", param.getString("PROD_CD"));
			prodMap.put("ORDER_NO", param.getString("ORDER_NO"));
			commService.tableSaveData("ASW_BOARD_TP_PROD", prodMap, null, whereColumName , null, null);
			commService.setGdataModHis("ASW_BOARD_TP_PROD", prodMap.get("BOARD_SEQ"), prodMap, UPDATE);
		}
		Map<String, Object> matchingColumName2 = new HashMap<String, Object>();
		matchingColumName2.put("REP_ID", "$iui");
		matchingColumName2.put("REP_DT", "$idate");
		paramMap.put("BOARD_REPLY", null);
		if(param.getString("PROD_GRADE").equals("")){
			paramMap.put("PROD_GRADE", "1");
		}else{
			paramMap.put("PROD_GRADE", param.getString("PROD_GRADE"));
		}
		commService.tableSaveData("ASW_BOARD_TP_REVIEW", paramMap, matchingColumName2, whereColumName , null, null);
		commService.setGdataModHis("ASW_BOARD_TP_REVIEW", paramMap.get("BOARD_SEQ"), paramMap, INSERT);

		if(param.getArray("DTL_FILE_PATH") != null){

			List<?> list = (List<?>) param.get("DTL_FILE_PATH_LIST");
			UnCamelMap<String, Object> fileMap = new UnCamelMap<>();
			UnCamelMap<String, Object> fileAttMap = new UnCamelMap<>();
			for (int idx = 0; idx < list.size(); idx++) {
				@SuppressWarnings("unchecked")
				Map<String, String> attchMap = (Map<String, String>) list.get(idx);
				// 게시판 첨부파일테이블
				fileMap.put("BOARD_SEQ",paramMap.get("BOARD_SEQ"));
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
			Map<String, Object> params	= new HashMap<String, Object>();
			LoginVO loginVO = getLoginVO();
			params.put("MBR_ID", loginVO.getMbrId());
			params.put("PT_CD", "MPP00012");
			params.put("BOARD_SEQ", paramMap.get("BOARD_SEQ"));
			commService.stackPoints(params);
		}else{
			Map<String, Object> params	= new HashMap<String, Object>();
			LoginVO loginVO = getLoginVO();
			params.put("MBR_ID", loginVO.getMbrId());
			params.put("PT_CD", "MPP00005");
			params.put("BOARD_SEQ", paramMap.get("BOARD_SEQ"));
			commService.stackPoints(params);
		}

		return messageRedirect(egovMessageSource.getMessage("success.common.insert"), conUrl + "review.do", model);
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
	 * 마이페이지 : 나의제품후기 : 나의제품후기관리 목록
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "review_set.do")
	public String review_set(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("REG_ID", EgovUserDetailsHelper.getMbrId());
		int totalCnt = bbtService.bbt3Count(paramMap);
		List<?> prodAfterList = bbtService.bbt3List(paramMap);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("prodAfterList", prodAfterList);
		return conUrl + "review_set";
	}

	/**
	 * 마이페이지 : 회원정보수정 
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "setting.do")
	public String setting(@RequestParam Map<String, Object> commandMap, ModelMap model, HttpServletRequest request) throws Exception {
		
		String uri="";
		
		if(CommonUtil.isMobile(request)){
			uri = "setting_m";
		}else{
			uri = "setting";
		}

		if(isLogIn()){
			
			init(model);
			UnCamelMap<String, Object> paramMap = init(commandMap);
			String MBR_ID = EgovUserDetailsHelper.getMbrId();
			paramMap.put("MBR_ID", MBR_ID);
			model.addAttribute("mbr", mmService.actionLogin(getLoginVO()));
			return conUrl + uri;
			
		}else{
			return "forward:/ISDS/mm/acessLogin.do";
		}
	}

	/**
	 * 마이페이지 : 회원정보수정 
	 * @param commandMap 회원정보가 담긴 map
	 * @param model
	 * @return 회원정보수정 페이지
	 * @throws Exception
	 */
	@RequestMapping(value = "settingSave.action")
	public String settingSave(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		UnCamelMap<String, Object> userInfo = new UnCamelMap<>();
		
		userInfo.put("MBR_ID", paramMap.getString("MBR_ID"));
		userInfo.put("CS_NO", paramMap.getString("MBR_SEQ"));
		//String[] whereColumName = new String[]{"MBR_ID"};
		//commService.tableSaveData("ASW_M_MBR_LOGIN", userInfo, null, whereColumName , null, null);
		//commService.setGdataModHis("ASW_M_MBR_LOGIN", userInfo.getString("MBR_ID"), userInfo, UPDATE);

		String[] whereColumName = new String[]{"cs_no"};
		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		//if(EgovUserDetailsHelper.getAuthenticatedUser() != null) matchingColumName.put("MID", "$uui");
		if(EgovUserDetailsHelper.getAuthenticatedUser() != null) matchingColumName.put("MID", 0); //MID가 INT형이어서 임시 하드코딩
		matchingColumName.put("MDT", "$udate");
		Map<String, Object> map = new HashMap<>();
		map.put("cs_no", paramMap.getString("MBR_SEQ"));
		map.put("cs_nm", paramMap.getString("MBR_NM"));
		map.put("e_mail", paramMap.getString("MBR_EMAIL1")+"@"+paramMap.getString("MBR_EMAIL2"));
		map.put("zip_cd", paramMap.getString("MBR_ZIPCODE"));
		map.put("addr", paramMap.getString("MBR_ADDR"));
		map.put("addr2", paramMap.getString("MBR_ADDR_DTL"));
		map.put("hp", paramMap.getString("MBR_MOBILE1")+"-"+paramMap.getString("MBR_MOBILE2")+"-"+paramMap.getString("MBR_MOBILE3"));
		if((paramMap.getString("MBR_PHONE1") == null || paramMap.getString("MBR_PHONE1").equals("")) ||
			(paramMap.getString("MBR_PHONE2") == null || paramMap.getString("MBR_PHONE2").equals("")) ||
			(paramMap.getString("MBR_PHONE3") == null || paramMap.getString("MBR_PHONE3").equals(""))){
			map.put("tel", null);
		}else{
			map.put("tel", paramMap.getString("MBR_PHONE1")+"-"+paramMap.getString("MBR_PHONE2")+"-"+paramMap.getString("MBR_PHONE3"));
		}
		commService.tableSaveData("ASA010", map, matchingColumName, whereColumName , null, null);
		commService.setGdataModHis("ASA010", userInfo.getString("CS_NO"), map, UPDATE);

		return messageRedirect(egovMessageSource.getMessage("success.common.update"), conUrl + "setting.do", model);
	}
	
	/**
	 * 마이페이지 : 회원정보수정 > 비밀번호 수정 
	 * @param commandMap 회원정보가 담긴 map
	 * @param model
	 * @return 회원정보수정 페이지
	 * @throws Exception
	 */
	@RequestMapping(value = "pwSave.action")
	public String pwSave(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		UnCamelMap<String, Object> userInfo = new UnCamelMap<>();
		JSONObject jObj = new JSONObject();


		/* 값 셋팅 : ASW_M_MBR_LOGIN */
		userInfo.put("MBR_ID", paramMap.getString("MBR_ID"));
		if(paramMap.getString("MBR_PW") != null && paramMap.getString("MBR_PW") != ""){
			
			userInfo.put("MBR_PW", EgovFileScrty.encryptPassword(paramMap.getString("MBR_ID") + paramMap.getString("MBR_PW"), paramMap.getString("MBR_ID")));
		
			// 현재 비밀번호가 다르다.
			int mbrPwExist = userService.getPwExist(userInfo);
			if(mbrPwExist <= 0){
				jObj.put("message", egovMessageSource.getMessage("fail.user.passwordUpdate1"));
				jObj.put("updateYn", "N");
				model.addAttribute("outData", jObj.toString());
				return "common/out";
			}
			
			// 새 비밀번호가 서로 다르다.
			if(!paramMap.getString("MBR_PW_NEW").equals(paramMap.getString("MBR_PW_NEW_R"))){
				jObj.put("message", egovMessageSource.getMessage("fail.user.passwordUpdate2"));
				jObj.put("updateYn", "N");
				model.addAttribute("outData", jObj.toString());
				return "common/out";
			}
			
			// 새 비밀번호가 같으니 수정
			userInfo.put("MBR_PW", EgovFileScrty.encryptPassword(paramMap.getString("MBR_ID") + paramMap.getString("MBR_PW_NEW"), paramMap.getString("MBR_ID")));
			String[] whereColumName = new String[]{"MBR_ID"};
			commService.tableSaveData("ASW_M_MBR_LOGIN", userInfo, null, whereColumName , null, null);
			commService.setGdataModHis("ASW_M_MBR_LOGIN", userInfo.getString("MBR_ID"), userInfo, UPDATE);
			jObj.put("message", egovMessageSource.getMessage("success.common.update"));
			jObj.put("updateYn", "Y");
				
		}else{
			jObj.put("message", egovMessageSource.getMessage("errors.required"));
			jObj.put("updateYn", "N");
		}
		
		model.addAttribute("outData", jObj.toString());
		return "common/out";
	}
	
	/**
	 * 마이페이지 : 회원정보수정 > 회원탈퇴
	 * @param commandMap 회원정보가 담긴 map
	 * @param model
	 * @return 홈
	 * @throws Exception
	 */
	@RequestMapping(value = "secessionSave.action")
	public String secessionSave(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		UnCamelMap<String, Object> userInfo = new UnCamelMap<>();
		JSONObject jObj = new JSONObject();
		
		userInfo.put("MBR_ID", paramMap.getString("MBR_ID"));
		userInfo.put("MBR_LOGIN_STATUS_YHN", "N");
		String[] whereColumName = new String[]{"MBR_ID"};
		commService.tableSaveData("ASW_M_MBR_LOGIN", userInfo, null, whereColumName , null, null);
		commService.setGdataModHis("ASW_M_MBR_LOGIN", userInfo.getString("MBR_ID"), userInfo, UPDATE);

		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("MBR_RSG_DT", "$idate");
		Map<String, Object> map = new HashMap<>();
		map.put("MBR_ID", paramMap.getString("MBR_ID"));
		map.put("MBR_NM", paramMap.getString("MBR_NM"));
		map.put("MBR_JOIN_DT", paramMap.getString("MBR_JOIN_DT"));
		commService.tableSaveData("ASW_M_RSG_MBR", map, matchingColumName, whereColumName , null, null);
		commService.setGdataModHis("ASW_M_RSG_MBR", userInfo.getString("MBR_ID"), map, INSERT);
		
		jObj.put("message", egovMessageSource.getMessage("success.common.secession"));
		model.addAttribute("outData", jObj.toString());
		return "common/out";
	}
	
	@RequestMapping(value = "secede.do")
	public String secede(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
		model.addAttribute("userMap", userService.mypageUser(paramMap));
		model.addAttribute("mbr", getLoginVO());
		return conUrl + "secede";
	}

	@RequestMapping(value = "memberOut.action")
	public String secede(@RequestParam MultiValueMap<String, Object> multiValueMap, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(multiValueMap);
		paramMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
		LoginVO resultVO = mmService.actionLogin(getLoginVO());
		String mbrPw = EgovFileScrty.encryptPassword(paramMap.getString("MBR_ID") + paramMap.getString("MBR_PW"), paramMap.getString("MBR_ID"));
		if(resultVO.getMbrPw().equals(mbrPw)){
			paramMap.put("MBR_NM", resultVO.getMbrNm());
			paramMap.put("MBR_NM", resultVO.getMbrNm());
			paramMap.put("MBR_JOIN_DT", resultVO.getMbrJoinDt());
			String[] contArr = paramMap.getArray("CONT_MBR");
			String MBR_CONT = "";
			if(contArr != null){
				for (int i = 0; i < contArr.length; i++) {
					if(i!=(contArr.length-1)){
						MBR_CONT += contArr[i]+" / ";
					}else if(i==(contArr.length-1)){
						MBR_CONT += contArr[i];
					}
				}
			}
			paramMap.put("MBR_CONT", MBR_CONT);
			paramMap.put("MBR_CONT_DT", paramMap.getString("MBR_CONT_DT"));
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			matchingColumName.put("MBR_RSG_DT", "$idate");
			String[] whereColumName = new String[]{"MBR_ID"};
			commService.tableSaveData("ASW_M_RSG_MBR", paramMap, matchingColumName, whereColumName , null, null);
			commService.tableDelete("ASW_M_MBR", null,"and MBR_ID ='"+paramMap.getString("MBR_ID")+"'");
			UnCamelMap<String, Object> loginMap = new UnCamelMap<>();
			loginMap.put("MBR_ID", paramMap.getString("MBR_ID"));
			loginMap.put("MBR_LOGIN_STATUS_YHN", "N");
			loginMap.put("MBR_DI", "");
			commService.tableSaveData("ASW_M_MBR_LOGIN", loginMap, null, whereColumName , null, null);
			commService.setGdataModHis("ASW_M_RSG_MBR", paramMap.getString("MBR_ID"), paramMap, INSERT);
			EgovUserDetailsHelper.removeAttribute("loginVO");
			return messageRedirect("정상적으로 회원탈퇴 처리되었습니다.", MAIN_PAGE, model);
		}else{
			return messageRedirect("비밀번호가 일치하지않습니다.", conUrl + "secede.do", model);
		}

	}

	@RequestMapping(value = "pop_delivery.action")
	public String pop_delivery(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		List<?> list = userService.mypageTransList(paramMap);
		model.addAttribute("deliveryList", list);
		model.addAttribute("mbrId", paramMap.getString("MBR_ID"));
		model.addAttribute("yTransMap", userService.mypageTransY(paramMap.getString("MBR_ID")));
		if(!paramMap.getString("TRANS_SEQ").equals("")){
			paramMap.put("TRANS_INFO_SEQ", paramMap.getString("TRANS_SEQ"));
			model.addAttribute("viewMap", userService.transView(paramMap));
		}
		return conUrl + "pop_delivery";
	}

	@RequestMapping(value = "pop_deliverySave.action")
	public String pop_deliverySave(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		paramMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
		UnCamelMap<String, Object> userInfo = new UnCamelMap<>();
		userInfo.put("MBR_ID", paramMap.getString("MBR_ID"));
		userInfo.put("TRANS_NM", paramMap.getString("TRANS_NM"));
		userInfo.put("TRANS_REV_NM", paramMap.getString("TRANS_REV_NM"));
		userInfo.put("MBR_PHONE", paramMap.getString("MBR_PHONE1")+"-"+paramMap.getString("MBR_PHONE2")+"-"+paramMap.getString("MBR_PHONE3"));
		userInfo.put("MBR_MOBILE", paramMap.getString("MBR_MOBILE1")+"-"+paramMap.getString("MBR_MOBILE2")+"-"+paramMap.getString("MBR_MOBILE3"));
		userInfo.put("MBR_ZIPCODE", paramMap.getString("MBR_ZIPCODE"));
		userInfo.put("MBR_ADDR", paramMap.getString("MBR_ADDR"));
		userInfo.put("MBR_ADDR_DTL", paramMap.getString("MBR_ADDR_DTL"));
		if(paramMap.getString("TRANS_INFO_SEQ").isEmpty()){
			userInfo.put("TRANS_INFO_SEQ", CommonUtil.nvl(getPrSeq("TRANS_INFO_SEQ")));
			commService.setGdataModHis("ASW_M_TRANS_INFO", userInfo.getString("TRANS_INFO_SEQ"), userInfo, INSERT);
		}else{
			userInfo.put("TRANS_INFO_SEQ", paramMap.getString("TRANS_INFO_SEQ"));
			commService.setGdataModHis("ASW_M_TRANS_INFO", userInfo.getString("TRANS_INFO_SEQ"), userInfo, UPDATE);
		}
		String[] whereColumName = new String[]{"TRANS_INFO_SEQ"};
		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("MBR_REG_DT", "$idate");
		commService.tableSaveData("ASW_M_TRANS_INFO", userInfo, matchingColumName, whereColumName , null, null);
		return messageRedirect(egovMessageSource.getMessage("success.common.insert"), conUrl + "pop_delivery.action?mbrId="+paramMap.getString("MBR_ID"), model);
	}

	@RequestMapping(value = "pop_deliveryYn.action")
	public String pop_deliveryYn(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		String transSeq = paramMap.getString("TRANS_SEQ");
		if(!"".equals(transSeq)){
			paramMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
			paramMap.put("BASIC_TRANS_YN", "N");
			String[] whereColumName1 = new String[]{"MBR_ID"};
			commService.tableSaveData("ASW_M_TRANS_INFO", paramMap, null, whereColumName1 , null, null);
			paramMap.put("TRANS_INFO_SEQ", transSeq);
			paramMap.put("BASIC_TRANS_YN", "Y");
			String[] whereColumName2 = new String[]{"TRANS_INFO_SEQ"};
			commService.tableSaveData("ASW_M_TRANS_INFO", paramMap, null, whereColumName2 , null, null);
			commService.setGdataModHis("ASW_M_TRANS_INFO", paramMap.getString("TRANS_INFO_SEQ"), paramMap, UPDATE);
		}
		return messageAction(egovMessageSource.getMessage("success.common.update"), "parent.fnReBasicTransInfo('"+transSeq+"');", model);
	}

	@RequestMapping(value = "pop_deliveryDel.action")
	public String pop_deliveryDel(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		String transSeq = paramMap.getString("TRANS_SEQ");
		paramMap.put("MBR_ID", EgovUserDetailsHelper.getMbrId());
		commService.tableDelete("ASW_M_TRANS_INFO", null,"and TRANS_INFO_SEQ ='"+paramMap.getString("TRANS_INFO_SEQ")+"'");
		commService.setGdataModHis("ASW_M_TRANS_INFO", paramMap.getString("TRANS_INFO_SEQ"), paramMap, DELETE);
		return messageAction(egovMessageSource.getMessage("success.common.delete"), "parent.fnReBasicTransInfo('"+transSeq+"');", model);
	}

	@RequestMapping("myInfoMap.action")
	public String getMyInfoMap( ModelMap model) throws Exception {
		String mbrId = "";
		if(!EgovUserDetailsHelper.getMbrId().equals("")){
			mbrId = EgovUserDetailsHelper.getMbrId();
		}

		model.addAttribute("outData", CommonUtil.mapToJsonString(userService.getMyInfoMap(mbrId)));
		return "common/out";
	}
}
