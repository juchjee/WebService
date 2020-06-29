package site.mng.amM4.amM403.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("AmM403DAO")
public class AmM403DAO extends EgovAbstractDAO {

	public List<?> amM403(UnCamelMap<String, Object> paramMap) throws Exception {
        return list("AmM403DAO.amM403", paramMap);
	}

	public Object amM403U(UnCamelMap<String, Object> paramMap) {
        return select("AmM403DAO.amM403",paramMap);
	}


}
