package site.mng.popup.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("PopupDAO")
public class PupupDAO extends BaseDAO {



	public String msgRollCode() {
		return (String) select("PopupDAO.msgRollCode",null );
	}

	/**
	 * @param paramMap
	 * @return
	 */
	public List<?> msgRollMgtPopA(UnCamelMap<String, Object> paramMap) {
		return list("PopupDAO.msgRollMgtPopA", paramMap);
	}

	/**
	 * @param paramMap
	 * @return
	 */
	public String conditionSearchCount(UnCamelMap<String, Object> paramMap) {
		return (String) select("PopupDAO.conditionSearchCount", paramMap);
	}

	/**
	 * @param paramMap
	 * @return
	 */
	public List<?> conditionSearch(UnCamelMap<String, Object> paramMap) {
		return list("PopupDAO.conditionSearch", paramMap);
	}

	/**
	 * @param paramMap
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public CamelMap<String, Object> sendCont(Object paramMap) {
		return (CamelMap<String, Object>) select("PopupDAO.smsSendCont", paramMap);
	}

	public int smsContMaxLen(UnCamelMap<String, Object> paramMap) {
		return (int) select("PopupDAO.smsContMaxLen", paramMap);
	}

	/**
	 * @param paramMap
	 */
	public void smsSend(UnCamelMap<String, Object> paramMap) {
		insert("PopupDAO.smsSend", paramMap);
	}

	/**
	 * @param paramMap
	 */
	public void mmsSendTempD() {
		delete("PopupDAO.mmsSendTempD");
	}

	public Object mmsSendTempReseed() {
		return update("PopupDAO.mmsSendTempReseed");
	}

	public Object mmsSendTempU(Map<String, Object> seqMap) {
		return update("PopupDAO.mmsSendTempU", seqMap);
	}

	public int eMmsTempMaxMmsSeq() throws Exception {
		return (int) select("PopupDAO.eMmsTempMaxMmsSeq");
	}

	/**
	 * @param paramMap
	 */
	public void mmsSend() {
		insert("PopupDAO.mmsSend");
	}

	/**
	 * @param paramMap
	 */
	public void mmsSendTempI(UnCamelMap<String, Object> paramMap) {
		insert("PopupDAO.mmsSendTempI", paramMap);
	}

	/**
	 * @param paramMap
	 */
	public void emTranMmsSend() {
		insert("PopupDAO.emTranMmsSend");
	}

	/**
	 * @param paramMap
	 */
	public void smsSendInfoHis(UnCamelMap<String, Object> paramMap) {
		insert("PopupDAO.smsSendInfoHis", paramMap);

	}
	/**
	 * @param paramMap
	 */
	public void emailSendInfoHis(UnCamelMap<String, Object> paramMap) {
		insert("PopupDAO.emailSendInfoHis", paramMap);
	}


	@SuppressWarnings("unchecked")
	public CamelMap<String, Object> getCompanyMap() throws Exception {
		return (CamelMap<String, Object>) select("PopupDAO.getCompanyMap");
	}

	public String getMailHoldingCount() {
		return (String) select("PopupDAO.getMailHoldingCount");
	}

	@SuppressWarnings("unchecked")
	public CamelMap<String, Object> getMailSendInfoMstHis(){
		return (CamelMap<String, Object>) select("PopupDAO.getMailSendInfoMstHis");
	}

	public Object updateMailSendInfoMstHisRecv(Map<String, Object> params){
		return update("PopupDAO.updateMailSendInfoMstHisRecv", params);
	}

	public List<?> mbrSmsTemp(UnCamelMap<String, Object> paramMap) {
		return list("PopupDAO.mbrSmsTemp", paramMap);
	}

	public void mbrSmsSend(UnCamelMap<String, Object> paramMap) {
		insert("PopupDAO.mbrSmsSend", paramMap);
	}

	public void mbrSmsSendInfoHis(UnCamelMap<String, Object> paramMap) {
		insert("PopupDAO.mbrSmsSendInfoHis", paramMap);

	}

	public List<?> mbrTempList(UnCamelMap<String, Object> paramMap) {
		return list("PopupDAO.mbrTempList", paramMap);
	}

	public void mbrMmsSendTempI(UnCamelMap<String, Object> paramMap) {
		insert("PopupDAO.mbrMmsSendTempI", paramMap);
	}

	public void mbrMmsSend() {
		insert("PopupDAO.mbrMmsSend");
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> footerCont(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("PopupDAO.footerCont", params);
    }

	/**
	 * @param paramMap
	 */
	public void mbrEmailSendInfoHis(UnCamelMap<String, Object> paramMap) {
		insert("PopupDAO.mbrEmailSendInfoHis", paramMap);
	}

	public List<?> mbrSmtpMailList(UnCamelMap<String, Object> paramMap) {
		return list("PopupDAO.mbrSmtpMailList", paramMap);
	}

}
