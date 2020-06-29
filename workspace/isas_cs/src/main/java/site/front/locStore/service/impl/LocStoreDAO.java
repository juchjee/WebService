package site.front.locStore.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("LocStoreDAO")
public class LocStoreDAO extends EgovAbstractDAO {

	public List<?> selectMapList(Map<String, Object> params) throws Exception{
		return list("MapDAO.selectMapList", params);
    }
	
	public List<?> zipcodeSearchLev1() {
		return list("MapDAO.zipcodeSearchLev1", null);
	}

	public int totalMapListCount(Map<String, Object> params) throws Exception {
		return (int) select("MapDAO.totalMapListCount", params);
	}
	
	public List<?> zipcodeSearchLev2(UnCamelMap<String, Object> paramMap) {
		return list("MapDAO.zipcodeSearchLev2", paramMap);
	}
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> selectMapView(Map<String, Object> paramMap) throws Exception {
        return (Map<String, Object>) select("MapDAO.selectMapView", paramMap);
    }
	
}
