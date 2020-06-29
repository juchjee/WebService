package site.mng.amM7.amM701.service.impl;

import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;

@Service("AmM701Service")
public class AmM701Service extends BaseService {

	@Resource(name = "AmM701DAO")
	private AmM701DAO amM701DAO;

	/**  **/
	public Map<String, Object> amM701Com(Map<String, Object> params) throws Exception {
		return amM701DAO.amM701Com(params);
	}

}
