package site.sms.service.impl;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.IConstants;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CommDAO;

/**
 * SMS 디비 인서트를 위한 서비스
 * @author vary
 *
 */
@Service("SmsService")
public class SmsService extends EgovAbstractServiceImpl implements IConstants{

	/** SmsDAO */
	@Resource(name = "SmsDAO")
	private SmsDAO smsDAO;

	/** CommDAO */
	@Resource(name = "CommDAO")
	private CommDAO commDAO;

	/**
	 * 비밀 번호 찼기 SMS 인서트
	 * @param mbrMobile
	 * @param newPW
	 * @return
	 * @throws Exception
	 */
	public Object sendPWSms(String mbrMobile, String newPW) throws Exception {
		Map<String, String> msmParams = new HashMap<>();
		msmParams.put("tran_phone", mbrMobile);
		msmParams.put("tran_callback", SMS_SEND_PHONE);
		msmParams.put("tran_status", "1");
		msmParams.put("tran_msg", "[I6SHOP] 고객님의 임시 비밀번호 : "+newPW+" / 로그인 후 수정 권장");
        return smsDAO.sendSms(msmParams);
    }

	/**
	 * SMS 인서트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Object sendSms(Map<?, ?> params) throws Exception {
        return smsDAO.sendSms(params);
    }

	/**
	 * SMS Template을 이용한 SMS 인서트
	 * @param params
	 * @param MSG_ROLE_CD
	 * @return
	 * @throws Exception
	 */
	public Object sendTemplateSms(Map<String, String> params) throws Exception {
		params.put("tran_callback", SMS_SEND_PHONE);
		params.put("tran_status", "1");

		return null;
	}
	
	public int emTranMmsMaxMmsSeq() throws Exception {
		return smsDAO.emTranMmsMaxMmsSeq();
	}
	
	/**
	 * 비밀 번호 찼기 SMS 인서트
	 * @param mbrMobile
	 * @param newPW
	 * @return
	 * @throws Exception [I6SHOP] 고객님의 임시 비밀번호 : ## 패스워드 ## / 로그인 후 수정 권장
	 */
	public Object sendPWSms(UnCamelMap<String, Object> smsMailMap, String newPW) throws Exception {
		CamelMap<String, Object> smsTemplate = commDAO.mbrSmsCont(smsMailMap);
		String conText = smsTemplate.getString("smsCont");
		conText = conText.replace("## 임시비밀번호 ##", newPW);
		Map<String, String> msmParams = new HashMap<>();
		msmParams.put("tran_phone", smsMailMap.getString("MBR_MOBILE"));
		msmParams.put("tran_callback", SMS_SEND_PHONE);
		msmParams.put("tran_status", "1");
		msmParams.put("tran_msg", conText);
        return smsDAO.sendSms(msmParams);
    }
	
}
