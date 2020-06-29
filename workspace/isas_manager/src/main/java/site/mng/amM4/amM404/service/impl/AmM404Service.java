package site.mng.amM4.amM404.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.IConstants;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CommService;

@Service("AmM404Service")
public class AmM404Service extends EgovAbstractServiceImpl implements IConstants {

	/** AmM404DAO */
	@Resource(name = "AmM404DAO")
	private AmM404DAO amM404DAO;

	/** 공통 서비스 */
	@Resource(name = "CommService")
	protected CommService commService;

	public List<?> amM404(UnCamelMap<String, Object> paramMap) throws Exception {
		return amM404DAO.amM404(paramMap);
	}

	public void amM404Save(UnCamelMap<String, Object> paramMap) throws Exception {
		String[] whereColumName = new String[] { "MSG_ROLE_CD" };
		commService.tableSaveData("E_MAIL", paramMap, null, whereColumName, null, null);
		commService.setGdataModHis("E_MAIL", paramMap.get("MSG_ROLE_CD"), paramMap, UPDATE);

		Map<String, Object> matchingColumName = new HashMap<String, Object>();
		matchingColumName.put("MAIL_FOOTER_DT", "$idate");

		commService.tableInatall("E_MAIL_FOOTER", paramMap, matchingColumName);
	}

	public Object amM404U(UnCamelMap<String, Object> paramMap) {
		return amM404DAO.amM404U(paramMap);
	}
}
