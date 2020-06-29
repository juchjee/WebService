package site.comm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.vo.TableColumnVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@SuppressWarnings("unchecked")
@Repository("CommDAO")
public class CommDAO extends EgovAbstractDAO {


	/**
	 * 오늘 날짜를 가지고 온다
	 * @return Object
	 * @throws Exception
	 */
	public Object getToday() throws Exception {
		return select("CommDAO.getToday");
	}

	public List<?> getCategoryList(String param) throws Exception {
		Map<String, String> paramMap = new HashMap<>();
		paramMap.put("admAuthCd", param);
		paramMap.put("boardMstCdParam", "?boardMstCd=");
		return list("CommDAO.getCategoryList", paramMap);
	}

	public CamelMap<String, Object> getGSiteCode(Map<String, Object> params ) throws Exception {
		return (CamelMap<String, Object>) select("CommDAO.getGSiteCode", params);
	}

	public Object getMaxNumber(Map<String, Object> params ) throws Exception {
		return select("CommDAO.getMaxNumber", params);
	}

	/**
	 * 테이블의 컬럼 구조를 가지고 온다.
	 * @param tableNm
	 * @return
	 */
	public List<?> getTableList(String commTableNm, Map<String, Object> params) throws Exception {
		Map<String, Object> newParams = new HashMap<String, Object>();
		newParams.putAll(params);
		newParams.put("commTableNm", commTableNm);
		return list("CommDAO.getTableList", newParams);
	}

	/**
	 * 동적 Procedure 실행
	 * @param params
	 * @return List<CamelMap>
	 */
	public List<?> getProcedureToList(Map<String, Object> params) throws Exception {
		return list("CommDAO.getProcedureToList", params);
	}

	/**
	 * 동적 Procedure 실행
	 * @param params
	 * @return Object
	 */
	public Object getProcedureToObject(Map<String, Object> params) throws Exception {
		return select("CommDAO.getProcedureToObject", params);
	}

	/**
	 * 테이블의 컬럼 구조를 가지고 온다.
	 * @param tableNm
	 * @return
	 */
	public List<TableColumnVO> getTableColumnList(String tableNm) throws Exception {
		return (List<TableColumnVO>) list("CommDAO.getTableColumnList", tableNm);
	}

	public int getRowCount(String commTableNm, Map<String, Object> params ) {
		Map<String, Object> newParams = new HashMap<String, Object>();
		if(params != null) newParams.putAll(params);
		newParams.put("commTableNm", commTableNm);
		return (int) select("CommDAO.getRowCount", newParams);
	}

	public int tableUpdate(Map<String, Object> params ) {
		return (int) update("CommDAO.tableUpdate", params);
	}

	public Object tableInsert(Map<String, Object> params ) {
		return insert("CommDAO.tableInsert", params);
	}

	public Object tableDelete(Map<String, Object> params ) {
		return delete("CommDAO.tableDelete", params);
	}

	public Object getGAttch(Map<String, Object> params) throws Exception {
		return select("CommDAO.getGAttch", params);
	}

	public List<?> msgVariableList(UnCamelMap<String, Object> paramMap) {
        return list("CommDAO.msgVariableList", paramMap);
	}


	public CamelMap<String, Object> mbrSmsCont(Map<String, Object> params){
		return (CamelMap<String, Object>) select("CommDAO.mbrSmsCont", params);
	}

	public Object mbrSmsSend(Map<?, ?> params) {
		return insert("CommDAO.mbrSmsSend", params);
	}

	public CamelMap<String,Object> mbrInfoMap(UnCamelMap<String, Object> paramMap) {
		return (CamelMap<String, Object>) select("CommDAO.mbrInfoMap", paramMap);
	}


	public int stackUseOnOff(Map<String, Object> paramMap) {
		return (int) select("CommDAO.stackUseOnOff", paramMap);
	}

	public Map<String,Object> mbrMailCont(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("CommDAO.mbrMailCont", params);
    }

	public Object insertIniStdMap(Map<String, Object> paramMap) {
		return insert("CommDAO.insertIniStdMap", paramMap);
	}

	public Map<String, String> selectIniStdMap(String orderNo) throws Exception {
		return (Map<String, String>) select("CommDAO.selectIniStdMap", orderNo);
	}

}
