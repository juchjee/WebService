package site.mng.amM1.amM103.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;

@Repository("AmM103DAO")
public class AmM103DAO extends BaseDAO {

	public List<?> amM103(Map<String, Object> params) throws Exception {
		return list("AmM103DAO.amM103", params);
	}

	public int hCount(Map<String, Object> params) throws Exception {
		return (int) select("AmM103DAO.hCount", params);
	}
}
