package site.mng.amM7.amM704.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;

@Repository("AmM704DAO")
public class AmM704DAO extends BaseDAO {

	public List<?> amM704(Map<String, Object> params) throws Exception {
        return list("AmM704DAO.amM704", params);
    }

	public List<?> amM704A(Map<String, Object> params) throws Exception {
        return list("AmM704DAO.amM704A", params);
    }

	public List<?> amM704P(Map<String, Object> params) throws Exception {
        return list("AmM704DAO.amM704P", params);
    }

	/**  **/
	@SuppressWarnings("unchecked")
	public Map<String, Object> amM704PD(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("AmM704DAO.amM704PD", params);
    }

}
