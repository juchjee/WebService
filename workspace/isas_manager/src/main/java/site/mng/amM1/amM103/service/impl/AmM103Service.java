package site.mng.amM1.amM103.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.service.impl.BaseService;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CommService;

@Service("AmM103Service")
public class AmM103Service extends BaseService{

	/** AmM103DAO */
	@Resource(name = "AmM103DAO")
	private AmM103DAO amM103DAO;

	/** 공통 서비스 */
	@Resource(name = "CommService")
	protected CommService commService;

	public List<?> amM103(Map<String, Object> params) throws Exception {
		return amM103DAO.amM103(params);
    }

	public int hCount(Map<String, Object> params) throws Exception {
		return amM103DAO.hCount(params);
	}

	public boolean unlockMbr(UnCamelMap<String, Object> paramMap) throws Exception {

		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("MBR_LOGIN_DT", "$idate");
		commService.tableInatall("M_MBR_LOGIN_HIS", paramMap, matchingColumName);

		Map<String, Object> mbrMap = new HashMap<String, Object>();
		mbrMap.put("MBR_LOGIN_STATUS_YHN","Y");
		commService.tableUpdate("M_MBR_LOGIN", mbrMap, null,null, " and MBR_ID = '" + paramMap.get("MBR_ID") + "'", null);
		return true;
	}
}
