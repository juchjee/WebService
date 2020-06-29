package site.mng.amM4.amM403.service.impl;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.IConstants;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;
import site.comm.service.impl.CommService;

@Service("AmM403Service")
public class AmM403Service extends EgovAbstractServiceImpl implements IConstants{

	/** AmM403DAO */
	@Resource(name = "AmM403DAO")
	private AmM403DAO amM403DAO;
	/** 공통 서비스 */
	@Resource(name = "CommService")
    protected CommService commService;

	public List<?> amM403(UnCamelMap<String, Object> paramMap) throws Exception {
        return amM403DAO.amM403(paramMap);
	}

	public void amM403Save(UnCamelMap<String, Object> paramMap) throws Exception {
		String[]  whereColumName = new String[]{"MSG_ROLE_CD"};
		commService.tableSaveData("E_SMS", paramMap, null, whereColumName , null, null);
		commService.setGdataModHis("E_SMS", paramMap.get("MSG_ROLE_CD"), paramMap, UPDATE);
	}

	public Object amM403U(UnCamelMap<String, Object> paramMap) {
        return amM403DAO.amM403U(paramMap);
	}
}
