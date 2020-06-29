package site.front.repair.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("RepairDAO")
public class RepairDAO extends EgovAbstractDAO {

	public List<?> getPartItemList(UnCamelMap<String, Object> paramMap) throws Exception {
		return list("RepairDAO.getPartItemList",paramMap);
	}

	public int totalListCount(Map<String, Object> params) throws Exception {
		return (int) select("RepairDAO.totalListCount", params);
	}

	public List<?> repairStateList(UnCamelMap<String, Object> paramMap)  throws Exception {
		return list("RepairDAO.repairStateList", paramMap);
	}

	public Object repairStateView(UnCamelMap<String, Object> paramMap) {
		return (Object) select("RepairDAO.repairStateView", paramMap);
	}

	public Object getCodeInfo(String mainCd,String subCd) {

		Map<String, Object> params = new HashMap<String, Object>();

		params.put("MAIN_CD", mainCd);
		params.put("SUB_CD", subCd);

		return list("RepairDAO.getCodeInfo", params);
	}


	public Object ascodeList(UnCamelMap<String, Object> paramMap) {

		return list("RepairDAO.ascodeList", paramMap);
	}

	public int repairStateFinishListCount(Map<String, Object> params) throws Exception {
		return (int) select("RepairDAO.repairStateFinishListCount", params);
	}

	public List<?> repairStateFinishList(UnCamelMap<String, Object> paramMap)  throws Exception {
		return list("RepairDAO.repairStateFinishList", paramMap);
	}

	public int handlingListCount(Map<String, Object> params) throws Exception {
		return (int) select("RepairDAO.handlingListCount", params);
	}

	public List<?> handlingList(UnCamelMap<String, Object> paramMap)  throws Exception {
		return list("RepairDAO.handlingList", paramMap);
	}

	public List<?> repairPartList(UnCamelMap<String, Object> paramMap)  throws Exception {
		return list("RepairDAO.repairPartList", paramMap);
	}

	public List<?> repairFileList(UnCamelMap<String, Object> paramMap) throws Exception {
		return list("RepairDAO.repairFileList", paramMap);
	}

	public Object asSign(UnCamelMap<String, Object> paramMap) throws Exception {
		return (Object) select("RepairDAO.asSign", paramMap);
	}

	public List<?> repairStateHistoyList(UnCamelMap<String, Object> paramMap) {
		return list("RepairDAO.repairStateHistoyList", paramMap);
	}

	public int repairStateHistoyListCount(Map<String, Object> params) throws Exception {
		return (int) select("RepairDAO.handlingListCount", params);
	}

	public String repairThisHistoyNm(Map<String, Object> params)  throws Exception {
		return (String) select("RepairDAO.repairThisHistoyNm", params);
	}

	public List<?> installAcceptList(UnCamelMap<String, Object> paramMap) throws Exception {
		return list("RepairDAO.installAcceptList", paramMap);
	}

	public Object installAcceptView(UnCamelMap<String, Object> paramMap) throws Exception {
		return (Object) select("RepairDAO.installAcceptView", paramMap);
	}

	public int installAcceptListCount(Map<String, Object> params) {
		return (int) select("RepairDAO.installAcceptListCount", params);
	}

	public String getAsz120Pay(UnCamelMap<String, Object> paramMap) {
		return (String) select("RepairDAO.getAsz120Pay", paramMap);
	}

	public String getActDt(UnCamelMap<String, Object> paramMap) {
		return (String) select("RepairDAO.getActDt", paramMap);
	}

	public List<?> modelList(UnCamelMap<String, Object> paramMap) {
		return list("RepairDAO.modelList", paramMap);
	}

	public List<?> itmList(UnCamelMap<String, Object> paramMap) {
		return list("RepairDAO.itmList", paramMap);
	}

	public void smsSend(UnCamelMap<String, Object> paramMap) {
		System.out.println("#######"+ paramMap.getString("MBR_NM"));
		select("RepairDAO.smsSend", paramMap);
	}

}
