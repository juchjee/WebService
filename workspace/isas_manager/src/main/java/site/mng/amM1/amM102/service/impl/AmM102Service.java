package site.mng.amM1.amM102.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;

@Service("AmM102Service")
public class AmM102Service extends BaseService{

	/** CbtsIaAmDAO */
	@Resource(name = "AmM102DAO")
	private AmM102DAO amM102DAO;

	/**
	 * 회원관리 : 회원목록 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	
	public List<?> selectAmM102(Map<String, Object> params) throws Exception {
		return amM102DAO.selectAmM102(params);
	}
	
	public int selectCntAmM102(Map<String, Object> params) throws Exception {
		return amM102DAO.selectCntAmM102(params);
	}
	
	public int selectTodayCntAmM102(Map<String, Object> params) throws Exception {
		return amM102DAO.selectTodayCntAmM102(params);
	}
	
	public List<?> amM102(Map<String, Object> params) throws Exception {
		return amM102DAO.amM102(params);
    }

	public int amM102S(Map<String, Object> params) throws Exception {
		return amM102DAO.amM102S(params);
	}

	public String amM102SS(Map<String, Object> params) throws Exception {
		return amM102DAO.amM102SS(params);
	}

	public List<?> amM102PLA(Map<String, Object> params) throws Exception {
		return amM102DAO.amM102PLA(params);
    }


	/**
	 * 회원관리 : 회원목록 전체 카운트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int totalCount(Map<String, Object> params) throws Exception {
		return amM102DAO.totalCount(params);
	}

	/**
	 * 회원관리 : 회원목록 당일가입회원 카운트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int nowCount(Map<String, Object> params) throws Exception {
		return amM102DAO.nowCount(params);
	}

	/**
	 * 회원관리 : 회원 종합 정보
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> selectMbrInfo(String mbrId) throws Exception {
		return amM102DAO.selectMbrInfo(mbrId);
	}
	
	public Map<String, Object> mbrTotalInfo(String mbrId) throws Exception {
		return amM102DAO.mbrTotalInfo(mbrId);
	}
	
	/**
	 * 회원관리 : 1:1 문의 목록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> selectAmM102P9(Map<String, Object> params) throws Exception {
		return amM102DAO.selectAmM102P9(params);
	}
	
	/**
	 * 회원관리 : 1:1 문의 목록 개수
	 * @param params
	 * @return
	 * @throws Exception
	 */	
	public int selectCntAmM102P9(Map<String, Object> params) throws Exception {
		return amM102DAO.selectCntAmM102P9(params);
	}
	
	/**
	 * 회원관리 : 1:1 문의 목록 : 미처리 개수
	 * @param params
	 * @return
	 * @throws Exception
	 */	
	public int selectDelayCntAmM102P9(Map<String, Object> params) throws Exception {
		return amM102DAO.selectDelayCntAmM102P9(params);
	}
	
	/**
	 * 제품리스트
	 * @param params
	 * @return
	 * @throws Exception
	 */	
	public List<?> cateList(Map<String, Object> params) throws Exception {
		return amM102DAO.cateList(params);
	}

	/**
	 * 상담유입경로 목록 (라디오버튼 생성용)
	 * @return
	 * @throws Exception
	 */
	public List<?> selectCsFunnel() throws Exception {
		return amM102DAO.selectCsFunnel();
	}

	/**
	 * 상담유형 목록 (라디오버튼 생성용)
	 * @return
	 * @throws Exception
	 */
	public List<?> selectCsType() throws Exception {
		return amM102DAO.selectCsType();
	}

	/**
	 * 회원관리 : 상담 & 문의 내역
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public Map<String, Object> csInfo(String mbrId) throws Exception {
		return amM102DAO.csInfo(mbrId);
	}

	public List<?> amM1023L(Map<String, Object> params) throws Exception {
		return amM102DAO.amM1023L(params);
    }

	public Map<String, Object> amM1023SUM(Map<String, Object> params) throws Exception {
		return amM102DAO.amM1023SUM(params);
	}

	/**
	 * 회원정보 팝업 > 사용된 쿠폰내역 > 총 할인 금액
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public String totCopnDisAmt(Map<String, Object> params) throws Exception {
		return amM102DAO.totCopnDisAmt(params);
	}

	/**
	 * 회원정보 팝업 > 사용된 쿠폰내역
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> amM1025usedCpn(Map<String, Object> params) throws Exception {
		return amM102DAO.amM1025usedCpn(params);
	}
	/**
	 * 회원정보 팝업 > 미사용 쿠폰내역
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> amM1025unUsedCpn(Map<String, Object> params) throws Exception {
		return amM102DAO.amM1025unUsedCpn(params);
	}

	public List<?> amM1026L(Map<String, Object> params) throws Exception {
		return amM102DAO.amM1026L(params);
    }

	public int amM1026TC(Map<String, Object> params) throws Exception {
		return amM102DAO.amM1026TC(params);
	}

	public int amM1026NC(Map<String, Object> params) throws Exception {
		return amM102DAO.amM1026NC(params);
	}

	public int amM1029TC(Map<String, Object> params) throws Exception {
		return amM102DAO.amM1029TC(params);
	}

	public int amM1029NC(Map<String, Object> params) throws Exception {
		return amM102DAO.amM1029NC(params);
	}

	public Map<String, Object> userInfo(String mbrId) throws Exception {
		return amM102DAO.userInfo(mbrId);
	}
	
	public List<?> mCsList(Map<String, Object> params) throws Exception {
		return amM102DAO.mCsList(params);
    }
	
	public List<?> mCsGuestList() throws Exception {
		return amM102DAO.mCsGuestList();
	}
	
}
