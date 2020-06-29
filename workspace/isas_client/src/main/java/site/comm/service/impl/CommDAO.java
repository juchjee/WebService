package site.comm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import egovframework.cmmn.IConstants;
import egovframework.cmmn.vo.TableColumnVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.EgovMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("CommDAO")
public class CommDAO extends EgovAbstractDAO implements IConstants{

	/**
	 * 오늘 날짜를 가지고 온다
	 * @return Object
	 * @throws Exception
	 */
	public Object getToday() throws Exception {
		return select("CommDAO.getToday");
	}

	public Object getMaxNumber(Map<String, Object> params ) throws Exception {
		return select("CommDAO.getMaxNumber", params);
	}

	@SuppressWarnings("unchecked")
	public CamelMap<String, Object> getGSiteCode(Map<String, Object> params ) throws Exception {
		return (CamelMap<String, Object>) select("CommDAO.getGSiteCode", params);
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
	 * @return List<EgovMap>
	 */
	@SuppressWarnings("unchecked")
	public List<EgovMap> getProcedureToList(Map<String, Object> params) throws Exception {
		return (List<EgovMap>) list("CommDAO.getProcedureToList", params);
	}

	/**
	 * 동적 Procedure 실행
	 * @param params
	 * @return Object
	 */
	public Object getProcedureToObject(Map<String, Object> params) throws Exception {
		return select("CommDAO.getProcedureToObject", params);
	}

	public Object getProcedureToObject(Object pName, Object pValue) throws Exception {
		return select("CommDAO."+pName, pValue);
	}

	/**
	 * 테이블의 컬럼 구조를 가지고 온다.
	 * @param tableNm
	 * @return
	 */
	@SuppressWarnings("unchecked")
	@Cacheable(value="TableColumnCache",key="#tableNm")
	public List<TableColumnVO> getTableColumnList(String tableNm) throws Exception {
		return (List<TableColumnVO>) list("CommDAO.getTableColumnList", tableNm);
	}

	public int getRowCount(String commTableNm, Map<String, Object> params ) {
		Map<String, Object> newParams = new HashMap<String, Object>();
		newParams.putAll(params);
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

	public List<?> getCouponSearch(Map<String, Object> params) {
		return list("CommDAO.getCouponSearch", params);
	}

	@SuppressWarnings("unchecked")
	public CamelMap<String, Object> getGInfoDesign(String param) throws Exception {
		return (CamelMap<String, Object>) select("CommDAO.getGInfoDesign", param);
	}

	@SuppressWarnings("unchecked")
	public List<CamelMap<String, Object>> getMbrCouponSearch(Map<String, Object> params) {
		return (List<CamelMap<String, Object>>) list("CommDAO.getMbrCouponSearch", params);
	}

	@SuppressWarnings("unchecked")
	public List<CamelMap<String, Object>> getCouponProdSearch(String couponCd) {
		return (List<CamelMap<String, Object>>) list("CommDAO.getCouponProdSearch", couponCd);
	}

	public Object stackPoints(Map<String, Object> paramMap) {
		return insert("CommDAO.stackPoints", paramMap);
	}

	public Object insertIniStdMap(Map<String, Object> paramMap) {
		return insert("CommDAO.insertIniStdMap", paramMap);
	}

	@SuppressWarnings("unchecked")
	public Map<String, String> selectIniStdMap(String orderNo) throws Exception {
		return (Map<String, String>) select("CommDAO.selectIniStdMap", orderNo);
	}

	/*public Object deleteIniStdMap(String orderNo) throws Exception {
		return delete("CommDAO.deleteIniStdMap", orderNo);
	}*/

	@SuppressWarnings("unchecked")
	public Map<String,Object> mbrMailCont(Map<String, Object> params) throws Exception {
        return (Map<String, Object>) select("CommDAO.mbrMailCont", params);
    }

	@SuppressWarnings("unchecked")
	public CamelMap<String,Object> mbrInfoMap(UnCamelMap<String, Object> paramMap) {
		return (CamelMap<String, Object>) select("CommDAO.mbrInfoMap", paramMap);
	}

	public int getLevCopnCount(String mbrId) {
		return (int) select("CommDAO.getLevCopnCount", mbrId);
	}
}
