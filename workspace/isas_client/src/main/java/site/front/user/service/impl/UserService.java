package site.front.user.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.util.CommonUtil;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CommService;

@Service("UserService")
public class UserService extends EgovAbstractServiceImpl{

	/** UserDAO */
	@Resource(name = "UserDAO")
	private UserDAO userDAO;

	/** 공통 서비스 */
	@Resource(name = "CommService")
	protected CommService commService;

	public List<?> selectAuthorList() throws Exception {
        return userDAO.selectAuthorList();
    }

	public Map<String, Object> mypageUser(Map<String, Object> params) throws Exception {
		return userDAO.mypageUser(params);
	}

	public int totalAmt(Map<String, Object> params) throws Exception {
		return userDAO.totalAmt(params);
	}

	public List<?> mypageAdvice(Map<String, Object> params) throws Exception {
        return userDAO.mypageAdvice(params);
    }

	public Map<String, Object> mypageAfter(Map<String, Object> params) throws Exception {
		return userDAO.mypageAfter(params);
	}

	public Map<String, Object> mypageOrderCnt(Map<String, Object> params) throws Exception {
		return userDAO.mypageOrderCnt(params);
	}

	public List<Map<String, Object>> mypageOrder(Map<String, Object> params) throws Exception {
        return userDAO.mypageOrder(params);
    }

	public Map<String, Object> mypageOrderSingle(Map<String, Object> params) throws Exception {
        return userDAO.mypageOrderSingle(params);
    }

	public List<?> mypageWishList(Map<String, Object> params) throws Exception {
        return userDAO.mypageWishList(params);
    }

	public int mypagePointCnt(Map<String, Object> params) throws Exception {
		return userDAO.mypagePointCnt(params);
	}

	public List<?> mypagePoint(Map<String, Object> params) throws Exception {
        return userDAO.mypagePoint(params);
    }

	public List<?> mypageCoupon(Map<String, Object> params) throws Exception {
        return userDAO.mypageCoupon(params);
    }

	public Map<String, Object> mypageTransY(String mbrId) throws Exception {
		return userDAO.mypageTransY(mbrId);
	}

	public List<?> mypageTransList(Map<String, Object> params) throws Exception {
        return userDAO.mypageTransList(params);
    }

	public Map<String, Object> transView(Map<String, Object> params) throws Exception {
		return userDAO.transView(params);
	}

	public List<Map<String, Object>>  prodInfoList(String orderNo) {
		return userDAO.prodInfoList(orderNo);
	}
	public List<Map<String, Object>>  claimInfoList(String orderNo) {
		return userDAO.claimInfoList(orderNo);
	}

	public int getOrderTotalAmt(Map<String, Object> params) throws Exception {
		return userDAO.getOrderTotalAmt(params);
	}

	public CamelMap<String, Object> getMyInfoMap(String mbrId) throws Exception{
    	return userDAO.getMyInfoMap(mbrId);
    }

	public CamelMap<String, Object> orderAddr(String orderNo) {
    	return userDAO.orderAddr(orderNo);
	}


	public boolean addrSave(UnCamelMap<String, Object> paramMap) throws Exception {
		Map<String, Object> receiptAddrMap = new HashMap<String, Object>();
		String addrClaimCheck = userDAO.addrClaimCheck(paramMap.getString("ORDER_NO"));

		if(CommonUtil.nvl(addrClaimCheck).equals("")){
			receiptAddrMap.put("RECEIPT_NM", paramMap.getString("RECEIPT_NM"));

			String receiptMobile1 = paramMap.getString("RECEIPT_MOBILE1");
			String receiptMobile2 = paramMap.getString("RECEIPT_MOBILE2");
			String receiptMobile3 = paramMap.getString("RECEIPT_MOBILE3");

			String receiptTel1 = paramMap.getString("RECEIPT_TEL1");
			String receiptTel2 = paramMap.getString("RECEIPT_TEL2");
			String receiptTel3 = paramMap.getString("RECEIPT_TEL3");

			if(!receiptMobile1.equals("") && !receiptMobile2.equals("") && !receiptMobile3.equals("")){
				receiptAddrMap.put("RECEIPT_MOBILE", receiptMobile1 +"-"+receiptMobile2+"-"+receiptMobile3);
			}

			if(!receiptTel1.equals("") && !receiptTel2.equals("") && !receiptTel3.equals("")){
				receiptAddrMap.put("RECEIPT_TEL", receiptTel1 +"-"+receiptTel2+"-"+receiptTel3);
			}

			receiptAddrMap.put("RECEIPT_ZIPCODE", paramMap.getString("RECEIPT_ZIPCODE"));
			receiptAddrMap.put("RECEIPT_ADDR", paramMap.getString("RECEIPT_ADDR"));

			if(!paramMap.getString("RECEIPT_ADDR_DTL").equals("")){
				receiptAddrMap.put("RECEIPT_ADDR_DTL", paramMap.getString("RECEIPT_ADDR_DTL"));
			}
			if(!paramMap.getString("RECEIPT_REQ_CONT").equals("")){
				receiptAddrMap.put("RECEIPT_REQ_CONT", paramMap.getString("RECEIPT_REQ_CONT"));
			}


			Map<String, Object> matchingColumName = new HashMap<String, Object>();
			commService.tableUpdate("O_RECEIPT_ADDR", receiptAddrMap, matchingColumName, null,
					" and ORDER_NO = '" + paramMap.getString("ORDER_NO") + "'", null);

		return true;

		 }else{
			 return false;
		 }
	}


}
