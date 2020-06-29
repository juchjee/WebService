package site.mng.amM7.amM704.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;

@Service("AmM704Service")
public class AmM704Service extends BaseService {

	@Resource(name = "AmM704DAO")
	private AmM704DAO amM704DAO;

	/** **/
	public List<?> amM704(Map<String, Object> params) throws Exception {
		return amM704DAO.amM704(params);
    }

	/** **/
	public List<?> amM704A(Map<String, Object> params) throws Exception {
		return amM704DAO.amM704A(params);
    }

	/** **/
	public List<?> amM704P(Map<String, Object> params) throws Exception {
		return amM704DAO.amM704P(params);
    }

	/** **/
	public Map<String, Object> amM704PD(Map<String, Object> params) throws Exception {
		return amM704DAO.amM704PD(params);
	}

}
