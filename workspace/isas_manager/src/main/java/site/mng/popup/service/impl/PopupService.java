package site.mng.popup.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.Resource;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.stereotype.Service;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.service.impl.BaseService;
import egovframework.cmmn.util.CommonUtil;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CommService;
import site.sms.service.impl.SmsService;

@Service("PopupService")
public class PopupService extends BaseService implements IConstants{
	/** PopupDAO */
	@Resource(name = "PopupDAO")
	private PupupDAO popupDAO;

	@Resource(name = "SmsService")
	private SmsService smsService;

	/** 공통 서비스 */
	@Resource(name = "CommService")
    protected CommService commService;

	public String msgRollCode() {
		return popupDAO.msgRollCode();
	}

	public List<?> msgRollMgtPopA(UnCamelMap<String, Object> paramMap) {
		return popupDAO.msgRollMgtPopA(paramMap);
	}

	public String conditionSearchCount(UnCamelMap<String, Object> paramMap) {
		return popupDAO.conditionSearchCount(paramMap);
	}

	public List<?> conditionSearch(UnCamelMap<String, Object> paramMap) {
		return popupDAO.conditionSearch(paramMap);
	}

	public CamelMap<String, Object> sendCont(Object paramMap) {
		return popupDAO.sendCont(paramMap);
	}

	public int smsContMaxLen(UnCamelMap<String, Object> paramMap) {
		return popupDAO.smsContMaxLen(paramMap);
	}

	public void smsSend(UnCamelMap<String, Object> paramMap) throws Exception {

		paramMap.put("tranCallback", SMS_SEND_PHONE);
		paramMap.put("tranStatus", "1");
		popupDAO.smsSend(paramMap);

//		paramMap.put("msgSendSeq",commService.getPrSeq("MSG_SEND_SEQ"));
//
//		Map<String, Object> matchingColumName = new HashMap<String, Object>();
//		matchingColumName.put("REG_MBR_ID", "$iui");
//		matchingColumName.put("REG_DT", "$idate");
//
//		commService.tableInatall("E_MSG_SEND_HIS", paramMap, matchingColumName);
//
//		popupDAO.smsSendInfoHis(paramMap);
	}

	public void mmsSendTempD() {
		popupDAO.mmsSendTempD();
	}

	public void mmsSendTempReseed() {
		popupDAO.mmsSendTempReseed();
	}

	public int eMmsTempMaxMmsSeq() throws Exception {
		return popupDAO.eMmsTempMaxMmsSeq();
	}

	public void mmsSendTempI(UnCamelMap<String, Object> paramMap) throws Exception {
		paramMap.put("fileCnt", "0");
		paramMap.put("tranCallback", SMS_SEND_PHONE);
		paramMap.put("tranStatus", "1");
		paramMap.put("tranType", 6);
		if(paramMap.getString("SMS_CONT").indexOf("##") > -1){
			paramMap.put("isVariableCont", "Y");
		}else{
			paramMap.put("isVariableCont", "N");
		}
		if(paramMap.getString("MMS_SUB").indexOf("##") > -1){
			paramMap.put("isVariableSub", "Y");
		}else{
			paramMap.put("isVariableSub", "N");
		}
		popupDAO.mmsSendTempI(paramMap);
		//popupDAO.mmsSendTempI(paramMap);

		/*popupDAO.smsSend(paramMap);

		paramMap.put("msgSendSeq",commService.getPrSeq("MSG_SEND_SEQ"));

		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("REG_MBR_ID", "$iui");
		matchingColumName.put("REG_DT", "$idate");

		commService.tableInatall("E_MSG_SEND_HIS", paramMap, matchingColumName);

		popupDAO.smsSendInfoHis(paramMap);*/
	}

	public void emTranMmsSend() throws Exception {
		popupDAO.emTranMmsSend();
	}

	public void mmsSendTempU(Map<String, Object> seqMap) throws Exception {
		popupDAO.mmsSendTempU(seqMap);
	}

	public void mmsSend() throws Exception {
		popupDAO.mmsSend();
	}

	public void emailSend(UnCamelMap<String, Object> paramMap) throws Exception {
		//MailHelper mailHelper = new MailHelper(commService, popupDAO);
		String msgSendSeq = CommonUtil.nvl(commService.getPrSeq("MSG_SEND_SEQ"));
		paramMap.put("MSG_SEND_SEQ", msgSendSeq);

		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("REG_MBR_ID", "$iui");
		matchingColumName.put("REG_DT", "$idate");

		paramMap.put("MAIL_TITLE_HIS",paramMap.getString("MAIL_TITLE"));
		paramMap.put("MAIL_CONT_HIS",paramMap.getString("MAIL_CONT")+paramMap.getString("MAIL_FOOTER_CONT"));
		paramMap.put("MSG_VARIABLE_LIST",commService.msgVariableList(paramMap)); //메일에 치환 변수값을 조회하여 인자에 삽입한다.
//		commService.tableInatall("E_MSG_SEND_HIS", paramMap, matchingColumName);

		commService.tableInatall("E_MAIL_SEND_INFO_MST_HIS", paramMap, null);
		popupDAO.emailSendInfoHis(paramMap);
		//mailHelper.setSendMail();
		Map<String, Object> recvUpParams = new HashMap<>();
		recvUpParams.put("msgSendSeq", msgSendSeq);
		//recvUpParams.put("recvCd", mailHelper.getRecvCode());
		//recvUpParams.put("recvMsg", mailHelper.getRecvMsg());
		popupDAO.updateMailSendInfoMstHisRecv(recvUpParams);
	}

