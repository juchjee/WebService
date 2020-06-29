package site.mng.amM4.amM406.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("AmM406DAO")
public class AmM406DAO extends EgovAbstractDAO {

	public List<?> eBanner(Map<String, Object> params) throws Exception {
        return list("AmM406DAO.eBanner", params);
    }
	
	public List<?> eBannerList(UnCamelMap<String, Object> paramMap) throws Exception {
		return list("AmM406DAO.eBannerList", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public CamelMap<String, Object> eBannerListMap(UnCamelMap<String, Object> paramMap) throws Exception {
		return (CamelMap<String, Object>) select("AmM406DAO.eBannerList", paramMap);
	}

}
