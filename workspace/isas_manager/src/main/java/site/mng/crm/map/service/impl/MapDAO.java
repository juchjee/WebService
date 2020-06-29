package site.mng.crm.map.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("MapDAO")
public class MapDAO extends BaseDAO {

	public List<?> selectMapList(Map<String, Object> params) throws Exception{
		return list("MapDAO.selectMapList", params);
    }

	public void mergeStore(Map<String, Object> map) throws Exception {
		update("MapDAO.mergeStore", map);
	}

	public List<?> zipcodeSearchLev1() {
		return list("MapDAO.zipcodeSearchLev1", null);
	}

	public List<?> zipcodeSearchLev2(UnCamelMap<String, Object> paramMap) {
		return list("MapDAO.zipcodeSearchLev2", paramMap);
	}

	@SuppressWarnings("unchecked")
	public Map<String, String> selectMapObj(UnCamelMap<String, Object> paramMap) {
		return (Map<String, String>) select("MapDAO.selectMapObj", paramMap);
	}

	public List<?> addressmpgList(UnCamelMap<String, Object> paramMap) {
		return list("MapDAO.addressmpgList", paramMap);
	}

	public List<?> storeCateList(UnCamelMap<String, Object> paramMap) {
		return list("MapDAO.storeCateList", paramMap);
	}
}
