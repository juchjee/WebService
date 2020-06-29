package site.front.mm.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;
import egovframework.cmmn.vo.LoginVO;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("MmDAO")
public class MmDAO extends BaseDAO {

	/**
	 * 회원 정보를 가지고 온다
	 * @param vo LoginVO
	 * @return LoginVO
	 * @exception Exception
	 */
    public LoginVO actionLogin(LoginVO vo) throws Exception {
    	return (LoginVO)select("MmDAO.actionLogin", vo);
    }

    /**
     * 아이디를 찾는다.
     * @param params
     * @return
     * @throws Exception
     */
    @SuppressWarnings("unchecked")
	public CamelMap<String, String> searchId(Map<?, ?> params) throws Exception {
    	return (CamelMap<String, String>) select("MmDAO.searchId", params);
    }

    /**
     * 회원번호를 채번한다
     * @param paramMap
     * @return
     */
	public String selectMaxMbrSeq(){
        return (String) select("MmDAO.selectMaxMbrSeq", null);
    }

    /**
     * 회원번호조회
     * @param paramMap
     * @return
     */
	public int selectMbrSeq(Map<String, Object> paramMap){
        return (int) select("MmDAO.selectMbrSeq", paramMap);
    }

    /**
	 * 변경된 비밀번호를 저장한다.
	 * @param vo LoginVO
	 * @exception Exception
	 */
    public void updateADM_PW(LoginVO vo) throws Exception {
    	update("MmDAO.updateADM_PW", vo);
    }


	public int getLoginCnt(Map<String, Object> paramMap){
        return (int) select("MmDAO.getLoginCnt", paramMap);
    }

	public int guestCheck(Map<String, Object> paramMap){
        return (int) select("MmDAO.guestCheck", paramMap);
    }

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> aSZ130List(Map<String, Object> params) {
		return (List<Map<String, Object>>) list("MmDAO.aSZ130List", params);
	}

	public String csNoSearch(Map<String, Object> paramMap) {
        return (String) select("MmDAO.csNoSearch", paramMap);
	}
}
