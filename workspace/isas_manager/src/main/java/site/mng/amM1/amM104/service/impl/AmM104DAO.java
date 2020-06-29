package site.mng.amM1.amM104.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;

@Repository("AmM104DAO")
public class AmM104DAO extends BaseDAO {

	public List<?> amM104(Map<String, Object> params) throws Exception {
		return list("AmM104DAO.amM104", params);
	}

	public int dCount(Map<String, Object> params) throws Exception {
		return (int) select("AmM104DAO.dCount", params);
	}

}
