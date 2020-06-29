package site.mng.bbt.service.impl;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Service("BbtService")
public class BbtService extends BaseService {

	@Resource(name = "BbtDAO")
	private BbtDAO bbtDAO;

	public List<?> bbt00001L(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00001L(params);
	}

	public int bbt00001C(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00001C(params);
	}

	public Map<String, Object> bbt00001V(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00001V(params);
	}

	public List<?> bbt00001F(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00001F(params);
	}

	public List<?> selectFunc(Map<String, Object> params) throws Exception {
		return bbtDAO.selectFunc(params);
	}

	public List<?> bbt00002L(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00002L(params);
	}

	public Map<String, Object> bbt00001RP(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00001RP(params);
	}

	public List<?> bbt00003L(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00003L(params);
	}

	public Map<String, Object> bbt00003RV(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00003RV(params);
	}

	public List<?> bbt00005L(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00005L(params);
	}

	public Map<String, Object> bbt00005TP(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00005TP(params);
	}

	public Map<String, Object> bbt00006V(Map<String, Object> params) throws Exception {
        return bbtDAO.bbt00006V(params);
    }

	public Map<String, Object> bbt00008TP(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00008TP(params);
	}

	public List<?> bbt00010L(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00010L(params);
	}

	public List<?> bbt00007L(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00007L(params);
	}

	public Map<String, Object> bbt00007V(Map<String, Object> params) throws Exception {
		return bbtDAO.bbt00007V(params);
	}

	public void bbsSmsSend(String boardTitle) {
		
		List<CamelMap<String, Object>> custList = bbtDAO.custSmsSearch();
		for (CamelMap<String, Object> custmap : custList) {

			CamelMap<String, Object> custM = new CamelMap<>();
			custM.put("hp", custmap.getString("hp"));
			custM.put("tit", boardTitle);
			bbtDAO.bbsSmsSend(custM);
		}
	}


}
