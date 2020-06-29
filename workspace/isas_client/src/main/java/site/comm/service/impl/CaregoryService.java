package site.comm.service.impl;

import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import egovframework.cmmn.interceptor.EgovUserDetailsHelper;
import egovframework.rte.fdl.cmmn.EgovAbstractServiceImpl;

/**
 * 공통 Service
 * @author vary
 *
 */
@Service("CaregoryService")
public class CaregoryService extends EgovAbstractServiceImpl{

	/** CaregoryDAO */
	@Resource(name = "CaregoryDAO")
	private CaregoryDAO caregoryDAO;

	/**
	 * 해댱 권한에 대한 Menu Category list를 가지고 온다
	 * @param key
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public List<?> getCategoryList(String _key) throws Exception{
		String signTp = "UNSIGN";
		if(EgovUserDetailsHelper.isAuthenticated()){
			signTp = "SIGN";
		}

    	return (List<Map<String, Object>>) caregoryDAO.getCategoryList(_key,signTp);
    }


}
