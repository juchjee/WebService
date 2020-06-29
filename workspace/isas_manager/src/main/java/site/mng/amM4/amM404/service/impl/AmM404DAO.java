package site.mng.amM4.amM404.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("AmM404DAO")
public class AmM404DAO extends EgovAbstractDAO {

	public List<?> amM404(UnCamelMap<String, Object> paramMap) throws Exception {
        return list("AmM404DAO.amM404", paramMap);
	}

	public Object amM404U(UnCamelMap<String, Object> paramMap) {
        return select("AmM404DAO.amM404",paramMap);
	}


}
