package site.front.user.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.CamelMap;

@Repository("UserDAO")
public class UserDAO extends EgovAbstractDAO {

	public List<?> selectAuthorList() throws Exception {
        return list("UserDAO.selectAuthorList", null);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> mypageUser(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("UserDAO.mypageUser", params);
    }

	public int totalAmt(Map<String, Object> params) throws Exception {
		return (int) select("UserDAO.totalAmt", params);
	}

	public List<?> mypageAdvice(Map<String, Object> params) throws Exception {
        return list("UserDAO.mypageAdvice", params);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> mypageAfter(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("UserDAO.mypageAfter", params);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> mypageOrderCnt(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("UserDAO.mypageOrderCnt", params);
    }

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> mypageOrder(Map<String, Object> params) throws Exception {
        return (List<Map<String, Object>>) list("UserDAO.mypageOrder", params);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> mypageOrderSingle(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("UserDAO.mypageOrder", params);
    }

	public List<?> mypageWishList(Map<String, Object> params) throws Exception {
        return list("UserDAO.mypageWishList", params);
    }

	public int mypagePointCnt(Map<String, Object> params) throws Exception {
		return (int) select("UserDAO.mypagePointCnt", params);
	}

	public List<?> mypagePoint(Map<String, Object> params) throws Exception {
        return list("UserDAO.mypagePoint", params);
    }

	public List<?> mypageCoupon(Map<String, Object> params) throws Exception {
        return list("UserDAO.mypageCoupon", params);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> mypageTransY(String mbrId) throws Exception {
        return (Map<String, Object>) select("UserDAO.mypageTransY", mbrId);
    }

	public List<?> mypageTransList(Map<String, Object> params) throws Exception {
        return list("UserDAO.mypageTransList", params);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> transView(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("UserDAO.transView", params);
    }

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> prodInfoList(String orderNo) {
        return (List<Map<String, Object>>) list("UserDAO.prodInfoList", orderNo);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> claimInfoList(String orderNo) {
        return (List<Map<String, Object>>) list("UserDAO.claimInfoList", orderNo);
	}

	public int getOrderTotalAmt(Map<String, Object> params) throws Exception {
		return (int) select("UserDAO.getOrderTotalAmt", params);
	}

	@SuppressWarnings("unchecked")
	public CamelMap<String, Object> getMyInfoMap(String mbrId) throws Exception {
		return (CamelMap<String, Object>) select("UserDAO.getMyInfoMap", mbrId);
	}

	@SuppressWarnings("unchecked")
	public  CamelMap<String, Object> orderAddr(String orderNo) {
		return (CamelMap<String, Object>) select("UserDAO.getOrderAddr", orderNo);
	}

	public String addrClaimCheck(String ORDER_NO) {
		return  (String) select("UserDAO.addrClaimCheck",  ORDER_NO);
	}

}
