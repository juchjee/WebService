package site.mng.popup.web;

import java.util.ArrayList;
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
import egovframework.cmmn.util.CommonUtil;
import egovframework.cmmn.web.BaseController;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.mng.amM4.amM403.service.impl.AmM403Service;
import site.mng.amM4.amM404.service.impl.AmM404Service;
import site.mng.popup.service.impl.PopupService;
import site.sms.service.impl.SmsService;

@Controller
@RequestMapping(value = IConstants.MNG_URI + "popup/") // /mng/main/
public class PopupController extends BaseController{

	/** PopupService */
	@Resource(name = "PopupService")
	private PopupService popupService;

	/** PopupService For SMS */
	@Resource(name = "AmM403Service")
	private AmM403Service amM403Service;

	/** PopupService For EMAIL */
	@Resource(name = "AmM404Service")
	private AmM404Service amM404Service;

	@Resource(name = "SmsService")
	private SmsService smsService;

	


	/**
	 * 상품조회 팝업
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "prodSearchPop.do")
	public String prodSearchPop(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		return IConstants.MNG_URI + "popup/prodSearchPop";
	}


	/**
	 * 메시지롤 관리 팝업
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "msgRollMgtPop.do")
	public String msgRollMgtPop(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		init(model);
		model.addAttribute("emrMaxCode", popupService.msgRollCode());
		return IConstants.MNG_URI + "popup/msgRollMgtPop";
	}

	/**
	 * 메시지롤 관리 팝업 목록
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "msgRollMgtPopA.do")
	public String msgRollMgtPopA(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> list = popupService.msgRollMgtPopA(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@SuppressWarnings("unchecked")
	@RequestMapping(value = "msgRollSave.action")
	public String msgRollSave(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		try{
			init(model);
			String jsonDtr = HtmlUtils.htmlUnescape(CommonUtil.nvl(commandMap.get("data")));
			JSONArray jasonArr = new JSONArray(jsonDtr);
			List<Map<String, Object>> saveList = JsonHelper.toUnCamelList(jasonArr);
			for(Map<String, Object> map : saveList){
				map.put("MSG_ROLE_TP_ASM", map.get("MSG_ROLE_TP_ASM"));
				map.put("MSG_ROLE_YN", map.get("MSG_ROLE_YN"));
				if(CommonUtil.nvl(map.get("MSG_ROLE_CD")).equals("")){
					map.put("MSG_ROLE_CD", commService.getPrCode("EMR"));
				}else{
					map.put("MSG_ROLE_CD", map.get("MSG_ROLE_CD"));
				}
				map.put("MSG_ROLE_NM", map.get("MSG_ROLE_NM"));
				String[] whereColumName = null;
				whereColumName = new String[]{"MSG_ROLE_CD"};
				commService.tableSaveData("E_MSG_ROLE", map, null, whereColumName , null, null);
	    	}
			model.addAttribute("outData", "ok");
		}catch(Exception e){
			model.addAttribute("outData", "ng");
		}
		return "common/out";
	}

	@RequestMapping(value = "msgRollDelete.action")
	public String msgRollDelete(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		try{
			UnCamelMap<String, Object> paramMap = init(model, commandMap);
			String jsonDtr = HtmlUtils.htmlUnescape(CommonUtil.nvl(commandMap.get("data")));
			JSONObject jasonArr = new JSONObject(jsonDtr);
			UnCamelMap<String, Object> deleteMap = JsonHelper.toUnCamelMap(jasonArr);

				paramMap.put(deleteMap.getString("KEY_COLUMN"), deleteMap.getString("KEY_VALUE"));
				paramMap.put("MSG_ROLE_YN", 'N');
				String[] whereColumName = null;
				whereColumName = new String[]{"MSG_ROLE_CD"};
				commService.tableSaveData("E_MSG_ROLE", paramMap, null, whereColumName , null, null);

			model.addAttribute("outData", "ok");
		}catch(Exception e){
			model.addAttribute("outData", "ng");
		}
		return "common/out";
	}

	/**
	 *  조건별 회원인원 검색
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "conditionSearchCount.do")
	public String conditionSearchCount(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		String conditionSearchCount = popupService.conditionSearchCount(paramMap);
		model.addAttribute("outData", conditionSearchCount);
		return "common/out";
	}
	/**
	 *  조건별 회원 검색
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "conditionSearch.do")
	public String conditionSearch(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		List<?> list  = popupService.conditionSearch(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	/**
	 * SMS 발송 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "smsSendPop.do")
	public String smsSendPopView(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		model.addAttribute("smsInfo", amM403Service.amM403U(paramMap));
		model.addAttribute("msgVariableList", commService.msgVariableList(paramMap));
		return IConstants.MNG_URI + "popup/smsSendPop";
	}
	/**
	 * SMS 발송
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "smsSendPop.action")
	public String smsSendPop(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		popupService.smsSend(paramMap);
		return messageRedirect(egovMessageSource.getMessage("success.common.send"), IConstants.MNG_URI + "popup/smsSendPop.do?msgRoleCd=" + paramMap.getString("MSG_ROLE_CD")+"&msgDivRc=" + paramMap.getString("MSG_DIV_RC"), model);
	}

	/**
	 * MMS 발송 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "mmsSendPop.do")
	public String mmsSendPopView(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		model.addAttribute("mmsInfo", amM403Service.amM403U(paramMap));
		model.addAttribute("msgVariableList", commService.msgVariableList(paramMap));
		return IConstants.MNG_URI + "popup/mmsSendPop";
	}
	/**
	 * MMS 발송
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "mmsSendPop.action")
	public String mmsSendPop(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		popupService.mmsSendTempD();
		int emTranMmsMaxSeq = smsService.emTranMmsMaxMmsSeq();
		popupService.mmsSendTempReseed();
		int eMmsTempMaxMmsSeq = popupService.eMmsTempMaxMmsSeq();
		int updateSeq = emTranMmsMaxSeq - eMmsTempMaxMmsSeq;
		Map<String, Object> seqMap = new HashMap<String, Object>();
		seqMap.put("EM_TRAN_MMS_MAX_SEQ", emTranMmsMaxSeq);
		seqMap.put("E_MMS_TEMP_MAX_MMS_SEQ", eMmsTempMaxMmsSeq);
		seqMap.put("UPDATE_SEQ", updateSeq);

		popupService.mmsSendTempI(paramMap);

		popupService.emTranMmsSend();
		popupService.mmsSendTempU(seqMap);
		popupService.mmsSend();
		return messageRedirect(egovMessageSource.getMessage("success.common.send"), IConstants.MNG_URI + "popup/mmsSendPop.do?msgRoleCd=" + paramMap.getString("MSG_ROLE_CD")+"&msgDivRc=" + paramMap.getString("MSG_DIV_RC"), model);
	}

	/**
	 * Email 발송 화면
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "emailSendPop.do")
	public String emailSendPopView(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		//MailHelper mailHelper = new MailHelper(commService);
		model.addAttribute("emailInfo", amM404Service.amM404U(paramMap));
		model.addAttribute("msgVariableList", commService.msgVariableList(paramMap)); //메일에 치환 변수값을 조회한다.
		//model.addAttribute("remainCnt",mailHelper.getRemainCnt());//대량메일 잔여건수조회
		return IConstants.MNG_URI + "popup/emailSendPop";
	}

	/**
	 * Email 발송
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "emailSendPop.action")
	public String emailSendPop(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		if(popupService.getMailHoldingCount().equals("0")){ //메일 발송중인지 체크
			popupService.emailSend(paramMap);
			return messageRedirect(egovMessageSource.getMessage("success.common.send"), IConstants.MNG_URI + "popup/emailSendPop.do?msgRoleCd=" + paramMap.getString("MSG_ROLE_CD")+"&msgDivRc=" + paramMap.getString("MSG_DIV_RC"), model);
		}else{
			return messageRedirect(egovMessageSource.getMessage("mail.send.stop"), IConstants.MNG_URI + "popup/emailSendPop.do?msgRoleCd=" + paramMap.getString("MSG_ROLE_CD")+"&msgDivRc=" + paramMap.getString("MSG_DIV_RC"), model);
		}



	}

	/**
	 * 회원관리 : SMS발송 팝업
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "mbrSmsSendPop.do")
	public String mbrSmsSendPop(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		model.addAttribute("idArr", paramMap.get("ID_ARR"));
		model.addAttribute("nmArr", paramMap.get("NM_ARR"));
		String[] idArr = CommonUtil.toStringArray(paramMap.get("ID_ARR").toString(), ",");
		String[] nmArr = CommonUtil.toStringArray(paramMap.get("NM_ARR").toString(), ",");
		List<Map<String, Object>> list = new ArrayList<>();
		for(int i=0;i<idArr.length;i++){
			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("mbrId", idArr[i]);
			resultMap.put("mbrNm", nmArr[i]);
			list.add(resultMap);
		}
		model.addAttribute("mbrSmsList", list);
		paramMap.put("MSG_DIV_RC", "C");
		model.addAttribute("msgVariableList", commService.msgVariableList(paramMap)); //메시지에 치환 변수값을 조회한다.
		return IConstants.MNG_URI + "popup/mbrSmsSendPop";
	}

	/**
	 * 회원관리 : SMS 일반발송(비회원) 팝업
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "mbrSmsNomalSendPop.do")
	public String mbrSmsNomalSendPop() throws Exception {
		return IConstants.MNG_URI + "popup/mbrSmsNomalSendPop";
	}

	/**
	 * 회원관리 : SMS 발송 선택회원 ( LISTBOX )
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "mbrSmsList.action")
	public String mbrSmsSendList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		String[] idArr = CommonUtil.toStringArray(paramMap.get("ID_ARR").toString(), ",");
		String[] nmArr = CommonUtil.toStringArray(paramMap.get("NM_ARR").toString(), ",");
		List<Map<String, Object>> list = new ArrayList<>();
		for(int i=0;i<idArr.length;i++){
			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("mbrId", idArr[i]);
			resultMap.put("mbrNm", nmArr[i]);
			list.add(resultMap);
		}
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "mbrSmsTemp.action")
	public String mbrSmsTemp(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		paramMap.put("MSG_DIV_RC", "C");
		List<?> mbrSmsContList = popupService.mbrSmsTemp(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(mbrSmsContList));
		return "common/out";
	}

	/**
	 * 회원관리 : SMS 발송 로직처리
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "mbrSmsSendPop.action")
	public String mbrSmsSendPopA(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		String[] idArr = CommonUtil.toStringArray(paramMap.get("ID_ARR").toString(), ",");
		List<String> mbrIdList = new ArrayList<String>();
		for(int i=0;i<idArr.length;i++){
			mbrIdList.add(idArr[i]);
		}
		paramMap.put("mbrIdList", mbrIdList);
		popupService.mbrSmsSend(paramMap);
		return messageAction(egovMessageSource.getMessage("success.common.send"), "parent.$.fancybox.close();", model);
	}

	/**
	 * 회원관리 : SMS 발송(비회원) 로직처리
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "mbrSmsNomalSendPop.action")
	public String orderPakingSms(@RequestParam Map<String, Object> commandMap,ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);

		UnCamelMap<String, Object> smsMap = new UnCamelMap<String, Object>();
		smsMap.put("tranPhone", paramMap.get("TRAN_PHONE"));
		smsMap.put("tranCallback", SMS_SEND_PHONE);
		smsMap.put("tranStatus", "1");
		smsMap.put("tranMsg", paramMap.get("TRAN_MSG"));

		commService.smsSend(smsMap);

		smsMap.clear();

		return messageAction(egovMessageSource.getMessage("success.common.send"), "parent.$.fancybox.close(); ", model);
	}

	@RequestMapping(value = "mbrMmsSendPop.do")
	public String mbrMmsSendPop(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		model.addAttribute("idArr", paramMap.get("ID_ARR"));
		model.addAttribute("nmArr", paramMap.get("NM_ARR"));
		String[] idArr = CommonUtil.toStringArray(paramMap.get("ID_ARR").toString(), ",");
		String[] nmArr = CommonUtil.toStringArray(paramMap.get("NM_ARR").toString(), ",");
		List<Map<String, Object>> list = new ArrayList<>();
		for(int i=0;i<idArr.length;i++){
			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("mbrId", idArr[i]);
			resultMap.put("mbrNm", nmArr[i]);
			list.add(resultMap);
		}
		model.addAttribute("mbrMmsList", list);
		paramMap.put("MSG_DIV_RC", "C");
		model.addAttribute("msgVariableList", commService.msgVariableList(paramMap)); //메시지에 치환 변수값을 조회한다.
		return IConstants.MNG_URI + "popup/mbrMmsSendPop";
	}

	@RequestMapping(value = "mbrMmsSendPop.action")
	public String mbrMmsSendPopA(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		String[] idArr = CommonUtil.toStringArray(paramMap.get("ID_ARR").toString(), ",");
		List<String> mbrIdList = new ArrayList<String>();
		for(int i=0;i<idArr.length;i++){
			mbrIdList.add(idArr[i]);
		}
		paramMap.put("mbrIdList", mbrIdList);

		popupService.mmsSendTempD();
		int emTranMmsMaxSeq = smsService.emTranMmsMaxMmsSeq();
		popupService.mmsSendTempReseed();
		int eMmsTempMaxMmsSeq = popupService.eMmsTempMaxMmsSeq();
		int updateSeq = emTranMmsMaxSeq - eMmsTempMaxMmsSeq;
		Map<String, Object> seqMap = new HashMap<String, Object>();
		seqMap.put("EM_TRAN_MMS_MAX_SEQ", emTranMmsMaxSeq);
		seqMap.put("E_MMS_TEMP_MAX_MMS_SEQ", eMmsTempMaxMmsSeq);
		seqMap.put("UPDATE_SEQ", updateSeq);
		popupService.mbrMmsSendTempI(paramMap);
		popupService.emTranMmsSend();
		popupService.mmsSendTempU(seqMap);
		popupService.mbrMmsSend();
		return messageAction(egovMessageSource.getMessage("success.common.send"), "parent.$.fancybox.close(); ", model);
	}

	/**
	 * 회원관리 : SMS 발송 선택회원 ( LISTBOX )
	 * @param commandMap
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "mbrMmsList.action")
	public String mbrMmsSendList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		String[] idArr = CommonUtil.toStringArray(paramMap.get("ID_ARR").toString(), ",");
		String[] nmArr = CommonUtil.toStringArray(paramMap.get("NM_ARR").toString(), ",");
		List<Map<String, Object>> list = new ArrayList<>();
		for(int i=0;i<idArr.length;i++){
			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("mbrId", idArr[i]);
			resultMap.put("mbrNm", nmArr[i]);
			list.add(resultMap);
		}
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "mbrMmsTemp.action")
	public String mbrMmsTemp(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		paramMap.put("MSG_DIV_RC", "C");
		List<?> mbrMmsContList = popupService.mbrSmsTemp(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(mbrMmsContList));
		return "common/out";
	}

	@RequestMapping(value = "mbrEmailSendPop.do")
	public String mbrEmailSendPop(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		model.addAttribute("idArr", paramMap.get("ID_ARR"));
		model.addAttribute("nmArr", paramMap.get("NM_ARR"));
		String[] idArr = CommonUtil.toStringArray(paramMap.get("ID_ARR").toString(), ",");
		String[] nmArr = CommonUtil.toStringArray(paramMap.get("NM_ARR").toString(), ",");
		List<Map<String, Object>> list = new ArrayList<>();
		for(int i=0;i<idArr.length;i++){
			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("mbrId", idArr[i]);
			resultMap.put("mbrNm", nmArr[i]);
			list.add(resultMap);
		}
		model.addAttribute("mbrEmailList", list);
		paramMap.put("MSG_DIV_RC", "C");
		model.addAttribute("msgVariableList", commService.msgVariableList(paramMap));
		model.addAttribute("footerCont", popupService.footerCont(null));
		return IConstants.MNG_URI + "popup/mbrEmailSendPop";
	}

	@RequestMapping(value = "mbrEmailList.action")
	public String mbrEmailList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		String[] idArr = CommonUtil.toStringArray(paramMap.get("ID_ARR").toString(), ",");
		String[] nmArr = CommonUtil.toStringArray(paramMap.get("NM_ARR").toString(), ",");
		List<Map<String, Object>> list = new ArrayList<>();
		for(int i=0;i<idArr.length;i++){
			Map<String, Object> resultMap = new HashMap<>();
			resultMap.put("mbrId", idArr[i]);
			resultMap.put("mbrNm", nmArr[i]);
			list.add(resultMap);
		}
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "mbrTempList.action")
	public String mbrTempList(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model, commandMap);
		paramMap.put("MSG_DIV_RC", "C");
		List<?> list = popupService.mbrTempList(paramMap);
		model.addAttribute("outData", CommonUtil.listToJsonString(list));
		return "common/out";
	}

	@RequestMapping(value = "mbrEmailSendPop.action")
	public String mbrEmailSendPopA(@RequestParam Map<String, Object> commandMap, ModelMap model) throws Exception {
		UnCamelMap<String, Object> paramMap = init(model,commandMap);
		String[] idArr = CommonUtil.toStringArray(paramMap.get("ID_ARR").toString(), ",");
		List<String> mbrIdList = new ArrayList<String>();
		for(int i=0;i<idArr.length;i++){
			//popupService.mbrSendMail(idArr[i]);
			mbrIdList.add(idArr[i]);
		}
		paramMap.put("mbrIdList", mbrIdList);
		popupService.mbrEmailSend(paramMap);
		// 메일발송
		popupService.mbrSendMail(paramMap);
		return messageAction(egovMessageSource.getMessage("success.common.send"), "parent.$.fancybox.close(); ", model);
	}

}
