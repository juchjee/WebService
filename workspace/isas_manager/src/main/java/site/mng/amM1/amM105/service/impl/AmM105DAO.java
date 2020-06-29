package site.mng.amM1.amM105.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;

@Repository("AmM105DAO")
public class AmM105DAO extends BaseDAO {

	public List<?> amM105(Map<String, Object> params) throws Exception {
		return list("AmM105DAO.amM105", params);
	}
}
