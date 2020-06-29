package site.sms.service.impl;

import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;

/**
 * SMS 디비 인서트를 위한 DAO
 * @author vary
 *
 */
@Repository("SmsDAO")
public class SmsDAO extends EgovAbstractDAO {

	/**
	 * SMS 디비 인서트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Object sendSms(Map<?, ?> params) throws Exception {
        return insert("SmsDAO.sendSms", params);
    }
	
	public Object mmsSend(Map<?, ?> params) throws Exception {
		return insert("SmsDAO.sendSms", params);
	}
	
	public int emTranMmsMaxMmsSeq() throws Exception {
		return (int) select("SmsDAO.emTranMmsMaxMmsSeq");
	}
	
}
