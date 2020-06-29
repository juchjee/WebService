package site.mng.amM4.amM405.service.impl;

import java.util.List;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("AmM405DAO")
public class AmM405DAO extends EgovAbstractDAO {

	public List<?> amM405Search(UnCamelMap<String, Object> paramMap) {
        return list("AmM405DAO.amM405Search", paramMap);
	}

	public Object amM405View(UnCamelMap<String, Object> paramMap) {
        return select("AmM405DAO.amM405View", paramMap);
	}

}
