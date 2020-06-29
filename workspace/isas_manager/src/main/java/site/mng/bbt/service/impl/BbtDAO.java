package site.mng.bbt.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;
import egovframework.rte.psl.dataaccess.util.CamelMap;

@Repository("BbtDAO")
public class BbtDAO extends BaseDAO {

	public List<?> bbt00001L(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt00001L", params);
	}

	public int bbt00001C(Map<String, Object> params) throws Exception {
		return (int) select("BbtDAO.bbt00001C", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00001V(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00001V", params);
    }

	public List<?> bbt00001F(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt00001F", params);
	}

	public List<?> selectFunc(Map<String, Object> params) throws Exception {
		return list("BbtDAO.selectFunc", params);
	}

	public List<?> bbt00002L(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt00002L", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00001RP(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00001RP", params);
    }

	public List<?> bbt00003L(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt00003L", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00003RV(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00003RV", params);
    }

	public List<?> bbt00005L(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt00005L", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00005TP(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00005TP", params);
    }
	
	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00006V(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00006V", params);
    }

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00008TP(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00008TP", params);
    }

	public List<?> bbt00010L(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt00010L", params);
	}

	public List<?> bbt00007L(Map<String, Object> params) throws Exception {
		return list("BbtDAO.bbt00007L", params);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> bbt00007V(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("BbtDAO.bbt00007L", params);
    }

	@SuppressWarnings("unchecked")
	public List<CamelMap<String, Object>> custSmsSearch() {
		return (List<CamelMap<String, Object>>) list("BbtDAO.custSmsSearch", null);
	}

	public void bbsSmsSend(Map<String, Object> bbsSmsSendMap) {
		select("BbtDAO.bbsSmsSend", bbsSmsSendMap);
	}




}
