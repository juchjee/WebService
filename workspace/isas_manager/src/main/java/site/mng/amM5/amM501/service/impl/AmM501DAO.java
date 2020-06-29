package site.mng.amM5.amM501.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;

@Repository("AmM501DAO")
public class AmM501DAO extends BaseDAO {

	public List<?> amM501L(Map<String, Object> params) throws Exception {
        return list("AmM501DAO.amM501L", params);
    }

	public List<?> amM501FL(Map<String, Object> params) throws Exception {
        return list("AmM501DAO.amM501FL", params);
    }

	public List<?> amM501TL(Map<String, Object> params) throws Exception {
        return list("AmM501DAO.amM501TL", params);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> amM501R(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("AmM501DAO.amM501R", params);
    }

}
