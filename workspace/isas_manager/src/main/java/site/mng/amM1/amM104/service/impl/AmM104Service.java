package site.mng.amM1.amM104.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;

@Service("AmM104Service")
public class AmM104Service extends BaseService{

	/** AmM104DAO */
	@Resource(name = "AmM104DAO")
	private AmM104DAO amM104DAO;

	public List<?> amM104(Map<String, Object> params) throws Exception {
		return amM104DAO.amM104(params);
    }

	public int dCount(Map<String, Object> params) throws Exception {
		return amM104DAO.dCount(params);
	}

}
