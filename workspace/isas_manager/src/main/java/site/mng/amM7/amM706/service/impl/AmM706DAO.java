package site.mng.amM7.amM706.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;

@Repository("AmM706DAO")
public class AmM706DAO extends BaseDAO {

	/**
	 * 설정 : 게시판설정 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> amM706L(Map<String, Object> params) throws Exception {
		return list("AmM706DAO.amM706L", params);
	}

	public List<?> amM706TL(Map<String, Object> params) throws Exception {
		return list("AmM706DAO.amM706TL", params);
	}

	public List<?> amM706SL(Map<String, Object> params) throws Exception {
		return list("AmM706DAO.amM706SL", params);
	}

	public int amM706Count(Map<String, Object> params) throws Exception {
		return (int) select("AmM706DAO.amM706Count", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> amM706BD(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("AmM706DAO.amM706BD", params);
    }

	public List<?> amM706SML(Map<String, Object> params) throws Exception {
		return list("AmM706DAO.amM706SML", params);
	}

	public int amM706CC(Map<String, Object> params) throws Exception {
		return (int) select("AmM706DAO.amM706CC", params);
	}

	public List<?> amM706CL(Map<String, Object> params) throws Exception {
		return list("AmM706DAO.amM706CL", params);
	}

	public List<?> admMenuList() throws Exception {
		return list("AmM706DAO.admMenuList", null);
	}

}
