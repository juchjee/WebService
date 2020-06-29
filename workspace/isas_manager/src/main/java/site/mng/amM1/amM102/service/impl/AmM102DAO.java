package site.mng.amM1.amM102.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;

@Repository("AmM102DAO")
public class AmM102DAO extends BaseDAO {

	/**
	 * 회원관리 : 회원목록 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> selectAmM102(Map<String, Object> params) throws Exception {
		return list("AmM102DAO.selectAmM102", params);
	}
	
	public int selectCntAmM102(Map<String, Object> params) throws Exception {
		return (int) select("AmM102DAO.selectCntAmM102", params);
	}
	
	public int selectTodayCntAmM102(Map<String, Object> params) throws Exception {
		return (int) select("AmM102DAO.selectTodayCntAmM102", params);
	}
	
	public List<?> amM102(Map<String, Object> params) throws Exception {
		return list("AmM102DAO.amM102", params);
	}

	public int amM102S(Map<String, Object> params) throws Exception {
		return (int) select("AmM102DAO.amM102S", params);
	}

	public String amM102SS(Map<String, Object> params) throws Exception {
		return (String) select("AmM102DAO.amM102SS", params);
	}

	public List<?> amM102PLA(Map<String, Object> params) throws Exception {
		return list("AmM102DAO.amM102PLA", params);
	}

	/**
	 * 회원관리 : 회원목록 전체 카운트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int totalCount(Map<String, Object> params) throws Exception {
		return (int) select("AmM102DAO.totalCount", params);
	}

	/**
	 * 회원관리 : 회원목록 당일가입회원 카운트
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int nowCount(Map<String, Object> params) throws Exception {
		return (int) select("AmM102DAO.nowCount", params);
	}

	/**
	 * 회원관리 : 회원 종합 정보
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> mbrTotalInfo(String mbrId) throws Exception {
		return (Map<String, Object>) select("AmM102DAO.mbrTotalInfo", mbrId);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMbrInfo(String mbrId) throws Exception {
		return (Map<String, Object>) select("AmM102DAO.selectMbrInfo", mbrId);
	}
	
	/**
	 * 회원관리 : 1:1 문의 목록
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> selectAmM102P9(Map<String, Object> params) throws Exception {
		return list("AmM102DAO.selectAmM102P9", params);
	}
	
	/**
	 * 회원관리 : 1:1 문의 목록 개수
	 * @param params
	 * @return
	 * @throws Exception
	 */	
	public int selectCntAmM102P9(Map<String, Object> params) throws Exception {
		return (int) select("AmM102DAO.selectCntAmM102P9", params);
	}
	
	/**
	 * 회원관리 : 1:1 문의 목록 : 미처리 개수
	 * @param params
	 * @return
	 * @throws Exception
	 */	
	public int selectDelayCntAmM102P9(Map<String, Object> params) throws Exception {
		return (int) select("AmM102DAO.selectDelayCntAmM102P9", params);
	}
	
	/**
	 * 제품리스트
	 * @param params
	 * @return
	 * @throws Exception
	 */	
	public List<?> cateList(Map<String, Object> params) throws Exception {
		return list("AmM102DAO.cateList", params);
	}
	
	/**
	 * 상담유입경로 목록 (라디오버튼 생성용)
	 * @return
	 * @throws Exception
	 */
	public List<?> selectCsFunnel() throws Exception {
		return list("AmM102DAO.selectCsFunnel", null);
	}

	/**
	 * 상담유형 목록 (라디오버튼 생성용)
	 * @return
	 * @throws Exception
	 */
	public List<?> selectCsType() throws Exception {
		return list("AmM102DAO.selectCsType", null);
	}

	/**
	 * 회원관리 : 상담 & 문의 내역
	 * @param params
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public Map<String, Object> csInfo(String mbrId) throws Exception {
		return (Map<String, Object>) select("AmM102DAO.csInfo", mbrId);
	}

	public List<?> amM1023L(Map<String, Object> params) throws Exception {
		return list("AmM102DAO.amM1023L", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> amM1023SUM(Map<String, Object> params) throws Exception {
		return (Map<String, Object>) select("AmM102DAO.amM1023SUM", params);
	}

	public String totCopnDisAmt(Map<String, Object> params) throws Exception {
		return (String) select("AmM102DAO.totCopnDisAmt", params);
	}

	public List<?> amM1025usedCpn(Map<String, Object> params) throws Exception {
		return list("AmM102DAO.amM1025usedCpn", params);
	}

	public List<?> amM1025unUsedCpn(Map<String, Object> params) throws Exception {
		return list("AmM102DAO.amM1025unUsedCpn", params);
	}

	public List<?> amM1026L(Map<String, Object> params) throws Exception {
		return list("AmM102DAO.amM1026L", params);
	}

	public int amM1026TC(Map<String, Object> params) throws Exception {
		return (int) select("AmM102DAO.amM1026TC", params);
	}

	public int amM1026NC(Map<String, Object> params) throws Exception {
		return (int) select("AmM102DAO.amM1026NC", params);
	}

	public int amM1029TC(Map<String, Object> params) throws Exception {
		return (int) select("AmM102DAO.amM1029TC", params);
	}

	public int amM1029NC(Map<String, Object> params) throws Exception {
		return (int) select("AmM102DAO.amM1029NC", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> userInfo(String mbrId) throws Exception {
		return (Map<String, Object>) select("AmM102DAO.userInfo", mbrId);
	}
	
	public List<?> mCsList(Map<String, Object> params) throws Exception {
		return list("AmM102DAO.mCsList", params);
	}
	
	public List<?> mCsGuestList() throws Exception {
		return list("AmM102DAO.mCsGuestList");
	}
	
}
