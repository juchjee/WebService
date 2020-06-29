package site.mng.amM1.amM105.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;

@Service("AmM105Service")
public class AmM105Service extends BaseService{

	/** AmM105DAO */
	@Resource(name = "AmM105DAO")
	private AmM105DAO amM105DAO;

	public List<?> amM105(Map<String, Object> params) throws Exception {
		return amM105DAO.amM105(params);
    }

}
