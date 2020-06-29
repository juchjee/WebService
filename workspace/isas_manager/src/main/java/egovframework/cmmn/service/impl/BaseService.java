package egovframework.cmmn.service.impl;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.cmmn.vo.LoginVO;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * @author vary
 *
 */
public class BaseService extends EgovAbstractServiceImpl {
	protected static final Logger logger = LoggerFactory.getLogger("Controller");

	/**
	 * 로그인 여부
	 * @return
	 */
	protected boolean isLogIn(){
		return EgovUserDetailsHelper.isAuthenticated();
	}

	/**
	 * 관리자 정보
	 * @return
	 */
	protected LoginVO getLoginVO(){
		return EgovUserDetailsHelper.getAuthenticatedUser();
	}

}
