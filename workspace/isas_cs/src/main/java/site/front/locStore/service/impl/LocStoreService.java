package site.front.locStore.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import site.comm.service.impl.CommService;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;
import egovframework.rte.psl.dataaccess.util.UnCamelMap;

@Service("LocStoreService")
public class LocStoreService extends EgovAbstractServiceImpl{

	/** LocStoreDAO */
	@Resource(name = "LocStoreDAO")
	private LocStoreDAO locStoreDAO;

	/** 공통 서비스 */
	@Resource(name = "CommService")
    protected CommService commService;

	public List<?> selectMapList(Map<String,Object> params) throws Exception {
        return locStoreDAO.selectMapList(params);
    }
	
	public List<?> zipcodeSearchLev1() throws Exception {
        return locStoreDAO.zipcodeSearchLev1();
	}
	
	public int totalMapListCount(Map<String, Object> params) throws Exception {
		return locStoreDAO.totalMapListCount(params);
	}
	
	public List<?> zipcodeSearchLev2(UnCamelMap<String, Object> paramMap) throws Exception {
        return locStoreDAO.zipcodeSearchLev2(paramMap);
	}
	
	public Map<String, Object> selectMapView(Map<String, Object> paramMap) throws Exception {
        return locStoreDAO.selectMapView(paramMap);
    }
	
}
