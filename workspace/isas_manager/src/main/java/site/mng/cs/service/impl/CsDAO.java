package site.mng.cs.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import egovframework.cmmn.vo.LoginVO;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.CamelMap;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Repository("CsDAO")
public class CsDAO extends EgovAbstractDAO {

	public List<?> calendarList(UnCamelMap<String, Object> paramMap) {
		return list("CsDAO.calendarList", paramMap);
	}

	public List<?> ascodeList(UnCamelMap<String, Object> paramMap) {
		return list("CsDAO.ascodeList", paramMap);
	}


	public String mbrDiSearchForAsa010(Map<String, Object> csNoMap) {
		return (String) select("CsDAO.mbrDiSearchForAsa010", csNoMap);
	}

	public String asa050SeqSearch(String csNo) {
		return (String) select("CsDAO.asa050SeqSearch", csNo);
	}

	public List<?> csTimeTableList() {
		return list("CsDAO.csTimeTableList", null);
	}

	public List<?> csTimeMpgList(UnCamelMap<String, Object> paramMap) {
		return list("CsDAO.csTimeMpgList", paramMap);
	}

	@SuppressWarnings("unchecked")
	public Map<String,Object> csInfo(UnCamelMap<String, Object> paramMap) {
		return (Map<String, Object>) select("CsDAO.csInfo", paramMap);
	}

	public List<?> csInfoList(UnCamelMap<String, Object> paramMap) {
		return list("CsDAO.csInfoList", paramMap);
	}

	public int csInfoListCount(UnCamelMap<String, Object> paramMap) {
		return (int) select("CsDAO.csInfoListCount", paramMap);
	}

	public List<?> modelList(UnCamelMap<String, Object> paramMap) {
		return list("CsDAO.modelList", paramMap);
	}

	public List<?> custCdList(UnCamelMap<String, Object> paramMap) {
		return list("CsDAO.custCdList", paramMap);
	}

	public String asNoSearchForAsa200() {
		return (String) select("CsDAO.asNoSearchForAsa200", null);
	}

	public List<?> csFileList(UnCamelMap<String, Object> paramMap) {
		return list("CsDAO.csFileList", paramMap);
	}

	public List<?> itmGubunList(UnCamelMap<String, Object> paramMap) {
		return list("CsDAO.itmGubunList",paramMap);
	}

	@SuppressWarnings("unchecked")
	public CamelMap<String, Object> modelInfo(UnCamelMap<String, Object> param) {
		return (CamelMap<String, Object>)  select("CsDAO.modelInfo", param);
	}
	
	@SuppressWarnings("unchecked")
	public CamelMap<String, Object> custInfo(String custCd) {
		return (CamelMap<String, Object>)  select("CsDAO.custInfo", custCd);
	}

	public String autoReceiptCustCdSearch(UnCamelMap<String, Object> paramMap) {
		return (String) select("CsDAO.autoReceiptCustCdSearch", paramMap);
	}

	public void asa200_new_work(String asNo, String mbrNm, String mbrMobile, String drvNm, String hp) {
		Map<String, Object> param = new HashMap<>();
		param.put("asNo", asNo);
		param.put("mbrNm", mbrNm);
		param.put("mbrMobile", mbrMobile);
		param.put("drvNm", drvNm);
		param.put("hp", hp);

		select("CsDAO.asa200_new_work", param);
	}

	public void asa200_new_work_cs(String asNo, String mbrNm, String mbrMobile, String tel, String addr,String itmCd, String itmNm, String reNm, String drvHp) {
		Map<String, Object> param = new HashMap<>();
		param.put("asNo", asNo);
		param.put("mbrNm", mbrNm);
		param.put("mbrMobile", mbrMobile);
		param.put("tel", tel);
		param.put("addr", addr);
		param.put("itmCd", itmCd);
		param.put("itmNm", itmNm);
		param.put("reNm", reNm);
		param.put("drvHp", drvHp);

		select("CsDAO.asa200_new_work_cs", param);
	}

}