	public String getMailHoldingCount() {
		return popupDAO.getMailHoldingCount();
	}

	public List<?> mbrSmsTemp(UnCamelMap<String, Object> paramMap) {
		return popupDAO.mbrSmsTemp(paramMap);
	}

	public void mbrSmsSend(UnCamelMap<String, Object> paramMap) throws Exception {

		paramMap.put("tranCallback", SMS_SEND_PHONE);
		paramMap.put("tranStatus", "1");
		popupDAO.mbrSmsSend(paramMap);
		paramMap.put("MSG_SEND_SEQ",commService.getPrSeq("MSG_SEND_SEQ"));
		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("REG_MBR_ID", "$iui");
	    matchingColumName.put("REG_DT", "$idate");
//		commService.tableInatall("E_MSG_SEND_HIS", paramMap, matchingColumName);
		popupDAO.mbrSmsSendInfoHis(paramMap);
	}

	public Map<String, Object> footerCont(Map<String, Object> params) throws Exception {
		return popupDAO.footerCont(params);
	}

	public List<?> mbrTempList(UnCamelMap<String, Object> paramMap) {
		return popupDAO.mbrTempList(paramMap);
	}

	public void mbrMmsSendTempI(UnCamelMap<String, Object> paramMap) throws Exception {
		paramMap.put("fileCnt", "0");
		paramMap.put("tranCallback", SMS_SEND_PHONE);
		paramMap.put("tranStatus", "1");
		paramMap.put("tranType", 6);
		if(paramMap.getString("SMS_CONT").indexOf("##") > -1){
			paramMap.put("isVariableCont", "Y");
		}else{
			paramMap.put("isVariableCont", "N");
		}
		if(paramMap.getString("MMS_SUB").indexOf("##") > -1){
			paramMap.put("isVariableSub", "Y");
		}else{
			paramMap.put("isVariableSub", "N");
		}
		popupDAO.mbrMmsSendTempI(paramMap);
		//popupDAO.mmsSendTempI(paramMap);

		/*popupDAO.smsSend(paramMap);

		paramMap.put("msgSendSeq",commService.getPrSeq("MSG_SEND_SEQ"));

		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("REG_MBR_ID", "$iui");
		matchingColumName.put("REG_DT", "$idate");

		commService.tableInatall("E_MSG_SEND_HIS", paramMap, matchingColumName);

		popupDAO.smsSendInfoHis(paramMap);*/
	}

	public void mbrMmsSend() throws Exception {
		popupDAO.mbrMmsSend();
	}

	public void mbrEmailSend(UnCamelMap<String, Object> paramMap) throws Exception {
		String msgSendSeq = CommonUtil.nvl(commService.getPrSeq("MSG_SEND_SEQ"));
		paramMap.put("MSG_SEND_SEQ", msgSendSeq);

		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("REG_MBR_ID", "$iui");
		matchingColumName.put("REG_DT", "$idate");

		paramMap.put("MAIL_TITLE_HIS",paramMap.getString("MAIL_TITLE"));
		paramMap.put("MAIL_CONT_HIS",paramMap.getString("MAIL_CONT")+paramMap.getString("MAIL_FOOTER"));
		paramMap.put("MSG_DIV_RC", "C");
		paramMap.put("MSG_VARIABLE_LIST",commService.msgVariableList(paramMap)); //메일에 치환 변수값을 조회하여 인자에 삽입한다.
//		commService.tableInatall("E_MSG_SEND_HIS", paramMap, matchingColumName);
		commService.tableInatall("E_MAIL_SEND_INFO_MST_HIS", paramMap, null);
		popupDAO.mbrEmailSendInfoHis(paramMap);
	}

	@SuppressWarnings("unchecked")
	public void mbrSendMail(UnCamelMap<String, Object> paramMap) throws Exception{

//		String host = "58.229.234.98";
//		String host = "58.229.234.102";
		String host = "localhost";
		String from = "help@i6-shop.com";
        int port=25;
        List<?> mailInfoList = popupDAO.mbrSmtpMailList(paramMap);
        CamelMap<String, Object> mailMap = new CamelMap<String, Object>();
        String subject = CommonUtil.getHtmlStrCnvr(paramMap.getString("MAIL_TITLE"));

    	if(!paramMap.getString("MAIL_CONT").equals("")){
	       for(int i=0;i<mailInfoList.size();i++){
	    	   mailMap = (CamelMap<String, Object>) mailInfoList.get(i);
	    	   String recipient = mailMap.getString("mbrEmail");
	    	   String body = CommonUtil.getHtmlStrCnvr(mailMap.getString("mailCont"));
	    	   Properties props = System.getProperties();
	           props.put("mail.transport.protocol", "smtp");
	           props.put("mail.smtp.host", host);
	           props.put("mail.smtp.port", port);
	           props.put("mail.smtp.auth", "true");
	           props.put("mail.smtp.ssl.enable", "false");
	           props.put("mail.smtp.ssl.trust", host);
	           props.put("mail.smtp.starttls.enable", "true");
	           Session session = Session.getDefaultInstance(props, null);
	           session.setDebug(true); //for debug
	           Message mimeMessage = new MimeMessage(session);
	           mimeMessage.setFrom(new InternetAddress(from));
	           mimeMessage.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
	           mimeMessage.setSubject(subject);
	           mimeMessage.setContent(body, "text/html; charset=UTF-8");
//	           Transport.send(mimeMessage);
	       }
    	}
    }

}
