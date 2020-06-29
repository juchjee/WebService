package site.mng.amM7.amM701.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;

@Repository("AmM701DAO")
public class AmM701DAO extends BaseDAO {

	/** 카테고리 관리 : 상세페이지(수정) **/
	@SuppressWarnings("unchecked")
	public Map<String, Object> amM701Com(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("AmM701DAO.amM701Com", params);
    }

	/** **/
	public List<?> amM701O(Map<String, Object> params) throws Exception {
        return list("AmM701DAO.amM701O", params);
    }
}
