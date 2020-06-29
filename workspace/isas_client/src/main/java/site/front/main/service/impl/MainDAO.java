package site.front.main.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Repository;

import egovframework.cmmn.service.impl.BaseDAO;

@Repository("MainDAO")
public class MainDAO extends BaseDAO {

	@Cacheable(value="MainNoticeCache",key="#root.methodName+#popupSeq")
	public List<?> popupList(String popupSeq) {
		Map<String, String> param = null;
		if(!"".equals(popupSeq)){
			param = new HashMap<String, String>();
			param.put("POPUP_SEQ", popupSeq);
		}
		return list("MainDAO.popupList", param);
	}

	@Cacheable(value="MainNoticeCache",key="#root.methodName+#popupSeq")
	public Object popupView(String popupSeq) {
		Map<String, Object> paramMap = new HashMap<String, Object>();
		paramMap.put("POPUP_SEQ", popupSeq);
		return select("MainDAO.popupView", paramMap);
	}

	@Cacheable(value="MainNoticeCache",key="#root.methodName")
	public List<?> eBannerList() throws Exception {
		return list("AmM406DAO.eBannerList");
	}


	@Cacheable(value="MainNoticeCache",key="#root.methodName")
	public List<?> getMainNoticeList() throws Exception {
		return list("MainDAO.getMainNoticeList");
	}

	@Cacheable(value="MainNoticeCache",key="#root.methodName")
	public List<?> getMainFaqList() throws Exception {
		return list("MainDAO.getMainFaqList");
	}

	public Map<?, ?> getWorkCount(String custCd) {
		return (Map<?, ?>) select("MainDAO.getWorkCount",custCd);
	}

}
