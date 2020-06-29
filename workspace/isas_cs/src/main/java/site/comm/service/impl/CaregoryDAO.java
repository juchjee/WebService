package site.comm.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import egovframework.cmmn.IConstants;
import egovframework.rte.psl.dataaccess.EgovAbstractDAO;
import egovframework.rte.psl.dataaccess.util.CamelMap;

@Repository("CaregoryDAO")
public class CaregoryDAO extends EgovAbstractDAO implements IConstants{

	@Cacheable(value="ListCache",key="#root.methodName+#_key")
	public List<?> getCategoryList(String _key, String signTp) throws Exception {
		Map<String, String> hashMap = new HashMap<>();
		hashMap.put("key", _key);
		hashMap.put("signTp", signTp);


		hashMap.put("rootFrontUri", ROOT_URI + ISDS_URL);
		hashMap.put("param", "?"+CATEGORY_PARAM_NM+"=");
		return list("CaregoryDAO.getCategoryList", hashMap);
	}

}
