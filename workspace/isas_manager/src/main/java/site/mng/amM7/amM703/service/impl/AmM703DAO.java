package site.mng.amM7.amM703.service.impl;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("AmM703DAO")
public class AmM703DAO extends BaseDAO {

	/** FRONT 메뉴관리 : 메뉴 조회(1차.2차.3차) **/
	public List<?> amM703L(Map<String, Object> params) throws Exception {
        return list("AmM703DAO.amM703L", params);
    }

	/** FRONT 메뉴관리 : sort조회 **/
	public int amM703Count(Map<String, Object> params) throws Exception {
		return (int) select("AmM703DAO.amM703Count", params);
	}

	/** FRONT 메뉴관리 : 삭제 후 순서수정 리스트 조회 **/
	public List<?> amM703SList(Map<String, Object> params) throws Exception {
        return list("AmM703DAO.amM703SList", params);
    }

	/** FRONT 메뉴관리 : 순서이동 처리 **/
	public int sortMod(Map<String, Object> params) throws Exception {

		int udpCount = 0 ;
		    udpCount =  update("AmM703DAO.sortMod_1step", params);
		if(udpCount == 1){
			 udpCount =  update("AmM703DAO.sortMod_2step", params);
		}
		return udpCount;
	}

	/** FRONT 메뉴관리 : **/
	public void amM703SU(Map<String, Object> params) throws Exception {
		update("AmM703DAO.amM703SU", params);
	}

	public List<?> bbsProgList(UnCamelMap<String, Object> paramMap) {
        return list("AmM703DAO.bbsProgList", paramMap);
	}

	public List<?> frontAllList() {
        return list("AmM703DAO.frontAllList", null);
	}

}
