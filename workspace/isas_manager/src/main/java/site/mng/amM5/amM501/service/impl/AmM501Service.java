package site.mng.amM5.amM501.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;

@Service("AmM501Service")
public class AmM501Service extends BaseService {

	@Resource(name = "AmM501DAO")
	private AmM501DAO amM501DAO;

	public List<?> amM501L(Map<String, Object> params) throws Exception {
		return amM501DAO.amM501L(params);
    }

	public List<?> amM501FL(Map<String, Object> params) throws Exception {
		return amM501DAO.amM501FL(params);
    }

	public List<?> amM501TL(Map<String, Object> params) throws Exception {
		return amM501DAO.amM501TL(params);
    }

	public Map<String, Object> amM501R(Map<String, Object> params) throws Exception {
		return amM501DAO.amM501R(params);
	}
}
