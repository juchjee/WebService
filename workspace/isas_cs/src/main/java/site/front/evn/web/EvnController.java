package site.front.evn.web;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.ModelAndViewDefiningException;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.MessageBox;
import egovframework.cmmn.util.PagingUtil;
import egovframework.cmmn.vo.LoginVO;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.front.evn.service.impl.EvnService;
import site.front.mm.service.impl.MmService;


@Controller
@RequestMapping(value = IConstants.ISDS_URL + "evn")
public class EvnController extends BaseController{

	private static final String conUrl = ISDS_URL + "evn/";

	/** EtcService */
	@Resource(name = "EvnService")
	private EvnService evnService;

	@Resource(name = "MmService")
	private MmService mmService;

	/**
	 * 진행중인 이벤트 리스트 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "evn.do")
	public String evnList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		String url = CommonUtil.nvl(commandMap.get(CATEGORY_PARAM_NM));

		// 진행중인 이벤트 인 경우
		if("SFM00301".equals(url) ) {
			int totalCnt = evnService.selectEventListCount();
			int page = 1;
			if( commandMap.containsKey("page")){
				if( commandMap.get("page").toString().length() > 0 ){
					 page = Integer.parseInt(commandMap.get("page").toString());
				}
			}
			PagingUtil pageInfo = new PagingUtil(totalCnt, page);
			pageInfo.setPageSize(9);
			paramMap.put("startPageNum", pageInfo.getStartPageNum());
			paramMap.put("endPageNum", pageInfo.getEndPageNum());
			model.addAttribute("page", page);
			model.addAttribute("eventList", evnService.selectEventList(paramMap)); //이벤트 목록 조회
			model.addAttribute("pageTag", pageInfo.getPagesStrTag());
			model.addAttribute("pageInfo",pageInfo);
		}else if("SFM00302".equals(url) ){ // 지난 이벤트 인 경우
			int totalCnt = evnService.selectEventPastListCount();
			int page = 1;
			if( commandMap.containsKey("page")){
				if( commandMap.get("page").toString().length() > 0 ){
					 page = Integer.parseInt(commandMap.get("page").toString());
				}
			}
			PagingUtil pageInfo = new PagingUtil(totalCnt, page);
			pageInfo.setPageSize(9);
			model.addAttribute("page", page);
			paramMap.put("startPageNum", pageInfo.getStartPageNum());
			paramMap.put("endPageNum", pageInfo.getEndPageNum());
			model.addAttribute("eventList", evnService.selectEventPastList(paramMap)); //이벤트 목록 조회
			model.addAttribute("pageTag", pageInfo.getPagesStrTag());
			model.addAttribute("pageInfo",pageInfo);
		}


		return conUrl + url;
	}

	/**
	 * 이벤트 상세 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "evnDetail.do")
	public String evnDetail(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("conUrl", conUrl);

		Map<String, Object> resultMap = null; // 이벤트 메인
		Map<String, Object> quizMap = null; // 퀴즈이벤트
		Map<String, Object> params = new HashMap<String, Object>(); // 지난이벤트인지 판단하기 위한 조회용 params
		List<?> eventPrevNextList = null;
		List<?> choiceList = null; // 객관식 퀴즈문항
		List<?> copnDownList = null; // 객관식 퀴즈문항

		ArrayList<String> numArr = new ArrayList<String>(); // rownum array
		ArrayList<String> seqArr =new ArrayList<String>(); // eventseq array
		Map<String, Object> mapList = null; // list 에서 map 값을 뽑기위한 맵

		String pageCd = ""; // 소셜댓글등의 이벤트에서 pageCd 없이 seq 만 넘어온경우 진행중인지 판단해서  페이지 연결하기위함

		if(!commandMap.containsKey("pageCd")){ // pageCd ( SFM00301,2 ) 없는경우
			params.put("EVENT_SEQ", commandMap.get("eventSeq").toString());
			// 1진행중인 이벤트
			if( 1 == evnService.selectEventProceed(params) ){
				pageCd = "SFM00301";
				eventPrevNextList = evnService.selectEventList(paramMap);
			}else{
				pageCd = "SFM00302";
				eventPrevNextList = evnService.selectEventPastList(paramMap);
			}
		}else{ // pageCd 있는경우
			if("SFM00301".equals(commandMap.get("pageCd").toString()) ){
				// 진행중이벤트
				eventPrevNextList = evnService.selectEventList(paramMap);
				pageCd = "SFM00301";
			}else{
				// 지난이벤트
				eventPrevNextList = evnService.selectEventPastList(paramMap);
				pageCd = "SFM00302";
			}
		}
		int listSize = eventPrevNextList.size();

		// 전체 리스트 rowNum 과 seq 를 배열로 저장
		for( int i=0; i < listSize; i++){
			mapList = (Map<String, Object>)eventPrevNextList.get(i);
			numArr.add(mapList.get("num").toString());
			seqArr.add(mapList.get("eventSeq").toString());
		}

		String prev = "";
		String next = "";
		for( int i=0; i < listSize; i++){
			// 선택된 seq 의 이전과 다음의 seq 를 뽑음
			if(commandMap.get("eventSeq").toString().equals(seqArr.get(i))){
				// 첫번째(맨앞) 이 아니면
				if(i != 0){
					prev = seqArr.get(i-1).toString();
				}else{
					prev = "0";
				}
				// 마지막이 아니면
				if(i != listSize-1){
					next = seqArr.get(i+1).toString();
				}else{
					next = "0";
				}
			}
		}

		// 이벤트 메인 조회
		resultMap = evnService.selectEventDetail(paramMap);

		// 퀴즈 이벤트 이면
		if( "EET00003".equals(resultMap.get("eventTp")) ){
			quizMap = evnService.selectQuizList(paramMap);

			// 퀴즈 이벤트가 객관식 이면
			if( "C".equals(quizMap.get("eventQuizTpCs"))){
				paramMap.put("QUIZ_NO", quizMap.get("eventQuizNo").toString());
				choiceList = evnService.selectQuizChoiceList(paramMap);
			}
		}

		// 쿠폰다운로드 이벤트 이면
		if( "EET00004".equals(resultMap.get("eventTp")) ){
			copnDownList = evnService.selectCopnDownList(paramMap);
		}
		resultMap.put("prev", prev);
		resultMap.put("next", next);
		resultMap.put("pageCd", pageCd);
		model.addAttribute("page", commandMap.get("page"));
		model.addAttribute("eventDetail", resultMap); //이벤트 상세조회(팝업용)
		model.addAttribute("eventList", evnService.selectEventCodeList()); //이벤트 코드목록 조회
		model.addAttribute("quizDetail", quizMap); //퀴즈이벤트
		model.addAttribute("choiceList", choiceList); //퀴즈 이벤트 객관식 항목
		model.addAttribute("copnDownList", copnDownList); //쿠폰 다운로드 리스트

		return conUrl + "SFM00301R";
	}

	/**
	 * 이벤트 참여
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "evnPart.action")
	public String evnPart(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		Map<String, Object> outData = new HashMap<String, Object>();
		if( isLogIn() ){ // 로그인 되어있을때
			Map<String, Object> partMap = new HashMap<String, Object>();
			Map<String, Object> paramMap = new HashMap<String, Object>();
			Map<String, Object> matchingColumName = new HashMap<String, Object>();

			int already = 0; // 기존에 응모했는지 여부 판단 값
			int levCdNo = 0; // 회원등급 값
			LoginVO loginVO = getLoginVO();
			String mbrId = loginVO.getMbrId();
			String eventSeq = commandMap.get("eventSeq").toString();
			String eventQuizNo = commandMap.get("eventQuizNo").toString();
			String eventQuizAns = commandMap.get("eventQuizAns").toString();
			partMap.put("EVENT_SEQ", eventSeq);
			partMap.put("QUIZ_QUEST_NO", eventQuizNo);
			partMap.put("QUIZ_QUEST_VAL", eventQuizAns);
			matchingColumName.put("MBR_ID", "$iui");
			paramMap.put("EVENT_SEQ", eventSeq);
			paramMap.put("MBR_ID", mbrId);
			outData = evnService.selectEventDetail(paramMap);

			// 회원등급을 비교할수 있게 수치조회
			levCdNo = evnService.selectMbrLev(paramMap);
			// 로그인 사용자의 회원등급 값 보다 이벤트 제한등급이 더 큰 경우
			if( levCdNo < Integer.parseInt(outData.get("mbrLevNo").toString()) ){
				outData.put("limitLevel", "F");
				model.addAttribute("outData", CommonUtil.mapToJsonString(outData));
				return "common/out";
			}

			// 참여가 횟수가 제한된 이벤트 이면
			if( "L".equals( outData.get("eventLimitsTpUl").toString() )){
				// 참여 제한 수 체크
				int limit = (Integer.parseInt(outData.get("eventLimitsCount").toString()));
				int part = (Integer.parseInt(outData.get("eventPartCount").toString()));
				if( limit <= part && limit != 0 ){
					// 참여 제한 수 초과
					outData.put("limitOver", "over");
				}else{ // 참여 기회 남음
					outData.put("limitOver", "yet");
				}
			}else{
				// 무제한 참여
				outData.put("limitOver", "yet");
			}
			if("yet".equals(outData.get("limitover"))){ // 참여가능한 경우
				// 퀴즈 이벤트 이면
				if( "EET00003".equals(commandMap.get("eventTp").toString()) ){
					// 기존 퀴즈이벤트 응모내역 있는지 확인
					already = evnService.selectAlreadyQuizPart(paramMap);
					if( already == 0){
						commService.tableSaveData("E_QUIZ_PARTY", partMap, matchingColumName, null , null, null);
						commService.setGdataModHis("E_QUIZ_PARTY", eventSeq, partMap, INSERT);
						// 포인트 적립 -- 불필요한 부분으로 판단되어 주석처리
//						paramMap.put("BOARD_SEQ", eventSeq);
//						paramMap.put("PT_CD", "MPP00007");
//						commService.stackPoints(paramMap);
					}else{
						// 기존에 응모내역이 있음
						outData.put("limitOver", "already");
					}

				}else if( "EET00002".equals(commandMap.get("eventTp").toString()) ){// 응모이벤트 이면
					// 기존 응모이벤트 응모내역 있는지 확인
					already = evnService.selectAlreadyAppPart(paramMap);
					if( already == 0){
						commService.tableSaveData("E_EVENT_APP_PARTY", partMap, matchingColumName, null , null, null);
						commService.setGdataModHis("E_EVENT_APP_PARTY", eventSeq, partMap, INSERT);
						// 포인트 적립 -- 불필요한 부분으로 판단되어 주석처리
//						paramMap.put("BOARD_SEQ", eventSeq);
//						paramMap.put("PT_CD", "MPP00007");
//						commService.stackPoints(paramMap);
					}else{
						// 기존에 응모내역이 있음
						outData.put("limitOver", "already");
					}
				}
			}
		}else{ // 로그인 하지 않은상태
			outData.put("login", "F");
		}
		model.addAttribute("outData", CommonUtil.mapToJsonString(outData));
		return "common/out";
	}


	/**
	 * 이벤트 쿠폰다운로드
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "eventCopnDown.action")
	public String eventCopnDown(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		Map<String, Object> outData = new HashMap<String, Object>();
		if( isLogIn() ){ // 로그인 되어있을때
			Map<String, Object> partMap = new HashMap<String, Object>();
			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			LoginVO loginVO = getLoginVO();
			int levCdNo = 0; // 회원등급 값
			String mbrId = loginVO.getMbrId();
			String eventSeq = commandMap.get("eventSeq").toString();
			partMap.put("EVENT_SEQ", eventSeq);
			matchingColumName.put("MBR_ID", "$iui");
			paramMap.put("EVENT_SEQ", eventSeq);
			paramMap.put("MBR_ID", mbrId);
			outData = evnService.selectEventDetail(paramMap);

			// 회원등급을 비교할수 있게 수치조회
			levCdNo = evnService.selectMbrLev(paramMap);
			// 로그인 사용자의 회원등급 값 보다 이벤트 제한등급이 더 큰 경우
			if( levCdNo < Integer.parseInt(outData.get("mbrLevNo").toString()) ){
				outData.put("limitLevel", "F");
				model.addAttribute("outData", CommonUtil.mapToJsonString(outData));
				return "common/out";
			}

			// 참여가 횟수가 제한된 이벤트 이면
			if( "L".equals( outData.get("eventLimitsTpUl").toString() )){
				// 참여 제한 수 체크
				int limit = (Integer.parseInt(outData.get("eventLimitsCount").toString()));
				int part = (Integer.parseInt(outData.get("eventPartCount").toString()));
				if( limit <= part && limit != 0 ){
					// 참여 제한 수 초과
					outData.put("limitOver", "over");
				}else{ // 참여 기회 남음
					outData.put("limitOver", "yet");
				}
			}else{
				// 무제한 참여
				outData.put("limitOver", "yet");
			}


			if("yet".equals(outData.get("limitover"))){ // 참여가능한 경우
				CamelMap<String,Object> useCopn= evnService.selecUseCpon(paramMap);
				String ecnMbrCount = useCopn.getString("ecnMbrCount");
				if(Integer.parseInt(ecnMbrCount) == 0){
					String ecnQty = useCopn.getString("ecnQty");
					String ecnCount = useCopn.getString("ecnCount");
					if(Integer.parseInt(ecnQty) > Integer.parseInt(ecnCount)){

						String commTableNm = "M_MBR_COPN_LIST";
						Map<String, Object> matchingColumName2 = new HashMap<String, Object>();
						Map<String, Object> couponIsuMap = new HashMap<String, Object>();
						matchingColumName2.put("COPN_ISU_DT", "$idate");
						couponIsuMap.put("MBR_ID",mbrId);
						couponIsuMap.put("COPN_CD",paramMap.get("COPN_CD"));
						couponIsuMap.put("COPN_ISU_CD",commProcedureService.getProcedureToObject("PR_COPN_ISU_CODE", paramMap.get("COPN_CD")));
						commService.tableInatall(commTableNm, couponIsuMap, matchingColumName2);
						commService.tableSaveData("E_EVENT_APP_PARTY", partMap, matchingColumName, null , null, null);
						commService.setGdataModHis("M_MBR_COPN_LIST", eventSeq, couponIsuMap, INSERT);
						couponIsuMap.clear();
						outData.put("limitOver", "yet");
					}else{
						outData.put("limitOver", "over");
					}
				}else{
					outData.put("limitOver", "already");
				}

			}
		}else{ // 로그인 하지 않은상태
			outData.put("login", "F");
		}
		model.addAttribute("outData", CommonUtil.mapToJsonString(outData));
		return "common/out";
	}



	private static ModelAndView setMessageRedirect(String message){
		ModelAndView modelAndView = new ModelAndView("common/messageRedirect");
		modelAndView.addObject(MESSAGE_BOX_KEY, new MessageBox("alert.message", message));
		modelAndView.addObject("rootUri", ROOT_URI);
		modelAndView.addObject("frontUrl", ISDS_URL);
		modelAndView.addObject("location", LOGIN_PAGE);
		return modelAndView;
	}

	/**
	 * 이벤트 참여 시 로그인상태가 아니었을때 redirect
	 * @param request
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	@RequestMapping(value = "evnLoginRedirect.do")
	public String evnLoginRedirect(HttpServletRequest request, @RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.putAll(request.getParameterMap());
		String referUrl = request.getParameter("referUrl");
		if(referUrl == null || "".equals(referUrl)){
			dataMap.put("referUrl", "/mall/evn/evnDetail.do?eventSeq="+commandMap.get("eventSeq")+
													"&pageCd="+commandMap.get("pageCd")+"&page="+commandMap.get("page"));
		}else{
			dataMap.put("referUrl", CommonUtil.getWebUrl(referUrl));
		}
		EgovUserDetailsHelper.setAttribute("loginParams", dataMap);
		throw new ModelAndViewDefiningException(setMessageRedirect("해당 이벤트 참여는 로그인 후 이용 가능 합니다."));
	}

	/**
	 * 이벤트 당첨자 확인 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "evnWinnersR.do")
	public String evnWinnerR(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		model.addAttribute("conUrl", conUrl);

		Map<String, Object> resultMap = null; // 이벤트 메인
		commandMap.put("EVENT_SEQ", commandMap.get("eventSeq"));

		evnService.updateWinnersHit(commandMap);
		resultMap = evnService.selectWinnersDetail(commandMap);

		model.addAttribute("winnersDetail", resultMap);

		return conUrl + "SFM00302WR";
	}

	/**
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "livereAuth.action")
	public String livereAuth(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		model.addAttribute("conUrl", conUrl);
		StringBuffer out = new StringBuffer();

		if( isLogIn() ){ // 로그인 되어있을때
			LoginVO loginVO = getLoginVO();
			String mbrId = loginVO.getMbrId();
			String mbrNm = loginVO.getMbrNm();
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("MBR_ID", mbrId);
			int mbrSeq = mmService.selectMbrSeq(params);
			out.append("var additionalResult = new Object();");
			out.append("additionalResult.user_id = \""+mbrSeq+"\";");
			out.append("additionalResult.user_name = \""+mbrNm+"\";");
		}else{
			out.append("var additionalResult ='';");
		}

		model.addAttribute("auth", out);

		return conUrl + "livereAuth";
	}

	/**
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "eBannerTop.do")
	public String eBannerTop(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);

		Map<String, Object> eBannerTopDetail = new HashMap<String, Object>();
		eBannerTopDetail = evnService.eBannerTopDetail();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("EBR00001", eBannerTopDetail);
		map.put("message", "OK");
		model.addAttribute("outData", CommonUtil.mapToJsonString(map));
		return "common/out";

	}
}
