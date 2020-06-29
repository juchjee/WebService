package site.mng.amM7.amM706.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;

@Service("AmM706Service")
public class AmM706Service extends BaseService {

	@Resource(name = "AmM706DAO")
	private AmM706DAO amM706DAO;


	/**
	 * 설정 : 게시판설정 목록조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> amM706L(Map<String, Object> params) throws Exception {
		return amM706DAO.amM706L(params);
	}

	public List<?> amM706TL(Map<String, Object> params) throws Exception {
		return amM706DAO.amM706TL(params);
	}

	public List<?> amM706SL(Map<String, Object> params) throws Exception {
		return amM706DAO.amM706SL(params);
	}

	public int amM706Count(Map<String, Object> params) throws Exception {
		return amM706DAO.amM706Count(params);
	}

	public Map<String, Object> amM706BD(Map<String, Object> params) throws Exception {
		return amM706DAO.amM706BD(params);
	}

	public List<?> amM706SML(Map<String, Object> params) throws Exception {
		return amM706DAO.amM706SML(params);
	}

	public int amM706CC(Map<String, Object> params) throws Exception {
		return amM706DAO.amM706CC(params);
	}

	public List<?> amM706CL(Map<String, Object> params) throws Exception {
		return amM706DAO.amM706CL(params);
	}

	public List<?> admMenuList() throws Exception {
		return amM706DAO.admMenuList();
	}

}
