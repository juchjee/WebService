package site.mng.amM7.amM705.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;

@Service("AmM705Service")
public class AmM705Service extends BaseService {

	@Resource(name = "AmM705DAO")
	private AmM705DAO amM705DAO;

	/**
	 * 설정 : 권한설정 권한조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> amM705L(Map<String, Object> params) throws Exception {
		return amM705DAO.amM705L(params);
	}

	/**
	 * 설정 : 권한설정 SORT 조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public int amM705Count(Map<String, Object> params) throws Exception {
		return amM705DAO.amM705Count(params);
	}

	/**
	 * 설정 : 권한에 대한 메뉴조회
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> amM705ML(Map<String, Object> params) throws Exception {
		return amM705DAO.amM705ML(params);
	}

	/**
	 * 설정 : 권한에 대한 메뉴등록을 위한 이전등록된 정보조회(삭제)
	 * @param params
	 * @return
	 * @throws Exception
	 */
	public List<?> amM705DL(Map<String, Object> params) throws Exception {
		return amM705DAO.amM705DL(params);
	}

}
