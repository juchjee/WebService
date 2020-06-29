package site.mng.sa.service.impl;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;
import egovframework.cmmn.vo.LoginVO;

@Repository("SaDAO")
public class SaDAO extends BaseDAO {

	/**
     * 2011.08.26
	 * EsntlId를 이용한 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO actionLoginByEsntlId(LoginVO vo) throws Exception {
    	return (LoginVO)select("SaDAO.ssoLoginByEsntlId", vo);
    }

	/**
	 * 일반 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO actionLogin(LoginVO vo) throws Exception {
    	return (LoginVO)select("SaDAO.actionLogin", vo);
    }
    
    public LoginVO actionCrmLogin(LoginVO vo) throws Exception {
    	return (LoginVO)select("SaDAO.actionCrmLogin", vo);
    }

    /**
	 * 인증서 로그인을 처리한다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO actionCrtfctLogin(LoginVO vo) throws Exception {

    	return (LoginVO)select("SaDAO.actionCrtfctLogin", vo);
    }

    /**
	 * 아이디를 찾는다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO searchId(LoginVO vo) throws Exception {

    	return (LoginVO)select("SaDAO.searchId", vo);
    }

    /**
	 * 비밀번호를 찾는다.
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO searchADM_PW(LoginVO vo) throws Exception {

    	return (LoginVO)select("SaDAO.searchADM_PW", vo);
    }

    /**
	 * 변경된 비밀번호를 저장한다.
	 * @param vo LoginVO
	 * @exception Exception
	 */
    public void updateADM_PW(LoginVO vo) throws Exception {
    	update("SaDAO.updateADM_PW", vo);
    }
}
