package site.mng.amM1.amM102.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.RandomStringUtils;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.util.EgovFileScrty;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.mng.amM1.amM102.service.impl.AmM102Service;
import site.mng.amM1.amM105.service.impl.AmM105Service;
import site.mng.amM5.amM501.service.impl.AmM501Service;
import site.mng.amM7.amM706.service.impl.AmM706Service;
import site.mng.popup.service.impl.PopupService;
import site.sms.service.impl.SmsService;


/**
 * 회원관리
 * @author vary
 *
 */
@Controller
@RequestMapping(value = IConstants.MNG_URI + "amM1/amM102") /* /mng/amM1/amM102/ */
public class AmM102Controller extends BaseController{
	private static final String conUrl = MNG_URI + "amM1/amM102/";

	/** AmM102Service */
	@Resource(name = "AmM102Service")
	private AmM102Service amM102Service;

	@Resource(name = "AmM706Service")
	private AmM706Service amM706Service;

	@Resource(name = "AmM501Service")
	private AmM501Service amM501Service;

	@Resource(name = "AmM105Service")
	private AmM105Service amM105Service;

	@Resource(name = "SmsService")
	private SmsService smsService;

	@Resource(name = "PopupService")
	private PopupService popupService;

	/**
	 * 회원관리 : 회원목록 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM102.do")
	public String cbtsIaAm1002(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("conUrl", conUrl);
		paramMap.put("mbrJoinDt", model.get("nowYmd"));
		int todayCnt = amM102Service.selectTodayCntAmM102(paramMap);
		model.addAttribute("nowCount", todayCnt);
		return conUrl + "amM102";
	}

	/**
	 * 회원관리 : 회원목록 목록조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM102.action")
	public String cbtsIaAm1002a(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("conUrl", conUrl);
		List<?> list = amM102Service.selectAmM102(paramMap);
		int listCnt = amM102Service.selectCntAmM102(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		model.addAttribute("listCnt", listCnt);
		return "common/out";
	}

	@RequestMapping(value = "amM102S.action")
	public String cbtsIaAm1002S(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		// 해당키워드로 카운터조회
		int searchCnt = amM102Service.amM102S(paramMap);
		JSONObject reJson = new JSONObject();
		reJson.put("cnt", searchCnt);
		if(searchCnt==0){
			if(!"".equals(paramMap.getString("CALLER"))){
				reJson.put("mCsList", amM102Service.mCsList(paramMap));
			}
		}else if(searchCnt==1){
			reJson.put("mbrId", amM102Service.amM102SS(paramMap));
		}
		model.addAttribute("outData", reJson.toString());
		return "common/out";
	}

	@RequestMapping(value = "amM102PL.action")
	public String cbtsIaAm1002pl(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		model.addAttribute("conUrl", conUrl);
		model.addAttribute("mbrSearch", commandMap.get("mbrSearch"));
		return conUrl + "amM102PL";
	}

	@RequestMapping(value = "amM102PLA.action")
	public String cbtsIaAm1002pla(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("conUrl", conUrl);
		model.addAttribute("mbrSearch", commandMap.get("mbrSearch"));
		List<?> list = amM102Service.amM102PLA(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "amM102Del.action")
	public String amM102Del(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("conUrl", conUrl);
		String[] idArr = CommonUtil.toStringArray(paramMap.get("ID_ARR").toString(), ",");
		for(int i=0;i<idArr.length;i++){

			paramMap.put("MBR_ID", idArr[i]);
			String mbrId = paramMap.getString("MBR_ID");
			String[] whereColumName = null;
			whereColumName = new String[]{"MBR_ID"};

			Map<String, Object> userMap = amM102Service.userInfo(mbrId);
			paramMap.put("MBR_NM", userMap.get("mbrNm"));
			paramMap.put("MBR_SCORE", userMap.get("mbrScore"));
			paramMap.put("MBR_REC", userMap.get("mbrRec"));
			paramMap.put("MBR_JOIN_DT", userMap.get("mbrJoinDt"));
			Map<String, Object> matchingColumName = new HashMap<>();
			matchingColumName.put("MBR_RSG_DT", "$idate");
			commService.tableSaveData("M_RSG_MBR", paramMap, matchingColumName, whereColumName , null, null);
			commService.setGdataModHis("M_RSG_MBR", paramMap.getString("MBR_ID"), paramMap, INSERT);

			paramMap.put("MBR_LOGIN_STATUS_YHN", "N");
			commService.tableSaveData("M_MBR_LOGIN", paramMap, null, whereColumName , null, null);
			commService.setGdataModHis("M_MBR_LOGIN", paramMap.getString("MBR_ID"), paramMap, UPDATE);

			commService.tableDelete("M_MBR", null, "and MBR_ID ='"+paramMap.getString("MBR_ID")+"'");
			commService.setGdataModHis("M_MBR", paramMap.getString("MBR_ID"), paramMap, DELETE);
		}
		return messageRedirect(egovMessageSource.getMessage("success.common.delete"), conUrl + "amM102.do", model);
	}

	/**
	 * 회원정보 팝업에서 공통으로 가지고 있어야 하는 값 세팅
	 * @param model
	 * @param commandMap
	 * @param popUrl
	 * @throws Exception
	 */
	private UnCamelMap<String, Object> popInit(ModelMap model, Map<String, Object> commandMap) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);

		Map<String, Object> userInfoMap = new HashMap<String, Object>();
		userInfoMap = amM102Service.selectMbrInfo(CommonUtil.nvl(commandMap.get("mbrId"))); //회원종합정보
		model.addAttribute("mbrNm", userInfoMap.get("mbrNm"));
		model.addAttribute("mbrId", commandMap.get("mbrId"));
		model.addAttribute("userInfo", userInfoMap);

		if( commandMap.containsKey("csQuestion") ){
			model.addAttribute("csQuestion", commandMap.get("csQuestion").toString().replaceAll("\r\n", "<br/>")); // 문의내용
		}
		if( commandMap.containsKey("csConsult") ){
			model.addAttribute("csConsult", commandMap.get("csConsult").toString().replaceAll("\r\n", "<br/>")); // 상담내용
		}
		if( commandMap.containsKey("csProcess") ){
			model.addAttribute("csProcess", commandMap.get("csProcess").toString().replaceAll("\r\n", "<br/>")); // 처리내용
		}
		return paramMap;
	}

	/**
	 * 회원관리 > 회원목록 > 팝업 > 상담내역 등록
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM102CsSave.action")
	public String amM102CsSave(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		model.addAttribute("conUrl", conUrl);
		model.addAttribute("popUrl", commandMap.get("popUrl"));
		Map<String, Object> csMap = new HashMap<String, Object>(); // M_CS 테이블용
		Map<String, Object> matchingColumName = new HashMap<>();
		String admId = model.get("admId").toString();
		String mbrId = commandMap.get("mbrId").toString();
		Object csNo = CommonUtil.nvl(commService.getPrSeq("CS_NO"));
		String csFunnel = CommonUtil.nvl(commandMap.get("csFunnel"));
		String csType = CommonUtil.nvl(commandMap.get("csType"));
		String csCall = CommonUtil.nvl(commandMap.get("csCall"));

		String csQuestion = "";
		String csConsult = "";
		String csProcess = "";
		if(!CommonUtil.nvl(commandMap.get("csQuestion")).equals("")){
			 csQuestion = CommonUtil.nvl(commandMap.get("csQuestion")).replaceAll("\r\n", "<br/>"); // 문의내용
		}

		if(!CommonUtil.nvl(commandMap.get("csConsult")).equals("")){
			 csConsult = CommonUtil.nvl(commandMap.get("csConsult")).replaceAll("\r\n", "<br/>"); // 상담내용
		}

	    if(!CommonUtil.nvl(commandMap.get("csProcess")).equals("")){
			 csProcess = CommonUtil.nvl(commandMap.get("csProcess")).replaceAll("\r\n", "<br/>"); // 처리내용
		}
		if(!csNo.equals("")){
			csMap.put("CS_NO", csNo);
			}
			if(!mbrId.equals("")){
			csMap.put("CS_MBR_ID", mbrId);
			}
			if(!admId.equals("")){
			csMap.put("CA_MBR_ID", admId);
			}
			matchingColumName.put("CS_DT", "$idate");

			if(!csFunnel.equals("")){
			csMap.put("CS_FUNNEL", csFunnel);
			}

			if(!csType.equals("")){
			csMap.put("CS_TYPE", csType);
			}

			if(!csCall.equals("")){
			csMap.put("CS_CALL", csCall);
			}
			if(!csQuestion.equals("")){
				csMap.put("CS_QUESTION", csQuestion);
			}
			if(!csConsult.equals("")){
			csMap.put("CS_CONSULT", csConsult);
			}
			if(!csProcess.equals("")){
				csMap.put("CS_PROCESS", csProcess);
			}

		try{
			commService.tableInatall("M_CS", csMap, matchingColumName);
			commService.setGdataModHis("M_CS", csNo, csMap, INSERT);
			// 고객평가 점수가 있다면 평가점수를 등록
			if(CommonUtil.nvl(commandMap.get("mbrId")).equals("")){
				if( commandMap.get("mbrScore").toString().length() > 0	){
					Map<String, Object> mbrMap = new HashMap<String, Object>();
					String[] whereColumName = new String[]{"MBR_ID"};
					mbrMap.put("MBR_ID", mbrId);
					mbrMap.put("MBR_SCORE", commandMap.get("mbrScore"));
					commService.tableSaveData("M_MBR", mbrMap, matchingColumName, whereColumName , null, null);
					commService.setGdataModHis("M_MBR", csNo, csMap, UPDATE);
				}
			}
		}catch(Exception e){
			return messageRedirect(
					egovMessageSource.getMessage("fail.common.insert"),
					conUrl + commandMap.get("popUrl")+"?mbrId="+commandMap.get("mbrId")+"&mbrNm="+commandMap.get("mbrNm")
			, model);
		}

		if(CommonUtil.nvl(commandMap.get("popUrl")).equals("")){
			commandMap.put("popUrl", "/mng/amM1/amM102/amM1021.pop");
		}

		return messageRedirect(
			egovMessageSource.getMessage("success.common.insert"),
			conUrl + commandMap.get("popUrl")+"?mbrId="+commandMap.get("mbrId")+"&mbrNm="+commandMap.get("mbrNm")
		, model);
	}

	/**
	 * 회원관리 > 회원목록 > 팝업 > 회원 종합 정보 조회 ( 그리드에서 or 회원검색에서 처음 클릭 시 조회후 리다이렉트 )
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1021F.pop")
	public String amM1021F(@RequestParam Map<String, Object> commandMap, ModelMap model, RedirectAttributes redirectAttr) throws Exception {
		init(model);
/*		Map<String, Object> userInfoMap = new HashMap<String, Object>();
		userInfoMap = amM102Service.mbrTotalInfo(commandMap.get("mbrId").toString()); //회원종합정보
		redirectAttr.addAttribute("mbrId", commandMap.get("mbrId"));
		redirectAttr.addAttribute("mbrNm", userInfoMap.get("mbrNm"));
		redirectAttr.addAttribute("mbrScore", userInfoMap.get("mbrScore"));
		redirectAttr.addAttribute("popUrl", "amM1021.pop");
 */
		redirectAttr.addAttribute("mbrId", commandMap.get("mbrId"));

		return"redirect:amM1021.pop";
	}

	/**
	 * 회원관리 > 회원목록 > 팝업 > 회원 종합 정보 조회
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1021.pop")
	public String amM1021(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		popInit(model, commandMap);
		return conUrl + "amM102P1";
	}

	/**
	 * 회원관리 > 회원목록 > 팝업 > 회원정보 수정페이지 로드
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1022.pop")
	public String amM1022(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		popInit(model, commandMap);
		return conUrl + "amM102P2";
	}


	/**
	 * 회원관리 > 회원목록 > 팝업 >회원정보 수정항목 저장
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1022Save.action")
	public String amM1022Save(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model, commandMap);
		UnCamelMap<String, Object> paramMap = init(commandMap);
		model.addAttribute("conUrl", conUrl);
		String mbrId = paramMap.getString("MBR_ID");
		String csNo = paramMap.getString("MBR_SEQ");

		Map<String, Object> userInfoMap = new HashMap<String, Object>(); // ASA010 테이블용
		Map<String, Object> userStatusMap = new HashMap<String, Object>(); // M_MBR_LOGIN 테이블용

		// ASA010 테이블용 데이터 세팅
		String[] whereColumName = new String[]{"cs_no"};
		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		if(EgovUserDetailsHelper.getAuthenticatedUser() != null) matchingColumName.put("mid", 0); //MID가 INT형이어서 임시 하드코딩
		matchingColumName.put("mdt", "$udate");
		userInfoMap.put("cs_no", paramMap.getString("MBR_SEQ"));
		userInfoMap.put("cs_nm", paramMap.getString("MBR_NM"));
		userInfoMap.put("e_mail", paramMap.getString("MBR_EMAIL1")+"@"+paramMap.getString("MBR_EMAIL2"));
		userInfoMap.put("zip_cd", paramMap.getString("MBR_ZIPCODE"));
		userInfoMap.put("addr", paramMap.getString("MBR_ADDR"));
		userInfoMap.put("addr2", paramMap.getString("MBR_ADDR_DTL"));
		userInfoMap.put("hp", paramMap.getString("MBR_MOBILE1")+"-"+paramMap.getString("MBR_MOBILE2")+"-"+paramMap.getString("MBR_MOBILE3"));
		if((paramMap.getString("MBR_PHONE1") == null || paramMap.getString("MBR_PHONE1").equals("")) ||
			(paramMap.getString("MBR_PHONE2") == null || paramMap.getString("MBR_PHONE2").equals("")) ||
			(paramMap.getString("MBR_PHONE3") == null || paramMap.getString("MBR_PHONE3").equals(""))){
			userInfoMap.put("tel", null);
		}else{
			userInfoMap.put("tel", paramMap.getString("MBR_PHONE1")+"-"+paramMap.getString("MBR_PHONE2")+"-"+paramMap.getString("MBR_PHONE3"));
		}
		
		// ASW_M_MBR_LOGIN 테이블용 데이터 세팅
		String[] whereColumName2 = new String[]{"MBR_ID"};
		userStatusMap.put("MBR_ID", paramMap.getString("MBR_ID"));
		userStatusMap.put("MBR_LOGIN_STATUS_YHN", paramMap.getString("MBR_LOGIN_STATUS_YHN"));

		try{
			commService.tableSaveData("ASA010", userInfoMap, matchingColumName, whereColumName , null, null);
			commService.setGdataModHis("ASA010", csNo, userInfoMap, UPDATE);
			commService.tableSaveData("ASW_M_MBR_LOGIN", userStatusMap, null, whereColumName2, null, null);
			commService.setGdataModHis("ASW_M_MBR_LOGIN", mbrId, userStatusMap, UPDATE);
		}catch(Exception e){
			return messageRedirect(
					egovMessageSource.getMessage("fail.common.update"),
					conUrl + "amM1022.pop?mbrId="+commandMap.get("mbrId")+"&mbrNm="+commandMap.get("mbrNm")
			, model);
		}
		return messageRedirect(
			egovMessageSource.getMessage("success.common.update"),
			conUrl + "amM1022.pop?mbrId="+commandMap.get("mbrId")+"&mbrNm="+commandMap.get("mbrNm")
		, model);
	}

	/**
	 * 맵에 보내지지 않은 키값을 get 할때 null
	 * @param map
	 * @param key
	 * @return
	 */
	public String getValueIgnoreNull(Map<String, Object> map, String key){
		String value = "";
		try{
			value=map.get(key).toString();
		}catch (Exception e){
			// 맵에 해당 키가 없음
		}
		return value;
	}

	@RequestMapping(value = "amM1023.pop")
	public String cbtsIaAm10023a(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = popInit(model, commandMap);
		model.addAttribute("amM203Sum", amM102Service.amM1023SUM(paramMap));
		return conUrl + "amM102P3";
	}

	@RequestMapping(value = "amM1023.action")
	public String cbtsIaAm10023L(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("mbrId", commandMap.get("mbrId"));
		model.addAttribute("mbrNm", commandMap.get("mbrNm"));
		List<?> list = amM102Service.amM1023L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "amM1024.pop")
	public String cbtsIaAm10024a(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = popInit(model, commandMap);
		List<?> list = amM105Service.amM105(paramMap);
		model.addAttribute("plicyList", list);
		return conUrl + "amM102P4";
	}

	/**
	 * 포인트 적립 ( 차감은 -숫자 로 적립시킴 )
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1024SavePoint.action")
	public String amM1024SavePoint(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		Map<String, Object> resultMap = new HashMap<String, Object>();
		try{
			Object ptSeq = commService.getPrSeq("MBR_PT_SEQ");
			paramMap.put("PT_CD", commandMap.get("ptCd"));
			paramMap.put("MBR_ID", commandMap.get("mbrId"));
			paramMap.put("MBR_PT_SEQ", ptSeq);
			paramMap.put("MBR_PT_SCORE", commandMap.get("mbrPtScore"));
			Map<String, Object> matchingColumName = new HashMap<>();
			matchingColumName.put("MBR_PT_ACC_DT", "$idate");
			Map<String, Object> modKeyMap = new HashMap<String, Object>(); // 히스토리 수정용

			modKeyMap.put("MBR_ID", commandMap.get("mbrId"));
			modKeyMap.put("MBR_PT_SEQ", ptSeq);
			commService.tableInatall("M_MBR_PT_LIST", paramMap, matchingColumName, null);
			commService.setGdataModHis("M_MBR_PT_LIST", modKeyMap, paramMap, INSERT);
			resultMap.put("result", "success");
		}catch(Exception e){
			resultMap.put("result", "fail");
		}

		model.addAttribute("outData", CommonUtil.mapToJsonString(resultMap));
		return "common/out";
	}

	/**
	 * 회원관리 > 회원목록 > 팝업 > 쿠폰내역
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1025.pop")
	public String amM1025(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = popInit(model, commandMap);
		paramMap.put("MBR_ID", commandMap.get("mbrId"));
		String totCopnDisAmt = amM102Service.totCopnDisAmt(paramMap); // 쿠폰 총 할인 금액
		model.addAttribute("totCopnDisAmt", totCopnDisAmt);
		return conUrl + "amM102P5";
	}

	/**
	 * 회원관리 > 회원목록 > 팝업 > 사용된 쿠폰내역
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1025usedCpn.action")
	public String amM1025usedCpn(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = popInit(model, commandMap);
		paramMap.put("MBR_ID", commandMap.get("mbrId"));
		List<?> usedCpnList = amM102Service.amM1025usedCpn(paramMap); //사용된쿠폰
		model.addAttribute("outData", CommonUtil.listToJsonString(usedCpnList));
		return "common/out";
	}

	/**
	 * 회원관리 > 회원목록 > 팝업 > 미사용 쿠폰내역
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1025unUsedCpn.action")
	public String amM1025unUsedCpn(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = popInit(model, commandMap);
		paramMap.put("MBR_ID", commandMap.get("mbrId"));
		List<?> unUsedCpnList = amM102Service.amM1025unUsedCpn(paramMap); // 미사용 쿠폰
		model.addAttribute("outData", CommonUtil.listToJsonString(unUsedCpnList));
		return "common/out";
	}

	/**
	 * 회원관리 : 회원목록 : 고객상담 팝업조회 (bbt2/BBM00003)
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1026.pop")
	public String cbtsIaAm10026a(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = popInit(model, commandMap);
		paramMap.put("BOARD_MST_CD", "BBM00003");
		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		return conUrl + "amM102P6";
	}

	/**
	 * 회원관리 : 회원목록 : 고객상담 목록조회 (bbt2/BBM00003)
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1026.action")
	public String cbtsIaAm10026L(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		paramMap.put("BOARD_MST_CD", "BBM00003");
		List<?> list = amM102Service.amM1026L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/**
	 * 회원관리 : 회원목록 : 고객상담 목록카운트 (bbt2/BBM00003)
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1026Cnt.action")
	public String cbtsIaAm10026Cnt(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("mbrId", commandMap.get("mbrId"));
		model.addAttribute("mbrNm", commandMap.get("mbrNm"));
		paramMap.put("BOARD_MST_CD", "BBM00003");
		Map<String, Object> outData = new HashMap<String, Object>();
		outData.put("totCnt", amM102Service.amM1026TC(paramMap));
		outData.put("miCnt", amM102Service.amM1026NC(paramMap));
		model.addAttribute("outData", CommonUtil.mapToJsonString(outData));
		return "common/out";
	}

	/**
	 * 회원관리 : 회원목록 : 제품문의 팝업조회 (bbt2/BBM00006)
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1027.pop")
	public String cbtsIaAm10027a(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = popInit(model, commandMap);
		paramMap.put("BOARD_MST_CD", "BBM00006");
		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		return conUrl + "amM102P7";
	}

	/**
	 * 회원관리 : 회원목록 : 제품문의 목록조회 (bbt2/BBM00006)
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1027.action")
	public String cbtsIaAm10027L(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		paramMap.put("BOARD_MST_CD", "BBM00006");
		List<?> list = amM102Service.amM1026L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/**
	 * 회원관리 : 회원목록 : 제품문의 목록카운트 (bbt2/BBM00006)
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "amM1027Cnt.action")
	public String cbtsIaAm10027Cnt(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("mbrId", commandMap.get("mbrId"));
		model.addAttribute("mbrNm", commandMap.get("mbrNm"));
		paramMap.put("BOARD_MST_CD", "BBM00006");
		Map<String, Object> outData = new HashMap<String, Object>();
		outData.put("totCnt", amM102Service.amM1026TC(paramMap));
		outData.put("miCnt", amM102Service.amM1026NC(paramMap));
		model.addAttribute("outData", CommonUtil.mapToJsonString(outData));
		return "common/out";
	}

	@RequestMapping(value = "amM1028.pop")
	public String cbtsIaAm10028a(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = popInit(model, commandMap);
		paramMap.put("BOARD_MST_CD", "BBM00007");
		List<?> cateList = amM706Service.amM706CL(paramMap);
		model.addAttribute("cateList", cateList);
		return conUrl + "amM102P8";
	}

	@RequestMapping(value = "amM1028.action")
	public String cbtsIaAm10028L(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		paramMap.put("BOARD_MST_CD", "BBM00007");
		List<?> list = amM102Service.amM1026L(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "amM1028Cnt.action")
	public String cbtsIaAm10028Cnt(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		model.addAttribute("mbrId", commandMap.get("mbrId"));
		model.addAttribute("mbrNm", commandMap.get("mbrNm"));
		paramMap.put("BOARD_MST_CD", "BBM00007");
		Map<String, Object> outData = new HashMap<String, Object>();
		outData.put("totCnt", amM102Service.amM1026TC(paramMap));
		outData.put("miCnt", amM102Service.amM1026NC(paramMap));
		model.addAttribute("outData", CommonUtil.mapToJsonString(outData));
		return "common/out";
	}

	@RequestMapping(value = "amM1029.pop")
	public String cbtsIaAm10029a(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = popInit(model, commandMap);
		paramMap.put("boardMstCd", "BBM00003");
		List<?> cateList = amM102Service.cateList(paramMap);
		model.addAttribute("cateList",cateList);
		
		return conUrl + "amM102P9";
	}

	@RequestMapping(value = "amM1029.action")
	public String cbtsIaAm10029L(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception{
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> list = amM102Service.selectAmM102P9(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "amM1029Cnt.action")
	public String cbtsIaAm10029Cnt(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		Map<String, Object> outData = new HashMap<String, Object>();
		outData.put("totCnt", amM102Service.selectCntAmM102P9(paramMap));
		outData.put("miCnt", amM102Service.selectDelayCntAmM102P9(paramMap));
		model.addAttribute("mbrId", commandMap.get("mbrId"));
		model.addAttribute("mbrNm", commandMap.get("mbrNm"));
		model.addAttribute("outData", CommonUtil.mapToJsonString(outData));
		return "common/out";
	}

	/**
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "wearingPop.action")
	public String wearingPop(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		return conUrl + "wearingPop";
	}

	/**
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "orderPakingSms.action")
	public String orderPakingSms(@RequestParam Map<String, Object> commandMap,ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);

		paramMap.put("tranCallback", SMS_SEND_PHONE);
		paramMap.put("tranStatus", "1");

		return messageAction(egovMessageSource.getMessage("success.common.send"), "parent.$.fancybox.close(); parent.location.reload(true);", model);
	}

	/**
	 * SMS보내기
	 * @param
	 * @return
	 * @exception Exception
	 */
	@RequestMapping(value = "sendMLS.do")
	public String sendMLS(@RequestParam Map<String, Object> commandMap, HttpServletRequest request, HttpServletResponse response, ModelMap model) throws Exception {

//		System.out.println("start");
//
//		String msg = "";
//		UnCamelMap<String, Object> paramMap = init(commandMap);
//		JSONObject jObj = new JSONObject();
//
//		String mbrPw = paramMap.getString("MBR_PW");
//		String mbrMobile = paramMap.getString("MBR_MOBILE");
//
//		try {
//			if("".equals(mbrPw)){
//				msg = "비밀 / 인증 번호가 누락 되었습니다.";
//
//			}else if("".equals(mbrMobile)){
//				msg = "휴대폰 번호가 누락 되었습니다.";
//			}else{
//				popupService.mmsSendTempD();
//				int emTranMmsMaxSeq = smsService.emTranMmsMaxMmsSeq();
//				popupService.mmsSendTempReseed();
//				int eMmsTempMaxMmsSeq = popupService.eMmsTempMaxMmsSeq();
//				int updateSeq = emTranMmsMaxSeq - eMmsTempMaxMmsSeq;
//				Map<String, Object> seqMap = new HashMap<String, Object>();
//				seqMap.put("EM_TRAN_MMS_MAX_SEQ", emTranMmsMaxSeq);
//				seqMap.put("E_MMS_TEMP_MAX_MMS_SEQ", eMmsTempMaxMmsSeq);
//				seqMap.put("UPDATE_SEQ", updateSeq);
//
//				paramMap.put("MSG_ROLE_CD", "EMR00017");
//				paramMap.put("MSG_DIV_RC", "C");
//				softPhoneService.mmsSendTempI(paramMap);
//				popupService.emTranMmsSend();
//				popupService.mmsSendTempU(seqMap);
//				popupService.mmsSend();
//
//				msg = "정상적으로 SMS를 보냈습니다.";
//			}
//		} catch (Exception e) {
//			logger.error(e.getMessage());
//			msg = "SMS 보내기에 실패 하였습니다." + e.getMessage();
//		}
//		jObj.put("message", msg);
//		model.addAttribute("outData", jObj.toString());
		return "common/out";
	}

	/**
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "unlockMbr.action")
	public String unlockMbr(@RequestParam Map<String, Object> commandMap,ModelMap model)  {
		try{
			UnCamelMap<String, Object> paramMap = init(model, commandMap);

			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			matchingColumName.put("MBR_LOGIN_DT", "$idate");
			commService.tableInatall("M_MBR_LOGIN_HIS", paramMap, matchingColumName);

			Map<String, Object> mbrMap = new HashMap<String, Object>();
			mbrMap.put("MBR_LOGIN_STATUS_YHN","Y");
			commService.tableUpdate("M_MBR_LOGIN", mbrMap, null,null, " and MBR_ID = '" + paramMap.get("MBR_ID") + "'", null);
			model.addAttribute("outData", egovMessageSource.getMessage("success.common.insert"));
		}catch(Exception e){
			model.addAttribute("outData", egovMessageSource.getMessage("fail.common.insert"));
		}
		return "common/out";

	}

	/**
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "newPassword.action")
	public String newPassword(@RequestParam Map<String, Object> commandMap,ModelMap model)  {
		try{
			UnCamelMap<String, Object> paramMap = init(model, commandMap);
			String mbrId = paramMap.getString("MBR_ID");
    		String newPW = RandomStringUtils.randomAlphanumeric(6);//임시비밀번호 만들기 임의의 8자리
    		String newEncryptPW = EgovFileScrty.encryptPassword(mbrId + newPW, mbrId);
    		Map<String, Object> newParams = new HashMap<>();
    		newParams.put("MBR_ID", mbrId);
    		newParams.put("MBR_PW", newEncryptPW);
    		commService.tableSaveData("M_MBR_LOGIN", newParams, null, new String[]{"MBR_ID"}, null, null);
    		UnCamelMap<String, Object> smsMailMap = new UnCamelMap<String, Object>();
			smsMailMap.put("mbrId", mbrId);
			smsMailMap.put("msgSendSeq", CommonUtil.nvl(commService.getPrSeq("MSG_SEND_SEQ")));
			smsMailMap.put("msgRoleCd", "EMR00021");
			smsMailMap.put("msgDivRc", "C");
			smsMailMap.put("mbrMobile", paramMap.get("MBR_MOBILE"));
    		smsService.sendPWSms(smsMailMap, newPW);
    		model.addAttribute("outData", egovMessageSource.getMessage("success.request.msg"));
		}catch(Exception e){
			model.addAttribute("outData", egovMessageSource.getMessage("fail.request.msg"));
		}
		return "common/out";
	}

}
